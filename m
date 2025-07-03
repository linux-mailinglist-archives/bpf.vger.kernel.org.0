Return-Path: <bpf+bounces-62338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BEEAF8219
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DAC4A8290
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EFF2BE7C6;
	Thu,  3 Jul 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFqxNqDH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CD2BE7A7
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575718; cv=none; b=azVAnNXE9b84nCpfJ+bsNVBmfQcfqcD34TwO9/zK8kkhLWxRzbTGwMgt8IM8OHxma5A5miDm2G3X11u57IQpASVmlafGgB9PVE4RYJi6l4SiuFNpfILT+A2CVEsQzVWPq9DRxncyW5EpgimcNAnDA1rfjcciCU1kOMcNydyUCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575718; c=relaxed/simple;
	bh=luDkJ5JCm77sLDhMzbddK7T3ks3tztn4nYuDbC9CsGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+vHQ5Rl5hp1aN708NDz++SGPfyv0d1X44IuRbUqYUJkrQHqRf4Y4doI6a9ASkEBlcis5sUAeFTEJNzS7ib8EoADOB+KI4fDevFxuDHmjAFwxfGGIhkg4jLB5Eadc3G36AT9teITClMLai0CfAnWuqicfGpjYrbxOZ8iutIPbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFqxNqDH; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae361e8ec32so60181766b.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575715; x=1752180515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2DDJwuKzHTHNnRlfFgVsD84DQNMtL14SVQw95efBCI=;
        b=cFqxNqDHJH0eUKy6qYV3RM779RlVh5I+OThomHUYwI3Mqdva4tGFnkHIVtLurKNFS0
         ry5PPMIT0CL3rATJBx+RJRBXVaYngyHFVUZaFJoyq3j3LIrN0gNPfHWXafSrK0AS9LVd
         oXSc350REzaXEGU6QJe98C7t/zNNFIbtsyrpP15EZ8u1WC7qxNl2U/JhacqUgFTkFCkv
         y2VK8BhKu9FHZQpjgUVnUwVJVmxeRFS+4bpGBMfGlfzjM/GotHBzo6ZV//1f1RgZMmyT
         u3EMwxKDKjVRqYBVkG/pKQ/CfJaWOcgzsLm5nU7GHYV6jH8Onb/eRsZaBjQIsfTdfdl1
         tSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575715; x=1752180515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2DDJwuKzHTHNnRlfFgVsD84DQNMtL14SVQw95efBCI=;
        b=wq0ioY7GfjIqVMK8Q6LTQgvIvsz1GATcz9zZjUOnSh0Dt1gEO88+yvraT+JBDz65hD
         JccYeZpNSk6Wxwo0UAbBmq7DHgiNe+JWcMFTOv+8cUaGsiZXeXAlG0diXnDDQ+yZl/2e
         GJUEKd0GwH15MgFHB8biggGLg19q9eqh6/EjFKgNK74aOqAc+cbUPQlMosqVP7bPo6oW
         q1jwvbixoMXJ2Vo2R56DW4D+Qr3jn21cxcEEmeAbyCOYg7lrjFGPYlfN9R51xZh+tRrg
         R/rThE1NMK9zkB1cQZoVHFVpQsp5pZiQPVpWZHQMH1HIGsPBsQ8RbvOp7gRlUdm2Gy41
         udAw==
X-Gm-Message-State: AOJu0YwHIax8ZyNDL6qnChMChG7hFdIh/5p4x2rGAk4HWW3hNiMoYvtC
	qokm6xh11iaC8racIhDxkmel15EyRnfImFjBKdHYN/iTT+7WrNlc0BQXG1sZHTlFkUQ=
X-Gm-Gg: ASbGncsh/wEMnRWqfwgRvXXXD7FdMInu5yG9YVPNYUaYBmVKhDrIGC1rts0qdnrERGE
	C9jedAbokXUd5KLMYxfhdEG2kbVn4lyi2MB1CmzfzDVy2cR/CaewIEN7LnZ+lbuE95lPGJ/02Dy
	9gsRbSzkee/k+359aPu4XkQCeMpE8ggbJt6kKymgqRkiOgJ+cqCUegQIbsLvePTLCgF599ArHnA
	2XUp/zeRh13jQDgCETz78Z2PGvxPdJKpQdrgcUCg1xjzEBSCPXClXzCREZmzxxmCs7gUkGWT7sF
	uh8UH5/yOr1FGzvc4qQ2ulbPHMdCDPOWkoOwdl7bKFd9S21fTBDI
X-Google-Smtp-Source: AGHT+IFbOOkx8jwPv/g5uPlja780lARtb0HaAM0kx3UDJg17yGCIIlVhlCUNTMR2rlud9mtn/xMR7g==
X-Received: by 2002:a17:907:d89:b0:ae0:b7c8:d735 with SMTP id a640c23a62f3a-ae3d8cf0f2cmr467957266b.42.1751575714901;
        Thu, 03 Jul 2025 13:48:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02788sm37612366b.113.2025.07.03.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 08/12] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
Date: Thu,  3 Jul 2025 13:48:14 -0700
Message-ID: <20250703204818.925464-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; h=from:subject; bh=luDkJ5JCm77sLDhMzbddK7T3ks3tztn4nYuDbC9CsGs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudMvqxNY2SWaTG61qnufPwtwflTNgAv52Mb+mPP 6qHv2FmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnTAAKCRBM4MiGSL8Rygd9D/ 9JLpvLGtt1wAkUzj6LSYNblrXsj0XV9c0wHnFs4ZJv6Ge2hO9TUG+zacE2hiKzlZqrLv/8RoEWuY7J oe68Ctdo7aPxwlDriIXCBs64JONcvv0wICetBcMHtFI94M89jdvXRY6axT1T6cw5IHos+pFooUBsof ctNW9yYdWFTTGH3M5DcAoLykbFqAFDqX4vG8Vy4VnHXwU0xf/MEEUnWIC4YD1B/z8eDrU7fJsTZj9m AS3V7UI3w1XEbctBJRsqNLsRSktuLC75NEjlwy9iqr88sE302BmX/Fk5UWyh608TLaTkZjXH73hwdc yxPwyDYv9HFcUA+gkjfX5xKjCrwKEtAh1q3BB7b2A1LEzqgluYwW2iHvn+7o34i5Vf/nrl+fRCAGhJ 7DnFzy/P/qmKpJHPl8JgJu5I/L87chMCNdDrvTbIprleO8a399D0qPdm4ecI+2R2as+SeGviceCi16 gZP8RRGSdVX9l/2sdJCWfssep/qCjL9Lygjqobv0rc+KdFLmxdKKTi21Unm6X3NAy7efFQQJN9bmT6 /57Y0SgO+twZFlPuqAnfSVOBMUKMu22zdLVSa6ZQ/gKD3Zij0AXbjvtyBfOw7vNSCpQqMcoXnFH272 cX1/MeWPRHPSmcd6BuHSjNMKmwgeuokg2OZCHZQj275g425aNf8lmLbSv1Kg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting rqspinlock deadlocks and timeout to BPF program's
stderr.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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


