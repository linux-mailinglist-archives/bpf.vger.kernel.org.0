Return-Path: <bpf+bounces-73319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E421C2A55A
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF57A348818
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106922BE64D;
	Mon,  3 Nov 2025 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ORKnoyz1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FA1DFF7;
	Mon,  3 Nov 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155096; cv=none; b=ViTUTxtKFLSByNiamS9GPs6gqJVc8clvuGYE1T/MPcxSuXLn6UZCLPeUWiGKR31zG60CnAYz69nVoA2jZwa8u2JrhoBIxg4TAmZXSY/d15o6eog2k1uBfzv5ytZWMqJygG526whwFWfnJMfksbCgqjP382KWg1lB7W2501hwS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155096; c=relaxed/simple;
	bh=TDyFl4b9bo6o/8uZ8pTHmIrqEqQv0nieqbOKW1nS4ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw5jt9wem14LRAdbqQek31UhZj4MhH35baj71vPdThZjomI3LHZK87VkW7ezZEubJA2v9SVCxb2tnvH82CgYdSD04OTrUFKqwCme/YrMSqaM43OsL11OKKJtUyF8m7DqbpKuKNDBu6SMTAgTZmX2RLcAwliUKs2she9g5Q9jTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ORKnoyz1; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762155091; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yu5fYthbs4VPGz0AGcEiQL+FtskjXzgmIaJS+iAS9x0=;
	b=ORKnoyz18JksUCGCYEwUe6+WLwZUBqxjf2BXeDf6m8vBLa/Hk+DqANA37aR1lVlcIav7xEy7O5TSl0tK9g1uVTXza2MC+d0782crylfSts+lD2Qa+9sg/a2nPPBb/Bc5808AHTFpjrOmH2Ld4ZfzW8KlCuTgvzjYR7P3SzttN6A=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrYjrxb_1762155088 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 15:31:29 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: ast@kernel.org,
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
	mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next v4 1/3] bpf: export necessary symbols for modules with struct_ops
Date: Mon,  3 Nov 2025 15:31:22 +0800
Message-ID: <20251103073124.43077-2-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251103073124.43077-1-alibuda@linux.alibaba.com>
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
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
index a41e6730edcf..278490683d28 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1162,6 +1162,7 @@ bool bpf_struct_ops_get(const void *kdata)
 	map = __bpf_map_inc_not_zero(&st_map->map, false);
 	return !IS_ERR(map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
 
 void bpf_struct_ops_put(const void *kdata)
 {
@@ -1173,6 +1174,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 u32 bpf_struct_ops_id(const void *kdata)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..80b86e9d3c39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1234,6 +1234,7 @@ int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size)
 
 	return src - orig_src;
 }
+EXPORT_SYMBOL_GPL(bpf_obj_name_cpy);
 
 int map_check_no_btf(const struct bpf_map *map,
 		     const struct btf *btf,
-- 
2.45.0


