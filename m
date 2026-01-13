Return-Path: <bpf+bounces-78702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D11D18A55
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0B3630216AC
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEB38E5FC;
	Tue, 13 Jan 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGYlxivN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1738E5FF
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306391; cv=none; b=YWCFyyh0V0c/JrJiGO1ElQ2JOzRNqOBDlILV5xKO5BrVkFXfw0qrWTpXwntw9IC7df7hy6w9GP09seGXsBuJnrJgtCyJCr9jzM8gAs9Cx7L0695tYQtI8U98PKqvIDEZbD6L6Vz5nw0Wcfx5OAT1GR4+07EPr2/a79KAm9U+oeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306391; c=relaxed/simple;
	bh=IVYNWWvs8l8zqowRtBwJh9uNnKmeWc5f2QAixPPNrO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKG0lYOJZiO/750CrhUBk+4YiUkhX6LZE38jNqVr2tUnB/PI29g5OgZNiSRVh2SGbvhXWuoc5VuJodo0iHOYIwPrG6egHAhrayVckot/CJBkBkWHqA2bhWcqS/ImEkcTEMYsq4iAWEdryPRnm+VzAPqYnkyC8LQYlvThA91oqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGYlxivN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f2676bb21so63923695ad.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306389; x=1768911189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuDeTOp5vFTHpGOU7ymp4ZCToBarwKwYG+gbn6QIhuo=;
        b=CGYlxivN7ytxNDmZp+hUnBQLh4kD6Wx5R8u8G32jwOnxWZ2Uhhmu85S83KlaugiNI1
         L2YcDX0ZHdCiVcQWXRXs5zNcDzV36WCFkqQz470fc30dDUSY5v/DuUczaVJgzsB2gaj3
         xZ5L5y/LM21yGy+noOAUovLKmXFS235+lE/qe1Av9ZUk6yNRTnaMOtQeSDu3QH4teelq
         x2SPZ8paEMGtEb5tL8oWo4KG6UPwpeoiOykpV0MGGTP9/KPnpI7ER2zicwF3/GrughDC
         i2Vz6ib+Z6KjfD5squxEFMBuFNDMlxzsuf7scckaYJDVl1GmafwC7E1S+LkRVKSN9qi3
         PiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306389; x=1768911189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kuDeTOp5vFTHpGOU7ymp4ZCToBarwKwYG+gbn6QIhuo=;
        b=o3mYVE8W3xUgjGiwIvb35oxfbf6mwoauQFvH0v58tVKuLBsZ+nqyJmeFXBM10aEPh/
         CaWZ6PXycClJbcEb6d6YcIcUZFhwfWW0jKIgOMGI6HfEGzuBZ5pg7/km8n0Tn7m4TZ57
         m63QINInJrcU4qenEKgZbe2o6085c+XhLv+94Ov0YnAOd2XmiQ4WyOd1Nf+2iXdaS8sM
         KUi9jjFQB135DamAXeSWQBIIbKvIcYblJE1NmhhTDUZd72KQMMMCaTkotEJTEZla2hxx
         Jh1bLNYm9VJWpzvlL3XHcNUPdz9ibxZGnctPqsJ8HKFv6/BsSPT423XckUjvk24ApopT
         5TWQ==
X-Gm-Message-State: AOJu0YzkHOjdNF4K8dkUmJkUgqIykQsf/ZR5mFGUhn5+PUluWSfG7cjl
	y/tEkJsoPvAtwmhiCxs3mUvSEj2dmscxjXEArLBvIbq4sm/jV0VLEjoR
X-Gm-Gg: AY/fxX4YD2aWuLoLeKmV0KjwTMkodHK3WmkzLQ1lMCZosLHpYieFodVp6ZrjD6ilXGx
	+o1idPxxThED3OTJmAPU1Ue5k9eWpyNLS8VIxnodmBPGCWSonb+q2xiGApHQAZYFAdK/OpOkEnE
	Aik55+qIDVA1LZOv0WeeNNHBM5jjNdh1JmJW7ASs5yuomNFDzGpn/kXsTpyUel2RGpQWI34JHhr
	P66HB0s26RKWuq1DB6aw930f6D5yDKb8tTWPE1yoZXmtC5dyznhjOC8Ca+0YJNomQXXQHS7h7zI
	ChpiyGUnsJ8PltNDKf3AYcQi+j6EJGHGmMezdv+SYzS7xsxbjljrCvymq4vpjJp2XVEKRLL08sb
	jPTyEY5Bqwsczn8qDJC3s3FpwRkIP4/+bbDvSzvBLKUBlIvjd1lWisoTQqAFqxEv7lnWqgBEWNz
	1i0O8zPK3LllueVnWA8LLhfVAuRdSXuFtzJkLm/s3enPFZ
X-Google-Smtp-Source: AGHT+IH/7KH/XM9HqghYuq4Xp0l6J9YnEAXiv2p8+0oekBhp2itCclCHuYupc1TopwwPFAtakvimuA==
X-Received: by 2002:a17:902:ea11:b0:2a0:9d25:c4ca with SMTP id d9443c01a7336-2a3ee4362fbmr230310625ad.18.1768306388882;
        Tue, 13 Jan 2026 04:13:08 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1d24:c3f5:8074:4004:163:94af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e7fd708fdsm11596703b3a.65.2026.01.13.04.13.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 04:13:08 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mkoutny@suse.com,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/3] mm: set numa balancing hot threshold with bpf
Date: Tue, 13 Jan 2026 20:12:38 +0800
Message-ID: <20260113121238.11300-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113121238.11300-1-laoar.shao@gmail.com>
References: <20260113121238.11300-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our experimentation with NUMA balancing across our server fleet
revealed that different workloads require distinct hot thresholds.
This allows migrating the maximum number of cross-NUMA pages
while avoiding significant latency impact on sensitive workloads.

We can also configure other per-workload NUMA balancing parameters via BPF,
such as scan_size_mb in /sys/kernel/debug/sched/numa_balancing/.
This can be implemented later if the core approach proves acceptable.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched/numa_balancing.h |  9 +++++++++
 kernel/sched/fair.c                  |  2 +-
 kernel/sched/sched.h                 |  1 -
 mm/bpf_numa_balancing.c              | 28 ++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index c58d32ab39a7..bbf5b884aa47 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -36,7 +36,9 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false bpf_numab_enabled_key;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 int bpf_numab_hook(struct task_struct *p);
+unsigned int bpf_numab_hot_thresh(struct task_struct *p);
 static inline bool task_numab_enabled(struct task_struct *p)
 {
 	if (static_branch_unlikely(&sched_numa_balancing))
@@ -63,6 +65,13 @@ static inline bool task_numab_mode_tiering(void)
 		return true;
 	return false;
 }
+
+static inline unsigned int task_numab_hot_thresh(struct task_struct *p)
+{
+	if (!static_branch_unlikely(&bpf_numab_enabled_key))
+		return sysctl_numa_balancing_hot_threshold;
+	return bpf_numab_hot_thresh(p);
+}
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4f6583ef83b2..d51ddd46f4be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1917,7 +1917,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 			return true;
 		}
 
-		def_th = sysctl_numa_balancing_hot_threshold;
+		def_th = task_numab_hot_thresh(p);
 		rate_limit = MB_TO_PAGES(sysctl_numa_balancing_promote_rate_limit);
 		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1247e4b0c2b0..d72eaa472d7d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2961,7 +2961,6 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
-extern unsigned int sysctl_numa_balancing_hot_threshold;
 
 #ifdef CONFIG_SCHED_HRTICK
 
diff --git a/mm/bpf_numa_balancing.c b/mm/bpf_numa_balancing.c
index aac4eec7c6ba..26e80434f337 100644
--- a/mm/bpf_numa_balancing.c
+++ b/mm/bpf_numa_balancing.c
@@ -9,6 +9,7 @@ typedef int numab_fn_t(struct task_struct *p);
 
 struct bpf_numab_ops {
 	numab_fn_t *numab_hook;
+	unsigned int hot_thresh;
 
 	/* TODO:
 	 * The cgroup_id embedded in this struct is set at compile time
@@ -52,6 +53,30 @@ int bpf_numab_hook(struct task_struct *p)
 	return ret;
 }
 
+unsigned int bpf_numab_hot_thresh(struct task_struct *p)
+{
+	unsigned int ret = sysctl_numa_balancing_hot_threshold;
+	struct bpf_numab_ops *bpf_numab;
+	struct mem_cgroup *task_memcg;
+
+	if (unlikely(!p->mm))
+		return ret;
+
+	rcu_read_lock();
+	task_memcg = mem_cgroup_from_task(rcu_dereference(p->mm->owner));
+	if (!task_memcg)
+		goto out;
+
+	bpf_numab = rcu_dereference(task_memcg->bpf_numab);
+	if (!bpf_numab || !bpf_numab->hot_thresh)
+		goto out;
+
+	ret = bpf_numab->hot_thresh;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 static const struct bpf_func_proto *
 bpf_numab_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -105,6 +130,9 @@ static int bpf_numab_init_member(const struct btf_type *t,
 		 */
 		kbpf_numab->cgroup_id = ubpf_numab->cgroup_id;
 		return 1;
+	case offsetof(struct bpf_numab_ops, hot_thresh):
+		kbpf_numab->hot_thresh = ubpf_numab->hot_thresh;
+		return 1;
 	}
 	return 0;
 }
-- 
2.43.5


