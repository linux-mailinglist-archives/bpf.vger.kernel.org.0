Return-Path: <bpf+bounces-50566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7BA29BD7
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1F37A2CD0
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B916214A95;
	Wed,  5 Feb 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1uoagRK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0731FECAC;
	Wed,  5 Feb 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790711; cv=none; b=BMrRV1MRu89RUvipegNsKate/GWBoFKdlhOYkxTzcJhFjYER6kLwO6bouhYvlHMuS/rNk4mQ2l28mvET/2Qq/EHnPzOmWQ3uMQ4hr0TDVMzLL1vhXoI61LBJy0GAVRUAuQf93rwkHcYzt77EEyqa7ENz4xU6+uBNaPsehYROFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790711; c=relaxed/simple;
	bh=bspsdi0JhrRkLqZVXa/cqiD+zMr29IJ1Q/PfDozmA3M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=u+DBKqrMfmeQGaCpcY5oxkluBETBhjlggpmoHV7PuwRf65CAU7oXHGgTDPY58Skgf6dPSnBU3WLStgk4PLluc2y0NSTa9qM26CBCADjwLpJ3/KXQqjgQ9AH0QDZSKOwTTe9yZkr17O51XV43a29fHhK7pr8mV4svLFUK/zg3wRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1uoagRK; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-866e8ca2e07so42348241.2;
        Wed, 05 Feb 2025 13:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790708; x=1739395508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxmvWj5ZpJ/l9PRt1Au1U66Vo/FgOv8eQRdT6PtZdM8=;
        b=f1uoagRK307aEvSJBCSqDZx5LqQwohqIjw3Eg/Uzt+a8jDFXa64OywAe3SGJZunJA0
         SyMZwwAgZ2piVB3WDXk7TI33/px9we/bevb2BA8OCbIj0JiHDov1CIYFiXa0iPp8DSjv
         Z9tF2CzYBRDikbee0b4JqsdZQJ8+J0x8rrTU5c2ewvrcZjLFnB3Du64J7w/WNlbQfKqZ
         WS32ZwiKBfY4Kzuiif/zllCzs7NEtrWgRi0rgcQmrhUilavoOdLIAkDmk49HnuaPafEO
         8ev1EaS+9IHxLwFHzICbGq5jPZJuzhSr+WcwxLrF6kyZYBBaCTd/6WswFSmEhZmcprrX
         jlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790708; x=1739395508;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxmvWj5ZpJ/l9PRt1Au1U66Vo/FgOv8eQRdT6PtZdM8=;
        b=jApuLo2/074Mu0s5ITyDz1VPxJ0pgVoQPx/9+kH8TWKsH1GghICCUTOnnwXsiDgtGM
         05z+PqYp4QJ1bN4pWPDC7OScL6sRMpbESerMAWK91WVuSZx92z++iw93LHGsYPfrbpEl
         RUimW7oCfXV84AQOc4o9EtECO04dsVWKyIcHBFID8OVViqEqOmyuwT4Tc8otVdwLBrZ3
         q01b0pG0ftBrtmPgZKfqIjRhQy44tk4vcYttdzun73JM0HLXw8mtoyxO/q28QzqOjbcr
         zLcMihy4fzU3DZ2oSpp8GQ1y5856OkayZfDFRQGuZnWquuRkMZgxVRf8uPz4JYKNd4OA
         6zQg==
X-Forwarded-Encrypted: i=1; AJvYcCUHcOWRZTDxttHFGfWWbiX0y6IFQlGczdDuqKoc5SvnVPobg33es0yihcWyHiJdbYITawg=@vger.kernel.org, AJvYcCW9Laz3pIfr9r/G4+kDy2VonRSueSx38+9ZH6ED++gnczGqE8wOd0obYm3s81EJYDZULQSEASgZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRIpo8crvvQXfHHcaANH/PuWNX0zFx5kq/8GvEnALbP+1iOxq
	HshT9NyILbG+sjll4yvniVDMEUSoPEZdRc8hR24uxmgIjscCtHhI
X-Gm-Gg: ASbGncuz4G/yWoZyMOCQNkXT023UVc9PSUpKnsJ/ZVF4AsPeVMhFcgvwsmvOoiHw7ku
	yLuneotzcFFWhDJ3h2tJM2DDDBBkz3W1s6KDOj+ftLLkLyIrbrzt3FmEbPLXXbfcJLfl7nX5iZL
	iPxxfOISqSpeHOB4d3j0diB/Thqd3cUeW/GPxlM34zcjfonHPklAsMvzvDVhModdhnD7qW0GnUL
	G5htUkT9QwWPQzXLmjo7WczGvCNpB+5C46EnDm/EOkSdQ6F6ZDBR7+5GrTC56f+7mCes0+HRCRW
	MBzS56dRovhfv+hjFRsCpIM7kGqB9/vXaCv8FMIyhzHRq2wqAJfjBDgsa9tN5CE=
X-Google-Smtp-Source: AGHT+IGlL+YghWpDSy55bM7mKBBhuMhcx93hFPqYxugKAItAMEN2nNwvioSinHlNr8afswe7ptoglg==
X-Received: by 2002:a05:6102:5343:b0:4b2:5d3e:7554 with SMTP id ada2fe7eead31-4ba47ae1626mr3502635137.23.1738790707954;
        Wed, 05 Feb 2025 13:25:07 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941da3fdsm2456083241.25.2025.02.05.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:25:07 -0800 (PST)
Date: Wed, 05 Feb 2025 16:25:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a3d732aeff0_170d392942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoA26mQQf-_0Ebi2qqd=qVn1soUoma-3o8NdUFGZL_-L2g@mail.gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-2-kerneljasonxing@gmail.com>
 <67a3821d3ae5b_14e0832944c@willemb.c.googlers.com.notmuch>
 <CAL+tcoA26mQQf-_0Ebi2qqd=qVn1soUoma-3o8NdUFGZL_-L2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 01/12] bpf: add support for bpf_setsockopt()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Feb 5, 2025 at 11:22=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Users can write the following code to enable the bpf extension:
> > > int flags =3D SK_BPF_CB_TX_TIMESTAMPING;
> > > int opts =3D SK_BPF_CB_FLAGS;
> > > bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  include/net/sock.h             |  3 +++
> > >  include/uapi/linux/bpf.h       |  8 ++++++++
> > >  net/core/filter.c              | 23 +++++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h |  1 +
> > >  4 files changed, 35 insertions(+)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 8036b3b79cd8..7916982343c6 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -303,6 +303,7 @@ struct sk_filter;
> > >    *  @sk_stamp: time stamp of last packet received
> > >    *  @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architec=
tures only
> > >    *  @sk_tsflags: SO_TIMESTAMPING flags
> > > +  *  @sk_bpf_cb_flags: used in bpf_setsockopt()
> > >    *  @sk_use_task_frag: allow sk_page_frag() to use current->task_=
frag.
> > >    *                     Sockets that can be used under memory recl=
aim should
> > >    *                     set this to false.
> > > @@ -445,6 +446,8 @@ struct sock {
> > >       u32                     sk_reserved_mem;
> > >       int                     sk_forward_alloc;
> > >       u32                     sk_tsflags;
> > > +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FL=
AG))
> > > +     u32                     sk_bpf_cb_flags;
> > >       __cacheline_group_end(sock_write_rxtx);
> > >
> > >       __cacheline_group_begin(sock_write_tx);
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 2acf9b336371..6116eb3d1515 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6913,6 +6913,13 @@ enum {
> > >       BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > >  };
> > >
> > > +/* Definitions for bpf_sk_cb_flags */
> > > +enum {
> > > +     SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> > > +     SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPIN=
G - 1) |
> > > +                                        SK_BPF_CB_TX_TIMESTAMPING
> > > +};
> > > +
> > >  /* List of known BPF sock_ops operators.
> > >   * New entries can only be added at the end
> > >   */
> > > @@ -7091,6 +7098,7 @@ enum {
> > >       TCP_BPF_SYN_IP          =3D 1006, /* Copy the IP[46] and TCP =
header */
> > >       TCP_BPF_SYN_MAC         =3D 1007, /* Copy the MAC, IP[46], an=
d TCP header */
> > >       TCP_BPF_SOCK_OPS_CB_FLAGS =3D 1008, /* Get or Set TCP sock op=
s flags */
> > > +     SK_BPF_CB_FLAGS         =3D 1009, /* Used to set socket bpf f=
lags */
> > >  };
> > >
> > >  enum {
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 2ec162dd83c4..1c6c07507a78 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -5222,6 +5222,25 @@ static const struct bpf_func_proto bpf_get_s=
ocket_uid_proto =3D {
> > >       .arg1_type      =3D ARG_PTR_TO_CTX,
> > >  };
> > >
> > > +static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, =
bool getopt)
> > > +{
> > > +     u32 sk_bpf_cb_flags;
> > > +
> > > +     if (getopt) {
> > > +             *(u32 *)optval =3D sk->sk_bpf_cb_flags;
> > > +             return 0;
> > > +     }
> > > +
> > > +     sk_bpf_cb_flags =3D *(u32 *)optval;
> > > +
> > > +     if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
> > > +             return -EINVAL;
> > > +
> > > +     sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
> >
> > I don't know BPF internals that well:
> >
> > Is there mutual exclusion between these sol_socket_sockopt calls?
> > Or do these sk field accesses need WRITE_ONCE/READ_ONCE.
> =

> According to the existing callbacks (like
> BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB which I used in the selftests) in
> include/uapi/linux/bpf.h, they are under the socket lock protection.
> And the correct use of this feature is to set during the 3-way
> handshake that also is protected by lock. But after you remind me of
> this potential data race issue, just in case bpf program doesn't use
> it as we expect, I think I will add the this annotation in v9.

Let's not add instrumentation defensively where not needed. Doing so
confuses future readers who will assume that it was needed and cannot
see why.

Either leave it for now. Or if it is needed for lockless UDP, add it
now, but then add an explicit comment that it is for that use case.



