Return-Path: <bpf+bounces-51380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3AA338C2
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 08:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C97188BB5D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA405209668;
	Thu, 13 Feb 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq9jRc8E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF01FAC42;
	Thu, 13 Feb 2025 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431514; cv=none; b=sMG4tSkFQdcRIny4Vi7BqC0phMRzImigVPqIsOZGZfgBaYLUCI8NIjsdVz+O1CqiOVTa9T6tZf5X2HMeH0Nv5WfSAL9p/pos9KRkVhBMPV97wpuB0UBesJZLq13mhmTv0PhlxyVFMa1jnYrSjGh11r8SdJeZDazufwU8FPxAXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431514; c=relaxed/simple;
	bh=DRPApdIO1hjqDSiJfQjNZ64VrXoBZxzHXsrThoOG6bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPhbX22YLwS0ksfKLPmoT6vWZhttwbn+6ntQoa/6tHrLiCL4svi5FzxHdl0CM5VJfrFTbyG5bwCNQVBlcaF8r7TnMFo3AgtLNYwt15s/tRs/PWkc48Sq3D196x6fKldHOYQNudXzd8SdhAQfua1hInNElogLwLZt+Lfussu0v7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq9jRc8E; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so2061325ab.2;
        Wed, 12 Feb 2025 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739431511; x=1740036311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lsDlskI1XlpKLkvs3f4ODJwIZbqrD0d2Rq9yStXHOs=;
        b=Xq9jRc8EzY2PayPnmlpGnCeg/AayThb+2IoZbay71bowsWG15gLCm2GCDQHAlTdk9x
         i8AfHcRN4JNC0y8Kn5jnh46PuFndukJZfcP+EsfV1WVUHeE/KScuCj2MznMVHCdbWpAW
         OIw6uHOT+zdgnXi3U3X2iHbTI98MbFYRJ2/scajgqdjRivB52h9XWQ/mGZR909bWacer
         z6MAf9UefBSBZiPKOItl1p1QnaFBEAli3F1jfV2K5MP2WIuT8K29RCot5l+/Omeq8C89
         HWwnksl41tc2iM6LwC9+5jGh42X4bwt3g3IW9HK3KMajOQUjVWm5FNcY7brdLKZ7tmb9
         AJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431512; x=1740036312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lsDlskI1XlpKLkvs3f4ODJwIZbqrD0d2Rq9yStXHOs=;
        b=IHAFnLVDjlr+qph6mxlryAD80/FtuAN9AZvc45BGJ901RenfF28J3gYkYvRo7MrsLt
         4u4T3GxLmvRauDujRw+Ax6X/s0R9S3mDmXHPV4i+jlJgbRnutiEiQCm+gd6IsgIHSssB
         7HDLCjPfOcgb5VKxPOncQJOCFP98v2hK+xKxh/Zir2AJQRwzAynEpXE/dJ6DXf+YFerd
         DPMMe2zuAxwTay/6UNIOmNjX1UbYax67W1G4vNK7hvmptCOyNfMKQQUqwKOjfwuchnrz
         s0yotwZrCi+zBzElOVqizChtkWDMnjRcbHeWBGjR382EDjGeLG3JxCQ38o3cHFhk+wza
         31Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Q0bEJ/b9x/uMpGypO9TEjJB4cultZ1yi6VNMfol93UAmf24rDYcnvfee314fePhha/j9R8GK@vger.kernel.org, AJvYcCXTWJts9mcIvK3Virz1rrJqT/6nsKIF7GIXxjHKa091182pMNJXt7P3ChzQy6ZeTwLkU8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNYIooppIqR993kqYTo0LMAnc8/zU9P2FH3JhZZDtx3pRjKm2
	wZ2+hwTc6I98mtOj8RLmXmTsGE2Ep7u3ya9x1EZQA81jm74qyVkpo3o3n+gIHDGd8SqJzVlhQ3Z
	Wqu4sMGHvElxzHxHVjvqc1tswVno=
X-Gm-Gg: ASbGnctKwubP10QF1aVzDZ/7MBqeRuK39sSwNvmzOMDWJI9TeEOgF4Oep8OFKh8GJAW
	YQTKpwyirhFeMxFoqKyYB3T7WCiR8q5kbzQKNdG8wXph/OIIWmB5A5fbbzC4WcFvFmcoJ8dCC
X-Google-Smtp-Source: AGHT+IFEmICaGFHReqgHIAMYAGYsU8oxirjBBKTYWdusCyKTGkUtYNYrEslHZs7wey5xFEMdK8GQS1L63TfWyrLOZ2I=
X-Received: by 2002:a92:c269:0:b0:3d0:d0d:db8e with SMTP id
 e9e14a558f8ab-3d18c21e8a1mr20566315ab.1.1739431511658; Wed, 12 Feb 2025
 23:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-9-kerneljasonxing@gmail.com> <216c663c-1a7a-4db7-9973-afba485f797e@linux.dev>
In-Reply-To: <216c663c-1a7a-4db7-9973-afba485f797e@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 15:24:35 +0800
X-Gm-Features: AWEUYZkppkMyfovKe9HvsFboC0NC24GTtV3gUGiFVDvnk6ACPGMA9_BnNNiVfd8
Message-ID: <CAL+tcoC9Xc1-9ZJVQX+AcKaOQGPSaXhoLH7FOemsD1yNEP8ULw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:20=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/11/25 10:18 PM, Jason Xing wrote:
> > Support hw SCM_TSTAMP_SND case for bpf timestamping.
> >
> > Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > callback will occur at the same timestamping point as the user
> > space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> > get the same SCM_TSTAMP_SND timestamp without modifying the
> > user-space application.
> >
> > To avoid increase the code complexity, replace SKBTX_HW_TSTAMP
> > with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> > from driver side using SKBTX_HW_TSTAMP. The new definition of
> > SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> > and bpf timestamping. After this patch, drivers can work under the
> > bpf timestamping.
> >
> > Considering some drivers doesn't assign the skb with hardware
> > timestamp, this patch do the assignment and then BPF program
> > can acquire the hwstamp from skb directly.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h         | 4 +++-
> >   include/uapi/linux/bpf.h       | 4 ++++
> >   net/core/skbuff.c              | 6 +++---
> >   tools/include/uapi/linux/bpf.h | 4 ++++
> >   4 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 76582500c5ea..0b4f1889500d 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -470,7 +470,7 @@ struct skb_shared_hwtstamps {
> >   /* Definitions for tx_flags in struct skb_shared_info */
> >   enum {
> >       /* generate hardware time stamp */
> > -     SKBTX_HW_TSTAMP =3D 1 << 0,
> > +     SKBTX_HW_TSTAMP_NOBPF =3D 1 << 0,
> >
> >       /* generate software time stamp when queueing packet to NIC */
> >       SKBTX_SW_TSTAMP =3D 1 << 1,
> > @@ -494,6 +494,8 @@ enum {
> >       SKBTX_BPF =3D 1 << 7,
> >   };
> >
> > +#define SKBTX_HW_TSTAMP              (SKBTX_HW_TSTAMP_NOBPF | SKBTX_BP=
F)
> > +
> >   #define SKBTX_ANY_SW_TSTAMP (SKBTX_SW_TSTAMP    | \
> >                                SKBTX_SCHED_TSTAMP | \
> >                                SKBTX_BPF)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index b3bd92281084..f70edd067edf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7043,6 +7043,10 @@ enum {
> >                                        * to the nic when SK_BPF_CB_TX_T=
IMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_HW_OPT_CB,      /* Called in hardware phase when
> > +                                      * SK_BPF_CB_TX_TIMESTAMPING feat=
ure
> > +                                      * is on.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index d80d2137692f..4930c43ee77b 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5547,7 +5547,7 @@ static bool skb_tstamp_tx_report_so_timestamping(=
struct sk_buff *skb,
> >       case SCM_TSTAMP_SCHED:
> >               return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
> >       case SCM_TSTAMP_SND:
> > -             return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAM=
P :
> > +             return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAM=
P_NOBPF :
> >                                                   SKBTX_SW_TSTAMP);
> >       case SCM_TSTAMP_ACK:
> >               return TCP_SKB_CB(skb)->txstamp_ack;
> > @@ -5568,9 +5568,9 @@ static void skb_tstamp_tx_report_bpf_timestamping=
(struct sk_buff *skb,
> >               op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >               break;
> >       case SCM_TSTAMP_SND:
> > +             op =3D hwts ? BPF_SOCK_OPS_TS_HW_OPT_CB : BPF_SOCK_OPS_TS=
_SW_OPT_CB;
>
> Remove this "hwts" test.
>
> >               if (hwts)
>
> Reuse this and do everything in this "if else" statement.

Will do it.

Thanks,
Jason

>
> > -                     return;
> > -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > +                     *skb_hwtstamps(skb) =3D *hwts;
> >               break;
> >       default:
> >               return;
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 9bd1c7c77b17..7b9652ce7e3c 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7033,6 +7033,10 @@ enum {
> >                                        * to the nic when SK_BPF_CB_TX_T=
IMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_HW_OPT_CB,      /* Called in hardware phase when
> > +                                      * SK_BPF_CB_TX_TIMESTAMPING feat=
ure
> > +                                      * is on.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
>

