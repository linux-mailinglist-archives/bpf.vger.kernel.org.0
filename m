Return-Path: <bpf+bounces-42161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D59A0347
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC5B1C27DCA
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAC1D14E3;
	Wed, 16 Oct 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+hrQnWh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA01B2193;
	Wed, 16 Oct 2024 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065309; cv=none; b=iQ/DsZfQweWekKgjINklkeHe5e2aBAYJ/EQvrFOQKU4cLJIKCQIOKXeAB1TaSxoiK8JjPRyKINyvu1kxM80skU78E96QX3ihxddDO33DgVyfTEEfZRODttyXoq5uwddEflBKLnC2D9bq9n/4mH+jk/RWfcAG95KR4AhR4W7S5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065309; c=relaxed/simple;
	bh=JzQAHU8yO5lgQ72/MlGdgHfxI7MVTV8H9aHa/WfaXfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cx+kE1WD6ibiGs/cMEx3UZk8ZAj5gimdsghY4hqqR959+rPoAMbrW59Sf4HXcmNNqPVnqdmnsNN8S/tdWrBHkV8zpPWDHKnodIu97fkJcO1ypRmvfnH/Ylnsegoool8y+/IO4ZGaeO0gxVSyKmWIxDe6/xWQ5ioJd+NNAAQr7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+hrQnWh; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-835496c8d6fso362470439f.0;
        Wed, 16 Oct 2024 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729065306; x=1729670106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMiQRc4iIxHuL6+J+86stU781d2Z3GirHXo0EgrbofQ=;
        b=Q+hrQnWhbL6e3LtQuPZlPC+mAut7WMJEMHTOQ9SXS46dafImS1ShdRGiB/IBbLYD68
         PDNw35bzz0HIxsLXBPTERkwN2dHlsQJhyt52ATDqFSJBar3/jd2jbhFsNzGjSdEUWv4t
         vmNRYue2/59dN62RuG+SvqSuEpU3gpYJf/6TfCIXh0VVI00//W30RNn1Lo4yZzs9tQnK
         KckhDKoDkYwloC7T9xrLS8H2AOfclSGNBUoizW+8BNasqORw08kIXSBQjYyKwnH/Vs7Z
         44I7rt3R7xvQUYZWwrjoU+5HXgkOA+zXMESFcjEg1QuwrbdoJJw9QbNuGPnwPvRcbGg7
         6E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065306; x=1729670106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMiQRc4iIxHuL6+J+86stU781d2Z3GirHXo0EgrbofQ=;
        b=CmtbMD24HlJRuky/muQLMgJYGrAr6PrKF4foFoyEwKghqLZG3Q9RSNTStNwc5topBB
         Wnb4O9w4PKmYLusXnVcamTC5bsoctO/WGxmlu8/fO2RZc+QfRoaavcUTDiUbAaVWQjZE
         geE33nmFMB4I8Czp6ngZAYqRbeVL46OPTiWAlYppv9ZrUTzy8n9ANsx/7j0+SQVmLaB6
         kf/JkSn/rblP2/uiGljryNr4i8WRGQXDE7Rmrfro60rJl1Q1W7Z0vQpAPrgPq2tbUM79
         VPnALK9rdYnGUN5WOqj6v2TTICyybWzZ+Hb2lJQDbXnmnVWhRPq4uoykbsp9KPo7KeSh
         nHXw==
X-Forwarded-Encrypted: i=1; AJvYcCVi2wYfF7YQlPyPb0iR+w8/XHc0LBvfpJQPOgk7nZOaJ49XGC13eQmt4iS7xmGnRRFcIhg=@vger.kernel.org, AJvYcCWN15IOESGx1PbZ6qiOiyf07KJejGqWTpWXpSPiyke6AkPCSDGQqdEsuLWCgabYNUiPOi2A5lzA@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8kd4EijL1bI+/BhqgjsD3bkeLHwST9MY537Sz67fgIVu/9E8
	1T8DYpIwjjxptAtBeRk/kGsNfNorL+IJRCMqjApnio1V1FD516L+ELZ2NnkolrDaSzxOmZThFw+
	1BjTKtMY2TY3YXDDkK5zgBJYkijc=
X-Google-Smtp-Source: AGHT+IGECrgJZbderygCtHbwOoKb7a20tm5PG/ZGiQiniOq4lFp5OvepiYi1PylzlJulFfh+0VAQTa+BNbMNchKOa9g=
X-Received: by 2002:a05:6e02:152d:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a3bcdfded1mr126208595ab.20.1729065306203; Wed, 16 Oct 2024
 00:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <CAL+tcoBXj=EO-sk-dS+dN-pCZf8OKeOZ4LXb9GZnja3EfOhXYg@mail.gmail.com>
 <9f050a5c-644f-4fbb-ac37-53edfd160edc@linux.dev> <CAL+tcoDyt=3hjwdx8Wk-abKg=qQsY=7UKu9=TU4iUAk5gMT2MQ@mail.gmail.com>
 <5398c020-e9b4-49d2-a5fa-dca047296ddd@linux.dev>
In-Reply-To: <5398c020-e9b4-49d2-a5fa-dca047296ddd@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 15:54:29 +0800
Message-ID: <CAL+tcoDb84bgUUpK9PjijWDt+xw=u2nKkoWf1Gjvkjf--XJ6VA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:01=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/15/24 11:30 PM, Jason Xing wrote:
> > On Wed, Oct 16, 2024 at 2:13=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 10/15/24 6:32 PM, Jason Xing wrote:
> >>> On Wed, Oct 16, 2024 at 9:04=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> >>>>
> >>>> On Wed, Oct 16, 2024 at 8:10=E2=80=AFAM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> >>>>>
> >>>>> On 10/11/24 9:06 PM, Jason Xing wrote:
> >>>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>>
> >>>>>> Willem suggested that we use a static key to control. The advantag=
e
> >>>>>> is that we will not affect the existing applications at all if we
> >>>>>> don't load BPF program.
> >>>>>>
> >>>>>> In this patch, except the static key, I also add one logic that is
> >>>>>> used to test if the socket has enabled its tsflags in order to
> >>>>>> support bpf logic to allow both cases to happen at the same time.
> >>>>>> Or else, the skb carring related timestamp flag doesn't know which
> >>>>>> way of printing is desirable.
> >>>>>>
> >>>>>> One thing important is this patch allows print from both applicati=
ons
> >>>>>> and bpf program at the same time. Now we have three kinds of print=
:
> >>>>>> 1) only BPF program prints
> >>>>>> 2) only application program prints
> >>>>>> 3) both can print without side effect
> >>>>>>
> >>>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>>>>> ---
> >>>>>>     include/net/sock.h |  1 +
> >>>>>>     net/core/filter.c  |  3 +++
> >>>>>>     net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
> >>>>>>     3 files changed, 42 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/net/sock.h b/include/net/sock.h
> >>>>>> index 66ecd78f1dfe..b7c51b95c92d 100644
> >>>>>> --- a/include/net/sock.h
> >>>>>> +++ b/include/net/sock.h
> >>>>>> @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(stru=
ct sock *sk, int dif)
> >>>>>>     void sock_def_readable(struct sock *sk);
> >>>>>>
> >>>>>>     int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_s=
k);
> >>>>>> +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >>>>>>     void sock_set_timestamp(struct sock *sk, int optname, bool val=
bool);
> >>>>>>     int sock_get_timestamping(struct so_timestamping *timestamping=
,
> >>>>>>                           sockptr_t optval, unsigned int optlen);
> >>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>>>> index 996426095bd9..08135f538c99 100644
> >>>>>> --- a/net/core/filter.c
> >>>>>> +++ b/net/core/filter.c
> >>>>>> @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_s=
ocket_uid_proto =3D {
> >>>>>>         .arg1_type      =3D ARG_PTR_TO_CTX,
> >>>>>>     };
> >>>>>>
> >>>>>> +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >>>>>> +
> >>>>>>     static int bpf_sock_set_timestamping(struct sock *sk,
> >>>>>>                                      struct so_timestamping *times=
tamping)
> >>>>>>     {
> >>>>>> @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct =
sock *sk,
> >>>>>>                 return -EINVAL;
> >>>>>>
> >>>>>>         WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> >>>>>> +     static_branch_enable(&bpf_tstamp_control);
> >>>>>
> >>>>> Not sure when is a good time to do static_branch_disable().
> >>>>
> >>>> Thanks for the review.
> >>>>
> >>>> To be honest, I considered how to disable the static key. Like you
> >>>> said, I failed to find a good chance that I can accurately disable i=
t.
> >>>>
> >>>>>
> >>>>> The bpf prog may be detached also. (IF) it ends up staying with the
> >>>>> cgroup/sockops interface, it should depend on the existing static k=
ey in
> >>>>> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.
> >>>>
> >>>> Are you suggesting that we need to remove the current static key? In
> >>>> the previous thread, the reason why Willem came up with this idea is=
,
> >>>> I think, to avoid affect the non-bpf timestamping feature.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>         return 0;
> >>>>>>     }
> >>>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>>>>> index f36eb9daa31a..d0f912f1ff7b 100644
> >>>>>> --- a/net/core/skbuff.c
> >>>>>> +++ b/net/core/skbuff.c
> >>>>>> @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_bu=
ff *skb,
> >>>>>>     }
> >>>>>>     EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >>>>>>
> >>>>>> +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int =
tstype)
> >>>>>
> >>>>> sk is unused.
> >>>>
> >>>> Thanks for the careful check.
> >>>>
> >>>>>
> >>>>>> +{
> >>>>>> +     u32 testflag;
> >>>>>> +
> >>>>>> +     switch (tstype) {
> >>>>>> +     case SCM_TSTAMP_SCHED:
> >>>>>
> >>>>> Instead of doing this translation,
> >>>>> is it easier to directly store the bpf prog desired ts"type" (i.e. =
the
> >>>>> SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
> >>>>> or there is a specific need to keep the SOF_TIMESTAMPING_* value in
> >>>>> sk->sk_tsflags_bpf?
> >>>>
> >>>> We have to reuse SOF_TIMESTAMPING_* because there are more flags, sa=
y,
> >>>> SOF_TIMESTAMPING_OPT_ID, that we need to support.
> >>>>
> >>>>>
> >>>>>> +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> >>>>>> +             break;
> >>>>>> +     case SCM_TSTAMP_SND:
> >>>>>> +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> >>>>>> +             break;
> >>>>>> +     case SCM_TSTAMP_ACK:
> >>>>>> +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> >>>>>> +             break;
> >>>>>> +     default:
> >>>>>> +             return false;
> >>>>>> +     }
> >>>>>> +     if (tsflags & testflag)
> >>>>>> +             return true;
> >>>>>> +
> >>>>>> +     return false;
> >>>>>> +}
> >>>>>> +
> >>>>>>     static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> >>>>>>                                  const struct sk_buff *ack_skb,
> >>>>>>                                  struct skb_shared_hwtstamps *hwts=
tamps,
> >>>>>> @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_b=
uff *orig_skb,
> >>>>>>         if (!skb_may_tx_timestamp(sk, tsonly))
> >>>>>>                 return;
> >>>>>>
> >>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> >>>>>
> >>>>> This is a new test. tsflags is the sk->sk_tsflags here if I read it=
 correctly.
> >>>>
> >>>> This test will be used in bpf and non-bpf cases. Because of this, we
> >>>> can support BPF extension. In this function, if skb has tsflags but =
we
> >>>> don't know which approach the user expects, sk_tstamp_tx_flags() can
> >>>> help us.
> >>>>
> >>>>>
> >>>>> My understanding is the sendmsg can provide SOF_TIMESTAMPING_* for =
individual
> >>>>> skb. Would it break?
> >>>>
> >>>> Oh, you're right. I didn't support cmsg mode...
> >>>
> >>> I think I only need to test if it's in the bpf mode, or else let the
> >>> original way print the timestamp, which can solve the issue.
> >>
> >>   From looking at the existing "__skb_tstamp_tx(skb, NULL, NULL, skb->=
sk,
> >> SCM_TSTAMP_SCHED);":
> >>
> >> int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> >> {
> >>          /* ... */
> >>
> >>          if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> >>                  __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_=
SCHED);
> >>
> >>          /* ... */
> >> }
> >>
> >> I am still puzzling how __skb_tstamp_tx() will be called if only bpf h=
as enabled
> >> the timestamping. I may have missed somewhere in the patch set that th=
e skb's
> >> tx_flags is changed by sk->sk_tsflags_bpf alone?
> >
> > If sk_tsflags_bpf is set, tcp_sendmsg() -> tcp_tx_timestamp() will be
> > helpful, which initializes every last skb, please see patch [10/12].
>
> Ah. ok. It is the thing I missed. Thanks for the pointer.
>
> >>
> >> I think a skb tskey is still desired (?), so eventually we want some s=
paces in
> >
> > tskey function is optional I think. It depends whether users want to
> > use it or not. It can controlled by SOF_TIMESTAMPING_OPT_ID flag.
> >
> >> the skb for bpf. Jakub Sitnicki (cc-ed) has presented in LPC about ext=
ending
> >> skb->data_meta usage outside of xdp and tc. I think here we want to ha=
ve it
> >> available at the tx side to store the tx_flags and tskey but probably =
want them
> >> at a specific place/offset at the data_meta.
> >
> > If we have the plan to store extra information in data_meta, I can
> > give it a try:)
> >
> >>
> >> For now, is there thing we can explore to share in the skb_shared_info=
?
> >
> > My initial thought is just to reuse these fields in skb. It can work
> > without interfering one another.
>
> After reading closer to patch 10, I am likely still missing something. Ho=
w can
> it tell if the tx_flags is set by the bpf or by the user space cmsg?

If the skb carries the timestamp, there are three cases:
1) non-bpf case and users uses setsockopt()
2) cmsg case
3) bpf case

#1 and #2 are already handled well before this patch. I only need to
test if sk_tsflags_bpf has those flags. If so, it means we hit #3, or
else it could be #1 or #2, then we will let the old way print
timestamps in __skb_tstamp_tx().

>
> >
> >> Can the "struct skb_shared_hwtstamps hwtstamps;" be used for the bpf t=
x_flags and tskey
> >> only at the "tx" side? There is already another union member.
> >
> > tskey is always used in the tx path.
> >
> > hwtstamps can be used in both rx and tx cases (please see
> > tcp_update_recv_tstamps() and skb_tstamp_tx()).
>
> hmm... we only need some where to store the bpf tx_flags and bpf tskey in=
 the
> TX-ing skb.

And there is one more field we have to take care of: txstamp_ack which
indicates whether we print timestamp when the last skb is acked.
Please see tcp_tx_timestamp().

> You meant the hwtstamps of a Tx-ing skb is not empty?

Sometimes, it's not empty if the hardware supports the timestamp
feature and the user wants to see it (by enabling the
SOF_TIMESTAMPING_TX_HARDWARE flag). As we can see, there are many
callers calling skb_tstamp_tx().

>
> At skb_tstamp_tx (TX side only?), the orig_skb's hwtstamps has not been w=
ritten yet?

I'm not that sure about the orig_skb. It seems no. I can see some
callers reading ptp timestamp from the nic and pass the timestamp to
skb_tstamp_tx().

Thanks,
Jason

