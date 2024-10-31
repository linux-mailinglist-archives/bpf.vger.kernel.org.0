Return-Path: <bpf+bounces-43614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321949B70F1
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 01:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559481C2114C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971F946C;
	Thu, 31 Oct 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO2KMRWy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CC8F49;
	Thu, 31 Oct 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333663; cv=none; b=ZTGfxAG697IDqFOFRW7KBjs58IBI/Bs9recxe1EMBcYwVZM+wXC132HEGNDzmm8uy//TCtEAW9FCFky9B89duz8vEKnaWRgAJuSQ1sUQgLlgCWeDHmz9WLtGjWuP32KBJLgGyq8ZLvdgBUtGjMDBgV157N48VRYf6TQzoNwqkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333663; c=relaxed/simple;
	bh=hHWyEwZvtqmiYaus4+N1OibokJx9R3zrvvC9ey/3rAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8KVV6r/Fs8cAaNO9AUnV444jmP+U0gJIGEp2oAlKP6772XDgBCbBJMks9lEEQjQcmmheL6XmY70h4M93YgrHLj6O+FZTtm97UiXkxyzOEBFnL6YaklVob7MX/P8qg9ZTXlUi9hW8Vl5qk3C+CxW4nygUQqMEn2uOsVpxZukKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO2KMRWy; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8323b555a6aso16840939f.3;
        Wed, 30 Oct 2024 17:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730333659; x=1730938459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be86WG/I23PGsLUV2qAQXgvNj2xQrfHoRUgDD4D88yo=;
        b=YO2KMRWyWqk6YWwVgrVIBBEZI6YTG5DXuxXZF0Cz5EwDooD2nkBU/0Jl3eFqtrmqf3
         a6Y1Jq17io/naeUvC7HLL4sRrOhEnrBD/O5IQnntnzl8N/evcZxbJbn1p3W0/FvcUcXF
         MuaqXiRjNdZwnwK7Y37JMJgbrpVjSJApgCJXYE8uNVxWV7wIVMyeyKp/WAt60rl9xRPp
         x/e9xhcWKMQkQJrKEhwScM+5rU8ZC8iD6Lj8zcBzUrXWMTN8CJLQWSDbuNxLCWyyRAwP
         y+rT88r9t2tLEl5Qi4H3IofOlJ54479BowVGFnusMVyGPvLnxgQsJ1LXbep2pAW88kk1
         XhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730333659; x=1730938459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be86WG/I23PGsLUV2qAQXgvNj2xQrfHoRUgDD4D88yo=;
        b=wKj/CRc+pS7p80RzCO8XG7LalrJFij1UlV9/LmbrLfyne1l7GqbdSmMYdNzK84epEI
         dJ7A/i2eL/mCRMjR3yl3uh7b/DvI0nO84ZryfLlJSoxd+3aOQ4F42S2K88C7jrBsLAZd
         LTA64DiTDkUpxthPo0iZhFn0X+7WZrdEalNvHQXc9gvMJkqC/EMSPueZvCyrmdEqrStJ
         +WQjoEgI4rCcvyvst0SonF/bMwmsGcfAnikgmdNLJHMlYIc7AoPGa6VyUXm84ylvFg8m
         ifjEQh+jLlKeYDoQQFMNbXpDfOvf0lQ4Td3xKnt0SBCf6+cfK62Gr+QWmNdU0mevShfP
         /lMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+LpgJHBh0WgoPOxzAuxRqdXE3cCZcSWF01WungHYvcK5nMzfPcX3adK1OjB4/xwsWHFQ=@vger.kernel.org, AJvYcCUD7mcSksXoKFebIo4WGOBq5ueqr8NRYV9TO5+zGfi/7+XzIBk26ExJAUEQ6SHVLq8fEwsTu8fN@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdZFWts0ULHcq+sWwXb9obHBzxATkiD8gTWL4P8oE6sSUMBAK
	ZYNFKrMp5gpVW2pELY8usJA87DlVw9MCyUcGmWSzZelFsWMJ8x8+Wr/EfpDU7pzUKuo4A+XHteF
	KoSyspJaDOvHBYIYlEY+o7eTcLOA=
X-Google-Smtp-Source: AGHT+IHLVWxcE6bUJPGtC7ouVbAfr2HO5RHhBz8PmfvrBmuRAfoOJeqrcp3k91f8xJrcsXDioVvTWKq9F36DBWkEPig=
X-Received: by 2002:a05:6e02:174e:b0:3a3:40f0:cb8c with SMTP id
 e9e14a558f8ab-3a61752b08cmr19288625ab.17.1730333658493; Wed, 30 Oct 2024
 17:14:18 -0700 (PDT)
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
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch> <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
In-Reply-To: <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 08:13:42 +0800
Message-ID: <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
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

On Thu, Oct 31, 2024 at 7:54=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Oct 31, 2024 at 1:15=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Wed, Oct 30, 2024 at 1:37=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > > >
> > > > On 10/29/24 8:04 PM, Jason Xing wrote:
> > > > >>>>>>>    static void skb_tstamp_tx_output(struct sk_buff *orig_sk=
b,
> > > > >>>>>>>                                 const struct sk_buff *ack_s=
kb,
> > > > >>>>>>>                                 struct skb_shared_hwtstamps=
 *hwtstamps,
> > > > >>>>>>> @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(stru=
ct sk_buff *orig_skb,
> > > > >>>>>>>        u32 tsflags;
> > > > >>>>>>>
> > > > >>>>>>>        tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > >>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> > > > >>>>>>
> > > > >>>>>> I still don't get this part since v2. How does it work with =
cmsg only
> > > > >>>>>> SOF_TIMESTAMPING_TX_*?
> > > > >>>>>>
> > > > >>>>>> I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it doe=
s not return any tx
> > > > >>>>>> time stamp after this patch.
> > > > >>>>>>
> > > > >>>>>> I am likely missing something
> > > > >>>>>> or v2 concluded that this behavior change is acceptable?
> > > > >>>>>
> > > > >>>>> Sorry, I submitted this series accidentally removing one impo=
rtant
> > > > >>>>> thing which is similar to what Vadim Fedorenko mentioned in t=
he v1
> > > > >>>>> [1]:
> > > > >>>>> adding another member like sk_flags_bpf to handle the cmsg ca=
se.
> > > > >>>>>
> > > > >>>>> Willem, would it be acceptable to add another field in struct=
 sock to
> > > > >>>>> help us recognise the case where BPF and cmsg works parallell=
y?
> > > > >>>>>
> > > > >>>>> [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf0=
1363c3b2@linux.dev/
> > > > >>>>
> > > > >>>> The current timestamp flags don't need a u32. Maybe just reser=
ve a bit
> > > > >>>> for this purpose?
> > > > >>>
> > > > >>> Sure. Good suggestion.
> > > > >>>
> > > > >>> But I think only using one bit to reflect whether the sk->sk_ts=
flags
> > > > >>> is used by normal or cmsg features is not enough. The existing
> > > > >>> implementation in tcp_sendmsg_locked() doesn't override the
> > > > >>> sk->sk_tsflags even the normal and cmsg features enabled parall=
elly.
> > > > >>> It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based =
on
> > > > >>> that, even if at some point users suddenly remove the cmsg use =
and
> > > > >>> then the prior normal SO_TIMESTAMPING continues to work.
> > > > >>>
> > > > >>> How about this, please see below:
> > > > >>> For now, sk->sk_tsflags only uses 17 bits (see the last one
> > > > >>> SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 f=
lags
> > > > >>> (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). Wi=
th that
> > > > >>> said, we could reserve the highest four bits for cmsg use for t=
he
> > > > >>> moment. Four bits represents four points where we can record th=
e
> > > > >>> timestamp in the tx case.
> > > > >>>
> > > > >>> Do you agree on this point?
> > > > >>
> > > > >> I don't follow.
> > > > >>
> > > > >> I probably miss the entire point.
> > > > >>
> > > > >> The goal for sockcm fields is to start with the sk field and
> > > > >> optionally override based on cmsg. This is what sockcm_init does=
 for
> > > > >> tsflags.
> > > > >>
> > > > >> This information is for the skb, so these are recording flags.
> > > > >>
> > > > >> Why does the new datapath need to know whether features are enab=
led
> > > > >> through setsockopt or on a per-call basis with a cmsg?
> > > > >>
> > > > >> The goal was always to keep the reporting flags per socket, but =
make
> > > > >> the recording flag per packet, mainly for sampling.
> > > > >
> > > > > If a user uses 1) cmsg feature, 2) bpf feature at the same time, =
we
> > > > > allow each feature to work independently.
> > > > >
> > > > > How could it work? It relies on sk_tstamp_tx_flags() function in =
the
> > > > > current patch: when we are in __skb_tstamp_tx(), we cannot know w=
hich
> > > > > flags in each feature are set without fetching sk->sk_tsflags and
> > > > > sk->sk_tsflags_bpf. Then we are able to know what timestamp we wa=
nt to
> > > > > record. To put it in a simple way, we're not sure if the user wan=
ts to
> > > > > see a SCHED timestamp by using the cmsg feature in __skb_tstamp_t=
x()
> > > > > if we hit this test statement "skb_shinfo(skb)->tx_flags &
> > > > > SKBTX_SCHED_TSTAMP)". So we need those two socket tsflag fields t=
o
> > > > > help us.
> > > >
> > > > I also don't see how a new bit/integer in a sk can help to tell the=
 per cmsg
> > > > on/off. This cmsg may have tx timestamp on while the next cmsg can =
have it off.
> > >
> > > It's not hard to use it because we can clear every socket cmsg tsflag=
s
> > > when we're done the check in tcp_sendmsg_locked() if the cmsg feature
> > > is not enabled. Then we can accurately know which timestamp should we
> > > print in the tx path.
> > >
> > > >
> > > > There is still one bit in skb_shinfo(skb)->tx_flags. How about defi=
ne a
> > > > SKBTX_BPF for everything. imo, the fine control on
> > > > SOF_TIMESTAMPING_TX_{SCHED,SOFTWARE} is not useful for bpf. Almost =
all of the
> > > > time the bpf program wants all available time stamps (sched, softwa=
re, and
> > > > hwtstamp if the NIC has it).
> >
> > I like the approach of just calling BPF on every hook. Assuming that
> > the call is very cheap, which AFAIK is true.
> >
> > In that case we don't need complex branching in C to optionally skip
> > this step, as we do for reporting to userspace.
> >
> > All the logic and complexity is in the BPF program itself.
> >
> > We obviously then let go of the goal to model the BPF API close to the
> > existing SO_TIMESTAMPING API. Though I advocated for keeping them
> > aligned, I also think we should just tailor it to what makes most
> > sense in the BPF space.
> >
> > > Sorry, I really doubt that we can lose the fine control.
> >
> > Since BPF is called at each reporting point, no control is lost,
> > actually.
>
> Sorry, I still don't get it :( If there is something wrong with my
> understanding, please correct me.
>
> BPF is only called on every sock_opt point in this case, like
> BPF_SOCK_OPS_TCP_CONNECT_CB, not every report point of
> SO_TIMESTAMPING. If we add check to test if skb is set SKBTX_BPF in
> __skb_tstamp_tx(), then at every point bpf will be called. But it's
> different from SO_TIMESTAMPING drived by each bit (SCHED/TX_SOFTWARE)
> to control each point. My question is if we would use SKBTX_BPF for
> everything, how could we control and know when we hit
> SCHED/TX_SOFTWARE/ACK time from the bpf programs' perspective? Only
> one bit... It will print everything without the ability to control.
>
> Then if we try the SKBTX_BPF approach, it seems we don't actually
> insist on adding a test statement in __skb_tstamp_tx(). Instead, we
> could add into more places (by only checking the SKBTX_BPF flag), say,
> tcp_write_xmit(), right?

I realized that we will have some new sock_opt flags like
TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
not... For each sock_opt point, they will be called without caring if
related flags in skb are set. Well, it's meaningless to add more
control of skb tsflags at each TS_xx_OPT_CB point.

Am I understanding in a correct way? Now, I'm totally fine with this great =
idea!

Thanks,
Jason

