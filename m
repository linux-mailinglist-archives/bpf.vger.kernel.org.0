Return-Path: <bpf+bounces-54206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D588A65662
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988EF7A9406
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E319CC28;
	Mon, 17 Mar 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="easnEXZ+"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8FB1A0BCD;
	Mon, 17 Mar 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226433; cv=none; b=DI1CeyA8Trq/fdbOWkjJ69fisc0rBw+ZO2XQ2KB/WgPuy57ygNqXOAFsHhYV+U9mT31mtDnJAw3B8zbizdc6rHK6TknCiTe8pMz/D9iNm7tIGxjEe2Cdj4Kn1ZbwCvTkbO77SThyB7IAaQHXQLNzyZ+N9R6Ll94RZwxq/GiKpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226433; c=relaxed/simple;
	bh=7z8tSDnE7yDv4tllSCBfzvQeclZzW6y92veuMcHw0fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojZkPayls+Ht53+wj0pJx0TNxb3ufdHJAtKAuVz6HPCI7ZoclY7diF2zN9mSVgLYO985zyta0g3P/1qURwxMbuiv429i9BmQj0vQxTN766OXD+g6lc3elKO5FhyzN2Jlra290+U4EZbHzHsm1wDWSp/evDRSqU2L3FdFdgZ+MBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=easnEXZ+; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 34E53C0008E0;
	Mon, 17 Mar 2025 08:47:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 34E53C0008E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742226429;
	bh=7z8tSDnE7yDv4tllSCBfzvQeclZzW6y92veuMcHw0fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=easnEXZ+HsLJsz0bTYrTCg6Srz/UdQt1L3mcCEJ8ntPB/UHj+V7JmtAjv3igygutr
	 OT+bicdiKOotmognuAm7r47D/ydcJ4V+7iX+3CqF1PZgvG+CMF2t9pbIWjfE5frRvE
	 VpwLfM/fzJniLX1QAS6aPSqRbR1cSljM23WOQGHE=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 0ED854002F45;
	Mon, 17 Mar 2025 11:47:06 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Felix Huettner <felix.huettner@mail.schwarz>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <simon.horman@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Carlos Soto <carlos.soto@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Pravin B Shelar <pshelar@ovn.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Andrii Nakryiko <andriin@fb.com>,
	Sasha Levin <sashal@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>,
	Xin Long <lucien.xin@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	dev@openvswitch.org (open list:OPENVSWITCH),
	bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH stable 5.15 1/2] net: openvswitch: fix race on port output
Date: Mon, 17 Mar 2025 08:47:02 -0700
Message-Id: <20250317154703.3671421-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317154703.3671421-1-florian.fainelli@broadcom.com>
References: <20250317154703.3671421-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Huettner <felix.huettner@mail.schwarz>

[ Upstream commit 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8 ]

assume the following setup on a single machine:
1. An openvswitch instance with one bridge and default flows
2. two network namespaces "server" and "client"
3. two ovs interfaces "server" and "client" on the bridge
4. for each ovs interface a veth pair with a matching name and 32 rx and
   tx queues
5. move the ends of the veth pairs to the respective network namespaces
6. assign ip addresses to each of the veth ends in the namespaces (needs
   to be the same subnet)
7. start some http server on the server network namespace
8. test if a client in the client namespace can reach the http server

when following the actions below the host has a chance of getting a cpu
stuck in a infinite loop:
1. send a large amount of parallel requests to the http server (around
   3000 curls should work)
2. in parallel delete the network namespace (do not delete interfaces or
   stop the server, just kill the namespace)

there is a low chance that this will cause the below kernel cpu stuck
message. If this does not happen just retry.
Below there is also the output of bpftrace for the functions mentioned
in the output.

The series of events happening here is:
1. the network namespace is deleted calling
   `unregister_netdevice_many_notify` somewhere in the process
2. this sets first `NETREG_UNREGISTERING` on both ends of the veth and
   then runs `synchronize_net`
3. it then calls `call_netdevice_notifiers` with `NETDEV_UNREGISTER`
4. this is then handled by `dp_device_event` which calls
   `ovs_netdev_detach_dev` (if a vport is found, which is the case for
   the veth interface attached to ovs)
5. this removes the rx_handlers of the device but does not prevent
   packages to be sent to the device
6. `dp_device_event` then queues the vport deletion to work in
   background as a ovs_lock is needed that we do not hold in the
   unregistration path
7. `unregister_netdevice_many_notify` continues to call
   `netdev_unregister_kobject` which sets `real_num_tx_queues` to 0
8. port deletion continues (but details are not relevant for this issue)
9. at some future point the background task deletes the vport

If after 7. but before 9. a packet is send to the ovs vport (which is
not deleted at this point in time) which forwards it to the
`dev_queue_xmit` flow even though the device is unregistering.
In `skb_tx_hash` (which is called in the `dev_queue_xmit`) path there is
a while loop (if the packet has a rx_queue recorded) that is infinite if
`dev->real_num_tx_queues` is zero.

To prevent this from happening we update `do_output` to handle devices
without carrier the same as if the device is not found (which would
be the code path after 9. is done).

Additionally we now produce a warning in `skb_tx_hash` if we will hit
the infinite loop.

bpftrace (first word is function name):

__dev_queue_xmit server: real_num_tx_queues: 1, cpu: 2, pid: 28024, tid: 28024, skb_addr: 0xffff9edb6f207000, reg_state: 1
netdev_core_pick_tx server: addr: 0xffff9f0a46d4a000 real_num_tx_queues: 1, cpu: 2, pid: 28024, tid: 28024, skb_addr: 0xffff9edb6f207000, reg_state: 1
dp_device_event server: real_num_tx_queues: 1 cpu 9, pid: 21024, tid: 21024, event 2, reg_state: 1
synchronize_rcu_expedited: cpu 9, pid: 21024, tid: 21024
synchronize_rcu_expedited: cpu 9, pid: 21024, tid: 21024
synchronize_rcu_expedited: cpu 9, pid: 21024, tid: 21024
synchronize_rcu_expedited: cpu 9, pid: 21024, tid: 21024
dp_device_event server: real_num_tx_queues: 1 cpu 9, pid: 21024, tid: 21024, event 6, reg_state: 2
ovs_netdev_detach_dev server: real_num_tx_queues: 1 cpu 9, pid: 21024, tid: 21024, reg_state: 2
netdev_rx_handler_unregister server: real_num_tx_queues: 1, cpu: 9, pid: 21024, tid: 21024, reg_state: 2
synchronize_rcu_expedited: cpu 9, pid: 21024, tid: 21024
netdev_rx_handler_unregister ret server: real_num_tx_queues: 1, cpu: 9, pid: 21024, tid: 21024, reg_state: 2
dp_device_event server: real_num_tx_queues: 1 cpu 9, pid: 21024, tid: 21024, event 27, reg_state: 2
dp_device_event server: real_num_tx_queues: 1 cpu 9, pid: 21024, tid: 21024, event 22, reg_state: 2
dp_device_event server: real_num_tx_queues: 1 cpu 9, pid: 21024, tid: 21024, event 18, reg_state: 2
netdev_unregister_kobject: real_num_tx_queues: 1, cpu: 9, pid: 21024, tid: 21024
synchronize_rcu_expedited: cpu 9, pid: 21024, tid: 21024
ovs_vport_send server: real_num_tx_queues: 0, cpu: 2, pid: 28024, tid: 28024, skb_addr: 0xffff9edb6f207000, reg_state: 2
__dev_queue_xmit server: real_num_tx_queues: 0, cpu: 2, pid: 28024, tid: 28024, skb_addr: 0xffff9edb6f207000, reg_state: 2
netdev_core_pick_tx server: addr: 0xffff9f0a46d4a000 real_num_tx_queues: 0, cpu: 2, pid: 28024, tid: 28024, skb_addr: 0xffff9edb6f207000, reg_state: 2
broken device server: real_num_tx_queues: 0, cpu: 2, pid: 28024, tid: 28024
ovs_dp_detach_port server: real_num_tx_queues: 0 cpu 9, pid: 9124, tid: 9124, reg_state: 2
synchronize_rcu_expedited: cpu 9, pid: 33604, tid: 33604

stuck message:

watchdog: BUG: soft lockup - CPU#5 stuck for 26s! [curl:1929279]
Modules linked in: veth pktgen bridge stp llc ip_set_hash_net nft_counter xt_set nft_compat nf_tables ip_set_hash_ip ip_set nfnetlink_cttimeout nfnetlink openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tls binfmt_misc nls_iso8859_1 input_leds joydev serio_raw dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sch_fq_codel drm efi_pstore virtio_rng ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel virtio_net ahci net_failover crypto_simd cryptd psmouse libahci virtio_blk failover
CPU: 5 PID: 1929279 Comm: curl Not tainted 5.15.0-67-generic #74-Ubuntu
Hardware name: OpenStack Foundation OpenStack Nova, BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:netdev_pick_tx+0xf1/0x320
Code: 00 00 8d 48 ff 0f b7 c1 66 39 ca 0f 86 e9 01 00 00 45 0f b7 ff 41 39 c7 0f 87 5b 01 00 00 44 29 f8 41 39 c7 0f 87 4f 01 00 00 <eb> f2 0f 1f 44 00 00 49 8b 94 24 28 04 00 00 48 85 d2 0f 84 53 01
RSP: 0018:ffffb78b40298820 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff9c8773adc2e0 RCX: 000000000000083f
RDX: 0000000000000000 RSI: ffff9c8773adc2e0 RDI: ffff9c870a25e000
RBP: ffffb78b40298858 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c870a25e000
R13: ffff9c870a25e000 R14: ffff9c87fe043480 R15: 0000000000000000
FS:  00007f7b80008f00(0000) GS:ffff9c8e5f740000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b80f6a0b0 CR3: 0000000329d66000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 netdev_core_pick_tx+0xa4/0xb0
 __dev_queue_xmit+0xf8/0x510
 ? __bpf_prog_exit+0x1e/0x30
 dev_queue_xmit+0x10/0x20
 ovs_vport_send+0xad/0x170 [openvswitch]
 do_output+0x59/0x180 [openvswitch]
 do_execute_actions+0xa80/0xaa0 [openvswitch]
 ? kfree+0x1/0x250
 ? kfree+0x1/0x250
 ? kprobe_perf_func+0x4f/0x2b0
 ? flow_lookup.constprop.0+0x5c/0x110 [openvswitch]
 ovs_execute_actions+0x4c/0x120 [openvswitch]
 ovs_dp_process_packet+0xa1/0x200 [openvswitch]
 ? ovs_ct_update_key.isra.0+0xa8/0x120 [openvswitch]
 ? ovs_ct_fill_key+0x1d/0x30 [openvswitch]
 ? ovs_flow_key_extract+0x2db/0x350 [openvswitch]
 ovs_vport_receive+0x77/0xd0 [openvswitch]
 ? __htab_map_lookup_elem+0x4e/0x60
 ? bpf_prog_680e8aff8547aec1_kfree+0x3b/0x714
 ? trace_call_bpf+0xc8/0x150
 ? kfree+0x1/0x250
 ? kfree+0x1/0x250
 ? kprobe_perf_func+0x4f/0x2b0
 ? kprobe_perf_func+0x4f/0x2b0
 ? __mod_memcg_lruvec_state+0x63/0xe0
 netdev_port_receive+0xc4/0x180 [openvswitch]
 ? netdev_port_receive+0x180/0x180 [openvswitch]
 netdev_frame_hook+0x1f/0x40 [openvswitch]
 __netif_receive_skb_core.constprop.0+0x23d/0xf00
 __netif_receive_skb_one_core+0x3f/0xa0
 __netif_receive_skb+0x15/0x60
 process_backlog+0x9e/0x170
 __napi_poll+0x33/0x180
 net_rx_action+0x126/0x280
 ? ttwu_do_activate+0x72/0xf0
 __do_softirq+0xd9/0x2e7
 ? rcu_report_exp_cpu_mult+0x1b0/0x1b0
 do_softirq+0x7d/0xb0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x54/0x60
 ip_finish_output2+0x191/0x460
 __ip_finish_output+0xb7/0x180
 ip_finish_output+0x2e/0xc0
 ip_output+0x78/0x100
 ? __ip_finish_output+0x180/0x180
 ip_local_out+0x5e/0x70
 __ip_queue_xmit+0x184/0x440
 ? tcp_syn_options+0x1f9/0x300
 ip_queue_xmit+0x15/0x20
 __tcp_transmit_skb+0x910/0x9c0
 ? __mod_memcg_state+0x44/0xa0
 tcp_connect+0x437/0x4e0
 ? ktime_get_with_offset+0x60/0xf0
 tcp_v4_connect+0x436/0x530
 __inet_stream_connect+0xd4/0x3a0
 ? kprobe_perf_func+0x4f/0x2b0
 ? aa_sk_perm+0x43/0x1c0
 inet_stream_connect+0x3b/0x60
 __sys_connect_file+0x63/0x70
 __sys_connect+0xa6/0xd0
 ? setfl+0x108/0x170
 ? do_fcntl+0xe8/0x5a0
 __x64_sys_connect+0x18/0x20
 do_syscall_64+0x5c/0xc0
 ? __x64_sys_fcntl+0xa9/0xd0
 ? exit_to_user_mode_prepare+0x37/0xb0
 ? syscall_exit_to_user_mode+0x27/0x50
 ? do_syscall_64+0x69/0xc0
 ? __sys_setsockopt+0xea/0x1e0
 ? exit_to_user_mode_prepare+0x37/0xb0
 ? syscall_exit_to_user_mode+0x27/0x50
 ? __x64_sys_setsockopt+0x1f/0x30
 ? do_syscall_64+0x69/0xc0
 ? irqentry_exit+0x1d/0x30
 ? exc_page_fault+0x89/0x170
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f7b8101c6a7
Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 18 89 54 24 0c 48 89 34 24 89
RSP: 002b:00007ffffd6b2198 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7b8101c6a7
RDX: 0000000000000010 RSI: 00007ffffd6b2360 RDI: 0000000000000005
RBP: 0000561f1370d560 R08: 00002795ad21d1ac R09: 0030312e302e302e
R10: 00007ffffd73f080 R11: 0000000000000246 R12: 0000561f1370c410
R13: 0000000000000000 R14: 0000000000000005 R15: 0000000000000000
 </TASK>

Fixes: 7f8a436eaa2c ("openvswitch: Add conntrack action")
Co-developed-by: Luca Czesla <luca.czesla@mail.schwarz>
Signed-off-by: Luca Czesla <luca.czesla@mail.schwarz>
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 81f9fd0c5830..966c02efc8f7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3231,6 +3231,7 @@ static u16 skb_tx_hash(const struct net_device *dev,
 	}
 
 	if (skb_rx_queue_recorded(skb)) {
+		DEBUG_NET_WARN_ON_ONCE(qcount == 0);
 		hash = skb_get_rx_queue(skb);
 		if (hash >= qoffset)
 			hash -= qoffset;
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 85af0e9e0ac6..9b07e2172c94 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -913,7 +913,7 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport)) {
+	if (likely(vport && netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-- 
2.34.1


