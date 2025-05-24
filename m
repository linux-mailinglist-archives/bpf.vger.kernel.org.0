Return-Path: <bpf+bounces-58882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA4AC2CDD
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256051BC7DEB
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3F1E1E13;
	Sat, 24 May 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrlW9k81"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8319DFA7
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049543; cv=none; b=G1MTcqhnR0VqtAYo1/+e6+bB2JuOGIFysh0Aa3w8PW8VtnjGgzRUFYYrwc0GFESIdk98zS483RDiHt7iZBGTnlHVD0twON5b/GwVamuANKoI5B+ghiSqpXg9OGFIPdVPsuhpMGitBTsbMpkjAEA3jPp89+BaG6oLtniWNNYnzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049543; c=relaxed/simple;
	bh=wSRaX8acuUEfv5DpSh1axk9fQZNPA17hfl7LY0eZLWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmQ3rNQrXfZZEKS4k8h0m0FfEYF8WaFZVqQeh7K71FlroxkkrSeQn2HNPaY9X/SWZLKVCaJVynOQsJWc7SHC9AWhuoTvSJLmRAj+B1AO3+xb/LhRNBVxkwWcPxKCXuHYZXJ9BYDCX07ecQHm2wNVNh6YbUllPY6wKj/HNQWQavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrlW9k81; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so395433f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049539; x=1748654339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSx4ax8t9jkQjP3ygZFfKfpLKGK7b22nNpBj72Yehi0=;
        b=RrlW9k81sTUBD3gmYX11NfXGu6ne6vvw3rwy9/dYsq6t42o5hRF1BXsMZmPzuFfU3b
         3dMZSQtbjI/7G4wBqdB4lf7VJ6LWsQsbd3nFdt6qoN4EgLVoWvOrRwHWd4cVPgzno543
         NIC/t93WZ/CZ9RmD+eSh2B0cHtnBSkqqvoLoHSXX3JluFUSEwkApxjpwB46lAnNqTEh0
         Jxy9Z4tRcc3QaXQ5pvd5pGriTg8ZASkBJ0OJnB4Ge/mRTxDjKeHRzPwNilj9w0nIDkXf
         jQ9WVn8h33RHB1cIai6cPpOGEp6Qx++G0q/jkhoaFIbPMJwLe0tWLIiRUflvU1YA2DZg
         VdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049539; x=1748654339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSx4ax8t9jkQjP3ygZFfKfpLKGK7b22nNpBj72Yehi0=;
        b=RivOf7mfekSPX06LKwZfQKUSs9/aEwI5gQ1+Cq06YzrNNHP8azcEAztR1nhb9RGUwl
         wKC4jDpS9tcK2f0wFMWbeSmer4GMViGkGXAIhZzrBVJta9zcOgz9fD/a12RnoNZstBAx
         ZcwxG78SKzBTwPLMHkSLacdZnz1GT4F8SzXwm3FLDf/Lb9zTNoLp+NsobYMDtCZuf6Qf
         /ecu0hV8aKbm4bVXSLJlb2kP2W2ibWxlxD+JYF51mlICeiQpyxVqGo0RaCYX4QTrjx64
         QhL03MWugs15WYIjO+UaaXAhGfhVX/CTQMjmKMFjRm+9Fx7SYx265Q/mK/B3G+lTX0oZ
         PZ7A==
X-Gm-Message-State: AOJu0YxfZuf6rJ7QF/+0QrDjD7ChsMDiS0eeynhQpPFwDMGLHMv/eWm2
	DmyQQrzO7V4ezQvU+lXPJxJbG4iRIeRbsBwrAOHQIEfgVVpOXSDSdaoZrZ87WbhyHOY=
X-Gm-Gg: ASbGnctXgM8NQ9wDV5gWH8jgpEqhM5G+Xsgxtw5Jy5i9h1Ox1DygdHDq06jNJXMDsyi
	9cxgDfXKOiw/bAQPtSt6IGUYgkhjFVQOyG6SpasVJNocCGOZSyYyKN5fl286LIdqAF9+8StwyCo
	Sy7H8H2PPNQPbnwPKNlu8z84uXzQlxzhYpFw8V02cRNjGQfnUF4xM5fvHbpy6115e/GhqqweTNr
	TMGwHt6s7rJVZTI/8MSeXeByNjONyAoEBWJQsPrFRfkHwGR0lq1nRVeVr5zgJXIhVlvYVzhST6/
	YV9gy+GLmmnIxCghjcFm9s/gcOPsm+UOmA6b0tvqaQ==
X-Google-Smtp-Source: AGHT+IFSr/ua8I4icBAtzTi6JPSZIoNFbZOBvHvw9rtaJxkrVt5aIKBWWQI38o1Rwp8i2yV9mJvlLg==
X-Received: by 2002:a05:6000:2313:b0:3a2:202:fd93 with SMTP id ffacd0b85a97d-3a4cb455561mr876969f8f.29.1748049539320;
        Fri, 23 May 2025 18:18:59 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:57::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8d005sm28945465f8f.90.2025.05.23.18.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/11] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
Date: Fri, 23 May 2025 18:18:45 -0700
Message-ID: <20250524011849.681425-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; h=from:subject; bh=wSRaX8acuUEfv5DpSh1axk9fQZNPA17hfl7LY0eZLWc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3PQhUakXlKEsMntfYNNnIeeBMDjYUl6FCAzYJE 0QlgHwSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzwAKCRBM4MiGSL8Rylt4EA CAjWFz8PqgA4EN1gNvvkrYaSTQje4OKg8vKCTmuw7UQm42SIcD+tWSNLVAht05+1AvKJiUPcZ6nHPY 9WGumacB3BqAo9h0K7hfQxS8k1kpo90tnzWXlqMVSC6zNFy5TWgHsMOr21DIWwEWcB2u+n9Qa81J6A 0BFxJxoVc8TDqxSHTdkvG21GgW7uxFISEz/sKK+rjWhe5B6i5Y06fmPiEg1fjX7Mbi1SugYSPb6vL6 jLG8w3rsz3aPu8ZbZfbFsaDefuLGU65XX7GqwQBsHm78yCZDveFhpyIMov9uSkpmWI/JrTcZ/Ut77v TdJKDnynkTmvCjJ8Ai6TFirXFd852qCcNaBb/BYwSlsy9AVKs8ug+JcuzWs/uqFQEdx2z/P3UceGnr sXzixsHFTvXSUESboNl3O6XPsuHCml2D1ifxBhzeDW/4mfWieVit4UGzwWg/idHdHAtuHG1eOlwLv9 3pUoNbtZiO+Niy9CTxUSgaXmqUjb4Tw/eyNZmAU23RPlgzPz/Up9kwd8f0oKvN6mTTxKbn0gczg1Q6 0wQxeZA5Eq+W8aTvHkpNGfFlfKNQgV+i4v+QhiWVsimvmezA0yltvLNv/Swg2bceJF1FwBCkWmUfCW 4+Nx4xjz7YQRVux1XuL/j0SK8T/F+LtkIvds59TTQTvQgsF2HuVW82mug1TA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting rqspinlock deadlocks and timeout to BPF program's
stderr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 338305c8852c..888c8e2f9061 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -666,6 +666,26 @@ EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
 
 __bpf_kfunc_start_defs();
 
+static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(prog, BPF_STDERR, ({
+		bpf_stream_printk("ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
+		bpf_stream_printk("Attempted lock   = 0x%px\n", lock);
+		bpf_stream_printk("Total held locks = %d\n", rqh->cnt);
+		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
+			bpf_stream_printk("Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+		bpf_stream_dump_stack();
+	}));
+}
+
+#define REPORT_STR(ret) ({ (ret) == -ETIMEDOUT ? "Timeout detected" : "AA or ABBA deadlock detected"; })
+
 __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 {
 	int ret;
@@ -676,6 +696,7 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
 	if (unlikely(ret)) {
+		bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), lock, false);
 		preempt_enable();
 		return ret;
 	}
@@ -698,6 +719,7 @@ __bpf_kfunc int bpf_res_spin_lock_irqsave(struct bpf_res_spin_lock *lock, unsign
 	local_irq_save(flags);
 	ret = res_spin_lock((rqspinlock_t *)lock);
 	if (unlikely(ret)) {
+		bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), lock, true);
 		local_irq_restore(flags);
 		preempt_enable();
 		return ret;
-- 
2.47.1


