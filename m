Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B61449D3D
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 21:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhKHUtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 15:49:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232552AbhKHUtw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 15:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636404427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IF59Y+UW30k4l5eDTgapPlD1iqOa/3oN5dIJ31/PJF8=;
        b=g5o7c1dADnQfNi5qA/bDIqzF9HhFhwDxsZUjWA+tV9zbm457SWeB79ZT15nwEE1xOa1dZ5
        DyHiDojWPilyzosAPWFxVGhRV9XwYvwTY6jpMqtJcvan/PUp69XEFVQDMEAtXRj0GFHxNU
        GtQCyRVHxUOydJxJJq3OQ5l40naWT8w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-l6ETRgJjPL-fxVvl_Q5XxQ-1; Mon, 08 Nov 2021 15:47:06 -0500
X-MC-Unique: l6ETRgJjPL-fxVvl_Q5XxQ-1
Received: by mail-ed1-f72.google.com with SMTP id o15-20020a056402438f00b003e32b274b24so5425315edc.21
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 12:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IF59Y+UW30k4l5eDTgapPlD1iqOa/3oN5dIJ31/PJF8=;
        b=SDXknejZ2VU003/jNVx7XxHi99Wl08D5j5osKbr5xoLBo0jj69ZAaQMttHRCFuxBUg
         X2bcYc9RiQpmfSTjvx/Rmfm5RdiIDHxR6d/3yoqVfPQ6xOu869bFoFF9GKQcNYlHUeWE
         v1TxLdTjwHFzmrPZCy+5teNZklHJjB39JM7VVhpSfRaxjFHVuczGSw64iCMc91i9tBqJ
         ChOrkVRr114F/6A4TwMcKC5DgQsoClulP/5HqqWZSMiyI5ER0LFNg1w11dwjoocf5Rpg
         cIzvhGrrGQFxWzOIHI4RqIS0UoDfrwS/5389A1aD4CTbasFpm9hG+Uw4CfyzP3EiAk7S
         J47w==
X-Gm-Message-State: AOAM531Oa6mDkmQ4rgVJl5vnGphWCtfW8pD9ybC60g/g7RTc85Y2wrk9
        w0uyFKyw+1pAWQ89aLZnatrbG6o5OaNsmDZm1X0JITHSitD6LEZdx+2Mg7aQYe4TgUIja1UtZSo
        7k+RaTHqAu29G
X-Received: by 2002:a17:906:1b1b:: with SMTP id o27mr2639644ejg.279.1636404423705;
        Mon, 08 Nov 2021 12:47:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHeXX6v1Y/zkT+/B4xs2T97LYP9gYWoo7iKkDhZqZnFKyEKA/gGT7a86dVGQrmliVc3sCNZw==
X-Received: by 2002:a17:906:1b1b:: with SMTP id o27mr2639396ejg.279.1636404421330;
        Mon, 08 Nov 2021 12:47:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w1sm10650328edd.49.2021.11.08.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 12:47:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6C5318026D; Mon,  8 Nov 2021 21:46:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        shayagr@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        brouer@redhat.com, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v17 bpf-next 12/23] bpf: add multi-buff support to the
 bpf_xdp_adjust_tail() API
In-Reply-To: <YYl1P+nPSuMjI+e6@lore-desk>
References: <cover.1636044387.git.lorenzo@kernel.org>
 <fd0400802295a87a921ba95d880ad27b9f9b8636.1636044387.git.lorenzo@kernel.org>
 <20211105162941.46b807e5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YYlWcuUwcKGYtWAR@lore-desk> <87fss6r058.fsf@toke.dk>
 <YYl1P+nPSuMjI+e6@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Nov 2021 21:46:59 +0100
Message-ID: <87a6ieqssc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> >> On Thu,  4 Nov 2021 18:35:32 +0100 Lorenzo Bianconi wrote:
>> >> > This change adds support for tail growing and shrinking for XDP multi-buff.
>> >> > 
>> >> > When called on a multi-buffer packet with a grow request, it will always
>> >> > work on the last fragment of the packet. So the maximum grow size is the
>> >> > last fragments tailroom, i.e. no new buffer will be allocated.
>> >> > 
>> >> > When shrinking, it will work from the last fragment, all the way down to
>> >> > the base buffer depending on the shrinking size. It's important to mention
>> >> > that once you shrink down the fragment(s) are freed, so you can not grow
>> >> > again to the original size.
>> >> 
>> >> > +static int bpf_xdp_mb_increase_tail(struct xdp_buff *xdp, int offset)
>> >> > +{
>> >> > +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>> >> > +	skb_frag_t *frag = &sinfo->frags[sinfo->nr_frags - 1];
>> >> > +	int size, tailroom;
>> >> > +
>> >> > +	tailroom = xdp->frame_sz - skb_frag_size(frag) - skb_frag_off(frag);
>> >> 
>> >> I know I complained about this before but the assumption that we can
>> >> use all the space up to xdp->frame_sz makes me uneasy.
>> >> 
>> >> Drivers may not expect the idea that core may decide to extend the 
>> >> last frag.. I don't think the skb path would ever do this.
>> >> 
>> >> How do you feel about any of these options: 
>> >>  - dropping this part for now (return an error for increase)
>> >>  - making this an rxq flag or reading the "reserved frag size"
>> >>    from rxq (so that drivers explicitly opt-in)
>> >>  - adding a test that can be run on real NICs
>> >> ?
>> >
>> > I think this has been added to be symmetric with bpf_xdp_adjust_tail().
>> > I do think there is a real use-case for it so far so I am fine to just
>> > support the shrink part.
>> >
>> > @Eelco, Jesper, Toke: any comments on it?
>> 
>> Well, tail adjust is useful for things like encapsulations that need to
>> add a trailer. Don't see why that wouldn't be something people would
>> want to do for jumboframes as well?
>> 
>
> I agree this would be useful for protocols that add a trailer.
>
>> Not sure I get what the issue is with this either? But having a test
>> that can be run to validate this on hardware would be great in any case,
>> I suppose - we've been discussing more general "compliance tests" for
>> XDP before...
>
> what about option 2? We can add a frag_size field to rxq [0] that is set by
> the driver initializing the xdp_buff. frag_size set to 0 means we can use
> all the buffer.
>
> Regards,
> Lorenzo
>
> [0] pahole -C xdp_rxq_info vmlinux
> struct xdp_rxq_info {
> 	struct net_device *        dev;                  /*     0     8 */
> 	u32                        queue_index;          /*     8     4 */
> 	u32                        reg_state;            /*    12     4 */
> 	struct xdp_mem_info        mem;                  /*    16     8 */
> 	unsigned int               napi_id;              /*    24     4 */
>
> 	/* size: 64, cachelines: 1, members: 5 */
> 	/* padding: 36 */
> } __attribute__((__aligned__(64)));

Works for me :)

-Toke

