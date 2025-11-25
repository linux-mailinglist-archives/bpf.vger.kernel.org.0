Return-Path: <bpf+bounces-75421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCCC83104
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 03:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50F904E17DF
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B681C5F10;
	Tue, 25 Nov 2025 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBGGz4Yz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F21B4F09
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036481; cv=none; b=AMZHXZp8wN49QZ4BoBK6ldyE5C/VbuF528DlS7RdPedZZjwG8hYF7CHJp+5zwrorWG01TKXy/TUolVGDbuSMG2KKu9dTKDzX1j+l3fglT/aA8BjOQg/7ABAp8Bmav9DNSZCfXG5iCBlzq1qV048F3L7TU6ljMRpvGp3Zhy1Yvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036481; c=relaxed/simple;
	bh=MiGoMMiMabBBFjIfJxnmqV0wwhmfLUjE9C9nTCLTTeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n70LtjhPhsdM71+BbaRWi2ToY6KV+JJ8Uf+Ms9kpXTspzya4bAoRimADrGfX06+2a5mKv4wv2/TPEjm+x1lrs2ok914QPNOpBisOnVyUi+WQgLxymv0XLTh3pPrJSZMxieFcc2Aw4vSxMONa44MTT/+m6ZO/10LvC79T+1jaGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBGGz4Yz; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42bb288c219so4281312f8f.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764036477; x=1764641277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz5L1kMIIFf1Yz/O2b6DkqIttXC93pOszDC5y7TgoL4=;
        b=RBGGz4Yz9B/SkBtTrwk3SyC+nvkYtR50TA3op0++WwEd8wZah6WeSM/6JbQiFGIDOX
         gW6ftCd1hp5cB0Tij1Ym/CunaBeMAsKInjHlUylqqtvwf33hJfjE00gii9NTyzSVugTr
         gvpmqY1/cL9Gkrba4Jhxuad1ezcvD2ePsuWYxvq9UHe/crV069fXGsl33mBuw7GuF5lx
         gLrKZF6UoXEhsoA4Dcm2hppk2q5nJQ7qLOqMghyHSAQLauhS+EVn5lmTO8f9t2fNobR5
         nGmCgrFoZc4BmFqAKB2Z1z+tBnT5ck2rIIIGQ5UPw6g7lc4CqAB3dRgyEp6XEDjFC61u
         SX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764036477; x=1764641277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tz5L1kMIIFf1Yz/O2b6DkqIttXC93pOszDC5y7TgoL4=;
        b=pr6jPL1sxCxWY0A+osSYAMKFFrLnMYutHe0sMts5lBGFoSqufmVKWc4gcJpB1zKQXV
         JVCC/qetLUfZdPpIastM++Tj00mVQowu4GsVc7qSgYf1eQstFE4ZA/4H8GCyHTXBkNbO
         ogOZ5UITz6rbER6fwUMqRxgWayyk48RBDrfCAfVXZ0RiH4L2hJ3Zlkp9cxcER9vyYc6R
         2n265YJ/ayVCJzZdPymjVmgM1mz7QzPetvop5wV6X+LwwBxUb5S4m53Zj5cBxh1S7yes
         so3a37bID7+7H5OPvswWQTduJgGbEyOAbjSnkIFcN5pepTdaA/aZW5MurTHWTqnzmcnp
         +I3w==
X-Gm-Message-State: AOJu0YwBMLqrW1rwPJJD1An5nD2d7BV4YOZRF1Hm9ll1OYNIl+ptC6kx
	8wR82gkDiDkOPXZ26ZhI+w5VkGXsCGk/NgrALSKzETpKsL6E3qiVY2f59YT7gHjA
X-Gm-Gg: ASbGncvxqPiVL/CVi6gz98s0v/H/dXc2Syf8/6D8z4KUXvh+8mIfAS52jjVcB/jKRPA
	63hhqj84iWoC9+YREf45UIJrcUFBmr4x9qv4wdwScVkUE4f0ne38DTFpWASyOA3xvYsBzfKzyyW
	WPCkpbs/wH+NA09npB50T5+O0DhViEgB9x92NBXawbdEsiqDsVMcWOjtmkk+wCax2KvmCmXyHfh
	jtAVDtN4olHTYsZX2NCVc3SL2PFnHSLA1iUz0JkAEzVkgsaS447PE+WobE6RTipG7F94/GUXQWu
	RVJCXrdrDxgvmUAsHw1Cp4Dx671KbLqdyUIDkoxEtwBOw+GtEjlITjdzbn6TqTkm6bfMd41+qmo
	AZ4Ss3bzDXVNbEC6cd++tJDPnEBQfa1e77/eExUCgCTK7nVWMOBUKBs0MukhU3+nckBOqsumDeh
	sEno8m8oK1LE9xvkvFF0ZsVv+ZiCJy9zNpATs3jJdzks9EWf5b9ILWIQVJAqj992DT
X-Google-Smtp-Source: AGHT+IEO1o6x6eUH+7nLebd75g+NU79hvYCfsovufS1boi8thFWxS72OTf7CHaSgt/FBrGKPcq44Lg==
X-Received: by 2002:a05:6000:2309:b0:42b:32c3:3924 with SMTP id ffacd0b85a97d-42cc1ac9d94mr14637740f8f.10.1764036476547;
        Mon, 24 Nov 2025 18:07:56 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7f2e598sm30842942f8f.4.2025.11.24.18.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:07:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Make CS length configurable for rqspinlock stress test
Date: Tue, 25 Nov 2025 02:07:49 +0000
Message-ID: <20251125020749.2421610-4-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125020749.2421610-1-memxor@gmail.com>
References: <20251125020749.2421610-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=memxor@gmail.com; h=from:subject; bh=MiGoMMiMabBBFjIfJxnmqV0wwhmfLUjE9C9nTCLTTeI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpJQzvdWCwDAYffsBwwgj18p/DMZhcOE6tKna4l mHO/16OgHuJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSUM7wAKCRBM4MiGSL8R yprLD/9DHJjs7X6DfjJdMW6cUVn1/3hONUkt4dvK3ejx008FwlG3K4JgdbKOfkaIzKZyRNQTjxE UlHqFbzFPxRu751GU1DgcsSWmVCIeWJ3dM1UNko5ivV06qzhGK/l6yJEEa6WlDnvYaQO9FAJ+gY 9ZE8D15b+zQZgoTIUZwUkcIgq11fgRHEg+8JoLswOkHXAhZcaXBHyg00pTJB7MdXC39I1vfYLbo rHe8bQ0RXO4ZPWL1+L6zdpEmNBzTzE1VVD1EeRc47TGJxu+xZbOqcivju3Tv+xLIMbboVJwAKkX fkjn0uUWZyK17M3hXtHeoURbwJWVUD8a4f7a/dlV6NmIQBJuN03KfzS7f/HK07dRyQegcAxHYtE ta9350/A+ZIn+CqKZJS1D2pHazR6mtN/eYPpGC+rZB6as952LXYRxMIe2+bxvB9DETHWB0eK8LN 4kGnjUI/TXryZ/kmYq7L+Yj2yd3X31sGSpVEHN+YrAcT9KY/MBcvmxfpkdoW7AlTTcqR47xdDbu wXJvhV1rpNx9yvIDdyR3g+qd8w6X8ESdzOwYi2FTJGDfx/+0jbGCqtIzXMsKq/u47EpzFfoYtzr v7YZ03hPpPA48ZXkbeUdsY4Bt9E8FFSwnsOD06y/E+HQm+9wapo50kTAoOHAR9lOiuHJIQs22g8 tM22dLqW/Y2ZZ6Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Allow users to configure the critical section delay for both task/normal
and NMI contexts, and set to 20ms and 10ms as before by default.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/test_kmods/bpf_test_rqspinlock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
index 4ea7ec420e4e..e8dd3fbc6ea5 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -51,6 +51,16 @@ module_param(test_mode, int, 0644);
 MODULE_PARM_DESC(test_mode,
 		 "rqspinlock test mode: 0 = AA, 1 = ABBA, 2 = ABBCCA");
 
+static int normal_delay = 20;
+module_param(normal_delay, int, 0644);
+MODULE_PARM_DESC(normal_delay,
+		 "rqspinlock critical section length for normal context (20ms default)");
+
+static int nmi_delay = 10;
+module_param(nmi_delay, int, 0644);
+MODULE_PARM_DESC(nmi_delay,
+		 "rqspinlock critical section length for NMI context (10ms default)");
+
 static struct perf_event **rqsl_evts;
 static int rqsl_nevts;
 
@@ -138,7 +148,7 @@ static int rqspinlock_worker_fn(void *arg)
 			start_ns = ktime_get_mono_fast_ns();
 			ret = raw_res_spin_lock_irqsave(worker_lock, flags);
 			rqsl_record_lock_time(ktime_get_mono_fast_ns() - start_ns, false);
-			mdelay(20);
+			mdelay(normal_delay);
 			if (!ret)
 				raw_res_spin_unlock_irqrestore(worker_lock, flags);
 			cpu_relax();
@@ -182,7 +192,7 @@ static void nmi_cb(struct perf_event *event, struct perf_sample_data *data,
 	ret = raw_res_spin_lock_irqsave(locks.nmi_lock, flags);
 	rqsl_record_lock_time(ktime_get_mono_fast_ns() - start_ns, true);
 
-	mdelay(10);
+	mdelay(nmi_delay);
 
 	if (!ret)
 		raw_res_spin_unlock_irqrestore(locks.nmi_lock, flags);
-- 
2.51.0


