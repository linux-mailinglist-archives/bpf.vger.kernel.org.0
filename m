Return-Path: <bpf+bounces-67720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7FB491DD
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5415A179F3D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9C30CDB9;
	Mon,  8 Sep 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBtvtxGu"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23230CD94
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342261; cv=none; b=Jv7OG3XhTcnve5l2FK6+ZkUI2hGexkA+p5D3ShoB+ETXqumxt/M5qmOFqBgPo24+3HsWCzxWK9p+AT5QO9AdudCkCQJuYQBytiZWqsTHogkMP+NinrVnZ5f7SZKDOBAxRSi+PqI5I7i4X0D3k1vv75GMJyWbABnoZEZ831fc7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342261; c=relaxed/simple;
	bh=IMXGhZiuUIDmJquC2C+uehCjlGDb04Efc0oDqBpBOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4de0tqPu6hCQfRGjX5XfSrqO7lNgk5p+XRo8W+VYTG5vprcxpFVd1sDaq4oEXszAtKjdoXqDheH7HfQymMwJxsMCbOAbdtELAP546P5EK1yCaOex/VuI+xb7m0dMDZkgwAF3VQkO5Kcz788TefgMWm9AnRD4D4Vpcmfxa0z4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBtvtxGu; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APGlvz+t7zIqoo7asJSRvNEL8sQM7rl9aI9BXomkbE4=;
	b=DBtvtxGu6tYrVPFz73lJoKxAeMjEwD1TSD7xLMrpPAnVYIoymSi1kKGrXYaEKr4iQBKwCR
	Ig6w5X1FGOBSog9Xep2ytCyIUeumpPH+FUhvg4BbkKmIAxJY5FhPPx6S38Ot+gHn9Ck0xB
	wu357mk36K0icXCqLWrF9g/f4r5/WUk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 7/9] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
Date: Mon,  8 Sep 2025 22:36:42 +0800
Message-ID: <20250908143644.30993-8-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-1-leon.hwang@linux.dev>
References: <20250908143644.30993-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
allow updating values for all CPUs with a single value for update_elem
API.

Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
allow:

* update value for specified CPU for update_elem API.
* lookup value for specified CPU for lookup_elem API.

The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h        |  1 +
 kernel/bpf/local_storage.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2254aafc93773..c6010a2a42225 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3758,6 +3758,7 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index f63639c79902a..a4ba173e4c44f 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -186,6 +186,11 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	struct bpf_cgroup_storage *storage;
 	void __percpu *pptr;
 	u32 size;
+	int err;
+
+	err = bpf_map_check_cpu_flags(map_flags, false);
+	if (err)
+		return err;
 
 	rcu_read_lock();
 	storage = cgroup_storage_lookup(map, key, false);
@@ -212,10 +217,15 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	struct bpf_cgroup_storage *storage;
 	void __percpu *pptr;
 	u32 size;
+	int err;
 
-	if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
+	if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
 		return -EINVAL;
 
+	err = bpf_map_check_cpu_flags(map_flags, true);
+	if (err)
+		return err;
+
 	rcu_read_lock();
 	storage = cgroup_storage_lookup(map, key, false);
 	if (!storage) {
-- 
2.50.1


