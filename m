Return-Path: <bpf+bounces-39049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23B96E1F6
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655241F2711A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234FC18592C;
	Thu,  5 Sep 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GU7eRHJy"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1C1C2E
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560715; cv=none; b=HqgBlgCN5kbtnN1Ux9lkba2bsjXjBbPXkCy9qKcTwKyNIWmhfvgSEp8YKBZJszQ3mZS4l9bZRH2tZltklvLp8Hw8m1PSYAAEX03XDUNRs7yumyCzEJzZufbJLEZ+NgghPTX7sYsgv1M8D28eQXHmjk1DDFfgmwqNsytxVAYeZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560715; c=relaxed/simple;
	bh=MpaxPaGF4Gv79ZMnWFtifCFqwJskCf5I6Bno75eeXC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDkJ1ZIAdQfjnwsGVUNBkm6qe97eULrOK1LG/8XM3WuCfN3XsUaeAlPNCiULgmKiMYzDtQ109uDVzZI0+8mpvvTV4SnJitVQ17XGO640/QNaoN5BVHbk/r4cCryNo98ijw2HiOlQ8u050Li3/tKg15IWLDWikTxcIEnXct7opIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GU7eRHJy; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <288ad1c2-501a-4319-bc1e-e7a7e276ff63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725560711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26c9SQGaExc0iQKipk0W1aIbNjZ9QX1quhp2Gjfe6N0=;
	b=GU7eRHJyi8rQmdyKMcTxVYSg5Jskl5zTwnLh8GYPTftnStR+jdLhlzO/WaX1qAlmREeCK+
	JYWs5NDqo5hkmOOwuzXhlCqa5r8dl71V6G01iRd7D64jfgH+I5zLBtxDQf1ZCrGjtA7guj
	FNNkdz/ExPkZhBouQixmul76O7jqlyg=
Date: Thu, 5 Sep 2024 11:24:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next 1/4] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
 <a75fc3e8df7141ce582448d3f092871a4943fbf4.1725544210.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <a75fc3e8df7141ce582448d3f092871a4943fbf4.1725544210.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/24 6:52 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> It's necessary to traverse all subflows on the conn_list of an MPTCP
> socket and then call kfunc to modify the fields of each subflow. In
> kernel space, mptcp_for_each_subflow() helper is used for this:
> 
>   mptcp_for_each_subflow(msk, subflow)
>           kfunc(subflow);
> 
> But in the MPTCP BPF program, this has not yet been implemented. As
> Martin suggested recently, this conn_list walking + modify-by-kfunc
> usage fits the bpf_iter use case.
> 
> This patch adds a new bpf_iter type named "mptcp_subflow" to do this.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   kernel/bpf/helpers.c |  3 +++
>   net/mptcp/bpf.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5f0adae8293..2340ba967444 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3023,6 +3023,9 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
>   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
>   BTF_KFUNCS_END(common_btf_ids)
>   
>   static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 9672a70c24b0..cda09bbfd617 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -204,6 +204,63 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
>   	.set   = &bpf_mptcp_fmodret_ids,
>   };
>   
> +struct bpf_iter__mptcp_subflow {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct mptcp_sock *, msk);
> +	__bpf_md_ptr(struct list_head *, pos);
> +};
> +
> +DEFINE_BPF_ITER_FUNC(mptcp_subflow, struct bpf_iter_meta *meta,
> +		     struct mptcp_sock *msk, struct list_head *pos)
> +
> +struct bpf_iter_mptcp_subflow {
> +	__u64 __opaque[3];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_mptcp_subflow_kern {
> +	struct mptcp_sock *msk;
> +	struct list_head *pos;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> +					   struct mptcp_sock *msk)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +
> +	kit->msk = msk;
> +	kit->pos = &msk->conn_list;
> +	spin_lock_bh(&msk->pm.lock);

I don't think spin_lock here without unlock can be used. e.g. What if 
bpf_iter_mptcp_subflow_new() is called twice back-to-back.

I haven't looked at the mptcp details, some questions:
The list is protected by msk->pm.lock?
What happen to the sk_lock of the msk?
Can this be rcu-ify? or it needs some cares when walking the established TCP 
subflow?


[ Please cc the bpf list. Helping to review patches is a good way to contribute 
back to the mailing list. ]

> +
> +	return 0;
> +}
> +
> +__bpf_kfunc struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk = kit->msk;
> +
> +	subflow = list_entry((kit->pos)->next, struct mptcp_subflow_context, node);
> +	if (list_entry_is_head(subflow, &msk->conn_list, node))
> +		return NULL;
> +
> +	kit->pos = &subflow->node;
> +	return subflow;
> +}
> +
> +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +	struct mptcp_sock *msk = kit->msk;
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
>   __diag_push();
>   __diag_ignore_all("-Wmissing-prototypes",
>   		  "kfuncs which will be used in BPF programs");


