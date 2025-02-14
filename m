Return-Path: <bpf+bounces-51624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5BA36906
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B292016FC8C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B91FCF6B;
	Fri, 14 Feb 2025 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZckkF3oK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7391FC7F2;
	Fri, 14 Feb 2025 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575323; cv=none; b=EF6wtyNecCy2W1W/dD9yfBwfmk3k0S/RVs4f0yZr0xqKVNUxZrOgYys0woJU30CiIVxogvkzeOseFzIPiOeOW7EiyeS3RJU0O/w9in01oN6w0YkF3za20I9IicMSJt+eQebuf7wZ2ImVJSmcgC0Kzcrmphq/QB4ng48Gfq3T0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575323; c=relaxed/simple;
	bh=HGwES3ViKUiFB3SXCd8iHDNtzpEQGOUNeUOszO6Ih18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZz3seBcKL39iy2reUEGdvHM+4P/y+eAqJZ+8iHWmdk90zChmmvkVxDPGGFZ7gVDRJHHIsMOPYEY+enI5kuwzfCFjDNTgWQzk8tdI9ttABBRTgfuy3IbHnNUuQwtSadto0dqTQfu5x3Gru1aV0rFDruGNnmfSQrzgWtWFdjAdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZckkF3oK; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d19d214f0aso9493885ab.1;
        Fri, 14 Feb 2025 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739575321; x=1740180121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNoRSYbJUL3rdi6b/fdK0or9xvcqFCleykHk2oGXX1s=;
        b=ZckkF3oKabd0+9jKXUTlm4XDnA2w4/PL8WW0SCloivA3RqwCLv42mrDFgIWtK9j0KG
         Z9qMCWP1H9OuZq9KXFbQvrjzxg0Ffu/TSElGtoQD+73m0ubwqv+CKsSRVTju2E6AnI+t
         3KHQgh5BE+LGBfGhOCLq3kW7qSThxI1k7HnYP5uAzMP2p4Dhop4HO0Z+XKFZokuUs86a
         +xc8g6L75/bbydWDMWVdxtLkZvpY2NFtRn7ep9QY9qyRx6a+6a3XmXkpVbCgXY0P6FVx
         l9FS48iZqhuCYvG5qyyDKSiwL7b5OCDO/yTJAyQ1QFIH8R0OAG4GcnjojoGMGaNaIsFS
         RbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739575321; x=1740180121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNoRSYbJUL3rdi6b/fdK0or9xvcqFCleykHk2oGXX1s=;
        b=tLsPqAqZUmqP07JoyuBTCr4St6TtiCZcMZtW2FebgE6X4/eHDqJh3b6Jpn6pnKd76l
         GMhS9XH4edS1Fkkp3bc7uG5WPyIW8A64VtKguzh0a855cQUcZ5pHLKaYwu/+4gCte1hN
         if+WFZzfax5zILkOH1np8AurtLg+PKCHUSrX3Lof8S9jIiIlYaLg4BlSeaU5SzH4TKsd
         Oa1Psb11k2XTuCRk8nJ+cC2tXJwb5Qxx5QHCxFyNeuQfYjU05vZurccEzf2UQoyvbUR3
         KH+wMpVdUdvEhH8AoGe4iTBHoFDssbv9pNss6MJiS7uqc+HEVrZXuGHplFU4D47CZddG
         ClVA==
X-Forwarded-Encrypted: i=1; AJvYcCVCp8UF+fMgef3zn3tpSK3Oztf2myUPfj9GjpEVqOOmVobTGeI8rPPq0SEJ4UnukkberZWxLfa9@vger.kernel.org, AJvYcCVZz0Fas+cqZsZr2qkR0JgVwGKUwtbwivdFEwbatUKxH1hLyj1PYHqOvvdM7ILukUKdscg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWvm/CgTntGqSdCnite6O0CxAhTS7ql7XKALTplIm10NzynEz
	cjQb9jpN+JY8F6tzdM12vWNfSM8zVYq8ysnPv73IFrKF7ok67iPwnUunceovq4ZUKozZhntUyaP
	pDNZDnUKdSQ+iyE/p+SPxAjGbKzI=
X-Gm-Gg: ASbGncsPCtCGTLz9IA2ZbR2F9yHx6u2cqNELlw7BcqRxFdY/it2EFmEh69WJsb2+HiZ
	4wb6tfeDvHRX0ozHOX6LX9n1QlvALDAv0qkBRTCpIyYPEWLVtMK7OLUn3QJolPdIg4hgZGB1I
X-Google-Smtp-Source: AGHT+IGLEr9YOZeiRonLJDV8uk2pi1K84QElVat5W4GnDlJ+6Wlb4eedf8eNJfkxta/nGoVjylkWwo34SBKL0ciRn94=
X-Received: by 2002:a05:6e02:1446:b0:3d1:9cee:3d2f with SMTP id
 e9e14a558f8ab-3d28098a133mr12000255ab.18.1739575320701; Fri, 14 Feb 2025
 15:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com> <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com> <Z69lzNYwBb-5CPvX@mini-arch>
In-Reply-To: <Z69lzNYwBb-5CPvX@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 07:21:23 +0800
X-Gm-Features: AWEUYZm-OePH5mOLHgiX-BUTi_02eOxNvE5yax8xfbl28BAAhUiR6leWHgli6gY
Message-ID: <CAL+tcoBDS=ou-XLgwoBabSJ5SvE0z9zgnab_1ySWfnrgC93Ctg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 11:48=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 02/14, Jason Xing wrote:
> > On Fri, Feb 14, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 02/13, Jason Xing wrote:
> > > > Support bpf_setsockopt() to set the maximum value of RTO for
> > > > BPF program.
> > > >
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > >  Documentation/networking/ip-sysctl.rst | 3 ++-
> > > >  include/uapi/linux/bpf.h               | 2 ++
> > > >  net/core/filter.c                      | 6 ++++++
> > > >  tools/include/uapi/linux/bpf.h         | 2 ++
> > > >  4 files changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation=
/networking/ip-sysctl.rst
> > > > index 054561f8dcae..78eb0959438a 100644
> > > > --- a/Documentation/networking/ip-sysctl.rst
> > > > +++ b/Documentation/networking/ip-sysctl.rst
> > > > @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> > > >
> > > >  tcp_rto_max_ms - INTEGER
> > > >       Maximal TCP retransmission timeout (in ms).
> > > > -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
> > > > +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option ha=
ve the
> > > > +     higher precedence for configuring this setting.
> > >
> > > The cover letter needs more explanation about the motivation. And
> > > the precedence as well.
> >
> > I am targeting the net-next tree because of recent changes[1] made by
> > Eric. It probably hasn't merged into the bpf-next tree.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3Dae9b3c0e79bc
> >
> > >
> > > WRT precedence, can you install setsockopt cgroup program and filter =
out
> > > calls to TCP_RTO_MAX_MS?
> >
> > Yesterday, as suggested by Kuniyuki, I decided to re-use the same
> > logic of TCP_RTO_MAX_MS for bpf_setsockopt():
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 2ec162dd83c4..ffec7b4357f9 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int o=
ptname,
> >         case TCP_USER_TIMEOUT:
> >         case TCP_NOTSENT_LOWAT:
> >         case TCP_SAVE_SYN:
> > +       case TCP_RTO_MAX_MS:
> >                 if (*optlen !=3D sizeof(int))
> >                         return -EINVAL;
> >                 break;
> >
> > Are you referring to using the previous way (by introducing a new flag
> > for BPF) because we need to know the explicit precedence between
> > setsockopt() and bpf_setsockopt() or other reasons? If so, I think
> > there are more places than setsockopt() to modify.
> >
> > And, sorry that I don't follow what you meant by saying "install
> > setsockopt cgroup program" here. Please provide more hints.
>
> Ah, sorry, I misread it as bpf options taking precedence over tcp ones;
> ignore the suggestion about setsockopt cgroup prog.
>
> And yes, reusing the logic of TCP_RTO_MAX_MS looks better!

Okay, then I will send a patch soon. BTW, which tree should this
series go in? Should I use the prefix '[patch bpf-next]' or something
else in the title?

Thanks,
Jason

