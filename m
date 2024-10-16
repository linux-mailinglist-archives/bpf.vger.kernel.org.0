Return-Path: <bpf+bounces-42149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C179A0172
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9EC286A59
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DEB18DF7A;
	Wed, 16 Oct 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0p1J/4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21D171E70;
	Wed, 16 Oct 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060276; cv=none; b=FXAaImmvjIerdt2GPJudmCb5aXmpMwjOfNKmZ/OL2Eefc3uX2TlfN+N3jLllevZm+tTeKLPpNcxlJjA4AMuHpGfFGpB0lq8thNeYJwuwPV6UNSVo0h5jsu/hI7GOAdW3xQYYymgd463toaCP1iFHvKo/CVYZahUSfFkVe6xDto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060276; c=relaxed/simple;
	bh=TlXS6vjXv1nK17cq2d6MC7IX2qyKdx/eRi7nsFHUWcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6LtX2RVfBA565EybevZbnL4yDpXzEwyjvSGsl+pWd53nELSZgYZkF2fp8ShR+/+T2OzDBDACgQzMfy0EbF8Zz7MpuWGWMtBbPb8WtjimmYDSpWX4VjOtDoZFgz784NHyQihLKGEy4wFyrUCCLhj/wAkeU9hB4omNt7Bun6aRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0p1J/4E; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3bb6a020dso15753815ab.2;
        Tue, 15 Oct 2024 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729060274; x=1729665074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmICqce8YacIKBFZ7MQPbbF88fWYG35+PSduGGP7GYI=;
        b=H0p1J/4EsJf7jSFd924yNAAcCr8EKbca9KodAxefd0tbhYdFoAC8GgCepYuQAPZ1/i
         XGW/r8jh65N4DD3RRbEUM4DVtSzD0LNoj3AUWitmAH4h82lBGegxIWp8KC8CZemyDpOt
         bgUl7hAcCciPHLMzxPQPYhc9dOMqgSBMwc31y7f4PRF+NNXkn/qT3rjWoYfAy/nNUCJf
         fYJxMRmUX6NfMMGy1FwTgN6st56LaarsCJ8LIk4cvdFmzlkrKqh4whUQ1ZHgdfuJg5Fh
         Ib/Xi8ELXqGPoofh53w1MMV21f5xwJ3bv050feMEbo56Pu1ne3LG6JebViJpQ659Nkth
         mDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729060274; x=1729665074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmICqce8YacIKBFZ7MQPbbF88fWYG35+PSduGGP7GYI=;
        b=jra2JyCy0osbYve8rMpQHOmwGy8NsqsL5Nld8mZ4c2atHMMa3GS0BglgPGtXaM8TEh
         kl14eP4K6t6SZX6AlSrYuUjgwJyJFCa0HBhxyF4beGzEheIAe2h+MSKHl7W/WycQPxg7
         8fvNQQin0pjs8XTk+j/gptBhmUvd7jfpJfi+60Y+FxKTC1y+TF4tLnYXV3GD5SL2fmF0
         cw5gatcPTR0RRxJrjb4VQ/ubXDDyJNE23FX7fBm6swZMYvCid/dcmV2RNzv3eZ4kvWs3
         Hyn3LEzhUhY1ep1d60wpJXcEHNtakL9Cwwy/n1y2nmdafA90M+qnnioT8FwMmtxlqk0G
         oI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUndhoZgRN7qBd9KgWo4AnWbwHigctuJ37+dz1ZBa4UiSgyFiJ27WSEFgoprD7FFD18kHA=@vger.kernel.org, AJvYcCW2sgyiMjBFl72ljz0LcXHtL92mWSDUpWWWD54bxzL+VnEmA5SJ//Kt5aff+GEocM6WV74LSh5H@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3uHLbYEklTuEIFvPlPtgjzpQypbZWeW9ii8m808nP/Qa6/TQ
	vs6hCmrLAz/taDskAJv32voelUSr45jUH5rkVzEPuLWKsH2GpgDvO5Jv8r93qYLn1A7sDesp/jU
	fqJsYNhtAwSbLm7Ljq42XiijcwD0=
X-Google-Smtp-Source: AGHT+IE8BWjYxsUztdvn85HFhNsSgopePiItoRqry9aNE5XdGKK+pfpxUm8xu3NwFlzcS5Q1Vm9I35b6B11J2Ph06JQ=
X-Received: by 2002:a05:6e02:188e:b0:3a3:afa3:5155 with SMTP id
 e9e14a558f8ab-3a3b6050e70mr160288475ab.25.1729060273998; Tue, 15 Oct 2024
 23:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <CAL+tcoBXj=EO-sk-dS+dN-pCZf8OKeOZ4LXb9GZnja3EfOhXYg@mail.gmail.com> <9f050a5c-644f-4fbb-ac37-53edfd160edc@linux.dev>
In-Reply-To: <9f050a5c-644f-4fbb-ac37-53edfd160edc@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 14:30:37 +0800
Message-ID: <CAL+tcoDyt=3hjwdx8Wk-abKg=qQsY=7UKu9=TU4iUAk5gMT2MQ@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 2:13=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/15/24 6:32 PM, Jason Xing wrote:
> > On Wed, Oct 16, 2024 at 9:04=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> On Wed, Oct 16, 2024 at 8:10=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>>
> >>> On 10/11/24 9:06 PM, Jason Xing wrote:
> >>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>
> >>>> Willem suggested that we use a static key to control. The advantage
> >>>> is that we will not affect the existing applications at all if we
> >>>> don't load BPF program.
> >>>>
> >>>> In this patch, except the static key, I also add one logic that is
> >>>> used to test if the socket has enabled its tsflags in order to
> >>>> support bpf logic to allow both cases to happen at the same time.
> >>>> Or else, the skb carring related timestamp flag doesn't know which
> >>>> way of printing is desirable.
> >>>>
> >>>> One thing important is this patch allows print from both application=
s
> >>>> and bpf program at the same time. Now we have three kinds of print:
> >>>> 1) only BPF program prints
> >>>> 2) only application program prints
> >>>> 3) both can print without side effect
> >>>>
> >>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>>> ---
> >>>>    include/net/sock.h |  1 +
> >>>>    net/core/filter.c  |  3 +++
> >>>>    net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
> >>>>    3 files changed, 42 insertions(+)
> >>>>
> >>>> diff --git a/include/net/sock.h b/include/net/sock.h
> >>>> index 66ecd78f1dfe..b7c51b95c92d 100644
> >>>> --- a/include/net/sock.h
> >>>> +++ b/include/net/sock.h
> >>>> @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(struct=
 sock *sk, int dif)
> >>>>    void sock_def_readable(struct sock *sk);
> >>>>
> >>>>    int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
> >>>> +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >>>>    void sock_set_timestamp(struct sock *sk, int optname, bool valboo=
l);
> >>>>    int sock_get_timestamping(struct so_timestamping *timestamping,
> >>>>                          sockptr_t optval, unsigned int optlen);
> >>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>> index 996426095bd9..08135f538c99 100644
> >>>> --- a/net/core/filter.c
> >>>> +++ b/net/core/filter.c
> >>>> @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_soc=
ket_uid_proto =3D {
> >>>>        .arg1_type      =3D ARG_PTR_TO_CTX,
> >>>>    };
> >>>>
> >>>> +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >>>> +
> >>>>    static int bpf_sock_set_timestamping(struct sock *sk,
> >>>>                                     struct so_timestamping *timestam=
ping)
> >>>>    {
> >>>> @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct so=
ck *sk,
> >>>>                return -EINVAL;
> >>>>
> >>>>        WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> >>>> +     static_branch_enable(&bpf_tstamp_control);
> >>>
> >>> Not sure when is a good time to do static_branch_disable().
> >>
> >> Thanks for the review.
> >>
> >> To be honest, I considered how to disable the static key. Like you
> >> said, I failed to find a good chance that I can accurately disable it.
> >>
> >>>
> >>> The bpf prog may be detached also. (IF) it ends up staying with the
> >>> cgroup/sockops interface, it should depend on the existing static key=
 in
> >>> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.
> >>
> >> Are you suggesting that we need to remove the current static key? In
> >> the previous thread, the reason why Willem came up with this idea is,
> >> I think, to avoid affect the non-bpf timestamping feature.
> >>
> >>>
> >>>>
> >>>>        return 0;
> >>>>    }
> >>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>>> index f36eb9daa31a..d0f912f1ff7b 100644
> >>>> --- a/net/core/skbuff.c
> >>>> +++ b/net/core/skbuff.c
> >>>> @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_buff=
 *skb,
> >>>>    }
> >>>>    EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >>>>
> >>>> +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int ts=
type)
> >>>
> >>> sk is unused.
> >>
> >> Thanks for the careful check.
> >>
> >>>
> >>>> +{
> >>>> +     u32 testflag;
> >>>> +
> >>>> +     switch (tstype) {
> >>>> +     case SCM_TSTAMP_SCHED:
> >>>
> >>> Instead of doing this translation,
> >>> is it easier to directly store the bpf prog desired ts"type" (i.e. th=
e
> >>> SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
> >>> or there is a specific need to keep the SOF_TIMESTAMPING_* value in
> >>> sk->sk_tsflags_bpf?
> >>
> >> We have to reuse SOF_TIMESTAMPING_* because there are more flags, say,
> >> SOF_TIMESTAMPING_OPT_ID, that we need to support.
> >>
> >>>
> >>>> +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> >>>> +             break;
> >>>> +     case SCM_TSTAMP_SND:
> >>>> +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> >>>> +             break;
> >>>> +     case SCM_TSTAMP_ACK:
> >>>> +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> >>>> +             break;
> >>>> +     default:
> >>>> +             return false;
> >>>> +     }
> >>>> +     if (tsflags & testflag)
> >>>> +             return true;
> >>>> +
> >>>> +     return false;
> >>>> +}
> >>>> +
> >>>>    static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> >>>>                                 const struct sk_buff *ack_skb,
> >>>>                                 struct skb_shared_hwtstamps *hwtstam=
ps,
> >>>> @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_buf=
f *orig_skb,
> >>>>        if (!skb_may_tx_timestamp(sk, tsonly))
> >>>>                return;
> >>>>
> >>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> >>>
> >>> This is a new test. tsflags is the sk->sk_tsflags here if I read it c=
orrectly.
> >>
> >> This test will be used in bpf and non-bpf cases. Because of this, we
> >> can support BPF extension. In this function, if skb has tsflags but we
> >> don't know which approach the user expects, sk_tstamp_tx_flags() can
> >> help us.
> >>
> >>>
> >>> My understanding is the sendmsg can provide SOF_TIMESTAMPING_* for in=
dividual
> >>> skb. Would it break?
> >>
> >> Oh, you're right. I didn't support cmsg mode...
> >
> > I think I only need to test if it's in the bpf mode, or else let the
> > original way print the timestamp, which can solve the issue.
>
>  From looking at the existing "__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> SCM_TSTAMP_SCHED);":
>
> int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> {
>         /* ... */
>
>         if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
>                 __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHE=
D);
>
>         /* ... */
> }
>
> I am still puzzling how __skb_tstamp_tx() will be called if only bpf has =
enabled
> the timestamping. I may have missed somewhere in the patch set that the s=
kb's
> tx_flags is changed by sk->sk_tsflags_bpf alone?

If sk_tsflags_bpf is set, tcp_sendmsg() -> tcp_tx_timestamp() will be
helpful, which initializes every last skb, please see patch [10/12].

>
> I think a skb tskey is still desired (?), so eventually we want some spac=
es in

tskey function is optional I think. It depends whether users want to
use it or not. It can controlled by SOF_TIMESTAMPING_OPT_ID flag.

> the skb for bpf. Jakub Sitnicki (cc-ed) has presented in LPC about extend=
ing
> skb->data_meta usage outside of xdp and tc. I think here we want to have =
it
> available at the tx side to store the tx_flags and tskey but probably wan=
t them
> at a specific place/offset at the data_meta.

If we have the plan to store extra information in data_meta, I can
give it a try:)

>
> For now, is there thing we can explore to share in the skb_shared_info?

My initial thought is just to reuse these fields in skb. It can work
without interfering one another.

> Can the "struct skb_shared_hwtstamps hwtstamps;" be used for the bpf tx_f=
lags and tskey
> only at the "tx" side? There is already another union member.

tskey is always used in the tx path.

hwtstamps can be used in both rx and tx cases (please see
tcp_update_recv_tstamps() and skb_tstamp_tx()).

> The hwtstamps should only be needed when the NIC is done sending?

In this patch, yes, hwtstamps are the records in tx path.

Thanks,
Jason

