Return-Path: <bpf+bounces-18372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D2D819CB0
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 11:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3A282CFC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551C21371;
	Wed, 20 Dec 2023 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i927pW08"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577521362
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703067770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tenCflcvwHDUupcimFI6COHvWVks/d4mt7BRqPCBH0=;
	b=i927pW082998OCCHVinpFZ9nDQkG9ZzvLWuKuuOYYQ7JdcAp4WruzhD5DP9f/gm3LL+hJG
	SzDe0l1gRsm7dLiHMKNApSCbNvDmbRm/GJ5QUyBawnhcLNa5q4wGwRfGQL62XrISS1HNAm
	U/wp+MJ+kJgWNVpIOcX5vjgOEyltfx0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-CMuRLN5oOc6d5Vw2WcII8A-1; Wed, 20 Dec 2023 05:22:49 -0500
X-MC-Unique: CMuRLN5oOc6d5Vw2WcII8A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a268540bc61so19068966b.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 02:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067767; x=1703672567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tenCflcvwHDUupcimFI6COHvWVks/d4mt7BRqPCBH0=;
        b=rGqg/n+kmismw8KMfxCsMsDFC4z/XgpIPB9zopWgLQSTWWf/UTKDKcconqPqa6Zjdc
         0cJFmEgKx2mUoq+3oaBh4ol6iEnDFpVURT2QQWIHzLFBWKcqwux6a9A3AWqoFKrGnXMu
         kLVnlGwC0HfrhzRkTqggIWROUudvj56IkLXsII+jPdIW4M5Mt8cGhGEqcWMsD8SReTwz
         cpiA0sbakBwYfZ/R4Jtts/37pKm6J7xA+a9ys/cocjRZaWChAdnSDHN22goVhzyrkks/
         wWBlpURh9eoGVl+m9QvVHra8lROU+lZD3YoyBt5pgoQsz4qxr+nj8uLRmWzbvPP4w35G
         H9AA==
X-Gm-Message-State: AOJu0YzpuGNu4VT787IcP8GW7STG+DCIxNfvkKqL3MvNZerPG45ezIy6
	ceIQZZRMZDE+9EDgqKq1voPWViqMRXh/q3jBWHjjF6Q91EQF2SwgJuKYYoGPnIqqvGK+aXkRryu
	QwGazxGAU9t5iD5nbg2Ay
X-Received: by 2002:a17:907:72c3:b0:a23:679c:4683 with SMTP id du3-20020a17090772c300b00a23679c4683mr4746679ejc.4.1703067767658;
        Wed, 20 Dec 2023 02:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtUPRbx8MOeVOB8yA1mqeocJegsUUHrUmn8bGLwalPKHDnymDVFdMN/bgsTjAY0nQT2gkKMA==
X-Received: by 2002:a17:907:72c3:b0:a23:679c:4683 with SMTP id du3-20020a17090772c300b00a23679c4683mr4746660ejc.4.1703067767211;
        Wed, 20 Dec 2023 02:22:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906265300b00a234c5d0834sm4115922ejc.175.2023.12.20.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:22:46 -0800 (PST)
Message-ID: <533e8e80c4db4ecd34a2c49dd3de3e76810afe22.camel@redhat.com>
Subject: Re: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in
 skb_steal_sock().
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>, Kuniyuki Iwashima
 <kuniyu@amazon.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, edumazet@google.com, 
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  kuni1840@gmail.com, martin.lau@linux.dev,
 netdev@vger.kernel.org,  mptcp@lists.linux.dev
Date: Wed, 20 Dec 2023 11:22:45 +0100
In-Reply-To: <7d00ad25-abaa-191d-8e80-32674377b053@kernel.org>
References: 
	<CANn89i+8e8VJ8cJX6vwLFhtj=BmT233nNr=F9H3nFs8BZgTbsQ@mail.gmail.com>
	 <20231215023707.41864-1-kuniyu@amazon.com>
	 <7d00ad25-abaa-191d-8e80-32674377b053@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 08:45 -0800, Mat Martineau wrote:
> On Fri, 15 Dec 2023, Kuniyuki Iwashima wrote:
>=20
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Thu, 14 Dec 2023 17:31:15 +0100
> > > On Thu, Dec 14, 2023 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >=20
> > > > We will support arbitrary SYN Cookie with BPF.
> > > >=20
> > > > If BPF prog validates ACK and kfunc allocates a reqsk, it will
> > > > be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
> > > > the reqsk has its listener as req->rsk_listener with no refcnt
> > > > taken.
> > > >=20
> > > > When the TCP stack looks up a socket from the skb, we steal
> > > > inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
> > > > the skb will be processed in cookie_v[46]_check() with the
> > > > listener.
> > > >=20
> > > > Note that we do not clear skb->sk and skb->destructor so that we
> > > > can carry the reqsk to cookie_v[46]_check().
> > > >=20
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  include/net/request_sock.h | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/net/request_sock.h b/include/net/request_sock.=
h
> > > > index 26c630c40abb..8839133d6f6b 100644
> > > > --- a/include/net/request_sock.h
> > > > +++ b/include/net/request_sock.h
> > > > @@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(str=
uct sk_buff *skb,
> > > >         }
> > > >=20
> > > >         *prefetched =3D skb_sk_is_prefetched(skb);
> > > > -       if (*prefetched)
> > > > +       if (*prefetched) {
> > > > +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> > > > +               if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV && inet_re=
qsk(sk)->syncookie) {
> > > > +                       struct request_sock *req =3D inet_reqsk(sk)=
;
> > > > +
> > > > +                       *refcounted =3D false;
> > > > +                       sk =3D req->rsk_listener;
> > > > +                       req->rsk_listener =3D NULL;
> > >=20
> > > I am not sure about interactions with MPTCP.
> > >=20
> > > I would be nice to have their feedback.
> >=20
> > Matthieu, Mat, Paolo, could you double check if the change
> > above is sane ?
> > https://lore.kernel.org/bpf/20231214155424.67136-4-kuniyu@amazon.com/
>=20
> Hi Kuniyuki -
>=20
> Yes, we will take a look. Haven't had time to look in detail yet but I=
=20
> wanted to let you know we saw your message and will follow up.

I'm sorry for the late reply.

AFAICS, from mptcp perspective, the main differences from built-in
cookie validation are:

- cookie allocation via mptcp_subflow_reqsk_alloc() and cookie
'finalization' via cookie_tcp_reqsk_init() /
mptcp_subflow_init_cookie_req(req, sk, skb) could refer 2 different
listeners - within the same REUSEPORT group.

- incoming pure syn packets will not land into the TCP stack, so
af_ops->route_req will not happen.

I think both the above are problematic form mptcp.=C2=A0

Potentially we can have both mptcp-enabled and plain tcp socket with
the same reuseport group.=20

Currently the mptcp code assumes the listener is mptcp
cookie_tcp_reqsk_init(), the req is mptcp, too. I think we could fix
this at the mptcp level, but no patch ready at the moment.

Even the missing call to route_req() is problematic, as we use that to
fetch required information from the initial syn for MP_JOIN subflows -
yep, unfortunately mptcp needs to track of some state across MPJ syn
and MPJ 3rd ack reception.

Fixing this last item looks more difficult. I think it would be safer
and simpler to avoid mptcp support for generic syncookie and ev enable
it later - after we address things on the mptcp side.

@Eric, were you looking to something else and/or more specific?

Thanks!

Paolo



