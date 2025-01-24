Return-Path: <bpf+bounces-49630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C5A1ADFE
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465023AE27A
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 00:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B11D5142;
	Fri, 24 Jan 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QkDY2lFO"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACD2B9BC;
	Fri, 24 Jan 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737679677; cv=none; b=QtWc3IAL3Tc0gDfVAOdyJ8WE4iCc1oLe5rg5i43+7akRqIxSdHRylqbf9bWZDn/MrLHnfF0GqY4WZbCPYj8cex0+scQ6UpnXaMDHlrqDhBJtH9oxpDACTLRXw/CieUJohPFE10vyQ7tlYsV6zgdCh1W71xanm2uvj0LUyiytp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737679677; c=relaxed/simple;
	bh=Vz6y+8dB7hx3JeW+p/kladDwPjHK/Q8zuaZZvkC10uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWjwBuK8qHq9hAD0b2JeipHICpTeDCWX6hYca6fDSiHJyFad/aA+13R5cwzYKo1SlmAa0Wmpkj0yQbChaavX6EZYkmu3NSyB7Z7zwrQQfffvHHC3Irr2R/cDle121W3p4e5M2xqN9dKexTDUlQOGOXOm3c+v5ITnYmZ+c5TE9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QkDY2lFO; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737679672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUuaKy1sM92Co0RwIGKFEWtlJHw8JW5XxlTLishTd28=;
	b=QkDY2lFOjcmVdNQELpQS6+vB1VWXHDxWrPrK+FDAsJcNvSKNFBF/vBdEavxZkGrBnIdzQc
	Q7s2voLmkPf9Rj0MuzAoCTPOK5Mz9dx8JScgxstr+9YBl+z5AEyv6MVQbFQmt8Qh3H7tzD
	VLSnR9P6lbJAyyJkuD8VcO/s/kCOfVc=
Date: Thu, 23 Jan 2025 16:47:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v2 4/7] bpf: Add mptcp_subflow bpf_iter
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-4-ae244d3cdbbc@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-4-ae244d3cdbbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
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
> usage fits the bpf_iter use case.
> 
> So this patch adds a new bpf_iter type named "mptcp_subflow" to do
> this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
> _destroy(). And register these bpf_iter mptcp_subflow into mptcp
> common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
> in BPF program like this:
> 
> 	bpf_for_each(mptcp_subflow, subflow, msk)
> 		kfunc(subflow);
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - v2:
>     - Add BUILD_BUG_ON() checks, similar to the ones done with other
>       bpf_iter_(...) helpers.
>     - Replace msk_owned_by_me() by sock_owned_by_user_nocheck() and
>       !spin_is_locked() (Martin).
> 
> A few versions of this single patch have been previously posted to the
> BPF mailing list by Geliang, before continuing to the MPTCP mailing list
> only, with other patches of this series. The version of the whole series
> has been reset to 1, but here is the ChangeLog for the previous ones:
>   - v2: remove msk->pm.lock in _new() and _destroy() (Martin)
>         drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
>   - v3: drop bpf_iter__mptcp_subflow
>   - v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
>         it in _next() (Andrii)
>   - v5: use list_is_last() instead of list_entry_is_head() add
>         KF_ITER_NEW/NEXT/DESTROY flags add msk_owned_by_me in _new()
>   - v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)
> ---
>   net/mptcp/bpf.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index c5bfd84c16c43230d9d8e1fd8ff781a767e647b5..e39f0e4fb683c1aa31ee075281daee218dac5878 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -35,6 +35,15 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
>   	.set   = &bpf_mptcp_fmodret_ids,
>   };
>   
> +struct bpf_iter_mptcp_subflow {
> +	__u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_mptcp_subflow_kern {
> +	struct mptcp_sock *msk;
> +	struct list_head *pos;
> +} __aligned(8);
> +
>   __bpf_kfunc_start_defs();
>   
>   __bpf_kfunc static struct mptcp_subflow_context *
> @@ -47,10 +56,54 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
>   	return NULL;
>   }
>   
> +__bpf_kfunc static int
> +bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> +			   struct mptcp_sock *msk)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +	struct sock *sk = (struct sock *)msk;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
> +		     sizeof(struct bpf_iter_mptcp_subflow));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
> +		     __alignof__(struct bpf_iter_mptcp_subflow));
> +
> +	kit->msk = msk;
> +	if (!msk)

NULL check is not needed. verifier should have rejected it for KF_TRUSTED_ARGS.

> +		return -EINVAL;
> +
> +	if (!sock_owned_by_user_nocheck(sk) &&
> +	    !spin_is_locked(&sk->sk_lock.slock))

I could have missed something. If it is to catch bug, should it be 
sock_owned_by_me() that has the lockdep splat? For the cg get/setsockopt hook 
here, the lock should have already been held earlier in the kernel.

This set is only showing the cg sockopt bpf prog but missing the major 
struct_ops piece. It is hard to comment. I assumed the lock situation is the 
same for the struct_ops where the lock will be held before calling the 
struct_ops prog?

> +		return -EINVAL;
> +
> +	kit->pos = &msk->conn_list;
> +	return 0;
> +}
> +
> +__bpf_kfunc static struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +
> +	if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
> +		return NULL;
> +
> +	kit->pos = kit->pos->next;
> +	return list_entry(kit->pos, struct mptcp_subflow_context, node);
> +}
> +
> +__bpf_kfunc static void
> +bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
> +{
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
>   BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
>   BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
>   
>   static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
> 


