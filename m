Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6781057F4
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKURGz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 12:06:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50198 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbfKURGz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 12:06:55 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALGxMad012686
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2019 09:06:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=/f3TJc24kT2Fl/zq/XaI9B46jjvNZ1jCHXxlSAtd9/8=;
 b=NHCUwKLM43FXQ2i4fKf/Rm0SFw9I1josyxArsCt+4XFMNxOsRk99WYCzZWEGkY2eLVj7
 vfX+WaXTxpvEz8HpD1sofsK8I4XMIkzezvn6x4OwSTVPBiqmG/evwRKUvFpzXDKUQwFP
 0E/4R4lK+ieB+Mmuvqa4y36HNT0sL0Fm5jc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wdjuvf5n3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2019 09:06:53 -0800
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Nov 2019 09:06:51 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A98523701F42; Thu, 21 Nov 2019 09:06:50 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 1/2] bpf: provide better register bounds after jmp32 instructions
Date:   Thu, 21 Nov 2019 09:06:50 -0800
Message-ID: <20191121170650.449030-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121170650.448973-1-yhs@fb.com>
References: <20191121170650.448973-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_04:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 mlxlogscore=684 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210148
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest llvm (trunk https://github.com/llvm/llvm-project),
test_progs, which has +alu32 enabled, failed for strobemeta.o.
The verifier output looks like below with edit to replace large
decimal numbers with hex ones.
 193: (85) call bpf_probe_read_user_str#114
   R0=inv(id=0)
 194: (26) if w0 > 0x1 goto pc+4
   R0_w=inv(id=0,umax_value=0xffffffff00000001)
 195: (6b) *(u16 *)(r7 +80) = r0
 196: (bc) w6 = w0
   R6_w=inv(id=0,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
 197: (67) r6 <<= 32
   R6_w=inv(id=0,smax_value=0x7fffffff00000000,umax_value=0xffffffff00000000,
            var_off=(0x0; 0xffffffff00000000))
 198: (77) r6 >>= 32
   R6=inv(id=0,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
 ...
 201: (79) r8 = *(u64 *)(r10 -416)
   R8_w=map_value(id=0,off=40,ks=4,vs=13872,imm=0)
 202: (0f) r8 += r6
   R8_w=map_value(id=0,off=40,ks=4,vs=13872,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
 203: (07) r8 += 9696
   R8_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
 ...
 255: (bf) r1 = r8
   R1_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
 ...
 257: (85) call bpf_probe_read_user_str#114
 R1 unbounded memory access, make sure to bounds check any array access into a map

The value range for register r6 at insn 198 should be really just 0/1.
The umax_value=0xffffffff caused later verification failure.

After jmp instructions, the current verifier already tried to use just
obtained information to get better register range. The current mechanism is
for 64bit register only. This patch implemented to tighten the range
for 32bit sub-registers after jmp32 instructions.
With the patch, we have the below range ranges for the
above code sequence:
 193: (85) call bpf_probe_read_user_str#114
   R0=inv(id=0)
 194: (26) if w0 > 0x1 goto pc+4
   R0_w=inv(id=0,smax_value=0x7fffffff00000001,umax_value=0xffffffff00000001,
            var_off=(0x0; 0xffffffff00000001))
 195: (6b) *(u16 *)(r7 +80) = r0
 196: (bc) w6 = w0
   R6_w=inv(id=0,umax_value=0xffffffff,var_off=(0x0; 0x1))
 197: (67) r6 <<= 32
   R6_w=inv(id=0,umax_value=0x100000000,var_off=(0x0; 0x100000000))
 198: (77) r6 >>= 32
   R6=inv(id=0,umax_value=1,var_off=(0x0; 0x1))
 ...
 201: (79) r8 = *(u64 *)(r10 -416)
   R8_w=map_value(id=0,off=40,ks=4,vs=13872,imm=0)
 202: (0f) r8 += r6
   R8_w=map_value(id=0,off=40,ks=4,vs=13872,umax_value=1,var_off=(0x0; 0x1))
 203: (07) r8 += 9696
   R8_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=1,var_off=(0x0; 0x1))
 ...
 255: (bf) r1 = r8
   R1_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=1,var_off=(0x0; 0x1))
 ...
 257: (85) call bpf_probe_read_user_str#114
 ...

At insn 194, the register R0 has better var_off.mask and smax_value.
Especially, the var_off.mask ensures later lshift and rshift
maintains proper value range.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f59f7a19dd0..fc85714428c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1007,6 +1007,17 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 						 reg->umax_value));
 }
 
+static void __reg_bound_offset32(struct bpf_reg_state *reg)
+{
+	u64 mask = 0xffffFFFF;
+	struct tnum range = tnum_range(reg->umin_value & mask,
+				       reg->umax_value & mask);
+	struct tnum lo32 = tnum_cast(reg->var_off, 4);
+	struct tnum hi32 = tnum_lshift(tnum_rshift(reg->var_off, 32), 32);
+
+	reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
+}
+
 /* Reset the min/max bounds of a register */
 static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 {
@@ -5589,6 +5600,10 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(false_reg);
 	__reg_bound_offset(true_reg);
+	if (is_jmp32) {
+		__reg_bound_offset32(false_reg);
+		__reg_bound_offset32(true_reg);
+	}
 	/* Intersecting with the old var_off might have improved our bounds
 	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
 	 * then new var_off is (0; 0x7f...fc) which improves our umax.
@@ -5698,6 +5713,10 @@ static void reg_set_min_max_inv(struct bpf_reg_state *true_reg,
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(false_reg);
 	__reg_bound_offset(true_reg);
+	if (is_jmp32) {
+		__reg_bound_offset32(false_reg);
+		__reg_bound_offset32(true_reg);
+	}
 	/* Intersecting with the old var_off might have improved our bounds
 	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
 	 * then new var_off is (0; 0x7f...fc) which improves our umax.
-- 
2.17.1

