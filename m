Return-Path: <bpf+bounces-49552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC037A19CA8
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 03:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D6F16D0C5
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE18224FD;
	Thu, 23 Jan 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GwepcI39"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4A8F5A;
	Thu, 23 Jan 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597596; cv=none; b=bmWzPnVz7U4/TpIp3UNHSkDvBvVLoDGVQT1wBSwWkIoTyZLl/tj9hILiRvwPZ4WHoppZCIZByscvgG0A25f6CmQuWHiZ6hzE+0S9afeTN1uVaKLxXwia/yTU1kYnnVLJPUD7Jtgm7fONDN2MAT5/cE5vdtLQN/Dg0v9/Jd9+CYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597596; c=relaxed/simple;
	bh=0L+lOzuqDwvA7au8Ptv67yZ4le6S9WtRxe/Zj7PDXxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWeHQzunDfbZSgP5EFOKSCTUviVbaD7expnGknXLR7orcEIomDIJR4yQGSppXR7EyLO1u2lAn7j04sGv6i+NLPyOgWij9TYukJvqJrzLNC2BeB0kzjLULpg4RHVBlJM6bJHxDl2W2hfWScTrPspeqIxFWju5kFtYJvoTLPv7Kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GwepcI39; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737597589; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P4JL4e44Jo4xpeFGWKuHffDh6hTSU5etq3GouBCGp6Q=;
	b=GwepcI39bDB/d4oOqf1GYbiBTNCRqn6/TJyZquZlCdD2nrhfJkQPekh5q38Ao//Rm08YSjo+PjLwup5whyVuJhmmZwDvzyhXf31k3Bdb44qA6mPLjV3dD/bqTcRDT0Rfo4NrlorL7GfnwU8bVXYSP7X+SOqt2a/BmIAulzUVvng=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO9yfG5_1737597587 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 09:59:48 +0800
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
Subject: [PATCH bpf-next v7 1/6] bpf: export necessary sympols for modules with struct_ops
Date: Thu, 23 Jan 2025 09:59:37 +0800
Message-ID: <20250123015942.94810-2-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250123015942.94810-1-alibuda@linux.alibaba.com>
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
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
index 040fb1cd840b..588e9b43fc2a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1140,6 +1140,7 @@ bool bpf_struct_ops_get(const void *kdata)
 	map = __bpf_map_inc_not_zero(&st_map->map, false);
 	return !IS_ERR(map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
 
 void bpf_struct_ops_put(const void *kdata)
 {
@@ -1151,6 +1152,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0daf098e3207..85bee712b16c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1171,6 +1171,7 @@ int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size)
 
 	return src - orig_src;
 }
+EXPORT_SYMBOL_GPL(bpf_obj_name_cpy);
 
 int map_check_no_btf(const struct bpf_map *map,
 		     const struct btf *btf,
-- 
2.45.0


