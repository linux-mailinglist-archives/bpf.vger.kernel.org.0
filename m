Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1E36A093
	for <lists+bpf@lfdr.de>; Sat, 24 Apr 2021 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhDXJyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Apr 2021 05:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237054AbhDXJyT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 24 Apr 2021 05:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619258020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vvarF7tleWgKobJBRvOBVQVnBeK645Sn0Qu8FN72LA=;
        b=EUAMiRBdnWD2BF65F4TQlsqNGbMglKzeuezoYpuJk/5SnJo7i8cs0X66ZQ9v/210m1G4uQ
        k6klWedrX0FVLxD0C5bb00io3ky/uERAjjB3unlgw669JYwX5BpFLadExEAJhOOriWC4jr
        Uj21nHoe8KX1BiG6Rs4+1bZvP2Md9X4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-p8_hkfrwOGygbbbJj_YePQ-1; Sat, 24 Apr 2021 05:53:39 -0400
X-MC-Unique: p8_hkfrwOGygbbbJj_YePQ-1
Received: by mail-ed1-f72.google.com with SMTP id r14-20020a50d68e0000b0290385504d6e4eso10121125edi.7
        for <bpf@vger.kernel.org>; Sat, 24 Apr 2021 02:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6vvarF7tleWgKobJBRvOBVQVnBeK645Sn0Qu8FN72LA=;
        b=MQjER5iOSHkG+tmI3b2AZ5kuAukpieOvRRz0vKiPe7fjPW6fPRWgKghg1kDbJ/tECm
         a41oFdIvNEQsCUT7FMY8qAq14VCNlLGX/Hu0DBeEH/Dtloz9gyqlU2djGk42xKAmCTlx
         suL3p0r6GzLHClu5AbGGath164CJEHR1bB+hQW9KrIMG/IrXgLJ9aRarLI8TSY8lUIVs
         cu0L0G4UE9pqCpdfBEygcT66hf5kSWhG+GFU3vm4JkuCHt6PSCiSGeeEFT6mJfZoA0QM
         vASZXVdAWHLoWTQEdipXqibgJ+hpYu4eHpYSBHvZOnwl7VRAlYHDJd8mgvaa6zSjC7o5
         gVkg==
X-Gm-Message-State: AOAM530wKxuWqXgchKa3PU/KMgAgKyoI/qemLEutFdhUbqndNwCF7JSd
        ed9hqxDP+IL6STnnGbw15zyaQ0rSa7Wh7zV8DWbs2DKMEqikGCMNQptGdpV4SYp9/8C00apMZq7
        NJec+E8DdofSp
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr9424071edc.33.1619258017483;
        Sat, 24 Apr 2021 02:53:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDgq5hbZIFjYRKMDCL7Jul3AJ+fKFZEQN/YXigYbK7gZr7NUuTqMDRVwrCrRYhzbzWzr0i0A==
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr9424044edc.33.1619258017228;
        Sat, 24 Apr 2021 02:53:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s3sm7685956edw.66.2021.04.24.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:53:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F0F01180615; Sat, 24 Apr 2021 11:53:35 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@gmail.com>, Martin KaFai Lau <kafai@fb.com>,
        brouer@redhat.com
Subject: Re: [PATCHv9 bpf-next 2/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210424090129.1b8fe377@carbon>
References: <20210422071454.2023282-1-liuhangbin@gmail.com>
 <20210422071454.2023282-3-liuhangbin@gmail.com>
 <20210422185332.3199ca2e@carbon> <87a6pqfb9x.fsf@toke.dk>
 <20210423185429.126492d0@carbon> <20210424010925.GG3465@Leo-laptop-t470s>
 <20210424090129.1b8fe377@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 24 Apr 2021 11:53:35 +0200
Message-ID: <87zgxoc8kg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Sat, 24 Apr 2021 09:09:25 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
>
>> On Fri, Apr 23, 2021 at 06:54:29PM +0200, Jesper Dangaard Brouer wrote:
>> > On Thu, 22 Apr 2021 20:02:18 +0200
>> > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> >=20=20=20
>> > > Jesper Dangaard Brouer <brouer@redhat.com> writes:
>> > >=20=20=20
>> > > > On Thu, 22 Apr 2021 15:14:52 +0800
>> > > > Hangbin Liu <liuhangbin@gmail.com> wrote:
>> > > >=20=20=20=20
>> > > >> diff --git a/net/core/filter.c b/net/core/filter.c
>> > > >> index cae56d08a670..afec192c3b21 100644
>> > > >> --- a/net/core/filter.c
>> > > >> +++ b/net/core/filter.c=20=20=20=20
>> > > > [...]=20=20=20=20
>> > > >>  int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>> > > >>  		    struct bpf_prog *xdp_prog)
>> > > >>  {
>> > > >> @@ -3933,6 +3950,7 @@ int xdp_do_redirect(struct net_device *dev,=
 struct xdp_buff *xdp,
>> > > >>  	enum bpf_map_type map_type =3D ri->map_type;
>> > > >>  	void *fwd =3D ri->tgt_value;
>> > > >>  	u32 map_id =3D ri->map_id;
>> > > >> +	struct bpf_map *map;
>> > > >>  	int err;
>> > > >>=20=20
>> > > >>  	ri->map_id =3D 0; /* Valid map id idr range: [1,INT_MAX[ */
>> > > >> @@ -3942,7 +3960,12 @@ int xdp_do_redirect(struct net_device *dev=
, struct xdp_buff *xdp,
>> > > >>  	case BPF_MAP_TYPE_DEVMAP:
>> > > >>  		fallthrough;
>> > > >>  	case BPF_MAP_TYPE_DEVMAP_HASH:
>> > > >> -		err =3D dev_map_enqueue(fwd, xdp, dev);
>> > > >> +		map =3D xchg(&ri->map, NULL);=20=20=20=20
>> > > >
>> > > > Hmm, this looks dangerous for performance to have on this fast-pat=
h.
>> > > > The xchg call can be expensive, AFAIK this is an atomic operation.=
=20=20=20=20
>> > >=20
>> > > Ugh, you're right. That's my bad, I suggested replacing the
>> > > READ_ONCE()/WRITE_ONCE() pair with the xchg() because an exchange is
>> > > what it's doing, but I failed to consider the performance implicatio=
ns
>> > > of the atomic operation. Sorry about that, Hangbin! I guess this sho=
uld
>> > > be changed to:
>> > >=20
>> > > +		map =3D READ_ONCE(ri->map);
>> > > +		if (map) {
>> > > +			WRITE_ONCE(ri->map, NULL);
>> > > +			err =3D dev_map_enqueue_multi(xdp, dev, map,
>> > > +						    ri->flags & BPF_F_EXCLUDE_INGRESS);
>> > > +		} else {
>> > > +			err =3D dev_map_enqueue(fwd, xdp, dev);
>> > > +		}=20=20
>> >=20
>> > This is highly sensitive fast-path code, as you saw Bj=C3=B8rn have be=
en
>> > hunting nanosec in this area.  The above code implicitly have "map" as
>> > the likely option, which I don't think it is.=20=20
>>=20
>> Hi Jesper,
>>=20
>> From the performance data, there is only a slightly impact. Do we still =
need
>> to block the whole patch on this? Or if you have a better solution?
>
> I'm basically just asking you to add an unlikely() annotation:

Maybe the maintainers could add this while applying, though? Or we could
fix it in a follow-up? Hangbin has been respinning this series with very
minor changes for a while now, so I can certainly emphasise with his
reluctance to keep doing this. IMO it's way past time to merge this
already... :/

-Toke

