Return-Path: <bpf+bounces-40451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A16988CDD
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 01:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5EB28328C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 23:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5B1B6527;
	Fri, 27 Sep 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du71w7tc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AD1B6520
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478526; cv=none; b=Gc0ZT+qMa72WCuJdbuw3slD7y1xiG+vpQk/rtj+1cpJX8OvDmzHuHFs6q9M/WtnHA2vBa4l+y/BNkuUSdrOOKobPet7kpjwhC31X7UOEZgWneoJk9fxuFa4DF+ZttU0eXTtxyVzrYsYZtqha2cw958AeXdpg05ooaseHF11Mvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478526; c=relaxed/simple;
	bh=a9G8niNlzCvMwtTLh+DMGdao6dqsGdZsufgq5H/vSpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quN9NINj3D2cTKqn+EAXQCT7B1BduwQkIvrJpWtE9dwMHecrr+Jh+frJ0rw03UU/sbWQF1kvnZGlh5xqTRISd8UNZ0DHdPIhrsWX+s4yKwsGEDUxcxtEzExI7SMP4xYwH7e94w5VwHQ1uShfhHxjEdFEREZIjpzmUnwu4pYXh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du71w7tc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e07ad50a03so2046195a91.3
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727478525; x=1728083325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jWlUazC5bpMD7f8HBX4L8FciEvqU1saorIRpD+V+kg=;
        b=du71w7tcyY1GRkbzDz616IL7tWZ0PaOVBaHEjrknCbM1MbIteHg7vyXnLv0n6CdNdS
         4UW7209e9vfzluLDE7TItxGLeA94c3OoEwy4G6EgCGDd5G5po4sRjRAxSyH4TS70Klf4
         hECcHuT8+9wzkyokHngoJJFjV1wbsg48bwiTJMD63iZzhkW9cpi+O57zMZSFwxhhyZNG
         ophwrJ5RS2RdhSuzBUDbm5jrsTqkxcBHnQLpFklWAbVzO1dQ+qblgEwwA0QlSg4Sphwx
         9XtWcNoTIchNbgxGxcOoJ8tsEIYfbzfkkzhpiobtFkr1a/mlElPEzLhyiFyR0HjT9r/F
         xY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727478525; x=1728083325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jWlUazC5bpMD7f8HBX4L8FciEvqU1saorIRpD+V+kg=;
        b=otVogFPxHDWOJI+r+5y54yAMOlm+dV1cWlIOVWmVTZ/WYh7nvGHd5FDUlRlTynMxmC
         JM8jl7OW5ydxiL89MAQpyzSG0Ma3v9z9jicd5hwW0J6Dkimo/kSAHvRCSLrbHFNHXaID
         nZedGHEAwqwIq67aMLxx1Zsb2y9a7xHU9zvsKnNWBgJuf00SAtgEbirV6UVg5fzGeC2x
         Uu/H/5vwBY7kPWd71LQugw+T83kU6qXWQyU6OZdlATRIZa7vhUwtk7soA25QY4c4rsRk
         sO2WinKvkxy2ZmYagslZ5VNj3NfJw9eyZAFLzOvD3nJIPxKSVfjrKcOhT+ZxIz1Dpjxg
         dCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbtW/fmnTjerxLtS4QlJaedOu8mZA9dvT35WoV8r+DMLE81sqnFgrRzOROAPTzEi3YkTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDkHJaycU9ngqlFEK96tUh4L+pSwTvJPeq7WhVh6AxlBmZ+Nbf
	fpdsVd4+bnMzoeAziC6t+zvDbSqStuJgE9S+oFInBv6DWJWp8VvuH6J0hRUG1kl+wrR0E8drKla
	pYgs1R7VnVPA2uU7zIOI4e5S2VI3PrQ==
X-Google-Smtp-Source: AGHT+IFPNJWzvM92TL6XxiTGnCGA67I4o/oHO2YJFWSam4s7lOewZh34QdU3V2d6YcNmdU5esy3aNlxldMRJXiOCLYE=
X-Received: by 2002:a17:90a:fe17:b0:2e0:a290:2b7a with SMTP id
 98e67ed59e1d1-2e0b8872d64mr5401824a91.7.1727478524767; Fri, 27 Sep 2024
 16:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com>
 <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com> <CAL+tcoDEpGq3NfYgavc=wwgsMch=L7mh9-0J8tWv2Sv1MWCH+w@mail.gmail.com>
In-Reply-To: <CAL+tcoDEpGq3NfYgavc=wwgsMch=L7mh9-0J8tWv2Sv1MWCH+w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 16:08:32 -0700
Message-ID: <CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 12:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Thu, Sep 19, 2024 at 11:17=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In some environments (gcc treated as error in W=3D1, which is default=
), if we
> > > make -C samples/bpf/, it will be stopped because of
> > > "no previous prototype" error like this:
> > >
> > >   ../samples/bpf/syscall_nrs.c:7:6:
> > >   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 =
[-Werror=3Dmissing-prototypes]
> > >    void syscall_defines(void)
> > >         ^~~~~~~~~~~~~~~
> >
> > samples/bpf/ doesn't accept patches any more.
> > If this samples/test is useful, refactor it to the test_progs framework=
.
> > Otherwise delete it.
> >
> > pw-bot: cr
>
> After reconsidering what Alexei said, I still feel we could take this
> patch? It is because:
> 1) the patch itself  is more of a fix instead of optimization,
> 2)as long as samples/bpf exists in the kernel, we cannot easily let
> it(issues) go and ignore it.
>
> Applying such a patch won't cause any further confusion, right? As we
> can see, it's like a fix which does not introduce anything new here.
>
> What do you bpf maintainers think?

I think it's fine to minimally fix the issue in samples/bpf, but I
don't think this weirdly-looking extra declaration is the best fix.

Can you mark that function static? Will that work? Or, as a plan B,
use pragma to disable this warning, it's clearly "expected" in this
case.

>
> Thanks,
> Jason

