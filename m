Return-Path: <bpf+bounces-31423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C78FC82A
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C251C20B55
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424041922C8;
	Wed,  5 Jun 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CTLMNEcE"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D418FC90
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580529; cv=none; b=EyVjtaAV8KDlNtp2Rx+DBMgepJ+of3iEkbanGQpwN4WBgN/en95lH/1D9B0SNIsLNiqoiDhNj4CVO+wtqz6kpw0eh8TA+iHp/euNJab5xISrmUgDyV94tWo+FZum9+OJMxn7BuiiwDfD58o7zlIHapTTq5TYMjdCiKyY0UgL3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580529; c=relaxed/simple;
	bh=WLlMYI7y0sLcmzSbVHks3WxjwItNOv5saiN/tqdRJkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TG/grQiwZiIkJq74t3Ee04wZ26cnWvNgVZkNHncjI7PqVDdnBNEpYdiQIF5PsNuz3eoSR3isLvk4LXAgso2C7QTYVMTdZNW4ztU+w0nO5NM/VodoOLbVB3QsBlWsirCv5yhYsSlg7VNUKk8AfqqZcjfvJmn8SQiOnTjDCjuMPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CTLMNEcE; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717580525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8er04J+AYfEB7FMGIsyHTbW1JyKQ72hIQ3MCr+3vsA=;
	b=CTLMNEcE5k6rSia4D20Qd9+w3gIj/9xw4dFP2CimH/bwd+5wxaDSpKCCP+sdI+gn8cv/il
	tggrDMpMk1reJCMaHmM0S2BtsmqT64ahPpDbgItz4aXlA1/VcT5XwnEkTWA+9rjWQSZ94h
	4J/lVWdGhZ9/aPoloSRNOoBau88UeKM=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: ast@kernel.org
Message-ID: <f7fe13a8-c379-495b-9e42-3a5ff50b50e3@linux.dev>
Date: Wed, 5 Jun 2024 10:42:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>
References: <20240527185928.1871649-1-vadfed@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240527185928.1871649-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/05/2024 19:59, Vadim Fedorenko wrote:
> Add special flag to validate that TC BPF program properly updates
> checksum information in skb.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>   include/uapi/linux/bpf.h       |  2 ++
>   net/bpf/test_run.c             | 18 +++++++++++++++++-
>   tools/include/uapi/linux/bpf.h |  2 ++
>   3 files changed, 21 insertions(+), 1 deletion(-)
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
> index f6aad4ed2ab2..4c21562ad526 100644
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
> +			ret = -EBADMSG;
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
> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
>   
>   /* type for BPF_ENABLE_STATS */
>   enum bpf_stats_type {

Hi Daniel!

Have you had a chance to look at v3 of this patch?
I think I addressed all your comments form v2.

Thanks,
Vadim


