Return-Path: <bpf+bounces-72385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6030C11F4A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20D164F24E9
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195332C326;
	Mon, 27 Oct 2025 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJD2QcuS"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA832A3C1
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607064; cv=none; b=Tv94VKBh6w8HaGE/R24rb8rWacWTP4YTjsN0DmNT0DBe74oUc3FdsgR6A7lCX/7F1/VTIDO4+vfPudjZGWk20PUixFe/pZ+RNzDmDEPUf2kGoNBxFf7nYVWpyJKSC91xZs/G8hOi2ZwoN4oT6EeAIa/LKbPFh5B9BJrp3qdcmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607064; c=relaxed/simple;
	bh=ekBQrsBPe80TpWVUSqHQRJhm/p0zZcNT6CP5E5otsgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU6tKE5z+n3ILMh01zvXU002NB2euQKGOvY9Ql/FH0UV9BmNpMqEl/d1gYgyF5S3arOS4VUaDJMVQvZQ9FW+KhQ0+XIREGBJNdUkJ6ofdShrdtiRVZsaCF804FzG1rA2fDycWZPE8o9rMAIjUTdqt5bKDQ3/Fd3JdPoaeDWTnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJD2QcuS; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pie7GrC+9+lsUm8ND6bCvId8ysPp7dmE7YlQN8G+ZkY=;
	b=lJD2QcuScgMclRJ6mDHlCLu1e/Po/2+/GKKJZqnv3su5QYU6Yn9p+hz/5DJblXQYn/HUVM
	REvI4h4hi9CbZi48THsPHxWgjBsXmbbIlEnzvgXARMru7YA1bCStqffp+NSOqSsAWR1g81
	J7Zg8jJlzKa2E2a1Bk7M0RzVoh7Tg58=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 01/23] bpf: move bpf_struct_ops_link into bpf.h
Date: Mon, 27 Oct 2025 16:17:04 -0700
Message-ID: <20251027231727.472628-2-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Move struct bpf_struct_ops_link's definition into bpf.h,
where other custom bpf links definitions are.

It's necessary to access its members from outside of generic
bpf_struct_ops implementation, which will be done by following
patches in the series.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h         | 6 ++++++
 kernel/bpf/bpf_struct_ops.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..eae907218188 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1845,6 +1845,12 @@ struct bpf_raw_tp_link {
 	u64 cookie;
 };
 
+struct bpf_struct_ops_link {
+	struct bpf_link link;
+	struct bpf_map __rcu *map;
+	wait_queue_head_t wait_hup;
+};
+
 struct bpf_link_primer {
 	struct bpf_link *link;
 	struct file *file;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a41e6730edcf..45cc5ee19dc2 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -55,12 +55,6 @@ struct bpf_struct_ops_map {
 	struct bpf_struct_ops_value kvalue;
 };
 
-struct bpf_struct_ops_link {
-	struct bpf_link link;
-	struct bpf_map __rcu *map;
-	wait_queue_head_t wait_hup;
-};
-
 static DEFINE_MUTEX(update_mutex);
 
 #define VALUE_PREFIX "bpf_struct_ops_"
-- 
2.51.0


