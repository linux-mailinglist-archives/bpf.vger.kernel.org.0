Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68B51E67CA
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405173AbgE1Quv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 12:50:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405162AbgE1Quu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 12:50:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04SGgxkV017937
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 09:50:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JPlQGyeIUyzXh/DDX7sdcpt8zRNvH+GDTfld75cS2PM=;
 b=IoUoh4gZ9UfxBOY9WFl7st0OMfR73gpprGv/QiT+rNlHJBD7IkoCfR2bqtyeKZHCARZ5
 vFVEmaOfbl0S8KD+3sSMNJefNXQd20kRtJVB0IGrw0azJOArrRdK6KSsVBGlydOJMtHn
 olDYxoCHJgG0InH0HeniGjuX0pzhig0/+Qw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 319ybhsbea-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 09:50:47 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 09:50:46 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7A3D237053B2; Thu, 28 May 2020 09:50:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 1/2] bpf: fix a verifier issue when assigning 32bit reg states to 64bit ones
Date:   Thu, 28 May 2020 09:50:43 -0700
Message-ID: <20200528165043.1568695-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200528165043.1568623-1-yhs@fb.com>
References: <20200528165043.1568623-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 priorityscore=1501 cotscore=-2147483648 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=13 malwarescore=0
 lowpriorityscore=0 mlxlogscore=807 adultscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280116
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the latest trunk llvm (llvm 11), I hit a verifier issue for
test_prog subtest test_verif_scale1.

The following simplified example illustrate the issue:
    w9 =3D 0  /* R9_w=3Dinv0 */
    r8 =3D *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
    r7 =3D *(u32 *)(r1 + 76)  /* __sk_buff->data */
    ......
    w2 =3D w9 /* R2_w=3Dinv0 */
    r6 =3D r7 /* R6_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0) */
    r6 +=3D r2 /* R6_w=3Dinv(id=3D0) */
    r3 =3D r6 /* R3_w=3Dinv(id=3D0) */
    r3 +=3D 14 /* R3_w=3Dinv(id=3D0) */
    if r3 > r8 goto end
    r5 =3D *(u32 *)(r6 + 0) /* R6_w=3Dinv(id=3D0) */
       <=3D=3D error here: R6 invalid mem access 'inv'
    ...
  end:

In real test_verif_scale1 code, "w9 =3D 0" and "w2 =3D w9" are in
different basic blocks.

In the above, after "r6 +=3D r2", r6 becomes a scalar, which eventually
caused the memory access error. The correct register state should be
a pkt pointer.

The inprecise register state starts at "w2 =3D w9".
The 32bit register w9 is 0, in __reg_assign_32_into_64(),
the 64bit reg->smax_value is assigned to be U32_MAX.
The 64bit reg->smin_value is 0 and the 64bit register
itself remains constant based on reg->var_off.

In adjust_ptr_min_max_vals(), the verifier checks for a known constant,
smin_val must be equal to smax_val. Since they are not equal,
the verifier decides r6 is a unknown scalar, which caused later failure.

The llvm10 does not have this issue as it generates different code:
    w9 =3D 0  /* R9_w=3Dinv0 */
    r8 =3D *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
    r7 =3D *(u32 *)(r1 + 76)  /* __sk_buff->data */
    ......
    r6 =3D r7 /* R6_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0) */
    r6 +=3D r9 /* R6_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0) */
    r3 =3D r6 /* R3_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0) */
    r3 +=3D 14 /* R3_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0) */
    if r3 > r8 goto end
    ...

To fix the issue, if 32bit register is a const 0,
then just assign max vaue 0 to 64bit register smax_value as well.

Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d7ee40e2748..5123ce54695f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1174,6 +1174,9 @@ static void __reg_assign_32_into_64(struct bpf_reg_=
state *reg)
 		reg->smin_value =3D 0;
 	if (reg->s32_max_value > 0)
 		reg->smax_value =3D reg->s32_max_value;
+	else if (reg->s32_max_value =3D=3D 0 && reg->s32_min_value =3D=3D 0 &&
+		 tnum_is_const(reg->var_off))
+		reg->smax_value =3D 0; /* const 0 */
 	else
 		reg->smax_value =3D U32_MAX;
 }
--=20
2.24.1

