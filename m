Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62735F23D
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348932AbhDNLWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 07:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348923AbhDNLWW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 07:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618399321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVId7o3lQtIks2yXeQsOoMjWTTFDLY+Z4zrdMUPuNNg=;
        b=egPnpLXOy7EZHGXTn9ZbpgODuODSrpxBL0rVHmAssuQk9v1phmKkZz5E/IpOHVyxMRFDAA
        BFNv+FBxKudckm8gI9+fB2ftKJP66Ydczkb6ApbxWV1lVAd2+qCHEbiy2uBaLUOYDNt62D
        +X9S14T4E3Pfjy3GtS/qBNf0kfLSZkU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-s-6bCkhiNM-jj2ZB6qrP4A-1; Wed, 14 Apr 2021 07:21:59 -0400
X-MC-Unique: s-6bCkhiNM-jj2ZB6qrP4A-1
Received: by mail-ed1-f69.google.com with SMTP id f26-20020a056402069ab02903788b40ed89so3137138edy.2
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 04:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PVId7o3lQtIks2yXeQsOoMjWTTFDLY+Z4zrdMUPuNNg=;
        b=ELf5cDvu4UJWb0iUCG8twybeJOTAjf5fI1pbw/QaVlMoNGEB0HBPicCHI7CglyVhyj
         DofhGYRi5vJYSgPMHLkQGJ9J6mJ9qkGsirbUHZ7Qq3XpVSzhlGn8uZZLWOizUkqoQuap
         4NlWfr6EcL7xIMWizKnZ6JCjVGLqVadmTirgKOrLc7yKugE9n4JO3ceo101/tLzyxafY
         hPAsid+r0bmq1FG6H2jtTTMNJEC/cMhwhkx/Tb8heNXY8dphQFK/q0wOufeKB/OFh/cr
         wH7wh8YF8x4grJ+z8UEQUkgO5BRg1jj+2GJYmCqV7le5MAFf77aHan3Mr9SnX0xNludH
         2vjA==
X-Gm-Message-State: AOAM533QbEU8HacKJGr1931BdH277pYdplOLcT4MEa0mKH0O8BQnvfi5
        pLIwhAovofo8qDLdZbYtZjyeRmWwgfdzMynNPufkLO8LjmGXCmGpBv7loEmkTkSBNzNron6Fvgx
        75PMn1ryK6QC8
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr40500406edc.302.1618399318220;
        Wed, 14 Apr 2021 04:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjx+te+EROqkEH5R1MOeN8pBw66QcrMYzo4o84liXDc/JB14cLDfpBsxQMLBFyyVc9ZHqupw==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr40500374edc.302.1618399317891;
        Wed, 14 Apr 2021 04:21:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id li16sm6829761ejb.101.2021.04.14.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 04:21:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 937901804E8; Wed, 14 Apr 2021 13:21:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCHv6 bpf-next 2/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210414012341.3992365-3-liuhangbin@gmail.com>
References: <20210414012341.3992365-1-liuhangbin@gmail.com>
 <20210414012341.3992365-3-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Apr 2021 13:21:56 +0200
Message-ID: <87y2dlkt63.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> This patch adds two flags BPF_F_BROADCAST and BPF_F_EXCLUDE_INGRESS to
> extend xdp_redirect_map for broadcast support.
>
> With BPF_F_BROADCAST the packet will be broadcasted to all the interfaces
> in the map. with BPF_F_EXCLUDE_INGRESS the ingress interface will be
> excluded when do broadcasting.
>
> When getting the devices in dev hash map via dev_map_hash_get_next_key(),
> there is a possibility that we fall back to the first key when a device
> was removed. This will duplicate packets on some interfaces. So just walk
> the whole buckets to avoid this issue. For dev array map, we also walk the
> whole map to find valid interfaces.
>
> Function bpf_clear_redirect_map() was removed in
> commit ee75aef23afe ("bpf, xdp: Restructure redirect actions").
> Add it back as we need to use ri->map again.
>
> Here is the performance result by using 10Gb i40e NIC, do XDP_DROP on
> veth peer, run xdp_redirect_{map, map_multi} in sample/bpf and send pkts
> via pktgen cmd:
> ./pktgen_sample03_burst_single_flow.sh -i eno1 -d $dst_ip -m $dst_mac -t 10 -s 64
>
> There are some drop back as we need to loop the map and get each interface.
>
> Version          | Test                                | Generic | Native
> 5.12 rc4         | redirect_map        i40e->i40e      |    1.9M |  9.6M
> 5.12 rc4         | redirect_map        i40e->veth      |    1.7M | 11.7M
> 5.12 rc4 + patch | redirect_map        i40e->i40e      |    1.9M |  9.3M
> 5.12 rc4 + patch | redirect_map        i40e->veth      |    1.7M | 11.4M
> 5.12 rc4 + patch | redirect_map multi  i40e->i40e      |    1.9M |  8.9M
> 5.12 rc4 + patch | redirect_map multi  i40e->veth      |    1.7M | 10.9M
> 5.12 rc4 + patch | redirect_map multi  i40e->mlx4+veth |    1.2M |  3.8M
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>
> ---
> v6:
> Fix a skb leak in the error path for generic XDP

That's better, thanks! When checking this I at first thought you were
missing a free; turns out I was wrong, the caller of
xdp_do_generic_redirect() will free the skb on error.

However, this is also the case for the native path: the driver is
supposed to free/recycle the frame if xdp_do_redirect() fails. Which
means that this:

[...]
> +static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
> +				 struct net_device *dev_rx,
> +				 struct xdp_frame *xdpf)
> +{
> +	struct xdp_frame *nxdpf;
> +
> +	nxdpf = xdpf_clone(xdpf);
> +	if (unlikely(!nxdpf)) {
> +		xdp_return_frame_rx_napi(xdpf);
> +		return -ENOMEM;
> +	}

is wrong; the ENOMEM return gets propagated up to the caller of
xdp_do_redirect() which will take care of freeing the frame, so this
code shouldn't also be freeing it.

Sorry for not spotting this on the last round - these error conditions
are a bit confusing to me as well. Making the generic and native paths
more similar like you did in this round made it more obvious, though,
which was the point; so yay! :)

-Toke

