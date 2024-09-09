Return-Path: <bpf+bounces-39310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670709718CE
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 13:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204AC283D10
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021BB1B5ED9;
	Mon,  9 Sep 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EunNC8rt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788941B6521;
	Mon,  9 Sep 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883034; cv=none; b=kl2bZaPIovThEVFO3qJ4EomWdHeL/wANOs+Ksgj/aTgOYTQDWtEq8X2Ya9Mjo3m44JHKTlQPVhw7M4ndCg29271sP6vvvqP6SSln8kdUuUjL/kK3PpZslTttM4zmDAscweOglR2e86HQ2V9bk2+3MRyAftBdmjyPSFtbucKYHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883034; c=relaxed/simple;
	bh=Xs1ma3py/kYQl+X+Z1t4uxsWvuP6OYkETY78e8ZgRGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZ+Z9z518AxjYvIXmRI7Tek3LNf2bSFT98f+ci1Q6of6xlGICln0iupEIAIMj0nIhL14c6cCD1flUnFX4DBRAOhZ8FYyro/L+L6nX7VUrHuTdJR0T4MaJeGJQzHLg4dIaQT/pejbEew87wKYoMSIWHG/hb5ATjcjK+csOcSlpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EunNC8rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F040FC4CEC5;
	Mon,  9 Sep 2024 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725883034;
	bh=Xs1ma3py/kYQl+X+Z1t4uxsWvuP6OYkETY78e8ZgRGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EunNC8rtl0pHf0fMNVqfew4abZDFXZd9Euf//3xorzLJsPEwXXptrJEaFFooTq02+
	 Ma2/HmtZh1BMoT4o8sv5QX11wBFvdgnPQXU8RnoTqFnfWrrjqPuT2v9C7ZqLSu2ZDH
	 V36dsM8KBFh2LX/tBIBiIR1ktKXLy46DtofdSCK7SQaLjdgp4eJPloF8KISw6WtyCD
	 RvIEkolAxl9RdRvVW+sAaaDQXm/ye1y/Di+qQw/xPwh9wSBkC3u3WNQmun9NOHbk5I
	 PgFxaDItCfAV5eZkd8yAGNfdL82IGPHFHU6Zqf8jwXm5UuQGkDp6EegE6GKhUxftm7
	 6X7v/r4x2JtSA==
Message-ID: <332e79e8eb212de91c848ef0d99a2f3326a8153f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 1/4] bpf: Add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>, Martin
 KaFai Lau <martin.lau@kernel.org>
Date: Mon, 09 Sep 2024 19:57:10 +0800
In-Reply-To: <a4a0e759b9f82a17ddd2eac68f6cd99788248683.1725845619.git.tanggeliang@kylinos.cn>
References: <cover.1725845619.git.tanggeliang@kylinos.cn>
	 <a4a0e759b9f82a17ddd2eac68f6cd99788248683.1725845619.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-09-09 at 09:36 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> It's necessary to traverse all subflows on the conn_list of an MPTCP
> socket and then call kfunc to modify the fields of each subflow. In
> kernel space, mptcp_for_each_subflow() helper is used for this:
> 
> 	mptcp_for_each_subflow(msk, subflow)
> 		kfunc(subflow);
> 
> But in the MPTCP BPF program, this has not yet been implemented. As
> Martin suggested recently, this conn_list walking + modify-by-kfunc
> usage fits the bpf_iter use case. So this patch adds a new bpf_iter
> type named "mptcp_subflow" to do this and implements its helpers
> bpf_iter_mptcp_subflow_new()/_next()/_destroy().
> 
> Then bpf_for_each() for mptcp_subflow can be used in BPF program like
> this:
> 
> 	bpf_rcu_read_lock();
> 	bpf_for_each(mptcp_subflow, subflow, msk)
> 		kfunc(subflow);
> 	bpf_rcu_read_unlock();
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c      | 51
> ++++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.h |  6 ++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 9672a70c24b0..799264119891 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -204,10 +204,59 @@ static const struct btf_kfunc_id_set
> bpf_mptcp_fmodret_set = {
>  	.set   = &bpf_mptcp_fmodret_ids,
>  };
>  
> +struct bpf_iter__mptcp_subflow {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct mptcp_sock *, msk);
> +	__bpf_md_ptr(struct list_head *, pos);
> +};

This bpf_iter__mptcp_subflow struct should be dropped too.

> +
> +struct bpf_iter_mptcp_subflow {
> +	__u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_mptcp_subflow_kern {
> +	struct mptcp_sock *msk;
> +	struct list_head *pos;
> +} __attribute__((aligned(8)));
> +
>  __diag_push();
>  __diag_ignore_all("-Wmissing-prototypes",
>  		  "kfuncs which will be used in BPF programs");

Duplicate with __bpf_kfunc_start_defs/__bpf_kfunc_end_defs,
__diag_push, __diag_pop and __diag_ignore_all should be dropped.

>  
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
> bpf_iter_mptcp_subflow *it,
> +					   struct mptcp_sock *msk)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +
> +	if (!msk)
> +		return -EINVAL;
> +
> +	kit->msk = msk;
> +	kit->pos = &msk->conn_list;
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
> +	subflow = list_entry((kit->pos)->next, struct
> mptcp_subflow_context, node);
> +	if (!msk || list_entry_is_head(subflow, &msk->conn_list,
> node))
> +		return NULL;
> +
> +	kit->pos = &subflow->node;
> +	return subflow;
> +}
> +
> +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct
> bpf_iter_mptcp_subflow *it)
> +{
> +}
> +
>  __bpf_kfunc struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
> unsigned int pos)
>  {
> @@ -221,6 +270,8 @@ __bpf_kfunc bool
> bpf_mptcp_subflow_queues_empty(struct sock *sk)
>  	return tcp_rtx_queue_empty(sk);
>  }
>  
> +__bpf_kfunc_end_defs();
> +
>  __diag_pop();
>  
>  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d25d2dac88a5..b3f5254e3c0d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -715,6 +715,12 @@ void mptcp_subflow_queue_clean(struct sock *sk,
> struct sock *ssk);
>  void mptcp_sock_graft(struct sock *sk, struct socket *parent);
>  u64 mptcp_wnd_end(const struct mptcp_sock *msk);
>  void mptcp_set_timeout(struct sock *sk);
> +struct bpf_iter_mptcp_subflow;
> +int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> +			       struct mptcp_sock *msk);
> +struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it);
> +void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow
> *it);

No need to add these declarations, since "-Wmissing-declarations" is
ignored in __bpf_kfunc_start_defs.

Will update in v3.

Thanks,
-Geliang

>  bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
>  struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
> unsigned int pos);


