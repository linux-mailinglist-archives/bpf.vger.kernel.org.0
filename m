Return-Path: <bpf+bounces-21807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9FD8522DA
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8671F22D49
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F265025A;
	Mon, 12 Feb 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M54icSSp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACED3EA78
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782386; cv=none; b=AuYpudyxszcnsovn9sOdQ56u3T93XtgBKhvYGg2jnQQqVTYrG9z+lBbxH2UHWQWr7pJ6w6MCuIAZjiLwEZXNa78Nk0kXFS4pNcaoLOIDbSY0B4gfuS4XPxNplrVc9f4jsZQRNbdBl0al5MAs7WmPlq4V0yOUzcNrgOKdGAzy8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782386; c=relaxed/simple;
	bh=2NOWoecb9rXT2CO3pQ95Jbp558TppZwagGNbUvGrDo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ng67rAmcXy/0594AtJYUa5er0B0SI+BSoDA0GXB7NikoPYI22Y7SSlSffxE/QZcrga6GT4+r961u3Fl8AiL+1iqclNnfufY17WpKXvOPGP6Lyejawr8XHP5XQ9gtS1zam8AHjzmfxKXXYDs/jiI+F2jvkAitf76YljQZlsT8YM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M54icSSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BDFC433C7;
	Mon, 12 Feb 2024 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707782386;
	bh=2NOWoecb9rXT2CO3pQ95Jbp558TppZwagGNbUvGrDo8=;
	h=From:To:Cc:Subject:Date:From;
	b=M54icSSpUVerkQzRhtpDp1j7P3kGhILifdRwQvqSiTbI+GBfxjSZnrrf59gr7YiEh
	 8Pn3xCbQkmxVPWKCg2x6TIIAtCPzopbVj+PuxQ5Q6Tvnmjuw2nNeikpVVCJ7vTjBwm
	 4HwkSHOQgXhatzqNjbM7itqoUHsPSSuoctznFb8TKmdCMu9Xo1Z+JxJQfZ3mW2SY3B
	 Je2YpwfqA3A6a3yitkoPthUYoqf3D0kMzOmJoCFgNnUzH6cJ+2wAvLXEbPm4hoU2oP
	 PycVZyhlcAMouzlPvGTrNEmxa+LC5W6z7QjlitVmYUX+yxrNAcZNgNaxWkaaaDF0sc
	 MHfIgYi+FbXDQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next] bpf: emit source code file name and line number in verifier log
Date: Mon, 12 Feb 2024 15:59:44 -0800
Message-Id: <20240212235944.2816107-1-andrii@kernel.org>
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

This patch extends verifier log with file name and line number
information, emitted next to original (presumably C) source code,
annotating BPF assembly output, like so:

  ; <original C code> @ <filename>.bpf.c:<line>

If file name has directory names in it, they are stripped away. This
should be fine in practice as file names tend to be pretty unique with
C code anyways, and keeping log size smaller is always good.

In practice this might look something like below, where some code is
coming from application files, while others are from libbpf's usdt.bpf.h
header file:

  ; if (STROBEMETA_READ( @ strobemeta_probe.bpf.c:534
  5592: (79) r1 = *(u64 *)(r10 -56)     ; R1_w=mem_or_null(id=1589,sz=7680) R10=fp0
  5593: (7b) *(u64 *)(r10 -56) = r1     ; R1_w=mem_or_null(id=1589,sz=7680) R10=fp0
  5594: (79) r3 = *(u64 *)(r10 -8)      ; R3_w=scalar() R10=fp0 fp-8=mmmmmmmm

  ...

  170: (71) r1 = *(u8 *)(r8 +15)        ; frame1: R1_w=scalar(...) R8_w=map_value(map=__bpf_usdt_spec,ks=4,vs=208)
  171: (67) r1 <<= 56                   ; frame1: R1_w=scalar(...)
  172: (c7) r1 s>>= 56                  ; frame1: R1_w=scalar(smin=smin32=-128,smax=smax32=127)
  ; val <<= arg_spec->arg_bitshift; @ usdt.bpf.h:183
  173: (67) r1 <<= 32                   ; frame1: R1_w=scalar(...)
  174: (77) r1 >>= 32                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  175: (79) r2 = *(u64 *)(r10 -8)       ; frame1: R2_w=scalar() R10=fp0 fp-8=mmmmmmmm
  176: (6f) r2 <<= r1                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2_w=scalar()
  177: (7b) *(u64 *)(r10 -8) = r2       ; frame1: R2_w=scalar(id=61) R10=fp0 fp-8_w=scalar(id=61)
  ; if (arg_spec->arg_signed) @ usdt.bpf.h:184
  178: (bf) r3 = r2                     ; frame1: R2_w=scalar(id=61) R3_w=scalar(id=61)
  179: (7f) r3 >>= r1                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R3_w=scalar()
  ; if (arg_spec->arg_signed) @ usdt.bpf.h:184
  180: (71) r4 = *(u8 *)(r8 +14)
  181: safe

log_fixup tests needed a minor adjustment as verifier log output
increased a bit and that test is quite sensitive to such changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c                                  | 15 ++++++++++++---
 .../testing/selftests/bpf/prog_tests/log_fixup.c  |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 594a234f122b..cc789efc7f43 100644
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
+	verbose(env, " @ %s:%u\n", fname, BPF_LINE_INFO_LINE_NUM(linfo->line_col));
 
 	env->prev_linfo = linfo;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index 7a3fa2ff567b..90a98e23be61 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -169,9 +169,9 @@ void test_log_fixup(void)
 	if (test__start_subtest("bad_core_relo_trunc_none"))
 		bad_core_relo(0, TRUNC_NONE /* full buf */);
 	if (test__start_subtest("bad_core_relo_trunc_partial"))
-		bad_core_relo(280, TRUNC_PARTIAL /* truncate original log a bit */);
+		bad_core_relo(300, TRUNC_PARTIAL /* truncate original log a bit */);
 	if (test__start_subtest("bad_core_relo_trunc_full"))
-		bad_core_relo(220, TRUNC_FULL  /* truncate also libbpf's message patch */);
+		bad_core_relo(240, TRUNC_FULL  /* truncate also libbpf's message patch */);
 	if (test__start_subtest("bad_core_relo_subprog"))
 		bad_core_relo_subprog();
 	if (test__start_subtest("missing_map"))
-- 
2.39.3


