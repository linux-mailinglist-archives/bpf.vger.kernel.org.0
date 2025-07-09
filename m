Return-Path: <bpf+bounces-62749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D994AFDDF8
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 05:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0267B266B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C01F63D9;
	Wed,  9 Jul 2025 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fy6EH0Cq"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7671E7C27;
	Wed,  9 Jul 2025 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030658; cv=none; b=OitWWEHdLybUog/zZ2HSv/5RSo8du7xTl8SIsDSvRxiNaJbXnemtG9EtkCUPyURcynJOW6Zf+Xv/ikI4FpYj+liE2CjHYs5CzIuTsEAujC0z/YFGTYrq8H6Spte7IIoQTzKdoaA+GjMAXmut+kioi3PtrIZZcoqbDP11m8R128I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030658; c=relaxed/simple;
	bh=uPyve8B1VvQ+YBQnPk5iClZDvwAqMaBpfUtzv7eH4+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOHUOruPwHuqcGnqhAKhIzFMA1xvL3/Pt2ViDbyZ0OOCgGhE+Szg5v05SQvf9mJxMP4AWlc5tPCN8Ok1Fj71zyg3gqPg0kXcF8W0VuBu/mVCu3NDj9PdkvazrzFuJd/IqLjuhSsF5zU2b3DCvcPpqwVSPJ3QJ1/sE2aQNOe+4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fy6EH0Cq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752030654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/mdOWM4rga/L/OCL2xt/WG/u3qj7dKYqBet7f89t8Q=;
	b=Fy6EH0Cq3hhyZmS6WgvxMxcFaq6YNkK1oYprh9MfJ/nxmYhk83i+WOJaEi0PWEpo0HSRkE
	J7VZ6r1PrUp5zeN01EiKmwldIQXmIti6YMIhyfy3c4yLFsM9CMpWl/m+Tvicuxe+z9uO/j
	eNa1ntK1n1cykBCN5JYImojeDCWVZT8=
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
Subject: [PATCH bpf-next v3 7/7] netkit: Remove location field in netkit_link
Date: Wed,  9 Jul 2025 11:08:02 +0800
Message-ID: <20250709030802.850175-8-chen.dylane@linux.dev>
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

Use attach_type in bpf_link to replace the location field, and
remove location field in netkit_link.

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


