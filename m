Return-Path: <bpf+bounces-48045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82129A036E7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 05:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFACB3A2B27
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 04:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D769198A08;
	Tue,  7 Jan 2025 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sSHACGSE"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0FECC;
	Tue,  7 Jan 2025 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736223449; cv=none; b=P0yjE+Tp2x8aC4rdj3u/ydPecmgURr9H4+5U6zgr6Y9OWPyX59noc2uPfaHNy7r/oUcEEZiGg33ksL9mqmLUJdY+joXA4UVrrxedl5frJOelZt27aVvjaTvvTGcZAtMiuQUV74ARi/G8BockGOONvmhz6P4iPDSdI5f9uzxWDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736223449; c=relaxed/simple;
	bh=8Me0+ORdUwnQJJZusQP7gsBibbKOgKoUBm5L+YNIMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGYMokYnpO8nVSwd8qcYya/14z6AeRo0sXtqdmJ9yRi9GkkeWiByZn2PqN3WL/qk4is76nK7nAbamWMrHZhKA2ddOekTO/r8wzhLkzlVPpZPwXlxyflhd7a5NjlFdc3tWnXlsICZtVGq90unGcZVaC+CmZ4RsyTKCYexPc51xT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sSHACGSE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736223443; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GAH1Lz6yySHh0akD6UjVzqvmSG58TUkUU80VrEvWcyY=;
	b=sSHACGSEl3WG8GaAfO/5IDxNBX95rPo7e7VBOiMFhuPkKBB5IiIkrlNAikpFI2mPJdI9H9xA0dxwzoTekjWS6M9nMuWn0BDVKQfeCpMJx/4bg58Z020KOHifZtOq8cGe0ss6E9CpZ52HBw5d6NGkKril0MotKJprbX8kPcnIZYs=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WN9KZa6_1736223441 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 12:17:21 +0800
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
Subject: [PATCH bpf-next v5 1/5] bpf: export necessary sympols for modules with struct_ops
Date: Tue,  7 Jan 2025 12:17:11 +0800
Message-ID: <20250107041715.98342-2-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107041715.98342-1-alibuda@linux.alibaba.com>
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
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


