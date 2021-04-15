Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D273605AF
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhDOJ3v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 05:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231488AbhDOJ3t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 05:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618478964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2kU6pnkx8ahC9lrMW5Fx29wiRnsU7XdlivJV5ohDfks=;
        b=RNjaTJQVA3THVxAD3LARhO7Q+m3IE/Y6KbjW7Z8D9bMazX2FzTxIfRtBDdLIU08B3sYDhg
        1AcTa8V4J6xIRZjyCnYRs71m4TYpa5EuoB9IG7HSDkliXm1/BK9wyOrxcjUcHEjXi3hXLx
        8VIUbl+b886/yyI8FYdTjhmy3DHoNio=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-VPaCU54NM2SvgCCnJZ4_ig-1; Thu, 15 Apr 2021 05:29:23 -0400
X-MC-Unique: VPaCU54NM2SvgCCnJZ4_ig-1
Received: by mail-ed1-f70.google.com with SMTP id c5-20020aa7d6050000b02903825f4da4f3so4835108edr.16
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2kU6pnkx8ahC9lrMW5Fx29wiRnsU7XdlivJV5ohDfks=;
        b=ra4fG30B3p98XU+fSGBIb4xBwPv26vcqtputt2gXkgDzrAu6BlGCjEy5SKNT77HZS7
         5sT7DHB6Od+FbijkAXvD3tQ8UEw+svSsOqrJ3i93d5Z76z4afvZViaCwSixs5S+4Ksnr
         Cozj571YZRk/8EAb5Cm2CBKePiXAu1JDlQirNsnLbZRi1vfBjNsvAqF49HZY6Ct5W+S5
         rymIOkMl20QIFccU8jQYID26nxm+3MmOHkEsgBVPBmb6DRsGaTS6VeEDtkzdASio3X5S
         LSFTRPXAJ9QTb2RzacZ1YHwW0pSDRdeE3qldYYoihKdWAMy3gpw7Vdq4Fzi/svCZy42e
         kwBA==
X-Gm-Message-State: AOAM532WcHiQ2JMy+mOlwDt3cZZYhF03fDx8rRu2QfbK1s5zlkH5WHad
        iktf14VvNVHdT+F/H7FRdrY+/34plt1SE75+mczNjbvjAvvSrMypMIuUVwX128k1DzvJPourYLL
        PTQprC2vOjr1q
X-Received: by 2002:a05:6402:5153:: with SMTP id n19mr3043718edd.173.1618478961828;
        Thu, 15 Apr 2021 02:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN1YONbgCaDAZ7dB148jhXZY0vOhSLRfPeDL37+0RZfGd1KDG48fS8Qo4Vek+pOtpWNjw9uQ==
X-Received: by 2002:a05:6402:5153:: with SMTP id n19mr3043699edd.173.1618478961521;
        Thu, 15 Apr 2021 02:29:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k8sm1937480edr.75.2021.04.15.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:29:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 47FBC1806B3; Thu, 15 Apr 2021 11:29:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>, Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
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
        <bjorn.topel@gmail.com>
Subject: Re: [PATCHv7 bpf-next 2/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210415022127.GQ2900@Leo-laptop-t470s>
References: <20210414122610.4037085-1-liuhangbin@gmail.com>
 <20210414122610.4037085-3-liuhangbin@gmail.com>
 <20210415002350.247ni4rqjwzguu4j@kafai-mbp.dhcp.thefacebook.com>
 <20210415022127.GQ2900@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Apr 2021 11:29:20 +0200
Message-ID: <87lf9jkia7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, Apr 14, 2021 at 05:23:50PM -0700, Martin KaFai Lau wrote:
>> On Wed, Apr 14, 2021 at 08:26:08PM +0800, Hangbin Liu wrote:
>> [ ... ]
>> 
>> > +static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifindex,
>> > +						  u64 flags, u64 flag_mask,
>> >  						  void *lookup_elem(struct bpf_map *map, u32 key))
>> >  {
>> >  	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
>> >  
>> >  	/* Lower bits of the flags are used as return code on lookup failure */
>> > -	if (unlikely(flags > XDP_TX))
>> > +	if (unlikely(flags & ~(BPF_F_ACTION_MASK | flag_mask)))
>> >  		return XDP_ABORTED;
>> >  
>> >  	ri->tgt_value = lookup_elem(map, ifindex);
>> > -	if (unlikely(!ri->tgt_value)) {
>> > +	if (unlikely(!ri->tgt_value) && !(flags & BPF_F_BROADCAST)) {
>> >  		/* If the lookup fails we want to clear out the state in the
>> >  		 * redirect_info struct completely, so that if an eBPF program
>> >  		 * performs multiple lookups, the last one always takes
>> > @@ -1482,13 +1484,21 @@ static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifind
>> >  		 */
>> >  		ri->map_id = INT_MAX; /* Valid map id idr range: [1,INT_MAX[ */
>> >  		ri->map_type = BPF_MAP_TYPE_UNSPEC;
>> > -		return flags;
>> > +		return flags & BPF_F_ACTION_MASK;
>> >  	}
>> >  
>> >  	ri->tgt_index = ifindex;
>> >  	ri->map_id = map->id;
>> >  	ri->map_type = map->map_type;
>> >  
>> > +	if (flags & BPF_F_BROADCAST) {
>> > +		WRITE_ONCE(ri->map, map);
>> Why only WRITE_ONCE on ri->map?  Is it needed?
>
> I think this is make sure the map pointer assigned to ri->map safely.
> which starts from commit f6069b9aa993 ("bpf: fix redirect to map under tail
> calls")

The reason WRITE_ONCE() is only on the map field is because that's the
one that could be changed by a remote CPU (in bpf_clear_redirect_map())
- everything else is only accessed on the local CPU.

As for whether it's strictly needed from a memory model PoV, I'm not
actually sure (and should we be using smp_{store_release,load_acquire}()
instead?); I view it mostly as an annotation to make it clear that the
map field is 'special' in this respect...

-Toke

