Return-Path: <bpf+bounces-43496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABD9B5BE7
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C535283FD2
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBD1DB346;
	Wed, 30 Oct 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc8CkXTN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A563CB;
	Wed, 30 Oct 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270595; cv=none; b=koCMovlj0H+TTkfkXBKDqSlTCos1Dm4Y1hkxrx9nqfG9lOvC2bUNL7gxFrb2GUHbMpiqfUlV4ctA8jEN2mfiZsysorl2/i5wwao7hN5LyFFN1DJqUfZeU5QikD/+xsmyUQB2fkyvUkIndiH8sriNl1UrvOXtvcmncvQgDeJ7Wcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270595; c=relaxed/simple;
	bh=00NnwpxS5BTyFlQ5Tz77O/7Y4OyE0b4ki/CbqnqHS90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjHoDwS6Z1T7TfA4GQlhFMR9yyF697m7D+ickIQm26wOCXYoG+0Be2Y6D7bHRHchIwENlQ1Fs2ZSCbqe9Ssifa/bY8UzjgxDzURtEbQmaMzqllulU5n7uW2oI1NWI2YuU9qlF2ZhAayqXw7QIy1WTIrstr+niEgIKbZrbb/QFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc8CkXTN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a5075ed279so8731465ab.0;
        Tue, 29 Oct 2024 23:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270592; x=1730875392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY5wC4m6HqV+IELxdvIHJnFUvtLNQHhmLJyiQyHv0BM=;
        b=mc8CkXTNItOQNSNDPrrhYsimQOxseOmi2GGTCNqFNFgzq3q0sHfJ/Gvd64zEfVjivK
         +O8ZA13i+9AT+A3e0IpZM/bXzrF6ku3kSiGJdN6wCkvLCXhi6SbMtFcpvguE5AW1x261
         dJwq9TkKcOZ7AaLAPuqFPzZymeijjh2pwhDy5zorXlR4EstFS8kgp3XF4hsuW8CgRKEt
         QoPWNJcK9HU48rx8Fxgb1HF0RmYPWUGfijETDUXIsIMIU9MvYDvodGNP2p+wjaCd9+uy
         6LvMGb6Ejj2D5Fq/3m0sMcYmGht3p6IgVdSPEQwOiKoaL2ABgbXed890dxd8aZ/LOq/G
         BhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270592; x=1730875392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY5wC4m6HqV+IELxdvIHJnFUvtLNQHhmLJyiQyHv0BM=;
        b=G2H9Zlx/fCm4fFWgP8r0lZ7X6aNSnyvYT9I0j45sKfFp/9Qk1TyINQI7RHkAIC3dXk
         Dewl9vGmf2HCUu0+EzYtLfkzzbGG7VO40SIz/F9h2CG8/5nqp0HfY+gQB/Zsu50GNDIC
         cfzvhYK4sKdLPCsk1y6WNvqKIAAmm4+MV9OeXPUAErdxKboOAK4qN6+w0Slh92Exk61i
         bPtZ2c5Y/mGkbAXoi4hMIv91gJoU8RqwFi0SQmKWvtCsGuOonLV6Rf99p97xDpl+ZFkC
         FFQTfjksjmiIWhFCp7Y7k1zeDLN8maBX+qBP+pK1wu+fhLTFHt5FvaKhl9AWzhzdZ7Ln
         H1QA==
X-Forwarded-Encrypted: i=1; AJvYcCVByV371fVWNVHWHl7tx7TQ8BQcg6zkZ+yIKsf1RwGIrEEm9sZ3XxmtTZJXHm1cJnWFokQkozTl@vger.kernel.org, AJvYcCVPdZKruwy8nDuM1ThOLIMY/s7Mf4U49gPf/YabJdyCZLeKhDcLEDpZ+7lV05cy33bdGUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrALbK+GebHqLsAvAU7MiQR7oIrsG268yS38imBTySd1rdZDF
	ms5v7XviKh0ukpYs6N1ddC5kZKzyHceyOpPo4kDmcuuBCeKJvmfPNEy/YZZbWNg7tXNsasSqgyT
	xvUP7FByuXOYGsDomW1ypRH0X9YLMg3on
X-Google-Smtp-Source: AGHT+IFfR0i2uLh8Zem8RAObDL4La0+1YuIAhcW4ThBFAb6Q0b9genZAGgjKP4ZJT9SsFElT+BMLNtHDRKCmfuitX9U=
X-Received: by 2002:a05:6e02:13ac:b0:3a1:a293:4349 with SMTP id
 e9e14a558f8ab-3a4ed2fbabemr136409215ab.18.1730270592102; Tue, 29 Oct 2024
 23:43:12 -0700 (PDT)
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
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com> <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
In-Reply-To: <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 14:42:35 +0800
Message-ID: <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:37=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/29/24 8:04 PM, Jason Xing wrote:
> >>>>>>>    static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> >>>>>>>                                 const struct sk_buff *ack_skb,
> >>>>>>>                                 struct skb_shared_hwtstamps *hwts=
tamps,
> >>>>>>> @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_=
buff *orig_skb,
> >>>>>>>        u32 tsflags;
> >>>>>>>
> >>>>>>>        tsflags =3D READ_ONCE(sk->sk_tsflags);
> >>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> >>>>>>
> >>>>>> I still don't get this part since v2. How does it work with cmsg o=
nly
> >>>>>> SOF_TIMESTAMPING_TX_*?
> >>>>>>
> >>>>>> I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not =
return any tx
> >>>>>> time stamp after this patch.
> >>>>>>
> >>>>>> I am likely missing something
> >>>>>> or v2 concluded that this behavior change is acceptable?
> >>>>>
> >>>>> Sorry, I submitted this series accidentally removing one important
> >>>>> thing which is similar to what Vadim Fedorenko mentioned in the v1
> >>>>> [1]:
> >>>>> adding another member like sk_flags_bpf to handle the cmsg case.
> >>>>>
> >>>>> Willem, would it be acceptable to add another field in struct sock =
to
> >>>>> help us recognise the case where BPF and cmsg works parallelly?
> >>>>>
> >>>>> [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3=
b2@linux.dev/
> >>>>
> >>>> The current timestamp flags don't need a u32. Maybe just reserve a b=
it
> >>>> for this purpose?
> >>>
> >>> Sure. Good suggestion.
> >>>
> >>> But I think only using one bit to reflect whether the sk->sk_tsflags
> >>> is used by normal or cmsg features is not enough. The existing
> >>> implementation in tcp_sendmsg_locked() doesn't override the
> >>> sk->sk_tsflags even the normal and cmsg features enabled parallelly.
> >>> It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on
> >>> that, even if at some point users suddenly remove the cmsg use and
> >>> then the prior normal SO_TIMESTAMPING continues to work.
> >>>
> >>> How about this, please see below:
> >>> For now, sk->sk_tsflags only uses 17 bits (see the last one
> >>> SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 flags
> >>> (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With tha=
t
> >>> said, we could reserve the highest four bits for cmsg use for the
> >>> moment. Four bits represents four points where we can record the
> >>> timestamp in the tx case.
> >>>
> >>> Do you agree on this point?
> >>
> >> I don't follow.
> >>
> >> I probably miss the entire point.
> >>
> >> The goal for sockcm fields is to start with the sk field and
> >> optionally override based on cmsg. This is what sockcm_init does for
> >> tsflags.
> >>
> >> This information is for the skb, so these are recording flags.
> >>
> >> Why does the new datapath need to know whether features are enabled
> >> through setsockopt or on a per-call basis with a cmsg?
> >>
> >> The goal was always to keep the reporting flags per socket, but make
> >> the recording flag per packet, mainly for sampling.
> >
> > If a user uses 1) cmsg feature, 2) bpf feature at the same time, we
> > allow each feature to work independently.
> >
> > How could it work? It relies on sk_tstamp_tx_flags() function in the
> > current patch: when we are in __skb_tstamp_tx(), we cannot know which
> > flags in each feature are set without fetching sk->sk_tsflags and
> > sk->sk_tsflags_bpf. Then we are able to know what timestamp we want to
> > record. To put it in a simple way, we're not sure if the user wants to
> > see a SCHED timestamp by using the cmsg feature in __skb_tstamp_tx()
> > if we hit this test statement "skb_shinfo(skb)->tx_flags &
> > SKBTX_SCHED_TSTAMP)". So we need those two socket tsflag fields to
> > help us.
>
> I also don't see how a new bit/integer in a sk can help to tell the per c=
msg
> on/off. This cmsg may have tx timestamp on while the next cmsg can have i=
t off.

It's not hard to use it because we can clear every socket cmsg tsflags
when we're done the check in tcp_sendmsg_locked() if the cmsg feature
is not enabled. Then we can accurately know which timestamp should we
print in the tx path.

>
> There is still one bit in skb_shinfo(skb)->tx_flags. How about define a
> SKBTX_BPF for everything. imo, the fine control on
> SOF_TIMESTAMPING_TX_{SCHED,SOFTWARE} is not useful for bpf. Almost all of=
 the
> time the bpf program wants all available time stamps (sched, software, an=
d
> hwtstamp if the NIC has it).

Sorry, I really doubt that we can lose the fine control. I still
reckon that providing more options to users is a good way to go,
especially for some latency sensitive applications, enabling one or
two or three tx flags could lead to different performances. For the
users of SO_TIMESTAMPING, they use the feature very differently. Not
all users prefer to record everything.

> Since bpf is in the kernel, it is much cheaper
> because it does not need to do skb_alloc/clone and queue to the error que=
ue.
>
> I think the bpf prog needs to capture a timestamp at the sendmsg() time, =
so a
> bpf prog needs to be called at sendmsg().

Agreed, I planned to implement this after this series.

> Then it may as well allow the bpf
> prog@sendmsg() to decide if it needs to set the SKBTX_BPF bit in
> skb_shinfo(skb)->tx_flags or not.
>
> TCP_SKB_CB(skb)->txstamp_ack can also work similarly. There is still unus=
ed bit
> in "struct tcp_skb_cb", so may be adding TCP_SKB_CB(skb)->bpf_txstamp_ack
>
> Then there is no need to control SOF_TIMESTAMPING_TX_* through bpf_setsoc=
kopt().
> It only needs one bpf specific socket option like bpf_setsockopt(SOL_SOCK=
ET,
> BPF_TX_TIMESTAMPING) to guard if the bpf-prog@sendmsg() needs to be calle=
d or
> not. There are already other TCP_BPF_IW,TCP_BPF_SNDCWND_CLAMP,... specifi=
c
> socket options.
>
> imo, this is a simpler interface and also gives the bpf prog per packet c=
ontrol
> at the same time.

Very interesting idea, but the precondition is that we give up the
fine control...

Thanks,
Jason

