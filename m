Return-Path: <bpf+bounces-41194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07483994236
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCC92902D2
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E61F12ED;
	Tue,  8 Oct 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wcslBufv"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A921EF94F;
	Tue,  8 Oct 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374969; cv=none; b=ff62gyhWqoaNztou3ELv48Z+A9adViZizBECmjrQtKKkm3i+gu8kG0eYyOaYlrmkdkSQzcPbLEVdrb4FoSuuwfh5Km+GynfQxh5ULTHVu71hUSCnoEmjweTCwBsjWpVulbbPiM6O4NvAxmNVNi4NvehZrlWkswx2dllJSMf4Oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374969; c=relaxed/simple;
	bh=8TWrMAqz+8PV+QIuzBMLugBELPe9nkZP3HMj0ti5P9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6zhlpeK42xPjHmZ51dvvGyXAMQVs8QHqXSpggpGZqBSt1NKMG4AUM7e653OSUuZr59wH7Ash78Ys1EY9plPf3aL/gWVC2CPlPauSLwCYhwNBBVM0/F8tmv7lMlRdLsMWnsUEHMQMwT8LPBs2snsxIA1//WAeXrv2Pr/EP1rWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wcslBufv; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728374958; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4wuyDbSs+jQNbrvshTJAPkFNX8Ga8obk7ExF2kgCdfQ=;
	b=wcslBufvmRepU86iHhX/TEHpV3BGjTzDKeU4EbrLOdYGUQbtzz5Z27p9QzF/xxRCtQOZG9PBK4m0GX9+aUoORKRynhWJHkcwbdyMiBr21K/YP9qNf8AjrhXPhzrPdHLT4Jy+HoKTvTIOfiBgCSXEGhY7K6so3L4XhiyzMpk/exQ=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGcMLEf_1728374956)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 16:09:17 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	xuanzhuo@linux.alibaba.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Add rcu ptr in btf_id_sock_common_types
Date: Tue,  8 Oct 2024 16:09:16 +0800
Message-Id: <20241008080916.44724-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes sk is dereferenced as an rcu ptr, such as skb->sk in tp_btf,
which is a valid type of sock common. Then helpers like bpf_skc_to_*()
can be used with skb->sk.

For example, the following prog will be rejected without this patch:
```
SEC("tp_btf/tcp_bad_csum")
int BPF_PROG(tcp_bad_csum, struct sk_buff* skb)
{
	struct sock *sk = skb->sk;
	struct tcp_sock *tp;

	if (!sk)
		return 0;
	tp = bpf_skc_to_tcp_sock(sk);

	return 0;
}
```

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a7ed527e47e..3e7ce448ae03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8362,6 +8362,7 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
 		PTR_TO_XDP_SOCK,
 		PTR_TO_BTF_ID,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
+		PTR_TO_BTF_ID | MEM_RCU,
 	},
 	.btf_id = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 };
-- 
2.32.0.3.g01195cf9f


