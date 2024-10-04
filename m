Return-Path: <bpf+bounces-40939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3A9904EF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D832B20D9C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B62139C8;
	Fri,  4 Oct 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="adLdOpJA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D082101A7
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050117; cv=none; b=qRW/x8NB/Wh6Kf5wkKck5y4CpPwjtxMjmz8lUYLqT+SXUCXyAkZnE5SIRBQqwDQL++hjlNGhBPrjuqQWGinr//gvGuxHiWWuiS/cGkbd8pqT9qWZGu4truZa20RdXgBldP0IR2GyzHxcWzPq9kX27ulr/M9F01WltaQ8W2DdPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050117; c=relaxed/simple;
	bh=bV6wW+1YqGCb0bkNHMmxaFIf2QsQFcLf/TlDWuoTGLc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=m92KuLPkBe0Ed/6yjvERUNbImj0RQzNiWirBKFHZ+LDYsnOA2hrmCmid02PVvSlGXWKXHbPWfuOPzUnKL9Z/l7wZwDYvpoiJswrjU41ZbOXroL0mwV0/KxIhYzIn1SNmtULu6ahMhzZk4R6c258TBl5UGNGt3NRqnzKWCz8UUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=adLdOpJA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso1363806f8f.2
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728050114; x=1728654914; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNYZH5yk5RBPis3PkfiwxOzrh/DxAti5Ed/4hlA/rxo=;
        b=adLdOpJA+xe/bIIDjXQBni7a0qQ3Fij9VA/FjzKYyoTbO5+8YIYKmTGD9l59Sn84OL
         ByZb/Gppii+0JEYq2xWh7AiKVy1YT5LQKQ866XFzhTUV5edXR4l+HGdT8XG4/iFfddoO
         wo+AEtewgLbM/34JM6QvSM2h5kBr8SL/5FpPxhfqekcnv52Ym3iyAddTF9Pp2BHzvqjr
         vf3+PF2pdaptuAXmaOIE16JPdjKJayopWVEUsHShBJW5nxZF2mAvL8LrGBBdgBooRvih
         Ob6YL5emMc58/T4R+VePxv+1rl0IM56QAX49YeOWPOFcv+DZqcEkPSNE+SjDo4RMVDiC
         Eaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050114; x=1728654914;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNYZH5yk5RBPis3PkfiwxOzrh/DxAti5Ed/4hlA/rxo=;
        b=VVu861GeVhjh4TBxTJ0PyF2CA+LfZxXJFmh/l0YIVdUhvIRV4jZljfAD6f7rzwjJFk
         yzOktqtTUrZi9sMx6BwK/VYL5XPYxRDjCTqz1Rn6nwf8Tcm8Ff2itFxdPzildptDEdG5
         CuqdJpb4RACZ/92NqWgMpAo8PyCa24qa49OalpnrKQMBqDs2mWwjJ6GV/NF9DUzFlzcg
         EXptugfPfbY1PX1geAaasAJ31z2ST19ob8cxq3eEdkehILp5UxjOKsEu/XrCvJ7xB2Di
         ZzCTp3KFw5FALMkKQ8d3o9rnLMMpkxwLhOQ020DVlhqeKabViGpfeM1R1uTGzNg8g+Sp
         tTxg==
X-Forwarded-Encrypted: i=1; AJvYcCWRlyLCdnbhBIV+a+PQLcWiggu+v6iLrEiy3PHVqu5rykPIbNP/O6GYRSBcQ1G4uTRV/z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1ubJHIYElKGCkanID7x/Lfh8BDHfaQ6VCVAkdGeS6qHmJ5Hr
	Zc9s7VpZBK6MHijW2FpWtxnhI3uDXDlNH26jsYSePlWmI8WNwQFcl4iHY9QqDYg=
X-Google-Smtp-Source: AGHT+IFtu5umZBfH6/IiaE3XVq2bAaE74f7neCyeNg9pQd9XAeJmoVZo9hWEaKWhLH3oyXhtOF7g9Q==
X-Received: by 2002:adf:e50d:0:b0:37c:d121:e841 with SMTP id ffacd0b85a97d-37d0e8e03f0mr1813504f8f.40.1728050114034;
        Fri, 04 Oct 2024 06:55:14 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::31:92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f7035sm3280815f8f.23.2024.10.04.06.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 06:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Oct 2024 15:55:11 +0200
Message-Id: <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
To: "Jesper Dangaard Brouer" <hawk@kernel.org>, "Daniel Xu" <dxu@dxuuu.xyz>,
 "Stanislav Fomichev" <stfomichev@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "Lorenzo Bianconi"
 <lorenzo.bianconi@redhat.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
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
From: "Arthur Fabre" <afabre@cloudflare.com>
X-Mailer: aerc 0.8.2
References: <871q11s91e.fsf@toke.dk> <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby> <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
In-Reply-To: <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>

On Fri Oct 4, 2024 at 12:38 PM CEST, Jesper Dangaard Brouer wrote:
> [...]
> >>> There are two different use-cases for the metadata:
> >>>
> >>> * "Hardware" metadata (like the hash, rx_timestamp...). There are onl=
y a
> >>>    few well known fields, and only XDP can access them to set them as
> >>>    metadata, so storing them in a struct somewhere could make sense.
> >>>
> >>> * Arbitrary metadata used by services. Eg a TC filter could set a fie=
ld
> >>>    describing which service a packet is for, and that could be reused=
 for
> >>>    iptables, routing, socket dispatch...
> >>>    Similarly we could set a "packet_id" field that uniquely identifie=
s a
> >>>    packet so we can trace it throughout the network stack (through
> >>>    clones, encap, decap, userspace services...).
> >>>    The skb->mark, but with more room, and better support for sharing =
it.
> >>>
> >>> We can only know the layout ahead of time for the first one. And they=
're
> >>> similar enough in their requirements (need to be stored somewhere in =
the
> >>> SKB, have a way of retrieving each one individually, that it seems to
> >>> make sense to use a common API).
> >>
> >> Why not have the following layout then?
> >>
> >> +---------------+-------------------+---------------------------------=
-------+------+
> >> | more headroom | user-defined meta | hw-meta (potentially fixed skb f=
ormat) | data |
> >> +---------------+-------------------+---------------------------------=
-------+------+
> >>                  ^                                                    =
        ^
> >>              data_meta                                                =
      data
> >>
> >> You obviously still have a problem of communicating the layout if you
> >> have some redirects in between, but you, in theory still have this
> >> problem with user-defined metadata anyway (unless I'm missing
> >> something).
> >>
>
> Hmm, I think you are missing something... As far as I'm concerned we are
> discussing placing the KV data after the xdp_frame, and not in the XDP
> data_meta area (as your drawing suggests).  The xdp_frame is stored at
> the very top of the headroom.  Lorenzo's patchset is extending struct
> xdp_frame and now we are discussing to we can make a more flexible API
> for extending this. I understand that Toke confirmed this here [3].  Let
> me know if I missed something :-)
>
>   [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
>
> As part of designing this flexible API, we/Toke are trying hard not to
> tie this to a specific data area.  This is a good API design, keeping it
> flexible enough that we can move things around should the need arise.

+1. And if we have an API for doing this for user-defined metadata, it
seems like we might as well use it for hardware metadata too.

With something roughly like:

    *val get(id)

    set(id, *val)

with pre-defined ids for hardware metadata, consumers don't need to know=20
the layout, or where / how the data is stored.

Under the hood we can implement it however we want, and change it in the
future.

I was initially thinking we could store hardware metadata the same way
as user defined metadata, but Toke and Lorenzo seem to prefer storing it
in a fixed struct.

