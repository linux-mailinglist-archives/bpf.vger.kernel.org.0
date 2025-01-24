Return-Path: <bpf+bounces-49635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B807DA1AE3B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6BD188D574
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867011D5CC1;
	Fri, 24 Jan 2025 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZLwMxLm"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3151662E9
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682736; cv=none; b=dmC9UEiSHSJvsV28Ijwmss2e3TrCrOoQ85I+kBVQkyg2pjJ3hj75CHDCctEqzrR+gAPBITRCpBnKMBXq+UMfxgRmLIF252qs43YnhB4VtSftkYYNg8NXQpqwcJdTBQMYNARhvDMRgMK1RdgtjgASx66GHYyl4nvwtnvUWiDnW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682736; c=relaxed/simple;
	bh=/wnClBcqy9IKrjwNnBUNENWd6mxPJwtoFNxLjAZn4HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX/6IANQnrdLo0GblQWV2mXFd5zdsSQvq76QRuQi6qCpfoewFWVu2gj7/7aa9b1akYj5QsISEo12ZdcEFnJQG7Mr6iGde7/3ukOzv/ApQYQNzcFSoJYAKePHD2lP5xtON3cl6t/QMFM/Wj5zFSqfLV/AqrAbRLAua/xAagLvlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZLwMxLm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5313b129-72b1-4fdc-954e-e2d0a141a99c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737682716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PuF0gN9ro6NkSKhiCAGItV5HEn3Pklvs68VtZ/vAjKU=;
	b=GZLwMxLmr8EUv1bZOB3dBcC2uVrOJkEOAmHOSVAvZGDxaYihXg/9LaTZYs7L2/4RAi9oWH
	CJR8XbBtTezqOkGblOibRHvE8+oHFz4F/eNaGUfNaYCSmlclyM85kMsQn6n39UtVxPHpA1
	X27+LG2jxP+LfNFH8lOpcz2J5ZQSzm4=
Date: Thu, 23 Jan 2025 17:38:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v2 7/7] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
To: Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 linux-kselftest@vger.kernel.org
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-7-ae244d3cdbbc@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-7-ae244d3cdbbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
> +SEC("cgroup/getsockopt")
> +int iters_subflow(struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct bpf_sock *sk = ctx->sk;
> +	struct sock *ssk = NULL;
> +	struct mptcp_sock *msk;
> +	int local_ids = 0;
> +
> +	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
> +		return 1;
> +
> +	msk = bpf_skc_to_mptcp_sock(sk);
> +	if (!msk || msk->pm.server_side || !msk->pm.subflows)
> +		return 1;
> +
> +	msk = bpf_mptcp_sock_acquire(msk);
> +	if (!msk)
> +		return 1;
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		/* Here MPTCP-specific packet scheduler kfunc can be called:
> +		 * this test is not doing anything really useful, only to
> +		 * verify the iteration works.
> +		 */
> +
> +		local_ids += subflow->subflow_id;
> +
> +		/* only to check the following kfunc works */
> +		ssk = mptcp_subflow_tcp_sock(subflow);

It is good to have test cases to exercise the new iter and kfunc. Thanks.

However, it seems not useful to show how it will be used in the future 
packet/subflow scheduler. iiuc, the core piece is in bpf_struct_ops. Without it, 
it is hard to comment. Any RFC patches ready to be posted?

> +	}
> +
> +	if (!ssk)
> +		goto out;
> +
> +	/* assert: if not OK, something wrong on the kernel side */
> +	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
> +		goto out;
> +
> +	/* only to check the following kfunc works */
> +	subflow = bpf_mptcp_subflow_ctx(ssk);
> +	if (!subflow || subflow->token != msk->token)
> +		goto out;
> +
> +	ids = local_ids;
> +
> +out:
> +	bpf_mptcp_sock_release(msk);
> +	return 1;
> +}


