Return-Path: <bpf+bounces-40945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C070990614
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD83282095
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C347217337;
	Fri,  4 Oct 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ReclbQ19"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AC69D2B
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052169; cv=none; b=O5tu7BhcVKBtJiOzSFmILJu3Vwj+3A1F8eQ0LAl1akopjsuBhpalYgfANWS309C4qYJJAV8ZCDQZGoGgaXZSqB4uW0GMu7WJPF8jlUwrbAX4AxxD7Gd88k2baR6eUE54dFGKQ5yyNDrVgPkwtgj0rebBoQD6c5kmyON0IBUABzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052169; c=relaxed/simple;
	bh=mE3LWvhRzbJY5LUB/JwX/iB8jrOFlrAg7Z2RWvjpBX4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mL1++SiyPBUzVeftwGY0f7yj8oCmM1gS9DR7z/ZPEb6OgHB8Ihi1PKVSQpg6VtWXKbZHs+TN24G2PJm6yqrcjF3l1t5aMl+G3ADzKTZa8QkH3AEOnezYocw/vyiVTE9LNNgxmBNmkm1t3YLozEEbqzFuMAzvNaT7l7LSelg9Anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ReclbQ19; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cd831ab06so1368132f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728052166; x=1728656966; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYRKMpJ4OBC0LQYCHSn1P6nBU6dgmdu8HhUM6MMa+jE=;
        b=ReclbQ19DXJBAujsnuXejP7nRdtuC+UMY/UUfYsxpizRmg2uqLUzEZyhGaIh9bAlaa
         +vkISBMVRcw2F9uo8kBtEZvazFEEUKRHw90M2X294Ui7HQj1Z83AJayfFc8Y3aToBOoJ
         jm5I5TO10ckFDqPcAATqYMFPW0vmDrNxVLr20zGgMEBAQpt4jY1vRxUhNjVeFOMOAivp
         jjyPbYlu/C0SDQOguuDLZIruE8Bn8uoCNfAV6Ub/LBOxi9Mb5u95ytBhknQ6RgjisRrd
         3+8K31zFXzzm82OwjGPHADglm9M0lvQyVKurSgiYBQn15H5xBpcw6c4KY9GzDBrQLra9
         Cdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728052166; x=1728656966;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rYRKMpJ4OBC0LQYCHSn1P6nBU6dgmdu8HhUM6MMa+jE=;
        b=tDwd1gzVgHkaXLcKNYmFcbtLJBhee4DkFWt6fQ1YdYULOtnOW9EzcWRPl9bXhO/b8E
         guILetQFlLGxfzljUXoTYBc7CxTHTV2yJWjk1czZp2xpdpqXYztGBG5XSZGJmogr4d8j
         zrZH2tuR++lt9+JwqqGO4q0M9GhJWtSpbReyOaRF2Nh64vc6tyuC8EJPVcKfpAsYi4nT
         4w6xcQ9qrljHThjCZA3crnmONokGxk71U/5p9G1SK4jpmlPx+fqKeyPUPfYItdfTIXZx
         0iIUfx5feu9EKXGv9rWTkCxwnRrUOGQ+YAQBusAV/XX3e6nubYFN70a3b96v2Eo4hAr/
         Q2cw==
X-Forwarded-Encrypted: i=1; AJvYcCUBQUa4PS7hZFkN39m1/kP49tw+e5OyUtwKnbN1jIViPY1w8eQXCPV8CZiGhNEKZN9rIzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQ6JQXoS3UjoU+5V8MsUe68AbCCOb8YDVB0vQ1z4zTek0pmam
	EEUdYvnxYRfh5zDVVbUs62MF6aql9/S7hnhLYtlCjCJ4JYs9U8ViTCwrxdBWHh4=
X-Google-Smtp-Source: AGHT+IGfwB1d0G2mnqATVG3785KhqOhSttTikbEtmWl9Q33QYeDl/m5n3wD4HEhVBVCt8hb+z5i61A==
X-Received: by 2002:a05:6000:1866:b0:37c:c870:b454 with SMTP id ffacd0b85a97d-37d0e8f708fmr2201971f8f.49.1728052165950;
        Fri, 04 Oct 2024 07:29:25 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::31:92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a1f42esm17045225e9.4.2024.10.04.07.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 07:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Oct 2024 16:29:23 +0200
Message-Id: <D4N3D8N0MUJE.2X8G8YM8UMA3N@bobby>
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Lorenzo Bianconi" <lorenzo@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>
Cc: "Daniel Xu" <dxu@dxuuu.xyz>, "Stanislav Fomichev"
 <stfomichev@gmail.com>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>, "Jakub
 Sitnicki" <jakub@cloudflare.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <kuba@kernel.org>, <john.fastabend@gmail.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sdf@fomichev.me>,
 <tariqt@nvidia.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
X-Mailer: aerc 0.8.2
References: <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
 <75fb1dd3-fe14-426c-bc59-9a582c4b0e8d@kernel.org>
 <Zv_5KdpkaYY-6z1f@lore-desk>
In-Reply-To: <Zv_5KdpkaYY-6z1f@lore-desk>

On Fri Oct 4, 2024 at 4:18 PM CEST, Lorenzo Bianconi wrote:
> On Oct 04, Jesper Dangaard Brouer wrote:
> > On 04/10/2024 15.55, Arthur Fabre wrote:
> > > On Fri Oct 4, 2024 at 12:38 PM CEST, Jesper Dangaard Brouer wrote:
> > > > [...]
> > > > > > > There are two different use-cases for the metadata:
> > > > > > >=20
> > > > > > > * "Hardware" metadata (like the hash, rx_timestamp...). There=
 are only a
> > > > > > >     few well known fields, and only XDP can access them to se=
t them as
> > > > > > >     metadata, so storing them in a struct somewhere could mak=
e sense.
> > > > > > >=20
> > > > > > > * Arbitrary metadata used by services. Eg a TC filter could s=
et a field
> > > > > > >     describing which service a packet is for, and that could =
be reused for
> > > > > > >     iptables, routing, socket dispatch...
> > > > > > >     Similarly we could set a "packet_id" field that uniquely =
identifies a
> > > > > > >     packet so we can trace it throughout the network stack (t=
hrough
> > > > > > >     clones, encap, decap, userspace services...).
> > > > > > >     The skb->mark, but with more room, and better support for=
 sharing it.
> > > > > > >=20
> > > > > > > We can only know the layout ahead of time for the first one. =
And they're
> > > > > > > similar enough in their requirements (need to be stored somew=
here in the
> > > > > > > SKB, have a way of retrieving each one individually, that it =
seems to
> > > > > > > make sense to use a common API).
> > > > > >=20
> > > > > > Why not have the following layout then?
> > > > > >=20
> > > > > > +---------------+-------------------+--------------------------=
--------------+------+
> > > > > > | more headroom | user-defined meta | hw-meta (potentially fixe=
d skb format) | data |
> > > > > > +---------------+-------------------+--------------------------=
--------------+------+
> > > > > >                   ^                                            =
                ^
> > > > > >               data_meta                                        =
              data
> > > > > >=20
> > > > > > You obviously still have a problem of communicating the layout =
if you
> > > > > > have some redirects in between, but you, in theory still have t=
his
> > > > > > problem with user-defined metadata anyway (unless I'm missing
> > > > > > something).
> > > > > >=20
> > > >=20
> > > > Hmm, I think you are missing something... As far as I'm concerned w=
e are
> > > > discussing placing the KV data after the xdp_frame, and not in the =
XDP
> > > > data_meta area (as your drawing suggests).  The xdp_frame is stored=
 at
> > > > the very top of the headroom.  Lorenzo's patchset is extending stru=
ct
> > > > xdp_frame and now we are discussing to we can make a more flexible =
API
> > > > for extending this. I understand that Toke confirmed this here [3].=
  Let
> > > > me know if I missed something :-)
> > > >=20
> > > >    [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
> > > >=20
> > > > As part of designing this flexible API, we/Toke are trying hard not=
 to
> > > > tie this to a specific data area.  This is a good API design, keepi=
ng it
> > > > flexible enough that we can move things around should the need aris=
e.
> > >=20
> > > +1. And if we have an API for doing this for user-defined metadata, i=
t
> > > seems like we might as well use it for hardware metadata too.
> > >=20
> > > With something roughly like:
> > >=20
> > >      *val get(id)
> > >=20
> > >      set(id, *val)
> > >=20
> > > with pre-defined ids for hardware metadata, consumers don't need to k=
now
> > > the layout, or where / how the data is stored.
> > >=20
> > > Under the hood we can implement it however we want, and change it in =
the
> > > future.
> > >=20
> > > I was initially thinking we could store hardware metadata the same wa=
y
> > > as user defined metadata, but Toke and Lorenzo seem to prefer storing=
 it
> > > in a fixed struct.
> >=20
> > If the API hide the actual location then we can always move things
> > around, later.  If your popcnt approach is fast enough, then IMO we
> > don't need a fixed struct for hardware metadata.
>
> +1. I am fine with the KV approach for nic metadata as well if it is fast=
 enough.

Great! That's simpler. I should have something for Jesper to benchmark
on Monday.

> If you want I can modify my series to use kfunc sto store data after xdp_=
frame
> and then you can plug the KV encoding. What do you think? Up to you.

Thanks for the offer! That works for me :)

