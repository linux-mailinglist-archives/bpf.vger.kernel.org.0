Return-Path: <bpf+bounces-64411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8986B1249A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E0916B384
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9C257AC1;
	Fri, 25 Jul 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQdqpB7E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA44A254877
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470514; cv=none; b=m/fvq9PAbKwXk7hgMrWa3N5t50o9b43BEa1ZNLP3DCdXc55krUDEErzYMGWh+2r1euj+7jlEG+QEEwwj3QMphoH6mJU6heqxza0LA0BqNseg8BORpbaNyxTrxpNhirrHLVgW0cUfYxXlQoReUrGcWNPArgMrLGl4YIbzR8NZDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470514; c=relaxed/simple;
	bh=wF0hjyHS8eqO/rpybdnodHe2EmBrWUQ9OUUK7ANaGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6QOorrQivI+Z9kxB4BbDyPjAAUC2n2ZXVXiNpa3F9DlvqX6SAG2KegnauOigk437eWT59Rrtuz3F1vZ+3FtSXMYBOY7NT9E5MHTwW7ulZPy3oFV3V2uOvR7NVpO+tzk2em/R1ouEYTjfw3mkimp/VOmYAyyRET5a1eebSh2lAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQdqpB7E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45629703011so19652105e9.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470510; x=1754075310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8CXtqJPzDVrTlYqKRWUo3wxSmtHVRgZb7cZ5Z3cpj0=;
        b=QQdqpB7EGBeMY/6Mqdp5tmsHEduh/hPOyIVC351H37xNPadBxvFgqvcmTrvxGuuJ2N
         covC3nFHpqguVrzOEJQ1VomcPNQCEIExlVf6hFCnFj9/t+nWTpGo7Fbk2Xhrd4V3tCzM
         ZqfcsNEomqXdGRBM2kwMsXjkPBABO0k+DMbGu/oWsvuuwNr0TTpVG9r4FWCFqi5L3SjV
         3ESPNDTax4bzyP0De2/BQOiAdVvEkdbcngzjeokq69d0PBR8h76X3GPp2B54p2WrZ9Lz
         bj6xGYpo+R/kc6NI0Qady4j6W7Fm2cLVvOefxytNCG55yzc+ylBRqvOtH1OebnR/Ufl7
         MeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470510; x=1754075310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8CXtqJPzDVrTlYqKRWUo3wxSmtHVRgZb7cZ5Z3cpj0=;
        b=gwLBSBJT+uCtBF0A+THiVm3nYrxvAKfJGrD2PSbqP2V41BVo3Gpi+4k3RKSHzhAN1u
         hKDQu15d5B88pqYDLhUyjRHdhoJXqFkiFgCoNB1/JVDUGWMzJkRskFqEQV3ZEuYwRwUQ
         JiqXGDb7qsSzueV1u46+JFltzz97yjriasUbe449KBJk2sQyj6r4C8zf59HB02YgKW7I
         s7DSG8lNwJy6DyprJqM0AndCfDrCJUpZHJs7XsXNKJXowAZCyIQY+8ZY9NYquT+9lp4F
         cB+wAOA1/Fwye9YuFh/cGuWIjIRh0xrmMLIMXaarbeJs1CN0v8a7dON6NCQqOPryMpiB
         eLvQ==
X-Gm-Message-State: AOJu0Yyuda5GduH1VDxI/fcIP975/0e06m12UxTdkPqGpkVvE1D4d4g8
	/QfeJGLQRNhDM5Hmcb2P4iV3o5kTZsrdas5uanw8nE201kJBilB8C+vL1ilHUmYB
X-Gm-Gg: ASbGnctN9JlRUJYG2WUHb8BgOazhdNOmXbGUNHn8nzIScY7HxzSYwOYmklSXxeOQ46j
	ZgdpY56wdtwXK5HMTOT/+TynTse5FcOfBtaZqWaTKeNpgy3GvC7KXMze9s+c88bLRYDP7vIedvZ
	j7AeDuk3SOLgX/3eUZX2UfutSAW1/sg0kKWD6fWBXqeaIWxFKzGu5GfXzo2Vjxu10h1vLdkZYVe
	JR898tKozL4+HnMTJbqyesqsp7xbLIEzRcgou0WXQH8iah+5FbsccffVhHFSHtAO1VRjcaMpKMw
	armZjrCagTwIPHG9rfEC0ugxHJ9bVtHv/bTPuBsszla8gyW9SRbcgAG7FgPO4kVrXlQ+OxL/sv4
	XDYqxwGaQ2OppoWBPNQa9zkTvKl9uyKvazXLrZik7xkJ/NfmkzJOK+hukFADbih4k5PET3HIBwU
	G5m6Vdta7xm01Sha0Z+NWZeFa7t5H6nX0=
X-Google-Smtp-Source: AGHT+IEoRM3YPiQffTZ5CCd6hBZiynjHcpOhnp21HOnKqq4QUB/LhIUTB3SsM2xyxX4lDS1jamB24g==
X-Received: by 2002:a05:600c:1ca1:b0:456:117b:94bc with SMTP id 5b1f17b1804b1-4587644a028mr29431685e9.17.1753470509903;
        Fri, 25 Jul 2025 12:08:29 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008dd2b4234fb07c80.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8dd2:b423:4fb0:7c80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377cesm62058095e9.5.2025.07.25.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:08:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:08:27 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <efbb1967c5595dcf4a0b334f934b6d59c6c20d30.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753468667.git.paul.chaignon@gmail.com>

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
commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
JSET"): the verifier walks a dead branch, uses the condition to refine
ranges, and ends up with inconsistent ranges. In this case, the dead
branch is when we fallthrough on both jumps. The new refinement logic
improves the bounds such that the second jump is properly detected as
always-taken and the verifier doesn't end up walking a dead branch.

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


