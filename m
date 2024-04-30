Return-Path: <bpf+bounces-28258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA48B7594
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DFD1F22FEE
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA113F44D;
	Tue, 30 Apr 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mPbi54UZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6F12D765
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479499; cv=none; b=MfFSh5L0qZE7i7ar67rY6vYw0X730I2bDxOzF/+vlj32TFvZq7UT1VsEsANEnRNgBDNBtdfKFzAd/WGd+52/VJ63fZhLDA9yuWA7vmsj371UjU9RQ20hcH/on1c9zRUl/POY/BOzNLYNVB1w3y0GOwp48ES5ArS97oLsfnAdeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479499; c=relaxed/simple;
	bh=JlDUkXQ4Ad/UDrFPJrhCz5Hzi4+XTnh6WHeQgz/yc6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2gU+4KPc4KlZIcwFua0Pzu3rX0hTpejClAYwJtzQCDx7ft7VS2S1uCypPvFQGczeHvYjarT7PQRZX+27twk4PERwGDZtstJ/dr4NxdzZLbpcGNXj9rLVLUW5YH3ahP029u0SWYPtCHGdBb1gcSKhxS4mYPbabctTz10uDnn0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mPbi54UZ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714479490; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kcQeThUMr+D776DE706wmtmLubbhjUt/tZV3QB7MQdo=;
	b=mPbi54UZEbxVJbZihKAVhpl7D0UEvPjUTdOzPfhv2rn3zcfZWlxypdWOhPyacoyusgxbN5upSHQwmTfFXKWl6K9AZshRxpG/e+32bZAUCA5kcTrmimhUCe2qIQ0bZrn+/0OOhWo3OveNZRzOqIwZbq/sCQKRUVImnvLcR2Sbw7w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W5cHy9g_1714479487;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W5cHy9g_1714479487)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 20:18:09 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	drosen@google.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next 1/2] bpf: Allow bpf_dynptr_from_skb() for tp_btf
Date: Tue, 30 Apr 2024 20:18:04 +0800
Message-Id: <20240430121805.104618-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240430121805.104618-1-lulie@linux.alibaba.com>
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making tp_btf able to use bpf_dynptr_from_skb(), which is useful for skb
parsing, especially for non-linear paged skb data. This is achieved by
adding KF_TRUSTED_ARGS flag to bpf_dynptr_from_skb and registering it
for TRACING progs. With KF_TRUSTED_ARGS, args from fentry/fexit are
excluded, so that unsafe progs like fexit/__kfree_skb are not allowed.

We also need the skb dynptr to be read-only in tp_btf. Because
may_access_direct_pkt_data() returns false by default when checking
bpf_dynptr_from_skb, there is no need to add BPF_PROG_TYPE_TRACING to it
explicitly.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 786d792ac816..399492970b8c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11990,7 +11990,7 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
 }
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
@@ -12039,6 +12039,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
-- 
2.32.0.3.g01195cf9f


