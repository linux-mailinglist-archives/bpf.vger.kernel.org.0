Return-Path: <bpf+bounces-62747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDFAFDDF3
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4825406B2
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8AF1F09BF;
	Wed,  9 Jul 2025 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VE/WhMjR"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6941E9B19
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030615; cv=none; b=h8A2ujGm/vaKN1czwyC76ez3XylfTddKRjBnFHNsse6kuwob41RR6IDdQ1C1M6gaKlL/fAQvBq9GP8PpOX7HR+kDuzQGjlooPrverAbC3cGtwwWJVNjURm3L14h9YFR4rMHuw4nz2fAnSOLtMXzvGYPcklpzRkUV9bcruv3/kCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030615; c=relaxed/simple;
	bh=UdIgkYyOOa7hCxMjPOwfAkzf8A+cA2dmARHAg+FBH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtOxVy6CDdCjhZJNFbv+tBoA4Cea9y83QFLn7B2DCxWqVxTULfeA/MjeOn1IyNQcUqrj0SmmvJ/7kKlRJ077D55gZukY5BEeM0RcuvJe36O92gC+gGEtL7xC40aEnBQ6SYmOouv9V1u5ksaU0wntkfWxLcB9mIO5u0zbL08S3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VE/WhMjR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752030611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD8eyIMRPg4u1jgNvJQ/ElVilPMWhJf81CmtaFeXe3k=;
	b=VE/WhMjRYUoSEBsl05KdPQXbMq+ZS8rr0sk2TbD+WzUpikn6+nifvDapuEvbIk2w3DbGY6
	fsxDltr+0bSuJCbKT5SA/VRPkgqkhr6qAhaMxm4KbbK6hxUBGXZ3UkFsJ7++jPgJaizrn5
	0c+uz866yZrqhbDTI/GAXGQTbqRnqcU=
From: Tao Chen <chen.dylane@linux.dev>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 5/7] bpf: Remove attach_type in bpf_netns_link
Date: Wed,  9 Jul 2025 11:08:00 +0800
Message-ID: <20250709030802.850175-6-chen.dylane@linux.dev>
In-Reply-To: <20250709030802.850175-1-chen.dylane@linux.dev>
References: <20250709030802.850175-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in bpf_netns_link.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/net_namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 63702c86275..6d27bd97c95 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -11,7 +11,6 @@
 
 struct bpf_netns_link {
 	struct bpf_link	link;
-	enum bpf_attach_type type;
 	enum netns_bpf_attach_type netns_type;
 
 	/* We don't hold a ref to net in order to auto-detach the link
@@ -216,7 +215,7 @@ static int bpf_netns_link_fill_info(const struct bpf_link *link,
 	mutex_unlock(&netns_bpf_mutex);
 
 	info->netns.netns_ino = inum;
-	info->netns.attach_type = net_link->type;
+	info->netns.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -230,7 +229,7 @@ static void bpf_netns_link_show_fdinfo(const struct bpf_link *link,
 		   "netns_ino:\t%u\n"
 		   "attach_type:\t%u\n",
 		   info.netns.netns_ino,
-		   info.netns.attach_type);
+		   link->attach_type);
 }
 
 static const struct bpf_link_ops bpf_netns_link_ops = {
@@ -503,7 +502,6 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	bpf_link_init(&net_link->link, BPF_LINK_TYPE_NETNS,
 		      &bpf_netns_link_ops, prog, type);
 	net_link->net = net;
-	net_link->type = type;
 	net_link->netns_type = netns_type;
 
 	err = bpf_link_prime(&net_link->link, &link_primer);
-- 
2.48.1


