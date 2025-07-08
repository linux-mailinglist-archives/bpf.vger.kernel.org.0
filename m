Return-Path: <bpf+bounces-62649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD946AFC57C
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441E156292D
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BB2BF3EB;
	Tue,  8 Jul 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kds35jWk"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF772623
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963032; cv=none; b=lGdDXF0asyD/mqSpm9+U10XEieTj09IE5Roc5qlqKHw6WfoFyfpQp7KZv8m17HqC1Xdhnye+j1kSVNVCNZgYfLD/6tNh7OyQJDKxYbBmZAs+Xv0LXsxKz1610TPyQG3ToRo2+3I4K9i+NGtx3aiEf0vURbN7mojDDSzS/DwYOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963032; c=relaxed/simple;
	bh=IfzLpa9ofM5D3fXmX67qb3ZMbp8UBmv38FQ5oGdQiRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atJuM7zFT4bQIfsMClJJVBT0cITQ5ekO1kGNc5/15o+KrY565QHd+ckEkFh3mJlPrR6swZK4LYRr29KrrlI52ja5kb2cSqBoDWPkqFRtCZRoxKxYbCUW2wAJVyLmoCso9DvAKGOOrceoIxXjOq1U1kWsGFemW3NPUyWQf/0TNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kds35jWk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751963028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ri0kPDDK6KMLWcWYPPkrrtf19kFhVkAh3t65eq9med4=;
	b=Kds35jWk/E3efhCVF6+tNydCIutbg6HxLEznpEdX0GU1LB6y88bVRJ+waQV8E0vQu8vQLF
	SYbTVuCFB3PCZT0y2KcatFt1T2o05KJUQRLnVcZHjSCc2hVi759mTpNS82d2GaIhoC+Hwj
	MlQvNoklAQuU800fyFB22aumo/xhg70=
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
Subject: [PATCH bpf-next v2 3/7] bpf: Remove attach_type in sockmap_link
Date: Tue,  8 Jul 2025 16:22:24 +0800
Message-ID: <20250708082228.824766-4-chen.dylane@linux.dev>
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

Use attach_type in bpf_link, and remove it in sockmap_link.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 net/core/sock_map.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index fbe9a33ddf1..5947b38e4f8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1709,7 +1709,6 @@ EXPORT_SYMBOL_GPL(sock_map_close);
 struct sockmap_link {
 	struct bpf_link link;
 	struct bpf_map *map;
-	enum bpf_attach_type attach_type;
 };
 
 static void sock_map_link_release(struct bpf_link *link)
@@ -1721,7 +1720,7 @@ static void sock_map_link_release(struct bpf_link *link)
 		goto out;
 
 	WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
-					  sockmap_link->attach_type));
+					  link->attach_type));
 
 	bpf_map_put_with_uref(sockmap_link->map);
 	sockmap_link->map = NULL;
@@ -1772,7 +1771,7 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 	}
 
 	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
-					sockmap_link->attach_type);
+					link->attach_type);
 	if (ret)
 		goto out;
 
@@ -1817,7 +1816,7 @@ static int sock_map_link_fill_info(const struct bpf_link *link,
 	u32 map_id = sock_map_link_get_map_id(sockmap_link);
 
 	info->sockmap.map_id = map_id;
-	info->sockmap.attach_type = sockmap_link->attach_type;
+	info->sockmap.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -1828,7 +1827,7 @@ static void sock_map_link_show_fdinfo(const struct bpf_link *link,
 	u32 map_id = sock_map_link_get_map_id(sockmap_link);
 
 	seq_printf(seq, "map_id:\t%u\n", map_id);
-	seq_printf(seq, "attach_type:\t%u\n", sockmap_link->attach_type);
+	seq_printf(seq, "attach_type:\t%u\n", link->attach_type);
 }
 
 static const struct bpf_link_ops sock_map_link_ops = {
@@ -1869,7 +1868,6 @@ int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_link_ops, prog,
 		      attach_type);
 	sockmap_link->map = map;
-	sockmap_link->attach_type = attach_type;
 
 	ret = bpf_link_prime(&sockmap_link->link, &link_primer);
 	if (ret) {
-- 
2.48.1


