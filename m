Return-Path: <bpf+bounces-36492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C629498A6
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 21:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D06B250A1
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D213C677;
	Tue,  6 Aug 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+K+QP8G"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570918D64E
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974072; cv=none; b=a3mK2hRzZyrKzv7uAOrzc25+ekXhZblUqL6aDSgb26iVKdRbtDDS52mpYeGVpA9fjkuq7763qKxNKLRhxf+kWTYSTjDy6ycUxr9IbGZ1i/Nbfp4Uq/fjDg+v3EAYrBw1yVTsiJ+PmRmPKyT1HaJsW1dq1FFg3qptRUcl+ZTWEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974072; c=relaxed/simple;
	bh=dlH81ktutp3sWf3QIvyrNHlg9JBuq55q/eiiAA0f84Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WE7BAF3z8VgrzEbZ0+ILMr0qLoe7eQtzdSjV070PxORyA8YZJwhedxl8e4AZXTYOZwD0cNcp1t2QACpokJwsrSmaMrJNboraQXLniumFTVWcPKAbaMPdHwSHds5dRvEcxs31Em+ZzmWHNjll6qHdJbMpRVi90E+IuvTB760qps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+K+QP8G; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <adb20c35-1533-4910-be40-d3f149049f54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722974067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsH5+rFXBYsGEc1QUUb8qibhCEcO3hUJ+OoDvRJNNZc=;
	b=a+K+QP8GA2MMh+ZgbBMzqxKoygbhk6o4SOTh8dXZPw+QU71Rd9DwkarULzxwPWY7fcrXqH
	b1wSK0ZXpPGvK9dUoffzV5CiwU0CNjEEJ8bcDTBlSR9tA52BI7yh3qLfFE/TlJWYdApQ73
	x3krjeWzZfJiR5txkkK5kT8FmDZDIWE=
Date: Tue, 6 Aug 2024 12:54:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf/bpf_get,set_sockopt: add option to set
 TCP-BPF sock ops flags
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, bpf@vger.kernel.org
References: <20240802152929.2695863-1-alan.maguire@oracle.com>
 <20240802152929.2695863-2-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240802152929.2695863-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/2/24 8:29 AM, Alan Maguire wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78a6f746ea0b..570ca3f12175 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5278,6 +5278,11 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>   			return -EINVAL;
>   		inet_csk(sk)->icsk_rto_min = timeout;
>   		break;
> +	case TCP_BPF_SOCK_OPS_CB_FLAGS:
> +		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
> +			return -EINVAL;
> +		tp->bpf_sock_ops_cb_flags = val;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -5366,6 +5371,17 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>   		if (*optlen < 1)
>   			return -EINVAL;
>   		break;
> +	case TCP_BPF_SOCK_OPS_CB_FLAGS:
> +		if (*optlen != sizeof(int))
> +			return -EINVAL;
> +		if (getopt) {
> +			struct tcp_sock *tp = tcp_sk(sk);
> +			int val = READ_ONCE(tp->bpf_sock_ops_cb_flags);

READ_ONCE() here looks suspicious. There is no existing WRITE_ONCE.

Is it needed? The read here should have already passed the sock_owned_by_me 
test. The existing write side should also have the sock_owned_by_me.


