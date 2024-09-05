Return-Path: <bpf+bounces-38960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4596D0ED
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1FF1C228CB
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7321946C1;
	Thu,  5 Sep 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SM4dkg2w"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB58193422;
	Thu,  5 Sep 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522994; cv=none; b=FyNzgx3fAx6Q7qYJFzHiyITT2Nwf60Rgm9fjrpPad9swV3pNJkYdd5p6raHaTfLzX+ZmmIS3TB+Pw6DJYky+fYc0cKQfztLjsGiUI1WMxA54nL+Utjm6BNYtB0IKsYVxcv4jQaCfNNqC8U0seS/5IGAOjvnu0xeYXa6vtzvTE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522994; c=relaxed/simple;
	bh=9nX5BEqo/bJuVUV4T906+zK42dyZFMxqoxbNcOlRtAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drijcX7jjSCbfnr+4yDm4RQDvphP0AFhmBXfXSHmlzYWv9tFADbu0NxvxRb4d2ZWCU//hG1ZqPXQsGU908Bkx2lrCRGn0NKg9GK9FQ/CewGKyldMnASu2o7FSjBBpoMfSp/5Xbvl4isgjl3U9gCsnpoZM8KrELuhQC2LcRbvp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SM4dkg2w; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725522990; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=heg5ujh9995FGb5Bxbbr9bVFNtt01S491isl+3eyVds=;
	b=SM4dkg2wDBVCtiM81sxkeUyOD1h+8jkHwb4OF48R0mRF7dCAjNGwFKrmb3MczM2S3eSBy5aQfCrx0Mc7peP4M1XcKd/N4lTFYHs5ULndurGNcY0/SNfNLbALwaCXCKe9BioxGXZ7yxHNU5SNwpuS2vUVnFfrLpNAK+aQ/uncZ44=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEKuTDv_1725522987)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 15:56:28 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	juntong.deng@outlook.com,
	jrife@google.com,
	alan.maguire@oracle.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	vmalik@redhat.com,
	cupertino.miranda@oracle.com,
	mattbobrowski@google.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] bpf: Allow bpf_dynptr_from_skb() for tp_btf
Date: Thu,  5 Sep 2024 15:56:21 +0800
Message-Id: <20240905075622.66819-5-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240905075622.66819-1-lulie@linux.alibaba.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
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

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6d4fa9198b652..4c01f4756ddb5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12074,7 +12074,7 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 }
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
@@ -12123,6 +12123,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
-- 
2.32.0.3.g01195cf9f


