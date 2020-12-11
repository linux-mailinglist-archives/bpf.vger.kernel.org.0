Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66E02D6ECF
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 04:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405281AbgLKDmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 22:42:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405238AbgLKDmH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 22:42:07 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB3P9EC019252
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 19:41:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1ncYG1vbOeg9nT3FZ+0J4n1I+6d2KjtwiQRUO8jg/JQ=;
 b=Lxo6U2XbmY4dPgsGea9RlnibRWSmTOOFy+aM/3b7u4m28eOmJl/eodPRTokFdDM4sm0B
 k9ras45cGAFaElHgNfLt9DBx8jXaMfeVJqFrmcQZ7LS2ts/lc/nQRV13xnTCjdmDRoVc
 gqBXWFboiy41cV2Lxo7OGmS7z6136ShFH14= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35avdhd61q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 19:41:26 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 19:41:24 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7E7CF3705C0A; Thu, 10 Dec 2020 19:41:21 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v3 1/2] bpf: permits pointers on stack for helper calls
Date:   Thu, 10 Dec 2020 19:41:21 -0800
Message-ID: <20201211034121.3452243-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201211034121.3452172-1-yhs@fb.com>
References: <20201211034121.3452172-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_01:2020-12-09,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=928 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=13 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110019
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
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93def76cf32b..eebb2d3e16bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3769,7 +3769,9 @@ static int check_stack_boundary(struct bpf_verifier=
_env *env, int regno,
 			goto mark;
=20
 		if (state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
-		    state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE) {
+		    (state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE ||
+		     (state->stack[spi].spilled_ptr.type !=3D NOT_INIT &&
+		      env->allow_ptr_leaks))) {
 			__mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
 			for (j =3D 0; j < BPF_REG_SIZE; j++)
 				state->stack[spi].slot_type[j] =3D STACK_MISC;
--=20
2.24.1

