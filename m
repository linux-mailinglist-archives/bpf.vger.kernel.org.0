Return-Path: <bpf+bounces-58878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DCAC2CD9
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F0AA413C9
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A171C1DFD84;
	Sat, 24 May 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ2Zt/k7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670F1C32
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049538; cv=none; b=aATR6uPg2zzV3FTdCf43UIotW2qVLenYLqFG5NTH/x979yXXhCqG800X+L5JyuaolqPBFR2ZtuUp/38OIfW9pWFouSNM+AW5AcoZKoOWOEcBGSPbJWYbdZWVd4eccEz7S/4A6VLqKzKYEmjVV14WmwD4JDVY0xC6WmsLZszDnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049538; c=relaxed/simple;
	bh=YGvT3yva1QMufsgaSpeeisz9fl3gXGTJE1/B43PKnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9xilG2q4b9FpzB27S3MtTcUpZp/2Pf7h6168wobxGVwiPpHJMGtB3nc9eHkbZ0CCm20cYVC0GBfKPy/zV6u4Apz7JBBCPDf35r1eSUspsSZrwGFpuXtfK5aRV4ba5ZA3Lpvk9cJ9I0Kq+qj9gYrkKHfOzMgamYAIGv/sjBNfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ2Zt/k7; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so2695395e9.0
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049534; x=1748654334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqI63H5XDFp2lZ+al8wdUtDXWeAwrhps6yVsn5yyZVs=;
        b=iQ2Zt/k7EXQOi+2spmMvVpI+GJianALl/7aPVIzomKjBnDMA9tsmuCFHi8fp5ctvKx
         wRkpaWHXNiRsjzpna9mgfDW6ewj6vk7X+CtULDmhqw7T8RiacVHxgUIqcasxqHkepbPb
         IFI7G1JhL3S4JSERfvm0QeMH32drU/dK1FFdNCWsSpm+MTpGHfhNuhKGz5ZeeoqAAA0Q
         AIWgBFYaKQMRPFgqvdB6nVpMzHZqgTgStidH+AheDSboSdGghVfn8/CrurgtFWtHcfc8
         jS95xVYqjs41z7yqNUaJsZx1YeHewj4MVgNhuVlWlPPOna3x/qHFS7R0fh9FLkWOn0kA
         H22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049534; x=1748654334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqI63H5XDFp2lZ+al8wdUtDXWeAwrhps6yVsn5yyZVs=;
        b=fC1qgqxovOmM7P/IosFn+cR7sqMUIQAZTNo3msA1J1PPKkBWhGOf1nZS43LUH/yEI3
         a83JHtIziw2qyMZrRbUqMrP4Q3e2myfBAyU6Yn2uNO8bBKhRs1tNP5GsH6PQGLW8/A2F
         1vg14ZyJNn5uh7L+P8NsPVPLLCltmgH17mB1kWoA7k6riFHmRDc1GP903wPoss7VewWK
         7/5DGkRwlHNuBzVUVl3SBB2RjAt1Fl/OxeY/UzF2tOHP2P+XLV+zxRUgyD6DneIZjE5J
         wnyF+U9hF3DQ81TiHRwHA9JDOb8CgpehKdqpmJkmkwJWq65mDeUPIfa1mu/9wGDqSKk/
         YXnw==
X-Gm-Message-State: AOJu0YzSf24dCjKlCHNqKnaFAIMDpWBkd/lUmlFB4b7lSEWItvn1G8Sg
	IIg3j6WwtrrhS3oLYBslFPL6USPBtzcwEaS96bXw5wYK+mC1ocbacdsBewMh5v8ypek=
X-Gm-Gg: ASbGncvUtBzlqS3I8BM8ltViFOVwb38MiBOvyMhVCxc5A9LKny96hqwunuzxKpH8oXg
	rJx4sqJckUtnvgm5oy+GCTIolPdkpGLgD9NGVduvB4BdleR5Bl4xfplhZiyKNi9/cEEkYuAXmWw
	IWlaVC6DJQlotnnaRD9hkve75K7SfZteETuS/D9Zgqq7xacXQETQZE+MqEOEaShPGbwXJyJnU8u
	lWklxugOvMJyRLeZrLufWuNURxYmun3OuCcyJo+M9xsyq8Xc9xDLt/bLKurz0OpA/MZA3b1QUkl
	LvLN1YAq1CRR+L25wpvhzEp+Dy1pS9wKfnm4dzvckQ==
X-Google-Smtp-Source: AGHT+IEKcX58KAgHIJ5zerNImB7Cpg6zsyCB8qAYyBl3vn4xfpGPgeae1tYKndbTXZ/moqIbNwpjRg==
X-Received: by 2002:a05:600c:6090:b0:441:d446:b636 with SMTP id 5b1f17b1804b1-44c933ed957mr7731305e9.27.1748049534439;
        Fri, 23 May 2025 18:18:54 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aef8asm166691215e9.29.2025.05.23.18.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/11] bpf: Add function to find program from stack trace
Date: Fri, 23 May 2025 18:18:41 -0700
Message-ID: <20250524011849.681425-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886; h=from:subject; bh=YGvT3yva1QMufsgaSpeeisz9fl3gXGTJE1/B43PKnVA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3PCFzcEVn3WRJlHSkuvR/L5N/MjeGmlx6QJwdp FjRcRJaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzwAKCRBM4MiGSL8RyncMD/ 9ZrSHkB55aFdLxvDa5K+Q7idSQsUEZTb8jShNg8GtNPZ6jZt+PXCPOKm0uLi24U/bTFRROCiMvD0jF lj/mFvtV5k44XZkTNlkdBowL5yEUe+88L9FqeeIqkOi0sPVVmx2FpMrfjTB05BWXQ6U8Rn8U9qCvsu 65zUwLFar5egUkR9uk6jB2rswrZhg2zQgyyeJB9Geg7FIJ2ARyoR/y7sBuxUMBfBN6DTwPEBO7oy7P fe3Yt/i3fUdZPtDRRSPvhw5WrDOFJeswdzszd5svEqofg9NqAvOSp96dwnipL1Iks038VaHk4umDlF xycwj8/FuK5ckj24OqCbKEqQiDSDwgC16CQWPsMr7916LWc8Cq3N7UPKY6c9tXXJE/sbmfgVf4Gih0 8Gah1CO6A7fMN3hdENF3zHo6TvSleaqrkqXvbEHt5ic97+e7i2zSVUkMqNajcAkdizvwzsC6cc+WDU MfuQMevlBe2Xo7iJb/1fEeqJ6tq64HEs/YqzQF0E7xJPBEUggSIVTXGKXqj6DTHyzGqXe0iL80C94R LvC1xvz7zDz9tWJgI5ViBKr0wA7xp5IqHycIGlev2lr4F+pG/RNAdR22AQl5oEi/5sLu5cAt1ex97t Dm90iwiKLgYQusfvTKWYNnhsRJVUhXn3yGl1BN0TY5m5Bth9PMK/g4k2NrZA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation of figuring out the closest program that led to the
current point in the kernel, implement a function that scans through the
stack trace and finds out the closest BPF program when walking down the
stack trace.

Special care needs to be taken to skip over kernel and BPF subprog
frames. We basically scan until we find a BPF main prog frame. The
assumption is that if a program calls into us transitively, we'll
hit it along the way. If not, we end up returning NULL.

Contextually the function will be used in places where we know the
program may have called into us.

Due to reliance on arch_bpf_stack_walk(), this function only works on
x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
arch_bpf_stack_walk as well since we call it outside bpf_throw()
context.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 -
 include/linux/bpf.h         |  1 +
 kernel/bpf/core.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..17693ee6bb1a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3791,7 +3791,6 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 	}
 	return;
 #endif
-	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4eb4f06f7219..6985e793e927 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3660,5 +3660,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 }
 
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep, const char **linep);
+struct bpf_prog *bpf_prog_find_from_stack(void);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7e7fef095bca..8d381ca9f2fa 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3252,4 +3252,30 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
 }
 
+struct walk_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct walk_stack_ctx *ctxp = cookie;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_ksym_find(ip);
+	if (!prog)
+		return true;
+	if (bpf_is_subprog(prog))
+		return true;
+	ctxp->prog = prog;
+	return false;
+}
+
+struct bpf_prog *bpf_prog_find_from_stack(void)
+{
+	struct walk_stack_ctx ctx = {};
+
+	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
+	return ctx.prog;
+}
+
 #endif
-- 
2.47.1


