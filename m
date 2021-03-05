Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34F32EF45
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCEPoq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 10:44:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:38358 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhCEPop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 10:44:45 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lICd9-000B4L-2a; Fri, 05 Mar 2021 16:44:43 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lICd8-0002uB-QV; Fri, 05 Mar 2021 16:44:42 +0100
Subject: Re: [PATCH bpf-next v5 2/2] bpf, xdp: restructure redirect actions
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        maciej.fijalkowski@intel.com, hawk@kernel.org, toke@redhat.com,
        magnus.karlsson@intel.com, john.fastabend@gmail.com,
        kuba@kernel.org, davem@davemloft.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20210227122139.183284-1-bjorn.topel@gmail.com>
 <20210227122139.183284-3-bjorn.topel@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ddbbeadc-bead-904a-200a-b75cd995b254@iogearbox.net>
Date:   Fri, 5 Mar 2021 16:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210227122139.183284-3-bjorn.topel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26099/Fri Mar  5 13:02:51 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/27/21 1:21 PM, Björn Töpel wrote:
[...]
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 008691fd3b58..a7752badc2ec 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -646,11 +646,20 @@ struct bpf_redirect_info {
>   	u32 flags;
>   	u32 tgt_index;
>   	void *tgt_value;
> -	struct bpf_map *map;
> +	u32 map_id;
> +	u32 tgt_type;
>   	u32 kern_flags;
>   	struct bpf_nh_params nh;
>   };
>   
> +enum xdp_redirect_type {
> +	XDP_REDIR_UNSET,
> +	XDP_REDIR_DEV_IFINDEX,

[...]

> +	XDP_REDIR_DEV_MAP,
> +	XDP_REDIR_CPU_MAP,
> +	XDP_REDIR_XSK_MAP,

Did you eval whether for these maps we can avoid the redundant def above by just
passing in map->map_type as ri->tgt_type and inferring the XDP_REDIR_UNSET from
invalid map_id of 0 (given the idr will never allocate such)?

[...]
> @@ -4068,10 +4039,9 @@ BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
>   	if (unlikely(flags))
>   		return XDP_ABORTED;
>   
> -	ri->flags = flags;
> -	ri->tgt_index = ifindex;
> -	ri->tgt_value = NULL;
> -	WRITE_ONCE(ri->map, NULL);
> +	ri->tgt_type = XDP_REDIR_DEV_IFINDEX;
> +	ri->tgt_index = 0;
> +	ri->tgt_value = (void *)(long)ifindex;

nit: Bit ugly to pass this in /read out this way, maybe union if we cannot use
tgt_index?

>   	return XDP_REDIRECT;
>   }
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index 711acb3636b3..2c58d88aa69d 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -87,7 +87,6 @@ static void xsk_map_free(struct bpf_map *map)
>   {
>   	struct xsk_map *m = container_of(map, struct xsk_map, map);
>   
> -	bpf_clear_redirect_map(map);
>   	synchronize_net();
>   	bpf_map_area_free(m);
>   }
> @@ -229,7 +228,8 @@ static int xsk_map_delete_elem(struct bpf_map *map, void *key)
>   
>   static int xsk_map_redirect(struct bpf_map *map, u32 ifindex, u64 flags)
>   {
> -	return __bpf_xdp_redirect_map(map, ifindex, flags, __xsk_map_lookup_elem);
> +	return __bpf_xdp_redirect_map(map, ifindex, flags, __xsk_map_lookup_elem,
> +				      XDP_REDIR_XSK_MAP);
>   }
>   
>   void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
> 

