Return-Path: <bpf+bounces-49014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E6EA13088
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8431165BB3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614B1F942;
	Thu, 16 Jan 2025 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFB3Ht3U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A48494;
	Thu, 16 Jan 2025 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736989991; cv=none; b=QWFylnfFKNn3y/Tv7RiKhC95LyXxEM32SByd+fH4GTvit9shLRxHFbIHanD6vnBOWhilZigPe3ShKGyGZR2kBHZzVLgdIVXsjaUk6vWl5mvaeb6wNrVrp+KF7IiBIz3nPnb/+7bpC5DfS8at1mow5lqUbF8do8adhk0A/2UMRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736989991; c=relaxed/simple;
	bh=4BQOfZxHB5HndhISHgem1p4U7kXFZ+Cp7oKH5ALMXBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC5SNrNiFpQ98eCeVnx9fYtYWQ1U2QcaJpXCEtOy7dxCzfp8vIqg22UffaPg1UiUNfFrhwjRcdeBbxA0CqW2CxT6rWN+350xDKmuy06zTRQGw+SMNkjitxmsjLNrU/ZpvNffBcUK0hp5PbYqXnh6gtVl0Cs/0KnMr81fZbJRShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFB3Ht3U; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso33425939f.3;
        Wed, 15 Jan 2025 17:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736989988; x=1737594788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8C2C2bsZxq9vqDHdNsHWMM6AyuPxp4suTcXbrM1CMA=;
        b=YFB3Ht3UDwv+0lAKNsSSCsbgfNEUuYqwOuAPt6XdeWuV57hnNtT+5NHck5S2HZ6I1e
         prFAXEodjXegEYRZIY6XM44rv9tz/HzjyjaUWzQnbsRAKLRRdYEtmfKcvImvisLbMgiN
         QlKoOAFG8tvfVpoX7lmifBESY2o3M/k64ks38XtabxTz4QMXu6e9I7IuXjMtcH95e7mF
         PRIihsAOaLAXrEdFbueDZcSRuj5fIv/FO64eOVjr7RJH7n9Zq9XtAR7zKW43mBiDHuNt
         3ovQlMbsga9yRtHjxMtShXc0iVQOeWJEd+eNaWS0fsl8qAhPfWBfnyxqLyqlb7bOWizT
         PKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736989988; x=1737594788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8C2C2bsZxq9vqDHdNsHWMM6AyuPxp4suTcXbrM1CMA=;
        b=akNpW7+dZQCV3aTNkwyS5Vq8dUkOYcwlSgmAXWDlh6O+lNH0nATWN0IVUfv+lFzNve
         dtyq3GrwE5kYVjeaskmVPVw4Wr6fwgZO6ehVH6BbfcedHIE7XaudNkGru0ocwN+3ztEF
         x24qB4nbDw+QqOdri4yll5hp4K87g8qqej/uxSx5elCC/gda3Cpshl4XOb+Syq2VV9i7
         myfiD0QowluAnI1YN3aIRCPVxFIRlJqpjaY4LaGQi7RvLx4NYAg5QgLyX4H+zHmZBicJ
         Wle1PeIY+9IlaOZEWSep4QT7Om90v0P27tRUYoDhBVQYie4n6xBfIMFngWhHREIQpMWy
         dW8g==
X-Forwarded-Encrypted: i=1; AJvYcCUhmytBd5FF7wGLasOmEgN17Buh0YFEq+Dkaw3KZCVjNn+Ta94/EO0eEWj9WFK9jKF8UcY=@vger.kernel.org, AJvYcCVlmbg8ylRvBNzcsO89bwEvC8xOmiliCu+5E16taeWl6j17Ww1dW8GsoenWY9vDuvB1qS8BPlA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WHiA6AggKax860KDDvgCtEfXIHXAR6CHfYNDjvrbvQf7WUg3
	2Zub4Qmrnnm6fPpZe7qJkZG4sK3+rxAeEWZbJUMfZMYGC96PysW4W1kbw8wj8B69w8tpbVygR1C
	JZEcsQoiecdBJ7A8sGpAxfg/TNiw=
X-Gm-Gg: ASbGncuTACmNOlgMF4Z9/hk95bYwUCLtzm/ix00dYTFx0OkLINglTS5iFg+h+TX/t2+
	K5qZmELoeei2sw14Y9E3CzczI5hkjdI6Pqu47
X-Google-Smtp-Source: AGHT+IGvRWRudFeMb6nNd2IXuDFhoB0ZzDfdLTF4XM+v01cKTQNoTwnddq28FteKSc/6w0+unwOQZs4asEmao/9/7Hs=
X-Received: by 2002:a05:6e02:330a:b0:3ce:8bae:d88b with SMTP id
 e9e14a558f8ab-3ce8baedb52mr45050525ab.18.1736989987105; Wed, 15 Jan 2025
 17:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com> <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
 <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
 <CAL+tcoDS6H4SMDRs9r+cOM_2bdbNRFRQpuYmpVFyxoMcQJDXLQ@mail.gmail.com> <ba353503-bfd3-4de0-bb99-9c7e865e8a73@linux.dev>
In-Reply-To: <ba353503-bfd3-4de0-bb99-9c7e865e8a73@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 09:12:30 +0800
X-Gm-Features: AbW1kvYEushpMBnz-ZVyiwuwHJSwJn3_z6lkX6rdRikKO18FLOof4Nw2490kdDA
Message-ID: <CAL+tcoChGB3vA7LMm0VHb9OjmXHUw0--f6v4Crz5R7U+EPo+cg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow
 UDP socket fetched in bpf prog
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

On Thu, Jan 16, 2025 at 8:51=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/14/25 6:54 PM, Jason Xing wrote:
> > I construct my thoughts here according to our previous discussion:
> > 1. not limiting the use of is_fullsock, so in patch 2, I will use the
> > follow codes:
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op)
> > +{
> > +       struct bpf_sock_ops_kern sock_ops;
> > +
> > +       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +       sock_ops.op =3D op;
> > +       sock_ops.is_fullsock =3D 1;
> > +       sock_ops.sk =3D sk;
>
> lgtm.
>
> > +       BPF_CGROUP_RUN_PROG_SOCK_OPS(sk, &sock_ops, CGROUP_SOCK_OPS);
>
> After looking through the set and looking again at how sk is used in
> __skb_tstamp_tx(), I think the sk must be fullsock here, so using
> __cgroup_bpf_run_filter_sock_ops() as in patch 2 is good. It will be usef=
ul to
> have a comment here to explain it must be a fullsock.

Got it, will add more comments on it.

>
> > +}
> >
> > 2. introduce the allow_direct_access flag which is used to test if the
> > socket is allowed to access tcp socket or not.
>
> yeah, right now is only tcp_sock, but future will have UDP TS support.
>
> May be the "allow_direct_access" naming is not obvious to mean the existi=
ng
> tcp_sock support. May be "allow_tcp_access"?

I like this name :)

>
> I was thinking to set the allow_direct_access for the "existing" sockops
> callback which must be tcp_sock and must have the sk locked.
>
> > On the basis of the above bpf_skops_tx_timestamping() function, I
> > would add one check there:
> > + if (sk_is_tcp(sk))
> > +       sock_ops. allow_direct_access =3D 1;
>
> so don't set this in the new TS callback from bpf_skops_tx_timestamping
> regardless it is tcp or not.
>
> >
> > Also, I need to set allow_direct_access to one as long as there is
> > "sock_ops.is_fullsock =3D 1;" in the existing callbacks.
>
> Only set allow_direct_access when the sk is fullsock in the "existing" so=
ckops
> callback.

Only "existing"? Then how can the bpf program access those members of
the tcp socket structure in the current/new timestamping callbacks?

>
> After thinking a bit more today, I think this should work. Please give it=
 a try
> and check if some cases may be missed in sock_ops_convert_ctx_access().

I will give it a shot this week.

>
> >
> > 3. I will replace is_fullsock with allow_direct_access in
> > SOCK_OPS_GET/SET_FIELD() instead of SOCK_OPS_GET_SK().
>
> Yep.
>
> >
> > Then the udp socket can freely access the socket with the helper
> > SOCK_OPS_GET_SK() because it is a fullsock. And udp socket cannot
> > access struct tcp_sock because in the timestamping callback, there is
> > no place where setting allow_direct_access for udp use.
>
> __sk_buff->sk? yes.

