Return-Path: <bpf+bounces-41408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1357996C99
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A3B21542
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56D1991CE;
	Wed,  9 Oct 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfcTVJdZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456438DE5;
	Wed,  9 Oct 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481668; cv=none; b=SFkQJHJ9eplj37109v7dotTRikRMUSbnhzfyeJcQHteLEi4p7C7/FcdkwHoYFwNbHV0y5aYzVoXekiHmtekkGcFugyk3b8T41opC6uRr9puzo9w0o4y/uRkkTtMd8Ph1elsRc9D9CCrC+dV7kEbvA5DxFmgQpAHWf5sUzRY3CmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481668; c=relaxed/simple;
	bh=Lj6MEJKjvsIyhG2LPbwa7R+8WxkMtk+pHKKt4YZkI+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQyAry4x40bjCRdcAuC9PUQOCRG8Uqrt1TXD0cylW4upP7m/gH8xGyGu13rPApyd+AcPfv3Lvd+CjhdfBX6zDEkQDjvbOdwhsfImv5F3rTHNO39qtzFQHURD5pDQCxDKRun4Ygcfe+tCz8BEHpH4KFfNPON7vF5Pw3EhemGUoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfcTVJdZ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a39cabb9b8so1985975ab.1;
        Wed, 09 Oct 2024 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728481665; x=1729086465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZeyqSXnEW/wySDEDmrRwMCqJGNUUqmSPWzOGXQFVsc=;
        b=kfcTVJdZc5488U1Eg2CQObeaC6mbMJmy2LPYijBrrutypDHMHi1L0Z3V/x1uvPHRVE
         IAm+/XlilT21DTg1whJ6BvVc1IFOw/fF3JVtrxZHaFgcI/jMFuCzBJ+CCBcOc7qFshxP
         CxSgXs3d0oUHSsq54VVEF21XvYkP7/z7LYvAlHDAkfuMQxqLIxGkGKUuUmwL4V9cwZOd
         Dr+Ik/d3Lzn8tvj/UDP6UNvfkYmi9b5/1znAMu+kuJ6QMIlzR9+HXjFWpuC+7GrW6lAb
         Qdlmbsmrx7+pbVx/brHgp7AjHiwsFy5NZMOMPSBRKMJF6laPUxxQdtSzVflA/UhP0F21
         nOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481665; x=1729086465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZeyqSXnEW/wySDEDmrRwMCqJGNUUqmSPWzOGXQFVsc=;
        b=wfNQpAuobQwUEbeVkBuiXy+Q/qpsQV4C4J1b6rqvUt9QHjf2p1SKWCS5h3Ru6vDLFR
         I53QTHltj/M9I8LGMYOwkORBlUKAwd3p5IfiqGCTL7dYRPGQ4IDE/TjErOcAv1xjNE7J
         HUKFnkNI91T16deIbWMKYnKPNJ2Xjyyl7aoYcB59YowWImS6WG6Je8lykeJCdy6cwwWM
         FeED33vcSIR7iSFKTe9aFjsFDkO8KzC5aw5B60ino1iPuy4mS4i0k+vZeWeujxVYDnBV
         IF5o2GaGMFnzY3n0mP/07wlUbngRAz/DkiQWdhng71bPTDDnzCkuI9Paqm+aQa7VzVmU
         Uq+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOxG3T3rlIenc7UM74l6VjnAL7vd0sFANRevOfJFY4rc6l9Fyzl44gvh13Eu4EQtKZ5Dk=@vger.kernel.org, AJvYcCX11yGv5mSBuxeYXoxCDXqrskE/0hV/yqXupJXFdSw7fTcSmMMJvcC6VDPViG5tppOsB4Yh7nxq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7AIdmCO6gCx+/56RDs+7gTbLnevpFo+7AxNP4QFbFlngMVwC
	eW+NMIwVlytGS4C20ZR5T7CyM2fsb4K71wouIfqzDMuU0gAAD1kwLgzUg9C30l7BSw+tSBYnxH3
	pAnqbAvtVV+skPZGhBOVhkja+sKA=
X-Google-Smtp-Source: AGHT+IE+AF95oOgsqTZOB7tBDYztJoew88PI+itbPgh/JdiQ0RXIRl21KLDiXOXAFuWaJKSou6Ci8Q8tthBsFXayEDI=
X-Received: by 2002:a92:c54d:0:b0:3a3:44b2:acb2 with SMTP id
 e9e14a558f8ab-3a397d19b4dmr26325785ab.25.1728481665536; Wed, 09 Oct 2024
 06:47:45 -0700 (PDT)
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
 <CAL+tcoD47VfZJFPJcQOgPsQuGA=jPfKU2548fJp2NBH14gEoHA@mail.gmail.com> <9c5b405c-9b3d-4c1f-b278-303fe24c7926@linux.dev>
In-Reply-To: <9c5b405c-9b3d-4c1f-b278-303fe24c7926@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 21:47:09 +0800
Message-ID: <CAL+tcoDDmcPQVUMN-AoGFC4SsmRwdVN+q0MAu+gAWY92Xy_zEA@mail.gmail.com>
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

On Wed, Oct 9, 2024 at 9:16=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 09/10/2024 12:48, Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 7:12=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >>
> >> On Wed, Oct 9, 2024 at 5:28=E2=80=AFPM Vadim Fedorenko
> >> <vadim.fedorenko@linux.dev> wrote:
> >>>
> >>> On 09/10/2024 02:05, Jason Xing wrote:
> >>>> On Wed, Oct 9, 2024 at 7:22=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> >>>>>
> >>>>> On Wed, Oct 9, 2024 at 2:44=E2=80=AFAM Willem de Bruijn
> >>>>> <willemdebruijn.kernel@gmail.com> wrote:
> >>>>>>
> >>>>>> Jason Xing wrote:
> >>>>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>>>
> >>>>>>> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by =
using
> >>>>>>> tracepoint to print information (say, tstamp) so that we can
> >>>>>>> transparently equip applications with this feature and require no
> >>>>>>> modification in user side.
> >>>>>>>
> >>>>>>> Later, we discussed at netconf and agreed that we can use bpf for=
 better
> >>>>>>> extension, which is mainly suggested by John Fastabend and Willem=
 de
> >>>>>>> Bruijn. Many thanks here! So I post this series to see if we have=
 a
> >>>>>>> better solution to extend.
> >>>>>>>
> >>>>>>> This approach relies on existing SO_TIMESTAMPING feature, for tx =
path,
> >>>>>>> users only needs to pass certain flags through bpf program to mak=
e sure
> >>>>>>> the last skb from each sendmsg() has timestamp related controlled=
 flag.
> >>>>>>> For rx path, we have to use bpf_setsockopt() to set the sk->sk_ts=
flags
> >>>>>>> and wait for the moment when recvmsg() is called.
> >>>>>>
> >>>>>> As you mention, overall I am very supportive of having a way to ad=
d
> >>>>>> timestamping by adminstrators, without having to rebuild applicati=
ons.
> >>>>>> BPF hooks seem to be the right place for this.
> >>>>>>
> >>>>>> There is existing kprobe/kretprobe/kfunc support. Supporting
> >>>>>> SO_TIMESTAMPING directly may be useful due to its targeted feature
> >>>>>> set, and correlation between measurements for the same data in the
> >>>>>> stream.
> >>>>>>
> >>>>>>> After this series, we could step by step implement more advanced
> >>>>>>> functions/flags already in SO_TIMESTAMPING feature for bpf extens=
ion.
> >>>>>>
> >>>>>> My main implementation concern is where this API overlaps with the
> >>>>>> existing user API, and how they might conflict. A few questions in=
 the
> >>>>>> patches.
> >>>>>
> >>>>> Agreed. That's also what I'm concerned about. So I decided to ask f=
or
> >>>>> related experts' help.
> >>>>>
> >>>>> How to deal with it without interfering with the existing apps in t=
he
> >>>>> right way is the key problem.
> >>>>
> >>>> What I try to implement is let the bpf program have the highest
> >>>> precedence. It's similar to RTO min, see the commit as an example:
> >>>>
> >>>> commit f086edef71be7174a16c1ed67ac65a085cda28b1
> >>>> Author: Kevin Yang <yyd@google.com>
> >>>> Date:   Mon Jun 3 21:30:54 2024 +0000
> >>>>
> >>>>       tcp: add sysctl_tcp_rto_min_us
> >>>>
> >>>>       Adding a sysctl knob to allow user to specify a default
> >>>>       rto_min at socket init time, other than using the hard
> >>>>       coded 200ms default rto_min.
> >>>>
> >>>>       Note that the rto_min route option has the highest precedence
> >>>>       for configuring this setting, followed by the TCP_BPF_RTO_MIN
> >>>>       socket option, followed by the tcp_rto_min_us sysctl.
> >>>>
> >>>> It includes three cases, 1) route option, 2) bpf option, 3) sysctl.
> >>>> The first priority can override others. It doesn't have a good
> >>>> chance/point to restore the icsk_rto_min field if users want to
> >>>> shutdown the bpf program because it is set in
> >>>> bpf_sol_tcp_setsockopt().
> >>>
> >>> rto_min example is slightly different. With tcp_rto_min the doesn't
> >>> expect any data to come back to user space while for timestamping the
> >>> app may be confused directly by providing more data, or by not provid=
ing
> >>> expected data. I believe some hint about requestor of the data is nee=
ded
> >>> here. It will also help to solve the problem of populating sk_err_que=
ue
> >>> mentioned by Martin.
> >>
> >> Sorry, I don't fully get it. In this patch series, this bpf extension
> >> feature will not rely on sk_err_queue any more to report tx timestamps
> >> to userspace. Bpf program can do that printing.
> >>
> >> Do you mean that it could be wrong if one skb carries the tsflags that
> >> are previously set due to the bpf program and then suddenly users
> >> detach the program? It indeed will put a new/cloned skb into the error
> >> queue. Interesting corner case. It seems I have to re-implement a
> >> totally independent tsflags for bpf extension feature. Do you have a
> >> better idea on this?
> >
> > I feel that if I could introduce bpf new flags like
> > SOF_TIMESTAMPING_TX_ACK_BPF for the last skb based on this patch
> > series, then it will not populate skb in sk_err_queue even users
> > remove the bpf program all of sudden. With this kind of specific bpf
> > flags, we can also avoid conflicting with the apps using
> > SO_TIEMSTAMPING feature. Let me give it a shot unless a better
> > solution shows up.
>
> It doesn't look great to have duplicate flags just to indicate that this
> particular timestamp was asked by a bpf program, even though it looks

Or introduce a new field in struct sock or struct sk_buff so that
existing SOF_TIMESTAMPING_* can be reused.

> like a straight forward solution. Sounds like we have to re-think the
> interface for timestamping requests, but I don't have proper suggestion
> right now.

Thanks for your help :)

Thanks,
Jason

