Return-Path: <bpf+bounces-43356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10469B3FB2
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB92282D35
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866DD44C94;
	Tue, 29 Oct 2024 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP/418xc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6417C79;
	Tue, 29 Oct 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165039; cv=none; b=OQSbb3ouoGctH//u80l8s53VFKviwmpcrNN1Rjfm0VMUZls5bq3VVE12j4BO5SaO+SFiC9b8A/E6HvlJimxpGhiOulOo5bydrxKctJo5FEa3kcNX7GP+owY4dC5G3vTToEqXOBkZ7RxB2O1p1x5MK8jBw3DrCZ98Zn5wg+gIvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165039; c=relaxed/simple;
	bh=bLvLTxYjNxL0JWBzGQRuC+crw5tkr+VGM2IySfcDaUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLu65IQnWuCw22D5pMEE1fhhUqsFb8gVP2s+AmuK5u1ppe+piCVJQ1g6xUBf0dDAIKTEhjNX0RyhxNW3pHn5ThD6EYGC4M8GEJvS2J1bk84ra/v6zC6jZACv9MIHu/PXPodKKugFJl98S/ASVf8o1H3lNFAcq6vmB5+bMSiRbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP/418xc; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83b2a41b81cso78387539f.0;
        Mon, 28 Oct 2024 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165036; x=1730769836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5QVvqdSrkStsRDPMj7gokyAJVfr4C8jvJrnGyjH5o0=;
        b=VP/418xcIbHCx9h5HgR6Ybcz27eVeOU96zkeF2s0LaP7tzzy844a4/hJusN0l33uB9
         B92EvYinZRiQqovrTS4wwEr6B+eyX1m/cLaNAytSbd8S1Z/hUx3nHAsPzpvLTukMSGvF
         B5yRu9g4nZrrA5LitweZJcccMgMyOisqNO1h9n24VoqJOSNfKPFJTGuo+CNjt58bqn3l
         BW9/bPz8co/VtbZVsJ/D+YD5rDNgHgMRvsWr9WUSMxJ2JzprPauK/UPNdThlgPvipIUu
         Bhadlj2SBu4BQG7wWt02Yg36WnlA3MBzTJlcy/wgqaO3v2WjIxBm1jUlVWwTHnGOUMyH
         LMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165036; x=1730769836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5QVvqdSrkStsRDPMj7gokyAJVfr4C8jvJrnGyjH5o0=;
        b=w2A3BDPTpaa4UMc6/Z9Fs7wMaq9Z6O+4pzit1+wkMIifnXonuRIYtvkafUGZiU0pzP
         laQ4um/7MNUrYh/bciyAfNRhp2h7UmDHEhUiirGnAViKv5tPu9rF8qAd0CSkvnXWvNVt
         yZYPzG2JBTDjyd1MeWsDzCbUVJ1Gpah1Hop9R5CEeH4++xzT4JB9lP3On2O7g1ylxk5X
         aXZAKI01/7dx0y0mZ8nPJ/D10WiXLI/7wTqZqYgv+N+4/DsIIzgPbKPdchNTUQqALQMB
         eRUZNPNyF4Dz8CMDSzOZQmhqVJilN5CV+Em9zT8PDu4j6DMF7htB0IkYVKWXckdcjWpx
         UgAg==
X-Forwarded-Encrypted: i=1; AJvYcCVI7KTjQCWVFAFwXOz4uFyeTLStaNTdvrjfobqC/LXndhu4D/WKxhFmJlx1+BwnYNMV75E=@vger.kernel.org, AJvYcCW+x0oPALXU9VaJT9kyMxYEibG8fvWE3eEvH+MA3eIGPyl2DpS33ke67SbzBgUmzi9uNzgmFPFw@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgoDkn0K5kUs8Z2YtUhPiHxON4gh7KoBcRuYPZX+ulGAhpxxO
	roI7uQN8pJmPiOxViVxfBq86D9ir9IJ3rn07u9CUDHkF1lnFghdyOTGQRLoD5b1CxcW3AlmSzgs
	Pl+/RR6W2Al1+F6jji3R3hsTTYtA=
X-Google-Smtp-Source: AGHT+IH6JkMeKApQCVDMUPnin1XbpszzEbshVH+z9CmyYVcQwLFbWme50QTuCtIuBjNCVC4JWur5aJ6YaxyLA6PpQ4Y=
X-Received: by 2002:a05:6e02:180e:b0:3a4:ecdb:d61d with SMTP id
 e9e14a558f8ab-3a4ed298ff0mr78950025ab.8.1730165035961; Mon, 28 Oct 2024
 18:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-8-kerneljasonxing@gmail.com> <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
In-Reply-To: <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 09:23:20 +0800
Message-ID: <CAL+tcoCBxTUU9mPUTC=9LmGLsrUrjVDVk-982M-TjewSW-hjzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/14] net-timestamp: add a new triggered
 point to set sk_tsflags_bpf in UDP layer
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:07=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch behaves like how cmsg feature works, that is to say,
> > check and set on each call of udp_sendmsg before passing sk_tsflags_bpf
> > to cork tsflags.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/sock.h             | 1 +
> >  include/uapi/linux/bpf.h       | 3 +++
> >  net/core/skbuff.c              | 2 +-
> >  net/ipv4/udp.c                 | 1 +
> >  tools/include/uapi/linux/bpf.h | 3 +++
> >  5 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 062f405c744e..cf7fea456455 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(const struct=
 sock *sk)
> >  }
> >
> >  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
> > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)=
;
> >  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, i=
nt level,
> >                      int type);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6fc3bd12b650..055ffa7c965c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7028,6 +7028,9 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_sendmsg
> > +                                      * syscall is triggered
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 8b2a79c0fe1c..0b571306f7ea 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct sk_buff *=
orig_skb,
> >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> >  }
> >
> > -static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32=
 *args)
> > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
> >  {
> >       struct bpf_sock_ops_kern sock_ops;
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 9a20af41e272..e768421abc37 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *m=
sg, size_t len)
> >       if (!corkreq) {
> >               struct inet_cork cork;
> >
> > +             timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0, NUL=
L);
> >               skb =3D ip_make_skb(sk, fl4, getfrag, msg, ulen,
> >                                 sizeof(struct udphdr), &ipc, &rt,
> >                                 &cork, msg->msg_flags);
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 6fc3bd12b650..055ffa7c965c 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7028,6 +7028,9 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_sendmsg
> > +                                      * syscall is triggered
> > +                                      */
>
> If adding a timestamp as close to syscall entry as possible, give it a
> generic name, not specific to UDP.

Good suggestion, then it will also solve the remaining issue for TCP type:
__when__ we should record the user timestamp which exists in the
application SO_TIMESTAMPING feature.

>
> And please explain in the commit message the reason for a new
> timestamp recording point: with existing timestamping the application
> can call clock_gettime before (and optionally after) the send call.
> An admin using BPF does not have this option, so needs this as part of
> the BPF timestamping API.

Will revise this part. Thanks for your description!

Thanks,
Jason

