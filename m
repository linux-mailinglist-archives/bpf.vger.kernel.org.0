Return-Path: <bpf+bounces-44949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F59CDEB6
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B72839CF
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7801BE86E;
	Fri, 15 Nov 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOapYzWi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DC1BCA19;
	Fri, 15 Nov 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675242; cv=none; b=bQQGCWSR+cEUJwuqa4Rzr7ZYT16w1ibImEmacsyU6tNhq/4c9p0Fjz3XBgB6biRphdZnXgQ+uvC3UErteMaXNV66DBI26l0wP8QXv7BcnvWRcwg7mr4YOaGx7XEPikNrvnYZSUY3qDpFfjwh6NtA6Q1OFIqvzn0wCJG84+Xn1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675242; c=relaxed/simple;
	bh=5gLwRkHtra4mGAlh8DUhPfiM3IoHF+mWNPxUInl0EX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWXQk48AygiEHbwGP3HLwukMY87mpYFSRphwPXTTCzZBkgk3bwhC+Evmv2Ljk6LzdRUAkNMBgGEVL0Th2Lvc48ULc0FSUZoUnzMJyAaTpjJoBQXaot5fzkvVxZBWUF5wVpX3wYF19sg2zEK1F7vv5iojNKpAntJCqXbY4nJRYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOapYzWi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731675241; x=1763211241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5gLwRkHtra4mGAlh8DUhPfiM3IoHF+mWNPxUInl0EX0=;
  b=jOapYzWieXxA0rvPgiHhVwqpFMJF21vWITEDpJkKjs3bHV9h95HaF0P3
   lPA1jHCYohOZ8ADUlTqz2msRclUiluJ2pWmTJhReWBak8dGcvy952pL1m
   NPPfxI4hKWxWptaPiEWBgc5VVb16OHi81bJd7mau83cy+jbbA15QAbDJj
   In4FZkBh4OuSao2FelaW8sb13KN9Qcg5NDPRwugMx7AnP8asUhzcar08J
   J5XP/tccEIm9b8PnTxBBNCDuVE4BMmqe2ovvBTMOa5cksOgpEvaScEfRF
   WJ9u/R5itvpmDeljOabpnZ7lPwQM5gxfvBzstIKTG0ot96a7YRq9ZPTdZ
   Q==;
X-CSE-ConnectionGUID: 7RvZupg4QECznYiX6uXNXQ==
X-CSE-MsgGUID: kQmlDM62QYSGZ5YT88OadQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="35607632"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="35607632"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 04:54:00 -0800
X-CSE-ConnectionGUID: pPFwgR3TT1WgqDYAoWAE5w==
X-CSE-MsgGUID: jBd7WpgJSBOt88dreyBQwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88555497"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 15 Nov 2024 04:53:57 -0800
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
Subject: [PATCH bpf 1/2] xsk: fix OOB map writes when deleting elements
Date: Fri, 15 Nov 2024 13:53:47 +0100
Message-Id: <20241115125348.654145-2-maciej.fijalkowski@intel.com>
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

Jordy says:

"
In the xsk_map_delete_elem function an unsigned integer
(map->max_entries) is compared with a user-controlled signed integer
(k). Due to implicit type conversion, a large unsigned value for
map->max_entries can bypass the intended bounds check:

	if (k >= map->max_entries)
		return -EINVAL;

This allows k to hold a negative value (between -2147483648 and -2),
which is then used as an array index in m->xsk_map[k], which results
in an out-of-bounds access.

	spin_lock_bh(&m->lock);
	map_entry = &m->xsk_map[k]; // Out-of-bounds map_entry
	old_xs = unrcu_pointer(xchg(map_entry, NULL));  // Oob write
	if (old_xs)
		xsk_map_sock_delete(old_xs, map_entry);
	spin_unlock_bh(&m->lock);

The xchg operation can then be used to cause an out-of-bounds write.
Moreover, the invalid map_entry passed to xsk_map_sock_delete can lead
to further memory corruption.
"

It indeed results in following splat:

[76612.897343] BUG: unable to handle page fault for address: ffffc8fc2e461108
[76612.904330] #PF: supervisor write access in kernel mode
[76612.909639] #PF: error_code(0x0002) - not-present page
[76612.914855] PGD 0 P4D 0
[76612.917431] Oops: Oops: 0002 [#1] PREEMPT SMP
[76612.921859] CPU: 11 UID: 0 PID: 10318 Comm: a.out Not tainted 6.12.0-rc1+ #470
[76612.929189] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[76612.939781] RIP: 0010:xsk_map_delete_elem+0x2d/0x60
[76612.944738] Code: 00 00 41 54 55 53 48 63 2e 3b 6f 24 73 38 4c 8d a7 f8 00 00 00 48 89 fb 4c 89 e7 e8 2d bf 05 00 48 8d b4 eb 00 01 00 00 31 ff <48> 87 3e 48 85 ff 74 05 e8 16 ff ff ff 4c 89 e7 e8 3e bc 05 00 31
[76612.963774] RSP: 0018:ffffc9002e407df8 EFLAGS: 00010246
[76612.969079] RAX: 0000000000000000 RBX: ffffc9002e461000 RCX: 0000000000000000
[76612.976323] RDX: 0000000000000001 RSI: ffffc8fc2e461108 RDI: 0000000000000000
[76612.983569] RBP: ffffffff80000001 R08: 0000000000000000 R09: 0000000000000007
[76612.990812] R10: ffffc9002e407e18 R11: ffff888108a38858 R12: ffffc9002e4610f8
[76612.998060] R13: ffff888108a38858 R14: 00007ffd1ae0ac78 R15: ffffc9002e4610c0
[76613.005303] FS:  00007f80b6f59740(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[76613.013517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[76613.019349] CR2: ffffc8fc2e461108 CR3: 000000011e3ef001 CR4: 00000000007726f0
[76613.026595] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[76613.033841] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[76613.041086] PKRU: 55555554
[76613.043842] Call Trace:
[76613.046331]  <TASK>
[76613.048468]  ? __die+0x20/0x60
[76613.051581]  ? page_fault_oops+0x15a/0x450
[76613.055747]  ? search_extable+0x22/0x30
[76613.059649]  ? search_bpf_extables+0x5f/0x80
[76613.063988]  ? exc_page_fault+0xa9/0x140
[76613.067975]  ? asm_exc_page_fault+0x22/0x30
[76613.072229]  ? xsk_map_delete_elem+0x2d/0x60
[76613.076573]  ? xsk_map_delete_elem+0x23/0x60
[76613.080914]  __sys_bpf+0x19b7/0x23c0
[76613.084555]  __x64_sys_bpf+0x1a/0x20
[76613.088194]  do_syscall_64+0x37/0xb0
[76613.091832]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[76613.096962] RIP: 0033:0x7f80b6d1e88d
[76613.100592] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[76613.119631] RSP: 002b:00007ffd1ae0ac68 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
[76613.131330] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f80b6d1e88d
[76613.142632] RDX: 0000000000000098 RSI: 00007ffd1ae0ad20 RDI: 0000000000000003
[76613.153967] RBP: 00007ffd1ae0adc0 R08: 0000000000000000 R09: 0000000000000000
[76613.166030] R10: 00007f80b6f77040 R11: 0000000000000206 R12: 00007ffd1ae0aed8
[76613.177130] R13: 000055ddf42ce1e9 R14: 000055ddf42d0d98 R15: 00007f80b6fab040
[76613.188129]  </TASK>

Fix this by simply changing key type from int to u32.

Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
Reported-by: Jordy Zomer <jordyzomer@google.com>
Suggested-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xskmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index e1c526f97ce3..afa457506274 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -224,7 +224,7 @@ static long xsk_map_delete_elem(struct bpf_map *map, void *key)
 	struct xsk_map *m = container_of(map, struct xsk_map, map);
 	struct xdp_sock __rcu **map_entry;
 	struct xdp_sock *old_xs;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 
 	if (k >= map->max_entries)
 		return -EINVAL;
-- 
2.34.1


