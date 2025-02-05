Return-Path: <bpf+bounces-50524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A031A2954F
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C567A1821
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177519049B;
	Wed,  5 Feb 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm8IPo9e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438A18DF65;
	Wed,  5 Feb 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770806; cv=none; b=Uu4n/R4SJ2UZrJL20ttjSRTt74FKQ4ZSD6jDzIGvJsqRDuwefVdFmBfexy2QSrZ7EWSqeyar//D0k+hl8gc/3X15vmS4cilVvAaCJT77N8fuCnWauV+d1Jo59x4TeOlfaF7pz7Tn3lsYgAnAFvQycv7469ebb1PPdBvEmJcBxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770806; c=relaxed/simple;
	bh=iR0/DIhoe2SGYmsZM7LkSz2C6wvZpZwe/wX5Vvif3eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxE6yiOuwwz4Ta+WkIW1bW6DupCUeaQyq9yZqmGbUWBk0Te8HgFE67hg+QmJRyeq97f9zTGCoY+RDBH5/wmZJq3lmgoQwBCnunyzkl8gBYvTl6LraFy0S9sDHj9bmex4I6S6BYfT9JwiBuRWwI2CcnyhKTo+HLoutgNOj6RK6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm8IPo9e; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso49823125ab.2;
        Wed, 05 Feb 2025 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770804; x=1739375604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoPBFOyThpzqBixBfxYAgaLxqBVlSxlyenyIDemejlY=;
        b=Gm8IPo9eCeG4EmiZZH3UNaYT/qVOHRJBs4orfH/pv3eRVNAUVE7KYF4iGkDbK7VEv0
         Cklj7WFF+yS0Qna7kSjyGjvCorBz31pIRm8etykaHQ/lcmhbNbWCADsU0O4k9u6tA0Fy
         LaUL9ooja4R4351fWZFOuFF3qZxAB7tIB8i8JFptPHZeVvdON9vc/tTAHIz/UVaqHbG9
         MJL3kjKaGmvDKqh+hfsCJ0D1YkicBmUHOwrMjNylanawHaC1+RXkbv2yWDYoPxVd5YET
         1vX9213kyQ6Es46OEs3lZ3DWSldYNwuQLbP/AMb0STQa/qaJpsy9iAZ+tK3183bPIa2L
         gdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770804; x=1739375604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoPBFOyThpzqBixBfxYAgaLxqBVlSxlyenyIDemejlY=;
        b=E9LB4IkivwaALGqVCJFvL/qspMeZs7ZZyEwJY1Jvl5LPTFS9cdrxrr/Ylkj0K+IAc3
         iZHugfNzYwebkSnokfHsKXO1d/RM+iSmy+gFx5F4Jga34vjfcSVZ7n2m56YFQNXHHrr9
         4YQrytbgijWWWxej+4x7+lrgEIGk48071oyYCJZIaaoRYNKIEtkMiDY5qj1y98ljwHBR
         JupD9QBTjQzbJnfjvUa0QTHoRsOTp/J/WyeMZP6w1c1qBvQXouwM6ndHf2oLlIwMcKy+
         mVTN8PWCSwc2WX9qWQMBseXeMlFW5MTiEKmKZjrPL+l58kGYoehf+0ewGkilabCmUqQP
         DjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU89GGegkwlPwZyvlLMA57sbsszUn3Df46W/1xzGDrs5ugp7oSAltYpgAjTWW+/o6ffk/uEfl5a@vger.kernel.org, AJvYcCVKSXRVskFzKPwncsUTM5KbkvPtrW1Z2OSlI47BIMGHbRXwoJj1ecaOMc20216CabEK3Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIR45BlZzs9+poEhOcS+lGnFUsSnxkOirI8RIGT9TxsheiwJS+
	UogyX0MLalMnQ/GNJT7SOYD7bOmafTKRSWu2pgu4QX6G+V4oDISwKvrVvPqWYsMMCNQ0hKnvtVb
	TjpKQ51fvcG3EtZ+ga4NR3CXMmW8=
X-Gm-Gg: ASbGncuQhtgqvcgHv4sNv0anrXlwEiFlrI0V3zbzPqzdRt4Gq1bKOFCyDQYECh0otio
	OkggjuOtgb25cHRakSvAR+HvhUFeMkuGxCs3rVnfPAa04Z9OolTzFo7Xo1BDS0MCvbc860r8=
X-Google-Smtp-Source: AGHT+IGAANpKHkfE+pq3mylKnzRRPV8W7GvUO7IzvUNq63vy/HXVy+kJ6vCOaTjGq/vyPkKXU4gTiiJeFgYOeDkp5GQ=
X-Received: by 2002:a05:6e02:1945:b0:3cf:bb11:a3a4 with SMTP id
 e9e14a558f8ab-3d04f6e596emr27188455ab.15.1738770802125; Wed, 05 Feb 2025
 07:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com> <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 23:52:45 +0800
X-Gm-Features: AWEUYZn9XWEEZrm1vnXm3dqaK6QpiB4uDT3h7cuc2xGgcx051sLKUkxUzmOK2kI
Message-ID: <CAL+tcoDASMLDRiE7GG_4YvhkDg2E9MDWbr2BkWOHAOXVh-+-hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:34=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > No functional changes here, only add skb_enable_app_tstamp() to test
> > if the orig_skb matches the usage of application SO_TIMESTAMPING
> > or its bpf extension. And it's good to support two modes in
> > parallel later in this series.
> >
> > Also, this patch deliberately distinguish the software and
> > hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order
> > to avoid such a case where hardware may go wrong and pass a NULL
> > hwstamps, which is even though unlikely to happen. If it really
> > happens, bpf prog will finally consider it as a software timestamp.
> > It will be hardly recognized. Let's make the timestamping part
> > more robust.
>
> Disagree. Don't add a crutch that has not shown to be necessary for
> all this time.
>
> Just infer hw from hwtstamps !=3D NULL.
>
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/linux/skbuff.h | 13 +++++++------
> >  net/core/dev.c         |  2 +-
> >  net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++--
> >  net/ipv4/tcp_input.c   |  3 ++-
> >  4 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index bb2b751d274a..dfc419281cc9 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -39,6 +39,7 @@
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> >  #include <net/netmem.h>
> > +#include <uapi/linux/errqueue.h>
> >
> >  /**
> >   * DOC: skb checksums
> > @@ -4533,18 +4534,18 @@ void skb_complete_tx_timestamp(struct sk_buff *=
skb,
> >
> >  void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *a=
ck_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > -                  struct sock *sk, int tstype);
> > +                  struct sock *sk, bool sw, int tstype);
> >
> >  /**
> > - * skb_tstamp_tx - queue clone of skb with send time stamps
> > + * skb_tstamp_tx - queue clone of skb with send HARDWARE timestamps
>
> Unfortunately this cannot be modified to skb_tstamp_tx_hw, as that
> would require updating way too many callers.
>
> >   * @orig_skb:        the original outgoing packet
> >   * @hwtstamps:       hardware time stamps, may be NULL if not availabl=
e
> >   *
> >   * If the skb has a socket associated, then this function clones the
> >   * skb (thus sharing the actual data and optional structures), stores
> > - * the optional hardware time stamping information (if non NULL) or
> > - * generates a software time stamp (otherwise), then queues the clone
> > - * to the error queue of the socket.  Errors are silently ignored.
> > + * the optional hardware time stamping information (if non NULL) then
> > + * queues the clone to the error queue of the socket.  Errors are
> > + * silently ignored.
> >   */
> >  void skb_tstamp_tx(struct sk_buff *orig_skb,
> >                  struct skb_shared_hwtstamps *hwtstamps);
> > @@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buf=
f *skb)
> >  {
> >       skb_clone_tx_timestamp(skb);
> >       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > -             skb_tstamp_tx(skb, NULL);
> > +             __skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAM=
P_SND);
>
> If a separate version for software timestamps were needed, I'd suggest
> adding a skb_tstamp_tx_sw() wrapper. But see first comment.
>
> >  }
> >
> >  /**
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index afa2282f2604..d77b8389753e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4501,7 +4501,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
> >       skb_assert_len(skb);
> >
> >       if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> > -             __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHE=
D);
> > +             __skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAM=
P_SCHED);
> >
> >       /* Disable soft irqs for various locks below. Also
> >        * stops preemption for RCU.
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index a441613a1e6c..6042961dfc02 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5539,10 +5539,35 @@ void skb_complete_tx_timestamp(struct sk_buff *=
skb,
> >  }
> >  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >
> > +static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, boo=
l sw)
>
> app is a bit vague. I suggest
>
> skb_tstamp_tx_report_so_timestamping
>
> and
>
> skb_tstamp_tx_report_bpf_timestamping

Good name. I like them.

>
> > +{
> > +     int flag;
> > +
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
> > +             flag =3D SKBTX_SCHED_TSTAMP;
> > +             break;
>
> Please just have a one line statements in the case directly:
>
>     case SCM_TSTAMP_SCHED:
>         return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
>     case SCM_TSTAMP_SND:
>         return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP :
>                                                  SKBTX_HW_TSTAMP);
>     case SCM_TSTAMP_ACK:
>         return TCP_SKB_CB(skb)->txstamp_ack;
>

Thanks for the re-arrangement!

> > +     case SCM_TSTAMP_SND:
> > +             flag =3D sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
> > +             break;
> > +     case SCM_TSTAMP_ACK:
> > +             if (TCP_SKB_CB(skb)->txstamp_ack)
> > +                     return true;
> > +             fallthrough;
> > +     default:
> > +             return false;
> > +     }
> > +
> > +     if (skb_shinfo(skb)->tx_flags & flag)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >                    const struct sk_buff *ack_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > -                  struct sock *sk, int tstype)
> > +                  struct sock *sk, bool sw, int tstype)
> >  {
> >       struct sk_buff *skb;
> >       bool tsonly, opt_stats =3D false;
> > @@ -5551,6 +5576,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >       if (!sk)
> >               return;
> >
> > +     if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> > +             return;
> > +
> >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> >       if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
> >           skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> > @@ -5599,7 +5627,7 @@ EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
> >  void skb_tstamp_tx(struct sk_buff *orig_skb,
> >                  struct skb_shared_hwtstamps *hwtstamps)
> >  {
> > -     return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
> > +     return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk, f=
alse,
> >                              SCM_TSTAMP_SND);
> >  }
> >  EXPORT_SYMBOL_GPL(skb_tstamp_tx);
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 77185479ed5e..62252702929d 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3330,7 +3330,8 @@ static void tcp_ack_tstamp(struct sock *sk, struc=
t sk_buff *skb,
> >       if (!before(shinfo->tskey, prior_snd_una) &&
> >           before(shinfo->tskey, tcp_sk(sk)->snd_una)) {
> >               tcp_skb_tsorted_save(skb) {
> > -                     __skb_tstamp_tx(skb, ack_skb, NULL, sk, SCM_TSTAM=
P_ACK);
> > +                     __skb_tstamp_tx(skb, ack_skb, NULL, sk, true,
> > +                                     SCM_TSTAMP_ACK);
> >               } tcp_skb_tsorted_restore(skb);
> >       }
> >  }
> > --
> > 2.43.5
> >
>
>

