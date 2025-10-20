Return-Path: <bpf+bounces-71341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5DBEF2BB
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 05:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCED84EB43F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 03:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5F929D270;
	Mon, 20 Oct 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awt91vO4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD529B233
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930241; cv=none; b=FtP1SMFRq+KjOwZmdeJ8NQiElKFP2BN0Mt8J45sYlnrUc32r1i3ab6udPEJfBEyLGhrxyYsemF7HW3xZ8ZXBH10XT7imLIRTKihnPC6lI1hxrVLq9+VKbs2+fwEf3p4urNTVeGJkJUACSHX5u7fUXz9lHCTh3tJJM0ojUx3LKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930241; c=relaxed/simple;
	bh=sTyjq4lpHpE1Tag4v7BrWtTUyfVl+9Yq5BWJCJuucZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoN0BQku0yhrFtK7CS3VRv+jGu7WagTxZPSl+s2zBaqUO+/Ccq45TupZpvM10YSkTTgYy/THTXIeiauuOS1mr5kYFtEjadc5y1mr3gG2lVY/P8d856mT6lRtS7t21vq/ns1IPRb9WpCosyo5xQ/BSORbei7pywPLb26MfL3vBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awt91vO4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27c369f898fso56791135ad.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930239; x=1761535039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYdtRER+63D5fwP+dPFGkrD4tSBc+ZR0Nj1GwO3r8rs=;
        b=awt91vO4bDyg6BC107x/vOpmB4wLxzVF5dNdNwcXwB124WZfBJizAS5Aaj/gJT9JiS
         YVQ1nsRzSgPSdnMK88ewCrWVir/xYtIsBAuyjylfWLakwJGz+p1LiEAj0jgx3ABX5xbW
         bfatyQq/Xcldh5nDu3Nb6n6PPiShCwNJ8oxfLQ7gViOcUtAMAHQd2xBHJfzvG2wTTDme
         0NxGKsf3S4h2vQQRRekqtt+ceS4jpUVbBW7p0odDSzTZQgaHS0+pS5ikSvCF6v7xN1lA
         Mdo2I3LMlgv2riILDHWoAdSi7pg51rPn6JGdtFu4dzRRkANHgq3VmqbpMIpTFw9FB/8I
         eNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930239; x=1761535039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYdtRER+63D5fwP+dPFGkrD4tSBc+ZR0Nj1GwO3r8rs=;
        b=tpirlabdvzDgC2wYxgGGYJthoVYd3IEnWnjwO68vb0RUhf96fVHRNlfQYtrQBc3Izo
         7fErLKraC26YOnJuaVbGcFlU1zfSO7AB6taW5ggnjHkDpi/LSduKcDJjFjagWbN+FDSe
         15ZfXkR9UFtYtr+MFPupIlPmAEKfWAy8CSwIMk/tMdYZ50+bNe75ui1oaO3DMV577G8+
         NQj9OEZ1LIP3u60GS+2zXr+i5bFgiYw8xFfqpNGILJl3jPf/l5XO4SkWF87KyMgC2nvA
         G6DZNVZarSFVW80UcK9KUEKoiUyGTRbeMkckvC3yAYXEWJLONJifnrxUQkb4qh3ppEwp
         bsiw==
X-Gm-Message-State: AOJu0Ywi3bMdmG4w00H/pwjCiFO5BjuZPXSPwiscGBq8fR7/J39k/vPW
	g8BjCe/xPBE11msvE2+PgeJNc43ZknjlAVj3CropqIi9pfuavbYx9lsP
X-Gm-Gg: ASbGncvcBXUPPibzD1PBwEA8rugTJjx3pCJOnwQ1zc343DJbs91j2flMMw55spIizAU
	6orrqkjdL1gQK66o4NzznBJ+R1n+4ZlZdwui0mshL7HlUV8V58naXIxLcG9NMPjdycJ/1g2enb6
	KX+La2AFpF79KtuCV+KOZmzGh2wNujhOJfw724xV4wGCUpOw6WXhiLAo+eJhCETsohXwnCVeBrY
	kq99sDGqDr3Wq9mrfjmEVDOqSlNhTxIe4Kjetj1SvMQHDtETD9azqlHtXT09xEsBESc7a0h2i/B
	85YbCBAzUqi85ol7tSMnk33npRgr2QGOeCytrD32G6oVofopxD6rpKvpsm8euYVLu0AQMr8hqtN
	iEFo4Va2ePJyJVa6bAn+fTOUNMdlLXIWuFDd62T6FRkqsPwIq3Pd4X8VtniQOlEveAaSW+Mgw1V
	Od//6Wq7Ab8MOImTso2piA3i+i4tDlOFByOx9UuJfbQOSKeA==
X-Google-Smtp-Source: AGHT+IGo/kUBmmZVSBiCCtDWJPQhX6W2PzXxnBQ3p+r5Rs/M8lNok3r/Ez1M0M2GbDWgxzLf0C8R3g==
X-Received: by 2002:a17:902:dac5:b0:267:6754:8fd9 with SMTP id d9443c01a7336-290ca216ad6mr166008035ad.39.1760930238858;
        Sun, 19 Oct 2025 20:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fddfesm66373435ad.88.2025.10.19.20.17.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:17:18 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
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
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 06/10] mm: bpf-thp: add support for global mode
Date: Mon, 20 Oct 2025 11:16:51 +0800
Message-Id: <20251020031655.1093-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251020031655.1093-1-laoar.shao@gmail.com>
References: <20251020031655.1093-1-laoar.shao@gmail.com>
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
 mm/huge_memory_bpf.c | 109 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
index e8894c10d1d9..cad1ca6f59a4 100644
--- a/mm/huge_memory_bpf.c
+++ b/mm/huge_memory_bpf.c
@@ -33,6 +33,28 @@ struct bpf_thp_ops {
 };
 
 static DEFINE_SPINLOCK(thp_ops_lock);
+static struct bpf_thp_ops __rcu *bpf_thp_global; /* global mode */
+
+static unsigned long
+bpf_hook_thp_get_orders_global(struct vm_area_struct *vma,
+			       enum tva_type type,
+			       unsigned long orders)
+{
+	thp_order_fn_t *bpf_hook_thp_get_order;
+	int bpf_order;
+
+	rcu_read_lock();
+	bpf_hook_thp_get_order = rcu_dereference(bpf_thp_global->thp_get_order);
+	if (!bpf_hook_thp_get_order)
+		goto out;
+
+	bpf_order = bpf_hook_thp_get_order(vma, type, orders);
+	orders &= BIT(bpf_order);
+
+out:
+	rcu_read_unlock();
+	return orders;
+}
 
 unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
 				      enum tva_type type,
@@ -45,6 +67,10 @@ unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
 	if (!mm)
 		return orders;
 
+	/* Global BPF-THP takes precedence over per-process BPF-THP. */
+	if (rcu_access_pointer(bpf_thp_global))
+		return bpf_hook_thp_get_orders_global(vma, type, orders);
+
 	rcu_read_lock();
 	bpf_thp = rcu_dereference(mm->bpf_mm.bpf_thp);
 	if (!bpf_thp || !bpf_thp->thp_get_order)
@@ -177,6 +203,23 @@ static int bpf_thp_init_member(const struct btf_type *t,
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
@@ -187,6 +230,11 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
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
@@ -207,8 +255,10 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
 	 * might register this task simultaneously.
 	 */
 	spin_lock(&thp_ops_lock);
-	/* Each process is exclusively managed by a single BPF-THP. */
-	if (rcu_access_pointer(mm->bpf_mm.bpf_thp))
+	/* Each process is exclusively managed by a single BPF-THP.
+	 * Global mode disables per-process instances.
+	 */
+	if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_pointer(bpf_thp_global))
 		goto out_lock;
 	err = 0;
 	rcu_assign_pointer(mm->bpf_mm.bpf_thp, bpf_thp);
@@ -224,12 +274,33 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
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
@@ -242,6 +313,31 @@ static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
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
@@ -249,6 +345,15 @@ static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
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


