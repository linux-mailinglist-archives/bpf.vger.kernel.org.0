Return-Path: <bpf+bounces-64265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C525B10BC6
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7F41CC1F78
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C02D94B2;
	Thu, 24 Jul 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRbMlb9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31C2D641C
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364617; cv=none; b=QEYEY6jAGCFZSI8ih/XD8nyz/8jc1o7rRo8xQoAF/S28Z0Lw+ecFMxCFZ3Bm7RzX0Di74y470jEm863ytNyLJseKi0PEy+sUR4tdqKIkmuqTlxoRjS0Ovhgwf8wFCHFiA8rl8jfCIOuNmi0HkGy7sCpavQgL4s38PufOuJSUA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364617; c=relaxed/simple;
	bh=D0UDSf3bwfDnOIbzt4x6dMTmg8IWykJ8DQmFJk+LXC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlMxem/fKus/jYJIsRhxILCOeU7nxS++ekmxmgsqJ54+7sNPY3Hg6+ABsRajALYacT02Js/6CpnfGjz1HyVQ9M6yCCVj2PK3xEbmPWSjp8VpajwbrZkeqHsfg6ZTBQRgQ62MLjMrUnGzOsu6p0yjAxfMyfgIMB1HQmCmyT7KlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRbMlb9k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561ca74829so10824895e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753364614; x=1753969414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucp8tvcmf5i1xsRvJwn6GPVvaAOD7yIPzBFVl4VuaGQ=;
        b=KRbMlb9kxcAmEcs6jvwrHx2crQfKs+HHw6KrPtgNZJOb+5sbMZ+tIT6vm323T/Dd9A
         L2LoaXVDQWEFTOPWIxGBjGJKct1w67tx8ZAIELI7rj5PGd8eKNQ7zTu/D2C78jG/Df63
         3Cqc6UfKZ0WLLL23LFMhul3jY33aMuIidFf/nQHDwlAoXdxql8jrKIK8B36gLa+kkKxv
         oUJdhACTEKixsCTKOqpZO5IE23ncXNXwv9QFtaI9UQEfARJb8Vjhv2F95RA9uUukkpI0
         ZApvseIbG/elm9l8RnHJtPiNWswI6Y1zkOYeQfZXC93doQKT51UgsadMn7E5SLDC6N2n
         kXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364614; x=1753969414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ucp8tvcmf5i1xsRvJwn6GPVvaAOD7yIPzBFVl4VuaGQ=;
        b=hcpLNoGQGKIeukj6n7N7okVcKd33VB0B41Msh9oQZHZMBwDU4uWTdCEA+sVdwNANBi
         Ubjuj5H8LW8hndQtQ+xKesHYlfwlUBLE4RKyLSyGf801btFGvfrjIYWc7RQ6px3WVXZW
         x6DPFR63IhTitKrKyJET51NORwxygKrf1npebvM6UOEwrHBsPjqLxA134wjU5n9g9bSl
         e5Uh7kUEmeLSCPEubV3GRJ1hYmMBePl3t0B4loGz/naB/o+Lh6F+VrzGj4KYueCJKpcu
         sUedVtEJwYYh7maSYNWJEAu8ozqQ49JskQmEXoyJWEqrD+w5pJ6t/1sOc5mQ6bJWUv0N
         QncA==
X-Gm-Message-State: AOJu0YwHVfs8SdDSj4uGC5nC/b+9G7EfGNZX6Pg8TUv3B+g+k+tlrLkg
	s8oZ1t3SxpS9LK1UJYKKYvKlSPdHCcJeceAimYXz5kpDk0pnX/fRej+y0Mpa6I/+
X-Gm-Gg: ASbGnctqPKW5jJZtWz7UC/pfufwk9GSRcwRgYGMsYAGbgyz9tyI215Izm9jzGNUmrxk
	KTn8bW1yHxiN13gwXiSo6GLIrrb1MDN1MpzmrYghKCryXJsGNWCL7UTSp4mBAoWA4dqHfnvemqC
	gB3NUt9wOzlaG9kXl3Vs08KLutr1jxdLyFZZynl+U9xuX5eHrJJTakAW0b8sS8NuYQADDt8ZcXs
	Se4M9YzEgKZ38748g6udNZ2gAGetxfZ4VxqeDap4BL9UYfQNGBA0ZuvAmQO0L33Mj0o/daaQXBt
	Tm/DC/6bTRoITB0MPJocHMDSoJovtcqkQSFCQy+AfxDEw2u52gj29G5n7n2v3RMRZp7TjEVocvg
	4j0ZhrblLdVMhnbNh/B6ncq5e7QUp4vBuJKHvSvVr60RN+03ShX7M21GOpHc9qPTVE2lMqHQyvc
	wjUfse0okGSaCYd93OneaXirlMcI0tcUU=
X-Google-Smtp-Source: AGHT+IGCT3fysdgtT4z/kyswHmk5cV4YMXqOHHZCEa18qw2EMjF2fsxApVp7M8ElNATd3+RJgKJyEQ==
X-Received: by 2002:a05:600c:3b29:b0:456:2cd9:fc41 with SMTP id 5b1f17b1804b1-45868d47d98mr61684445e9.20.1753364613438;
        Thu, 24 Jul 2025 06:43:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f31fsm20099005e9.10.2025.07.24.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:43:32 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:43:31 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753364265.git.paul.chaignon@gmail.com>

This patch adds coverage for the new cross-sign 64bits range refinement
logic. The three tests cover the cases when the u64 and s64 ranges
overlap (1) in the negative portion of s64, (2) in the positive portion
of s64, and (3) in both portions.

The first test is a simplified version of a BPF program generated by
syzkaller that caused an invariant violation [1]. It looks like
syzkaller could not extract the reproducer itself (and therefore didn't
report it to the mailing list), but I was able to extract it from the
console logs of a crash.

The principle is similar to the invariant violation described in
6279846b9b25 ("bpf: Forget ranges when refining tnum after JSET"): the
verifier walks a dead branch, uses the condition to refine ranges, and
ends up with inconsistent ranges. In this case, the dead branch is when
we fallthrough on both jumps. The new refinement logic improves the
bounds such that the second jump is properly detected as always-taken
and the verifier doesn't end up walking a dead branch.

The second and third tests are inspired by the first, but rely on
condition jumps to prepare the bounds instead of ALU instructions. An
R10 write is used to trigger a verifier error when the bounds can't be
refined.

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 63b533ca4933..dd4e3e9f41d3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1550,4 +1550,122 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
+ * overlap on the negative side. At instruction 7, the ranges look as follows:
+ *
+ * 0          umin=0xfffffcf1                 umax=0xff..ff6e  U64_MAX
+ * |                [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxxxx]                                   [xxxxxxxxxxxx|
+ * 0    smax=0xeffffeee                       smin=-655        -1
+ *
+ * We should therefore deduce the following new bounds:
+ *
+ * 0                             u64=[0xff..ffd71;0xff..ff6e]  U64_MAX
+ * |                                              [xxx]        |
+ * |----------------------------|------------------------------|
+ * |                                              [xxx]        |
+ * 0                                        s64=[-655;-146]    -1
+ *
+ * Without the deduction cross sign boundary, we end up with an invariant
+ * violation error.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, negative overlap")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__retval(0)
+__naked void bounds_deduct_negative_overlap(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w3 = w0;			\
+	w6 = (s8)w0;			\
+	r0 = (s8)r0;			\
+	if w6 >= 0xf0000000 goto l0_%=;	\
+	r0 += r6;			\
+	r6 += 400;			\
+	r0 -= r6;			\
+	if r3 < r0 goto l0_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
+ * overlap on the positive side. At instruction 3, the ranges look as follows:
+ *
+ * 0 umin=0                      umax=0xfffffffffffffeff       U64_MAX
+ * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]            |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxx]                                         [xxxxxxxx|
+ * 0      smax=127                                smin=-128    -1
+ *
+ * We should therefore deduce the following new bounds:
+ *
+ * 0  u64=[0;127]                                              U64_MAX
+ * [xxxxxxxx]                                                  |
+ * |----------------------------|------------------------------|
+ * [xxxxxxxx]                                                  |
+ * 0  s64=[0;127]                                              -1
+ *
+ * Without the deduction cross sign boundary, the program is rejected due to
+ * the frame pointer write.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, positive overlap")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__retval(0)
+__naked void bounds_deduct_positive_overlap(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 = (s8)r0;			\
+	r1 = 0xffffffffffffff00;	\
+	if r0 > r1 goto l0_%=;		\
+	if r0 < 128 goto l0_%=;		\
+	r10 = 0;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test is the same as above, but the s64 and u64 ranges overlap in two
+ * places. At instruction 3, the ranges look as follows:
+ *
+ * 0 umin=0                           umax=0xffffffffffffff80  U64_MAX
+ * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxx]                                         [xxxxxxxx|
+ * 0      smax=127                                smin=-128    -1
+ *
+ * 0xffffffffffffff80 = (u64)-128. We therefore can't deduce anything new and
+ * the program should fail due to the frame pointer write.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, two overlaps")
+__failure __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
+__msg("frame pointer is read only")
+__naked void bounds_deduct_two_overlaps(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 = (s8)r0;			\
+	r1 = 0xffffffffffffff80;	\
+	if r0 > r1 goto l0_%=;		\
+	if r0 < 128 goto l0_%=;		\
+	r10 = 0;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


