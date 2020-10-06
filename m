Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8971284FE8
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFQdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 12:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgJFQdS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Oct 2020 12:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602001996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bR5IjfX1cmeaRB5ggSzcftrnrbSjb90zh+7vGrlHwPQ=;
        b=WcUOn9s+9tP35F/qX6eyKPVdlWdx61EWjexao6AjTD+cSsc9iGxv2+jO1g1Qp0ifcNtPxz
        QC8fuRKWRabN7Yqezfz4OvkGQetWrwlcC+qpKpFBfFRfIcxjZDWO8mHkGTfuXS+5I8L2pJ
        N1uC3eRCQ+VAn+wvZW5a9O0Q3wIq0Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-nQ6Wr3pwO_OgaXjZSy2ArQ-1; Tue, 06 Oct 2020 12:33:12 -0400
X-MC-Unique: nQ6Wr3pwO_OgaXjZSy2ArQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76307425D1;
        Tue,  6 Oct 2020 16:33:10 +0000 (UTC)
Received: from carbon (unknown [10.36.110.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9E7118E3C;
        Tue,  6 Oct 2020 16:33:03 +0000 (UTC)
Date:   Tue, 6 Oct 2020 18:33:02 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        maze@google.com, lmb@cloudflare.com, shaun@tigera.io,
        Lorenzo Bianconi <lorenzo@kernel.org>, marek@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, brouer@redhat.com
Subject: Re: [PATCH bpf-next V1 3/6] bpf: add BPF-helper for reading MTU
 from net_device via ifindex
Message-ID: <20201006183302.337a9502@carbon>
In-Reply-To: <160200018165.719143.3249298786187115149.stgit@firesoul>
References: <160200013701.719143.12665708317930272219.stgit@firesoul>
        <160200018165.719143.3249298786187115149.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 06 Oct 2020 18:03:01 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> FIXME: add description.

Ups, I will obviously send a V2.

I still want feedback on whether I should implement another BPF-helper
as sketched below:

> FIXME: IMHO we can create a better BPF-helper named bpf_mtu_check()
> instead of bpf_mtu_lookup(), because a flag can be used for requesting
> GRO segment size checking.  The ret value of bpf_mtu_check() says
> if MTU was violoated, but also return MTU via pointer arg to allow
> BPF-progs to do own logic.
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  include/uapi/linux/bpf.h |   13 +++++++++++
>  net/core/filter.c        |   56 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 50ce65e37b16..29b335cb96ef 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3718,6 +3718,18 @@ union bpf_attr {
>   *		never return NULL.
>   *	Return
>   *		A pointer pointing to the kernel percpu variable on this cpu.
> + *
> + * int bpf_mtu_lookup(void *ctx, u32 ifindex, u64 flags)
> + *	Description
> + *		Lookup MTU of net device based on ifindex.  The Linux kernel
> + *		route table can configure MTUs on a more specific per route
> + *		level, which is not provided by this helper. For route level
> + *		MTU checks use the **bpf_fib_lookup**\ () helper.
> + *
> + *		*ctx* is either **struct xdp_md** for XDP programs or
> + *		**struct sk_buff** tc cls_act programs.
> + *	Return
> + *		On success, MTU size is returned. On error, a negative value.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -3875,6 +3887,7 @@ union bpf_attr {
>  	FN(redirect_neigh),		\
>  	FN(bpf_per_cpu_ptr),            \
>  	FN(bpf_this_cpu_ptr),		\
> +	FN(mtu_lookup),			\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d84723f347c0..49ae3b80027b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5512,6 +5512,58 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
>  	.arg4_type	= ARG_ANYTHING,
>  };
>  
> +static int bpf_mtu_lookup(struct net *netns, u32 ifindex, u64 flags)
> +{
> +	struct net_device *dev;
> +
> +	// XXX: Do we even need flags?
> +	// Flag idea: get ctx dev->mtu for XDP_TX or redir out-same-dev
> +	if (flags)
> +		return -EINVAL;
> +
> +	dev = dev_get_by_index_rcu(netns, ifindex);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	return dev->mtu;
> +}
> +
> +BPF_CALL_3(bpf_skb_mtu_lookup, struct sk_buff *, skb,
> +	   u32, ifindex, u64, flags)
> +{
> +	struct net *netns = dev_net(skb->dev);
> +
> +	return bpf_mtu_lookup(netns, ifindex, flags);
> +}
> +
> +BPF_CALL_3(bpf_xdp_mtu_lookup, struct xdp_buff *, xdp,
> +	   u32, ifindex, u64, flags)
> +{
> +	struct net *netns = dev_net(xdp->rxq->dev);
> +	// XXX: Handle if this runs in devmap prog (then is rxq invalid?)
> +
> +	return bpf_mtu_lookup(netns, ifindex, flags);
> +}
> +
> +static const struct bpf_func_proto bpf_skb_mtu_lookup_proto = {
> +	.func		= bpf_skb_mtu_lookup,
> +	.gpl_only	= true,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX,
> +	.arg2_type      = ARG_ANYTHING,
> +	.arg3_type      = ARG_ANYTHING,
> +};
> +
> +static const struct bpf_func_proto bpf_xdp_mtu_lookup_proto = {
> +	.func		= bpf_xdp_mtu_lookup,
> +	.gpl_only	= true,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX,
> +	.arg2_type      = ARG_ANYTHING,
> +	.arg3_type      = ARG_ANYTHING,
> +};
> +
> +
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>  static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
>  {
> @@ -7075,6 +7127,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_get_socket_uid_proto;
>  	case BPF_FUNC_fib_lookup:
>  		return &bpf_skb_fib_lookup_proto;
> +	case BPF_FUNC_mtu_lookup:
> +		return &bpf_skb_mtu_lookup_proto;
>  	case BPF_FUNC_sk_fullsock:
>  		return &bpf_sk_fullsock_proto;
>  	case BPF_FUNC_sk_storage_get:
> @@ -7144,6 +7198,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_xdp_adjust_tail_proto;
>  	case BPF_FUNC_fib_lookup:
>  		return &bpf_xdp_fib_lookup_proto;
> +	case BPF_FUNC_mtu_lookup:
> +		return &bpf_xdp_mtu_lookup_proto;
>  #ifdef CONFIG_INET
>  	case BPF_FUNC_sk_lookup_udp:
>  		return &bpf_xdp_sk_lookup_udp_proto;
> 
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

