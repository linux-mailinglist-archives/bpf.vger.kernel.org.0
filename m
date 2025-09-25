Return-Path: <bpf+bounces-69788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E6BA1E56
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9506032850A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7032EC084;
	Thu, 25 Sep 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHyZAkup"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648081FA178
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841099; cv=none; b=stfnmG4XhRQwAvEh6zt7mQzsi7CH/nRxADo4MlkCCmlUPYDWw75s/AHIy0Ax4VqCGPF0ZUivlK4H7KoEWWZ4xY1t7ceVu8JniRGVLk5QOOBy1A8ThIHY0uwn2g+tns65LJJZXq+gOrzjniPcgIiDu+naV65jLCW1hC6KlG8dYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841099; c=relaxed/simple;
	bh=EGI0VKtO90tUguHp/csAdFKtFnwGdBIphF1jhiF0ZJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHxTrDSCezqbRzscwUqqYKRcmgYJxDpwkQTuxbQnFzrjhoNQUDxE8BasFHbBijuVTI/v/HmsDuZflVqdw9KO2nfpU1ezW3EXGz43nI9XC/jQBgREqreV0qo76k2VppHbE083qzhQ4i854CaoIF+ubHhY68CVNEj8XBPQEekIRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHyZAkup; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso2131033a12.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758841096; x=1759445896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGI0VKtO90tUguHp/csAdFKtFnwGdBIphF1jhiF0ZJ8=;
        b=BHyZAkupXByAeNeiu8KpnqHfwuLC918fLuLNAKQDUf3bfLaswlxipo8jvI7s73b1oI
         +xYg3b+67JedLpEbe3gqdbPyuwDjoFuVIW/aKRO3lr1aAmOmWzG8elemS06ACfIITgfX
         3jL5XeO6iv0r1Nrzo3N98+rxuYNCrMZnK7CwtUWRn73hltn9i7aF6QWR35ujyr0eaEyh
         KYo2I6E1Hh/D5x9T1Bnl8/hjZwsCjLl/iOaovZ30jcXL0gB2TvCWhffSMNhosTxEV8OT
         fDF8Ywg6JU46mHhAO+u0yPfLFOrgouuB2XoKfzJS9zkxhuTj0P55fKmSQskFeAcUical
         9zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841096; x=1759445896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGI0VKtO90tUguHp/csAdFKtFnwGdBIphF1jhiF0ZJ8=;
        b=Vo/dcb8ezcb1vP5JIIZopJU9LCljc7Tg+fCr6MTZfUqmF/FObUSiQKbk1E5NjTdSlc
         u321Avc2Orw1BUIwYBc2PbtuEkQi95T9QeVIeFGUUNmykEKOVTNPbVTxAPp5A9Uze9h6
         j4O0XJlWHO09MDYw4U0+8kSXzFIAdpZTb6WS3ZlODfwonrmHiLtCyrN4ptkVhmzvpChz
         d1AJzq6jFEOzHyjyPlwPKSksZpzxdQcC6qQW+gmROR00MO6vZWHEpV/p8aQ1gxuehN6H
         UQhBfykuCScI+3wrZYrM+VnZPwqbKSYUhRyWshMiSWBdXJcjjbAu/NO5XKmIGqBMDKGj
         AxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx59XLjepE9CF3xxa/xBD8GMgxLg5ik4m+VAiBDUwJwJ/76SE2Vm4tdDXbVyibzW8XsDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmu5WQJ/05q9npeWRt/zaUaQM0Gm+z0cSJP8RzTO+2pWob1As
	QgKXl2WDXjn4pCFZYVPiwzdZGQcEoy4srD8t+oTiad+j3ikU7ZvWYQgeAZp39/ZY6B320wl6R9G
	DWwJZi3Ccpc3PqOMPATPSVfyUbXQm21w=
X-Gm-Gg: ASbGncuzhdvCggMDQsh3zcm51/yvTV2sBl6AlQaz0LAG1D1qqSULS/tbiooTvoD1sD4
	gQ2GBkGoau9+clCl8kJWv0noAc48QfvXtVSICS9eVzigLem0Q0r82YKjCol4BKwbTOLJh5ldzFq
	2CRiCq+VSynE7xv+XdZjUOGt1YhET24LBtXNP9AwYHiBmjgvNkFALRElr0eFNbqxYLY8N9E4Hzd
	+nYn9oJ
X-Google-Smtp-Source: AGHT+IG6dZ35x5bDgUuw4QrvRabnHS4/D/SWmHzKvuSxWRSRGYzL2hdkdNZkmYKtDNqI+142flF6CULs9h+erXFPrvQ=
X-Received: by 2002:a05:6402:13d4:b0:634:ad83:2111 with SMTP id
 4fb4d7f45d1cf-634ad83294cmr2160548a12.37.1758841095418; Thu, 25 Sep 2025
 15:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
 <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com> <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 26 Sep 2025 00:57:38 +0200
X-Gm-Features: AS18NWBgES_yAotZiqAXmmp5YG4bTjXs4aEKV9PgMXW38CURtkF9LS0LudV08Ok
Message-ID: <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sept 2025 at 00:54, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag on
> > > the kernel side of things and having access to full BTF information
> > > for parameters to let verifier know what specific kind of magic
> > > argument that kfunc has, though. So as an alternative, maybe we can
> > > create both a kfunc definition *meant for BPF programs* (i.e., withou=
t
> > > magic argument(s)), and then have a full original definition (produce=
d
> > > by pahole, it will need to understand KF_MAGIC_ARGS anyways) with ful=
l
> > > type information *for internal BPF verifier needs*. I don't know
> > > what's the best way to do that, maybe just a special ".magic" suffix,
> > > just to let the verifier easily find that? On the kernel side, if
> > > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magic"
> > > FUNC definition?
> >
> > Interesting idea. Maybe to simplify backward compat the pahole can
> > emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> > into vmlinux BTF.
> > bpftool will emit both in vmlinux.h and bpf side doesn't need to change=
.
> > libbpf doesn't need to change either.
> > The verifier would need a special check to resolve two kfunc BTFs
> > name into one kallsym name, since both kfuncs is one actual function
> > on the kernel.
> > bpf_wq_set_callback_impl() definition doesn't change. Only:
> > -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
> >
> > and the verifier can check that the last arg is aux__prog when
> > KF_PROG_ARG is specified.
> >
> > The runtime performance will be slightly better too, since
> > no need for wrappers like:
> >
> > +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > + int (callback_fn)(void *map, int *key, void *value),
> > + unsigned int flags,
> > + void *aux__prog)
> > +{
> > + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> > +}
> >
> > It's just one jmpl insn, but still.
>
> So basically xxx_impl() will be a phantom function that verifier will
> recognize and it will need to have corresponding xxx() kfunc with
> corresponding KF_PROG_ARG for everything to work. Makes sense.
>
> Two notes:
>
> a) KF flag would need to be more generically named, because we'll have
> other implicit arguments (like those for bpf_obj_new_impl, for
> example), which will be distinguished based on their BTF type
>
> b) bpf_stream_vprintk() throws a bit of a wrench into all this because
> it doesn't follow _impl naming convention. Any suggestions on how to
> deal with that?

We can probably do a compat break for this kfunc alone for now, it's
not been a long time since it's been out (1 release) not much adoption
yet.
And then double down on this convention going forward.

>

