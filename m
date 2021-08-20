Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39603F31A4
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 18:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhHTQkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 12:40:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhHTQkh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Aug 2021 12:40:37 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KGXn6F005306
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 09:39:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=CxCKuH0kyJR+WYs4tSStv3Od2wuTPrYAmVKI4q+t0ts=;
 b=DhKXhore4tVDS+ZsJ9+6bd06sIp0w3r976IbQ75RXjgFcLXiLWqaA2WXz7eK98v0Qndq
 g0lBVDYJPVD6jQvPcOiV8eqXL9hdxR2yjBFz4gWtnvT2saoyN/1Wjwphl6MdBlA8Jf15
 XJSCa6T0++cUk8zxgzlFa/UT9J6lgtPNO2M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ahxasx3sp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 09:39:59 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 09:39:56 -0700
Received: by devbig139.ftw2.facebook.com (Postfix, from userid 572249)
        id 6259116868AE; Fri, 20 Aug 2021 09:39:52 -0700 (PDT)
From:   Andrey Ignatov <rdna@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andriin@fb.com>,
        <dan.carpenter@oracle.com>, <kernel-team@fb.com>
Subject: [PATCH bpf v2] bpf: Fix possible out of bound write in narrow load handling
Date:   Fri, 20 Aug 2021 09:39:35 -0700
Message-ID: <20210820163935.1902398-1-rdna@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9obDDWsUQGkr35q3sfF0cmhZENTR14LD
X-Proofpoint-ORIG-GUID: 9obDDWsUQGkr35q3sfF0cmhZENTR14LD
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_06:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108200094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a verifier bug found by smatch static checker in [0].

This problem has never been seen in prod to my best knowledge. Fixing it
still seems to be a good idea since it's hard to say for sure whether
it's possible or not to have a scenario where a combination of
convert_ctx_access() and a narrow load would lead to an out of bound
write.

When narrow load is handled, one or two new instructions are added to
insn_buf array, but before it was only checked that

	cnt >=3D ARRAY_SIZE(insn_buf)

And it's safe to add a new instruction to insn_buf[cnt++] only once. The
second try will lead to out of bound write. And this is what can happen
if `shift` is set.

Fix it by making sure that if the BPF_RSH instruction has to be added in
addition to BPF_AND then there is enough space for two more instructions
in insn_buf.

The full report [0] is below:

kernel/bpf/verifier.c:12304 convert_ctx_accesses() warn: offset 'cnt' incre=
mented past end of array
kernel/bpf/verifier.c:12311 convert_ctx_accesses() warn: offset 'cnt' incre=
mented past end of array

kernel/bpf/verifier.c
    12282
    12283 			insn->off =3D off & ~(size_default - 1);
    12284 			insn->code =3D BPF_LDX | BPF_MEM | size_code;
    12285 		}
    12286
    12287 		target_size =3D 0;
    12288 		cnt =3D convert_ctx_access(type, insn, insn_buf, env->prog,
    12289 					 &target_size);
    12290 		if (cnt =3D=3D 0 || cnt >=3D ARRAY_SIZE(insn_buf) ||
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Bounds check.

    12291 		    (ctx_field_size && !target_size)) {
    12292 			verbose(env, "bpf verifier is misconfigured\n");
    12293 			return -EINVAL;
    12294 		}
    12295
    12296 		if (is_narrower_load && size < target_size) {
    12297 			u8 shift =3D bpf_ctx_narrow_access_offset(
    12298 				off, size, size_default) * 8;
    12299 			if (ctx_field_size <=3D 4) {
    12300 				if (shift)
    12301 					insn_buf[cnt++] =3D BPF_ALU32_IMM(BPF_RSH,
                                                         ^^^^^
increment beyond end of array

    12302 									insn->dst_reg,
    12303 									shift);
--> 12304 				insn_buf[cnt++] =3D BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
                                                 ^^^^^
out of bounds write

    12305 								(1 << size * 8) - 1);
    12306 			} else {
    12307 				if (shift)
    12308 					insn_buf[cnt++] =3D BPF_ALU64_IMM(BPF_RSH,
    12309 									insn->dst_reg,
    12310 									shift);
    12311 				insn_buf[cnt++] =3D BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
                                        ^^^^^^^^^^^^^^^
Same.

    12312 								(1ULL << size * 8) - 1);
    12313 			}
    12314 		}
    12315
    12316 		new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
    12317 		if (!new_prog)
    12318 			return -ENOMEM;
    12319
    12320 		delta +=3D cnt - 1;
    12321
    12322 		/* keep walking new program and skip insns we just inserted */
    12323 		env->prog =3D new_prog;
    12324 		insn      =3D new_prog->insnsi + i + delta;
    12325 	}
    12326
    12327 	return 0;
    12328 }

[0] https://lore.kernel.org/bpf/20210817050843.GA21456@kili/

v1->v2:
- clarify that problem was only seen by static checker but not in prod;

Fixes: 46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 381d3d6f24bc..b991fb0a5da4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12004,6 +12004,10 @@ static int convert_ctx_accesses(struct bpf_verifie=
r_env *env)
 		if (is_narrower_load && size < target_size) {
 			u8 shift =3D bpf_ctx_narrow_access_offset(
 				off, size, size_default) * 8;
+			if (shift && cnt + 1 >=3D ARRAY_SIZE(insn_buf)) {
+				verbose(env, "bpf verifier narrow ctx load misconfigured\n");
+				return -EINVAL;
+			}
 			if (ctx_field_size <=3D 4) {
 				if (shift)
 					insn_buf[cnt++] =3D BPF_ALU32_IMM(BPF_RSH,
--=20
2.30.2

