Return-Path: <bpf+bounces-43486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C50689B5A1A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407CEB21FFA
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC319342E;
	Wed, 30 Oct 2024 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzO8hRWE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAA4437;
	Wed, 30 Oct 2024 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256474; cv=none; b=c0RHjjKLhZ1W49JUg6qN+LPPJGyMt7XcPmLC/6JCHVXqTgU+zvmkwBGIevsuxurLwpW+MBwmvqC4R2nLSvinzOJpOPF5XFxmYCV7M13XT/bUayZJWRohIGkvPTIVnWnhqMOBKmaxeDck/zijsRtLKMubZCxKtM5pb4qNQsQfVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256474; c=relaxed/simple;
	bh=nyIOhsfaICKWmWJRau5S7I0SF8GaWVKHj/aHrCqDUwA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SsUuiYNPrFj9FcKudNZIJo+Oii6BNWdiC7RqC3edK5HPGr8IguGuv1l2+Zh6xhdFt6fQpKF9FDqWrBAIPXVahy06qrn2oUvpcYQAKYt27t6D2sl5iMj5hmtiLB/QRXgBJn7dKR+SUSIzUGq3jkeKzgvSpMBqruSGLL1TQbX+Vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzO8hRWE; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d3d4d2ad2so2279701e0c.0;
        Tue, 29 Oct 2024 19:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730256470; x=1730861270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1UN891Kf/HaZS1fhZFQz7DGwNs+2b4tJPGvOXdNuik=;
        b=VzO8hRWE7EHh2dIdsc+tq72/nV7JjC8CAWFqo5RQvxgIEtQin8ubn6DHzhEyZfu7Cx
         aXdi3X3f8mFQqAmwRvodXxXf6uZVWV7VoOYc6nIxgpCfwycKGJMiK6IlbFrEqUqRNgrV
         cXjFKn3YlE4PycV5ar0OQ+h9kkOZ5FbYxppBTMZwlcFk1g+7Y2lqhirKhIxU5qa9G2mY
         oKsT8uB3GEHNDMCmGb8pilT1H/70gYlekBDfjD7G8TUG9Oy4znXZu5IDlRgKZqexyuPv
         FYJ/8JbkVhv7ExrpEaYphgFlqKmCXSlnur23vy2QHJjNRU1MNqs5tLiDRIMWhR+ErabX
         2kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730256470; x=1730861270;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1UN891Kf/HaZS1fhZFQz7DGwNs+2b4tJPGvOXdNuik=;
        b=kiu4b16OrS3phuaqbRDU56t5+3Z/yW+6INHTYgw5NNjE8QjZ6gl5Nr8HXDzv5emlQX
         t4GDPGF18yiwL0N9w1Y/s3EelBvxv1xpNYerQZpAp2nPKVZSerYU5yInMJuCXsh4Gkt6
         BkSPhIZgNKEGIww0wEDunfaM9I1YNOnJAiIcmUa9HTBiAd206k7aknLhyg9wtpZm8pBe
         De8sJr8MEevtfojYrnHOQu871YyxEQtxvYr67nVuJnQXozeJnqLMMHCeihYieNe5VfFy
         aHw+ov4YWc/lTwiyQn65teOZ+t27lcoW3mQZvqxhA3Dd0KR1TPfaF3CNE1rzmooJ/xpC
         rj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQIXELxtQZUv2M/Qm4oZa0jCZA4H4XTuMZ6uL1sPQ1fZv4dolFDeAAsGCHXv7VYApJyNU1dKvO@vger.kernel.org, AJvYcCX4ttY3dDpK98cEqrJzGvCt3333uO1emsCILZK3KPhX2DWqFiPDRSdnjR9UBvdPfAhbJvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBc6xPdHPCf7ocnJpQ1wYrA6X9993apppOoRBdws75KKr2hMyZ
	DFhhpB1Uy4U9Ot3QIG2m4XiQ49vN+eS/XwITa1KS12pZngH4z0Ku
X-Google-Smtp-Source: AGHT+IH1nRhDCjQo6kjXDWimEADEqf7n224h6Gig5d9eRrIb0jZY2S2gq/h9EWppxQciFDB8gyVZFg==
X-Received: by 2002:a05:6122:1687:b0:50a:b728:5199 with SMTP id 71dfb90a1353d-510150684f8mr11756709e0c.7.1730256470388;
        Tue, 29 Oct 2024 19:47:50 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991c54esm47477596d6.68.2024.10.29.19.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 19:47:49 -0700 (PDT)
Date: Tue, 29 Oct 2024 22:47:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
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
> On Wed, Oct 30, 2024 at 9:45=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Wed, Oct 30, 2024 at 7:00=E2=80=AFAM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > >
> > > > On 10/28/24 4:05 AM, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > This patch has introduced a separate sk_tsflags_bpf for bpf
> > > > > extension, which helps us let two feature work nearly at the
> > > > > same time.
> > > > >
> > > > > Each feature will finally take effect on skb_shinfo(skb)->tx_fl=
ags,
> > > > > say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for=

> > > > > other types, so in __skb_tstamp_tx() we are unable to know whic=
h
> > > > > feature is turned on, unless we check each feature's own socket=

> > > > > flag field.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >   include/net/sock.h |  1 +
> > > > >   net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++=
++
> > > > >   2 files changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > index 7464e9f9f47c..5384f1e49f5c 100644
> > > > > --- a/include/net/sock.h
> > > > > +++ b/include/net/sock.h
> > > > > @@ -445,6 +445,7 @@ struct sock {
> > > > >       u32                     sk_reserved_mem;
> > > > >       int                     sk_forward_alloc;
> > > > >       u32                     sk_tsflags;
> > > > > +     u32                     sk_tsflags_bpf;
> > > > >       __cacheline_group_end(sock_write_rxtx);
> > > > >
> > > > >       __cacheline_group_begin(sock_write_tx);
> > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > index 1cf8416f4123..39309f75e105 100644
> > > > > --- a/net/core/skbuff.c
> > > > > +++ b/net/core/skbuff.c
> > > > > @@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk=
_buff *skb,
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > > > >
> > > > > +/* This function is used to test if application SO_TIMESTAMPIN=
G feature
> > > > > + * or bpf SO_TIMESTAMPING feature is loaded by checking its ow=
n socket flags.
> > > > > + */
> > > > > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, i=
nt tstype)
> > > > > +{
> > > > > +     u32 testflag;
> > > > > +
> > > > > +     switch (tstype) {
> > > > > +     case SCM_TSTAMP_SCHED:
> > > > > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > > > > +             break;
> > > > > +     case SCM_TSTAMP_SND:
> > > > > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > > > > +             break;
> > > > > +     case SCM_TSTAMP_ACK:
> > > > > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > > > > +             break;
> > > > > +     default:
> > > > > +             return false;
> > > > > +     }
> > > > > +     if (tsflags & testflag)
> > > > > +             return true;
> > > > > +
> > > > > +     return false;
> > > > > +}
> > > > > +
> > > > >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > > > >                                const struct sk_buff *ack_skb,
> > > > >                                struct skb_shared_hwtstamps *hwt=
stamps,
> > > > > @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct s=
k_buff *orig_skb,
> > > > >       u32 tsflags;
> > > > >
> > > > >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> > > >
> > > > I still don't get this part since v2. How does it work with cmsg =
only
> > > > SOF_TIMESTAMPING_TX_*?
> > > >
> > > > I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not=
 return any tx
> > > > time stamp after this patch.
> > > >
> > > > I am likely missing something
> > > > or v2 concluded that this behavior change is acceptable?
> > >
> > > Sorry, I submitted this series accidentally removing one important
> > > thing which is similar to what Vadim Fedorenko mentioned in the v1
> > > [1]:
> > > adding another member like sk_flags_bpf to handle the cmsg case.
> > >
> > > Willem, would it be acceptable to add another field in struct sock =
to
> > > help us recognise the case where BPF and cmsg works parallelly?
> > >
> > > [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3=
b2@linux.dev/
> >
> > The current timestamp flags don't need a u32. Maybe just reserve a bi=
t
> > for this purpose?
> =

> Sure. Good suggestion.
> =

> But I think only using one bit to reflect whether the sk->sk_tsflags
> is used by normal or cmsg features is not enough. The existing
> implementation in tcp_sendmsg_locked() doesn't override the
> sk->sk_tsflags even the normal and cmsg features enabled parallelly.
> It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on
> that, even if at some point users suddenly remove the cmsg use and
> then the prior normal SO_TIMESTAMPING continues to work.
> =

> How about this, please see below:
> For now, sk->sk_tsflags only uses 17 bits (see the last one
> SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 flags
> (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With that
> said, we could reserve the highest four bits for cmsg use for the
> moment. Four bits represents four points where we can record the
> timestamp in the tx case.
> =

> Do you agree on this point?

I don't follow.

I probably miss the entire point.

The goal for sockcm fields is to start with the sk field and
optionally override based on cmsg. This is what sockcm_init does for
tsflags.

This information is for the skb, so these are recording flags.

Why does the new datapath need to know whether features are enabled
through setsockopt or on a per-call basis with a cmsg?

The goal was always to keep the reporting flags per socket, but make
the recording flag per packet, mainly for sampling.=

