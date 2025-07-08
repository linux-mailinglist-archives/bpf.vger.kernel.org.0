Return-Path: <bpf+bounces-62650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FCAFC572
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63743AC57A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8E2BDC36;
	Tue,  8 Jul 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmPl5xSJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D9429DB77
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963053; cv=none; b=ZTiaoOReLt+KB4k0gRfxdeIFRnSWgrx162u4YnPFCvB03VBS8R6Py1+Be500DXHahow9yJdt8OQ92+Dg1oX5PDM3QTtla6zWRWNmLIAhLge5baVRA1rj7N1kTo4v8rNfKDOVbsuLQH9XbscqpLDFAl2mNw57SEik2r5pOxG9uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963053; c=relaxed/simple;
	bh=SqfaLR8/C5jzJtwP4LoXDHtISetJup6uWVH5ey3lMaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyUcv3vIXPz3Qb1lDTsBp1Cd+ziFllT2HD8wd8L90Lzj2m/slET8wYb8iz8H5CNFifuW+HN4XxlnH5D2f94gjdSfP/Ua0k32kONvU4l7NQIzBpp0b73ojlDkZ58VSzuuGJ2QTQMTJPF/GWzExiHq8bgL8UAfrIt4rbQJjs0etFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmPl5xSJ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751963049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCW68eGUYsLpHCGaD0r9aeEIjmFEKVXrBCPoykv6/AU=;
	b=DmPl5xSJ7weZXo9JRp9dAi4d2vWpQypoh4HhzC9fiVQGYMBZvEQltZOgyqijRl0ki/Vize
	HQlqrR3i84nE7F9nkGjYdJjZDTn/MSnA87TsdaYHUcvYCDzB7IkJaqxWLZlQrdmpWSEtcz
	Pi+Yq1LYE0XPvQ8QXHeCO9UypMziu6Q=
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
Subject: [PATCH bpf-next v2 4/7] bpf: Remove location field in tcx_link
Date: Tue,  8 Jul 2025 16:22:25 +0800
Message-ID: <20250708082228.824766-5-chen.dylane@linux.dev>
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

Use attach_type in bpf_link to replace the location filed, and
remove location field in tcx_link.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/net/tcx.h |  1 -
 kernel/bpf/tcx.c  | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/net/tcx.h b/include/net/tcx.h
index 5ce0ce9e0c0..23a61af1354 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -20,7 +20,6 @@ struct tcx_entry {
 struct tcx_link {
 	struct bpf_link link;
 	struct net_device *dev;
-	u32 location;
 };
 
 static inline void tcx_set_ingress(struct sk_buff *skb, bool ingress)
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index e6a14f408d9..efd987ea687 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -142,7 +142,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 				u64 revision)
 {
 	struct tcx_link *tcx = tcx_link(link);
-	bool created, ingress = tcx->location == BPF_TCX_INGRESS;
+	bool created, ingress = link->attach_type == BPF_TCX_INGRESS;
 	struct bpf_mprog_entry *entry, *entry_new;
 	struct net_device *dev = tcx->dev;
 	int ret;
@@ -169,7 +169,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 static void tcx_link_release(struct bpf_link *link)
 {
 	struct tcx_link *tcx = tcx_link(link);
-	bool ingress = tcx->location == BPF_TCX_INGRESS;
+	bool ingress = link->attach_type == BPF_TCX_INGRESS;
 	struct bpf_mprog_entry *entry, *entry_new;
 	struct net_device *dev;
 	int ret = 0;
@@ -204,7 +204,7 @@ static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 			   struct bpf_prog *oprog)
 {
 	struct tcx_link *tcx = tcx_link(link);
-	bool ingress = tcx->location == BPF_TCX_INGRESS;
+	bool ingress = link->attach_type == BPF_TCX_INGRESS;
 	struct bpf_mprog_entry *entry, *entry_new;
 	struct net_device *dev;
 	int ret = 0;
@@ -260,8 +260,8 @@ static void tcx_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
 
 	seq_printf(seq, "ifindex:\t%u\n", ifindex);
 	seq_printf(seq, "attach_type:\t%u (%s)\n",
-		   tcx->location,
-		   tcx->location == BPF_TCX_INGRESS ? "ingress" : "egress");
+		   link->attach_type,
+		   link->attach_type == BPF_TCX_INGRESS ? "ingress" : "egress");
 }
 
 static int tcx_link_fill_info(const struct bpf_link *link,
@@ -276,7 +276,7 @@ static int tcx_link_fill_info(const struct bpf_link *link,
 	rtnl_unlock();
 
 	info->tcx.ifindex = ifindex;
-	info->tcx.attach_type = tcx->location;
+	info->tcx.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -303,7 +303,6 @@ static int tcx_link_init(struct tcx_link *tcx,
 {
 	bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog,
 		      attr->link_create.attach_type);
-	tcx->location = attr->link_create.attach_type;
 	tcx->dev = dev;
 	return bpf_link_prime(&tcx->link, link_primer);
 }
-- 
2.48.1


