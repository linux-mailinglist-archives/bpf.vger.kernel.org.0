Return-Path: <bpf+bounces-62044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DEAF0921
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E0423157
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A31DE4FC;
	Wed,  2 Jul 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKKyGSTZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B21DDA31
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426278; cv=none; b=NxIcoFvsWhMbDbbCUFhWUx1nh7nH8iAFlLu0WnMoOMDcrHPi54jWg7z+8ydbF7hfQQ8WBFXZLzqlWI72s3V3oiUgG2CjQNvnQ50qKcZGR8+fnMqhq9+zVI6sLnlv9C7G8mfhu22h21fHH5euopNLXVdfq+OtZGPV1BH4HjviICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426278; c=relaxed/simple;
	bh=Gp9N5evBaVBCgG5QHktE/qX6HSsv2j9p68dUzNTksxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGsBCFcjcGfPNB/tbJ7HSyl0Fb1y/eGbmBUlCIbTKxM0qjpc1jc40FYUXz4aQaRuSzGvl30bc8y34pPNzsiiEznV9OWJWZ9NGzylTGtF03J5XIEDbtpK0jrZhvzZkajCFYKhkQ2YL8EbCvbLqbxJk6GGcsJtK/W0/LKMEBqSTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKKyGSTZ; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso1110049966b.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426274; x=1752031074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyDcTldV1Lj42TSvBJeZUdRq14OXgJmOizx7usTZn50=;
        b=KKKyGSTZRgfDFzmHpdwEO4Iv9SCVOKrX6nYqqPXRB25hbEaN2YA3LNebM9ZrSQEVw2
         5lZl8d7vm6j4LYAkfAECCABZv0cmBvbPexPHnZmn6Jucne03J7TncxZDF6PZ2NWDu8Hy
         QfU/X5P3BblIClsgfsI0Jge+tIrV+VseeGa7mbj43ilw8ZxON6dT8go/WUO6Jfm/bUTz
         gn3YfPWSl9PDKhojt29c9fXnbRqUcvkwaCULkwTT0wYancFmqAuP4XM/QqnwpGSadRBj
         1+njrcJqzkWeoF0per0Xc7Zh9x/VPLNzP9YUTsDWVW1zWVVG+0mfE0V41iAUu+dFXrvI
         KdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426274; x=1752031074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyDcTldV1Lj42TSvBJeZUdRq14OXgJmOizx7usTZn50=;
        b=CPyOMSbCASxK+OAp77MMLhiAC7dpEPCJBadCb64clSmZB8JwcBb3gzpdrSZjsge1U6
         ELcuTWPqj3QKHDZR+m3OB1kNZR0Tm5E0BDIjynzR5q1U5YZGXnFUNPMF5NeDiTM1fyLo
         blIiR+2+VFNIKDiw5pyL3EX6VI+BYeaKPXUxFNwhcScGLt6BsyytfiVtXn4XvaYHtwPv
         ZneDT0/sJ9zYbaDRchC7OrZoPwp2PLVnwjEKzNkvtBKoyLMCHWRS5CNY7k1Q+TkTfh+b
         D8DwABaWlB9l8rZmaTcQ5Cv2zrYCOGe4PQfe+AwnHQkqU8y0828DC15H2e3J0NQkF8cy
         59EA==
X-Gm-Message-State: AOJu0YweQpye+NtzsJHHpkuWwpSPP+ZVF7RPqPGwgyx12gttMMZQ/G9h
	Q1KJrRsaOTyWSuBJLb6O3uaBX9+3fmsGl0e2vUFRTd7wUlJY3Vx1xMkLG4PKYpaLfgE=
X-Gm-Gg: ASbGncu9mLKzPWHkIEnPUmTTDG19+gBG1FKvdsQVfDF5JqAYAuN/+/Mc6VTuKNMbQAD
	rgv91fnB914v5+dXJ9P+HolGJ3QPXP2NF0x0ioAJA/E2oztI8sOoTIh0v1p8RUst3tJVhrHYtyS
	gR7lDouifaDQM2LdGP97KX4MXV2236DP5OF3pBfiaFzgcJn8gfeb4XJfvRRnXKNYFoDklhS5fSh
	q8MOiEsxILkGs0LjsD/Bi1dxexoRlAPoi17gPZvv+LwskqN8wkmzKeHpGXQjvw7QXyFjFrCTPfK
	py8zsW0HcqrpJjyuyVCG//akyV3tZDq2srKlcAATX8yWVcNS
X-Google-Smtp-Source: AGHT+IFgAWmnafiD6K66tvFfRitcQ2WOzMKzeHTzeCUWJu4Q+JuX+xfKowtYhzEY48KcD/eCk8JLNQ==
X-Received: by 2002:a17:907:7b91:b0:ae0:a465:1c20 with SMTP id a640c23a62f3a-ae3c3972607mr78538566b.14.1751426274013;
        Tue, 01 Jul 2025 20:17:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca20absm994097666b.173.2025.07.01.20.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/12] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
Date: Tue,  1 Jul 2025 20:17:33 -0700
Message-ID: <20250702031737.407548-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; h=from:subject; bh=Gp9N5evBaVBCgG5QHktE/qX6HSsv2j9p68dUzNTksxM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFRH5LnjFBUl/YTCa4zYeyhv8RqisWwVI8lyB0B 399gT+KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUQAKCRBM4MiGSL8RyhH1EA CN0E8mbJBRLdRd5zXuVcFB5Z2iT2ofXr9VKGheKolOxSdQkpwJBghDaClkDF4UV8SaGtYxTng8/H0c yzRfj+WlKATJ1hPGtwTyZGZG1rpx5QH7WsFlNBcn8vYkU/7duKA8geIr31zO1hSuO0aWvA0A1U3tDU Fh/PdXaspVYg9JqRVs7ndCJf4majcEg5Zd+eujyyx8V8bTyE3w7A1o5aLjQcBITmb6zCxVyB8qyVdn qbRWrGZgeOKbvPNI4PJ5l6fZ6YWzUlA9TUQtHUyNOBhCUaojiEAC/JE1wYGS89+DJoQOud+yXJIjvr 0Vkxw4N0nAT9ZSEqvO+PgYUYryQMQL2dC6DMUXa6Rd2WZtYTkF1cdMYpLbwkgB1jnjI3Z6V/+JoSJM nQRiAs+dWKu2uz7LrBudaITGf0ewsg0yMZ+qMch0YgUlKQyA/i/om4jVxhWjusaRCKVA2FaAH532lk wKke5/q/SxcE/dCc6sQFncYQ4fydB7r/UsWjwt6SNBpFx0NR9c/QcR0ImGEB2e5rLlAGJMpfsIoikT vWpSLP+ixzqCK4/hjAxt6P3ocP4YJUvBO/mX450Dnli/4/TNSbvf6cfNRfyIuul0Fd4Wh11uGcNiTf Q7lrLcrFh4CfPK1oLj2U6QawwJPWi8RetXaHjHzONXQXO+G38ay+PBD5gAyg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting rqspinlock deadlocks and timeout to BPF program's
stderr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 338305c8852c..5ab354d55d82 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -666,6 +666,27 @@ EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
 
 __bpf_kfunc_start_defs();
 
+static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
+		bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
+		bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
+		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
+			bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
+#define REPORT_STR(ret) ({ (ret) == -ETIMEDOUT ? "Timeout detected" : "AA or ABBA deadlock detected"; })
+
 __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 {
 	int ret;
@@ -676,6 +697,7 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
 	if (unlikely(ret)) {
+		bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), lock, false);
 		preempt_enable();
 		return ret;
 	}
@@ -698,6 +720,7 @@ __bpf_kfunc int bpf_res_spin_lock_irqsave(struct bpf_res_spin_lock *lock, unsign
 	local_irq_save(flags);
 	ret = res_spin_lock((rqspinlock_t *)lock);
 	if (unlikely(ret)) {
+		bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), lock, true);
 		local_irq_restore(flags);
 		preempt_enable();
 		return ret;
-- 
2.47.1


