Return-Path: <bpf+bounces-52085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D3A3DEAC
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 16:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C3B3BFB9F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B71FDE26;
	Thu, 20 Feb 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch/A8Xo9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673B1FDA99;
	Thu, 20 Feb 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065301; cv=none; b=pTHh0aIS4LxFcitPu4t1yoc+NQHffeqUaQ4CWJo6suacafaM4TlNNtH+dawIjwaVumJh7vj15ai/hg9QRqCV/TK+JPSDnWzUFxBpmcqHjplH73Ni0hWI4oMtBjFHwJiZWYNhOH1QPvVCOULNnKR6sbMuF2h+g/PS+k58g+mbGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065301; c=relaxed/simple;
	bh=m8P0DDPnu4xowaTy2JsZyxocXCStvObe3mZQnDQNjow=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r/pFtTnqTF9/FD6rsQtH2+wbVOgFwzFeXc1i+D4F/sZmuoKtQiOeH5akxwAYCUq0zDbINWKIRllVoTtozIqyJvPtonTVQTNNcN7fcBV50nvRR/pXzI+MpG5vZugzGG3I+Euo38e0rcMEtxOoIgh4LJQj1qDYyOkIw6VJYvhtx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch/A8Xo9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2bcf9d9b60aso210184fac.3;
        Thu, 20 Feb 2025 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740065299; x=1740670099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVNjrtmuzgt838gVAsclLbdBwF4FLM0Hegt+RdAZTeg=;
        b=ch/A8Xo9erly/FE6xQ2ZWZDVOZr3dNfyDirmI+6SbzHMbI8gYUs28ZWxHbqRaYJDju
         jfyYQiWlnZ8jRxl0kLaMHCq+FtTkBgrG1tWZOtKc87vlOcr17hj2xXM9E/F87ZOjUsXN
         4Iw3ZBJ36xs5sLCCqMO7Xq06oA634V4beFus3myJYQg7iFoEyunEw77BcYLaf83vPKFA
         GLFy5FxL3RhVgCzPO6KKsDP2MWTofem3eOOvpKDihLSGf88KZwzXi1yD3NmRCHNrR97c
         TBNCz6z9PYHXJS9vTLUGFn+S637nOyWsArPCPL8+JrWWrXtjPNpHCUkewASbIXE8A2Vq
         G0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065299; x=1740670099;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TVNjrtmuzgt838gVAsclLbdBwF4FLM0Hegt+RdAZTeg=;
        b=fQlzIGX4gRedniX0qohLhnk6xtF9QkNu76jSo73aifAlAetW+WnLAMplwonTNnyJE/
         /ltlI6RGx8BQSxM8BcyGim8gK6Le4hGmgJkLL0VT++GHl2hd4Pq1hmc5/j/cra4+XpnT
         WI/M7BMZBEOJ/p9z2Nxz4fMxb0//hdykKiLEvUhS/VkViWuDj2R5CQNfDqBTzCmCOtlb
         2urqX4YuGBGpa4QxtU6/WkFRl9aOCumkDzIHbGeLRM2ryMLDoGzxLt3seLpBTkujsZ1O
         V/q6YzMw55ik1ayY8KqohAtH6dBPZ4uAjp9NPKGu/jy6pA32FrZ/rDxn1az3ay35SN6r
         +91g==
X-Forwarded-Encrypted: i=1; AJvYcCUM+Ygpu/UO4raJrhGyBdjY1+tD6lXx8WoxCTJD4/gzL+yYtc4VkyNw1nNgP75Eaacy7daxgx8u@vger.kernel.org, AJvYcCVfwmgH15zYmhm0ly30wmuRGBOaWb5yyoMqZYZ2VLUsJD4taXaITVuZGZPrMvgWToX0BZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAK+d+X3cLJYgI3oDMA62MpKeDqwAfgOQ16RiNBx6/NDIgaGdw
	ig6asSMiHa+RpVI5hzvo0g+BPQ5Qh0iBvh43FJFxv99TTSDOyd/Z
X-Gm-Gg: ASbGncvIpTW1hepoEkyfTzhodkS5iv62I8BySW+phjpqgoQ0j6sEoGm4fJViiVD/mzy
	lJEnkWEKO6QtPRQ3flR596GhkrApRF6wUN1avvEI7XIRMI0vbCQxzHcAbDR1mEH2+YghcUR3Uuf
	xbbcuf6ARSo5IILSXrLzf9XqM0m2+IiWtGyDhD0N6wdQ2mUQ8NTlyBGQG57cYqj3tK9G23p+juT
	nllyVTBfmmHLOqJGCOucJHz6lJfg1oWzaqh2VU72LNPkNL3mqX6ymimC8CkRNqEgqLZEZSJohvq
	5mtx4Rr+mWQ1Y/J5TWREUVvwLHsnoJTzL/88NP70Xw7cMXX4eoSYRqvcX+Tnuqo=
X-Google-Smtp-Source: AGHT+IEhD99iOe15C6tDD5uZ1n1A4FwUKSa1usOwdlvcKqq+RolaccX8ax4v5qg2lb8YkUoMUhG77Q==
X-Received: by 2002:a05:6871:5cc:b0:296:df26:8a6e with SMTP id 586e51a60fabf-2bc99dcf766mr15914044fac.35.1740065298976;
        Thu, 20 Feb 2025 07:28:18 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2bc69a3af4fsm5927401fac.19.2025.02.20.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:28:18 -0800 (PST)
Date: Thu, 20 Feb 2025 10:28:17 -0500
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
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b74a11377c2_261ab6294de@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCpGowFrRrTFSXXWL6OirR6TmCYm6Eu=b9ZyRNqrVfgpQ@mail.gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-11-kerneljasonxing@gmail.com>
 <67b699ab81a9_20efb029441@willemb.c.googlers.com.notmuch>
 <CAL+tcoDqqt3QScTHAjWGownjc8-gcMCGq=rYqB9eu=rCwoCLiQ@mail.gmail.com>
 <CAL+tcoCpGowFrRrTFSXXWL6OirR6TmCYm6Eu=b9ZyRNqrVfgpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB
 callback
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
> On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 10:55=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > This patch introduces a new callback in tcp_tx_timestamp() to cor=
relate
> > > > tcp_sendmsg timestamp with timestamps from other tx timestamping
> > > > callbacks (e.g., SND/SW/ACK).
> > > >
> > > > Without this patch, BPF program wouldn't know which timestamps be=
long
> > > > to which flow because of no socket lock protection. This new call=
back
> > > > is inserted in tcp_tx_timestamp() to address this issue because
> > > > tcp_tx_timestamp() still owns the same socket lock with
> > > > tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initiali=
zes
> > > > the timestamping related fields for the skb, especially tskey. Th=
e
> > > > tskey is the bridge to do the correlation.
> > > >
> > > > For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() =
and
> > > > then stores the sendmsg timestamp at the bpf_sk_storage, correlat=
ing
> > > > this timestamp with its tskey that are later used in other sendin=
g
> > > > timestamping callbacks.
> > > >
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       | 5 +++++
> > > >  net/ipv4/tcp.c                 | 4 ++++
> > > >  tools/include/uapi/linux/bpf.h | 5 +++++
> > > >  3 files changed, 14 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 9355d617767f..86fca729fbd8 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -7052,6 +7052,11 @@ enum {
> > > >                                        * when SK_BPF_CB_TX_TIMEST=
AMPING
> > > >                                        * feature is on.
> > > >                                        */
> > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendms=
g syscall
> > > > +                                      * is triggered. It's used =
to correlate
> > > > +                                      * sendmsg timestamp with c=
orresponding
> > > > +                                      * tskey.
> > > > +                                      */
> > > >  };
> > > >
> > > >  /* List of TCP states. There is a build check in net/ipv4/tcp.c =
to detect
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 12b9c4f9c151..4b9739cd3bc5 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk=
, struct sockcm_cookie *sockc)
> > > >               if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> > > >                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + sk=
b->len - 1;
> > > >       }
> > > > +
> > > > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > > > +         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && s=
kb)
> > > > +             bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_=
SND_CB);
> > > >  }
> > > >
> > > >  static bool tcp_stream_is_readable(struct sock *sk, int target)
> > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/=
linux/bpf.h
> > > > index d3e2988b3b4c..2739ee0154a0 100644
> > > > --- a/tools/include/uapi/linux/bpf.h
> > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > @@ -7042,6 +7042,11 @@ enum {
> > > >                                        * when SK_BPF_CB_TX_TIMEST=
AMPING
> > > >                                        * feature is on.
> > > >                                        */
> > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendms=
g syscall
> > > > +                                      * is triggered. It's used =
to correlate
> > > > +                                      * sendmsg timestamp with c=
orresponding
> > > > +                                      * tskey.
> > > > +                                      */
> > >
> > > Feel free to decline this late in the review process, but a bit mor=
e
> > > bikeshedding..
> > >
> > > Can we spell out TSTAMP instead of TS in these definitions? Within
> > > the context of this series it is self-explanatory, but when reading=

> > > kernel code the meaning of a two letter acronym is not that clear.
> >
> > Even though I feel reluctant to change across the whole series becaus=
e
> > if so, I will adjust in many places. Of course, you're right about th=
e
> > new name being clearer :)
> >
> > >
> > > And instead of SND can we use SENDMSG or something like that?
> > > SND here confused me as the software timestamp is SCM_TSTAMP_SND.
> >
> > I'm not sure about this. For TCP, it's not implemented in the
> > tcp_sendmsg_locked but tcp_tx_timestamp. Well, I have no strong
> > preference.
> >
> > You can make the final call :)
> =

> After taking a break, I feel full of energy and I will update them all
> as you requested :)

Awesome, thank you.

