Return-Path: <bpf+bounces-30505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B88CE88A
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2741F24277
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2012EBC3;
	Fri, 24 May 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RMGZp5gr"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10785C58;
	Fri, 24 May 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567357; cv=none; b=UHHqetKCwFkX2h+tPS6QaVNUxlfbLxFKsshCYWFta/2B5mhk4jJjzFEYdRxvRXIt+rdCFUVAS1F4SZabBpdRgvcpU5cb2N8e3mS2nbJKdEGhkwgTzfWT9pazQiO4jzdyhRkaEqxl6uKx1Ji7cpd+7mmd3Dzlk+FSIlc5m8R6N/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567357; c=relaxed/simple;
	bh=UH0BAnTszPz2wu8guNe+D2XVlT9MJNcLNC9x+P06jCY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KKrGbflb7/YHLeQUtwAKyyGAhr63z/qtCUoFDsfYEzhRVJbX0SgcqQAYAus6SFAa72zJr+Jb3P5yGVoYUDn8mHuwPFwsBvsTQxmZ508Onrz3i3ezfCeGMfUabysxNjh3kjFxpN862YvWu8TJJzEnsY+50B+Cs4vrmTSSUdwawoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RMGZp5gr; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6wnxVBY8oGCyyLZ+uTVDZizVU817OeWQA9zf3sRl7NM=; b=RMGZp5gronFL7LsHzNa0bPeAM5
	FLOQng0up+SSkI2vJ8CZGmY1VK5rRJ3L65s3n0qakwNeYeh08igXRG5yUDQWZ7l6Ie//TgsApcPkY
	tJYkm33s179nWp66wRJ93AdyBlvXPwnHD7iIpMfrWvCqVpBdd1tBY4XeV7gRc9gII2AcyxfLpDVrl
	ULOvk2bNdJi4f65vtp6OTsRRCTN4G5q26Lu8SR21+g+NLqHZl4tK9G2dxbEhnJCm3bAEzcgwYUG4V
	QtN0x87iOPcp9jRFU2iEtwMuzEDbMyd+xFcuhKnsEwsBR/HMNHhF8d6/qoDQG+PcZNvp/0dmcx/Cv
	btlRhdoQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXa2-000FzV-Tg; Fri, 24 May 2024 18:15:42 +0200
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXa2-0003EI-2d;
	Fri, 24 May 2024 18:15:42 +0200
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524110659.3612077-1-vadfed@meta.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <78a16fb9-dae7-900d-bbee-749da3990291@iogearbox.net>
Date: Fri, 24 May 2024 18:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240524110659.3612077-1-vadfed@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

On 5/24/24 1:06 PM, Vadim Fedorenko wrote:
> Add special flag to validate that TC BPF program properly updates
> checksum information in skb.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>   include/uapi/linux/bpf.h       |  2 ++
>   net/bpf/test_run.c             | 17 ++++++++++++++++-
>   tools/include/uapi/linux/bpf.h |  2 ++
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 90706a47f6ff..f7d458d88111 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1425,6 +1425,8 @@ enum {
>   #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
>   /* If set, XDP frames will be transmitted after processing */
>   #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
> +/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
>   
>   /* type for BPF_ENABLE_STATS */
>   enum bpf_stats_type {
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index f6aad4ed2ab2..c6189bb9bf67 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -977,7 +977,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	void *data;
>   	int ret;
>   
> -	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
> +	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
> +	    kattr->test.cpu || kattr->test.batch_size)
>   		return -EINVAL;
>   
>   	data = bpf_test_init(kattr, kattr->test.data_size_in,
> @@ -1025,6 +1026,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   
>   	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
>   	__skb_put(skb, size);
> +
> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
> +		skb->csum = skb_checksum(skb, 0, skb->len, 0);
> +		skb->ip_summed = CHECKSUM_COMPLETE;
> +	}
> +
>   	if (ctx && ctx->ifindex > 1) {
>   		dev = dev_get_by_index(net, ctx->ifindex);
>   		if (!dev) {
> @@ -1079,6 +1086,15 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	}
>   	convert_skb_to___skb(skb, ctx);
>   
> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
> +		__wsum csum = skb_checksum(skb, 0, skb->len, 0);
> +
> +		if (skb->csum != csum) {
> +			ret = -EINVAL;

This is very useful. Maybe just a nit that EINVAL seems too generic and some more concrete
signal (e.g. EBADMSG) might be better. Do you also plan to add test infra for other types
like CHECKSUM_PARTIAL?

> +			goto out;
> +		}
> +	}
> +
>   	size = skb->len;
>   	/* bpf program can never convert linear skb to non-linear */
>   	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 90706a47f6ff..f7d458d88111 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1425,6 +1425,8 @@ enum {
>   #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
>   /* If set, XDP frames will be transmitted after processing */
>   #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
> +/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	BIT(2)
>   
>   /* type for BPF_ENABLE_STATS */
>   enum bpf_stats_type {
> 


