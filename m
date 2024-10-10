Return-Path: <bpf+bounces-41668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D19995C5
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32613B2184D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD11E7674;
	Thu, 10 Oct 2024 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob8C/Owi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE21A704B;
	Thu, 10 Oct 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603118; cv=none; b=DTDbwah5eolVZLnGK+hUersheZ96P0gzKsJxg+o/pZofRpAe/2G10dGkfk7bMYzFG/A3styXJZ5XVZpX9qi/bOxngmPEJqO1mlTelCVqrye+Romo3kUE7yxNJnfUXa6PzQzcuZ5CV0ByzmF9fPlL/Lxi9vKlK6rDGLI6ak1A7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603118; c=relaxed/simple;
	bh=2gPLz6z2ycy12l0rGhWRv6cSxR91h7i2zrHIqZRDp88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NKUikv/qEMhxztDmwqEnewrKyGsPjDa+dHvytqBZI4QbTT7A86Y/oAAKHp0xiuKjowaygJRdpvbl/Vrpy7VRJqbyt3CwYhVGqC8Uv9EDSms4tKwZiq4NRKiwUrWx0XXQbS2lZAxl7D7T6OGSGt5eyKWOPVKyVtiwksz5mJcP3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob8C/Owi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4713C4CEC5;
	Thu, 10 Oct 2024 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728603118;
	bh=2gPLz6z2ycy12l0rGhWRv6cSxR91h7i2zrHIqZRDp88=;
	h=From:Date:Subject:To:Cc:From;
	b=Ob8C/OwiqYDLzrh83az+uOwNtteqM+DdviUs6Q5NDQWOl+r0wEOTEADtXOe3TM+YJ
	 hhNE0TqMcIllojy2N3eOfx6SdYOhwEfClbzzROCPvD1ObloYmLy7unPgFjxWLXz63N
	 r+rTpr1wVF5F0OdM8SUicKTejTxuX4nJCWeCRYFxOmlJQDCtjVkBlFVRIYujuoWL5G
	 M7enSMogi6BOUUkAQdItEq7S4Z1kEnw72cbqlshRW+uUpGZ46IvDfSfQgMoq+99pir
	 2MWVDgqBpHJfjGRX6iHBKE1iQ6ffeV6uKiuTVDwwOYzfjGIcCoSOYrV1sYW+X0Fg8D
	 baCq2trceffOg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 11 Oct 2024 01:31:32 +0200
Subject: [PATCH net] netfilter: nf_tables: Fix memory leak in
 nf_flow_offload_xdp_setup()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flowtable-xdp-memleak-v1-1-b32aacb65b99@kernel.org>
X-B4-Tracking: v=1; b=H4sIANNjCGcC/x3MywqAIBBA0V+JWTeg9oD6lWhhOtWQPdAoIfr3p
 OVZ3PtAIM8UoM0e8HRx4H1LkHkGZtbbRMg2GZRQpRRS4uj2+9SDI4z2wJVWR3pBURlrS6NUUTe
 Q2sPTyPH/dv37fmMTJENnAAAA
X-Change-ID: 20241011-flowtable-xdp-memleak-05cdd4c22369
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

nf_flow_offload_xdp_setup routine allocates/removes entries in
nf_xdp_hashtable hash running FLOW_BLOCK_BIND/FLOW_BLOCK_UNBIND
commands. In the current codebase we have an FLOW_BLOCK_BIND/
FLOW_BLOCK_UNBIND unbalance since we do not run FLOW_BLOCK_UNBIND in
__nft_unregister_flowtable_net_hooks() triggering the following error
reported by kmeamlak:

[<00000000be65a589>] __kmalloc_cache_noprof+0x280/0x310
[<00000000c6569ad4>] nf_flow_offload_xdp_setup+0x70/0x8d0 [nf_flow_table]
[<000000001efe6e35>] nf_flow_table_offload_setup+0x324/0x610 [nf_flow_table]
[<000000005d9c9ad6>] nft_register_flowtable_net_hooks+0x3f4/0x890 [nf_tables]
[<00000000de9071ee>] nf_tables_newflowtable+0xf61/0x18c0 [nf_tables]
[<00000000924f5d86>] nfnetlink_rcv_batch+0x12c1/0x1c50 [nfnetlink]
[<000000003fa07104>] nfnetlink_rcv+0x2a3/0x320 [nfnetlink]
[<000000009fd1c990>] netlink_unicast+0x588/0x7f0
[<00000000ee126795>] netlink_sendmsg+0x702/0xba0
[<000000000ddf29fb>] ____sys_sendmsg+0x7cd/0x9a0
[<0000000027b80416>] ___sys_sendmsg+0xd6/0x140
[<00000000edfe1eb5>] __sys_sendmsg+0xba/0x150
[<000000009d5eb571>] do_syscall_64+0x47/0x110
[<0000000077c3a21e>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix the issue running FLOW_BLOCK_UNBIND command in
__nft_unregister_flowtable_net_hooks() if the nft_hook is removed.

Fixes: 89cc8f1c5f22 ("netfilter: nf_tables: Add flowtable map for xdp offload")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_tables_api.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a24fe62650a753be872a2051b34ff0aba27ef8c4..53357b61700b01048e840154dffd55a2c05062c1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8546,14 +8546,18 @@ static void nft_unregister_flowtable_hook(struct net *net,
 }
 
 static void __nft_unregister_flowtable_net_hooks(struct net *net,
-						 struct list_head *hook_list,
-					         bool release_netdev)
+						 struct nft_flowtable *flowtable,
+						 struct list_head *hook_list)
 {
 	struct nft_hook *hook, *next;
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
+		if (flowtable)
+			flowtable->data.type->setup(&flowtable->data,
+						    hook->ops.dev,
+						    FLOW_BLOCK_UNBIND);
 		nf_unregister_net_hook(net, &hook->ops);
-		if (release_netdev) {
+		if (flowtable) {
 			list_del(&hook->list);
 			kfree_rcu(hook, rcu);
 		}
@@ -8563,7 +8567,7 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 static void nft_unregister_flowtable_net_hooks(struct net *net,
 					       struct list_head *hook_list)
 {
-	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
+	__nft_unregister_flowtable_net_hooks(net, NULL, hook_list);
 }
 
 static int nft_register_flowtable_net_hooks(struct net *net,
@@ -11459,8 +11463,8 @@ static void __nft_release_hook(struct net *net, struct nft_table *table)
 	list_for_each_entry(chain, &table->chains, list)
 		__nf_tables_unregister_hook(net, table, chain, true);
 	list_for_each_entry(flowtable, &table->flowtables, list)
-		__nft_unregister_flowtable_net_hooks(net, &flowtable->hook_list,
-						     true);
+		__nft_unregister_flowtable_net_hooks(net, flowtable,
+						     &flowtable->hook_list);
 }
 
 static void __nft_release_hooks(struct net *net)

---
base-commit: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
change-id: 20241011-flowtable-xdp-memleak-05cdd4c22369

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


