Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE357449B6D
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 19:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhKHSKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 13:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234885AbhKHSKy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 13:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636394889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92tSlxcyAg6RieGAjyG4n5v1Q4GuVYjlOG1zKn/iHhQ=;
        b=WhfhlL0K6/175tMisSkrqLVU0LRkWei5PUtgeOWxffsBlq1WGGcf16oGxw+dirqqGcqPF7
        tUdryaLRP9v0N8y3IJHp9eRWENygciRrSHGYFxFkP7Ck/btr5yNYDPjO6jajI0SsY+kCaS
        7xTyJJhMkEUU0bfOZe7zRRulDHdoYg0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-MTT9OWeRMgGDIUeAX9mO7Q-1; Mon, 08 Nov 2021 13:08:07 -0500
X-MC-Unique: MTT9OWeRMgGDIUeAX9mO7Q-1
Received: by mail-ed1-f69.google.com with SMTP id h18-20020a056402281200b003e2e9ea00edso11052138ede.16
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 10:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=92tSlxcyAg6RieGAjyG4n5v1Q4GuVYjlOG1zKn/iHhQ=;
        b=RS8O0IFhR6PCSERtfiww4GBxqmBdIofUyUvimO0eWqBag3pa/iyIfxtKbLP9XRhZJi
         2ooMP4ir0gZcxyyMTji13H0JMRK3K1afyt+s+zkZDrpz80s2MFYYcMqmdyBvn8tDaH+W
         XRsHSxjVDEot+pYzJJGY1CdFQcCO50VJ0DhOZiDzsr8orjI4Jfdj1kcJdiiFTMt4bOL/
         PlJ2XvWT/vz2czB7OMAx8uzjnsEC1Co5rKtQlS0OSOd4L/hHcrI5/hOlR9d5bohk1N1x
         y8QZ2A51DBmwOIi5ySRR8SEnDBzInMO9shpQ0/1h5JGKk66EaCiBbz0iMyXBGdf+QoOS
         XUEw==
X-Gm-Message-State: AOAM5309+o8I29ig5bRCR+RFjtv2xxl4l9P+r1r1DtbcCkYNtODP3LAJ
        byFaTywjycq8CVaKU/FTl2F3f1AUxViyfVx7Ssxhane+ATS85vP7uLXbIGxMd5/x2e1xF13jK3Z
        8I7wMzalR8X5K
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr1429330ejb.558.1636394885855;
        Mon, 08 Nov 2021 10:08:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz93B2AV89r1ymFJQ+wwa/FG2nea1AqvyhJPFBi0z5drQrLhm5wg/TLvmHQ2uJWMUsNk/qiog==
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr1429273ejb.558.1636394885405;
        Mon, 08 Nov 2021 10:08:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jt24sm8242608ejb.59.2021.11.08.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:08:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D6F9218026D; Mon,  8 Nov 2021 19:08:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, john.fastabend@gmail.com,
        dsahern@kernel.org, brouer@redhat.com, echaudro@redhat.com,
        jasowang@redhat.com, alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v17 bpf-next 12/23] bpf: add multi-buff support to the
 bpf_xdp_adjust_tail() API
In-Reply-To: <YYlWcuUwcKGYtWAR@lore-desk>
References: <cover.1636044387.git.lorenzo@kernel.org>
 <fd0400802295a87a921ba95d880ad27b9f9b8636.1636044387.git.lorenzo@kernel.org>
 <20211105162941.46b807e5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YYlWcuUwcKGYtWAR@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Nov 2021 19:08:03 +0100
Message-ID: <87fss6r058.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> On Thu,  4 Nov 2021 18:35:32 +0100 Lorenzo Bianconi wrote:
>> > This change adds support for tail growing and shrinking for XDP multi-buff.
>> > 
>> > When called on a multi-buffer packet with a grow request, it will always
>> > work on the last fragment of the packet. So the maximum grow size is the
>> > last fragments tailroom, i.e. no new buffer will be allocated.
>> > 
>> > When shrinking, it will work from the last fragment, all the way down to
>> > the base buffer depending on the shrinking size. It's important to mention
>> > that once you shrink down the fragment(s) are freed, so you can not grow
>> > again to the original size.
>> 
>> > +static int bpf_xdp_mb_increase_tail(struct xdp_buff *xdp, int offset)
>> > +{
>> > +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>> > +	skb_frag_t *frag = &sinfo->frags[sinfo->nr_frags - 1];
>> > +	int size, tailroom;
>> > +
>> > +	tailroom = xdp->frame_sz - skb_frag_size(frag) - skb_frag_off(frag);
>> 
>> I know I complained about this before but the assumption that we can
>> use all the space up to xdp->frame_sz makes me uneasy.
>> 
>> Drivers may not expect the idea that core may decide to extend the 
>> last frag.. I don't think the skb path would ever do this.
>> 
>> How do you feel about any of these options: 
>>  - dropping this part for now (return an error for increase)
>>  - making this an rxq flag or reading the "reserved frag size"
>>    from rxq (so that drivers explicitly opt-in)
>>  - adding a test that can be run on real NICs
>> ?
>
> I think this has been added to be symmetric with bpf_xdp_adjust_tail().
> I do think there is a real use-case for it so far so I am fine to just
> support the shrink part.
>
> @Eelco, Jesper, Toke: any comments on it?

Well, tail adjust is useful for things like encapsulations that need to
add a trailer. Don't see why that wouldn't be something people would
want to do for jumboframes as well?

Not sure I get what the issue is with this either? But having a test
that can be run to validate this on hardware would be great in any case,
I suppose - we've been discussing more general "compliance tests" for
XDP before...

-Toke

