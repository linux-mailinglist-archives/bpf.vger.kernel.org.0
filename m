Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6222D490F
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 19:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbgLIScI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 13:32:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728625AbgLIScH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 13:32:07 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B9ISBXL003207
        for <bpf@vger.kernel.org>; Wed, 9 Dec 2020 10:31:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=R+f9nbq5HyRZmtf3kjggx9mjFKxEHvIbpjbZuvTnkq4=;
 b=Ilq+OaEwJBd3Ku5J1RI1pfxf2uNbiJmijVx0ItYnjal/hZoUbKIL4Dcnc/qlLTerwfZ5
 yJY3z12/O6PmHjjE9a3lGbYLvsldTJGLisrDtgDbKFTPkyVpFzjyAjkbD6DtIa/yoGOo
 oDAuGqgNoAR9EVauZbFTvqM6XqNuCNOKV9s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35aj8vq313-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 10:31:26 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 10:31:25 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 887773705016; Wed,  9 Dec 2020 10:31:24 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: permits pointers on stack for helper calls
Date:   Wed, 9 Dec 2020 10:31:24 -0800
Message-ID: <20201209183124.3381965-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_14:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=13 mlxscore=0 bulkscore=0 mlxlogscore=821
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, when checking stack memory accessed by helper calls,
for spills, only PTR_TO_BTF_ID and SCALAR_VALUE are
allowed.

Song discovered an issue where the below bpf program
  int dump_task(struct bpf_iter__task *ctx)
  {
    struct seq_file *seq =3D ctx->meta->seq;
    static char[] info =3D "abc";
    BPF_SEQ_PRINTF(seq, "%s\n", info);
    return 0;
  }
may cause a verifier failure.

The verifier output looks like:
  ; struct seq_file *seq =3D ctx->meta->seq;
  1: (79) r1 =3D *(u64 *)(r1 +0)
  ; BPF_SEQ_PRINTF(seq, "%s\n", info);
  2: (18) r2 =3D 0xffff9054400f6000
  4: (7b) *(u64 *)(r10 -8) =3D r2
  5: (bf) r4 =3D r10
  ;
  6: (07) r4 +=3D -8
  ; BPF_SEQ_PRINTF(seq, "%s\n", info);
  7: (18) r2 =3D 0xffff9054400fe000
  9: (b4) w3 =3D 4
  10: (b4) w5 =3D 8
  11: (85) call bpf_seq_printf#126
   R1_w=3Dptr_seq_file(id=3D0,off=3D0,imm=3D0) R2_w=3Dmap_value(id=3D0,of=
f=3D0,ks=3D4,vs=3D4,imm=3D0)
  R3_w=3Dinv4 R4_w=3Dfp-8 R5_w=3Dinv8 R10=3Dfp0 fp-8_w=3Dmap_value
  last_idx 11 first_idx 0
  regs=3D8 stack=3D0 before 10: (b4) w5 =3D 8
  regs=3D8 stack=3D0 before 9: (b4) w3 =3D 4
  invalid indirect read from stack off -8+0 size 8

Basically, the verifier complains the map_value pointer at "fp-8" locatio=
n.
To fix the issue, if env->allow_ptr_leaks is true, let us also permit
pointers on the stack to be accessible by the helper.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93def76cf32b..9159c9822ede 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3769,7 +3769,8 @@ static int check_stack_boundary(struct bpf_verifier=
_env *env, int regno,
 			goto mark;
=20
 		if (state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
-		    state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE) {
+		    (state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE ||
+		     env->allow_ptr_leaks)) {
 			__mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
 			for (j =3D 0; j < BPF_REG_SIZE; j++)
 				state->stack[spi].slot_type[j] =3D STACK_MISC;
--=20
2.24.1

