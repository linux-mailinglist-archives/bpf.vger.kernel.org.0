Return-Path: <bpf+bounces-39628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053F97574B
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7B528676C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF71AC899;
	Wed, 11 Sep 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZJX3HK3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425EB1AC430;
	Wed, 11 Sep 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069077; cv=none; b=MUzvuP+yxb1ILyuIWccP0s6VCutOas4QZEEFKnReoZS8bOdOHdzYiZrKHzRgEtlq4ub3W5sBLZ1PnkoXMCdCTrqlSppOKms94HqI2lYvxHtB0abdfDUMKRZn/wl0JX4h/HlMcaj7WxxtZfPU5XrAFvxocvMgqx9Jc6f/my9wbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069077; c=relaxed/simple;
	bh=wpLd02b4jG0jt38TtMtuCb7LCdXzYfwkaSAE+4IMQL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Auak76wwsOauR7p9IYmREisUJlRB2fxqJ7Le+SluQ6PDQv7D3w5GlNPVjZ3Zai0vToSn16g5Unvc/KGmaqsL15tOYcBMxgyTkgqZLQNXFJI4ABf1EpcOgey5RZhYbTyYsKhrNuDDxXaEJkNpLgo3fzLmAJC5VLmVcssBC7hywQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZJX3HK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639B5C4CEC5;
	Wed, 11 Sep 2024 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726069076;
	bh=wpLd02b4jG0jt38TtMtuCb7LCdXzYfwkaSAE+4IMQL0=;
	h=From:Date:Subject:To:Cc:From;
	b=nZJX3HK3hO9hXR4fN3zMZkU8t0MJ90XFbexkiKyzPYJ4qurf/9sTTFQVpMSJ648Tv
	 tO2BLVRgAGkkAImolBbobZKcorcrNbWhWRPb6hrqjKAgjevg0ecmjrk7Fv4Fe10reB
	 jhSk4pDzj+iVdEki4qdq3aTmybFXqQGOBNGAmzpebkRoKkfLHzSHEz0HiqpiACJ17A
	 o0awddG2aUFZ7K8cIJslak5ZVvmlstiux5GcuCUtalX1xZQxrJut6Y9dGWJo/786cj
	 HjLPbsSnYyPnVgZ1dSRVbYQrGT26Fg5J3lhu8vHZkNc+zH4Ea3jmz6HB4McSJghQRd
	 dstVXQ89PnP0Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 11 Sep 2024 17:37:30 +0200
Subject: [PATCH net] net: netfilter: move nf flowtable bpf initialization
 in nf_flow_table_module_init()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
X-B4-Tracking: v=1; b=H4sIADm54WYC/x3MQQqEMAxA0atI1gZsKY56FXHRjskY0La0ogPi3
 S0u31/8CzIloQxDdUGiQ7IEX6DqCr6L9T9CmYtBN9o0vVLoGXkN527dSugi4xbmmIJDlj/qT9+
 yM6ZrOwVlEROV/O7H6b4fSBaAXW4AAAA=
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Florian Westphal <fw@strlen.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.14.1

Move nf flowtable bpf initialization in nf_flow_table module load
routine since nf_flow_table_bpf is part of nf_flow_table module and not
nf_flow_table_inet one. This patch allows to avoid the following kernel
warning running the reproducer below:

$modprobe nf_flow_table_inet
$rmmod nf_flow_table_inet
$modprobe nf_flow_table_inet
modprobe: ERROR: could not insert 'nf_flow_table_inet': Invalid argument

[  184.081501] ------------[ cut here ]------------
[  184.081527] WARNING: CPU: 0 PID: 1362 at kernel/bpf/btf.c:8206 btf_populate_kfunc_set+0x23c/0x330
[  184.081550] CPU: 0 UID: 0 PID: 1362 Comm: modprobe Kdump: loaded Not tainted 6.11.0-0.rc5.22.el10.x86_64 #1
[  184.081553] Hardware name: Red Hat OpenStack Compute, BIOS 1.14.0-1.module+el8.4.0+8855+a9e237a9 04/01/2014
[  184.081554] RIP: 0010:btf_populate_kfunc_set+0x23c/0x330
[  184.081558] RSP: 0018:ff22cfb38071fc90 EFLAGS: 00010202
[  184.081559] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
[  184.081560] RDX: 000000000000006e RSI: ffffffff95c00000 RDI: ff13805543436350
[  184.081561] RBP: ffffffffc0e22180 R08: ff13805543410808 R09: 000000000001ec00
[  184.081562] R10: ff13805541c8113c R11: 0000000000000010 R12: ff13805541b83c00
[  184.081563] R13: ff13805543410800 R14: 0000000000000001 R15: ffffffffc0e2259a
[  184.081564] FS:  00007fa436c46740(0000) GS:ff1380557ba00000(0000) knlGS:0000000000000000
[  184.081569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  184.081570] CR2: 000055e7b3187000 CR3: 0000000100c48003 CR4: 0000000000771ef0
[  184.081571] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  184.081572] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  184.081572] PKRU: 55555554
[  184.081574] Call Trace:
[  184.081575]  <TASK>
[  184.081578]  ? show_trace_log_lvl+0x1b0/0x2f0
[  184.081580]  ? show_trace_log_lvl+0x1b0/0x2f0
[  184.081582]  ? __register_btf_kfunc_id_set+0x199/0x200
[  184.081585]  ? btf_populate_kfunc_set+0x23c/0x330
[  184.081586]  ? __warn.cold+0x93/0xed
[  184.081590]  ? btf_populate_kfunc_set+0x23c/0x330
[  184.081592]  ? report_bug+0xff/0x140
[  184.081594]  ? handle_bug+0x3a/0x70
[  184.081596]  ? exc_invalid_op+0x17/0x70
[  184.081597]  ? asm_exc_invalid_op+0x1a/0x20
[  184.081601]  ? btf_populate_kfunc_set+0x23c/0x330
[  184.081602]  __register_btf_kfunc_id_set+0x199/0x200
[  184.081605]  ? __pfx_nf_flow_inet_module_init+0x10/0x10 [nf_flow_table_inet]
[  184.081607]  do_one_initcall+0x58/0x300
[  184.081611]  do_init_module+0x60/0x230
[  184.081614]  __do_sys_init_module+0x17a/0x1b0
[  184.081617]  do_syscall_64+0x7d/0x160
[  184.081620]  ? __count_memcg_events+0x58/0xf0
[  184.081623]  ? handle_mm_fault+0x234/0x350
[  184.081626]  ? do_user_addr_fault+0x347/0x640
[  184.081630]  ? clear_bhb_loop+0x25/0x80
[  184.081633]  ? clear_bhb_loop+0x25/0x80
[  184.081634]  ? clear_bhb_loop+0x25/0x80
[  184.081637]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  184.081639] RIP: 0033:0x7fa43652e4ce
[  184.081647] RSP: 002b:00007ffe8213be18 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[  184.081649] RAX: ffffffffffffffda RBX: 000055e7b3176c20 RCX: 00007fa43652e4ce
[  184.081650] RDX: 000055e7737fde79 RSI: 0000000000003990 RDI: 000055e7b3185380
[  184.081651] RBP: 000055e7737fde79 R08: 0000000000000007 R09: 000055e7b3179bd0
[  184.081651] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000040000
[  184.081652] R13: 000055e7b3176fa0 R14: 0000000000000000 R15: 000055e7b3179b80

Fixes: 391bb6594fd3 ("netfilter: Add bpf_xdp_flow_lookup kfunc")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_core.c | 6 ++++++
 net/netfilter/nf_flow_table_inet.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 5c1ff07eaee0..df72b0376970 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -670,8 +670,14 @@ static int __init nf_flow_table_module_init(void)
 	if (ret)
 		goto out_offload;
 
+	ret = nf_flow_register_bpf();
+	if (ret)
+		goto out_bpf;
+
 	return 0;
 
+out_bpf:
+	nf_flow_table_offload_exit();
 out_offload:
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
 	return ret;
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 8b541a080342..b0f199171932 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -101,7 +101,7 @@ static int __init nf_flow_inet_module_init(void)
 	nft_register_flowtable_type(&flowtable_ipv6);
 	nft_register_flowtable_type(&flowtable_inet);
 
-	return nf_flow_register_bpf();
+	return 0;
 }
 
 static void __exit nf_flow_inet_module_exit(void)

---
base-commit: d1aaaa2e0a6742b2bc4d851eb1a2b6390dbde2d9
change-id: 20240911-nf-flowtable-bpf-modprob-fix-2796fb448681

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


