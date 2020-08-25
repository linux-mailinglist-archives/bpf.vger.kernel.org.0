Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91A251248
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgHYGqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 02:46:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60386 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729076AbgHYGqP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 02:46:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6UVND032444
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 23:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=U44SsOqw7gigBVHL8i2vvoRtxLZ2HUhE2GbqxPQ3SA4=;
 b=eH639Gyd1scfwXQQzKDBukm/tVmuQTCBghN2P6sm2HaU3H8QmnbY+roLupzQu9YFwMoK
 VN4GEGqh1rzmrTW8Lel+VXKtU71Zq7wu5aAO4hBfKKv2/9bcPnNCOdsviaVPIu5At1EO
 IknyMmeag6FtqZbazbJyLtS0zlLPbtfzBFU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3330vjm23d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 23:46:13 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:46:12 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5C5343705749; Mon, 24 Aug 2020 23:46:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
Date:   Mon, 24 Aug 2020 23:46:08 -0700
Message-ID: <20200825064608.2017937-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200825064608.2017878-1-yhs@fb.com>
References: <20200825064608.2017878-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=963
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=13
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
Compared to llvm 10, llvm 11 and 12 generates xor instruction which
is not handled properly in verifier. The following illustrates the
problem:

  16: (b4) w5 =3D 0
  17: ... R5_w=3Dinv0 ...
  ...
  132: (a4) w5 ^=3D 1
  133: ... R5_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xff=
ffffff)) ...
  ...
  37: (bc) w8 =3D w5
  38: ... R5=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffff=
fff))
          R8_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfff=
fffff)) ...
  ...
  41: (bc) w3 =3D w8
  42: ... R3_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfff=
fffff)) ...
  45: (56) if w3 !=3D 0x0 goto pc+1
   ... R3_w=3Dinv0 ...
  46: (b7) r1 =3D 34
  47: R1_w=3Dinv34 R7=3Dpkt(id=3D0,off=3D26,r=3D38,imm=3D0)
  47: (0f) r7 +=3D r1
  48: R1_w=3DinvP34 R3_w=3Dinv0 R7_w=3Dpkt(id=3D0,off=3D60,r=3D38,imm=3D0=
)
  48: (b4) w9 =3D 0
  49: R1_w=3DinvP34 R3_w=3Dinv0 R7_w=3Dpkt(id=3D0,off=3D60,r=3D38,imm=3D0=
)
  49: (69) r1 =3D *(u16 *)(r7 +0)
  invalid access to packet, off=3D60 size=3D2, R7(id=3D0,off=3D60,r=3D38)
  R7 offset is outside of the packet

At above insn 132, w5 =3D 0, but after w5 ^=3D 1, we give a really conser=
vative
value of w5. At insn 45, in reality the condition should be always false.
But due to conservative value for w3, the verifier evaluates it could be
true and this later leads to verifier failure complaining potential
packet out-of-bound access.

This patch implemented proper XOR support in verifier.
In the above example, we have:
  132: R5=3DinvP0
  132: (a4) w5 ^=3D 1
  133: R5_w=3DinvP1
  ...
  37: (bc) w8 =3D w5
  ...
  41: (bc) w3 =3D w8
  42: R3_w=3DinvP1
  ...
  45: (56) if w3 !=3D 0x0 goto pc+1
  47: R3_w=3DinvP1
  ...
  processed 353 insns ...
and the verifier can verify the program successfully.

Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd24503ab3d3..a08cabc0f683 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5801,6 +5801,67 @@ static void scalar_min_max_or(struct bpf_reg_state=
 *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
=20
+static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
+				 struct bpf_reg_state *src_reg)
+{
+	bool src_known =3D tnum_subreg_is_const(src_reg->var_off);
+	bool dst_known =3D tnum_subreg_is_const(dst_reg->var_off);
+	struct tnum var32_off =3D tnum_subreg(dst_reg->var_off);
+	s32 smin_val =3D src_reg->s32_min_value;
+
+	/* Assuming scalar64_min_max_xor will be called so it is safe
+	 * to skip updating register for known case.
+	 */
+	if (src_known && dst_known)
+		return;
+
+	/* We get both minimum and maximum from the var32_off. */
+	dst_reg->u32_min_value =3D var32_off.value;
+	dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
+
+	if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0) {
+		/* XORing two positive sign numbers gives a positive,
+		 * so safe to cast u32 result into s32.
+		 */
+		dst_reg->s32_min_value =3D dst_reg->u32_min_value;
+		dst_reg->s32_max_value =3D dst_reg->u32_max_value;
+	} else {
+		dst_reg->s32_min_value =3D S32_MIN;
+		dst_reg->s32_max_value =3D S32_MAX;
+	}
+}
+
+static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
+			       struct bpf_reg_state *src_reg)
+{
+	bool src_known =3D tnum_is_const(src_reg->var_off);
+	bool dst_known =3D tnum_is_const(dst_reg->var_off);
+	s64 smin_val =3D src_reg->smin_value;
+
+	if (src_known && dst_known) {
+		/* dst_reg->var_off.value has been updated earlier */
+		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+		return;
+	}
+
+	/* We get both minimum and maximum from the var_off. */
+	dst_reg->umin_value =3D dst_reg->var_off.value;
+	dst_reg->umax_value =3D dst_reg->var_off.value | dst_reg->var_off.mask;
+
+	if (dst_reg->smin_value >=3D 0 && smin_val >=3D 0) {
+		/* XORing two positive sign numbers gives a positive,
+		 * so safe to cast u64 result into s64.
+		 */
+		dst_reg->smin_value =3D dst_reg->umin_value;
+		dst_reg->smax_value =3D dst_reg->umax_value;
+	} else {
+		dst_reg->smin_value =3D S64_MIN;
+		dst_reg->smax_value =3D S64_MAX;
+	}
+
+	__update_reg_bounds(dst_reg);
+}
+
 static void __scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
@@ -6109,6 +6170,11 @@ static int adjust_scalar_min_max_vals(struct bpf_v=
erifier_env *env,
 		scalar32_min_max_or(dst_reg, &src_reg);
 		scalar_min_max_or(dst_reg, &src_reg);
 		break;
+	case BPF_XOR:
+		dst_reg->var_off =3D tnum_xor(dst_reg->var_off, src_reg.var_off);
+		scalar32_min_max_xor(dst_reg, &src_reg);
+		scalar_min_max_xor(dst_reg, &src_reg);
+		break;
 	case BPF_LSH:
 		if (umax_val >=3D insn_bitness) {
 			/* Shifts greater than 31 or 63 are undefined.
--=20
2.24.1

