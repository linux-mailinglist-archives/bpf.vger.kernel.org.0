Return-Path: <bpf+bounces-41950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E499DC80
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FA2B221B5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B01741EF;
	Tue, 15 Oct 2024 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRjopBzW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155A17334E;
	Tue, 15 Oct 2024 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961176; cv=none; b=r3Cjm9HnAMZJNnQbGbWQH7Ly18HShXz7HelmHE15adrlgse6PTgqHfKYyQtKAiExLoNTI0RDirpyEAucmaSU0op2Dl2Ze9EOH+6qxj/PIFxLraLnV3jPi9LPGe+4tYm8ysZ+gdGum3Z0cfn+tpISKNUW46KgFVTHyfuVi7pqIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961176; c=relaxed/simple;
	bh=8aqdWFKYKw7qh967891TNiCf4FxfF7yPmCSkW93nx40=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=F6Hllowa50y210mW4Y1WVQ/VXi8Vw+sn1Tbpk3b3GLgHN5Hoph9DmCew0bGb2zGn7J52pMhOhLQYUB56uUrH3w8K1X6cJqYnKKs09cWB1hYkhM7MeyGcd25BhaUv/hvMfwlyvRTJ6hO1eZQfd5tujatJXOqciIuvTAJNGcJMVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRjopBzW; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45f091bf433so40966511cf.3;
        Mon, 14 Oct 2024 19:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728961173; x=1729565973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=729PwK6u533iM0lL1LTT5k653zxUsx2m1eetOqQYG4Q=;
        b=jRjopBzWuu4oz7NVHD1ZufkVLAwDGXvU7OVku55rbi915IcKxpmunH/eJOpgPahWyF
         F+kOY9yVrFWU3plksgm+UWJFnBh2s6tlTI6tG6D4rqiaCBOB05m8HNXVnhfCbxB1L7ep
         Ud2k6C8vUuml6FgWqr9bp3ykhlCllL3FRpg7rg434YzpgJcGQUluPlqFAa50tCgAbDnE
         SIeIkAlJ2dINyv78PlvFTC/QeiEiJQ8E0ciCcaUDJ+XaeoqYEViyj+MojGpIChbMFOlN
         mWyOHSSytvxZUsovJ3nLuYbQlGoM73QvHiTCTvDLqfUc5NU3yckM1d6gWQlGArsk5ZzC
         XweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728961173; x=1729565973;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=729PwK6u533iM0lL1LTT5k653zxUsx2m1eetOqQYG4Q=;
        b=NWgFHhW5FbAA8JrjEH5bqimrHmcXI45CRpc/KmbD969btjI5k51NDBMW97l8Cppbc/
         HJ7iU9m9FitzBEpa+yNNkTmNFWyvVRHC+vrSwbfqCFbDfzOuYZnlsme7vZvEo7S48xlR
         Gmsd2cjhgasVUqobgA3QiatPDUUDCgESOj5k7jXp9zIUr8v1rThgfZVOyTeNN4g1crYl
         aavXpSSCP4YtZ/5BlCgKOJC9f/M/cY83c5IpQxlWIomn5lt7Y8UeqrqAOi7/CDdd2ssd
         lareRWb4yEpWznR9pIfEv3No9KjjV9JA33frn0rm5GU7egUrtQec+yFJdlnjFdTUx+aa
         wDFg==
X-Forwarded-Encrypted: i=1; AJvYcCWY63Bh9LhnpA7JrWAy7HaUxS07d1qpuYKf0McqbLUhAKyX9SLQ4xKExqumaz0lIqMN4lY=@vger.kernel.org, AJvYcCXhAEuW43i+8l5bAW+EIKouVfKgCxE2JfptksEzk3lQe/zHRb+EnILCwY2IZau4cXZ9bEZ2wdcM@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpF8s87+kB1GD55HyqVScZfvFNgPXBFZnxVO3mue4kjFsnYne
	QsUNU/+QFdwCKdL2HfRD095B49t6BuGd7YrqPmILKAuRQ+ESgsTV
X-Google-Smtp-Source: AGHT+IF6JgvGnhsblrrWky+onFc2jTXIelEiSUDOmGkIPAG8NFmI3M/H0eJh2czNyHaji5IEFKDEug==
X-Received: by 2002:a05:622a:411a:b0:456:89e5:a43f with SMTP id d75a77b69052e-4604bc2d713mr209911211cf.48.1728961173364;
        Mon, 14 Oct 2024 19:59:33 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b12ddd2sm1801241cf.53.2024.10.14.19.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 19:59:32 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:59:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dda9437147_2e6c4029461@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoA-pMZniF2wmYJBR+PKCWThT+i+h5K-cRs3P5yqe3x-PQ@mail.gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
 <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
 <670dc531710c_2e1742294b4@willemb.c.googlers.com.notmuch>
 <CAL+tcoA-pMZniF2wmYJBR+PKCWThT+i+h5K-cRs3P5yqe3x-PQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
 applications transparently
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Oct 15, 2024 at 9:28=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Sun, Oct 13, 2024 at 1:48=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature b=
y using
> > > > > tracepoint to print information (say, tstamp) so that we can
> > > > > transparently equip applications with this feature and require =
no
> > > > > modification in user side.
> > > > >
> > > > > Later, we discussed at netconf and agreed that we can use bpf f=
or better
> > > > > extension, which is mainly suggested by John Fastabend and Will=
em de
> > > > > Bruijn. Many thanks here! So I post this series to see if we ha=
ve a
> > > > > better solution to extend. My feeling is BPF is a good place to=
 provide
> > > > > a way to add timestamping by administrators, without having to =
rebuild
> > > > > applications.
> > > > >
> > > > > This approach mostly relies on existing SO_TIMESTAMPING feature=
, users
> > > > > only needs to pass certain flags through bpf_setsocktop() to a =
separate
> > > > > tsflags. For TX timestamps, they will be printed during generat=
ion
> > > > > phase. For RX timestamps, we will wait for the moment when recv=
msg() is
> > > > > called.
> > > > >
> > > > > After this series, we could step by step implement more advance=
d
> > > > > functions/flags already in SO_TIMESTAMPING feature for bpf exte=
nsion.
> > > > >
> > > > > In this series, I only support TCP protocol which is widely use=
d in
> > > > > SO_TIMESTAMPING feature.
> > > > >
> > > > > ---
> > > > > V2
> > > > > Link: https://lore.kernel.org/all/20241008095109.99918-1-kernel=
jasonxing@gmail.com/
> > > > > 1. Introduce tsflag requestors so that we are able to extend mo=
re in the
> > > > > future. Besides, it enables TX flags for bpf extension feature =
separately
> > > > > without breaking users. It is suggested by Vadim Fedorenko.
> > > > > 2. introduce a static key to control the whole feature. (Willem=
)
> > > > > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feat=
ure in
> > > > > some TX/RX cases, not all the cases.
> > > > >
> > > > > Note:
> > > > > The main concern we've discussion in V1 thread is how to deal w=
ith the
> > > > > applications using SO_TIMESTAMPING feature? In this series, I a=
llow both
> > > > > cases to happen at the same time, which indicates that even one=

> > > > > applications setting SO_TIMESTAMPING can still be traced throug=
h BPF
> > > > > program. Please see patch [04/12].
> > > >
> > > > This revision does not address the main concern.
> > > >
> > > > An administrator installed BPF program can affect results of a pr=
ocess
> > > > using SO_TIMESTAMPING in ways that break it.
> > >
> > > Sorry, I didn't get it. How the following code snippet would break =
users?
> >
> > The state between user and bpf timestamping needs to be separate to
> > avoid interference.
> =

> Do you agree that we will use this method as following, only allow
> either of them to work?
> =

> void __skb_tstamp_tx(struct sk_buff *orig_skb,
>                      const struct sk_buff *ack_skb,
>                      struct skb_shared_hwtstamps *hwtstamps,
>                      struct sock *sk, int tstype)
> {
>         if (!sk)
>                 return;
> =

>        ret =3D skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, t=
stype);
>        if (ret)
>                /* Apps does set the SO_TIMESTAMPING flag, return direct=
ly */
>                return;
> =

>        if (static_branch_unlikely(&bpf_tstamp_control))
>                 bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamp=
s);
> }
> =

> which means if the apps using non-bpf method, we will not see the
> output even if we load bpf program.

Could the bpf setsockopt fail hard in that case?

Your current patch tries to make them work at the same time. It mostly
does work. There are just a few concerning edge cases that may result
in hard to understand bugs.

Making only one method work per socket and fail hard if both try it is
crude, but at least the failure will be clear: the setsockopt fails.

I think that's safer. And in practice, the use cases for BPF
timestamping probably are exactly when application timestamping is
missing?=

