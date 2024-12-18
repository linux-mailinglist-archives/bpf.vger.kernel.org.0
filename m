Return-Path: <bpf+bounces-47168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A62D9F5CFD
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF91893523
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3B13EFF3;
	Wed, 18 Dec 2024 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QgkUQ4wR"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8513C81B;
	Wed, 18 Dec 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489875; cv=none; b=SttUDIBX50rV5aZwe6CCWv9oVr5Qc6zEw1YBaVwCAymarcfAe2Xf8wMOsZn7vrnOL5ereTqSNKJxMtHiZS4e6LFOTITWCFOZTHN2ai1oBKopUSv1DnWOJRl31f5qa17QkDDiA0+PIHepZLSKEIQbibSs+Jh3mTiLjSi6VNBj9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489875; c=relaxed/simple;
	bh=8Me0+ORdUwnQJJZusQP7gsBibbKOgKoUBm5L+YNIMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5DcSQMydlEwUdCCo0moSzteLtRCzIVkESBqoB5vqjpbpNsPnx8RYH+puD/q2GebnelaZwv5bRKI/c+e8isfStE1s9r11ChhwBHPzqfUVSVUIu8aeR0uYQ15X9d+l/PlVD0a0En6QE0uyx5tQd+CQfnQDdHuXibnD4xjp9SBsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QgkUQ4wR; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734489870; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GAH1Lz6yySHh0akD6UjVzqvmSG58TUkUU80VrEvWcyY=;
	b=QgkUQ4wR4yaxnjMldItkIUu/YQf1UST2NbfDV29GgC255tQygnkLpL1rXXuCCVIEpYZvYIRZ5LpGTfngFzW/bS9GyuC3m3CZ95XI2YC90CGO4ZMiKO/Kbs7wnwnZzIJOv5Pz5kipM/BFVcA6AquWnPKPGujMGvms6RaV61yDejY=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLko6dn_1734489867 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 10:44:28 +0800
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
Subject: [PATCH bpf-next v3 1/5] bpf: export necessary sympols for modules with struct_ops
Date: Wed, 18 Dec 2024 10:44:17 +0800
Message-ID: <20241218024422.23423-2-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218024422.23423-1-alibuda@linux.alibaba.com>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
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


