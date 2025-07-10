Return-Path: <bpf+bounces-62873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B37AFF76A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98E8189CABF
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 03:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150828152B;
	Thu, 10 Jul 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9lsMGY8"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9A28136B
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117754; cv=none; b=PqYBSHdTntcrILGZbw1cuBLmZ7JgQkqMus3D/LxOViW2UcJGksuyA7ySothg3nW8A63IO/JaBiJUWWga7nSVugl6QrS5etotRrsJKrk6yMSms6D6fmOcDM/tEI2eqxLECX3+kfYh71UQajmBYdCwR+xCoxXT/K6Bo9uVC+tBjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117754; c=relaxed/simple;
	bh=I7fQ5uD822jodcXBwgkxZ+NPn0hjsw7BdgvKE9+3y2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuMOPjzqk7paYA8f9Q4+JVlpZHzNa/Sbq/COIqiFdouae9M+e8HvaBSFIpR5gtWvHCfhaHiTin+q9XbpIoSV2ox2UeuHwwqObIXWGPy0zsV0zUgwqUGnmzj6OxVG4bgHOO7VskQqdR4q9ShJu9OIT0WIApvuFM/dkMrlQQVL/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9lsMGY8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WjOFulYTruqRi1qvvm5j+4u4+BBF5+SQoPHvBQ/zn0=;
	b=f9lsMGY8HYF8RFCAfn/bDc1CeGxqDxr0RSV4aNm0PkRB2dVx+fqx9BkqlnegMbv8Dx9StD
	6l769IDsmYS2egE4yKQjekk+GMRq+2kCAa+Tl71nmBwCJzZFGf9YtEgJDC1aYoHUueIly+
	qj4pJ9QTxTHmcCkM2J0KDXZrmSctk84=
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
Subject: [PATCH bpf-next v4 2/7] bpf: Remove attach_type in bpf_cgroup_link
Date: Thu, 10 Jul 2025 11:20:33 +0800
Message-ID: <20250710032038.888700-3-chen.dylane@linux.dev>
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

Use attach_type in bpf_link, and remove it in bpf_cgroup_link.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf-cgroup.h |  1 -
 kernel/bpf/cgroup.c        | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 70c8b94e797..082ccd8ad96 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -103,7 +103,6 @@ struct bpf_cgroup_storage {
 struct bpf_cgroup_link {
 	struct bpf_link link;
 	struct cgroup *cgroup;
-	enum bpf_attach_type type;
 };
 
 struct bpf_prog_list {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bacdd0ca741..72c8b50dca0 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -984,7 +984,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	struct hlist_head *progs;
 	bool found = false;
 
-	atype = bpf_cgroup_atype_find(link->type, new_prog->aux->attach_btf_id);
+	atype = bpf_cgroup_atype_find(link->link.attach_type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
 		return -EINVAL;
 
@@ -1396,8 +1396,8 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	}
 
 	WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
-				    cg_link->type, 0));
-	if (cg_link->type == BPF_LSM_CGROUP)
+				    link->attach_type, 0));
+	if (link->attach_type == BPF_LSM_CGROUP)
 		bpf_trampoline_unlink_cgroup_shim(cg_link->link.prog);
 
 	cg = cg_link->cgroup;
@@ -1439,7 +1439,7 @@ static void bpf_cgroup_link_show_fdinfo(const struct bpf_link *link,
 		   "cgroup_id:\t%llu\n"
 		   "attach_type:\t%d\n",
 		   cg_id,
-		   cg_link->type);
+		   link->attach_type);
 }
 
 static int bpf_cgroup_link_fill_link_info(const struct bpf_link *link,
@@ -1455,7 +1455,7 @@ static int bpf_cgroup_link_fill_link_info(const struct bpf_link *link,
 	cgroup_unlock();
 
 	info->cgroup.cgroup_id = cg_id;
-	info->cgroup.attach_type = cg_link->type;
+	info->cgroup.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -1497,7 +1497,6 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	bpf_link_init(&link->link, BPF_LINK_TYPE_CGROUP, &bpf_cgroup_link_lops,
 		      prog, attr->link_create.attach_type);
 	link->cgroup = cgrp;
-	link->type = attr->link_create.attach_type;
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
@@ -1506,7 +1505,7 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	}
 
 	err = cgroup_bpf_attach(cgrp, NULL, NULL, link,
-				link->type, BPF_F_ALLOW_MULTI | attr->link_create.flags,
+				link->link.attach_type, BPF_F_ALLOW_MULTI | attr->link_create.flags,
 				attr->link_create.cgroup.relative_fd,
 				attr->link_create.cgroup.expected_revision);
 	if (err) {
-- 
2.48.1


