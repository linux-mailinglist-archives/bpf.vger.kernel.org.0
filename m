Return-Path: <bpf+bounces-43479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AFC9B597F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635A71F2423B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C2195980;
	Wed, 30 Oct 2024 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqDbNfio"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94413212B;
	Wed, 30 Oct 2024 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252730; cv=none; b=G98mp5d0fKHdfSoXkG1tGTIhI/YfxTFTeZzk8fhGxRcEa2KfGXNy1B3GBOjtnOBt165lp4OS3eJ7tg+iBPM0Ufc7d9XglPDZOc5hW3rMm2eBOnHIN7p3UbB4e0RewXt5nm8LoQxSfKX5oExUxAbDroD+y1aw7WLcAw8Pp+RVxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252730; c=relaxed/simple;
	bh=x46WHpDScW0ML4P/l0UvZJFZ47mzk4C6K1yNN0eMXwc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uJ9qfjl48DGsyKyCF/DyRwvIjbYZcOjWn7DdrtqURa+rSxDcU9i5rh+oeQCVteEZkOHkykvRBFEaNjldtrxOY35cmp3XbkCrzQjDWDxWC5sRUdHoelGiw5Q4FhwcGw22fp3/5vK4woPNTvmxbuMfcU5QWJXB7yWchaeKtK0F2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqDbNfio; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4608e389407so75516961cf.2;
        Tue, 29 Oct 2024 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252727; x=1730857527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghg+F042C7JerUA/5ugpCpRK2H0z6SthoJKk5EHuKsk=;
        b=OqDbNfiocN2PTMQRFJCbnLyAeSwCx2Bek+MWo/ArlF8NaqEHVKPRBpyTSNWEssR6TA
         1KuoYAdC8A48NIh5O8GFHNelK47RWyOnrBfU0KJI3FD0WTiTKg5FiY/pSqLvrRQTVutP
         bxkE/4X/9rXpGOe8vXfsj/W8Nat/36UyINklazTwCvjoMCE665LbOfkgxUk4+6tuYv3X
         EFy5J/zjAuFAP4BRZIjeIMeMqNJpkXZWz0rvW6+2jBXKDihcZ3qDLhVapzfDAaCvMEGr
         RGyy1Kc9G7gKd/Mni1qa6R3CEW98T4Gn0V/cEhoZYZ3ZuoZ7Uk01Uv7va+KXK4HotbYn
         uXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252727; x=1730857527;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ghg+F042C7JerUA/5ugpCpRK2H0z6SthoJKk5EHuKsk=;
        b=sx2nEEts5NAlkY/jiPS5vQMRJ6NezXae/3zJw9OrVqN1OiFyqshtDRbJyVRTYZJNAb
         T7+f/ALRRbxi2vLVJZr5NoXIHbXPf3Vz7ZUTvt7IyYMYqczGavDMCQooC4xm0Q6fjlkw
         /WhbKaIpJB+iquwfdhw2cQXzNpuUVWq68TJANeHMJnf1poPRbkBQR3s+8rhFlK8kcx17
         eOnn4bDPGn68YZ9xMz8V8Gtg40eduo65gTZCbFzkDjGmPY25LxBolCIEo/xNirhauwHW
         zk0HbMKuIPGozlPFZkipDfcsnNjcmbW/30VRvbd5k9qslrdf/aQbq1kP0e2aa5tz73Xe
         IKQg==
X-Forwarded-Encrypted: i=1; AJvYcCVvJDfkkxZtI0UN7Etp+vZMbtMrpweLc48n8+HZsfL2v7mTm3yZN022+DIV3NhUzR8YPvkIH5i5@vger.kernel.org, AJvYcCXMaznfr+jFkfYUiMeIxAY610/A3TpVzZXb26JFwVD+mQfnmS0gXGIBgs1uZjxQC0TONDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywga3ybMQ3IXQoROQaRsGlWwfnrHiBFAFE+gkk8NdcMiJAAUZN2
	z8PMa/GRhxS8Dh/LuHsq/3oikiiADj/1I0gl/o7f6CfAXLf+edau
X-Google-Smtp-Source: AGHT+IFkIblPa6vVZdgz0ioWmOUsPeStRsX4U4lTdkI0cyCYMtqiPaIBatlCeg1s5u6bGS97pzGiOg==
X-Received: by 2002:a05:620a:2488:b0:7b1:5311:468a with SMTP id af79cd13be357-7b193eeae7bmr1875257385a.19.1730252727304;
        Tue, 29 Oct 2024 18:45:27 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d343d62sm471937385a.101.2024.10.29.18.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:45:26 -0700 (PDT)
Date: Tue, 29 Oct 2024 21:45:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
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
Message-ID: <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
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
> On Wed, Oct 30, 2024 at 7:00=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 10/28/24 4:05 AM, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch has introduced a separate sk_tsflags_bpf for bpf
> > > extension, which helps us let two feature work nearly at the
> > > same time.
> > >
> > > Each feature will finally take effect on skb_shinfo(skb)->tx_flags,=

> > > say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> > > other types, so in __skb_tstamp_tx() we are unable to know which
> > > feature is turned on, unless we check each feature's own socket
> > > flag field.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >   include/net/sock.h |  1 +
> > >   net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 40 insertions(+)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 7464e9f9f47c..5384f1e49f5c 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -445,6 +445,7 @@ struct sock {
> > >       u32                     sk_reserved_mem;
> > >       int                     sk_forward_alloc;
> > >       u32                     sk_tsflags;
> > > +     u32                     sk_tsflags_bpf;
> > >       __cacheline_group_end(sock_write_rxtx);
> > >
> > >       __cacheline_group_begin(sock_write_tx);
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 1cf8416f4123..39309f75e105 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk_buf=
f *skb,
> > >   }
> > >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > >
> > > +/* This function is used to test if application SO_TIMESTAMPING fe=
ature
> > > + * or bpf SO_TIMESTAMPING feature is loaded by checking its own so=
cket flags.
> > > + */
> > > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int t=
stype)
> > > +{
> > > +     u32 testflag;
> > > +
> > > +     switch (tstype) {
> > > +     case SCM_TSTAMP_SCHED:
> > > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > > +             break;
> > > +     case SCM_TSTAMP_SND:
> > > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > > +             break;
> > > +     case SCM_TSTAMP_ACK:
> > > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > > +             break;
> > > +     default:
> > > +             return false;
> > > +     }
> > > +     if (tsflags & testflag)
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > >                                const struct sk_buff *ack_skb,
> > >                                struct skb_shared_hwtstamps *hwtstam=
ps,
> > > @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_bu=
ff *orig_skb,
> > >       u32 tsflags;
> > >
> > >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> >
> > I still don't get this part since v2. How does it work with cmsg only=

> > SOF_TIMESTAMPING_TX_*?
> >
> > I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not ret=
urn any tx
> > time stamp after this patch.
> >
> > I am likely missing something
> > or v2 concluded that this behavior change is acceptable?
> =

> Sorry, I submitted this series accidentally removing one important
> thing which is similar to what Vadim Fedorenko mentioned in the v1
> [1]:
> adding another member like sk_flags_bpf to handle the cmsg case.
> =

> Willem, would it be acceptable to add another field in struct sock to
> help us recognise the case where BPF and cmsg works parallelly?
> =

> [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3b2@l=
inux.dev/

The current timestamp flags don't need a u32. Maybe just reserve a bit
for this purpose?

