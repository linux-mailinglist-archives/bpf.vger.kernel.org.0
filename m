Return-Path: <bpf+bounces-20094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571178392A9
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D341C28460C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF05FDC4;
	Tue, 23 Jan 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgGdxtIw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7350A72
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023673; cv=none; b=REgT1FVab+MXnTCyameBeaxwSkH3g9fSq8XcHNyG7Tq+zqm2xUbcXIwtFgEfyEKipSRiFgQaDOGfHKjTBRrpG2b3uvEKv2vptlbuyq3owcShB+ltCKMHzsCj2r/9S4HIa56wauHaEpCF+gYDDUfIrLnjvTLpdadWCd9eYRb0uNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023673; c=relaxed/simple;
	bh=HbKNejpe58oXck8NGnFBh9Fzhm+Otj617ab8+i5OQyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cM1GED6D5LweVtj+uQCadY24RKs0E7s+YWDYmhRQ/c9qEXu+fFadqANuswVDaNEaeLu9B70Bmh1kprYYlVFKPBYEDw18kx89sL2MPAvkInB5QrOvz1OYHiUMlLoJE08JLAF3KBmeRnZgn2NnDCgAf7pgSK84kuhLUapPOiKM1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgGdxtIw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dd6c9cb6a8so628968b3a.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 07:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023671; x=1706628471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSAnNMNt7pPlqEuvctr/usv5wDuSdRTkZiU2I3fUMxo=;
        b=ZgGdxtIwTPcFJtDSkOSTd1WtlAvrAgB7A+gbUCmBWkPnZY6i/Ad3gW5AEEu/IrDn0t
         edmGTFA1K+VMs2M8Pq8eJeUMa5vFkTVbrkLs0S+AHHXk9wg3+Av+wQTNU6/XWcLjT8kl
         +Im6x4Tkz5BMoutSyVooDa8poFCeBl/tX5AfNgBG+9hi2sGzcRLXGFfb/oIeW7owhWTI
         +WCY4V02GyJK4nZgXYcLobe7SQsqUGKNMGMXni9V/vhWBUZB1pv1FJLsJutvbQsNswQ0
         21bbSHlKmSZNvmLGpa2o6yj18xo/cgF3ExZMLkO75nwZiYhTyTWcA5tOIz0wawV1NRc4
         pTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023671; x=1706628471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSAnNMNt7pPlqEuvctr/usv5wDuSdRTkZiU2I3fUMxo=;
        b=Rd/BkpoSYk9cc0m8mN+kjw+DOIf4sW1yhr8Ve8Q6tOFkLFqJdtrqMjHte2D4ooUsZO
         9theDy0SFmPn2BxA2dVuvhgMXNwzFT5vReJg9JZJvui17qs9zmjSaFTC1CpClYqXHQmH
         g1b2rTGr/oqZ2a1jrfYbMbh+kcyuBejMnZ2kJULaSIAXW46jaNiI9qajCx37de3Awci0
         JmsDVb6J1PXjH0lU5+eJabgQWvqYa2zgXCbDJYU/7H7mwPy/eFnnZFouUYCJARvi6TLf
         TgI72F1jHrSWC/eesNQ6P/tDUfZ17TgF8CNuT0IGCTIjNgD0v0sxd3X/E+Y7x1fQGXPa
         PmDg==
X-Gm-Message-State: AOJu0YwV/G3mxiO1M07SfDNkXqPAuGT2P5S+cP1/49FznTlWexDrBQzK
	8GJUozVV4/UdStsawQXsWZxmCqM6KphBFywD/gCbSvrDHxSJB5GY
X-Google-Smtp-Source: AGHT+IH3AbUuiqBZoaUALvzIv3pxEWfj4nbr8GmgVTi95GuTQy46s9NP1EcP0KSN0sex9oUzQOFgew==
X-Received: by 2002:a05:6a20:d38e:b0:19b:5c69:cfef with SMTP id iq14-20020a056a20d38e00b0019b5c69cfefmr4173971pzb.12.1706023670760;
        Tue, 23 Jan 2024 07:27:50 -0800 (PST)
Received: from localhost.localdomain ([183.193.176.90])
        by smtp.gmail.com with ESMTPSA id s125-20020a625e83000000b006dae5e8a79asm12264233pfb.33.2024.01.23.07.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:27:49 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
Date: Tue, 23 Jan 2024 23:27:14 +0800
Message-Id: <20240123152716.5975-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240123152716.5975-1-laoar.shao@gmail.com>
References: <20240123152716.5975-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for bpf_iter_cpumask.
- bpf_iter_cpumask_new
  KF_RCU is defined because the cpumask must be a RCU trusted pointer
  such as task->cpus_ptr.
- bpf_iter_cpumask_next
- bpf_iter_cpumask_destroy

These new kfuncs facilitate the iteration of percpu data, such as
runqueues, psi_cgroup_cpu, and more.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533a3811..474072a235d6 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+struct bpf_iter_cpumask {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_cpumask_kern {
+	struct cpumask *mask;
+	int cpu;
+} __aligned(8);
+
+/**
+ * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specified cpumask
+ * @it: The new bpf_iter_cpumask to be created.
+ * @mask: The cpumask to be iterated over.
+ *
+ * This function initializes a new bpf_iter_cpumask structure for iterating over
+ * the specified CPU mask. It assigns the provided cpumask to the newly created
+ * bpf_iter_cpumask @it for subsequent iteration operations.
+ *
+ * On success, 0 is returen. On failure, ERR is returned.
+ */
+__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpumask *mask)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct bpf_iter_cpumask));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=
+		     __alignof__(struct bpf_iter_cpumask));
+
+	kit->mask = bpf_mem_alloc(&bpf_global_ma, sizeof(struct cpumask));
+	if (!kit->mask)
+		return -ENOMEM;
+
+	cpumask_copy(kit->mask, mask);
+	kit->cpu = -1;
+	return 0;
+}
+
+/**
+ * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask
+ *
+ * This function retrieves a pointer to the number of the next CPU within the
+ * specified bpf_iter_cpumask. It allows sequential access to CPUs within the
+ * cpumask. If there are no further CPUs available, it returns NULL.
+ *
+ * Returns a pointer to the number of the next CPU in the cpumask or NULL if no
+ * further CPUs.
+ */
+__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+	const struct cpumask *mask = kit->mask;
+	int cpu;
+
+	if (!mask)
+		return NULL;
+	cpu = cpumask_next(kit->cpu, mask);
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+
+	kit->cpu = cpu;
+	return &kit->cpu;
+}
+
+/**
+ * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask to be destroyed.
+ *
+ * Destroy the resource assiciated with the bpf_iter_cpumask.
+ */
+__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	if (!kit->mask)
+		return;
+	bpf_mem_free(&bpf_global_ma, kit->mask);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.39.1


