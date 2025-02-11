Return-Path: <bpf+bounces-51095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436CA30177
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE63A5DA6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F061BFE00;
	Tue, 11 Feb 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbK+cv+1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF243AA1;
	Tue, 11 Feb 2025 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240786; cv=none; b=qN+Xb5GzY9zNgAfrod3q/Kzqaf8Hm6Q/5/Hj1/cGI84WxJmXm4kpZQyPoDFUgU2imQn9TBu/ImjGf8oBkGb6bcsRo5PS49+ZdFiz/jAhsBLG6SLLweda7p70dTXvRzn1EwPY6Vnxp1vX5904L66o/mxIV0Nt5rhCI9VUghTkatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240786; c=relaxed/simple;
	bh=KqVLyxIC/fj+oWAKy+OEvyNyM63220bp01X8vfg+Dlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuV5Gqc8reM+vBH83M8crV54wPQLHSmXgMRljdjUsZzQJVTx1Wnc4vkMLpScsmi2nuFpWKoUkO9nbAtJ7GawAe6rMB/96O25m/Kr5j8oR7uLjfyT3IzAKWymdcalqCIGsRKD6m7y3ogxr7ZKn+5n++sMniHocs9d9dd5WWPUXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbK+cv+1; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8551c57cb8aso55533939f.3;
        Mon, 10 Feb 2025 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739240783; x=1739845583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdMi94N80WRutQyRui90rmepUG8m7TEx7+QaiAvoOnU=;
        b=SbK+cv+14RIrLhxFbtr5xUG6+eX6l+mikSnF0qj2MXvpAD9JhzjJ43we54f/R8juRA
         aLZmOlGfw5YZ0K6kMpJ7FqEUj82+3UfC22m3omfkCdK0HRe1PxkHvRAeXUxLw3z/NfQ5
         gbHxpCIp1JGTjVm9Wrz/XHvwx/kSv+Hnln2DFZMRB+ezMWbRavvZv884d/YDACiMk2be
         kC1En3DOStPSKAlJEEvcyATvO88b91FyR6oNA5gHmpsmP7E1saxktPXNJ+1h2BkvMCqg
         60Y80YnxEAmaJj66uR/4GqcqtyCwrz+cOHYN+u+mUlL7G7wDHEYd9TyQ1o90M3pSG4WI
         JQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739240783; x=1739845583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdMi94N80WRutQyRui90rmepUG8m7TEx7+QaiAvoOnU=;
        b=v3Viie7JRmDbLbY0uNzyqW5gYaf0FdPy2uXmqho07Zha62oWs14lDsbCPYPqUFFzv7
         fYPCAbKk2CfMydejYIOwjWcYAG2STHy7CKrxISYpm0vJOvePjnfk5W6UDq18fp8GV6Ad
         8nvw6KfmWwiZzbj2QTJQwFNMYyBxhipJuBOZF+yO7Sqyuqar+jOMP1YZq/YYODTHi3q2
         aqMF9p4apydurk5H9FiXJU5YpKmuWIuMPfWANnZBuhirbeJKzMwDcGXxJeayxeI+PXad
         AI9Jgjwrr1MWQecY+H9BnTDjvvOyspSIcuxwd2HETroJeTFynCmOBDbPaZImcPmjY9c/
         Cz+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtrntecrbLGBaBz9sMF5OXZbC/+6ZvSHxvu0yTlagD6kwtlU/l1f3sPGyTHphE0c75DrA=@vger.kernel.org, AJvYcCXlOgfjqXBMKH4eVN2/akWZByheC7wBfoCCbEHnrfgZalS8ewps+KlSAZ1zRNzy6lXJ9ZWsRmKG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pSJ0YgwG8yn+wAjpA+BqjPC2VJGP72hFFDuuRp0XnqNNW4Sv
	Yqq6oBMU9sW7ngUKuR45VSQfzpZSHaqBUnAJFLPLwZ7ZAjoTtPqoE9memdm8qcodF0W8X1O1lZ1
	vq9maVIEzNIfNg6D1SwNGwXyzoHs=
X-Gm-Gg: ASbGncvTJCYrezbRdmQtXqXJeNjLPrzt2QEefDTtoZNf8nrC0h0P5ZJs5/ww9yaQGZi
	vHO6hL4BlrHCdPEQ7RTK/wvHLpEXGCjjAHEL1mudUTMWcWIw7L5/wUuLHM3aCEJfUYjGWPLnb
X-Google-Smtp-Source: AGHT+IH5Mj/yzzEq6yG33UOQaFMaulXA1YL1g0NX1oaWeKiCPW/pj2lpi4/WB38XSBdWkFIE4tW76vURsdfRLDOvQy0=
X-Received: by 2002:a05:6e02:1c86:b0:3cf:c82f:586c with SMTP id
 e9e14a558f8ab-3d13dcde651mr140473805ab.4.1739240783631; Mon, 10 Feb 2025
 18:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-3-kerneljasonxing@gmail.com> <fb1111fc-6a4e-4388-860c-0077910e814f@linux.dev>
In-Reply-To: <fb1111fc-6a4e-4388-860c-0077910e814f@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 10:25:47 +0800
X-Gm-Features: AWEUYZlo9Z1JEs4QYdN7AX6E9vhpOGKo1b_Th2zH2Z2qVc4gN6rW6ScIl7WGB2w
Message-ID: <CAL+tcoC9-tWb_ogoP--T60WJTniVtA9r=6NMC18iJiNuaKJWxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/12] bpf: prepare for timestamping callbacks use
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

On Tue, Feb 11, 2025 at 9:32=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > Later, four callback points to report information to user space
> > based on this patch will be introduced.
> >
> > As to skb initialization here, users can follow these three steps
> > as below to fetch the shared info from the exported skb in the bpf
> > prog:
> > 1. skops_kern =3D bpf_cast_to_kern_ctx(skops);
> > 2. skb =3D skops_kern->skb;
> > 3. shinfo =3D bpf_core_cast(skb->head + skb->end, struct skb_shared_inf=
o);
> >
> > More details can be seen in the last selftest patch of the series.
>
> This BPF program example is not useful in this commit message. It is not =
how
> this change will be used in the kernel. People will naturally be required=
 to
> look at the selftest to see how the bpf prog can get to the skb and tskey=
, etc.
>
> The commit message should focus on explaining "what" has changed and "why=
" it is
> necessary. The "why" part ("four callback points to report...") is mostly
> present but could be clearer.
>
> Subject: bpf: Prepare the sock_ops ctx and call bpf prog for TX timestamp=
ing
>
> (What)
> This patch introduces a new bpf_skops_tx_timestamping() function that pre=
pares
> the "struct bpf_sock_ops" ctx and then executes the sockops BPF program.
>
> (Why)
> The subsequent patch will utilize bpf_skops_tx_timestamping() at the exis=
ting TX
> timestamping kernel callbacks (__sk_tstamp_tx specifically) to call the s=
ockops
> BPF program.

Thanks, Will update it.

>
>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/net/sock.h |  7 +++++++
> >   net/core/sock.c    | 15 +++++++++++++++
> >   2 files changed, 22 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 7916982343c6..6f4d54faba92 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int o=
ptname,
> >                         struct so_timestamping timestamping);
> >
> >   void sock_enable_timestamps(struct sock *sk);
> > +#if defined(CONFIG_CGROUP_BPF)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op);
> > +#else
> > +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct s=
k_buff *skb, int op)
> > +{
> > +}
> > +#endif
> >   void sock_no_linger(struct sock *sk);
> >   void sock_set_keepalive(struct sock *sk);
> >   void sock_set_priority(struct sock *sk, u32 priority);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index eae2ae70a2e0..41db6407e360 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -948,6 +948,21 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
> >       return 0;
> >   }
> >
> > +#if defined(CONFIG_CGROUP_BPF)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op)
> > +{
> > +     struct bpf_sock_ops_kern sock_ops;
> > +
> > +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +     sock_ops.op =3D op;
> > +     sock_ops.is_fullsock =3D 1;
> > +     sock_ops.sk =3D sk;
> > +     bpf_skops_init_skb(&sock_ops, skb, 0);
> > +     /* Timestamping bpf extension supports only TCP and UDP full sock=
et */
>
> nit: After our earlier discussions, it's clear that the above is_fullsock=
 =3D 1;
> is always true for all sk here. This comment has become redundant. Let's =
remove it.

Will do it.

Thanks,
Jason

>
> > +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
> > +}
> > +#endif
> > +
> >   void sock_set_keepalive(struct sock *sk)
> >   {
> >       lock_sock(sk);
>

