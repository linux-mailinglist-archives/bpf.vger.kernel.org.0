Return-Path: <bpf+bounces-41411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCC996CC3
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAE3B2302D
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB11993B8;
	Wed,  9 Oct 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cggVmnjq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC41917EB;
	Wed,  9 Oct 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481971; cv=none; b=AHEKyCzVYBjqKPgg2IUPbDm3iuX/zzNv8mFpJQvCaKbo2cAHmh/dpDxviK3YD+6pM2NaVFdQm87dDQ/d6FspCv6rt8IKzukebYCP8K3hxBM1QeUpNhOWQPQFRLZ9mEu6hhxciutHtVf/muPaCV61IK/pDzk08FpGGewuI7sotBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481971; c=relaxed/simple;
	bh=4vGYZfHgeMmOSBuSbt3m58QFDEnDhi1vdrLlnLNEShw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVEB+mr8Ah5j1tu4T2FRRZqnDmVoCULw2b/8eAdnj4DYQgqscnv0YylUKdgIM40Rksnc4dH9Zijn5H0XukT6CeTTksa6AD5ISJygm7MUyiuf3rI/tNLaCljKDf+fsyuf/BbcJV4tDGxjI0kL9qhYDyOIWu5h0BYqAoHVNlsrrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cggVmnjq; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82ce603d8daso256400339f.0;
        Wed, 09 Oct 2024 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728481969; x=1729086769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA6qyPeG2ws8wkvBTh4BvpHnKbmM2PbfzdplzJflBkE=;
        b=cggVmnjqpfwTtA1aekmbjJE4bMLORmPXtVuPpcL5t/E/HkvHvlJj/VTM9NGgcb4EcZ
         7vNeGs9/Ej+0gH2ly1RnEz7daYGAk5vGtxwg6wbZ8NlTVpBbcEywL92NBVHmVMVU3lJG
         vXx+ct5F9dYkauiPRkrP7XHExf0ioKd7oY0f6gXhkLta2AOOXOKeuCtN+NQbBlQP2Pdb
         O/H4yUSUb7aXraqzyf1MZmSp71iXsOCfGsLb5EWWefQCAYuYHJ07kHlazcsHu0GHVebC
         PHoLtmmFcdKFVCoTHadeREtHsVlawYWLhYkdb/d3/rZCQmDD3dchFqGYmywO43wwDGnI
         3m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481969; x=1729086769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA6qyPeG2ws8wkvBTh4BvpHnKbmM2PbfzdplzJflBkE=;
        b=c1R/ZxqMEBt/Sqkno692JsDh0+QZRWGEFLAIAQEImbFlCskdxZsy4XFay3hDYM6+y/
         rge4nPJczZplOC0/SXBpVwn4atEq6ALTvukHkA68LPbLli32aLNj/MlmYyPlndeHlJfg
         0uhxE+l/snQK2896kkvqX9sIb17pLzRZuYNZgMP78YBRb11psMOyp5dh3qo6dTT2DEsS
         dmI5Wz1OMJ55GOGtyCw4wMLRA7kgBCwTfb94D5XIKbXUQZERoYQOkATCuQu0ikhwsipw
         6S/RMkCUZmFPuYeIWwN19DBvy1gSfq8oQ8cDD0bsfZrYJtNSIlZqwc0pw1V2tII11jDP
         Mf4w==
X-Forwarded-Encrypted: i=1; AJvYcCVUFsX2QL9zmV+3ypjE66BcvQwKibO9c4k1tDdY0aPKJuXwvthNmlsEvXR4q8SEOKn+U3w=@vger.kernel.org, AJvYcCWE2UN/JleVRy2NCv6MIt1Q1Ca0SHKEOXTDbQv674SAnNsCz+zcG15PlFZKskKF3thP4pm5M5HB@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJtpCJjKMnntcBh9vZz3vGIBCxhz4QEBdkDfBx03VhPkijbqk
	4D6NOoij7cBFz/8w+pBMZAVIfZizfgw9bvjGhSwyVEOs9ngnopG6LqeZDuFK92sozYeM80iXapC
	llznMoO1FpNdhg3DHdU0ru9H9F9I=
X-Google-Smtp-Source: AGHT+IFDxlNKKCutdHYKqmCxIbfP7W96tL2tnvJSMynvdeM9LdbTrxvqQbd9xH3Rc905/jRpVDkEherkbjPvCwihcQI=
X-Received: by 2002:a05:6e02:1fcc:b0:3a1:a293:4349 with SMTP id
 e9e14a558f8ab-3a397d10ec2mr26090495ab.18.1728481968919; Wed, 09 Oct 2024
 06:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-7-kerneljasonxing@gmail.com> <6705804318fa1_1a41992941a@willemb.c.googlers.com.notmuch>
 <CAL+tcoA_HwCYG+_DtdRHNL-L07RYqQfxY+pmT2fUvs-N1HYV9g@mail.gmail.com> <670682ed93e9c_1cca3129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <670682ed93e9c_1cca3129431@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 21:52:13 +0800
Message-ID: <CAL+tcoBR80V_760RoZ9w0cdAfyoHwGS0fL7ckuAF7JSpdzAvEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] net-timestamp: add tx OPT_ID_TCP support for
 bpf case
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:19=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> > > > from each sendmsg. We only set the socket once like how we use
> > > > setsockopt() with OPT_ID|OPT_ID_TCP flags.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/core/skbuff.c | 16 +++++++++++++---
> > > >  net/ipv4/tcp.c    | 19 +++++++++++++++----
> > > >  2 files changed, 28 insertions(+), 7 deletions(-)
> > > >
> > >
> > > > @@ -491,10 +491,21 @@ static u32 bpf_tcp_tx_timestamp(struct sock *=
sk)
> > > >       if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> > > >               return 0;
> > > >
> > > > +     /* We require users to set both OPT_ID and OPT_ID_TCP flags
> > > > +      * together here, or else the key might be inaccurate.
> > > > +      */
> > > > +     if (flags & SOF_TIMESTAMPING_OPT_ID &&
> > > > +         flags & SOF_TIMESTAMPING_OPT_ID_TCP &&
> > > > +         !(sk->sk_tsflags & (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTA=
MPING_OPT_ID_TCP))) {
> > > > +             atomic_set(&sk->sk_tskey, (tcp_sk(sk)->write_seq - co=
pied));
> > > > +             sk->sk_tsflags |=3D (SOF_TIMESTAMPING_OPT_ID | SOF_TI=
MESTAMPING_OPT_ID_TCP);
> > >
> > > So user and BPF admin conflict on both sk_tsflags and sktskey?
> > >
> > > I think BPF resetting this key, or incrementing it, may break user
> > > expectations.
> >
> > Yes, when it comes to OPT_ID and OPT_ID_TCP, conflict could happen.
> > The reason why I don't use it like BPF_SOCK_OPS_TS_SCHED_OPT_CB flags
> > (which is set along with each last skb) is that OPT_ID logic is a
> > little bit complex. If we want to avoid touching sk_tsflags field in
> > struct sock, we have to re-implement a similiar logic as you've
> > already done in these years.
>
> One option may be to only allow BPF to use sk_tsflags and sk_tskey if
> sk_tsflags is not set by the user, and to fail user access to these
> fields later.
>
> That enforces mutual exclusion between either user or admin
> timestamping.
>
> Of course, it may still break users if BPF is first, but the user
> socket tries to enable it later. So an imperfect solution.
>
> Ideally the two would use separate per socket state. I don't know
> all the options the various BPF hooks may have for this.

Adding a new sk state or skb state is a much clearer way. That is also
what I commented on the patch [0/9]. While waiting for BPF experts'
reply, I keep investigating if there is a good way to add a new field.

Thanks,
Jason

