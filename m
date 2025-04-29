Return-Path: <bpf+bounces-56948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AEFAA0D8A
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2CA1A80E04
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9D2C2AC8;
	Tue, 29 Apr 2025 13:33:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090284A35;
	Tue, 29 Apr 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745933598; cv=none; b=nNbuSPbQvIntdqruFyXzJmrLWhg/Az6BAdI+yxr5uab/ow09o2O3VouP4bRG8fQeZJ6b4apVX4neVZy8v8vgCfzE4pDVTA28uE2W3tp011C8fpvN7bQrRz7m29/Gj0s+dnixoOyD29gSdlKWq/8m9XDvgcqpuvuZvTZMZ9eu+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745933598; c=relaxed/simple;
	bh=dhfOGYE/ifFpnk7DyKqjBVByUrNA1ms2k80mmNiL4Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cuYhryYh1PGbvQJHemRmDuiIRLevySOsr9V2xLmzFlt7eA9U8DGebUjuAnSManF8+Dgvazodj55ELFnFOsj69rAcCYGuJg+Soc6yO1ea0qtW0m08S1SSSEI5Y04EW45RkA6ZEp0WC9tgSIaVvL0gRxokYBV/aBXsd1i94pGNIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 53TDPMc6009034
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Apr 2025 15:25:23 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net-next] ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup
Date: Tue, 29 Apr 2025 15:24:53 +0200
Message-Id: <20250429132453.31605-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Recent updates to the locking mechanism that protects IPv6 routing tables
[1] have affected the SRv6 networking subsystem. Such changes cause
problems with some SRv6 Endpoints behaviors, like End.B6.Encaps and also
impact SRv6 counters.

Starting from commit 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and
RTM_NEWROUTE."), the inet6_rtm_newroute() function no longer needs to
acquire the RTNL lock for creating and configuring IPv6 routes and set up
lwtunnels.
The RTNL lock can be avoided because the ip6_route_add() function
finishes setting up a new route in a section protected by RCU.
This makes sure that no dev/nexthops can disappear during the operation.
Because of this, the steps for setting up lwtunnels - i.e., calling
lwtunnel_build_state() - are now done in a RCU lock section and not
under the RTNL lock anymore.

However, creating and configuring a lwtunnel instance in an
RCU-protected section can be problematic when that tunnel needs to
allocate memory using the GFP_KERNEL flag.
For example, the following trace shows what happens when an SRv6
End.B6.Encaps behavior is instantiated after commit 169fd62799e8 ("ipv6:
Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE."):

[ 3061.219696] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
[ 3061.226136] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 445, name: ip
[ 3061.232101] preempt_count: 0, expected: 0
[ 3061.235414] RCU nest depth: 1, expected: 0
[ 3061.238622] 1 lock held by ip/445:
[ 3061.241458]  #0: ffffffff83ec64a0 (rcu_read_lock){....}-{1:3}, at: ip6_route_add+0x41/0x1e0
[ 3061.248520] CPU: 1 UID: 0 PID: 445 Comm: ip Not tainted 6.15.0-rc3-micro-vm-dev-00590-ge527e891492d #2058 PREEMPT(full)
[ 3061.248532] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[ 3061.248549] Call Trace:
[ 3061.248620]  <TASK>
[ 3061.248633]  dump_stack_lvl+0xa9/0xc0
[ 3061.248846]  __might_resched+0x218/0x360
[ 3061.248871]  __kmalloc_node_track_caller_noprof+0x332/0x4e0
[ 3061.248889]  ? rcu_is_watching+0x3a/0x70
[ 3061.248902]  ? parse_nla_srh+0x56/0xa0
[ 3061.248938]  kmemdup_noprof+0x1c/0x40
[ 3061.248952]  parse_nla_srh+0x56/0xa0
[ 3061.248969]  seg6_local_build_state+0x2e0/0x580
[ 3061.248992]  ? __lock_acquire+0xaff/0x1cd0
[ 3061.249013]  ? do_raw_spin_lock+0x111/0x1d0
[ 3061.249027]  ? __pfx_seg6_local_build_state+0x10/0x10
[ 3061.249068]  ? lwtunnel_build_state+0xe1/0x3a0
[ 3061.249274]  lwtunnel_build_state+0x10d/0x3a0
[ 3061.249303]  fib_nh_common_init+0xce/0x1e0
[ 3061.249337]  ? __pfx_fib_nh_common_init+0x10/0x10
[ 3061.249352]  ? in6_dev_get+0xaf/0x1f0
[ 3061.249369]  ? __rcu_read_unlock+0x64/0x2e0
[ 3061.249392]  fib6_nh_init+0x290/0xc30
[ 3061.249422]  ? __pfx_fib6_nh_init+0x10/0x10
[ 3061.249447]  ? __lock_acquire+0xaff/0x1cd0
[ 3061.249459]  ? _raw_spin_unlock_irqrestore+0x22/0x70
[ 3061.249624]  ? ip6_route_info_create+0x423/0x520
[ 3061.249641]  ? rcu_is_watching+0x3a/0x70
[ 3061.249683]  ip6_route_info_create_nh+0x190/0x390
[ 3061.249715]  ip6_route_add+0x71/0x1e0
[ 3061.249730]  ? __pfx_inet6_rtm_newroute+0x10/0x10
[ 3061.249743]  inet6_rtm_newroute+0x426/0xc50
[ 3061.249764]  ? avc_has_perm_noaudit+0x13d/0x360
[ 3061.249853]  ? __pfx_inet6_rtm_newroute+0x10/0x10
[ 3061.249905]  ? __lock_acquire+0xaff/0x1cd0
[ 3061.249962]  ? rtnetlink_rcv_msg+0x52f/0x890
[ 3061.249996]  ? __pfx_inet6_rtm_newroute+0x10/0x10
[ 3061.250012]  rtnetlink_rcv_msg+0x551/0x890
[ 3061.250040]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[ 3061.250065]  ? __lock_acquire+0xaff/0x1cd0
[ 3061.250092]  netlink_rcv_skb+0xbd/0x1f0
[ 3061.250108]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[ 3061.250124]  ? __pfx_netlink_rcv_skb+0x10/0x10
[ 3061.250179]  ? netlink_deliver_tap+0x10b/0x700
[ 3061.250210]  netlink_unicast+0x2e7/0x410
[ 3061.250232]  ? __pfx_netlink_unicast+0x10/0x10
[ 3061.250241]  ? __lock_acquire+0xaff/0x1cd0
[ 3061.250280]  netlink_sendmsg+0x366/0x670
[ 3061.250306]  ? __pfx_netlink_sendmsg+0x10/0x10
[ 3061.250313]  ? find_held_lock+0x2d/0xa0
[ 3061.250344]  ? import_ubuf+0xbc/0xf0
[ 3061.250370]  ? __pfx_netlink_sendmsg+0x10/0x10
[ 3061.250381]  __sock_sendmsg+0x13e/0x150
[ 3061.250420]  ____sys_sendmsg+0x33d/0x450
[ 3061.250442]  ? __pfx_____sys_sendmsg+0x10/0x10
[ 3061.250453]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[ 3061.250489]  ? __pfx_slab_free_after_rcu_debug+0x10/0x10
[ 3061.250514]  ___sys_sendmsg+0xe5/0x160
[ 3061.250530]  ? __pfx____sys_sendmsg+0x10/0x10
[ 3061.250568]  ? __lock_acquire+0xaff/0x1cd0
[ 3061.250617]  ? find_held_lock+0x2d/0xa0
[ 3061.250678]  ? __virt_addr_valid+0x199/0x340
[ 3061.250704]  ? preempt_count_sub+0xf/0xc0
[ 3061.250736]  __sys_sendmsg+0xca/0x140
[ 3061.250750]  ? __pfx___sys_sendmsg+0x10/0x10
[ 3061.250786]  ? syscall_exit_to_user_mode+0xa2/0x1e0
[ 3061.250825]  do_syscall_64+0x62/0x140
[ 3061.250844]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3061.250855] RIP: 0033:0x7f0b042ef914
[ 3061.250868] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 e9 5d 0c 00 8b 00 85 c0 75 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55 48 89 f5 53
[ 3061.250876] RSP: 002b:00007ffc2d113ef8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 3061.250885] RAX: ffffffffffffffda RBX: 00000000680f93fa RCX: 00007f0b042ef914
[ 3061.250891] RDX: 0000000000000000 RSI: 00007ffc2d113f60 RDI: 0000000000000003
[ 3061.250897] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000008
[ 3061.250902] R10: fffffffffffff26d R11: 0000000000000246 R12: 0000000000000001
[ 3061.250907] R13: 000055a961f8a520 R14: 000055a961f63eae R15: 00007ffc2d115270
[ 3061.250952]  </TASK>

To solve this issue, we replace the GFP_KERNEL flag with the GFP_ATOMIC
one in those SRv6 Endpoints that need to allocate memory during the
setup phase. This change makes sure that memory allocations are handled
in a way that works with RCU critical sections.

[1] - https://lore.kernel.org/all/20250418000443.43734-1-kuniyu@amazon.com/

Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index ac1dbd492c22..ee5e448cc7a8 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1671,7 +1671,7 @@ static int parse_nla_srh(struct nlattr **attrs, struct seg6_local_lwt *slwt,
 	if (!seg6_validate_srh(srh, len, false))
 		return -EINVAL;
 
-	slwt->srh = kmemdup(srh, len, GFP_KERNEL);
+	slwt->srh = kmemdup(srh, len, GFP_ATOMIC);
 	if (!slwt->srh)
 		return -ENOMEM;
 
@@ -1911,7 +1911,7 @@ static int parse_nla_bpf(struct nlattr **attrs, struct seg6_local_lwt *slwt,
 	if (!tb[SEG6_LOCAL_BPF_PROG] || !tb[SEG6_LOCAL_BPF_PROG_NAME])
 		return -EINVAL;
 
-	slwt->bpf.name = nla_memdup(tb[SEG6_LOCAL_BPF_PROG_NAME], GFP_KERNEL);
+	slwt->bpf.name = nla_memdup(tb[SEG6_LOCAL_BPF_PROG_NAME], GFP_ATOMIC);
 	if (!slwt->bpf.name)
 		return -ENOMEM;
 
@@ -1994,7 +1994,7 @@ static int parse_nla_counters(struct nlattr **attrs,
 		return -EINVAL;
 
 	/* counters are always zero initialized */
-	pcounters = seg6_local_alloc_pcpu_counters(GFP_KERNEL);
+	pcounters = seg6_local_alloc_pcpu_counters(GFP_ATOMIC);
 	if (!pcounters)
 		return -ENOMEM;
 
-- 
2.20.1


