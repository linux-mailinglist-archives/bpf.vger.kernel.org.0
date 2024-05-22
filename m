Return-Path: <bpf+bounces-30325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6BE8CC659
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA6628234C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C91419BC;
	Wed, 22 May 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMSwfc2j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519B1BF2A;
	Wed, 22 May 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402732; cv=none; b=XK9z/x5ZQHdNYEF9op5S1R0tui7UfZEzvvplpRHrAxDTVj2GUgArHreU1yfhjOTgQAd0DjdrqRMRQFukfcQPu/zdV44yQKmgmF/nYVPge9PH3DdYR0ueqY4O/eWAlsf9hqYou1jje05dlKSnaY8VD9/UE9Rc39xwsiWfGi3b0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402732; c=relaxed/simple;
	bh=KHalXU74FzcxUXfg1ZPfmKFQpAwC5/blQwRu7hXUkKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyOetnpPKjaGu2xuQ/K7X+yMBRlnDHDLsuB27dVhOqHLjVN7HtzdmiwwDE6xXYz6Z16Crz6GqkDt3km6L/sJwCAN+LOnjbBoBWK6ggteVUm567qFQ0gbeg9AQv6Ndf39dxYeTkYfAb9HM86c9Hii5huLwE+GCHDKxv7IWAPBXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMSwfc2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFBCC2BBFC;
	Wed, 22 May 2024 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716402732;
	bh=KHalXU74FzcxUXfg1ZPfmKFQpAwC5/blQwRu7hXUkKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMSwfc2jpuuEbCc88gVzO0pQakH+P8YDcUNApKlsrHmoOe5jlJrrUD65+E/ERNpSu
	 v0NC9BZDNptKd6tX5YR9T3pbKinTtBK0+4Zou7mKl51VsZjdOvU/kBBCSkJyd6uE3T
	 3fppawfN/GnZ8P+3Pr7jZdsB1zUGpq9AgTgr6lHBmXetAs8mv56Kv1AzJF/u0BzA6z
	 6wTPMPMwFIbb9f1Pdb3EU2S8Z+SuY/w2L6OX1K5VzdhPc0Y2DqQKRmSIlg0b9W8FYL
	 9WjbwtOL3hr6HwSKpcT31K5L9Nc34feHD0OJHTdA73iluOssfxmKlJ6JiROGDdD8tM
	 Q1Yga2dLFmXHA==
Date: Wed, 22 May 2024 19:32:07 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
Message-ID: <20240522183207.GB883722@kernel.org>
References: <20240522145712.3523593-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522145712.3523593-1-vadfed@meta.com>

On Wed, May 22, 2024 at 07:57:10AM -0700, Vadim Fedorenko wrote:
> Add special flag to validate that TC BPF program properly updates
> checksum information in skb.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index f6aad4ed2ab2..841552785c65 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -974,10 +974,13 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	int hh_len = ETH_HLEN;
>  	struct sk_buff *skb;
>  	struct sock *sk;
> +	__wsum csum;
> +	__sum16 sum;

Hi Vadim,

sum seems to be is unused in this function.
And, fwiiw, the scope of csum looks like it could be reduced.

>  	void *data;
>  	int ret;
>  
> -	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
> +	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
> +	    kattr->test.cpu || kattr->test.batch_size)
>  		return -EINVAL;
>  
>  	data = bpf_test_init(kattr, kattr->test.data_size_in,
> @@ -1025,6 +1028,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  
>  	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
>  	__skb_put(skb, size);
> +
> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
> +		skb->csum = skb_checksum(skb, 0, skb->len, 0);
> +		skb->ip_summed = CHECKSUM_COMPLETE;
> +	}
> +
>  	if (ctx && ctx->ifindex > 1) {
>  		dev = dev_get_by_index(net, ctx->ifindex);
>  		if (!dev) {
> @@ -1079,6 +1088,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	}
>  	convert_skb_to___skb(skb, ctx);
>  
> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
> +		csum = skb_checksum(skb, 0, skb->len, 0);
> +		if (skb->csum != csum) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
>  	size = skb->len;
>  	/* bpf program can never convert linear skb to non-linear */
>  	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))

...

