Return-Path: <bpf+bounces-32835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6691386F
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 09:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DBE283BE2
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 07:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC13A8D0;
	Sun, 23 Jun 2024 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D2SngYSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44410374DD
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126221; cv=none; b=uf9Ki8htVm3B46PW7s3YwfjwKgh/vYN8S24YJqbZh3cSrFn4XOXPHRp4dEcU2XsUEaSnayBOnNyVUyoymVHTGcoE4iN6A5rLw67KNodjSHFiSUrOZi0yJeS5XtNvUceuX2psmnrFmMtTdVHrQmE8WzZ/A1pGkB2xXZRZ8x4zqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126221; c=relaxed/simple;
	bh=o/bhDzG96N2ZECyKO48b1vbI8H9rBVKwFI/mmblVWDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oytMBTMyvkhoBuVPSSOLGhMPh2Zp6ho/ijl2CMy6ppM4pmBd2ZoMJ2EPO5h/BEOq2ZJLdJ5uKCh7ShVUjDbetE2dI6fV6IGLfQtuD+Q2dKvSWH1jOYZ5vMxNj/6OVT04DjG+u5PpAmoSyLCRTdyGDYdp6e3brKHtUcvFs/va06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D2SngYSz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so38894001fa.3
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719126217; x=1719731017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q0XDSkO6IPlbi2Ob1YwvqKlWsg4IDHusnEwu3XmzjY=;
        b=D2SngYSzZldxK6eguwUaLybZe2+gYLQrxnPBWlSs+LWzAzcJnxHmK8mtYi8LDvFbJx
         Qx0MaOpTU0d4V2bIkMRTTJFUB57+z9kaDurizOB3i+f4pNVuHixG961H8hSv28clGhs0
         jW74ffXAnJSgvd4oJWeRnBL21iXLEELvVGheXqZ7yEyxVTifuzY7aoTysu/+grsXKpUq
         3RlnTkrjRB7WhCvn0UaRQ5FFPVGEOPNUz9jUbq82h5oxEp9SBmlDx7rhOr4awnGj2Jru
         keHjdJihir3ttsAy1R110T7HQ868c4q5YlMMzTkJ/aTpXF/WFsQcfArhj87FW1jsL/Pj
         bgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126217; x=1719731017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q0XDSkO6IPlbi2Ob1YwvqKlWsg4IDHusnEwu3XmzjY=;
        b=qvQrFnvyMa/Ys5859XAvpxy5EPeKR9VojLlyHYdR3TTwGY/qgbhKMhEUn3a/Bw2OjO
         JdYXSjtNa90Dun4exKJfu2H47b5DJS84FcknMgGdGOTK4p8vt/+6JzJhtRHX5sJgyrLd
         HD/dLCwP+lFWxarGtMXMKVRgIvSQsLQcQfP8w1UQxT42AhUTl13fgTYLkzZo/0JU7TKZ
         8/swiYCFLfYtFt15kRXVqTzPZ1/3fF7cbFEGvPIJ7rvtyPOotOl+8mn3emSj8DpPWMTA
         nP9YX67wBZll+wQcS4fRwNYiE2iR1Xi5Z0ix2GlxT743eJMgaW3fHYn90hvDDvFmc8+W
         Wh0Q==
X-Gm-Message-State: AOJu0Yyu2XxThN6zaPi4cAC7/wjAKKKtU4bM702cq1G8IH/k/T/W2qdo
	box2w+u2H1RDhdoKVFKIdfduSpgnhQfvjMXoYEMbi64pxf+htKMxtNzEZ2ZU3mrqjkA+o/0YZHQ
	f
X-Google-Smtp-Source: AGHT+IFAoXwkgYPqS5wSlB9bCBXIEuR17/KsWQzurFfTAL1QqUiEVDbdqaJEBtJlAUmqYSryay5AaQ==
X-Received: by 2002:a2e:9b12:0:b0:2ec:559d:991 with SMTP id 38308e7fff4ca-2ec579ffb28mr14902571fa.50.1719126217179;
        Sun, 23 Jun 2024 00:03:37 -0700 (PDT)
Received: from localhost ([2401:e180:8842:4fc6:d5d2:edb0:d14c:4782])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706764d5e25sm715907b3a.220.2024.06.23.00.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:03:36 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 1/2] bpf: verifier: use check_add_overflow() to check for addition overflows
Date: Sun, 23 Jun 2024 15:03:19 +0800
Message-ID: <20240623070324.12634-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623070324.12634-1-shung-hsi.yu@suse.com>
References: <20240623070324.12634-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

signed_add*_overflows() was added back when there was no overflow-check
helper. With the introduction of such helpers in commit f0907827a8a91
("compiler.h: enable builtin overflow checkers and add fallback code"), we
can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
generic check_add_overflow() instead.

This will make future refactoring easier, and possibly taking advantage of
compiler-emitted hardware instructions that efficiently implement these
checks.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
shung-hsi.yu: maybe there's a better name instead of {min,max}_cur, but
I coudln't come up with one.
---
 kernel/bpf/verifier.c | 74 ++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f6be4923655..b1ad76c514f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12720,26 +12720,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-static bool signed_add_overflows(s64 a, s64 b)
-{
-	/* Do the add in u64, where overflow is well-defined */
-	s64 res = (s64)((u64)a + (u64)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
-static bool signed_add32_overflows(s32 a, s32 b)
-{
-	/* Do the add in u32, where overflow is well-defined */
-	s32 res = (s32)((u32)a + (u32)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
 static bool signed_sub_overflows(s64 a, s64 b)
 {
 	/* Do the sub in u64, where overflow is well-defined */
@@ -13134,6 +13114,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	s64 smin_cur, smax_cur;
+	u64 umin_cur, umax_cur;
 	int ret;
 
 	dst_reg = &regs[dst];
@@ -13241,21 +13223,21 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
-		if (signed_add_overflows(smin_ptr, smin_val) ||
-		    signed_add_overflows(smax_ptr, smax_val)) {
+		if (check_add_overflow(smin_ptr, smin_val, &smin_cur) ||
+		    check_add_overflow(smax_ptr, smax_val, &smax_cur)) {
 			dst_reg->smin_value = S64_MIN;
 			dst_reg->smax_value = S64_MAX;
 		} else {
-			dst_reg->smin_value = smin_ptr + smin_val;
-			dst_reg->smax_value = smax_ptr + smax_val;
+			dst_reg->smin_value = smin_cur;
+			dst_reg->smax_value = smax_cur;
 		}
-		if (umin_ptr + umin_val < umin_ptr ||
-		    umax_ptr + umax_val < umax_ptr) {
+		if (check_add_overflow(umin_ptr, umin_val, &umin_cur) ||
+		    check_add_overflow(umax_ptr, umax_val, &umax_cur)) {
 			dst_reg->umin_value = 0;
 			dst_reg->umax_value = U64_MAX;
 		} else {
-			dst_reg->umin_value = umin_ptr + umin_val;
-			dst_reg->umax_value = umax_ptr + umax_val;
+			dst_reg->umin_value = umin_cur;
+			dst_reg->umax_value = umax_cur;
 		}
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
@@ -13362,22 +13344,24 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
 	s32 smax_val = src_reg->s32_max_value;
 	u32 umin_val = src_reg->u32_min_value;
 	u32 umax_val = src_reg->u32_max_value;
+	s32 smin_cur, smax_cur;
+	u32 umin_cur, umax_cur;
 
-	if (signed_add32_overflows(dst_reg->s32_min_value, smin_val) ||
-	    signed_add32_overflows(dst_reg->s32_max_value, smax_val)) {
+	if (check_add_overflow(dst_reg->s32_min_value, smin_val, &smin_cur) ||
+	    check_add_overflow(dst_reg->s32_max_value, smax_val, &smax_cur)) {
 		dst_reg->s32_min_value = S32_MIN;
 		dst_reg->s32_max_value = S32_MAX;
 	} else {
-		dst_reg->s32_min_value += smin_val;
-		dst_reg->s32_max_value += smax_val;
+		dst_reg->s32_min_value = smin_cur;
+		dst_reg->s32_max_value = smax_cur;
 	}
-	if (dst_reg->u32_min_value + umin_val < umin_val ||
-	    dst_reg->u32_max_value + umax_val < umax_val) {
+	if (check_add_overflow(dst_reg->u32_min_value, umin_val, &umin_cur) ||
+	    check_add_overflow(dst_reg->u32_max_value, umax_val, &umax_cur)) {
 		dst_reg->u32_min_value = 0;
 		dst_reg->u32_max_value = U32_MAX;
 	} else {
-		dst_reg->u32_min_value += umin_val;
-		dst_reg->u32_max_value += umax_val;
+		dst_reg->u32_min_value = umin_cur;
+		dst_reg->u32_max_value = umax_cur;
 	}
 }
 
@@ -13388,22 +13372,24 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 	s64 smax_val = src_reg->smax_value;
 	u64 umin_val = src_reg->umin_value;
 	u64 umax_val = src_reg->umax_value;
+	s64 smin_cur, smax_cur;
+	u64 umin_cur, umax_cur;
 
-	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
-	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
+	if (check_add_overflow(dst_reg->smin_value, smin_val, &smin_cur) ||
+	    check_add_overflow(dst_reg->smax_value, smax_val, &smax_cur)) {
 		dst_reg->smin_value = S64_MIN;
 		dst_reg->smax_value = S64_MAX;
 	} else {
-		dst_reg->smin_value += smin_val;
-		dst_reg->smax_value += smax_val;
+		dst_reg->smin_value = smin_cur;
+		dst_reg->smax_value = smax_cur;
 	}
-	if (dst_reg->umin_value + umin_val < umin_val ||
-	    dst_reg->umax_value + umax_val < umax_val) {
+	if (check_add_overflow(dst_reg->umin_value, umin_val, &umin_cur) ||
+	    check_add_overflow(dst_reg->umax_value, umax_val, &umax_cur)) {
 		dst_reg->umin_value = 0;
 		dst_reg->umax_value = U64_MAX;
 	} else {
-		dst_reg->umin_value += umin_val;
-		dst_reg->umax_value += umax_val;
+		dst_reg->umin_value = umin_cur;
+		dst_reg->umax_value = umax_cur;
 	}
 }
 
-- 
2.45.2


