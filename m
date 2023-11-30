Return-Path: <bpf+bounces-16238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCD7FE9A5
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 08:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAEF1C20C14
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD461F934;
	Thu, 30 Nov 2023 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8BB9;
	Wed, 29 Nov 2023 23:23:30 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxQXcqY_1701329003;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VxQXcqY_1701329003)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 15:23:28 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	dxu@dxuuu.xyz
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org
Subject: [PATCH net] net/netfilter: bpf: fix bad registration on nf_defrag
Date: Thu, 30 Nov 2023 15:23:23 +0800
Message-Id: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

We should pass a pointer to global_hook to the get_proto_defrag_hook()
instead of its value, since the passed value won't be updated even if
the request module was loaded successfully.

Log:

[   54.915713] nf_defrag_ipv4 has bad registration
[   54.915779] WARNING: CPU: 3 PID: 6323 at net/netfilter/nf_bpf_link.c:62 get_proto_defrag_hook+0x137/0x160
[   54.915835] CPU: 3 PID: 6323 Comm: fentry Kdump: loaded Tainted: G            E      6.7.0-rc2+ #35
[   54.915839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[   54.915841] RIP: 0010:get_proto_defrag_hook+0x137/0x160
[   54.915844] Code: 4f 8c e8 2c cf 68 ff 80 3d db 83 9a 01 00 0f 85 74 ff ff ff 48 89 ee 48 c7 c7 8f 12 4f 8c c6 05 c4 83 9a 01 01 e8 09 ee 5f ff <0f> 0b e9 57 ff ff ff 49 8b 3c 24 4c 63 e5 e8 36 28 6c ff 4c 89 e0
[   54.915849] RSP: 0018:ffffb676003fbdb0 EFLAGS: 00010286
[   54.915852] RAX: 0000000000000023 RBX: ffff9596503d5600 RCX: ffff95996fce08c8
[   54.915854] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95996fce08c0
[   54.915855] RBP: ffffffff8c4f12de R08: 0000000000000000 R09: 00000000fffeffff
[   54.915859] R10: ffffb676003fbc70 R11: ffffffff8d363ae8 R12: 0000000000000000
[   54.915861] R13: ffffffff8e1f75c0 R14: ffffb676003c9000 R15: 00007ffd15e78ef0
[   54.915864] FS:  00007fb6e9cab740(0000) GS:ffff95996fcc0000(0000) knlGS:0000000000000000
[   54.915867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.915868] CR2: 00007ffd15e75c40 CR3: 0000000101e62006 CR4: 0000000000360ef0
[   54.915870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.915871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.915873] Call Trace:
[   54.915891]  <TASK>
[   54.915894]  ? __warn+0x84/0x140
[   54.915905]  ? get_proto_defrag_hook+0x137/0x160
[   54.915908]  ? __report_bug+0xea/0x100
[   54.915925]  ? report_bug+0x2b/0x80
[   54.915928]  ? handle_bug+0x3c/0x70
[   54.915939]  ? exc_invalid_op+0x18/0x70
[   54.915942]  ? asm_exc_invalid_op+0x1a/0x20
[   54.915948]  ? get_proto_defrag_hook+0x137/0x160
[   54.915950]  bpf_nf_link_attach+0x1eb/0x240
[   54.915953]  link_create+0x173/0x290
[   54.915969]  __sys_bpf+0x588/0x8f0
[   54.915974]  __x64_sys_bpf+0x20/0x30
[   54.915977]  do_syscall_64+0x45/0xf0
[   54.915989]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   54.915998] RIP: 0033:0x7fb6e9daa51d
[   54.916001] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 89 0c 00 f7 d8 64 89 01 48
[   54.916003] RSP: 002b:00007ffd15e78ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[   54.916006] RAX: ffffffffffffffda RBX: 00007ffd15e78fc0 RCX: 00007fb6e9daa51d
[   54.916007] RDX: 0000000000000040 RSI: 00007ffd15e78ef0 RDI: 000000000000001c
[   54.916009] RBP: 000000000000002d R08: 00007fb6e9e73a60 R09: 0000000000000001
[   54.916010] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
[   54.916012] R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
[   54.916014]  </TASK>
[   54.916015] ---[ end trace 0000000000000000 ]---

Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/netfilter/nf_bpf_link.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index e502ec0..0e4beae 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -31,7 +31,7 @@ struct bpf_nf_link {
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 static const struct nf_defrag_hook *
 get_proto_defrag_hook(struct bpf_nf_link *link,
-		      const struct nf_defrag_hook __rcu *global_hook,
+		      const struct nf_defrag_hook __rcu **ptr_global_hook,
 		      const char *mod)
 {
 	const struct nf_defrag_hook *hook;
@@ -39,7 +39,7 @@ struct bpf_nf_link {
 
 	/* RCU protects us from races against module unloading */
 	rcu_read_lock();
-	hook = rcu_dereference(global_hook);
+	hook = rcu_dereference(*ptr_global_hook);
 	if (!hook) {
 		rcu_read_unlock();
 		err = request_module(mod);
@@ -47,7 +47,7 @@ struct bpf_nf_link {
 			return ERR_PTR(err < 0 ? err : -EINVAL);
 
 		rcu_read_lock();
-		hook = rcu_dereference(global_hook);
+		hook = rcu_dereference(*ptr_global_hook);
 	}
 
 	if (hook && try_module_get(hook->owner)) {
@@ -78,7 +78,7 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 	switch (link->hook_ops.pf) {
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
 	case NFPROTO_IPV4:
-		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
+		hook = get_proto_defrag_hook(link, &nf_defrag_v4_hook, "nf_defrag_ipv4");
 		if (IS_ERR(hook))
 			return PTR_ERR(hook);
 
@@ -87,7 +87,7 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 #endif
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 	case NFPROTO_IPV6:
-		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
+		hook = get_proto_defrag_hook(link, &nf_defrag_v6_hook, "nf_defrag_ipv6");
 		if (IS_ERR(hook))
 			return PTR_ERR(hook);
 
-- 
1.8.3.1


