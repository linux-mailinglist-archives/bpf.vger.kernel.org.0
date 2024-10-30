Return-Path: <bpf+bounces-43591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5659B6AD1
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6044A1C2192F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C422443E;
	Wed, 30 Oct 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8MITQj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504E224410;
	Wed, 30 Oct 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308549; cv=none; b=irxDdJP0MEZJNUwUcP6nWp8CTK1XWwOT9VIN6Jt0jH4uzAOBG790uDWledlRK6WkNEfJi5IWQphqlF1+V9yTJsX+xCQaWrfAemQBIH8c/O1P8iQWgunBD9OZv50teyDeqrqnY/KXfThq3h/lIKBnxBDkujZpzq7554jMSWGHTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308549; c=relaxed/simple;
	bh=TDr4UyjokH9I9u2XzFFGaVpYFY1sqVtRJAHCqAPdoN8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JQ4rasJwUPAH1w3WY8TUTtjYvY86OllHRalga1u25drl0iNx2fn7gog+2F6d/8QiskK3caH4MeweFZtroT8TH8o8nClNpoUw3SKyj+WlJy+VcPuVT1Uf9u6DaADccP3XuNU5AjnqDGrUScRu5U3ClTBzrFBy9+FvRReNePZZNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8MITQj7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609c96b2e5so906511cf.0;
        Wed, 30 Oct 2024 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308546; x=1730913346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3TG+CE7b4FbAX66rtHsqzEPwWBN15H3tVxe7XWl/o4=;
        b=T8MITQj7ZLVTOt3gV53FbuMsQaIQ/3n8iUtnbVDh5YV5cKUsXygUjIVU1ylTGMZEnJ
         Tknpl8rRjKWU7KXizxa2FEPjv+gEUUMm+NVBJ51kRwrrl/ddLiS7F5tSltxQjuM1F3hL
         7QX30CnS669OncP3JUZWzOzFK0OpNqWhNRPeLCa9guEQ5jgw9xDLfuK596ieoFjFMgGY
         JPLFesQp7flGlvH9JGIHGs+0MsPleNDFnTNTNzpyY62o7yM4k1g7UkZv7RSQ804YqCcg
         bNoCGrkSuzBT5JWb8Oqjk5b8THm3gLdrGnIbmD584ILoHwU5qNOWGrS2eak8DCAsd8Dd
         fTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308546; x=1730913346;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3TG+CE7b4FbAX66rtHsqzEPwWBN15H3tVxe7XWl/o4=;
        b=oo/Oi3WjF9tRjimCxN5x7k+yD9R0hPudJAhf/ULOR4pByac42sO/+LGDxz9zexlNeh
         zXsbivtzriJYKnfq6AshZ+m9gZecbXSx9yjhadDKKayMT1ok72jZx77bzp/keFYgVx6L
         afqFacADsMt0Fy+wrEEj61aKD1dA9/J23k9On4HrkxEZGLcb1Cauv5t3VjQDGH6sUONi
         M3WmQHwTegkJU86LjwobOAoxSo8s9EEF+sQ/4hNMJqC4xq8y1IqvhQwsktlbSytY1suL
         V/GbzToJY90M7y4JjNY1Wbxk3OaXqekxHn/u/Ilxe72A74PjqtBqmzRKY6Xj2rQAjewF
         xvvg==
X-Forwarded-Encrypted: i=1; AJvYcCV8s0WL+ajmrQ3ycqzzhjCQYizmlD9mTx6ypzXfpqwIYINPmyj4Qx8vaI1IzgxrKPo8yE+1khBq@vger.kernel.org, AJvYcCXXVbPfEtu4KxYiyVMVNddefFiE9avvs708noi8yzeK/xZFtY0AIKJdD1AaxkzqLZlZ++0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvpolN001ALjdqRlldABn/IQXjWwfPBsnjrLO3p1y/ltXinWO
	xdDklUtbd6KDNp3bZn9S0P+DkyLv1uMJ4R129Zxf3FMptIMQEaCb
X-Google-Smtp-Source: AGHT+IEsl9jyrLX1CtEzERMX/3Z4GzRYax1i6gl8cY9B6ymzgBmsTdFEH0UqfAGeP79gqqct5tsCTg==
X-Received: by 2002:a05:6214:4b02:b0:6cb:afe7:1403 with SMTP id 6a1803df08f44-6d185866d2fmr263375426d6.48.1730308545647;
        Wed, 30 Oct 2024 10:15:45 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2c7b2sm53541276d6.122.2024.10.30.10.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:15:44 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:15:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
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
> On Wed, Oct 30, 2024 at 1:37=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 10/29/24 8:04 PM, Jason Xing wrote:
> > >>>>>>>    static void skb_tstamp_tx_output(struct sk_buff *orig_skb,=

> > >>>>>>>                                 const struct sk_buff *ack_skb=
,
> > >>>>>>>                                 struct skb_shared_hwtstamps *=
hwtstamps,
> > >>>>>>> @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct=
 sk_buff *orig_skb,
> > >>>>>>>        u32 tsflags;
> > >>>>>>>
> > >>>>>>>        tsflags =3D READ_ONCE(sk->sk_tsflags);
> > >>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> > >>>>>>
> > >>>>>> I still don't get this part since v2. How does it work with cm=
sg only
> > >>>>>> SOF_TIMESTAMPING_TX_*?
> > >>>>>>
> > >>>>>> I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does =
not return any tx
> > >>>>>> time stamp after this patch.
> > >>>>>>
> > >>>>>> I am likely missing something
> > >>>>>> or v2 concluded that this behavior change is acceptable?
> > >>>>>
> > >>>>> Sorry, I submitted this series accidentally removing one import=
ant
> > >>>>> thing which is similar to what Vadim Fedorenko mentioned in the=
 v1
> > >>>>> [1]:
> > >>>>> adding another member like sk_flags_bpf to handle the cmsg case=
.
> > >>>>>
> > >>>>> Willem, would it be acceptable to add another field in struct s=
ock to
> > >>>>> help us recognise the case where BPF and cmsg works parallelly?=

> > >>>>>
> > >>>>> [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf013=
63c3b2@linux.dev/
> > >>>>
> > >>>> The current timestamp flags don't need a u32. Maybe just reserve=
 a bit
> > >>>> for this purpose?
> > >>>
> > >>> Sure. Good suggestion.
> > >>>
> > >>> But I think only using one bit to reflect whether the sk->sk_tsfl=
ags
> > >>> is used by normal or cmsg features is not enough. The existing
> > >>> implementation in tcp_sendmsg_locked() doesn't override the
> > >>> sk->sk_tsflags even the normal and cmsg features enabled parallel=
ly.
> > >>> It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on=

> > >>> that, even if at some point users suddenly remove the cmsg use an=
d
> > >>> then the prior normal SO_TIMESTAMPING continues to work.
> > >>>
> > >>> How about this, please see below:
> > >>> For now, sk->sk_tsflags only uses 17 bits (see the last one
> > >>> SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 fla=
gs
> > >>> (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With=
 that
> > >>> said, we could reserve the highest four bits for cmsg use for the=

> > >>> moment. Four bits represents four points where we can record the
> > >>> timestamp in the tx case.
> > >>>
> > >>> Do you agree on this point?
> > >>
> > >> I don't follow.
> > >>
> > >> I probably miss the entire point.
> > >>
> > >> The goal for sockcm fields is to start with the sk field and
> > >> optionally override based on cmsg. This is what sockcm_init does f=
or
> > >> tsflags.
> > >>
> > >> This information is for the skb, so these are recording flags.
> > >>
> > >> Why does the new datapath need to know whether features are enable=
d
> > >> through setsockopt or on a per-call basis with a cmsg?
> > >>
> > >> The goal was always to keep the reporting flags per socket, but ma=
ke
> > >> the recording flag per packet, mainly for sampling.
> > >
> > > If a user uses 1) cmsg feature, 2) bpf feature at the same time, we=

> > > allow each feature to work independently.
> > >
> > > How could it work? It relies on sk_tstamp_tx_flags() function in th=
e
> > > current patch: when we are in __skb_tstamp_tx(), we cannot know whi=
ch
> > > flags in each feature are set without fetching sk->sk_tsflags and
> > > sk->sk_tsflags_bpf. Then we are able to know what timestamp we want=
 to
> > > record. To put it in a simple way, we're not sure if the user wants=
 to
> > > see a SCHED timestamp by using the cmsg feature in __skb_tstamp_tx(=
)
> > > if we hit this test statement "skb_shinfo(skb)->tx_flags &
> > > SKBTX_SCHED_TSTAMP)". So we need those two socket tsflag fields to
> > > help us.
> >
> > I also don't see how a new bit/integer in a sk can help to tell the p=
er cmsg
> > on/off. This cmsg may have tx timestamp on while the next cmsg can ha=
ve it off.
> =

> It's not hard to use it because we can clear every socket cmsg tsflags
> when we're done the check in tcp_sendmsg_locked() if the cmsg feature
> is not enabled. Then we can accurately know which timestamp should we
> print in the tx path.
> =

> >
> > There is still one bit in skb_shinfo(skb)->tx_flags. How about define=
 a
> > SKBTX_BPF for everything. imo, the fine control on
> > SOF_TIMESTAMPING_TX_{SCHED,SOFTWARE} is not useful for bpf. Almost al=
l of the
> > time the bpf program wants all available time stamps (sched, software=
, and
> > hwtstamp if the NIC has it).

I like the approach of just calling BPF on every hook. Assuming that
the call is very cheap, which AFAIK is true.

In that case we don't need complex branching in C to optionally skip
this step, as we do for reporting to userspace.

All the logic and complexity is in the BPF program itself.

We obviously then let go of the goal to model the BPF API close to the
existing SO_TIMESTAMPING API. Though I advocated for keeping them
aligned, I also think we should just tailor it to what makes most
sense in the BPF space.
 =

> Sorry, I really doubt that we can lose the fine control. =


Since BPF is called at each reporting point, no control is lost,
actually.

> I still
> reckon that providing more options to users is a good way to go,
> especially for some latency sensitive applications, enabling one or
> two or three tx flags could lead to different performances. For the
> users of SO_TIMESTAMPING, they use the feature very differently. Not
> all users prefer to record everything.
> =

> > Since bpf is in the kernel, it is much cheaper
> > because it does not need to do skb_alloc/clone and queue to the error=
 queue.
> >
> > I think the bpf prog needs to capture a timestamp at the sendmsg() ti=
me, so a
> > bpf prog needs to be called at sendmsg().
> =

> Agreed, I planned to implement this after this series.
> =

> > Then it may as well allow the bpf
> > prog@sendmsg() to decide if it needs to set the SKBTX_BPF bit in
> > skb_shinfo(skb)->tx_flags or not.
> >
> > TCP_SKB_CB(skb)->txstamp_ack can also work similarly. There is still =
unused bit
> > in "struct tcp_skb_cb", so may be adding TCP_SKB_CB(skb)->bpf_txstamp=
_ack
> >
> > Then there is no need to control SOF_TIMESTAMPING_TX_* through bpf_se=
tsockopt().
> > It only needs one bpf specific socket option like bpf_setsockopt(SOL_=
SOCKET,
> > BPF_TX_TIMESTAMPING) to guard if the bpf-prog@sendmsg() needs to be c=
alled or
> > not. There are already other TCP_BPF_IW,TCP_BPF_SNDCWND_CLAMP,... spe=
cific
> > socket options.
> >
> > imo, this is a simpler interface and also gives the bpf prog per pack=
et control
> > at the same time.
> =

> Very interesting idea, but the precondition is that we give up the
> fine control...
> =

> Thanks,
> Jason



