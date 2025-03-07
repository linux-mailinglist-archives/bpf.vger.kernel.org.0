Return-Path: <bpf+bounces-53587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A502A56C49
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F35B3AFF99
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBB21D3FC;
	Fri,  7 Mar 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="rk6gZ+eJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C221D58C
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361936; cv=none; b=ercEArXArY6DMYbhDJMrpnGjAq6VH1/KDBW6Hq56S4JCabeGuRhU8gkI5BJ5UxIZFjxerZ7A9ip6htUiUEhvloRMXlz8Da8N/gBJqyy5jZYmyO5wrr733R1OmtZt96G1khWiIREK6+baOdjgbQnXBY4qGSLzFUd4vrmFN/MtFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361936; c=relaxed/simple;
	bh=pffXZtsvnmipo8zxunVckuQSInHRDVZnsOQw0ZSXVIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuY40rrr8akR+Zy29IDKJnXVvHOiYpDeC786BJOS+12Zk0o4SV6ADl1bha13LrF++H8i6hymcZz+OCPPMRng4ruLGhqY/1PcfgV6Ysw6NX1OCZmRt93y+dJV/4JEz+SYNnCMLatSe9bkuxky4HcCtbn1tikqNlAyIy0K8TotHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=rk6gZ+eJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3cf3afc2bso220231585a.0
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741361934; x=1741966734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOjHJ/XEu8gnFlKw6M/pi/0WwNdhD20bEIw+Ix+DTXM=;
        b=rk6gZ+eJ4HAQJifQwb97svVGytRd2qQL+A2kvPywrRrgEdlL8YEyNO7IJ6ni45EVAc
         +VkAhfj4nG8HwvmsV1YW5W9RAttmQxOZKzZGD0325Wi0wZXerAHpWE9yoX+52fV2lnYk
         1Yu6lD0X2X2q4O7ljYNBM/gGt8Y5OGNPCbRry+hoD05nL39FfzPxNKb/2bde1cergNNa
         YmX5NNMI4ae7o3cktoGLA0e8O0yxiyDnRpzF66W+ElWqGvvVGn21EJgiOsoq2bMugMWz
         VXSkq8SaALgn4SLlPUzrlusWozQJZM9EsIVAxEn9sc+lb4BI8wEWmXLG1q4SQ2nnrXPM
         lRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361934; x=1741966734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOjHJ/XEu8gnFlKw6M/pi/0WwNdhD20bEIw+Ix+DTXM=;
        b=UqTUr029fPAQCwGU1dh+GKOsh/I4R7gMjGlLDDahc4I//eTZhi3iap79HDKgIntPuj
         IAPukr2Rvle/S5N8i2OrtWpkH0h1SyK2rHjBfrZ3Vn0i8A/bxpQrT8i2swsMaOzOrafM
         W0xN1ZWwNLzoZMHm8dubv2Lcg9cbSYXBP7j1kw2A1HwzunzUUkcs3dI3mJNPwWLnbE3K
         EhLMhu5C2iApSzQLl/WpfqGQ+1RuHMM/v9EkgGuDE2xcyWxsuv6zEml+W6GxrXRYYRCW
         0jqWUL9cSjUojhZ9BCjTk7dgp1PevtldweZI4s8yFn6UDS18jSWDKdm0y8xnz4Kc7eWO
         NwXQ==
X-Gm-Message-State: AOJu0Yzgz1s6YRr7m4J8jHYVol5ciPIq3uhf/E84rnJe4pNSXtpPt/9q
	tAo+hRKF2/iP4hTyPri7d6W7mLfS7GMkWEOrUll8qiRmLtJd6bsr76Ey4qnZFfZLojurXATjMqV
	3UcsRnQ==
X-Gm-Gg: ASbGncuZ3MjKF7Y5D2kbDok2PA+9IKSeogJhiAXh6mpZKTaLNEagyU51H1fucfWio6o
	jEguCFEn8eV69kK7bVBc9wA5rqCEHWko2HkqCuV0lMLyQEC5YoKn/OZGHulWVZKFomKuyDw0rBP
	F2pXw0gZBWijguLfU3webx2DwW6V/U3/kow34Z9QUtsfyUtc7eyCiSlZMr4c/zo4p1nAx9udpL9
	6XeiS2tVD2uChF5445NBOHN/VFUvzZctFaAZRJqfYu0CyuxyW6qryFiLQdGVfymZ4OkCTFtdDHj
	DY6Dpp9TpO1/Wdk/7r6ObfrEeiyPEva4w0p2Ds/UMQ==
X-Google-Smtp-Source: AGHT+IFOV7ylkpAZuLEjmuH8PtEQT2EIrJrRgzmyAD3Tf0r3Wv8eeW+3FevaLbxj6TLTGdr29ZhX8w==
X-Received: by 2002:a05:620a:2722:b0:7c3:c9f7:b119 with SMTP id af79cd13be357-7c4e168b757mr579776785a.13.1741361933752;
        Fri, 07 Mar 2025 07:38:53 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm253828585a.113.2025.03.07.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:38:53 -0800 (PST)
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
Subject: [PATCH v6 3/4] bpf: fix missing kdoc string fields in cpumask.c
Date: Fri,  7 Mar 2025 10:38:46 -0500
Message-ID: <20250307153847.8530-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307153847.8530-1-emil@etsalapatis.com>
References: <20250307153847.8530-1-emil@etsalapatis.com>
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


