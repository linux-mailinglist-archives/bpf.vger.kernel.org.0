Return-Path: <bpf+bounces-62648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B8AFC571
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E82B562983
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978562BE056;
	Tue,  8 Jul 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ugYOmMbV"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855129E111
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963011; cv=none; b=s31TUWXHKviqNPmlvuNqIyT4+yoJtNhwINqL/N1YliJOEi3gjgwpcE3wXgDMI3BrLSuI7vch4ZF2cjPVkz+844IXaKfhPZEDOnHBOZV/vLsqagaYUEiCfnCVpxMyYJOCTq6566SHR+U0dGYGyO7AN6BSImI6b4Du+kEXjM7vs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963011; c=relaxed/simple;
	bh=YslBrAgYZPoRig7rfxo1T/sFcH28GOBG7fNzhFWjPEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHoSyJT/f8WrNo/XScIMG3vbfWA14VWGqAfDWMKbzKXFnZoBsYvoki2zv5xMpJJ5KeGAj8JWK57SMlzxO/LQtrwI9WrQQP4o2NDSwVrEAgfnihtTB+3zv3KIRgkJnKITjxI/1Rg0uKnl1fjOCqHSqiJfys8vF8BrudHtilOVz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ugYOmMbV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751963007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFFj+EmUdX78YSHXH0ceZJh4m8HxnLe9oo1MhOydXdw=;
	b=ugYOmMbVKHL5YAQXXq3fcbAlUPYQieljGabIsAYmEHXFaLHCJ5RkTI/Dxt241HSsOB65ug
	X74S82uEQAbDtwwh0fLlQHGjdHvbYemGrjbNSNOuJmbWez7HKRIOIwji7aC4P6navYUJZ1
	spu6hyzBaTTyM6eb/8ENPy/MuOhxpUc=
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
Subject: [PATCH bpf-next v2 2/7] bpf: Remove attach_type in bpf_cgroup_link
Date: Tue,  8 Jul 2025 16:22:23 +0800
Message-ID: <20250708082228.824766-3-chen.dylane@linux.dev>
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

Use attach_type in bpf_link, and remove it in bpf_cgroup_link.

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


