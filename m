Return-Path: <bpf+bounces-62518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F0AFB7C4
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63C91AA747C
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2CA1FE47C;
	Mon,  7 Jul 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BmVkK7u+"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF881EB9E1
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903001; cv=none; b=m9FRwr3P9MjuG6QBpYCV8zu+bpXPLxzdvuH9ECpibY1bOkIb9c6RT6o85mtaJzwbkyU+w0HTg1tMIwcnIAGOPaAEI9l5d8ws8+DzLqqF5110Df1Sgnp+U5gGnwU5OpjpwzinlmUxmJLEREDxDwc1KxOscbmapMGG5oVFb6+GIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903001; c=relaxed/simple;
	bh=7JjTGV2EjX+W7UtcP012g5rTZpgzgtn1ezb7Y2UDimQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQAjx411RGq3YHAHwD+p08eN/GhVgWzCiPZjtpsp+F1P8sfavOGpFHHmXIkIXUBkQHZg4b8EgaUpBEMIVTyPw0f99CrUAAf4zw9ZXDQ2YTVQuicGO1B3YObL1dQlQfyl00tGRjEH8sGD+1PUySOt924R38pEJyqwSBNgnajw7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BmVkK7u+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751902997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDpmQYuK0vQauknx7TQlfoEHnUsAxwnLcxPxoWYrPKA=;
	b=BmVkK7u+CtV+emNIyiPJlmwv2X3VBQJSqMMnfn3tbTYNgnWS2WT3JAp8kYI0i2uNXSeffr
	h+kP8OPr6EubIOkPsfN1RrDm0iVgIVENBuM7s81elTBD9YdRZXKsWoRSP7TfAsOBC/lRUx
	eutM/ZkWcqid0v5Aei3g+Yx1hEk9fjs=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 6/6] bpf: Remove attach_type in bpf_tracing_link
Date: Mon,  7 Jul 2025 23:39:16 +0800
Message-ID: <20250707153916.802802-7-chen.dylane@linux.dev>
In-Reply-To: <20250707153916.802802-1-chen.dylane@linux.dev>
References: <20250707153916.802802-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in bpf_tracing_link.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h  | 1 -
 kernel/bpf/syscall.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 12a965362de..9c4ed6b372b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1783,7 +1783,6 @@ struct bpf_shim_tramp_link {
 
 struct bpf_tracing_link {
 	struct bpf_tramp_link link;
-	enum bpf_attach_type attach_type;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14883b3040a..bed523bf92c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3414,7 +3414,7 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 		   "target_obj_id:\t%u\n"
 		   "target_btf_id:\t%u\n"
 		   "cookie:\t%llu\n",
-		   tr_link->attach_type,
+		   link->attach_type,
 		   target_obj_id,
 		   target_btf_id,
 		   tr_link->link.cookie);
@@ -3426,7 +3426,7 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
 
-	info->tracing.attach_type = tr_link->attach_type;
+	info->tracing.attach_type = link->attach_type;
 	info->tracing.cookie = tr_link->link.cookie;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
 				  &info->tracing.target_obj_id,
@@ -3516,7 +3516,6 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog, attach_type);
 
-	link->attach_type = prog->expected_attach_type;
 	link->link.cookie = bpf_cookie;
 
 	mutex_lock(&prog->aux->dst_mutex);
-- 
2.48.1


