Return-Path: <bpf+bounces-41393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B7996936
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288B3B25647
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D619258B;
	Wed,  9 Oct 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKVPX6WD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00B17CA0B;
	Wed,  9 Oct 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474560; cv=none; b=bWITk9yYtz/Jwncp1XYscn1A3HbJVKZ6KUlntoOsGsbZ0g/SVOiEZIPJxVtBnvLC5dAWuWQ9PM8VdEGKo20jK65cqaG8PfhQYdYEYrd2j8uwTf/CeJj69r8EbnhlEOSsw7OCAHqFj8KhRIv9mvSLZlHLIlrz7SIlESSNiikCO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474560; c=relaxed/simple;
	bh=AhQ6MGEb8KyXASafcsdjnqQ2YSaM2uHoDEqEY8rO1Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egbA4Dw3x0dPjEYBEPHDPZSAgGOjrWPCTzXNT4DCYHIOPcnudDgevKj2NLxNdmSWmoro9loSXqO/uWb8mWe46a4yLB1gmlltITjLK0xQ0CNdlDfksiIdX411x8hg9HLmiAtDV9tm1y0sFh40ZtxwRBNt4CWI0IInJHRlLHotFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKVPX6WD; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8353b41369fso55722839f.3;
        Wed, 09 Oct 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474558; x=1729079358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIEdmZgxIFPQaTGy8TWOL7Nouo8WEwnQXonw9kdpw3I=;
        b=iKVPX6WDwTeWBIiYiEntUpUGoUXXBaMW5DyYyeDFmP1jBhTcf3K4mLwngHtO8kBmV0
         4pHSMjSCLyKvdpCngtEmMl0VfTT+izRj9vFQUqNDZT/se+Gt4Edkg83gDVoUNeSHNC8P
         yKFKlC/fmeUBJ1BS8GktzG1p3M/kJhfzL8Y0pPY2PsKtkvyd6Y5JyjVXEF2riU415A1P
         IG6ahCImPE7PNDEOxW3QNGgFii4prRT2BOFZ7+sw6U7ULBeGQpY5zxAiCyjlmOppuyFO
         Y+f2Gx6fP8lnHtt9UwKT/Dp5mjD2gnoF2T4nDQdowvdj4CIRF/1vgtNzBD80UVQ335fK
         pADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474558; x=1729079358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIEdmZgxIFPQaTGy8TWOL7Nouo8WEwnQXonw9kdpw3I=;
        b=wqUfJGLblCiN1oco2GMr5T3QNx9Wnf1VF4NFJ4PI/JsjwIoN1iXtrYsLbwePl1zSit
         MFaCzujls/egwrF2mWrgRLq/Zzd71uwcUqwGTbzZ5u9Aiwilt25QckuR0x7wgpQXHLXe
         OxXhcRbpU0hojAfNmn4rlT29w8KG/M6QQoWJ3MMSMsKc6tWBYLWiJ83e3bFKs2YVIVe0
         AX0w8ASt79cP2K7OVKXrNScAxb6OzpH1EjxT0W+VLMjW2lrp5sd9KC4B5dcfKN5J+abA
         9jLmmjBSizKsE8RMoKERpPOFna6op9VLWi5CeULfHW4zF1PRzm2BhBpifs42Sr3Svcpj
         zAPg==
X-Forwarded-Encrypted: i=1; AJvYcCWGBf1KxIpOM6msQOur8Keb41aH3fvtPbea6AOTksmyrfcU2kULjqIj6GBTHwtH3kLGl4M=@vger.kernel.org, AJvYcCXriXdXKONiFjaUKTGFtv8vep8eeBpEfwEXjYbotaYmXaZ9/TREuq3kuGagpUJvfD9E+aCcPFK2@vger.kernel.org
X-Gm-Message-State: AOJu0YyTI8NFjw/i4jNKpE6luGZ2YWgl55bJZ+GhWXGcQWEUhTBjQrZj
	NJx5eMtEWU1UWACfvIF9ADt2Jd01mngxLYrlHc7bjRZB7uMGl+fTGC12Z4juyRrvw8VrNn+MNO2
	6jm02NlZbmb/T24OQUF5s19pZKUI=
X-Google-Smtp-Source: AGHT+IF+xYzLzC4dGF5CPU7DnWbpfcrUnJPSeKGoRxS2bs6tMe0aknNwsK/FYQkVPUU/sIaF30iG16JQM4QEVJOqrHA=
X-Received: by 2002:a05:6e02:16c6:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a397d09e66mr18312025ab.10.1728474557704; Wed, 09 Oct 2024
 04:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch> <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
 <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
 <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev> <CAL+tcoBL22WsUbooOv6XXcGGugNyogiDhOpszGR_yj-pCdvCkA@mail.gmail.com>
In-Reply-To: <CAL+tcoBL22WsUbooOv6XXcGGugNyogiDhOpszGR_yj-pCdvCkA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 19:48:41 +0800
Message-ID: <CAL+tcoD47VfZJFPJcQOgPsQuGA=jPfKU2548fJp2NBH14gEoHA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 7:12=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Oct 9, 2024 at 5:28=E2=80=AFPM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
> >
> > On 09/10/2024 02:05, Jason Xing wrote:
> > > On Wed, Oct 9, 2024 at 7:22=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >>
> > >> On Wed, Oct 9, 2024 at 2:44=E2=80=AFAM Willem de Bruijn
> > >> <willemdebruijn.kernel@gmail.com> wrote:
> > >>>
> > >>> Jason Xing wrote:
> > >>>> From: Jason Xing <kernelxing@tencent.com>
> > >>>>
> > >>>> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by u=
sing
> > >>>> tracepoint to print information (say, tstamp) so that we can
> > >>>> transparently equip applications with this feature and require no
> > >>>> modification in user side.
> > >>>>
> > >>>> Later, we discussed at netconf and agreed that we can use bpf for =
better
> > >>>> extension, which is mainly suggested by John Fastabend and Willem =
de
> > >>>> Bruijn. Many thanks here! So I post this series to see if we have =
a
> > >>>> better solution to extend.
> > >>>>
> > >>>> This approach relies on existing SO_TIMESTAMPING feature, for tx p=
ath,
> > >>>> users only needs to pass certain flags through bpf program to make=
 sure
> > >>>> the last skb from each sendmsg() has timestamp related controlled =
flag.
> > >>>> For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsf=
lags
> > >>>> and wait for the moment when recvmsg() is called.
> > >>>
> > >>> As you mention, overall I am very supportive of having a way to add
> > >>> timestamping by adminstrators, without having to rebuild applicatio=
ns.
> > >>> BPF hooks seem to be the right place for this.
> > >>>
> > >>> There is existing kprobe/kretprobe/kfunc support. Supporting
> > >>> SO_TIMESTAMPING directly may be useful due to its targeted feature
> > >>> set, and correlation between measurements for the same data in the
> > >>> stream.
> > >>>
> > >>>> After this series, we could step by step implement more advanced
> > >>>> functions/flags already in SO_TIMESTAMPING feature for bpf extensi=
on.
> > >>>
> > >>> My main implementation concern is where this API overlaps with the
> > >>> existing user API, and how they might conflict. A few questions in =
the
> > >>> patches.
> > >>
> > >> Agreed. That's also what I'm concerned about. So I decided to ask fo=
r
> > >> related experts' help.
> > >>
> > >> How to deal with it without interfering with the existing apps in th=
e
> > >> right way is the key problem.
> > >
> > > What I try to implement is let the bpf program have the highest
> > > precedence. It's similar to RTO min, see the commit as an example:
> > >
> > > commit f086edef71be7174a16c1ed67ac65a085cda28b1
> > > Author: Kevin Yang <yyd@google.com>
> > > Date:   Mon Jun 3 21:30:54 2024 +0000
> > >
> > >      tcp: add sysctl_tcp_rto_min_us
> > >
> > >      Adding a sysctl knob to allow user to specify a default
> > >      rto_min at socket init time, other than using the hard
> > >      coded 200ms default rto_min.
> > >
> > >      Note that the rto_min route option has the highest precedence
> > >      for configuring this setting, followed by the TCP_BPF_RTO_MIN
> > >      socket option, followed by the tcp_rto_min_us sysctl.
> > >
> > > It includes three cases, 1) route option, 2) bpf option, 3) sysctl.
> > > The first priority can override others. It doesn't have a good
> > > chance/point to restore the icsk_rto_min field if users want to
> > > shutdown the bpf program because it is set in
> > > bpf_sol_tcp_setsockopt().
> >
> > rto_min example is slightly different. With tcp_rto_min the doesn't
> > expect any data to come back to user space while for timestamping the
> > app may be confused directly by providing more data, or by not providin=
g
> > expected data. I believe some hint about requestor of the data is neede=
d
> > here. It will also help to solve the problem of populating sk_err_queue
> > mentioned by Martin.
>
> Sorry, I don't fully get it. In this patch series, this bpf extension
> feature will not rely on sk_err_queue any more to report tx timestamps
> to userspace. Bpf program can do that printing.
>
> Do you mean that it could be wrong if one skb carries the tsflags that
> are previously set due to the bpf program and then suddenly users
> detach the program? It indeed will put a new/cloned skb into the error
> queue. Interesting corner case. It seems I have to re-implement a
> totally independent tsflags for bpf extension feature. Do you have a
> better idea on this?

I feel that if I could introduce bpf new flags like
SOF_TIMESTAMPING_TX_ACK_BPF for the last skb based on this patch
series, then it will not populate skb in sk_err_queue even users
remove the bpf program all of sudden. With this kind of specific bpf
flags, we can also avoid conflicting with the apps using
SO_TIEMSTAMPING feature. Let me give it a shot unless a better
solution shows up.

