Return-Path: <bpf+bounces-43367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC509B4090
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 03:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5801F231E7
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFA1F429A;
	Tue, 29 Oct 2024 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVTUrfei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281651F4265;
	Tue, 29 Oct 2024 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169710; cv=none; b=Gk9kPwWoQb2B9jJ8DsKGE+g4BPoRo2J7IxzO1c947TSjJKyCMR0S4H50aX5/uAqOuL0+B/hIv2uykX1eLYZBckRL+x8uJCnYRJqS4LmKal9Ij8J0n0lqC9XaMYyfzO/LmsIyliC/gwHdd7mLJN2lsbICMULBpUYS0RLuEAkUT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169710; c=relaxed/simple;
	bh=bWI0EYgRIpMHAQc9qhO5asqU+abRbM6HV5MtYp3zauo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqY9Bdhji7E7auIX8/4xFc+H9zonwsZbOfu76TElaSpZPuF8YJxrh5rG+XgvYLACnRq5Vb2xsVIRvzDCRbaN9lGEDVENgFMIoSanPpGe2+y9DczyqTvqo16vD6qUNiLuFDWCTuAOvklIN9Il7VCrZ797sx/glpVjD4ieaPePIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVTUrfei; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a4d1633df9so17455285ab.2;
        Mon, 28 Oct 2024 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730169707; x=1730774507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrX1x1NFKvKNx+uSJZbGmjNLKvbR52L99hom0eDRGsU=;
        b=iVTUrfeiNyQOraQkXNydtTox8yT2iELBIhHoODdBD+qSDrNMr9MgQS/cSGziU6zjs3
         eIXzjmg4/wgyuLzrcmQzLMKOp4ZdTLv69O9APRZ/WfxGSojWI04K7eUEQnrT6E9fkYYn
         RDcIGzzmVrCbZjbaIQ4AttHyu08j6S2rhPOMxfxYtteY4g7T4imvFZYXYlk+cA5J8Msx
         c4wK+dGf1LqOeTBamsrDk/4ZdxuwpAl/14Y+aNpSAIeINFAqpUzX0mRVlR7ley8BOMYN
         8BHkiFSNfpNV5lIXcu44vfS72unsPM+XweACqFRHeyS032kqJ83GfOMYiaVol7qFAYVX
         Ufqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169707; x=1730774507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrX1x1NFKvKNx+uSJZbGmjNLKvbR52L99hom0eDRGsU=;
        b=JYEBz8GY3+SoUQZqk/nqklvpqjUhe23QsdvzPMXx+9NcppCOHEHXHVfuls2gHxQD+I
         mIP9Z6WZ4H7ffivdG6iDFksS2t3YFK+c5uizYigPx+i8d4jgcInLhh7oqcKAX2LRurrq
         5iRD1FGggLTBJh4sR6mi4XjlXWaznswoRdVr+/yBNINHBIcOuEiuue4hoYCpOwmb6aQv
         AKXKvMI1jfyKDruA536Ve9YikTrcYRCacA+5BI5xt5bsnfkEgXT8s1KUnympTexYLiuu
         jVKxLuuSWp1uD4sddM5nnwRsEiXaHG1yGkyu9TSDWPIkoAo2WDRF3tt8LGOpXvY8DmEW
         n+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUoqYJpSCa4BvQZVw+xmfXDbsbO/HTx1TB7ZSbUXuR8Lp4MYdN8UtB0qn3ueeNkxyEFl8g=@vger.kernel.org, AJvYcCWGXZVqJrwq4u/gnnvZjXqD1AiKyU6RbLZ/zjvF4g6qwkxE9xX6etTCpm2MNRM1nJHrWCYlJLft@vger.kernel.org
X-Gm-Message-State: AOJu0YyremPrngMhxlAx51H6mevaMosmf37dwrBIqcCYv74OGINMH2nG
	4Sc1h+1NPB4/Rv/32Jp/Joef4iOqOg5OjMTeKpoUhu7snWd1l0V7WaCaImO6jTATRZT2roHBTYb
	J/HmfJHFjsU9alba3tj8xzEiwiAo=
X-Google-Smtp-Source: AGHT+IFsp7JCA3NEtFpW74WWqZyte33lxsAs2ULNhpUBNHY1jBO96fE9rUqAccqdR2a1xTGYUSt+r3Sg9L0tQEcgMp0=
X-Received: by 2002:a92:cdac:0:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a4ed29bf3bmr82683545ab.7.1730169707041; Mon, 28 Oct 2024
 19:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 10:41:10 +0800
Message-ID: <CAL+tcoBgbA1Q_7UaC0vp-mGHqDHxQ+eMybep0kw=E-T0oJAHfw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
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

On Tue, Oct 29, 2024 at 9:24=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Use the offset to record the delta value between current socket key
> > and bpf socket key.
> >
> > 1. If there is only bpf feature running, the socket key is bpf socket
> > key and the offset is zero;
> > 2. If there is only traditional feature running, and then bpf feature
> > is turned on, the socket key is still used by the former while the offs=
et
> > is the delta between them;
> > 3. if there is only bpf feature running, and then application uses it,
> > the socket key would be re-init for application and the offset is the
> > delta.
>
> We need to also figure out the rare conflict when one user sets
> OPT_ID | OPT_ID_TCP while the other only uses OPT_ID.

I think the current patch handles the case because:
1. sock_calculate_tskey_offset() gets the final key first whether the
OPT_ID_TCP is set or not.
2. we will use that tskey to calculate the delta.

>
> It is so obscure, that perhaps we can punt and say that the BPF
> program just has to follow the application preference and be aware of
> the subtle difference.

Right.

>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/sock.h |  1 +
> >  net/core/skbuff.c  | 15 ++++++++---
> >  net/core/sock.c    | 66 ++++++++++++++++++++++++++++++++++++++--------
> >  3 files changed, 68 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 91398b20a4a3..41c6c6f78e55 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -469,6 +469,7 @@ struct sock {
> >       unsigned long           sk_pacing_rate; /* bytes per second */
> >       atomic_t                sk_zckey;
> >       atomic_t                sk_tskey;
> > +     u32                     sk_tskey_bpf_offset;
> >       __cacheline_group_end(sock_write_tx);
> >
> >       __cacheline_group_begin(sock_read_tx);
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 0b571306f7ea..d1739317b97d 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5641,9 +5641,10 @@ void timestamp_call_bpf(struct sock *sk, int op,=
 u32 nargs, u32 *args)
> >  }
> >
> >  static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
> > +                                  struct sk_buff *skb,
> >                                    struct skb_shared_hwtstamps *hwtstam=
ps)
> >  {
> > -     u32 args[2] =3D {0, 0};
> > +     u32 args[3] =3D {0, 0, 0};
> >       u32 tsflags, cb_flag;
> >
> >       tsflags =3D READ_ONCE(sk->sk_tsflags_bpf);
> > @@ -5672,7 +5673,15 @@ static void skb_tstamp_tx_output_bpf(struct sock=
 *sk, int tstype,
> >               args[1] =3D ts.tv_nsec;
> >       }
> >
> > -     timestamp_call_bpf(sk, cb_flag, 2, args);
> > +     if (tsflags & SOF_TIMESTAMPING_OPT_ID) {
> > +             args[2] =3D skb_shinfo(skb)->tskey;
> > +             if (sk_is_tcp(sk))
> > +                     args[2] -=3D atomic_read(&sk->sk_tskey);
> > +             if (sk->sk_tskey_bpf_offset)
> > +                     args[2] +=3D sk->sk_tskey_bpf_offset;
> > +     }
> > +
> > +     timestamp_call_bpf(sk, cb_flag, 3, args);
>
>
> So the BPF interface is effectively OPT_TSONLY: the packet data is
> never shared.
>
> Then OPT_ID should be mandatory, because it without it the data is
> not actionable: which byte in the bytestream or packet in the case
> of datagram sockets does a callback refer to.

It does make sense, I think I will implement it when bpf_setsockopt() is ca=
lled.

>
> > +/* Used to track the tskey for bpf extension
> > + *
> > + * @sk_tskey: bpf extension can use it only when no application uses.
> > + *            Application can use it directly regardless of bpf extens=
ion.
> > + *
> > + * There are three strategies:
> > + * 1) If we've already set through setsockopt() and here we're going t=
o set
> > + *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey and =
will
> > + *    keep the record of delta between the current "key" and previous =
key.
> > + * 2) If we've already set through bpf_setsockopt() and here we're goi=
ng to
> > + *    set for application use, we will record the delta first and then
> > + *    override/initialize the @sk_tskey.
> > + * 3) other cases, which means only either of them takes effect, so in=
itialize
> > + *    everything simplely.
> > + */
>
> Please explain in the commit message that these gymnastics are needed
> because there can only be one tskey in skb_shared_info.

No problem.

>
> > +static long int sock_calculate_tskey_offset(struct sock *sk, int val, =
int bpf_type)
> > +{
> > +     u32 tskey;
> > +
> > +     if (sk_is_tcp(sk)) {
> > +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> > +                     return -EINVAL;
> > +
> > +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > +                     tskey =3D tcp_sk(sk)->write_seq;
> > +             else
> > +                     tskey =3D tcp_sk(sk)->snd_una;
> > +     } else {
> > +             tskey =3D 0;
> > +     }
> > +
> > +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&sk->sk_t=
skey);
> > +             return 0;
> > +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_OP=
T_ID)) {
> > +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_tskey) - =
tskey;
> > +     } else {
> > +             sk->sk_tskey_bpf_offset =3D 0;
> > +     }
> > +
> > +     return tskey;
> > +}
> > +
> >  int sock_set_tskey(struct sock *sk, int val, int bpf_type)
> >  {
> >       u32 tsflags =3D bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflags;
> > @@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int val, int =
bpf_type)
> >
> >       if (val & SOF_TIMESTAMPING_OPT_ID &&
> >           !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > -             if (sk_is_tcp(sk)) {
> > -                     if ((1 << sk->sk_state) &
> > -                         (TCPF_CLOSE | TCPF_LISTEN))
> > -                             return -EINVAL;
> > -                     if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)->wri=
te_seq);
> > -                     else
> > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd=
_una);
> > -             } else {
> > -                     atomic_set(&sk->sk_tskey, 0);
> > -             }
> > +             long int ret;
> > +
> > +             ret =3D sock_calculate_tskey_offset(sk, val, bpf_type);
> > +             if (ret <=3D 0)
> > +                     return ret;
> > +
> > +             atomic_set(&sk->sk_tskey, ret);
> >       }
> >
> >       return 0;
> > @@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(struct sock =
*sk,
> >                                    struct so_timestamping timestamping)
> >  {
> >       u32 flags =3D timestamping.flags;
> > +     int ret;
> >
> >       if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> >               return -EINVAL;
> >
> > +     ret =3D sock_set_tskey(sk, flags, 1);
> > +     if (ret)
> > +             return ret;
> > +
> >       WRITE_ONCE(sk->sk_tsflags_bpf, flags);
> >
> >       return 0;
>
> I'm a bit hazy on when this can be called. We can assume that this new
> BPF operation cannot race with the existing setsockopt nor with the
> datapath that might touch the atomic fields, right?

It surely can race with the existing setsockopt.

1)
if (only existing setsockopt works) {
        then sk->sk_tskey is set through setsockopt, sk_tskey_bpf_offset is=
 0.
}

2)
if (only bpf setsockopt works) {
        then sk->sk_tskey is set through bpf_setsockopt,
sk_tskey_bpf_offset is 0.
}

3)
if (existing setsockopt already started, here we enable the bpf feature) {
        then sk->sk_tskey will not change, but the sk_tskey_bpf_offset
will be calculated.
}

4)
if (bpf setsockopt already started, here we enable the application feature)=
 {
        then sk->sk_tskey will re-initialized/overridden by
setsockopt, and the sk_tskey_bpf_offset will be calculated.
}

Then the skb tskey will use the sk->sk_tskey like before.

At last, when we are about to print in bpf extension if we're allowed
(by testing the sk_tsflags_bpf), we only need to check if
sk_tskey_bpf_offset is zero or not. If the value is zero, it means
only the bpf program runs; if not, it means the sk->sk_tskey servers
for application feature, we need to compute the real bpf tskey. Please
see skb_tstamp_tx_output_bpf().

Above makes sure that two features can work parallelly. It's honestly
a little bit complicated. Before writing this part, I drew a few
pictures to help me understand how it works.

Thanks,
Jason

