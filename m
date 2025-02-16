Return-Path: <bpf+bounces-51694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F385A374D4
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F781890B8A
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905B19047F;
	Sun, 16 Feb 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXki06jG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AA53A7;
	Sun, 16 Feb 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717165; cv=none; b=d3pYedDy1L4HcPc6kP4thUk4yqhIbCVjO54//Xusbqz5XK2Rnf02vO9MELlMSEa1eQyJhmG6T5YZOOadYMjKQGMsZjIb9GpOrHpd6dkmFNOpRsJ7TQwjFuEDvXo5/LVxG3FrfV13YRAS16D1Qob9DOR1wY18CMr1UNLohvssKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717165; c=relaxed/simple;
	bh=J1ZhZONj24DaM/KReYqnrP+G0Mrlcg9v/1p/xQ2N4kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIf6gIQVx+bt0omPFZsvi19LLmUb8dk0bPyWzZQ5DYIOg/juBJhgyjiv66skIcxYfSlXxZG/yV7wAZDnua4hDDIQ8oUuc5ghX1phW6LdtqTIc7pTgGCAipfMQoXkBfn9hgAxAPvmH7B/7y24ZT2avVYpG9cDa6U+AGQef4RumM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXki06jG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce873818a3so33226035ab.1;
        Sun, 16 Feb 2025 06:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739717163; x=1740321963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1ZhZONj24DaM/KReYqnrP+G0Mrlcg9v/1p/xQ2N4kM=;
        b=mXki06jGMdFExCsm2GKBwPjlugnvPcrUQ+qN3TQFGJjdRqi0QadX7cxmAwybJqUtLg
         NSRZdMIrRUszbarfVH9gen62M/HUnPdH97Ckuy/hJhtHQKLQeXnemNh37+XzrJGVTgMJ
         irFE/KlusXL2DkG7URbWdIt9YPhGIoCTug2IQ1nTQw1P/knjD/bVyObod6agPFDRCcez
         WPT9GjZW4u4cXwUQ5tdIaQ4KMYIZWGXwpg76Oiax6qcpiLcM88erRGtCeOWfy/Hrzv7D
         Z/YwbA8VJMD7MCqhvt3k/ZPe6ksN4xbBlULoFysWYT9hhWD96z5/lVAAwBOugSzyuouW
         3JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739717163; x=1740321963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1ZhZONj24DaM/KReYqnrP+G0Mrlcg9v/1p/xQ2N4kM=;
        b=iDwtx/flJnPKDGLCFfugmvI9bm9J/uwmHQ0siJmK+52mLxEhjIoycuGhBW3IxxhnCG
         kT31zjTTbbX/zqFzZxoEfxaL5sBK4IWjUXQPOUS7df3KLWXPQWv5LPCg0dilTSsvE2c8
         FBUn1MdDrPEcFePN+7LMZDQas+Jt2VIK+mn95Ptu94UjIef6vE+MOWtYomaGR0286kgL
         oNFpjoWc3/FfSsdSJluvztGohSQtCcbxNd9opYWEGX9CrnbBXE6bAaGHDOUt1qHhWxUL
         gu5jhS09YF7uY2vn+ogWy/GSl9wD6WjbUmFyHP39NKXm2tLUITgp/UErOdwN/YT/mDHQ
         bjRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXHhpWtlfo3AhX0nTi2D8newQGkyT3Jv2MZTtYKvPyB36ZqMqy+r6bPjqS/AM16cVwTLCwzq4Y@vger.kernel.org, AJvYcCVbXHdaTr8Us4tFNOhQP81TjQgzKuFFpo9OY2g8ccM+zGJJikyGfPiLYsH3zBOMfJEY4wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCWpOLw4KZ6HF1aim5cVI+Wi4rjV4M18CaLwYfcVLz2gkgyw+
	z1ToZs0M5NHfIMeWt1VoJLZTSLeXC9j5Fia/76nUgZdJmr7ctBOoSL/cs0lHNH39Y8bf5AxQOys
	N8OTDmd0vdOBWQSYIMrLuw3UdXrs=
X-Gm-Gg: ASbGncssY1/dSAMGYQFE3zhK+F5OJNWZS06mEHoeAyxbakYqKEIoimN6dkedLrSxVPd
	HnhtzZjhCcwcHdiw/+iMXXZUnNZOBmSm3Hb4DLSAr9Cpha5vvsmnbjir6BS2NEvT1oSFH6sYn
X-Google-Smtp-Source: AGHT+IEQo2gQVQuaotIETELARyncaSDhsDyAzEyW0WE3EAq6YkeWIAQDpe1CdUgaJgwHT1POQylS/olobq/Mq9QD+RI=
X-Received: by 2002:a05:6e02:1489:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d280917ac6mr49915625ab.13.1739717163073; Sun, 16 Feb 2025
 06:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com> <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
 <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
 <89989129-9336-4863-a66e-e9c8adc60072@linux.dev> <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
 <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 22:45:26 +0800
X-Gm-Features: AWEUYZnBfHGBh3eCKwzhE3Smi3iC5H31Go-W4YZlh4m3TzHmEADD8KQhsHp6HD0
Message-ID: <CAL+tcoCWmzFvz=GtbmfVoDwacTDXi2XeHt-Fc10rxc5S2WMN_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 10:36=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 2/15/25 2:23 PM, Jason Xing wrote:
> > > > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >>
> > > >> Jason Xing wrote:
> > > >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > > >>> <willemdebruijn.kernel@gmail.com> wrote:
> > > >>>>
> > > >>>> Jason Xing wrote:
> > > >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > > >>>>>
> > > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > > >>>>> callback will occur at the same timestamping point as the user
> > > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> > > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
> > > >>>>> user-space application.
> > > >>>>>
> > > >>>>> To avoid increasing the code complexity, replace SKBTX_HW_TSTAM=
P
> > > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> > > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definition of
> > > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket timestamp=
ing
> > > >>>>> and bpf timestamping. After this patch, drivers can work under =
the
> > > >>>>> bpf timestamping.
> > > >>>>>
> > > >>>>> Considering some drivers doesn't assign the skb with hardware
> > > >>>>> timestamp,
> > > >>>>
> > > >>>> This is not for a real technical limitation, like the skb perhap=
s
> > > >>>> being cloned or shared?
> > > >>>
> > > >>> Agreed on this point. I'm kind of familiar with I40E, so I dare t=
o say
> > > >>> the reason why it doesn't assign the hwtstamp is because the skb =
will
> > > >>> soon be destroyed, that is to say, it's pointless to assign the
> > > >>> timestamp.
> > > >>
> > > >> Makes sense.
> > > >>
> > > >> But that does not ensure that the skb is exclusively owned. Nor th=
at
> > > >> the same is true for all drivers using this API (which is not smal=
l,
> > > >> but small enough to manually review if need be).
> > > >>
> > > >> The first two examples I happened to look at, i40e and bnx2x, both=
 use
> > > >> skb_get() to get a non-exclusive skb reference for their ptp_tx_sk=
b.
> > >
> > > I think the existing __skb_tstamp_tx() function is also assigning to
> > > skb_hwtstamps(skb). The skb may be cloned from the orig_skb first, bu=
t they
> > > still share the same shinfo. My understanding is that this patch is a=
ssigning to
> > > the shinfo earlier, so it should not have changed the driver's expect=
ation on
> > > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there are =
drivers
> > > assuming exclusive access to the skb_hwtstamps(skb), probably it is s=
omething
> > > that needs to be addressed regardless and should not be the common ca=
se?
> >
> > Right, it's also what I was trying to say but missed. Thanks for the
> > supplementary info:)
>
> That existing behavior looks dodgy then, too.
>
> I don't have time to look into it deeply right now. But it seems to go
> back all the way to the introduction of hw timestamping in commit
> ac45f602ee3d in 2009.

Right. And hardware timestamping has been used for many years, I presume.

>
> I can see how it works in that nothing else holding a clone will
> likely have a reason to touch those fields. But that does not make it
> correct.
>
> Your point that the new code is no worse than today probably is true.

Right.

> But when we spot something we prefer to fix it probably. Will need a
> deeper look..

Got it. I added it to my to-do list. If you don't mind, I plan to take
a deep look in March and then get back to you because recently I'm
occupied by many things. I need to study some of the drivers that
don't use skb_get() there.

Thanks,
Jason

