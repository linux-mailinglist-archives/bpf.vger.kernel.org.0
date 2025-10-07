Return-Path: <bpf+bounces-70495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F88BC080F
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 09:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E56F34D13D
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715B255F57;
	Tue,  7 Oct 2025 07:41:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210525486D;
	Tue,  7 Oct 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759822876; cv=none; b=YJJPi9Sftijf8QAPryqt88ZfF7uAZkgRQB1zfXwhv/cNPsxFpApTdmEgMt0SnuEv0vBGCsYETg7E+DExvqNSyWdmZ/Q/vs+RTGdXPlp2AHi+akJjJKSg0KCut7IR4MzEd3ZuBb0F2mF/HJ8LvD/cgIu5ULt91KiaKew+6XWRYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759822876; c=relaxed/simple;
	bh=GkZISkGeS+Thss4TG+0//7gQ0lSs/IhS2IyAqLOsNG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nt57JVXGoDQATVchzu1U8oab3mfZlPSZyG8Vk+4iCFsFv6yT+L28kW2/QqdfDmHSgdqVZc6E7siHw88KUsJzPtl4zM6/wINQuOdVLxdwQ2njLWk+1IHzfQPMFBQl1sWP8z9XVfx0Z/BaabrAokBuNqnVFsvl/Y9VknUfP1syH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<martin.lau@kernel.org>, <houtao1@huawei.com>, <jkangas@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <menglong.dong@linux.dev>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH v2] bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c
Date: Tue, 7 Oct 2025 15:40:11 +0800
Message-ID: <20251007074011.12916-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_sk_storage.c to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
v1 -> v2: no code changes. Simplify and clarify commit message
---
 net/core/bpf_sk_storage.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2e538399757f..bdb70cf89ae1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -50,16 +50,14 @@ void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		goto out;
 
 	bpf_local_storage_destroy(sk_storage);
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
@@ -161,8 +159,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 
 	if (!sk_storage || hlist_empty(&sk_storage->list))
@@ -213,9 +210,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	}
 
 out:
-	rcu_read_unlock();
-	migrate_enable();
 
+	rcu_read_unlock_migrate();
 	/* In case of an error, don't free anything explicitly here, the
 	 * caller is responsible to call bpf_sk_storage_free.
 	 */
-- 
2.36.1


