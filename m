Return-Path: <bpf+bounces-50437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C12A2797C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CA1188837D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F7217703;
	Tue,  4 Feb 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqW31Xwq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A221323A;
	Tue,  4 Feb 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692779; cv=none; b=BjfeIiFXbxt9F79bghhel7XMN4THS8iec9fCfpxYnzdULOo3n493zA3brk2nxyRMSDeVAkg/QkQqhgiHt3E9xPgGaijufl+K7hX3SyuIP7w5AnDPRqGp6qfSELjPIxSdUs/cvXnCxT7F0ynS469Q+1PbiCy9KewB3ZxZ3XES2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692779; c=relaxed/simple;
	bh=CYz20IyBdL4tx0KlOWGbshrZwaiBf8bN31w6HGh0JTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2ni0WpJPehaGU9Kkl6TwCWa7Pkp48nxqtNGXhCAPDIPUxt/ueEpm6C91G9ak0Q/EShJhN5QWVGFQHUYAyfiUK4sS+bDrNAe5qejQIxOvXVQHcT5O6Z3DKMZugQxXDKrUaYlEeWOjeDG6Y/voDhZKHL6iiDkGcRABoIslYBU+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqW31Xwq; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso19839495ab.3;
        Tue, 04 Feb 2025 10:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738692776; x=1739297576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYz20IyBdL4tx0KlOWGbshrZwaiBf8bN31w6HGh0JTE=;
        b=dqW31Xwq381+GeettufxoZmZHLXg69YLHHFGqIpYM5p8gwWDiSefDV/ngUksDqa2Qr
         HXL83vySyPQjdhZ667LS7Ucq9YwecZ5HttFxyUdoFdABcIJ7lOb1GbdplHeK5/sDfwdb
         i5hdl9m5BnUTQER/0VFg+BBNaMBHfakyEwhx80W4HBlVb5bfRDkBrcVwm3MjDm7IrEON
         tuMEEwNc2JtEQ25oBuLYOOMM+ezpDV2HKBHg7qkMhlr+Sh5KdEqIvoUX23QD/StRXK+g
         CBowGxlGYrasRiir053y1XC+ZBRJuU1YGyACU+yJgm9ZAIuu2xxlLiaD8aVrRCh03r/Y
         MVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692776; x=1739297576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYz20IyBdL4tx0KlOWGbshrZwaiBf8bN31w6HGh0JTE=;
        b=gphKvwUM/bASSOLxduxXZPq0TRcl+evDmOor6/HfvJxxEGg+DjK3zoFNa6lTPgyjTF
         VrmuL3GHMguyT972urJ0uiWhjz3iWP1UftB3hITGvHkMTuH/xArR/VfkCFhQFjMw/JRl
         uC2LUm47LnfokdVf8xloD4fXXsp3TUcGEtFWY1VDUuoNUqv3wYoK/tZ+f0JFzh2s+t0R
         psHaUpysrUvCJMDbNdIn0XrMe54guHdVoXerKyNlBdIWeRUHWln9+Uf3f/fha5zVXmaW
         w/l3Nb0shxSuMHKrj55FJZwmlUsZ2MPp/ZrnWrh++yReL+ORyhFwMtbclifenXGFm+Nh
         DG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCULJmrrlCSMNg+eluzWGy9CGEpqUvYLxuDUVZIs2Cp9ZDfI8uTFbR+b7WGeG3Cl4w8tXnI=@vger.kernel.org, AJvYcCUs/Xgk/GpJaHWqejw2a8aTLR3wvllTZyBTj8984DT+/7VlhRQWnh4+yWfLWDwmI8vb7Ls+UlsG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nTYNyWTj/3e4vGSvgCQ/n2g4AWjjjA/GCtmTOFLnveFJOODy
	2ZtZvkO7R2VVjpGtv8BiCIRjSXB15nV9taysaazuxqyAPKd+xsX2VSfgkCtIc3O6+xIVKdjUnpD
	5oKG1+uwXHgBL/iGDSem3uD5V3y8=
X-Gm-Gg: ASbGncst9sVzB465R6he9C1JvuPlYTv7rKWOc3QUbRwiIxFmm4HSZNYzQvVMz5405YC
	BeY2efK5yEJQDD0u/rzIhyfsdNNZhXrPL/YKKCzOWNY/VUGVGaVR8xFQ1cbHFxWI2MDjObpI=
X-Google-Smtp-Source: AGHT+IE9Zk1ylTm7CfFOdgB4WGBylyDh4Xr37dJnRaU1T1MqTAuNF3elTkgltrftpxCxvR53xK5bj4hsVvzWmHgTRJI=
X-Received: by 2002:a92:c547:0:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3cffe3d1bd8mr221526295ab.5.1738692776529; Tue, 04 Feb 2025
 10:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev> <CAL+tcoAXcDuAsy6rqGBh3Sb1dkdZ0xn6YFCQec-K6QSPyaVwEA@mail.gmail.com>
 <67a24a4f8af27_bb566294bd@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a24a4f8af27_bb566294bd@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 02:12:19 +0800
X-Gm-Features: AWEUYZlVxc_iy5Q7A4DbFKD-24NyCtpKGeKlsqSkA38EcadyYPZR5CCPL5j2q50
Message-ID: <CAL+tcoBiRrB+_p=W-EwRL-Dqa2kWY-yAWTNurbpF10DG96=Q6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip
 applications transparently
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 1:11=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Feb 4, 2025 at 10:27=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > "Timestamping is key to debugging network stack latency. With
> > > > SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> > > > network issues can be attributed to the kernel." This is extracted
> > > > from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> > > > addressed by Willem de Bruijn at netdevconf 0x17).
> > > >
> > > > There are a few areas that need optimization with the consideration=
 of
> > > > easier use and less performance impact, which I highlighted and mai=
nly
> > > > discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> > > > uAPI compatibility, extra system call overhead, and the need for
> > > > application modification. I initially managed to solve these issues
> > > > by writing a kernel module that hooks various key functions. Howeve=
r,
> > > > this approach is not suitable for the next kernel release. Therefor=
e,
> > > > a BPF extension was proposed. During recent period, Martin KaFai La=
u
> > > > provides invaluable suggestions about BPF along the way. Many thank=
s
> > > > here!
> > > >
> > > > In this series, I only support foundamental codes and tx for TCP.
> > >
> > > *fundamental*.
> > >
> > > May be just "only tx time stamping for TCP is supported..."
> > >
> > > > This approach mostly relies on existing SO_TIMESTAMPING feature, us=
ers
> > > > only needs to pass certain flags through bpf_setsocktopt() to a sep=
arate
> > > > tsflags. Please see the last selftest patch in this series.
> > > >
> > > > After this series, we could step by step implement more advanced
> > > > functions/flags already in SO_TIMESTAMPING feature for bpf extensio=
n.
> > >
> > > Patch 1-4 and 6-11 can use an extra "bpf:" tag in the subject line. P=
atch 13
> > > should be "selftests/bpf:" instead of "bpf:" in the subject.
> > >
> > > Please revisit the commit messages of this patch set to check for out=
dated
> > > comments from the earlier revisions. I may have missed some of them.
> >
> > Roger that, sir. Thanks for your help!
> >
> > >
> > > Overall, it looks close. I will review at your replies later.
> > >
> > > Willem, could you also take a look? Thanks.
> >
> > Right, some related parts need reviews from netdev experts as well.
> >
> > Willem, please help me review this when you're available. No rush :)
>
> I won't have much to add for the BPF side, to be clear.
>
> One small high level commit message point: as submitting-patches
> suggests, use imperative mood: "adds X" when the patch introduces a
> feature, not "I add". And "caller gets" rather than "we get".
>
> Specific case, with capitalization issue: "we need to Introduce".

Thanks for learning a new lesson. I will adjust them.

>
> I'll respond to a few inline code elements later. Nothing huge.
> Also feel free to post the next version and I'll respond to that, if
> you prefer.

I will post v8 soon. Thanks for your precious time. Have fun with your trip=
 :p

Thanks,
Jason

