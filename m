Return-Path: <bpf+bounces-75730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E2C92804
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78ED24E42B4
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663B2949E0;
	Fri, 28 Nov 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="g235KAHv"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A636285406;
	Fri, 28 Nov 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345952; cv=none; b=GVr2Y5pljrNi232pO6P8ST+EWOCOODIr9Mjl/VBaZ0GOa6399X8Cj+NyPemkExcxTBP/BrIU+Q46yNGm7O3EgyfhZOQoVXBQ4A6QDxwREuPvndf1NKxsqr7A6k5lzCXXICz7F7TzntjiOn40wEJ48X1LAhgYRVZvT3vSpXifxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345952; c=relaxed/simple;
	bh=umV4AvM5Td2PovaLZCG5xrOPAeAtEpzckpoadZ6rLbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyfI0IbR12DGJAiHpUcp7vGoMIRB9e7zrVjimiZ2k6+dNskmhw87ZdLIJWJfFXuCaQbhATrZ28J31nZHvZlw1ql4KBVevO5B8jtIOJ5CFzCmOqNar/DQL0RkswHykGzLHoWw7HUmP2Lr/KP0WhVdwLhpslrkWLhYMsLP7BPRQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=g235KAHv; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764345950; x=1795881950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VdXbYQQWDeV6NB+mW4weF4J48wztQNVdJMZo4ex3q8U=;
  b=g235KAHviXuFWD4x6nZAS+nvIbxU/tHC1Fthsj3BQuy3OkaBm5cLw0yW
   CSMOqIiqUY7wL2HJxhIP8JA5xeu7R+r9GxTjMwG3XgIzeVRIf4KIuHNmE
   W0ABZv7U6n9DnOgRwq1n+flk4dr7RC26+Bj5bCHos6ttdabqe3tyqEWG/
   jtdPtOFZgeNDRpbyv7vmQ8/oejP1d2kobWrjvx07VnclOyRgYRa4JW2YX
   SByrN4JxB4AQ9Ryuoe7LXlJQdy1QI7t7657PCLcbMNkLPEs2ZBp7WuxDu
   9xSrjd9jjswcCzqdob4/7P5PnzHMvPihuDnM9iYHR6zF1dCXkY3+0Xm43
   g==;
X-CSE-ConnectionGUID: v0Nx/jCmQBOKAocrbmYXwA==
X-CSE-MsgGUID: G2muaTjCSG2jJH1mUP12RA==
X-IronPort-AV: E=Sophos;i="6.20,234,1758585600"; 
   d="scan'208";a="7816052"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 16:05:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:20115]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.255:2525] with esmtp (Farcaster)
 id 5d6d7ada-11ed-463c-9326-d95838181b37; Fri, 28 Nov 2025 16:05:44 +0000 (UTC)
X-Farcaster-Flow-ID: 5d6d7ada-11ed-463c-9326-d95838181b37
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 16:05:44 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 16:05:41 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Shuah Khan <shuah@kernel.org>, <kohei.enju@gmail.com>,
	Kohei Enju <enjuk@amazon.com>
Subject: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
Date: Sat, 29 Nov 2025 01:04:54 +0900
Message-ID: <20251128160504.57844-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251128160504.57844-1-enjuk@amazon.com>
References: <20251128160504.57844-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
errors other than -ENOMEM, such as -EBADF or -EINVAL.

However, __cpu_map_entry_alloc() returns NULL on all failures, and
cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
As a result, user space always receives -ENOMEM regardless of the actual
underlying error.

Examples of unexpected behavior:
  - Nonexistent fd  : -ENOMEM (should be -EBADF)
  - Non-BPF fd      : -ENOMEM (should be -EINVAL)
  - Bad attach type : -ENOMEM (should be -EINVAL)

Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
and have cpu_map_update_elem() propagate this error.

Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 kernel/bpf/cpumap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..04171fbc39cb 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -430,7 +430,7 @@ static struct bpf_cpu_map_entry *
 __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 		      u32 cpu)
 {
-	int numa, err, i, fd = value->bpf_prog.fd;
+	int numa, err = -ENOMEM, i, fd = value->bpf_prog.fd;
 	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	struct xdp_bulk_queue *bq;
@@ -440,7 +440,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 
 	rcpu = bpf_map_kmalloc_node(map, sizeof(*rcpu), gfp | __GFP_ZERO, numa);
 	if (!rcpu)
-		return NULL;
+		return ERR_PTR(err);
 
 	/* Alloc percpu bulkq */
 	rcpu->bulkq = bpf_map_alloc_percpu(map, sizeof(*rcpu->bulkq),
@@ -468,16 +468,21 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->value.qsize  = value->qsize;
 	gro_init(&rcpu->gro);
 
-	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
-		goto free_ptr_ring;
+	if (fd > 0) {
+		err = __cpu_map_load_bpf_program(rcpu, map, fd);
+		if (err)
+			goto free_ptr_ring;
+	}
 
 	/* Setup kthread */
 	init_completion(&rcpu->kthread_running);
 	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
 					       "cpumap/%d/map:%d", cpu,
 					       map->id);
-	if (IS_ERR(rcpu->kthread))
+	if (IS_ERR(rcpu->kthread)) {
+		err = PTR_ERR(rcpu->kthread);
 		goto free_prog;
+	}
 
 	/* Make sure kthread runs on a single CPU */
 	kthread_bind(rcpu->kthread, cpu);
@@ -503,7 +508,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	free_percpu(rcpu->bulkq);
 free_rcu:
 	kfree(rcpu);
-	return NULL;
+	return ERR_PTR(err);
 }
 
 static void __cpu_map_entry_free(struct work_struct *work)
@@ -596,8 +601,8 @@ static long cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
 	} else {
 		/* Updating qsize cause re-allocation of bpf_cpu_map_entry */
 		rcpu = __cpu_map_entry_alloc(map, &cpumap_value, key_cpu);
-		if (!rcpu)
-			return -ENOMEM;
+		if (IS_ERR(rcpu))
+			return PTR_ERR(rcpu);
 	}
 	rcu_read_lock();
 	__cpu_map_entry_replace(cmap, key_cpu, rcpu);
-- 
2.51.0


