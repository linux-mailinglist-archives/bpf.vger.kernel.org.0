Return-Path: <bpf+bounces-44950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B069CDEB8
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD67B23FFD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039681BFE10;
	Fri, 15 Nov 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QotLqi8m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDDC1BF81B;
	Fri, 15 Nov 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675245; cv=none; b=qOy4kWAWsVrqkfnfiuvFlrnOW18blv/tLV6PCxuQsAH/Xd8Pf4Zu5lTwj9N8miCRXFEcI2u+woeAb/vcq647Mt+QRljlIYE+5Je4eE9/g3F3iCiZE7cyMDDHGyIOAdfTtoMZbxVlsoVAcHsUuKqiI5j/SEwBAAB4AwcJZ3PGJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675245; c=relaxed/simple;
	bh=Pq42jzca9zpHieZF+Q8ufniBF3oBct0bsuYex6yoMj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acjv54zJElCUXdXorpjqvZwQ8I2fkyW+4FpSv0eWThWcX3AK6cgUlD9lS9pUtUpaHy1GD9IrDv4YuZ5wbncTRtR3EtGB37TjoBeTUHQPmph3kx1HHKEPjZNvuGVllKN69UYgLj+u4rTmTFYiwp8W0COw4EWOYhuF6ejDJA1blUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QotLqi8m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731675244; x=1763211244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pq42jzca9zpHieZF+Q8ufniBF3oBct0bsuYex6yoMj0=;
  b=QotLqi8mCvNkQutqAitmw4LP0JV7+7nqRN9mRIzze5uUI4H1M0rGztZA
   j4m6DBnQyDHapnI5fLehWDAhlSlF9dPWJhwmaLERNF8jqMkQq8/Y+nGLb
   tYDzQkgUeoO0QDwg2CEEnoB4CvA1XQsQfBcfWHkSClU6PBLd/7loDsyYP
   6FRQDzdCVazXXrSm439t9WsfDHBOCYofRqql/agSpJBPMXqMaVCw47+G0
   4TsMRkuQfuCyuP28Yc1G+y2aT5SBPFoxsTu6gR+GO+4G9wlE3UZAwRF8p
   ZGLiLrQNCFcMrG82OL/CtWBQOk5wHBmOP+s7YGpHPIBb4cV2RzJI8LK25
   A==;
X-CSE-ConnectionGUID: PqyiUaTpRqeg3cmRZeEcWw==
X-CSE-MsgGUID: h89ZwyJvSfWcGsSigwAKKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="35607638"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="35607638"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 04:54:03 -0800
X-CSE-ConnectionGUID: HAUjZ+CuRuS7SVsLOg95sg==
X-CSE-MsgGUID: fkX3wC/kTsy3nEohA3wlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88555517"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 15 Nov 2024 04:54:00 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	jordyzomer@google.com,
	security@kernel.org
Subject: [PATCH bpf 2/2] bpf: fix OOB devmap writes when deleting elements
Date: Fri, 15 Nov 2024 13:53:48 +0100
Message-Id: <20241115125348.654145-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jordy reported issue against XSKMAP which also applies to DEVMAP - the
index used for accessing map entry, due to being a signed integer,
causes the OOB writes. Fix is simple as changing the type from int to
u32, however, when compared to XSKMAP case, one more thing needs to be
addressed.

When map is released from system via dev_map_free(), we iterate through
all of the entries and an iterator variable is also an int, which
implies OOB accesses. Again, change it to be u32.

Example splat below:

[  160.724676] BUG: unable to handle page fault for address: ffffc8fc2c001000
[  160.731662] #PF: supervisor read access in kernel mode
[  160.736876] #PF: error_code(0x0000) - not-present page
[  160.742095] PGD 0 P4D 0
[  160.744678] Oops: Oops: 0000 [#1] PREEMPT SMP
[  160.749106] CPU: 1 UID: 0 PID: 520 Comm: kworker/u145:12 Not tainted 6.12.0-rc1+ #487
[  160.757050] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[  160.767642] Workqueue: events_unbound bpf_map_free_deferred
[  160.773308] RIP: 0010:dev_map_free+0x77/0x170
[  160.777735] Code: 00 e8 fd 91 ed ff e8 b8 73 ed ff 41 83 7d 18 19 74 6e 41 8b 45 24 49 8b bd f8 00 00 00 31 db 85 c0 74 48 48 63 c3 48 8d 04 c7 <48> 8b 28 48 85 ed 74 30 48 8b 7d 18 48 85 ff 74 05 e8 b3 52 fa ff
[  160.796777] RSP: 0018:ffffc9000ee1fe38 EFLAGS: 00010202
[  160.802086] RAX: ffffc8fc2c001000 RBX: 0000000080000000 RCX: 0000000000000024
[  160.809331] RDX: 0000000000000000 RSI: 0000000000000024 RDI: ffffc9002c001000
[  160.816576] RBP: 0000000000000000 R08: 0000000000000023 R09: 0000000000000001
[  160.823823] R10: 0000000000000001 R11: 00000000000ee6b2 R12: dead000000000122
[  160.831066] R13: ffff88810c928e00 R14: ffff8881002df405 R15: 0000000000000000
[  160.838310] FS:  0000000000000000(0000) GS:ffff8897e0c40000(0000) knlGS:0000000000000000
[  160.846528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  160.852357] CR2: ffffc8fc2c001000 CR3: 0000000005c32006 CR4: 00000000007726f0
[  160.859604] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  160.866847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  160.874092] PKRU: 55555554
[  160.876847] Call Trace:
[  160.879338]  <TASK>
[  160.881477]  ? __die+0x20/0x60
[  160.884586]  ? page_fault_oops+0x15a/0x450
[  160.888746]  ? search_extable+0x22/0x30
[  160.892647]  ? search_bpf_extables+0x5f/0x80
[  160.896988]  ? exc_page_fault+0xa9/0x140
[  160.900973]  ? asm_exc_page_fault+0x22/0x30
[  160.905232]  ? dev_map_free+0x77/0x170
[  160.909043]  ? dev_map_free+0x58/0x170
[  160.912857]  bpf_map_free_deferred+0x51/0x90
[  160.917196]  process_one_work+0x142/0x370
[  160.921272]  worker_thread+0x29e/0x3b0
[  160.925082]  ? rescuer_thread+0x4b0/0x4b0
[  160.929157]  kthread+0xd4/0x110
[  160.932355]  ? kthread_park+0x80/0x80
[  160.936079]  ret_from_fork+0x2d/0x50
[  160.943396]  ? kthread_park+0x80/0x80
[  160.950803]  ret_from_fork_asm+0x11/0x20
[  160.958482]  </TASK>

Fixes: 546ac1ffb70d ("bpf: add devmap, a map for storing net device references")
Reported-by: Jordy Zomer <jordyzomer@google.com>
Suggested-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 kernel/bpf/devmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 7878be18e9d2..3aa002a47a96 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -184,7 +184,7 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 static void dev_map_free(struct bpf_map *map)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
-	int i;
+	u32 i;
 
 	/* At this point bpf_prog->aux->refcnt == 0 and this map->refcnt == 0,
 	 * so the programs (can be more than one that used this map) were
@@ -821,7 +821,7 @@ static long dev_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 
 	if (k >= map->max_entries)
 		return -EINVAL;
@@ -838,7 +838,7 @@ static long dev_map_hash_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 	unsigned long flags;
 	int ret = -ENOENT;
 
-- 
2.34.1


