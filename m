Return-Path: <bpf+bounces-62876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDDAFF776
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99C1560B87
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 03:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405E28151C;
	Thu, 10 Jul 2025 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NWvosv3s"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142D25BF14
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117817; cv=none; b=bQQqE+NN79IK66+kUL3101SPBRg774DylVeIzUv0FYm9McNDv+6RYwxaLtGRztXngks9Mx3aURxwwTCDTm7Ac4w73K4yedFZR5Y04IpyhZrWrv3Kisr+XAqLp1mXUu1z/hQcfs4P7mXrmDye8AN7zbuc63AblKUC84TNJPjZHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117817; c=relaxed/simple;
	bh=apSh/o37yEgCevje0h84Lu7bmpVlRSODBMboMBAeFHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB3eLsF3T2NnCco5gYYUafw9aNhjXkAQ/w/YdR+qLXEiw58HXIpHGA5VcferiwBtib/ezQeahp3AwHH28huli3353GbB81nD+KP8saqGUsyIbnv2puEIMwbkpkUkA889gB+ERimf9fLFK4wASYLln3G077+BMdl2LJVzvexECi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NWvosv3s; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSa1mkuyGKRufMORD6oFZCGpS3yYSkz7m6qJ45kDYMM=;
	b=NWvosv3s7G5piOuU6QDNpW40R0p5UiJOrNuP52L62CPnHFoDVzdqj76anrth2YKYTW56tx
	DfsU+3FmeucHydLBMwSkwL/088W1tiJBD8BEs30RnA1tOqfTq9Y3PMIUJeOSsmXlfxefsH
	cnE3ILmQJawYBDGPRN1NEfVdrW3bvvw=
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
Subject: [PATCH bpf-next v4 5/7] bpf: Remove attach_type in bpf_netns_link
Date: Thu, 10 Jul 2025 11:20:36 +0800
Message-ID: <20250710032038.888700-6-chen.dylane@linux.dev>
In-Reply-To: <20250710032038.888700-1-chen.dylane@linux.dev>
References: <20250710032038.888700-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in bpf_netns_link.
And move netns_type field to the end to fill the byte hole.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/net_namespace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 63702c86275..8e88201c98b 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -11,8 +11,6 @@
 
 struct bpf_netns_link {
 	struct bpf_link	link;
-	enum bpf_attach_type type;
-	enum netns_bpf_attach_type netns_type;
 
 	/* We don't hold a ref to net in order to auto-detach the link
 	 * when netns is going away. Instead we rely on pernet
@@ -21,6 +19,7 @@ struct bpf_netns_link {
 	 */
 	struct net *net;
 	struct list_head node; /* node in list of links attached to net */
+	enum netns_bpf_attach_type netns_type;
 };
 
 /* Protects updates to netns_bpf */
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


