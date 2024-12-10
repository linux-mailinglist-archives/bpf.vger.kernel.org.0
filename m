Return-Path: <bpf+bounces-46476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F569EA6E9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F06B168276
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AC2248B0;
	Tue, 10 Dec 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sxlmZFw7"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123394EB48;
	Tue, 10 Dec 2024 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803457; cv=none; b=mxdKILoomurkKDMFAvyg/CJqxsfIgOV8nr+BaPFAxUtASblF2R15zGDbdU3NERu2Htb536xbDNu3m5TdM46Sdhwl8PqfPzDKm4/YbY+lrEBsdAVDKWCEIKwxTkBWb9i9FgRou4FdMPetpELGltHM246ZHwPyWSjSp8uZ71DodG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803457; c=relaxed/simple;
	bh=8Me0+ORdUwnQJJZusQP7gsBibbKOgKoUBm5L+YNIMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXKkKB32PC2JxTnMORP+cyw8WwEsK5Dn3C/mxve5GzMgfsf5hAZRJUZ0Jq49n5intLzZu3t7PJk1mAULs9+JVABMbDlyulopoo1o6+3PHhqEldKmGXXTk2FiVH/XjS74SUvRRyaKBVAVvOWusgvYTqZlz7AcWO/6C4DXir9GhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sxlmZFw7; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733803452; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GAH1Lz6yySHh0akD6UjVzqvmSG58TUkUU80VrEvWcyY=;
	b=sxlmZFw7s6VzJfVmzdCfdKQImSPYnNajXlQuwK1YZA3kyit6qSdUXptcwxPfQd9zBMJyVm9KZrWZpHQXwSnfFmod59oIy0ucs6OPhtaWJuYINfC1cB5KeDYZUtuurZqEiXy7geF82SGH8RsErALM3yN0tK0NzkyzkLK3muZjWJU=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDSEXv_1733803449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 12:04:10 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/5] bpf: export necessary sympols for modules with struct_ops
Date: Tue, 10 Dec 2024 12:04:00 +0800
Message-ID: <20241210040404.10606-2-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241210040404.10606-1-alibuda@linux.alibaba.com>
References: <20241210040404.10606-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exports three necessary symbols for implementing struct_ops with
tristate subsystem.

To hold or release refcnt of struct_ops refcnt by inline funcs
bpf_try_module_get and bpf_module_put which use bpf_struct_ops_get(put)
conditionally.

And to copy obj name from one to the other with effective checks by
bpf_obj_name_cpy.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 kernel/bpf/bpf_struct_ops.c | 2 ++
 kernel/bpf/syscall.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 606efe32485a..00c212e0ad39 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1119,6 +1119,7 @@ bool bpf_struct_ops_get(const void *kdata)
 	map = __bpf_map_inc_not_zero(&st_map->map, false);
 	return !IS_ERR(map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
 
 void bpf_struct_ops_put(const void *kdata)
 {
@@ -1130,6 +1131,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5684e8ce132d..62238ec989dc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1167,6 +1167,7 @@ int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size)
 
 	return src - orig_src;
 }
+EXPORT_SYMBOL_GPL(bpf_obj_name_cpy);
 
 int map_check_no_btf(const struct bpf_map *map,
 		     const struct btf *btf,
-- 
2.45.0


