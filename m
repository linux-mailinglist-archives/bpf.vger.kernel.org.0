Return-Path: <bpf+bounces-57679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12474AAE796
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3241C01D9B
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F4328C5DB;
	Wed,  7 May 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVZyFeHy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9428B509
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638256; cv=none; b=nOzOG6zkcdmWq3lKsdGMN87L2v9BFMCQSsT2I0nnegcKccekzeTgcmSQSejijb5yx8eSzzIXORyjtg+KHeAgR1HuX0M+nY2yrir9pLtHqryY41c0fNWnrMdEysoT5qXRnM/P963Vw/1yxK0uKwHfa3LLYF3xZCUTDiMt4RiBepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638256; c=relaxed/simple;
	bh=wSRaX8acuUEfv5DpSh1axk9fQZNPA17hfl7LY0eZLWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+NgGUJ3IKaBxUl5eYcIoPP+HXDXYhcgbWF5YsiTVhjwewnF5askT43JyWZH1yJwAHQv66wdEGCE0x1ADq0XRLxh/ny7sJU2dcQrvNIQ92S+sPuQyfQGIdwUCB3AU2xkx7whKiyrLlAg3G0J74FJNCkZ8T2IM0p38ovUnmrzfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVZyFeHy; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so854715e9.1
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638252; x=1747243052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSx4ax8t9jkQjP3ygZFfKfpLKGK7b22nNpBj72Yehi0=;
        b=XVZyFeHyq7DzOSmSRXN7BEb+A6P7eCUfTqtyhA1SHdWYLm+bW5m2lUnO7KdvxmsmZn
         GkwfMiBJsgkLR39Z1helKfoxG3AT4hZcU6xm02WcMTm/XovGj/PGDZZ1grxov/O3N7nF
         6bQYu2ZBiAV/SYMVQr6+aJ+rZ4cJhricfz3izdfK8nDLG+XiUbiLBColiODIvuqa079N
         9gLznn77/xoJYEOeR4ngxB87QLVju2U5iNTnXQugqxy+fPi6M66WbxrnZ9hD76iSA1M+
         Qt/kEZg9f6sqayGkjJeQmtzfjmiQEP3yqgMmMld9cPTuFgKd43CC0GFcVwkk31u6F4Hu
         d7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638252; x=1747243052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSx4ax8t9jkQjP3ygZFfKfpLKGK7b22nNpBj72Yehi0=;
        b=uJ2b1wU1r3Zt6KKTnHdzqdBizmoiAWDsFyyJhaW6CcBy/lNw3CbrKUhjuxdjASIH44
         n/eiJf58uT+kB3lxsZ3BPigC7ggmNgQloWp7Luy5pr24fjndDIUFqFYiGxmoFm+csT75
         VSCeKe2d8HijANn9R0ziF+Cx0Er/hH/HCuGDIG+ZVZlorIL9W+RYizLIFbS2lqOwkqTu
         GzrVGxgqFarSR/0qidjgnIiLMz6+n2qnDKHh3ZNEG/wq0UgTG1YEIOfE//UK1b4ODhfF
         +2LR9mbQCPFkDKvMqzaDwyTTslj2mJ3XxKCl7bJqfX7AsaaDyBz6fmmR7/KudRHW2l9n
         UyQA==
X-Gm-Message-State: AOJu0Yx2dY9DtDJdWpqTRl04NnMNjV8amLHQlTTWUbrB69+KsJQhA/Tu
	cqen2DhfIB6oBmVYCtMJDzLuumWgzAUsFm3Je1Ic633uEr4HS1sl2cc5l9AR0sk=
X-Gm-Gg: ASbGncu4gUHPVvQkg2jIMC2o8Ze+X0HIhYdc/JRgvzuxQlgcTPLQ7VPMTGtdswi0BGm
	9O96jsZNPmddy81C/qR3huHRBc6qZxEEd4WCChPqTfeVQ8pqKnA6RhzznS857GRsswqU5Lbigdw
	S9JgSGMuoswDOQrrJu/IexosT8+nHARrYE2vnRCLvar+usy6rLaiEk0ZPXBQU6T5XxtJU+y/AEn
	ivwNiuLB60QP4aR7FAc+8vSRVksAKO5mSie2osnpH1Bwe/lgEcxyb1n/V8h0Dba9rCeSoDIMckW
	ZjVqBsZZbTFjsH4pHgtsH/FdzbhzTes=
X-Google-Smtp-Source: AGHT+IFegEuIxXbEgAlMp7xwEt9UzJRojyPUiDqhDymel+dKLP1IPoB3kpjJxHCQKTzZn+6smQodsg==
X-Received: by 2002:a05:600c:3844:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-442d02ed387mr2624115e9.11.1746638251936;
        Wed, 07 May 2025 10:17:31 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b55d2a1dsm3046763f8f.11.2025.05.07.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 07/11] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
Date: Wed,  7 May 2025 10:17:16 -0700
Message-ID: <20250507171720.1958296-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; h=from:subject; bh=wSRaX8acuUEfv5DpSh1axk9fQZNPA17hfl7LY0eZLWc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WKQhUakXlKEsMntfYNNnIeeBMDjYUl6FCAzYJE 0QlgHwSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuVigAKCRBM4MiGSL8Ryoa/EA CzDh4oh9fMfzW9nrXfW2OBKdxXa5mDHihEgxGQXG4dOz5mvCOD2cA6H5Z/qKOsRf0kcpEycOx8MGVv +RGD3XmVG7SvjgxxvRPC5lPxsGXuypYnXIr9XYiGZ6RNbxwE9sVFVL3eoCaRGp9NnWdwdpby4tYefv iqckX9GkxHWgdxBgMoyzHN9Fhc3uP4AARcf5DQD8mdF+z5eOjHRk/tzeovziIXLo+bXfJ0O4cihQSC AGnhbyq2iWq2+xDmmenSMxHyI7glndMGvkIEO1y0DwmkniRBKEqSaR1aear20S46Cm0UgvBfcC2sjf rHmuv+LyAZKcB2ENXJ3V2dQi9DXGpQ/ohQNPnXmFCnaokSdywxfGLdxWv78C/c78a9acNau4TIL6sL pfq5eJHLXdBb45rqL8APwvyMdj1jc2yjX3G3JlJVN49ZIgwzXz5sUpL/hoD9ya9vOGuYSR0KSoEtVU zFptdqtCwhHeH6hK7LEucr//s2KoCbJiiFyQ1+ywVYM3P0gprQFWSmZ8Qlf+97YuwtEsY/FO+qsMv9 Wd+HpnHGsqLr3psSW8cjikn70OmRu8azUy+jdoL74CqlhWkKO/zJoMbFsb8U/0XRMNTwY01Irc50pj 5mo/1087rjbEuazfH1GUD45EpdKW0964XxPjpPDfcdLNnSl2MK7C9rs/HWWQ==
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


