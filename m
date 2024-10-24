Return-Path: <bpf+bounces-42998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B905A9ADA0B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C528357B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320D156991;
	Thu, 24 Oct 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SrSRnwdO"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD03148FE1;
	Thu, 24 Oct 2024 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737787; cv=none; b=U1JFgWHNJPP6QNM81pq4rpinVgTbwsNo6/7OJauVtU8yD2lQz+OhBriMHhNLlOGvJiwEHgDeVWr+6hVAhlsiBsHhvFs2RpfvjOWA6mvwSCJDrpSCaL7XXae+MMoNa7+YChUYwBl8Si0W7idk5+V3/ZCrJL4+Oh2O37yvTxSbTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737787; c=relaxed/simple;
	bh=d5X79DXL4sLgimgSjRQujM8BNUAy9sF0ODxvjvhAuu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uMvce7/sFtDjrYF3KhSGcGAilJjQhIAxY/nYmCJdqq6SBoZCPJjqbB/sx+VJlVonaas1Eou3EhMv59Sj5Ur0ZRkqo6i7gpUwzuvjO3LKvDGm/bKQS7kpLWj31EqBpdcqh/5H96R5JphZ/XRJun2G1+1MOnGqQtIDkiONkpsZkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SrSRnwdO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729737776; h=From:To:Subject:Date:Message-Id;
	bh=9WSL3f1ZvddR+1LLPtQi+HsSwB81wBNbkuMQQoLImBg=;
	b=SrSRnwdO7DXhWairL//VewSLjSLZW9ld3gs/ZoHJb3zAZyIbF951tLlWoCQkr311mHdYoF7y1uwQb9nD7KJy9ro1oahQx/ScS1rvEDeSVFS+n8r9+i2ZDmexEbE3Ab+zjThJxqvdfa4e0fgERCEVi2uwDq2o/9IKKki/wzGnePI=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHnU0G-_1729737774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 10:42:54 +0800
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
	bpf@vger.kernel.org,
	dtcccc@linux.alibaba.com
Subject: [PATCH bpf-next 1/4] bpf: export necessary sympols for modules
Date: Thu, 24 Oct 2024 10:42:45 +0800
Message-Id: <1729737768-124596-2-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch exports two necessary symbols for registering struct_ops
or kfunc with tristate subsystem.

Find the corresponding btf_id by name and type with
btf_find_by_name_kind().

And find the string in btf by offset with btf_str_by_offset(),
used to look up the names of structure members.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 75e4fe8..315e49b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -567,6 +567,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(btf_find_by_name_kind);
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 {
@@ -789,6 +790,7 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(btf_str_by_offset);
 
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-- 
1.8.3.1


