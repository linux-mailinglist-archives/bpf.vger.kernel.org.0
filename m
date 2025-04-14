Return-Path: <bpf+bounces-55880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0345A8883E
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C7B3ADCB2
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2FA2820CD;
	Mon, 14 Apr 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHovFzpv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495427FD64
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647301; cv=none; b=GiLoGz7iBl6V4hrmKtZrwQWm8zHgEV7fJuX88gD7jGlkLGsRNKp1+cBQgE8lOWs9jUygizeDuGM4c10FaA9mqu6gGoMwWr8KUQrhwF0XkccLv0r3KXAVZl+gUngigBdUk/CwcQBUh3kCzYxoYwLz3N7OUP2oYagzIwE612f3wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647301; c=relaxed/simple;
	bh=r9IlNn09wDdNYpBtkslzut7UxM8MXdZVEnEJIg6hPaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKzJdJx6DFcObulxDGl8MHQQcOr6+PKBJrnNRnGLyiJgb4qthIi5+1k9MzmA4Y/xgMiTv0304/tDcp0lGoS+OoK/lyTvd/r0Axlwj8ZVU926m2Au5B+97mUf+9oKcnLXIJbOiaJC3ByUh8J45yX3+GskWs2dzWycL2qKncq7HqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHovFzpv; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39d83782ef6so3606958f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647298; x=1745252098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hgz608hMLKWLFEseHlIoEvyBWI+cUXEg7GXnoXAwp8=;
        b=RHovFzpvQgraRHqoyrQHoTj7aldML13BPtd9oBV3fvicekEhH9kj4mLP1ieyAgb0Ou
         3GvvECJ3OqkyicRa3YVOLia33lIHCnlGgapH0oPnd9rmICIa7prUuS2ZWHMQ3MBlfUuj
         oIggDyvwo1Alol/xuU9buc0HT3fAz43jN0fuMHc91FP9ERaxxOgJ95/lbNQSmXeAObYd
         5CCSJxTE6LCsR50Ade52bgpYF+IjRWl9CkYxym09IPlsFBQYGCOimOvtOEmSio/9TWRk
         vCDEKq1DTKb4zJwD3amszWsqynUWZEVo4iKTGkEakxIBP0VMUAUHcTYc+0a08+NCv14v
         d8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647298; x=1745252098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hgz608hMLKWLFEseHlIoEvyBWI+cUXEg7GXnoXAwp8=;
        b=E+mpSbHAC6Jc68zkhkwPEdD6r8cmoDXY254C+G7A4JDRwinpuEcvaUR5vCbHIyz2Zc
         Xywl40Cwdv9/pDns9b3FDi7F4k23ZYFQia1aBtTQHSQ3Kvnf8q99n5AEYB3sZLwJsVfy
         EuCPPTFKBFxe4NLFYy/g5UJPEP87os/akSsOPp76tMeSwqPUEQHE+aYHmWajtlNm+X6A
         yZJasraawmQcP1AHeikk8/VISkxoJBFMNV7rnGaywGh09F0HJMhZTUz7LKhvVISqZkYn
         8iH/LNRos5zh1VPdwnOsp4q/X6b/EhogCIRssbngj0pgEbMX6N96QlrryRSEabHdl0aK
         plSA==
X-Gm-Message-State: AOJu0YwoqAa0Z+PzOB7Vk9XTZhAK5UvdCO5pb05Dnge11F+qleUmQ7xs
	Yk05S4yiozVs5CK4tCMJI3uNxG5tS0XDXbtnPNbSuMwtWt8FFujphQQ+OtzautQ=
X-Gm-Gg: ASbGnct2xlXS6T1P3XRu+G67nX50VwAcYyOChJpspqTRXT3fyDLuFfELJ0sfaNjsqI6
	n8PuBnORCDyZeKo24X2jVXsplS68RGMLlz8/zbtLR/G8Na+qdFjmYyD3lUYexjdY8eckkHFJ/Ik
	LpAA4HHA/JEb42sDM/J1m/5Bsw+OTTF4S/A9b8ZZWwnXrROaKbWKkPoA5SYl1m8woyQJ9+RoiDA
	jxQwsQWjgmgaUhvI+56+fqjEsui6ec9gBsj3w2CLPR7d5CNPMfoeYJMQyA7jOciTiNfZEFyC0NX
	rIGCFBOzdXfTshAm94/FTqYUSO4YNw==
X-Google-Smtp-Source: AGHT+IE312bBMhU/kjcJxBZILGa3/1BnZmzaCRXtij0TVgdrriSeaNCyyVFJmfMklfZGnexuKA0ewQ==
X-Received: by 2002:a5d:59ad:0:b0:391:21e2:ec3b with SMTP id ffacd0b85a97d-39e6e45d55dmr9187698f8f.3.1744647297837;
        Mon, 14 Apr 2025 09:14:57 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977fc8sm11273661f8f.48.2025.04.14.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 10/13] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
Date: Mon, 14 Apr 2025 09:14:40 -0700
Message-ID: <20250414161443.1146103-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; h=from:subject; bh=r9IlNn09wDdNYpBtkslzut7UxM8MXdZVEnEJIg6hPaM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOKnaNgoqAE6sVQags3I9f8/zAf4BNP7unHypD8 5BeoeS2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0zigAKCRBM4MiGSL8RykKHEA CsoYbyOP/8nlOz0iQKXFLUOS2cwFxNNAmYX9NYzc6FAM+UPQ6hGtvpSihytk2M0vWrFNpWXAAbPgPC qXqJSeL1u1lqru+TlCWdhzThkECPe5agf3IzVt/bddgh47K516vCe24Zd+10A5b9iWZEaXJxrvGY/k i15vQRJEAFiSWW2DrVT//oKrLVdgSIu5uLqcfKsi8lstP86BkDXUDUrO1O/dXWJN27MonkNdkP9k7K ZplAlUlXCLY+c627w5uxFQDfOqwykIWIa8TRfGWW7aWWjFl3PPQyCb4tJeHTYH/vYhnWVJ0SKf5reg ikvo+ZyJ13GWRg7/API77IYRJfZt4zxnc/5ZrYp2FM40dshoQw7eS/qZRnMPBte7Hjt2mWUYqZ5tZ+ 0u1kn5VIyTVyXioYXuy9jcv0xbFVO1ir94DB+jc8Vx3lt4dcBhRaElLH26ZTGliA/bRYKIQJKYrt0w pIagljWyB/d3xiweAQNa8GP+AIME7F4dcs63R0iL0P7U8JVk9SljIlLk1qVb6i/zpe/1XD3nq8QlxS Br/yAZHFn699sUUbQUQjK8WHgEbc8Op2Yfr0yyISlk6GTsKir82WT46gPjdkdCld9zqnBRRAzjc5qS i+kwl4q/hUfyzzo3ryff0EPHl5NgDweafHgkWY1ZAhjeq+IHpi1V4euZkppQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting rqspinlock deadlocks and timeout to BPF program's
stderr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index b896c4a75a5c..7cf6bd8e4f78 100644
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
+	if (atomic_long_fetch_add(1, &prog->aux->error_count) >= BPF_PROG_ERROR_COUNT_MAX)
+		return;
+	bpf_prog_stderr_printk(prog, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
+	bpf_prog_stderr_printk(prog, "Attempted lock   = 0x%px\n", lock);
+	bpf_prog_stderr_printk(prog, "Total held locks = %d\n", rqh->cnt);
+	for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
+		bpf_prog_stderr_printk(prog, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+	bpf_prog_stderr_dump_stack(prog);
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


