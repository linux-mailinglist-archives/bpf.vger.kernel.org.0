Return-Path: <bpf+bounces-66513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA31B35575
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D205E05D7
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3568F3009C2;
	Tue, 26 Aug 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H41YRJoE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B43002B1;
	Tue, 26 Aug 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192845; cv=none; b=c+xOM0yBodo+3a0TA6hkLc8f1qX3rfa8GfaIpohWw9n46dslz9idiPS6cOqTnQFA92M9HkaW7LEdBSVKFwF1Fd56O9OQnvxiEkyQtcTjdNTVxpAwQyo1J16Hr/RiPC/obRP+oq3yr8znMGjj7X5fDb0xSQBkCOeDDG7+YipoFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192845; c=relaxed/simple;
	bh=oxgvlujZDViPWKc6pFJkHO6LZ/yeKPwRf4pAWw/xvmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYgYj0tvtkCKJxj7GSTjWdCNG2j6GAwaMsMgfZptDYaxbogPVdnqmRi7mmEInHnjKXeQmPbYom4oWyHjBO2/DCezzimaVceMOGRL5pSLlCirYRQrVM1tigB1CfQKqSwTCKVDNKv3u4I5EJpuUP50s4dUp6h78U42VfUgRTD8fSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H41YRJoE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso5869125b3a.0;
        Tue, 26 Aug 2025 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192843; x=1756797643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sviwpOLmfQUsJA0/Zn7lWOZM8N8qF/XZa2OLJ+sIYYU=;
        b=H41YRJoEOrZE1b+eV4VlXAzFf1VqyBfRfC5ZigbZ2CUM5oQdzM+ttmQt7+N7g09H6j
         CjJdN9LeGPCbDqf1YLAUXx5xlIrKMi17hti30CuuvxFfIl4rMnlF4zrE1xay4T0XxSwE
         3v7vBC7YvfEhcaDqWddUxHLfV92hoaBf5lAZGRToghZb0wt6CpWkqW2gW9IfdE5QqZC4
         E5JMf0FkJvamqTQzsBTApx7dnswp1HVE+pxHkriiwCmcsgQxO7lImIybmtK67WRg+Qmw
         IV4BXpVGzK6PlQtf2ZDwbfb5ZcbdppCgu4O8ffIEKFk7eBtQWXpnG8eU6UDhKNAATxdR
         iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192843; x=1756797643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sviwpOLmfQUsJA0/Zn7lWOZM8N8qF/XZa2OLJ+sIYYU=;
        b=mTxiNCpYvXC2OrVnJcdYcvG01I+qGYIXCXn+7dajA/RM0wMJ/zkwrXI2QjwEeBPnNu
         +L+Mgj1oYypLjpLT1K5nb5Yy9EIZxMjuzLwMQBLDuGr2r/ejtihk+RnKKS3C6wr6rSo1
         OOvlIPXi+DZDmkaCMCCqHOU0lBuW//vk3vLPdkMTgS8qHmDi6DVVqDP/ecDk2t9JokEE
         mregPpjkOKiEVrsAdXdhV0r7Zh4R8n+Izfxpb01YQsg1xPlqeyPMX3meOmgWeFQo4viV
         ecff9Wh6HhViHIULXFn8dHKCVSW7Tr5Gw1ybGUJXGY8LVo7MHnj6KRd12Ymmt9eBObVI
         w0fg==
X-Forwarded-Encrypted: i=1; AJvYcCUXVHUPtvLg3fk8QmPCOL3wJrXdOexJq9vCCGEsSrBHxvnshCvYIovQpWbvzKsxPd4pr/LcKW5JEZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGXg75PoKYt1AhOcIi+Y292twD2HbXFKB58wHn7PTwE79lJgY
	f+nP8hImnKTiK11hYTCG0/M0OVLKR4lLY9VFCZxI9TupEm4EiRxOLXef
X-Gm-Gg: ASbGnctXmg+IewNbuvHkPyj5EJJJ4ehRD1VDMApbT2iy/veGMMPkE/ZwiNxIm7SGfL+
	bfJRLaZ4dcFy92XHcIlg4sZw8oYlS9EWYZLgbgb92p4AEGCQKytbVc+PLgdNb1UXMtn7Q05JuCx
	Bs4pgoWrBExOkj/uZ5qtwkme9mWOth0JgGzul6uwNwOPa4pnXW9qfs6pjUtL8KvLbEEqlWKPJTi
	zyalxNCNPoGYjR099mS1r8gvx2W9+odZFusRw+wIEyiY+GZwySM/rBE2VtdZrSbfum+p2OgesN5
	AIegr+xHZiMORQk9XyzYSi4fHOV8E7m6xPZ/8Nw73p/QCAX31ODA3fyG5APjq77eQeAH7Kq9HUK
	+KEKCzP8vzRicZtnB8ldQ11e4cj6UAamImF7oYpDpgtO62TRjIaR5shs+Y4D7hDt4rrjUotagxS
	Tjh4g=
X-Google-Smtp-Source: AGHT+IFc/ProjGMVXcqa10X9CPlhCGT8IYwac5NyD5RvTObGqB9z0r+zsVy5MTfrS6xNwZ7PMnWYPw==
X-Received: by 2002:a05:6a00:a17:b0:771:e8fd:a82a with SMTP id d2e1a72fcca58-771e8fdaaa5mr5802935b3a.23.1756192842605;
        Tue, 26 Aug 2025 00:20:42 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.20.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:20:42 -0700 (PDT)
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
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc bpf_mm_get_task()
Date: Tue, 26 Aug 2025 15:19:41 +0800
Message-Id: <20250826071948.2618-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
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
index b757e8f425fd..46b3bc96359e 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
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
2.47.3


