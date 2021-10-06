Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2A44234E0
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhJFAVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 20:21:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231373AbhJFAVB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 20:21:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195NiTgL017737
        for <bpf@vger.kernel.org>; Tue, 5 Oct 2021 17:19:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=etO/nGEOJdFSkhfp0hWTtZUpdNmpmAReaEXhw7i6DnY=;
 b=REBcDMYnxoSQUirJUfHEV4XlK/npLNSNGwsl5cR/zgg+wr3zJ9wcR2HhXCYzXTGRF/5U
 IDm4w1IZBjzIQnsankcHVX7qmWo7YALLCjW4bKnN/hrON7YF+hi6ZlTRFer436Y8FuxK
 YW//a9Gl7BwvSR+DrEqbCSfgseFDReB67u4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bh0n0g6gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 17:19:10 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 17:19:09 -0700
Received: by devbig139.ftw2.facebook.com (Postfix, from userid 572249)
        id 306C13C11683; Tue,  5 Oct 2021 17:19:00 -0700 (PDT)
From:   Andrey Ignatov <rdna@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf: avoid retpoline for bpf_for_each_map_elem
Date:   Tue, 5 Oct 2021 17:18:38 -0700
Message-ID: <20211006001838.75607-1-rdna@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: XKS8tvDaugdJMwYxXo-0EK8NFOPaGCU8
X-Proofpoint-ORIG-GUID: XKS8tvDaugdJMwYxXo-0EK8NFOPaGCU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_06,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=290 spamscore=0 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to 09772d92cd5a ("bpf: avoid retpoline for
lookup/update/delete calls on maps") and 84430d4232c3 ("bpf, verifier:
avoid retpoline for map push/pop/peek operation") avoid indirect call
while calling bpf_for_each_map_elem.

Before (a program fragment):

  ; if (rules_map) {
   142: (15) if r4 =3D=3D 0x0 goto pc+8
   143: (bf) r3 =3D r10
  ; bpf_for_each_map_elem(rules_map, process_each_rule, &ctx, 0);
   144: (07) r3 +=3D -24
   145: (bf) r1 =3D r4
   146: (18) r2 =3D subprog[+5]
   148: (b7) r4 =3D 0
   149: (85) call bpf_for_each_map_elem#143680  <-- indirect call via
                                                    helper

After (same program fragment):

   ; if (rules_map) {
    142: (15) if r4 =3D=3D 0x0 goto pc+8
    143: (bf) r3 =3D r10
   ; bpf_for_each_map_elem(rules_map, process_each_rule, &ctx, 0);
    144: (07) r3 +=3D -24
    145: (bf) r1 =3D r4
    146: (18) r2 =3D subprog[+5]
    148: (b7) r4 =3D 0
    149: (85) call bpf_for_each_array_elem#170336  <-- direct call

On a benchmark that calls bpf_for_each_map_elem() once and does many
other things (mostly checking fields in skb) with CONFIG_RETPOLINE=3Dy it
makes program faster.

Before:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  Benchmark.cpp                                              time/iter it=
ers/s
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  IngressMatchByRemoteEndpoint                                80.78ns 12.=
38M
  IngressMatchByRemoteIP                                      80.66ns 12.=
40M
  IngressMatchByRemotePort                                    80.87ns 12.=
37M

After:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  Benchmark.cpp                                              time/iter it=
ers/s
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  IngressMatchByRemoteEndpoint                                73.49ns 13.=
61M
  IngressMatchByRemoteIP                                      71.48ns 13.=
99M
  IngressMatchByRemotePort                                    70.39ns 14.=
21M

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1433752db740..68948f1ed443 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12946,7 +12946,8 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
 		     insn->imm =3D=3D BPF_FUNC_map_push_elem   ||
 		     insn->imm =3D=3D BPF_FUNC_map_pop_elem    ||
 		     insn->imm =3D=3D BPF_FUNC_map_peek_elem   ||
-		     insn->imm =3D=3D BPF_FUNC_redirect_map)) {
+		     insn->imm =3D=3D BPF_FUNC_redirect_map    ||
+		     insn->imm =3D=3D BPF_FUNC_for_each_map_elem)) {
 			aux =3D &env->insn_aux_data[i + delta];
 			if (bpf_map_ptr_poisoned(aux))
 				goto patch_call_imm;
@@ -12990,6 +12991,11 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
 				     (int (*)(struct bpf_map *map, void *value))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_redirect,
 				     (int (*)(struct bpf_map *map, u32 ifindex, u64 flags))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
+				     (int (*)(struct bpf_map *map,
+					      bpf_callback_t callback_fn,
+					      void *callback_ctx,
+					      u64 flags))NULL));
=20
 patch_map_ops_generic:
 			switch (insn->imm) {
@@ -13014,6 +13020,9 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
 			case BPF_FUNC_redirect_map:
 				insn->imm =3D BPF_CALL_IMM(ops->map_redirect);
 				continue;
+			case BPF_FUNC_for_each_map_elem:
+				insn->imm =3D BPF_CALL_IMM(ops->map_for_each_callback);
+				continue;
 			}
=20
 			goto patch_call_imm;
--=20
2.30.2

