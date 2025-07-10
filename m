Return-Path: <bpf+bounces-62878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97422AFF77A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155857AF5A7
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 03:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95528312E;
	Thu, 10 Jul 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1sn3VPx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C828134D
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117860; cv=none; b=BRgki6GmW4TzDFNC5uSoUSc0BsmQKKaVF4OE/3FdauEoqJZAF2NXsYTzuhjOqv126vnJ7oYrq8aPG11ppHkRu7C6o2JkEN1b3iSnoT2MCUZOyta7jq0rfT0AQSJA7+v4G6OK2uXNcz03lF2SRFrsL0KqRRs8fiwka14MYvw2eV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117860; c=relaxed/simple;
	bh=a/EieaXIJ8bT7jkkiX2ZZx59t++eYRQ3llfRLi3g5K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I51j6Jj+tqm4M0m2TPCYKxHyefGNz0UgaQXSd4CT4F9TZe+hegw87cyL90V7f9bpV0AVGSfopVzCdopboYpTN9B4RwqdCT1c1ORHED+CprAfmQ3rb8vus8n1+DF9wNlNdbHMeWVzAQfVj0aSc2NBn88PTTorgG2w7jM+Zjnfm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1sn3VPx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd8j8vGZOIvVNqz3neXzkZTkC2cKpor6GLc1n0oUok0=;
	b=f1sn3VPxIGZOs+yOMKRi480pNx6qKaac8eqlXhzpxB2+FC+Y8lIYGx6kAx8WbGTJBKdIdg
	C686lO4v0S0GPDlxOqFs+ah+GaIumt/AtX1TWsxvryej/yET5LtbfCXW1+4Iv4rpXvhF1o
	Qbs+TmkTK6Gd/Wkv4hjoIOX1CHRmEZQ=
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
Subject: [PATCH bpf-next v4 7/7] netkit: Remove location field in netkit_link
Date: Thu, 10 Jul 2025 11:20:38 +0800
Message-ID: <20250710032038.888700-8-chen.dylane@linux.dev>
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

Use attach_type in bpf_link to replace the location field, and
remove location field in netkit_link.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 drivers/net/netkit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5928c99eac7..492be60f2e7 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -32,7 +32,6 @@ struct netkit {
 struct netkit_link {
 	struct bpf_link link;
 	struct net_device *dev;
-	u32 location;
 };
 
 static __always_inline int
@@ -733,8 +732,8 @@ static void netkit_link_fdinfo(const struct bpf_link *link, struct seq_file *seq
 
 	seq_printf(seq, "ifindex:\t%u\n", ifindex);
 	seq_printf(seq, "attach_type:\t%u (%s)\n",
-		   nkl->location,
-		   nkl->location == BPF_NETKIT_PRIMARY ? "primary" : "peer");
+		   link->attach_type,
+		   link->attach_type == BPF_NETKIT_PRIMARY ? "primary" : "peer");
 }
 
 static int netkit_link_fill_info(const struct bpf_link *link,
@@ -749,7 +748,7 @@ static int netkit_link_fill_info(const struct bpf_link *link,
 	rtnl_unlock();
 
 	info->netkit.ifindex = ifindex;
-	info->netkit.attach_type = nkl->location;
+	info->netkit.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -776,7 +775,6 @@ static int netkit_link_init(struct netkit_link *nkl,
 {
 	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
 		      &netkit_link_lops, prog, attr->link_create.attach_type);
-	nkl->location = attr->link_create.attach_type;
 	nkl->dev = dev;
 	return bpf_link_prime(&nkl->link, link_primer);
 }
-- 
2.48.1


