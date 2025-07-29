Return-Path: <bpf+bounces-64600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EEB14B09
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700753B5D41
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4822FDFA;
	Tue, 29 Jul 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV7HWQJV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFF22A4D5
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780736; cv=none; b=dGN6FNADTBtrt/bzOLlmO5Y+z61UKK0BZRNkMGad2Rl9jzJFPs/+eftD1JBriSN3QHy4vk4lPvYyJojYss1yPFq4zE+AKTBUPptd3I00vHv5FCNXLyZxeKCwugns96AEBGPuWOhAmrqAQgzINtu589a79c8J8Cd8/iS8GHu3ok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780736; c=relaxed/simple;
	bh=zUf/SsAIFDLNk6vKT7sEkMt1jisqymKPxSqhlLNvi4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1mvxkym59z0dIdJM7xxH978tNQQD61lgduvW2c6RFYCl4QMeovxdEcHvQ5EQO+z6O1FwkAfBuqQGzQsTz2UKojd8EYhzZOX3XQ9lDFZpI/Jbx6jTieCEB8W/IsRQjor0MQO5e7Eztqu8L54AYPLKSUvZaHjFTfgejV6lm2VX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV7HWQJV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24009eeb2a7so18957245ad.0
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780735; x=1754385535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHc/ChzXX4pKy3XoznGpzP7XumeUqYKz1lD0ZucY3MQ=;
        b=eV7HWQJVoerrKcZ/TRTs2hQggrloLuG0Nz4Q2YeHHpcKlvXInC3nS0RY93EHjA4LhS
         ITIm5ufwuRw1BD4gn7lp85aK5eEZZ8llk9yfP82CNIBHhc+PvI/KtlLO/9v7H6ZoxNkM
         a1zu4wipKB5lBlXEj1wdDpai/fkxRvEQoA1YlkmbKRIwSpLTdIZrJ6x4LbXQQLOt736t
         pGFMrgU+mlzy3Xi4DbBwmCVsX9Q/uFhy+HyR6usYtGfkDzzqW2/r4T3aABcYxGgsRYNG
         cLz+QODRz9bJIOBC0/QGvj+9SmVGKwfMImp/cRneCyCsygIL3tGhYDzJXvLooVAORCw1
         I/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780735; x=1754385535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHc/ChzXX4pKy3XoznGpzP7XumeUqYKz1lD0ZucY3MQ=;
        b=LRykNhOnHKbvvcmWXVRky99dlZXECir4Il61Nf+SkpNffhR0vYSXw2aAWkw/xOiPDv
         rhUiNydTlyqlMx4fYBqo+HDBY2zxem31nOhrsOg2MplLH4VD7q1bbQGdGcctoLEaDIvt
         AHVQR1E5PDEPQaTeXM5USYtQyoOtDL12yObwLIAK8HPQdJO5RlcPkAXoJ7WedaUxevVQ
         aeCi8fD6NcjndOcn4wDt4JtKAib1TsdgA0OcEFKCq09GQLnJBc/M3Yjnqq4yPveBwezy
         f9dyAs665qUnCvyjhFMzeQfwRqzWKQ5PMteMVOYJYS0AJGWmvyyxtpAn4HPyChqDcbOA
         97Hw==
X-Gm-Message-State: AOJu0YwMWL24xzZdgOf7o8HpfaEc9GOBtNrn9lezgrg6LZMhLhTiYmSB
	atKMUGZaE8vjiXGhHCF4Xy74OGZ5op208+FG95dmEVdiyX9GIhU0xolP
X-Gm-Gg: ASbGncu7CNIeunqvdUi39NX+0RXm4A0mzf+v3Z3/QQRwCB5CooEFQCm8gZwoQfNqJRW
	LGMk+HQi+2Q1MT2cyiGx3LOBHrxln0CMdZUPrFfnUl+pTZr9FUqQ3XS/jx02GhtlhWh56n0aoWx
	XsdKHvPrchxnBqrOQzZq9AucbfhoIpaTdPbcmuKIynLgxg4ItukSPZ0cJdv6vcm/bcf2n5yVrAT
	7hxU7DZuccAAnbTB4MoOsyWnzWHuqG3jco0c9BtWW2m1aKSUxp/34FyvMmHTLwTX4mX4TyE4fud
	eEFHqmAru/EgMMpqZKDX1E1mUDvbeXtuH+ZX9hyE2a3QYq+MdfSqmvyhlWepjqpdyFMY16a5ybb
	AXIM61hwBzUIeXaHNAj7lF05YV9wVTgO8hVqNBmJyitMCaA6p
X-Google-Smtp-Source: AGHT+IEwNw6iWdRG92+MOtfdkpGPTDLwGGyBzjfG9IcNP6NgCSwLOpYypWU0d+qgja6a81bzLFBFKA==
X-Received: by 2002:a17:903:2345:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23fb3040f6cmr190837245ad.18.1753780734575;
        Tue, 29 Jul 2025 02:18:54 -0700 (PDT)
Received: from localhost.localdomain ([101.82.174.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30be01sm74337015ad.39.2025.07.29.02.18.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 02:18:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 3/4] mm: thp: add a new kfunc bpf_mm_get_task()
Date: Tue, 29 Jul 2025 17:18:06 +0800
Message-Id: <20250729091807.84310-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250729091807.84310-1-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will utilize this new kfunc bpf_mm_get_task() to retrieve the
associated task_struct from the given @mm. The obtained task_struct must
be released by calling bpf_task_release() as a paired operation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
index 040f988dbdbd..3b10a97acc31 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -191,11 +191,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 #endif
 }
 
+/**
+ * bpf_mm_get_task - Get the task struct associated with a mm_struct.
+ * @mm: The mm_struct to query
+ *
+ * The obtained task_struct must be released by calling bpf_task_release().
+ *
+ * Return: The associated task_struct on success, or NULL on failure. Note that
+ * this function depends on CONFIG_MEMCG being enabled - it will always return
+ * NULL if CONFIG_MEMCG is not configured.
+ */
+__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm)
+{
+#ifdef CONFIG_MEMCG
+	struct task_struct *task;
+
+	if (!mm)
+		return NULL;
+	rcu_read_lock();
+	task = rcu_dereference(mm->owner);
+	if (!task)
+		goto out;
+	if (!refcount_inc_not_zero(&task->rcu_users))
+		goto out;
+
+	rcu_read_unlock();
+	return task;
+
+out:
+	rcu_read_unlock();
+#endif
+	return NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_thp_ids)
 BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_mm_get_task, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_thp_ids)
 
 static const struct btf_kfunc_id_set bpf_thp_set = {
-- 
2.43.5


