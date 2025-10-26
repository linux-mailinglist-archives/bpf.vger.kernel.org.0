Return-Path: <bpf+bounces-72224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F66C0A5D0
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0483C4E44CB
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6425785E;
	Sun, 26 Oct 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZXJNG0Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA8261B9F
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472995; cv=none; b=AsznDxan7SqExLnCDBZJ20pjjZj5ZmvUxJ3TPjHoQsVtdy22awzc87cYW8lP+Fugy7CxC2aYTSwxXQNx78P9RQ7U48r5uABMTQgchfweaN3yCr9HiG6lnRkCjF2AmsCXb0vpXGz/vwPksaBKuBaBMuDyfLV0ow6ShJVmTqSYDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472995; c=relaxed/simple;
	bh=f4Mpk0H4YBPkKxkA9k/ayF6vqFcX3US9I1xQkKqQqL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gPeypYl1+mY4XgFLpFhz8fDF76ReIZKxYByfpFwtImQ9Kd612IsET8dWDi6q1aEgGugOGiYUpPUPkk/dF3g83X1+vVIhTQkQq41xr0OquPWFgD2u0dDp7W/f16SmFQRDalF+opXpym/shSfBEZDYrXnDg75NFvT1J/il3xiZz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZXJNG0Z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33067909400so2696344a91.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472992; x=1762077792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51dh7knyJ2EI56Ln4OzlkkQ20tkXsHQX/EW7h1z6ees=;
        b=SZXJNG0Z57jURc8/WLQTiqrgKQZI5SBDg74zYFNe+Yny6HiqPvoDWHHNz+wPJgQMU8
         mHsKyDJY+NTJtqGE1Bfl9XpCac2ChvJjylwZODk58SPG2uw3TTKAWJ1teH/YJUD/xIvM
         SdXUJkI7UIiTDYO4cRQNBSMRVD39CqCt5ZpLNWqNss07yngFliTSiJu5f8Ry3lmLSGfj
         YQYNgXdmjxO8cxdu5zdL6Xow0bhkTYpdskyu4OX15Um0+JxJouva3bsi0wOXf1wlHxya
         Rc4jCWmm3JZuJCK4kd1BZvxRQvbi0crEW375o8O7kAcs9xto4OidRTuM4ZWerXl2wLfz
         YEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472992; x=1762077792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51dh7knyJ2EI56Ln4OzlkkQ20tkXsHQX/EW7h1z6ees=;
        b=a5wwbekbos8te+2rykGt2qDhEMo2ZaA+4nFj3KBkUZ7LXuzd/nJAM3VcgMLXyXP+i2
         gPeCWuC1zZXKyG6o3WhVBan2Ymq93Mrv7jBpxMEUEDxdBjXQl3ITR0QtbnzjLJ84kNbd
         vlCMdj5r2GlkXe/D8FzKx0aHDkIZTZ59KL9Y6ECokJ6fxYUCPd5md/tCd/DWwQQJuY0J
         HQn+xv+qNKopqykfsTADcnP794Ggi4QAivgplEy2bLisRoAVKj3hUEJyGWQ60GJblAV5
         bQuoe8psy9wPIv0RIlZ7Bt3xdKQeRyXaO+BK0+XYUEA2Gv7A7wBHCWUfZJZ0dtp4UlU/
         +llQ==
X-Forwarded-Encrypted: i=1; AJvYcCW12khtTn9vSrP+MjTPlogB6TlEhpOe1/kadNdpkxI3wEZBvapZNDuNbD2AY1gw5/T4CAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS29cSltwzefC1oHFVLtv6nUtwnSY5+k0Lqo2bPb7cuKJKqwac
	Fd8IsCfhwUMGWydpxCQ6KtUYMzblL/79Lawuosi8r1t8zW0L3XbAtPdF
X-Gm-Gg: ASbGncuulH/OHGFRmxh7+vyIr9OKrYnCK+A4MV8FnYh+tdumNvaYw8kZOspONI+ucqG
	vgrBMVaRLmh4V4drbvKFTWzqWwLRA2X4n2sotFyf9GSR5YnVFsYbe1PQJKuZvUXqPJgrUNomu9f
	FjKhNN2WAF8QJUluysasWll4IqeqYg6D+Hhr/OyuMJnB3DGiAWlb7oV8giW94QqWlmHS4li9m/T
	yUygD07piNVzPXglwG9lJbqforIStIfm7g7jWsQBj2Ij9ET2ztkf1MpAq+2LnYhJtQmRVdBK4JH
	TY9dm1kyau1qpUuXTv9Q8Pae6+yPTWlkYDq8z/RfwltshY6Gh2M141nIHhGbb8nQuCdfJz5ydjt
	oojOHlOR8t/NdNxOIpuB34q4PXrB1A+9CnZjpvOLTxYRWxh4l25wNc7jAnZZHUa37KdMJOgnUnf
	YDRysCXM86ThlbZuw+Nob8oL7kgg8lu8AnOX8hJfb8Brev6g==
X-Google-Smtp-Source: AGHT+IG7sgq1Xq92NeCyT7uFb5+71seRL/zYWyT7c5kIIXXvcEfrQgBKJ+civAjAk2csDkXdvTOUtQ==
X-Received: by 2002:a17:90b:1f89:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-33fafc8a0c9mr13862369a91.35.1761472992294;
        Sun, 26 Oct 2025 03:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.03.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:03:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org,
	clm@meta.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
Date: Sun, 26 Oct 2025 18:01:55 +0800
Message-Id: <20251026100159.6103-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251026100159.6103-1-laoar.shao@gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-process BPF-THP mode is unsuitable for managing shared resources
such as shmem THP and file-backed THP. This aligns with known cgroup
limitations for similar scenarios [0].

Introduce a global BPF-THP mode to address this gap. When registered:
- All existing per-process instances are disabled
- New per-process registrations are blocked
- Existing per-process instances remain registered (no forced unregistration)

The global mode takes precedence over per-process instances. Updates are
type-isolated: global instances can only be updated by new global
instances, and per-process instances by new per-process instances.

Link: https://lore.kernel.org/linux-mm/YwNold0GMOappUxc@slm.duckdns.org/ [0]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/huge_memory_bpf.c | 111 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
index f69c5851ea61..f8383c2a299f 100644
--- a/mm/huge_memory_bpf.c
+++ b/mm/huge_memory_bpf.c
@@ -35,6 +35,30 @@ struct bpf_thp_ops {
 };
 
 static DEFINE_SPINLOCK(thp_ops_lock);
+static struct bpf_thp_ops __rcu *bpf_thp_global; /* global mode */
+
+static unsigned long
+bpf_hook_thp_get_orders_global(struct vm_area_struct *vma,
+			       enum tva_type type,
+			       unsigned long orders)
+{
+	static struct bpf_thp_ops *bpf_thp;
+	int bpf_order;
+
+	rcu_read_lock();
+	bpf_thp = rcu_dereference(bpf_thp_global);
+	if (!bpf_thp || !bpf_thp->thp_get_order)
+		goto out;
+
+	bpf_order = bpf_thp->thp_get_order(vma, type, orders);
+	if (bpf_order < 0)
+		goto out;
+	orders &= BIT(bpf_order);
+
+out:
+	rcu_read_unlock();
+	return orders;
+}
 
 unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
 				      enum tva_type type,
@@ -47,6 +71,10 @@ unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
 	if (!mm)
 		return orders;
 
+	/* Global BPF-THP takes precedence over per-process BPF-THP. */
+	if (rcu_access_pointer(bpf_thp_global))
+		return bpf_hook_thp_get_orders_global(vma, type, orders);
+
 	rcu_read_lock();
 	bpf_thp = rcu_dereference(mm->bpf_mm.bpf_thp);
 	if (!bpf_thp || !bpf_thp->thp_get_order)
@@ -181,6 +209,23 @@ static int bpf_thp_init_member(const struct btf_type *t,
 	return 0;
 }
 
+static int bpf_thp_reg_gloabl(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	/* Protect the global pointer bpf_thp_global from concurrent writes. */
+	spin_lock(&thp_ops_lock);
+	/* Only one instance is allowed. */
+	if (rcu_access_pointer(bpf_thp_global)) {
+		spin_unlock(&thp_ops_lock);
+		return -EBUSY;
+	}
+
+	rcu_assign_pointer(bpf_thp_global, ops);
+	spin_unlock(&thp_ops_lock);
+	return 0;
+}
+
 static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_thp_ops *bpf_thp = kdata;
@@ -191,6 +236,11 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	pid_t pid;
 
 	pid = bpf_thp->pid;
+
+	/* Fallback to global mode if pid is not set. */
+	if (!pid)
+		return bpf_thp_reg_gloabl(kdata, link);
+
 	p = find_get_task_by_vpid(pid);
 	if (!p)
 		return -ESRCH;
@@ -209,8 +259,10 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	 * might register this task simultaneously.
 	 */
 	spin_lock(&thp_ops_lock);
-	/* Each process is exclusively managed by a single BPF-THP. */
-	if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
+	/* Each process is exclusively managed by a single BPF-THP.
+	 * Global mode disables per-process instances.
+	 */
+	if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_pointer(bpf_thp_global)) {
 		err = -EBUSY;
 		goto out;
 	}
@@ -226,12 +278,33 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	return err;
 }
 
+static void bpf_thp_unreg_global(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *bpf_thp;
+
+	spin_lock(&thp_ops_lock);
+	if (!rcu_access_pointer(bpf_thp_global)) {
+		spin_unlock(&thp_ops_lock);
+		return;
+	}
+
+	bpf_thp = rcu_replace_pointer(bpf_thp_global, NULL,
+				      lockdep_is_held(&thp_ops_lock));
+	WARN_ON_ONCE(!bpf_thp);
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+}
+
 static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_thp_ops *bpf_thp = kdata;
 	struct bpf_mm_ops *bpf_mm;
 	struct list_head *pos, *n;
 
+	if (!bpf_thp->pid)
+		return bpf_thp_unreg_global(kdata, link);
+
 	spin_lock(&thp_ops_lock);
 	list_for_each_safe(pos, n, &bpf_thp->mm_list) {
 		bpf_mm = list_entry(pos, struct bpf_mm_ops, bpf_thp_list);
@@ -244,6 +317,31 @@ static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
 	synchronize_rcu();
 }
 
+static int bpf_thp_update_global(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *old_bpf_thp = old_kdata;
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct bpf_thp_ops *old_global;
+
+	if (!old_bpf_thp || !bpf_thp)
+		return -EINVAL;
+
+	spin_lock(&thp_ops_lock);
+	/* BPF-THP global instance has already been removed. */
+	if (!rcu_access_pointer(bpf_thp_global)) {
+		spin_unlock(&thp_ops_lock);
+		return -ENOENT;
+	}
+
+	old_global = rcu_replace_pointer(bpf_thp_global, bpf_thp,
+					 lockdep_is_held(&thp_ops_lock));
+	WARN_ON_ONCE(!old_global);
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+	return 0;
+}
+
 static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
 {
 	struct bpf_thp_ops *old_bpf_thp = old_kdata;
@@ -251,6 +349,15 @@ static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
 	struct bpf_mm_ops *bpf_mm;
 	struct list_head *pos, *n;
 
+	/* Updates are confined to instances of the same scope:
+	 * global to global, process-local to process-local.
+	 */
+	if (!!old_bpf_thp->pid != !!bpf_thp->pid)
+		return -EINVAL;
+
+	if (!old_bpf_thp->pid)
+		return bpf_thp_update_global(kdata, old_kdata, link);
+
 	INIT_LIST_HEAD(&bpf_thp->mm_list);
 
 	/* Could be optimized to a per-instance lock if this lock becomes a bottleneck. */
-- 
2.47.3


