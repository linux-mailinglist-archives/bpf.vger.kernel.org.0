Return-Path: <bpf+bounces-48885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24EA11623
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0863A883E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3EA1863E;
	Wed, 15 Jan 2025 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7wy68OY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A733C0B;
	Wed, 15 Jan 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901474; cv=none; b=ouVm2tgfBsGP3OV7K+GiE/NSMDLapGu3QXYhtFd6tnEB6KBMqkXpWLakP9LccmOJ+VtOtzEg6p2DhjE6a95kDYogTSZ4Peki8Aaue7fkHuAbFjFdrL9jkHH4slbSYWZkr/0sNt1AQKhLIqocCIzi7CwVKiBLQkz9D3/Djaalkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901474; c=relaxed/simple;
	bh=Qulw3CFoq5Fsbg2KeUGtK2p3dSL7jyU0URrtVWHhQmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evtyHZE68fE9UWT0MgWo3sQlCT34iJKpIkedfs/x/vT2GvvnWEXnkkXKYpq2yk1i9c10Z1VN7HvLv5i9eAi4BeBpBPdsXgBMilRPIEcSLRQOv/JL9U+bo8RoPflF89a+y0G1lcYyxvSaFDP90ucBraNuUVnThGu2iN/2ijLBD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7wy68OY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a8165cfae8so18218055ab.0;
        Tue, 14 Jan 2025 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736901472; x=1737506272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrEU9tjCkadjgJx7/vPvOuWacoeQVTFxN8w9rHV3HkE=;
        b=i7wy68OYA4QLrfcObpxszfy7XoZE4gVuUx7B39etLbUyN6IPwg2ZpAMf+a/mJ4kCgH
         KR2KCIjVC3YvV3enbDF/yoO/CwZdsTHlGCtATbMNN0FNVUjibjMP/HwJq+X8OhScWuEK
         cDt0PxKCmLUdPo4Eor/V4mlWU5m7jezqC0TV6o4D10Cgjglr/0s1Hu9jlLC0vrXAX8gF
         eg/k6s/IG0SPLepsDS27SM76A+fZCiMHzAbA1gXgKz+SxI4J9OdjFDy/uIU7/wctr7PS
         qsQRxEymWIx7kpCk7RXFNH1skyEb+cYlsCcxZnH4xencvvlszl+CfFxWKibKoeJhkaIV
         ctmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736901472; x=1737506272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrEU9tjCkadjgJx7/vPvOuWacoeQVTFxN8w9rHV3HkE=;
        b=vZJyxOBEeNncjJ2P37YZgePIwmhEzAXfdSeC4bRfzRIzZDx3E2wx/eh+m21oBe3At6
         xaVk8sFp9gecnMk0Ai9bxDTvNlA0I03Tqczjw1fTX69S4gH0+TKzr7V9wm5PEyw0WI/7
         PXEhuEdniE3K1KEpJSkH11amJffJBzYsv5uam8bsx/oS/iGgYlGjGxv72X9s3P3yslOu
         EogzUVtxBIb/b2Kwc4BzyyoFHtciIQsK23NPxbaQKTAwfw854STP3KCdD4P/XcAM9NZv
         cfTTSK2HAvjw0qspA6t6PDebfYEQm7NsTiQfDjSSpqHRDVEjJ0puOVmOuheur5XFlZ7d
         i7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaQAjeqyeXuN7fWKvlKzq+e1mfnvgogYHj20U0rWzrtrWHvwfcyX8E8KBNEZ95s1SCvgUYlOn5@vger.kernel.org, AJvYcCXpbDF8iLas6ym2ogaiaGZPZBP2e8/Akys5UYALcZRhtLiviUdUnj/HZKhltsIZWsyUR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhSvqluLUlJng9mURm6GvdTcw0ROkXEuzjrmYOntGvIylCxxl
	+n0mAAhOoNZkqmYVpiRbABEiVNyr4C9O7cQojXfetzsC4U31BjvVDDvq3/dKqReTNZMXclAVqkt
	y8cOgnYKiUeU0T4wHxxifqdaUfpA=
X-Gm-Gg: ASbGncsAt00QGZIgFmJ2YoD9AWVxPyFh4Jt2DRhq/4KsUrkACa0apvMibGcMeb5aRm/
	NWR3dSB3PtuO8FxMos+0QrisXKqo37iZI2y1ngg==
X-Google-Smtp-Source: AGHT+IEXg43AO3chjuHfIwqJ8gLUaE9b4xCO+ch1CPhaoQoNFNs6X9lnGw4ntj/ghyYXHmYzJuHe/+rOISIPOA+FCko=
X-Received: by 2002:a05:6e02:219e:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3ce3a9a6308mr209546795ab.1.1736901472006; Tue, 14 Jan 2025
 16:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-3-kerneljasonxing@gmail.com> <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
 <CAL+tcoCn_u_tgYuGbKqp9n1fqao_Yi0ogO8HFcA2TcQcHJOa2w@mail.gmail.com>
 <CAL+tcoA2+MO4WgzHHnX1hhCaQs6afmXWoOXNKf7wrz3QZVeeyA@mail.gmail.com> <1a0cdf13-644a-4119-9ad8-e12f81751c79@linux.dev>
In-Reply-To: <1a0cdf13-644a-4119-9ad8-e12f81751c79@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 08:37:15 +0800
X-Gm-Features: AbW1kvaSCQOGlgndMIDFWvpjSE8Ezh8rsQJWhvTe5NxRfz8UYnsKqDAAK2sZ6LE
Message-ID: <CAL+tcoD2OH9Pp6-+iRaKUx7d2AjDgeM7qZjXGV=xurvhXiYrzw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/15] net-timestamp: prepare for bpf prog use
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/14/25 4:15 PM, Jason Xing wrote:
> > On Wed, Jan 15, 2025 at 8:09=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> On Wed, Jan 15, 2025 at 7:40=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>>
> >>> On 1/12/25 3:37 AM, Jason Xing wrote:
> >>>> Later, I would introduce three points to report some information
> >>>> to user space based on this.
> >>>>
> >>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> >>>> ---
> >>>>    include/net/sock.h |  7 +++++++
> >>>>    net/core/sock.c    | 14 ++++++++++++++
> >>>>    2 files changed, 21 insertions(+)
> >>>>
> >>>> diff --git a/include/net/sock.h b/include/net/sock.h
> >>>> index f5447b4b78fd..dd874e8337c0 100644
> >>>> --- a/include/net/sock.h
> >>>> +++ b/include/net/sock.h
> >>>> @@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, in=
t optname,
> >>>>                          struct so_timestamping timestamping);
> >>>>
> >>>>    void sock_enable_timestamps(struct sock *sk);
> >>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> >>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb=
, int op);
> >>>> +#else
> >>>> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struc=
t sk_buff *skb, int op)
> >>>> +{
> >>>> +}
> >>>> +#endif
> >>>>    void sock_no_linger(struct sock *sk);
> >>>>    void sock_set_keepalive(struct sock *sk);
> >>>>    void sock_set_priority(struct sock *sk, u32 priority);
> >>>> diff --git a/net/core/sock.c b/net/core/sock.c
> >>>> index eae2ae70a2e0..e06bcafb1b2d 100644
> >>>> --- a/net/core/sock.c
> >>>> +++ b/net/core/sock.c
> >>>> @@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int =
optname,
> >>>>        return 0;
> >>>>    }
> >>>>
> >>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> >>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb=
, int op)
> >>>> +{
> >>>> +     struct bpf_sock_ops_kern sock_ops;
> >>>> +
> >>>> +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp))=
;
> >>>> +     sock_ops.op =3D op;
> >>>> +     if (sk_is_tcp(sk) && sk_fullsock(sk))
> >>>> +             sock_ops.is_fullsock =3D 1;
> >>>> +     sock_ops.sk =3D sk;
> >>>> +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OP=
S);
> >>>
> >>> hmm... I think I have already mentioned it in the earlier revision
> >>> (https://lore.kernel.org/bpf/f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@lin=
ux.dev/).
> >>
> >> Right, sorry, but I deleted it intentionally.
> >>
> >>>
> >>> __cgroup_bpf_run_filter_sock_ops(sk, ...) requires sk to be fullsock.
> >>
> >> Well, I don't understand it, BPF_CGROUP_RUN_PROG_SOCK_OPS_SK() don't
> >> need to check whether it is fullsock or not.
>
> It is because the callers of BPF_CGROUP_RUN_PROG_SOCK_OPS_SK guarantees i=
t is
> fullsock.
>
> >>
> >>> Take a look at how BPF_CGROUP_RUN_PROG_SOCK_OPS does it.
> >>> sk_to_full_sk() is used to get back the listener. For other mini sock=
s,
> >>> it needs to skip calling the cgroup bpf prog. I still don't understan=
d
> >>> why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot be used here because of udp.
> >>
> >> Sorry, I got lost here. BPF_CGROUP_RUN_PROG_SOCK_OPS cannot support
> >> udp, right? And I think we've discussed that we have to get rid of the
> >> limitation of fullsock.
>
> It is the part I am missing. Why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot supp=
ort
> udp? UDP is not a fullsock?

No, you're not missing anything. UDP is a fullsock and
BPF_CGROUP_RUN_PROG_SOCK_OPS itself can support udp as my v3 version
used this method already like you suggest. I feel like
misunderstanding what you really suggest. Sorry for the trouble
caused.

I wonder if using is_fullsock would affect/break the usage of fetching
some fields, especially tcp related fields,  in
sock_ops_convert_ctx_access()? Sorry that I'm not a bpf expert :(

If not, I will use BPF_CGROUP_RUN_PROG_SOCK_OPS instead.

Thanks,
Jason

