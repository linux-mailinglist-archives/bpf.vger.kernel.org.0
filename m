Return-Path: <bpf+bounces-43613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AB9B70CB
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DD51F21F2F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31126217657;
	Wed, 30 Oct 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc5etqDH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6481C461C;
	Wed, 30 Oct 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332537; cv=none; b=fhB/keTWiC5F35x8sXUoIyBUw8nBhlqmJEic0nOlLM9AnpGkEAgNadh4uVJTVeRmYvoFFqIFnWQk2V3uNne6dibm4Sk5a2rG0PxWxVozMGRcYse2nuqokLPdgtIF1mEnsgs4feBZ44dESAk6PwbXIy0ZPMwQV9stKKmND4VEgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332537; c=relaxed/simple;
	bh=FsKYxAfzEB9P+Lkc+Fh7fTWdGZGLi0sIZWEX8infh00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBFj3/G3TPF0cN5IoiG8K/nNJy6k2tNbH1Ca/XQfDwZwaVdeIwY+6dAqPZxRsylLDWtWftbCziI2PXVWr72z0j6igEaTDGJjFclENHlXReXSz0xeHJL1KQc6/wEefRdu5ronQSK/eAZdF6zK4uYT32ufmNeuoq9gvHOZaGWHkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc5etqDH; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a4e5e574b6so1469715ab.0;
        Wed, 30 Oct 2024 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730332533; x=1730937333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOsxWjbPSZZm9f27KOHHcG0WNWuhgHkqU+vBEpi9xYI=;
        b=Rc5etqDHifti8kg1mzmqqBFRIx4Mhu1hfm6w1IhhhwpO0nB+8Y0KqHngKbM/DlwQRq
         CzAKUwWwZeClHNJTuGCCeJxzzc09MK4PwudqnG/mPGUaL8bdEodUMr0Kc3t9t0etPt6y
         1uQ0T/hMSJmES01Gih8HUDrPiiEunjq/GTFGyDg9yvwWSa0q7SP7Zh8kWpXXpSt4FL1O
         jpZsUCZ1l/5sF/wa2d54MLVqkx/AoscBFMU4aMX0+H3FYTgd5oCaiOyIpTW/iNr0fuS+
         5vZ6xKZNbzB7U+wSEbbmeQAY+IERBCqjlwwbJ8DaVVPXkJ0JPYs4Ce2te4/MwxyBgt3D
         Dgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730332533; x=1730937333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOsxWjbPSZZm9f27KOHHcG0WNWuhgHkqU+vBEpi9xYI=;
        b=FWNQsUhHdLqrLclyf4EjgXDVJU2SdjRRBs3L9qNIdRbVG4yATxdDJJmhf/tiVEWAxS
         GM/t+4mzyox56fD5K2s14kwE3kxhw5iKXKPhthN6SREjpo9mNtayYdbdw+L+ba4AsJKY
         dcgjtxYK3+gQMwrzYUEyQ4iHF2J5NfVRDD4WGUvInjjKKBCCuxv582BBakxOyfTaA/rG
         N5qZdu0RI0KXRpmGrihkxdcArP1fw86QE5TCPZdmeXb7moahlkP60I1ysYhJ2TnfdCD6
         PLAYuH3YZOvxEIKraaRBhEzfdg2XpNE1X0aDrvUt7L/qnrgm1IOBFm6VTcbf0Aoduxqk
         9TYw==
X-Forwarded-Encrypted: i=1; AJvYcCUo1x9xAsGTy4VoG8xPnPnuFp+D/reBEZ5pj96wppfflD/Am87QQW9ko67cK6eXShfAK+Q=@vger.kernel.org, AJvYcCVr0pW4yPHtm0nYbSEI2ib5nAaveOO/Sll5zuqeqTbjVx6u35uaf1dZGooZDxVj6kL/we1xCKE8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9E4dIF+bhv90RN74cks+Fj7xuHAD/P+8+7IeoOcuyDSmBvOy
	ArlszxlQ9y0OnHqOquXLz+eJDtRvqmj5UGGxVCvUUHjMoaLYvusTC3o0/VxF2MmWQLNbrC+WcIP
	IIAoA2Z1laPRTqaE02Dm+ypk1EzA=
X-Google-Smtp-Source: AGHT+IFSgI5HZgctf0kQScq2ouh2pRRqCqPVciYl1REOz9bHTqB2isQj2f5WE1CYWpFuI55m1D1gpDAMT+vd8aJSA3w=
X-Received: by 2002:a05:6e02:1aaa:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a6a93944camr4525045ab.0.1730332533279; Wed, 30 Oct 2024
 16:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
In-Reply-To: <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 07:54:57 +0800
Message-ID: <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:15=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 30, 2024 at 1:37=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 10/29/24 8:04 PM, Jason Xing wrote:
> > > >>>>>>>    static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > > >>>>>>>                                 const struct sk_buff *ack_skb=
,
> > > >>>>>>>                                 struct skb_shared_hwtstamps *=
hwtstamps,
> > > >>>>>>> @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct=
 sk_buff *orig_skb,
> > > >>>>>>>        u32 tsflags;
> > > >>>>>>>
> > > >>>>>>>        tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > >>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> > > >>>>>>
> > > >>>>>> I still don't get this part since v2. How does it work with cm=
sg only
> > > >>>>>> SOF_TIMESTAMPING_TX_*?
> > > >>>>>>
> > > >>>>>> I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does =
not return any tx
> > > >>>>>> time stamp after this patch.
> > > >>>>>>
> > > >>>>>> I am likely missing something
> > > >>>>>> or v2 concluded that this behavior change is acceptable?
> > > >>>>>
> > > >>>>> Sorry, I submitted this series accidentally removing one import=
ant
> > > >>>>> thing which is similar to what Vadim Fedorenko mentioned in the=
 v1
> > > >>>>> [1]:
> > > >>>>> adding another member like sk_flags_bpf to handle the cmsg case=
.
> > > >>>>>
> > > >>>>> Willem, would it be acceptable to add another field in struct s=
ock to
> > > >>>>> help us recognise the case where BPF and cmsg works parallelly?
> > > >>>>>
> > > >>>>> [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf013=
63c3b2@linux.dev/
> > > >>>>
> > > >>>> The current timestamp flags don't need a u32. Maybe just reserve=
 a bit
> > > >>>> for this purpose?
> > > >>>
> > > >>> Sure. Good suggestion.
> > > >>>
> > > >>> But I think only using one bit to reflect whether the sk->sk_tsfl=
ags
> > > >>> is used by normal or cmsg features is not enough. The existing
> > > >>> implementation in tcp_sendmsg_locked() doesn't override the
> > > >>> sk->sk_tsflags even the normal and cmsg features enabled parallel=
ly.
> > > >>> It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on
> > > >>> that, even if at some point users suddenly remove the cmsg use an=
d
> > > >>> then the prior normal SO_TIMESTAMPING continues to work.
> > > >>>
> > > >>> How about this, please see below:
> > > >>> For now, sk->sk_tsflags only uses 17 bits (see the last one
> > > >>> SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 fla=
gs
> > > >>> (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With=
 that
> > > >>> said, we could reserve the highest four bits for cmsg use for the
> > > >>> moment. Four bits represents four points where we can record the
> > > >>> timestamp in the tx case.
> > > >>>
> > > >>> Do you agree on this point?
> > > >>
> > > >> I don't follow.
> > > >>
> > > >> I probably miss the entire point.
> > > >>
> > > >> The goal for sockcm fields is to start with the sk field and
> > > >> optionally override based on cmsg. This is what sockcm_init does f=
or
> > > >> tsflags.
> > > >>
> > > >> This information is for the skb, so these are recording flags.
> > > >>
> > > >> Why does the new datapath need to know whether features are enable=
d
> > > >> through setsockopt or on a per-call basis with a cmsg?
> > > >>
> > > >> The goal was always to keep the reporting flags per socket, but ma=
ke
> > > >> the recording flag per packet, mainly for sampling.
> > > >
> > > > If a user uses 1) cmsg feature, 2) bpf feature at the same time, we
> > > > allow each feature to work independently.
> > > >
> > > > How could it work? It relies on sk_tstamp_tx_flags() function in th=
e
> > > > current patch: when we are in __skb_tstamp_tx(), we cannot know whi=
ch
> > > > flags in each feature are set without fetching sk->sk_tsflags and
> > > > sk->sk_tsflags_bpf. Then we are able to know what timestamp we want=
 to
> > > > record. To put it in a simple way, we're not sure if the user wants=
 to
> > > > see a SCHED timestamp by using the cmsg feature in __skb_tstamp_tx(=
)
> > > > if we hit this test statement "skb_shinfo(skb)->tx_flags &
> > > > SKBTX_SCHED_TSTAMP)". So we need those two socket tsflag fields to
> > > > help us.
> > >
> > > I also don't see how a new bit/integer in a sk can help to tell the p=
er cmsg
> > > on/off. This cmsg may have tx timestamp on while the next cmsg can ha=
ve it off.
> >
> > It's not hard to use it because we can clear every socket cmsg tsflags
> > when we're done the check in tcp_sendmsg_locked() if the cmsg feature
> > is not enabled. Then we can accurately know which timestamp should we
> > print in the tx path.
> >
> > >
> > > There is still one bit in skb_shinfo(skb)->tx_flags. How about define=
 a
> > > SKBTX_BPF for everything. imo, the fine control on
> > > SOF_TIMESTAMPING_TX_{SCHED,SOFTWARE} is not useful for bpf. Almost al=
l of the
> > > time the bpf program wants all available time stamps (sched, software=
, and
> > > hwtstamp if the NIC has it).
>
> I like the approach of just calling BPF on every hook. Assuming that
> the call is very cheap, which AFAIK is true.
>
> In that case we don't need complex branching in C to optionally skip
> this step, as we do for reporting to userspace.
>
> All the logic and complexity is in the BPF program itself.
>
> We obviously then let go of the goal to model the BPF API close to the
> existing SO_TIMESTAMPING API. Though I advocated for keeping them
> aligned, I also think we should just tailor it to what makes most
> sense in the BPF space.
>
> > Sorry, I really doubt that we can lose the fine control.
>
> Since BPF is called at each reporting point, no control is lost,
> actually.

Sorry, I still don't get it :( If there is something wrong with my
understanding, please correct me.

BPF is only called on every sock_opt point in this case, like
BPF_SOCK_OPS_TCP_CONNECT_CB, not every report point of
SO_TIMESTAMPING. If we add check to test if skb is set SKBTX_BPF in
__skb_tstamp_tx(), then at every point bpf will be called. But it's
different from SO_TIMESTAMPING drived by each bit (SCHED/TX_SOFTWARE)
to control each point. My question is if we would use SKBTX_BPF for
everything, how could we control and know when we hit
SCHED/TX_SOFTWARE/ACK time from the bpf programs' perspective? Only
one bit... It will print everything without the ability to control.

Then if we try the SKBTX_BPF approach, it seems we don't actually
insist on adding a test statement in __skb_tstamp_tx(). Instead, we
could add into more places (by only checking the SKBTX_BPF flag), say,
tcp_write_xmit(), right?

I'm not saying I'm opposed to this idea. Instead I think it's very
useful, just a few questions haunting me...

Thanks,
Jason

