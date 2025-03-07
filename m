Return-Path: <bpf+bounces-53534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53694A55F49
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B398C1891C87
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DCF1925AC;
	Fri,  7 Mar 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VWuAe+Oc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768B18DF86
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321066; cv=none; b=HOD3ZpibaEMN//jJIjvZBN3TD0ElhZ2JVB6wWpTGeMl7Q23YKeHyeVuaBZ1syarX7sCBJou1OUy/LHcWvBQPt8S1An1f1MXIoGFITD65ieBV3QJ3h4A9ji73EMcGkfRBLDbavfg6EvtZt/2s3BmovkVkQX40/MXEPoEuPNovoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321066; c=relaxed/simple;
	bh=pffXZtsvnmipo8zxunVckuQSInHRDVZnsOQw0ZSXVIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFXdVNkJFhAx8AMkN3T4sJQ2bpqZ6X7zm1syPNaJxjQfHxw26OvmqxcJb5UvpCPVUlnyOilFOMrjjKZuLgFH9wPMZrhqxVmDYPHppx+G5kITTHNwi7LeRBNa81U/Jp8B8uKf0sxw73jY7vp98f+brL5BZhIR9HFbwrA7XI6rGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VWuAe+Oc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3ca86e8c3so98506285a.1
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 20:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741321063; x=1741925863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOjHJ/XEu8gnFlKw6M/pi/0WwNdhD20bEIw+Ix+DTXM=;
        b=VWuAe+OcFJr28ZbnzruBbeMawbeDNAiupFvoSji3H+DRvsEjRsPdH6L2s3MlbSAjbd
         KMPhHL3+xtBySfPa1yrMBdQ7KMLD/LHQD8NQo7UTPSEPQ0eGZD7qf9AY5LKXsiKn9ty2
         nsNztZAcIKNHy0Z39dwDrfuw4KLGyZO0GLugNSqTliZtaRI/M9caqsZ3zCNGwKe+YGU6
         tv7TowIMm8cbxzHzjdM/qXZMqUYk96R9HwI5TxAfqFFc8ZDkDHZC8RFuyWMThJKaCCno
         ZcRp7LGLpQ6OGUS70FkIUxj76nfkkhsXjfJteC3E6M+HztER9FkclD5AaSZ17GCyBNnC
         PpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741321063; x=1741925863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOjHJ/XEu8gnFlKw6M/pi/0WwNdhD20bEIw+Ix+DTXM=;
        b=YdFbKvDqVO8J+IrvCWVRYpjIQ8/eId3QaEA1PZvHzXSZ8VbC4TamealuCxhLApC9rW
         0+t7cmRjbNJUe0GJdDePcd4T0MFqnAIxQWMnFi1gVBVrcvMttomXUuQ9gCdLTtD94nW8
         RYgUJcOp3Iy9YT9TNokZ8Tug8fTAipI8YdC8836Ok+d3pHr0Gi0mikgX7HQLOVNC31fS
         GPXISvPMoKnw0uK4gBQ6cE8XLNNIsSfq59m6Edkt9zMIw3+ioBdmEiEMLqmb2hUzhu15
         tIJV1zIZ5lsFfvP/OOi/J7DSpgOV9Wos92GIhfRWTxr4bcX2K7XxhX/RZorT/Er5DX/q
         zzSA==
X-Gm-Message-State: AOJu0Yyl1nFI7kiKSdYb5k+lYRSMGd8817csGKKQi41ri7Tv6HDHzMtA
	FaefMjpiIl4HpH42r0xyzCuBIf/SRcX4fcOYBHVelkbIL2sXbEk9cHlCsVOsC3tXWB0WbYxz2Jq
	YNIkz6A==
X-Gm-Gg: ASbGnct8t2UKY1G500/5hj0kexDygTWzmCxvedKEmkMZNCtf2g5vOuF33l5TO2hbmVc
	+735OtH0w8xzaEQoag3ueDBlDGLYeCYg3hBycUbirei9+USXs2DA+yB3uiw4m3P9CX/8qYLB4ZS
	XtYnnSFBskpQSyT1TozBxYWvtqR6/ulu+W6lp7ICiVWfqfAcpwCx6FGcS6Er8Oqp0cDvcup+dNR
	WSnt9BYQXklR9IOG2Vp4TNAbD+BtcXV29WcOIoM1YMoNar/QdK0XeC5hZZi1dIrWZ0OyaKdNAPm
	evGG8m70ifvFwYAOvAo2CqIjiE5n5O9H59qYpGGj2Q==
X-Google-Smtp-Source: AGHT+IEXrYZY523Nu1GWO26r3Rz5yymxhU1g54usZ9bHZKUCJJ85RoLf1D25CLbaV3CGDemboIsZTg==
X-Received: by 2002:a05:620a:4885:b0:7c3:d314:7238 with SMTP id af79cd13be357-7c4e61a0c12mr300898285a.49.1741321063354;
        Thu, 06 Mar 2025 20:17:43 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534ba85sm186108085a.28.2025.03.06.20.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:17:43 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v5 3/4] bpf: fix missing kdoc string fields in cpumask.c
Date: Thu,  6 Mar 2025 23:17:37 -0500
Message-ID: <20250307041738.6665-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307041738.6665-1-emil@etsalapatis.com>
References: <20250307041738.6665-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bpf_cpumask-related kfuncs have kdoc strings that are missing
return values. Add a the missing descriptions for the return values.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/cpumask.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 77900cbbbd75..9876c5fe6c2a 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -45,6 +45,10 @@ __bpf_kfunc_start_defs();
  *
  * bpf_cpumask_create() allocates memory using the BPF memory allocator, and
  * will not block. It may return NULL if no memory is available.
+ *
+ * Return:
+ * * A pointer to a new struct bpf_cpumask instance on success.
+ * * NULL if the BPF memory allocator is out of memory.
  */
 __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
 {
@@ -71,6 +75,10 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
  * Acquires a reference to a BPF cpumask. The cpumask returned by this function
  * must either be embedded in a map as a kptr, or freed with
  * bpf_cpumask_release().
+ *
+ * Return:
+ * * The struct bpf_cpumask pointer passed to the function.
+ *
  */
 __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 {
@@ -106,6 +114,9 @@ CFI_NOSEAL(bpf_cpumask_release_dtor);
  *
  * Find the index of the first nonzero bit of the cpumask. A struct bpf_cpumask
  * pointer may be safely passed to this function.
+ *
+ * Return:
+ * * The index of the first nonzero bit in the struct cpumask.
  */
 __bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
 {
@@ -119,6 +130,9 @@ __bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
  *
  * Find the index of the first unset bit of the cpumask. A struct bpf_cpumask
  * pointer may be safely passed to this function.
+ *
+ * Return:
+ * * The index of the first zero bit in the struct cpumask.
  */
 __bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
 {
@@ -133,6 +147,9 @@ __bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
  *
  * Find the index of the first nonzero bit of the AND of two cpumasks.
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ *
+ * Return:
+ * * The index of the first bit that is nonzero in both cpumask instances.
  */
 __bpf_kfunc u32 bpf_cpumask_first_and(const struct cpumask *src1,
 				      const struct cpumask *src2)
@@ -414,6 +431,9 @@ __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
  * @cpumask: The cpumask being queried.
  *
  * Count the number of set bits in the given cpumask.
+ *
+ * Return:
+ * * The number of bits set in the mask.
  */
 __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 {
-- 
2.47.1


