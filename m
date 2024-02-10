Return-Path: <bpf+bounces-21668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7A85013B
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477C4B2656A
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2FC5224;
	Sat, 10 Feb 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGwZv8lB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036F4C7B
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525191; cv=none; b=EXMLQkJAL2rJ35WbgjzMFU+bGBR4m9zUAbGddFkApVDgdz3QLI0rsdT0XrL/KVfi1roixfX6aXoUmhqjgTaSfc3q7n4xhLPorBGmAxRbQbSAl8IlHe8hHoibo/xlwZex9Zhnn7mADPONVdFNifC6tvg29vsLK40kTw0gG1RZ+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525191; c=relaxed/simple;
	bh=Myu864pIfYCHIHmS3c4+kThRdMzyF1sbliXBAGjB45M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uqYgYhRNpVvcQE6yrJhEUhQvWJHsceDUaM+p+0XD4y8FF3y8xW+O0BBndIMBEv1OqrF69Iad1UDV0MLtRjYfdSkhLVlUAHpDxr42bjxBenmuEc9YKR4pFnoktPHRYTrD5chtdPCFudVC3dIo6x8X2qHVJV9bLI0oFF31z+mzz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGwZv8lB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F1BC433C7;
	Sat, 10 Feb 2024 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707525191;
	bh=Myu864pIfYCHIHmS3c4+kThRdMzyF1sbliXBAGjB45M=;
	h=From:To:Cc:Subject:Date:From;
	b=VGwZv8lBUnvjTf1ysLjXDj89ML9keg0vWabUuTFHEjI0zQqtzzVAnfyUkp8vdwlQX
	 /7k4m8P4xdVvW42LPELoWtN/x0all7MbwEy3s/6Iw9jhPlqzmQ9azGd0xnq+ZWlbMj
	 3PEQ5W7zrXjPugiEqJ7YZf9a6kb7G2vFIv2AzRJcMn3tzkpj2PEdIC0WMZ8Kj//eW5
	 A7JqWI8TlZb5MgAlMjRmZtGa2B5JfZkEnMz4gvwu5T8DggasZEjDRnDx6++txrx7+2
	 o1d683+L04QX+OGynQiBLoO3qEvKlqBWfyqtsRwUbjWDm2x8r/gwX53oMszdUFGrCN
	 CsAfYNgTM0O2w==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: emit source code file name and line number in verifier log
Date: Fri,  9 Feb 2024 16:33:08 -0800
Message-Id: <20240210003308.3374075-1-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As BPF applications grow in size and complexity and are separated into
multiple .bpf.c files that are statically linked together, it becomes
harder and harder to match verifier's BPF assembly level output to
original C code. While often annotated C source code is unique enough to
be able to identify the file it belongs to, quite often this is actually
problematic as parts of source code can be quite generic.

Long story short, it is very useful to see source code file name and
line number information along with the original C code. Verifier already
knows this information, we just need to output it.

This patch set is an initial proposal on how this can be done. No new
flags are added and file:line information is appended at the end of
C code:

  ; <original C code> (<filename>.bpf.c:<line>)

If file name has directory names in it, they are stripped away. This
should be fine in practice as file names tend to be pretty unique with
C code anyways, and keeping log size smaller is always good.

In practice this might look something like below, where some code is
coming from application files, while others are from libbpf's usdt.bpf.h
header file:

  ; if (STROBEMETA_READ( (strobemeta_probe.bpf.c:534)
  5592: (79) r1 = *(u64 *)(r10 -56)     ; R1_w=mem_or_null(id=1589,sz=7680) R10=fp0 fp-56_w=mem_or_null(id=1589,sz=7680)
  5593: (7b) *(u64 *)(r10 -56) = r1     ; R1_w=mem_or_null(id=1589,sz=7680) R10=fp0 fp-56_w=mem_or_null(id=1589,sz=7680)
  5594: (79) r3 = *(u64 *)(r10 -8)      ; R3_w=scalar() R10=fp0 fp-8=mmmmmmmm

  ...

  170: (71) r1 = *(u8 *)(r8 +15)        ; frame1: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R8_w=map_value(map=__bpf_usdt_spec,ks=4,vs=208)
  171: (67) r1 <<= 56                   ; frame1: R1_w=scalar(smax=0x7f00000000000000,umax=0xff00000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xff00000000000000))
  172: (c7) r1 s>>= 56                  ; frame1: R1_w=scalar(smin=smin32=-128,smax=smax32=127)
  ; val <<= arg_spec->arg_bitshift; (usdt.bpf.h:183)
  173: (67) r1 <<= 32                   ; frame1: R1_w=scalar(smax=0x7f00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
  174: (77) r1 >>= 32                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  175: (79) r2 = *(u64 *)(r10 -8)       ; frame1: R2_w=scalar() R10=fp0 fp-8=mmmmmmmm
  176: (6f) r2 <<= r1                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2_w=scalar()
  177: (7b) *(u64 *)(r10 -8) = r2       ; frame1: R2_w=scalar(id=61) R10=fp0 fp-8_w=scalar(id=61)
  ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
  178: (bf) r3 = r2                     ; frame1: R2_w=scalar(id=61) R3_w=scalar(id=61)
  179: (7f) r3 >>= r1                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R3_w=scalar()
  ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
  180: (71) r4 = *(u8 *)(r8 +14)
  181: safe

I've played with few different formats and none stood out as
particularly better than other. Suggestions and votes are appreciated:

  a) ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
  b) ; if (arg_spec->arg_signed) [usdt.bpf.h:184]
  c) ; [usdt.bpf.h:184] if (arg_spec->arg_signed)
  d) ; (usdt.bpf.h:184) if (arg_spec->arg_signed)

Above output shows variant a), which is quite non-distracting in
practice.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 594a234f122b..4b49d0eb5cd1 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -9,6 +9,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/math64.h>
+#include <linux/string.h>
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
@@ -362,6 +363,8 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  const char *prefix_fmt, ...)
 {
 	const struct bpf_line_info *linfo;
+	const struct btf *btf;
+	const char *s, *fname;
 
 	if (!bpf_verifier_log_needed(&env->log))
 		return;
@@ -378,9 +381,15 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 		va_end(args);
 	}
 
-	verbose(env, "%s\n",
-		ltrim(btf_name_by_offset(env->prog->aux->btf,
-					 linfo->line_off)));
+	btf = env->prog->aux->btf;
+	s = ltrim(btf_name_by_offset(btf, linfo->line_off));
+	verbose(env, "%s", s); /* source code line */
+
+	s = btf_name_by_offset(btf, linfo->file_name_off);
+	/* leave only file name */
+	fname = strrchr(s, '/');
+	fname = fname ? fname + 1 : s;
+	verbose(env, " (%s:%u)\n", fname, BPF_LINE_INFO_LINE_NUM(linfo->line_col));
 
 	env->prev_linfo = linfo;
 }
-- 
2.39.3


