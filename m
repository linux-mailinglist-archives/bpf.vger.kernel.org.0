Return-Path: <bpf+bounces-62653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D422AFC58A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 10:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFBA5633AA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605E2BF3D3;
	Tue,  8 Jul 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="knWrRcv7"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B212BE7CB;
	Tue,  8 Jul 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963116; cv=none; b=ePdT9w7+eeeSwUd3wcKbfCYdkcrs9o9TFAeeUSjkWAGlydtGcz74VFaZ7AL1n6cOmhUv4XD/AcqqoMFVBLeCRBwgBTkdNzEeovW51x+5UzpP7HfyZjo8UISq/IYFJxVc7avnTL+X7kYU5NgqC9KJFO6QQYkRDppqBGXtrlIHiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963116; c=relaxed/simple;
	bh=36z0UV8fxJObKtRYSJiLD5FflrpuclUu7P1ftcfJG7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3xOSRPJ5AQiwi/kuN97B9Zrr/bt2sN6FE2yJu22Wpx7WqyFTZ11u/7gC+mPEs4pH2+mIlklC228FqnT3PXtQr0a38l7sRSU9Dgzp2e9FIraFpJ1hKyQTMbmpKJmRQFXHyKKd3O/MiOQRnSAydD4Wr3D6yndmWgQBjlFdyf3F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=knWrRcv7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751963111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ip1HWxxpZVZ+acPGUerAZmLvMn8cqD2ZX+zb9hEbz8s=;
	b=knWrRcv7Z7+L5As1/5NxH5ItPaZ+LRdPXOKO/dwrpe5PJ4vUBaDrx2UxZ1fxJl1tf0V7J1
	FjEUePFz7wmdUD+x1sYOgDRO0mKLwo+7zP9kKw5tIC5WvizHEKAQ4k6a/Le5SmWQ7s+IZO
	0ty+PKg4IQchW8b+zmUrFy0zoAi9OJM=
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
Subject: [PATCH bpf-next v2 7/7] netkit: Remove location field in netkit_link
Date: Tue,  8 Jul 2025 16:22:28 +0800
Message-ID: <20250708082228.824766-8-chen.dylane@linux.dev>
In-Reply-To: <20250708082228.824766-1-chen.dylane@linux.dev>
References: <20250708082228.824766-1-chen.dylane@linux.dev>
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


