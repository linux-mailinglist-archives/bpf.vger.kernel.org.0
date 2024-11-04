Return-Path: <bpf+bounces-43946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62B9BBE87
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06121F22573
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75101D5165;
	Mon,  4 Nov 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="ntCrfejz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D331D47C0
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750704; cv=none; b=mLIIAGqy5wH6GsVUtnh3QsyrzeLTxLl+83jEazK4vtT4ppxLHOGsjK16I3C/D3W31z72jEQuGGoycSuP7QvqX/HUt79D/HOzda+DIVVEij1fisJiQlwpy9Wy0xtsgV41qVElMaNvtgsABPaiLuCdYwQYwWPinBk+e4ogDAW++UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750704; c=relaxed/simple;
	bh=XIUdvSlCnzbEcy0YniPv49flYBxSP4mV/idspgIeXh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkcvXT4Nulpo86VHFjwHczrPOUMHxEh+jzHAjkB56rNbpo4n59wgbXV4Rk+awWa5eEWWbCq3zyzLaEM6iRuWfIbac0N38zc89ueg3ytvICYJt9l9DyDZv914tnI9SmOepi0XKmxmnOz7c7+Xs8YcFRrodfVfHXxIjI0hxpheejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=ntCrfejz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso5914523a12.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1730750701; x=1731355501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqXyBeqTqhNf+awLvPMY72W00ptpe9CxNn7gsTTON+g=;
        b=ntCrfejzMaIxdXYdOG0M6qCF/O1in5cjp2JWxLXouxDticBceHF7u8GyRpkOn1iVlQ
         j+uTWKz+GyubPj9Ts548uUpc3nYHe6qvjQpYahiZykHjqXfVE5ZrfMsv0zmMab4Pcg0Q
         NgeiGbrPp6kOrdmNl5OTxn5/QDBiny6PZCpadAphkW/+V2G/QI6Eg69z9GM7//pb+yhV
         1jQCISIv1uufTE0K45GfgxhG+Qfq3rYvlAeEWohkTDK/PDwWdQkK2AHH6QKP3zPvQszQ
         z+t3p6/VB0eWmOk3qXozjS5aqvOkKtCZirLSDfDKBNK8XKUOXU9I59x9/wCT5FMlSCC2
         geDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750701; x=1731355501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqXyBeqTqhNf+awLvPMY72W00ptpe9CxNn7gsTTON+g=;
        b=D0xmTaQcS/4zIeBwBc5XRENjq3lM/tktdSEJ65hvMllLpUb32/JCCxJbFe7mMrnuqw
         IBdezteq1CTe7YobQqoVwqDJJgg/Qtuvb/sk8xWxnpzziqsfgU2S6x8IUj7/A3370jyJ
         A1xiGR+5vDRIFjabXKNj9PPzKmukxBgXHDx9QCVjSIcxsiNu6eowO2dW4VVi0Q1hxN1N
         lYKGcIphMH1U4SJTqq0wpazUh3XeCiEmd1359f10xKPXwsL8NXhZpwSMsXRJFBe06Isq
         s8eUiDYC/5o0KeBBQz7jj4WneU0ylG4koyhHVq0dx0xU5Y9Bld22tbj/PDSkL3xKc1Vm
         aqLw==
X-Gm-Message-State: AOJu0YxjRc1i9SZQ336YObU/qMAj3NG8et8ZBiD/hvhoi8l5NbQfg40V
	iLnVl3+SpNwUTSsd5GpntpDoHEH63xzUCDW8YuGRuWzQDa21Q2k6gzadyZxjBApaMkZSs4rnTt1
	QRco=
X-Google-Smtp-Source: AGHT+IFfiWwMUqcQi3JT4VkZBNOmJCL/e1pON4K+ovIlwLvD1jQ9g7w8ja3e8ARtKuc2HFxLxH64nw==
X-Received: by 2002:a05:6402:3596:b0:5ce:cbce:ccbb with SMTP id 4fb4d7f45d1cf-5cecbcecfcdmr7407916a12.35.1730750700586;
        Mon, 04 Nov 2024 12:05:00 -0800 (PST)
Received: from bell.fritz.box (p200300f6af056e00c6570c15b61f00e3.dip0.t-ipconnect.de. [2003:f6:af05:6e00:c657:c15:b61f:e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a5c6sm249160a12.17.2024.11.04.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:05:00 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathias Krause <minipli@grsecurity.net>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 3/3] bpf/tests: Make staggered jump tests constant blinding compatible
Date: Mon,  4 Nov 2024 21:04:52 +0100
Message-Id: <20241104200452.2651529-4-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241104200452.2651529-1-minipli@grsecurity.net>
References: <20241104200452.2651529-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "staggered jumps" tests currently fail with constant blinding
enabled as the increased program size makes jump offsets overflow.

Fix that by decreasing the number of jumps depending on the expected
size increase caused by blinding the program.

As the test for JIT blinding makes use of bpf_jit_blinding_enabled(NULL)
and test_bpf.ko is a kernel modules, 'bpf_token_capable' and
'bpf_jit_harden' need to be exported.

Fixes: a7d2e752e520 ("bpf/tests: Add staggered JMP and JMP32 tests")
Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 kernel/bpf/core.c  |  3 +++
 kernel/bpf/token.c |  3 +++
 lib/test_bpf.c     | 19 +++++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 233ea78f8f1b..fe7eada54d4b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -570,6 +570,9 @@ int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
 long bpf_jit_limit_max __read_mostly;
+#if IS_MODULE(CONFIG_TEST_BPF)
+EXPORT_SYMBOL_GPL(bpf_jit_harden);
+#endif
 
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index dcbec1a0dfb3..aed98a958c73 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -26,6 +26,9 @@ bool bpf_token_capable(const struct bpf_token *token, int cap)
 		return false;
 	return true;
 }
+#if IS_MODULE(CONFIG_TEST_BPF)
+EXPORT_SYMBOL_GPL(bpf_token_capable);
+#endif
 
 void bpf_token_inc(struct bpf_token *token)
 {
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index c1140bab280d..3469631c0aba 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -2700,10 +2700,25 @@ static int __bpf_fill_staggered_jumps(struct bpf_test *self,
 				      u64 r1, u64 r2)
 {
 	int size = self->test[0].result - 1;
-	int len = 4 + 3 * (size + 1);
 	struct bpf_insn *insns;
-	int off, ind;
+	int len, off, ind;
 
+	/* Constant blinding triples the size of each instruction making use
+	 * of immediate values. Tweak the test to not overflow jump offsets.
+	 */
+	if (bpf_jit_blinding_enabled(NULL)) {
+		int bloat_factor = 2 * 3;
+
+		if (BPF_SRC(jmp->code) == BPF_K)
+			bloat_factor += 3;
+
+		size /= bloat_factor;
+		size &= ~1;
+
+		self->test[0].result = size + 1;
+	}
+
+	len = 4 + 3 * (size + 1);
 	insns = kmalloc_array(len, sizeof(*insns), GFP_KERNEL);
 	if (!insns)
 		return -ENOMEM;
-- 
2.30.2


