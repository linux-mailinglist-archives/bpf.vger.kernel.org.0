Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D22F346D
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404859AbhALPoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbhALPoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54DC0617A6
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so2861546yba.4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=bQ/1VpzHh8LT1vlEnW7Fvr1a2e1dg4odz7n7tEVwLj4=;
        b=u7OzrQ8sRnp6sCMVD2MLfM9SeDItazfF8lfa828zfYsWgVO0pj39eTjSf7/mqcCGgg
         uxlTo37z/mMEMpOKqHHmCrxJDw8wUpZwZZmMEZqWe9y2QEGq4LQtdYDX9jwUXx4h1gkp
         P+8U+QmSiIOJzFVee5H7zHFN4fj/0jCP0sorY61ba7U0mVK7//VmghCfwITwBRrfBxMx
         5wul+ZkRLaOfa2CpFex4s+E7UtdbUi8UgQ/Ka5993n+hgt0ymfOOsrIg6T7Ki/7ez14E
         jrOb5nYFwKDnZNaNgGuyDsvbeBgAOjwk+EQpbtTqZpRPNnPNbvtgrfjzD4XZK6lLPZmo
         2hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bQ/1VpzHh8LT1vlEnW7Fvr1a2e1dg4odz7n7tEVwLj4=;
        b=G7AzDJ147jeTTm9jzb7JCg1KRdZCQgo5c7qFy9Dv+nLGvhgl2hDchGMVqIH7pWRhBt
         tG46XPd7vm1YsLTP+IpogY5CSz6l12UXv8XsBmSX6TxHfo/Aq66oueObElufe11HQgwW
         k7X8msH2DFcopCBziAA01a/BvwePfuECjEkJ1BLkdct4GnN+Sq3dGaSN5djD/9pTq9bs
         K9X2TeoM6i3wtBoVbY6mS1AJpiUJRH3YbfpAYI6GtmA6YQylchhE2doFPOx7a21h3eHJ
         mQwgNJYwFxAfF1Gx3qpiXp/0krQgrpYzeaTaKx7aOifmcDqBVPTRnXi3RgAJbizak0Ul
         BEtQ==
X-Gm-Message-State: AOAM530e+3OGB1wy63pZ/VUft0aDLZBPv1298GnylzQFg2FXjbNzGBgd
        vCTFksAnNuwR2GSFWrHi6jt51E8TLtIuc84n9CigD5yiBiZyBJ/JmhP2AQMhZ6sRict5SuOYp92
        EepxvOs2zRIj1+2CceIP6d2pr5V4joqkwE377qgScOprsxg6U7OrzFrYlsKRBuOg=
X-Google-Smtp-Source: ABdhPJwmqaJdBPaQRWA+3AqwZ/nLQ4Jyw9NqLXfg0E8k2xoMKQTPy0NO9Ryhv5Tmk+AwKYhhOXqDKvfoQRtaqQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:5052:: with SMTP id
 e79mr7749796ybb.51.1610466167744; Tue, 12 Jan 2021 07:42:47 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:28 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-5-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 04/11] bpf: Rename BPF_XADD and prepare to encode
 other atomics in .imm
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A subsequent patch will add additional atomic operations. These new
operations will use the same opcode field as the existing XADD, with
the immediate discriminating different operations.

In preparation, rename the instruction mode BPF_ATOMIC and start
calling the zero immediate BPF_ADD.

This is possible (doesn't break existing valid BPF progs) because the
immediate field is currently reserved MBZ and BPF_ADD is zero.

All uses are removed from the tree but the BPF_XADD definition is
kept around to avoid breaking builds for people including kernel
headers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
---
 Documentation/networking/filter.rst           | 30 +++++++-----
 arch/arm/net/bpf_jit_32.c                     |  7 ++-
 arch/arm64/net/bpf_jit_comp.c                 | 16 +++++--
 arch/mips/net/ebpf_jit.c                      | 11 +++--
 arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++--
 arch/riscv/net/bpf_jit_comp32.c               | 20 ++++++--
 arch/riscv/net/bpf_jit_comp64.c               | 16 +++++--
 arch/s390/net/bpf_jit_comp.c                  | 27 ++++++-----
 arch/sparc/net/bpf_jit_comp_64.c              | 17 +++++--
 arch/x86/net/bpf_jit_comp.c                   | 46 ++++++++++++++-----
 arch/x86/net/bpf_jit_comp32.c                 |  6 +--
 drivers/net/ethernet/netronome/nfp/bpf/jit.c  | 14 ++++--
 drivers/net/ethernet/netronome/nfp/bpf/main.h |  4 +-
 .../net/ethernet/netronome/nfp/bpf/verifier.c | 15 ++++--
 include/linux/filter.h                        | 16 +++++--
 include/uapi/linux/bpf.h                      |  5 +-
 kernel/bpf/core.c                             | 31 +++++++++----
 kernel/bpf/disasm.c                           |  6 ++-
 kernel/bpf/verifier.c                         | 24 ++++++----
 lib/test_bpf.c                                | 14 +++---
 samples/bpf/bpf_insn.h                        |  4 +-
 samples/bpf/cookie_uid_helper_example.c       |  8 ++--
 samples/bpf/sock_example.c                    |  2 +-
 samples/bpf/test_cgrp2_attach.c               |  5 +-
 tools/include/linux/filter.h                  | 15 ++++--
 tools/include/uapi/linux/bpf.h                |  5 +-
 .../bpf/prog_tests/cgroup_attach_multi.c      |  4 +-
 .../selftests/bpf/test_cgroup_storage.c       |  2 +-
 tools/testing/selftests/bpf/verifier/ctx.c    |  7 ++-
 .../bpf/verifier/direct_packet_access.c       |  4 +-
 .../testing/selftests/bpf/verifier/leak_ptr.c | 10 ++--
 .../selftests/bpf/verifier/meta_access.c      |  4 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |  3 +-
 .../bpf/verifier/value_illegal_alu.c          |  2 +-
 tools/testing/selftests/bpf/verifier/xadd.c   | 18 ++++----
 35 files changed, 291 insertions(+), 152 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking=
/filter.rst
index debb59e374de..1583d59d806d 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1006,13 +1006,13 @@ Size modifier is one of ...
=20
 Mode modifier is one of::
=20
-  BPF_IMM  0x00  /* used for 32-bit mov in classic BPF and 64-bit in eBPF =
*/
-  BPF_ABS  0x20
-  BPF_IND  0x40
-  BPF_MEM  0x60
-  BPF_LEN  0x80  /* classic BPF only, reserved in eBPF */
-  BPF_MSH  0xa0  /* classic BPF only, reserved in eBPF */
-  BPF_XADD 0xc0  /* eBPF only, exclusive add */
+  BPF_IMM     0x00  /* used for 32-bit mov in classic BPF and 64-bit in eB=
PF */
+  BPF_ABS     0x20
+  BPF_IND     0x40
+  BPF_MEM     0x60
+  BPF_LEN     0x80  /* classic BPF only, reserved in eBPF */
+  BPF_MSH     0xa0  /* classic BPF only, reserved in eBPF */
+  BPF_ATOMIC  0xc0  /* eBPF only, atomic operations */
=20
 eBPF has two non-generic instructions: (BPF_ABS | <size> | BPF_LD) and
 (BPF_IND | <size> | BPF_LD) which are used to access packet data.
@@ -1044,11 +1044,19 @@ Unlike classic BPF instruction set, eBPF has generi=
c load/store operations::
     BPF_MEM | <size> | BPF_STX:  *(size *) (dst_reg + off) =3D src_reg
     BPF_MEM | <size> | BPF_ST:   *(size *) (dst_reg + off) =3D imm32
     BPF_MEM | <size> | BPF_LDX:  dst_reg =3D *(size *) (src_reg + off)
-    BPF_XADD | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) +=3D =
src_reg
-    BPF_XADD | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) +=3D =
src_reg
=20
-Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW. Note that 1 and
-2 byte atomic increments are not supported.
+Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.
+
+It also includes atomic operations, which use the immediate field for extr=
a
+encoding.
+
+   .imm =3D BPF_ADD, .code =3D BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(=
u32 *)(dst_reg + off16) +=3D src_reg
+   .imm =3D BPF_ADD, .code =3D BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(=
u64 *)(dst_reg + off16) +=3D src_reg
+
+Note that 1 and 2 byte atomic operations are not supported.
+
+You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referri=
ng to
+the exclusive-add operation encoded when the immediate field is zero.
=20
 eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
 of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as si=
ngle
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 0207b6ea6e8a..897634d0a67c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1620,10 +1620,9 @@ static int build_insn(const struct bpf_insn *insn, s=
truct jit_ctx *ctx)
 		}
 		emit_str_r(dst_lo, tmp2, off, ctx, BPF_SIZE(code));
 		break;
-	/* STX XADD: lock *(u32 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_W:
-	/* STX XADD: lock *(u64 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_DW:
+	/* Atomic ops */
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		goto notyet;
 	/* STX: *(size *)(dst + off) =3D src */
 	case BPF_STX | BPF_MEM | BPF_W:
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ef9f1d5e989d..f7b194878a99 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -875,10 +875,18 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx,
 		}
 		break;
=20
-	/* STX XADD: lock *(u32 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_W:
-	/* STX XADD: lock *(u64 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_DW:
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (insn->imm !=3D BPF_ADD) {
+			pr_err_once("unknown atomic op code %02x\n", insn->imm);
+			return -EINVAL;
+		}
+
+		/* STX XADD: lock *(u32 *)(dst + off) +=3D src
+		 * and
+		 * STX XADD: lock *(u64 *)(dst + off) +=3D src
+		 */
+
 		if (!off) {
 			reg =3D dst;
 		} else {
diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 561154cbcc40..939dd06764bc 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1423,8 +1423,8 @@ static int build_one_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
 	case BPF_STX | BPF_H | BPF_MEM:
 	case BPF_STX | BPF_W | BPF_MEM:
 	case BPF_STX | BPF_DW | BPF_MEM:
-	case BPF_STX | BPF_W | BPF_XADD:
-	case BPF_STX | BPF_DW | BPF_XADD:
+	case BPF_STX | BPF_W | BPF_ATOMIC:
+	case BPF_STX | BPF_DW | BPF_ATOMIC:
 		if (insn->dst_reg =3D=3D BPF_REG_10) {
 			ctx->flags |=3D EBPF_SEEN_FP;
 			dst =3D MIPS_R_SP;
@@ -1438,7 +1438,12 @@ static int build_one_insn(const struct bpf_insn *ins=
n, struct jit_ctx *ctx,
 		src =3D ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
 		if (src < 0)
 			return src;
-		if (BPF_MODE(insn->code) =3D=3D BPF_XADD) {
+		if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC) {
+			if (insn->imm !=3D BPF_ADD) {
+				pr_err("ATOMIC OP %02x NOT HANDLED\n", insn->imm);
+				return -EINVAL;
+			}
+
 			/*
 			 * If mem_off does not fit within the 9 bit ll/sc
 			 * instruction immediate field, use a temp reg.
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_c=
omp64.c
index 022103c6a201..aaf1a887f653 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -683,10 +683,18 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u3=
2 *image,
 			break;
=20
 		/*
-		 * BPF_STX XADD (atomic_add)
+		 * BPF_STX ATOMIC (atomic ops)
 		 */
-		/* *(u32 *)(dst + off) +=3D src */
-		case BPF_STX | BPF_XADD | BPF_W:
+		case BPF_STX | BPF_ATOMIC | BPF_W:
+			if (insn->imm !=3D BPF_ADD) {
+				pr_err_ratelimited(
+					"eBPF filter atomic op code %02x (@%d) unsupported\n",
+					code, i);
+				return -ENOTSUPP;
+			}
+
+			/* *(u32 *)(dst + off) +=3D src */
+
 			/* Get EA into TMP_REG_1 */
 			EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], dst_reg, off));
 			tmp_idx =3D ctx->idx * 4;
@@ -699,8 +707,15 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32=
 *image,
 			/* we're done if this succeeded */
 			PPC_BCC_SHORT(COND_NE, tmp_idx);
 			break;
-		/* *(u64 *)(dst + off) +=3D src */
-		case BPF_STX | BPF_XADD | BPF_DW:
+		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			if (insn->imm !=3D BPF_ADD) {
+				pr_err_ratelimited(
+					"eBPF filter atomic op code %02x (@%d) unsupported\n",
+					code, i);
+				return -ENOTSUPP;
+			}
+			/* *(u64 *)(dst + off) +=3D src */
+
 			EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], dst_reg, off));
 			tmp_idx =3D ctx->idx * 4;
 			EMIT(PPC_RAW_LDARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0));
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp3=
2.c
index 579575f9cdae..a9ef808b235f 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -881,7 +881,7 @@ static int emit_store_r64(const s8 *dst, const s8 *src,=
 s16 off,
 	const s8 *rd =3D bpf_get_reg64(dst, tmp1, ctx);
 	const s8 *rs =3D bpf_get_reg64(src, tmp2, ctx);
=20
-	if (mode =3D=3D BPF_XADD && size !=3D BPF_W)
+	if (mode =3D=3D BPF_ATOMIC && (size !=3D BPF_W || imm !=3D BPF_ADD))
 		return -1;
=20
 	emit_imm(RV_REG_T0, off, ctx);
@@ -899,7 +899,7 @@ static int emit_store_r64(const s8 *dst, const s8 *src,=
 s16 off,
 		case BPF_MEM:
 			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
 			break;
-		case BPF_XADD:
+		case BPF_ATOMIC: /* .imm checked above - only BPF_ADD allowed */
 			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
 			     ctx);
 			break;
@@ -1260,7 +1260,6 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, st=
ruct rv_jit_context *ctx,
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_W:
 	case BPF_STX | BPF_MEM | BPF_DW:
-	case BPF_STX | BPF_XADD | BPF_W:
 		if (BPF_CLASS(code) =3D=3D BPF_ST) {
 			emit_imm32(tmp2, imm, ctx);
 			src =3D tmp2;
@@ -1271,8 +1270,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, s=
truct rv_jit_context *ctx,
 			return -1;
 		break;
=20
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+		if (insn->imm !=3D BPF_ADD) {
+			pr_info_once(
+				"bpf-jit: not supported: atomic operation %02x ***\n",
+				insn->imm);
+			return -EFAULT;
+		}
+
+		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
+				   BPF_MODE(code)))
+			return -1;
+		break;
+
 	/* No hardware support for 8-byte atomics in RV32. */
-	case BPF_STX | BPF_XADD | BPF_DW:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		/* Fallthrough. */
=20
 notsupported:
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 8a56b5293117..b44ff52f84a6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1027,10 +1027,18 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
 		emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
 		emit_sd(RV_REG_T1, 0, rs, ctx);
 		break;
-	/* STX XADD: lock *(u32 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_W:
-	/* STX XADD: lock *(u64 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_DW:
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (insn->imm !=3D BPF_ADD) {
+			pr_err("bpf-jit: not supported: atomic operation %02x ***\n",
+			       insn->imm);
+			return -EINVAL;
+		}
+
+		/* atomic_add: lock *(u32 *)(dst + off) +=3D src
+		 * atomic_add: lock *(u64 *)(dst + off) +=3D src
+		 */
+
 		if (off) {
 			if (is_12b_int(off)) {
 				emit_addi(RV_REG_T1, rd, off, ctx);
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0a4182792876..f973e2ead197 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1205,18 +1205,23 @@ static noinline int bpf_jit_insn(struct bpf_jit *ji=
t, struct bpf_prog *fp,
 		jit->seen |=3D SEEN_MEM;
 		break;
 	/*
-	 * BPF_STX XADD (atomic_add)
+	 * BPF_ATOMIC
 	 */
-	case BPF_STX | BPF_XADD | BPF_W: /* *(u32 *)(dst + off) +=3D src */
-		/* laal %w0,%src,off(%dst) */
-		EMIT6_DISP_LH(0xeb000000, 0x00fa, REG_W0, src_reg,
-			      dst_reg, off);
-		jit->seen |=3D SEEN_MEM;
-		break;
-	case BPF_STX | BPF_XADD | BPF_DW: /* *(u64 *)(dst + off) +=3D src */
-		/* laalg %w0,%src,off(%dst) */
-		EMIT6_DISP_LH(0xeb000000, 0x00ea, REG_W0, src_reg,
-			      dst_reg, off);
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+		if (insn->imm !=3D BPF_ADD) {
+			pr_err("Unknown atomic operation %02x\n", insn->imm);
+			return -1;
+		}
+
+		/* *(u32/u64 *)(dst + off) +=3D src
+		 *
+		 * BFW_W:  laal  %w0,%src,off(%dst)
+		 * BPF_DW: laalg %w0,%src,off(%dst)
+		 */
+		EMIT6_DISP_LH(0xeb000000,
+			      BPF_SIZE(insn->code) =3D=3D BPF_W ? 0x00fa : 0x00ea,
+			      REG_W0, src_reg, dst_reg, off);
 		jit->seen |=3D SEEN_MEM;
 		break;
 	/*
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp=
_64.c
index 3364e2a00989..4b8d3c65d266 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1366,12 +1366,18 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx)
 		break;
 	}
=20
-	/* STX XADD: lock *(u32 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_W: {
+	case BPF_STX | BPF_ATOMIC | BPF_W: {
 		const u8 tmp =3D bpf2sparc[TMP_REG_1];
 		const u8 tmp2 =3D bpf2sparc[TMP_REG_2];
 		const u8 tmp3 =3D bpf2sparc[TMP_REG_3];
=20
+		if (insn->imm !=3D BPF_ADD) {
+			pr_err_once("unknown atomic op %02x\n", insn->imm);
+			return -EINVAL;
+		}
+
+		/* lock *(u32 *)(dst + off) +=3D src */
+
 		if (insn->dst_reg =3D=3D BPF_REG_FP)
 			ctx->saw_frame_pointer =3D true;
=20
@@ -1390,11 +1396,16 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx)
 		break;
 	}
 	/* STX XADD: lock *(u64 *)(dst + off) +=3D src */
-	case BPF_STX | BPF_XADD | BPF_DW: {
+	case BPF_STX | BPF_ATOMIC | BPF_DW: {
 		const u8 tmp =3D bpf2sparc[TMP_REG_1];
 		const u8 tmp2 =3D bpf2sparc[TMP_REG_2];
 		const u8 tmp3 =3D bpf2sparc[TMP_REG_3];
=20
+		if (insn->imm !=3D BPF_ADD) {
+			pr_err_once("unknown atomic op %02x\n", insn->imm);
+			return -EINVAL;
+		}
+
 		if (insn->dst_reg =3D=3D BPF_REG_FP)
 			ctx->saw_frame_pointer =3D true;
=20
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 93f32e0ba0ef..b1829a534da1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -795,6 +795,33 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg=
, u32 src_reg, int off)
 	*pprog =3D prog;
 }
=20
+static int emit_atomic(u8 **pprog, u8 atomic_op,
+		       u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
+{
+	u8 *prog =3D *pprog;
+	int cnt =3D 0;
+
+	EMIT1(0xF0); /* lock prefix */
+
+	maybe_emit_mod(&prog, dst_reg, src_reg, bpf_size =3D=3D BPF_DW);
+
+	/* emit opcode */
+	switch (atomic_op) {
+	case BPF_ADD:
+		/* lock *(u32/u64*)(dst_reg + off) <op>=3D src_reg */
+		EMIT1(simple_alu_opcodes[atomic_op]);
+		break;
+	default:
+		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
+		return -EFAULT;
+	}
+
+	emit_insn_suffix(&prog, dst_reg, src_reg, off);
+
+	*pprog =3D prog;
+	return 0;
+}
+
 static bool ex_handler_bpf(const struct exception_table_entry *x,
 			   struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr)
@@ -839,6 +866,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs=
, u8 *image,
 	int i, cnt =3D 0, excnt =3D 0;
 	int proglen =3D 0;
 	u8 *prog =3D temp;
+	int err;
=20
 	detect_reg_usage(insn, insn_cnt, callee_regs_used,
 			 &tail_call_seen);
@@ -1250,18 +1278,12 @@ st:			if (is_imm8(insn->off))
 			}
 			break;
=20
-			/* STX XADD: lock *(u32*)(dst_reg + off) +=3D src_reg */
-		case BPF_STX | BPF_XADD | BPF_W:
-			/* Emit 'lock add dword ptr [rax + off], eax' */
-			if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT3(0xF0, add_2mod(0x40, dst_reg, src_reg), 0x01);
-			else
-				EMIT2(0xF0, 0x01);
-			goto xadd;
-		case BPF_STX | BPF_XADD | BPF_DW:
-			EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
-xadd:
-			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
+		case BPF_STX | BPF_ATOMIC | BPF_W:
+		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			err =3D emit_atomic(&prog, insn->imm, dst_reg, src_reg,
+					  insn->off, BPF_SIZE(insn->code));
+			if (err)
+				return err;
 			break;
=20
 			/* call */
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 96fde03aa987..d17b67c69f89 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2243,10 +2243,8 @@ emit_cond_jmp:		jmp_cond =3D get_cond_jmp_opcode(BPF=
_OP(code), false);
 				return -EFAULT;
 			}
 			break;
-		/* STX XADD: lock *(u32 *)(dst + off) +=3D src */
-		case BPF_STX | BPF_XADD | BPF_W:
-		/* STX XADD: lock *(u64 *)(dst + off) +=3D src */
-		case BPF_STX | BPF_XADD | BPF_DW:
+		case BPF_STX | BPF_ATOMIC | BPF_W:
+		case BPF_STX | BPF_ATOMIC | BPF_DW:
 			goto notyet;
 		case BPF_JMP | BPF_EXIT:
 			if (seen_exit) {
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/eth=
ernet/netronome/nfp/bpf/jit.c
index 0a721f6e8676..e31f8fbbc696 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -3109,13 +3109,19 @@ mem_xadd(struct nfp_prog *nfp_prog, struct nfp_insn=
_meta *meta, bool is64)
 	return 0;
 }
=20
-static int mem_xadd4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta=
)
+static int mem_atomic4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *me=
ta)
 {
+	if (meta->insn.imm !=3D BPF_ADD)
+		return -EOPNOTSUPP;
+
 	return mem_xadd(nfp_prog, meta, false);
 }
=20
-static int mem_xadd8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta=
)
+static int mem_atomic8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *me=
ta)
 {
+	if (meta->insn.imm !=3D BPF_ADD)
+		return -EOPNOTSUPP;
+
 	return mem_xadd(nfp_prog, meta, true);
 }
=20
@@ -3475,8 +3481,8 @@ static const instr_cb_t instr_cb[256] =3D {
 	[BPF_STX | BPF_MEM | BPF_H] =3D	mem_stx2,
 	[BPF_STX | BPF_MEM | BPF_W] =3D	mem_stx4,
 	[BPF_STX | BPF_MEM | BPF_DW] =3D	mem_stx8,
-	[BPF_STX | BPF_XADD | BPF_W] =3D	mem_xadd4,
-	[BPF_STX | BPF_XADD | BPF_DW] =3D	mem_xadd8,
+	[BPF_STX | BPF_ATOMIC | BPF_W] =3D	mem_atomic4,
+	[BPF_STX | BPF_ATOMIC | BPF_DW] =3D	mem_atomic8,
 	[BPF_ST | BPF_MEM | BPF_B] =3D	mem_st1,
 	[BPF_ST | BPF_MEM | BPF_H] =3D	mem_st2,
 	[BPF_ST | BPF_MEM | BPF_W] =3D	mem_st4,
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/main.h b/drivers/net/et=
hernet/netronome/nfp/bpf/main.h
index fac9c6f9e197..d0e17eebddd9 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/main.h
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.h
@@ -428,9 +428,9 @@ static inline bool is_mbpf_classic_store_pkt(const stru=
ct nfp_insn_meta *meta)
 	return is_mbpf_classic_store(meta) && meta->ptr.type =3D=3D PTR_TO_PACKET=
;
 }
=20
-static inline bool is_mbpf_xadd(const struct nfp_insn_meta *meta)
+static inline bool is_mbpf_atomic(const struct nfp_insn_meta *meta)
 {
-	return (meta->insn.code & ~BPF_SIZE_MASK) =3D=3D (BPF_STX | BPF_XADD);
+	return (meta->insn.code & ~BPF_SIZE_MASK) =3D=3D (BPF_STX | BPF_ATOMIC);
 }
=20
 static inline bool is_mbpf_mul(const struct nfp_insn_meta *meta)
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/ne=
t/ethernet/netronome/nfp/bpf/verifier.c
index e92ee510fd52..9d235c0ce46a 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -479,7 +479,7 @@ nfp_bpf_check_ptr(struct nfp_prog *nfp_prog, struct nfp=
_insn_meta *meta,
 			pr_vlog(env, "map writes not supported\n");
 			return -EOPNOTSUPP;
 		}
-		if (is_mbpf_xadd(meta)) {
+		if (is_mbpf_atomic(meta)) {
 			err =3D nfp_bpf_map_mark_used(env, meta, reg,
 						    NFP_MAP_USE_ATOMIC_CNT);
 			if (err)
@@ -523,12 +523,17 @@ nfp_bpf_check_store(struct nfp_prog *nfp_prog, struct=
 nfp_insn_meta *meta,
 }
=20
 static int
-nfp_bpf_check_xadd(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
-		   struct bpf_verifier_env *env)
+nfp_bpf_check_atomic(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta=
,
+		     struct bpf_verifier_env *env)
 {
 	const struct bpf_reg_state *sreg =3D cur_regs(env) + meta->insn.src_reg;
 	const struct bpf_reg_state *dreg =3D cur_regs(env) + meta->insn.dst_reg;
=20
+	if (meta->insn.imm !=3D BPF_ADD) {
+		pr_vlog(env, "atomic op not implemented: %d\n", meta->insn.imm);
+		return -EOPNOTSUPP;
+	}
+
 	if (dreg->type !=3D PTR_TO_MAP_VALUE) {
 		pr_vlog(env, "atomic add not to a map value pointer: %d\n",
 			dreg->type);
@@ -655,8 +660,8 @@ int nfp_verify_insn(struct bpf_verifier_env *env, int i=
nsn_idx,
 	if (is_mbpf_store(meta))
 		return nfp_bpf_check_store(nfp_prog, meta, env);
=20
-	if (is_mbpf_xadd(meta))
-		return nfp_bpf_check_xadd(nfp_prog, meta, env);
+	if (is_mbpf_atomic(meta))
+		return nfp_bpf_check_atomic(nfp_prog, meta, env);
=20
 	if (is_mbpf_alu(meta))
 		return nfp_bpf_check_alu(nfp_prog, meta, env);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 29c27656165b..b65a57d3558a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -259,15 +259,23 @@ static inline bool insn_is_zext(const struct bpf_insn=
 *insn)
 		.off   =3D OFF,					\
 		.imm   =3D 0 })
=20
-/* Atomic memory add, *(uint *)(dst_reg + off16) +=3D src_reg */
=20
-#define BPF_STX_XADD(SIZE, DST, SRC, OFF)			\
+/*
+ * Atomic operations:
+ *
+ *   BPF_ADD                  *(uint *) (dst_reg + off16) +=3D src_reg
+ */
+
+#define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
-		.code  =3D BPF_STX | BPF_SIZE(SIZE) | BPF_XADD,	\
+		.code  =3D BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
 		.dst_reg =3D DST,					\
 		.src_reg =3D SRC,					\
 		.off   =3D OFF,					\
-		.imm   =3D 0 })
+		.imm   =3D OP })
+
+/* Legacy alias */
+#define BPF_STX_XADD(SIZE, DST, SRC, OFF) BPF_ATOMIC_OP(SIZE, BPF_ADD, DST=
, SRC, OFF)
=20
 /* Memory store, *(uint *) (dst_reg + off16) =3D imm32 */
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 77d7c1bb2923..7bd3671bff20 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -19,7 +19,8 @@
=20
 /* ld/ldx fields */
 #define BPF_DW		0x18	/* double word (64-bit) */
-#define BPF_XADD	0xc0	/* exclusive add */
+#define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
+#define BPF_XADD	0xc0	/* exclusive add - legacy name */
=20
 /* alu/jmp fields */
 #define BPF_MOV		0xb0	/* mov reg to reg */
@@ -2448,7 +2449,7 @@ union bpf_attr {
  *		running simultaneously.
  *
  *		A user should care about the synchronization by himself.
- *		For example, by using the **BPF_STX_XADD** instruction to alter
+ *		For example, by using the **BPF_ATOMIC** instructions to alter
  *		the shared data.
  *	Return
  *		A pointer to the local storage area.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 261f8692d0d2..3abc6b250b18 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1309,8 +1309,8 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(STX, MEM,  H),			\
 	INSN_3(STX, MEM,  W),			\
 	INSN_3(STX, MEM,  DW),			\
-	INSN_3(STX, XADD, W),			\
-	INSN_3(STX, XADD, DW),			\
+	INSN_3(STX, ATOMIC, W),			\
+	INSN_3(STX, ATOMIC, DW),		\
 	/*   Immediate based. */		\
 	INSN_3(ST, MEM, B),			\
 	INSN_3(ST, MEM, H),			\
@@ -1618,13 +1618,25 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn, u64 *stack)
 	LDX_PROBE(DW, 8)
 #undef LDX_PROBE
=20
-	STX_XADD_W: /* lock xadd *(u32 *)(dst_reg + off16) +=3D src_reg */
-		atomic_add((u32) SRC, (atomic_t *)(unsigned long)
-			   (DST + insn->off));
+	STX_ATOMIC_W:
+		switch (IMM) {
+		case BPF_ADD:
+			/* lock xadd *(u32 *)(dst_reg + off16) +=3D src_reg */
+			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
+				   (DST + insn->off));
+		default:
+			goto default_label;
+		}
 		CONT;
-	STX_XADD_DW: /* lock xadd *(u64 *)(dst_reg + off16) +=3D src_reg */
-		atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
-			     (DST + insn->off));
+	STX_ATOMIC_DW:
+		switch (IMM) {
+		case BPF_ADD:
+			/* lock xadd *(u64 *)(dst_reg + off16) +=3D src_reg */
+			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
+				     (DST + insn->off));
+		default:
+			goto default_label;
+		}
 		CONT;
=20
 	default_label:
@@ -1634,7 +1646,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bp=
f_insn *insn, u64 *stack)
 		 *
 		 * Note, verifier whitelists all opcodes in bpf_opcode_in_insntable().
 		 */
-		pr_warn("BPF interpreter: unknown opcode %02x\n", insn->code);
+		pr_warn("BPF interpreter: unknown opcode %02x (imm: 0x%x)\n",
+			insn->code, insn->imm);
 		BUG_ON(1);
 		return 0;
 }
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index b44d8c447afd..37c8d6e9b4cc 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -153,14 +153,16 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
 				insn->off, insn->src_reg);
-		else if (BPF_MODE(insn->code) =3D=3D BPF_XADD)
+		else if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC &&
+			 insn->imm =3D=3D BPF_ADD) {
 			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) +=3D r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
-		else
+		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
+		}
 	} else if (class =3D=3D BPF_ST) {
 		if (BPF_MODE(insn->code) !=3D BPF_MEM) {
 			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17270b8404f1..d562268c1fd1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3604,13 +3604,17 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 	return err;
 }
=20
-static int check_xadd(struct bpf_verifier_env *env, int insn_idx, struct b=
pf_insn *insn)
+static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct=
 bpf_insn *insn)
 {
 	int err;
=20
-	if ((BPF_SIZE(insn->code) !=3D BPF_W && BPF_SIZE(insn->code) !=3D BPF_DW)=
 ||
-	    insn->imm !=3D 0) {
-		verbose(env, "BPF_XADD uses reserved fields\n");
+	if (insn->imm !=3D BPF_ADD) {
+		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
+		return -EINVAL;
+	}
+
+	if (BPF_SIZE(insn->code) !=3D BPF_W && BPF_SIZE(insn->code) !=3D BPF_DW) =
{
+		verbose(env, "invalid atomic operand size\n");
 		return -EINVAL;
 	}
=20
@@ -3633,19 +3637,19 @@ static int check_xadd(struct bpf_verifier_env *env,=
 int insn_idx, struct bpf_ins
 	    is_pkt_reg(env, insn->dst_reg) ||
 	    is_flow_key_reg(env, insn->dst_reg) ||
 	    is_sk_reg(env, insn->dst_reg)) {
-		verbose(env, "BPF_XADD stores into R%d %s is not allowed\n",
+		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str[reg_state(env, insn->dst_reg)->type]);
 		return -EACCES;
 	}
=20
-	/* check whether atomic_add can read the memory */
+	/* check whether we can read the memory */
 	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1, true);
 	if (err)
 		return err;
=20
-	/* check whether atomic_add can write into the same memory */
+	/* check whether we can write into the same memory */
 	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
 }
@@ -9524,8 +9528,8 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class =3D=3D BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
=20
-			if (BPF_MODE(insn->code) =3D=3D BPF_XADD) {
-				err =3D check_xadd(env, env->insn_idx, insn);
+			if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC) {
+				err =3D check_atomic(env, env->insn_idx, insn);
 				if (err)
 					return err;
 				env->insn_idx++;
@@ -9938,7 +9942,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier=
_env *env)
=20
 		if (BPF_CLASS(insn->code) =3D=3D BPF_STX &&
 		    ((BPF_MODE(insn->code) !=3D BPF_MEM &&
-		      BPF_MODE(insn->code) !=3D BPF_XADD) || insn->imm !=3D 0)) {
+		      BPF_MODE(insn->code) !=3D BPF_ATOMIC) || insn->imm !=3D 0)) {
 			verbose(env, "BPF_STX uses reserved fields\n");
 			return -EINVAL;
 		}
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ca7d635bccd9..49ec9e8d8aed 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4295,13 +4295,13 @@ static struct bpf_test tests[] =3D {
 		{ { 0, 0xffffffff } },
 		.stack_depth =3D 40,
 	},
-	/* BPF_STX | BPF_XADD | BPF_W/DW */
+	/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
 	{
 		"STX_XADD_W: Test: 0x12 + 0x10 =3D 0x22",
 		.u.insns_int =3D {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
 			BPF_ST_MEM(BPF_W, R10, -40, 0x10),
-			BPF_STX_XADD(BPF_W, R10, R0, -40),
+			BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
 			BPF_LDX_MEM(BPF_W, R0, R10, -40),
 			BPF_EXIT_INSN(),
 		},
@@ -4316,7 +4316,7 @@ static struct bpf_test tests[] =3D {
 			BPF_ALU64_REG(BPF_MOV, R1, R10),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
 			BPF_ST_MEM(BPF_W, R10, -40, 0x10),
-			BPF_STX_XADD(BPF_W, R10, R0, -40),
+			BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
 			BPF_ALU64_REG(BPF_MOV, R0, R10),
 			BPF_ALU64_REG(BPF_SUB, R0, R1),
 			BPF_EXIT_INSN(),
@@ -4331,7 +4331,7 @@ static struct bpf_test tests[] =3D {
 		.u.insns_int =3D {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
 			BPF_ST_MEM(BPF_W, R10, -40, 0x10),
-			BPF_STX_XADD(BPF_W, R10, R0, -40),
+			BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
 			BPF_EXIT_INSN(),
 		},
 		INTERNAL,
@@ -4352,7 +4352,7 @@ static struct bpf_test tests[] =3D {
 		.u.insns_int =3D {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
 			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
-			BPF_STX_XADD(BPF_DW, R10, R0, -40),
+			BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
 			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
 			BPF_EXIT_INSN(),
 		},
@@ -4367,7 +4367,7 @@ static struct bpf_test tests[] =3D {
 			BPF_ALU64_REG(BPF_MOV, R1, R10),
 			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
 			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
-			BPF_STX_XADD(BPF_DW, R10, R0, -40),
+			BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
 			BPF_ALU64_REG(BPF_MOV, R0, R10),
 			BPF_ALU64_REG(BPF_SUB, R0, R1),
 			BPF_EXIT_INSN(),
@@ -4382,7 +4382,7 @@ static struct bpf_test tests[] =3D {
 		.u.insns_int =3D {
 			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
 			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
-			BPF_STX_XADD(BPF_DW, R10, R0, -40),
+			BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
 			BPF_EXIT_INSN(),
 		},
 		INTERNAL,
diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
index 544237980582..db67a2847395 100644
--- a/samples/bpf/bpf_insn.h
+++ b/samples/bpf/bpf_insn.h
@@ -138,11 +138,11 @@ struct bpf_insn;
=20
 #define BPF_STX_XADD(SIZE, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
-		.code  =3D BPF_STX | BPF_SIZE(SIZE) | BPF_XADD,	\
+		.code  =3D BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
 		.dst_reg =3D DST,					\
 		.src_reg =3D SRC,					\
 		.off   =3D OFF,					\
-		.imm   =3D 0 })
+		.imm   =3D BPF_ADD })
=20
 /* Memory store, *(uint *) (dst_reg + off16) =3D imm32 */
=20
diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_u=
id_helper_example.c
index deb0e3e0324d..c5ff7a13918c 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -147,12 +147,12 @@ static void prog_load(void)
 		 */
 		BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
 		BPF_MOV64_IMM(BPF_REG_1, 1),
-		BPF_STX_XADD(BPF_DW, BPF_REG_9, BPF_REG_1,
-				offsetof(struct stats, packets)),
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_9, BPF_REG_1,
+			      offsetof(struct stats, packets)),
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_6,
 				offsetof(struct __sk_buff, len)),
-		BPF_STX_XADD(BPF_DW, BPF_REG_9, BPF_REG_1,
-				offsetof(struct stats, bytes)),
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_9, BPF_REG_1,
+			      offsetof(struct stats, bytes)),
 		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
 				offsetof(struct __sk_buff, len)),
 		BPF_EXIT_INSN(),
diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
index 00aae1d33fca..23d1930e1927 100644
--- a/samples/bpf/sock_example.c
+++ b/samples/bpf/sock_example.c
@@ -54,7 +54,7 @@ static int test_sock(void)
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 =3D 1 */
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /=
* xadd r0 +=3D r1 */
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 		BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 =3D 0 */
 		BPF_EXIT_INSN(),
 	};
diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attac=
h.c
index 20fbd1241db3..390ff38d2ac6 100644
--- a/samples/bpf/test_cgrp2_attach.c
+++ b/samples/bpf/test_cgrp2_attach.c
@@ -53,7 +53,7 @@ static int prog_load(int map_fd, int verdict)
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 =3D 1 */
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /=
* xadd r0 +=3D r1 */
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
=20
 		/* Count bytes */
 		BPF_MOV64_IMM(BPF_REG_0, MAP_KEY_BYTES), /* r0 =3D 1 */
@@ -64,7 +64,8 @@ static int prog_load(int map_fd, int verdict)
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_6, offsetof(struct __sk_buff, len)=
), /* r1 =3D skb->len */
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /=
* xadd r0 +=3D r1 */
+
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
=20
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 =3D verdict */
 		BPF_EXIT_INSN(),
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index ca28b6ab8db7..e870c9039f0d 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -169,15 +169,22 @@
 		.off   =3D OFF,					\
 		.imm   =3D 0 })
=20
-/* Atomic memory add, *(uint *)(dst_reg + off16) +=3D src_reg */
+/*
+ * Atomic operations:
+ *
+ *   BPF_ADD                  *(uint *) (dst_reg + off16) +=3D src_reg
+ */
=20
-#define BPF_STX_XADD(SIZE, DST, SRC, OFF)			\
+#define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
-		.code  =3D BPF_STX | BPF_SIZE(SIZE) | BPF_XADD,	\
+		.code  =3D BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
 		.dst_reg =3D DST,					\
 		.src_reg =3D SRC,					\
 		.off   =3D OFF,					\
-		.imm   =3D 0 })
+		.imm   =3D OP })
+
+/* Legacy alias */
+#define BPF_STX_XADD(SIZE, DST, SRC, OFF) BPF_ATOMIC_OP(SIZE, BPF_ADD, DST=
, SRC, OFF)
=20
 /* Memory store, *(uint *) (dst_reg + off16) =3D imm32 */
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 77d7c1bb2923..7bd3671bff20 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -19,7 +19,8 @@
=20
 /* ld/ldx fields */
 #define BPF_DW		0x18	/* double word (64-bit) */
-#define BPF_XADD	0xc0	/* exclusive add */
+#define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
+#define BPF_XADD	0xc0	/* exclusive add - legacy name */
=20
 /* alu/jmp fields */
 #define BPF_MOV		0xb0	/* mov reg to reg */
@@ -2448,7 +2449,7 @@ union bpf_attr {
  *		running simultaneously.
  *
  *		A user should care about the synchronization by himself.
- *		For example, by using the **BPF_STX_XADD** instruction to alter
+ *		For example, by using the **BPF_ATOMIC** instructions to alter
  *		the shared data.
  *	Return
  *		A pointer to the local storage area.
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index b549fcfacc0b..0a1fc9816cef 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -45,13 +45,13 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 =3D 1 */
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /=
* xadd r0 +=3D r1 */
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
=20
 		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, val),
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
+		BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
=20
 		BPF_LD_MAP_FD(BPF_REG_1, percpu_cgroup_storage_fd),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/test=
ing/selftests/bpf/test_cgroup_storage.c
index d946252a25bb..0cda61da5d39 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, 1),
-		BPF_STX_XADD(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
 		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x1),
 		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/sel=
ftests/bpf/verifier/ctx.c
index 93d6b1641481..23080862aafd 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -10,14 +10,13 @@
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 },
 {
-	"context stores via XADD",
+	"context stores via BPF_ATOMIC",
 	.insns =3D {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_1,
-		     BPF_REG_0, offsetof(struct __sk_buff, mark), 0),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_1, BPF_REG_0, offsetof(struct __sk_=
buff, mark)),
 	BPF_EXIT_INSN(),
 	},
-	.errstr =3D "BPF_XADD stores into R1 ctx is not allowed",
+	.errstr =3D "BPF_ATOMIC stores into R1 ctx is not allowed",
 	.result =3D REJECT,
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 },
diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/=
tools/testing/selftests/bpf/verifier/direct_packet_access.c
index ae72536603fe..ac1e19d0f520 100644
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
@@ -333,7 +333,7 @@
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_STX_XADD(BPF_DW, BPF_REG_4, BPF_REG_5, 0),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_4, BPF_REG_5, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_4, 0),
 	BPF_STX_MEM(BPF_W, BPF_REG_2, BPF_REG_5, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -488,7 +488,7 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 11),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
-	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_4, -8),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_4, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 49),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
diff --git a/tools/testing/selftests/bpf/verifier/leak_ptr.c b/tools/testin=
g/selftests/bpf/verifier/leak_ptr.c
index d6eec17f2cd2..73f0dea95546 100644
--- a/tools/testing/selftests/bpf/verifier/leak_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/leak_ptr.c
@@ -5,7 +5,7 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
 		    offsetof(struct __sk_buff, cb[0])),
 	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_STX_XADD(BPF_DW, BPF_REG_1, BPF_REG_2,
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_1, BPF_REG_2,
 		      offsetof(struct __sk_buff, cb[0])),
 	BPF_EXIT_INSN(),
 	},
@@ -13,7 +13,7 @@
 	.errstr_unpriv =3D "R2 leaks addr into mem",
 	.result_unpriv =3D REJECT,
 	.result =3D REJECT,
-	.errstr =3D "BPF_XADD stores into R1 ctx is not allowed",
+	.errstr =3D "BPF_ATOMIC stores into R1 ctx is not allowed",
 },
 {
 	"leak pointer into ctx 2",
@@ -21,14 +21,14 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
 		    offsetof(struct __sk_buff, cb[0])),
-	BPF_STX_XADD(BPF_DW, BPF_REG_1, BPF_REG_10,
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_1, BPF_REG_10,
 		      offsetof(struct __sk_buff, cb[0])),
 	BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv =3D "R10 leaks addr into mem",
 	.result_unpriv =3D REJECT,
 	.result =3D REJECT,
-	.errstr =3D "BPF_XADD stores into R1 ctx is not allowed",
+	.errstr =3D "BPF_ATOMIC stores into R1 ctx is not allowed",
 },
 {
 	"leak pointer into ctx 3",
@@ -56,7 +56,7 @@
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
-	BPF_STX_XADD(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_6, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/meta_access.c b/tools/tes=
ting/selftests/bpf/verifier/meta_access.c
index 205292b8dd65..b45e8af41420 100644
--- a/tools/testing/selftests/bpf/verifier/meta_access.c
+++ b/tools/testing/selftests/bpf/verifier/meta_access.c
@@ -171,7 +171,7 @@
 	BPF_MOV64_IMM(BPF_REG_5, 42),
 	BPF_MOV64_IMM(BPF_REG_6, 24),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_5, -8),
-	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -8),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_5, 100, 6),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_5),
@@ -196,7 +196,7 @@
 	BPF_MOV64_IMM(BPF_REG_5, 42),
 	BPF_MOV64_IMM(BPF_REG_6, 24),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_5, -8),
-	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_6, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -8),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_5, 100, 6),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_5),
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/=
selftests/bpf/verifier/unpriv.c
index a3fe0fbaed41..ee298627abae 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -207,7 +207,8 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_10, BPF_REG_0, -8, 0),
+	BPF_RAW_INSN(BPF_STX | BPF_ATOMIC | BPF_DW,
+		     BPF_REG_10, BPF_REG_0, -8, BPF_ADD),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/value_illegal_alu.c b/too=
ls/testing/selftests/bpf/verifier/value_illegal_alu.c
index ed1c2cea1dea..489062867218 100644
--- a/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
@@ -82,7 +82,7 @@
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_STX_XADD(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_2, BPF_REG_3, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/xadd.c b/tools/testing/se=
lftests/bpf/verifier/xadd.c
index c5de2e62cc8b..b96ef3526815 100644
--- a/tools/testing/selftests/bpf/verifier/xadd.c
+++ b/tools/testing/selftests/bpf/verifier/xadd.c
@@ -3,7 +3,7 @@
 	.insns =3D {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_XADD(BPF_W, BPF_REG_10, BPF_REG_0, -7),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 	BPF_EXIT_INSN(),
 	},
@@ -22,7 +22,7 @@
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_STX_XADD(BPF_W, BPF_REG_0, BPF_REG_1, 3),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 3),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 3),
 	BPF_EXIT_INSN(),
 	},
@@ -45,13 +45,13 @@
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 	BPF_ST_MEM(BPF_W, BPF_REG_2, 3, 0),
-	BPF_STX_XADD(BPF_W, BPF_REG_2, BPF_REG_0, 1),
-	BPF_STX_XADD(BPF_W, BPF_REG_2, BPF_REG_0, 2),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_2, BPF_REG_0, 1),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_2, BPF_REG_0, 2),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 1),
 	BPF_EXIT_INSN(),
 	},
 	.result =3D REJECT,
-	.errstr =3D "BPF_XADD stores into R2 pkt is not allowed",
+	.errstr =3D "BPF_ATOMIC stores into R2 pkt is not allowed",
 	.prog_type =3D BPF_PROG_TYPE_XDP,
 	.flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
@@ -62,8 +62,8 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
+	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
 	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
 	BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
@@ -82,8 +82,8 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_XADD(BPF_W, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_XADD(BPF_W, BPF_REG_10, BPF_REG_0, -8),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
 	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
 	BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
--=20
2.30.0.284.gd98b1dd5eaa7-goog

