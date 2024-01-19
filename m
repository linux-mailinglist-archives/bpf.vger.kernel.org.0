Return-Path: <bpf+bounces-19916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5325833058
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E73828489F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5458100;
	Fri, 19 Jan 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDjPkwBh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E551DFCB
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700086; cv=none; b=ezTXq2ax77CoHRbFcv2I+qddbIiFgDdN+QdqS1heskw2WdNpPFn2Ih/I470qIbKZRgxtk2wBHvWo8Q+KObh8CqShCcNGsX+p6ttfl9DTn9NA5Ed9YThucjqgMS4III7TQd1ngyWvsmus9T6Vxo5kZt8QEi5HKpUZr39D4hg0FOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700086; c=relaxed/simple;
	bh=IPJp1WoVDiiiQbT0iGWL7OUaMCzCJlc9F76HAwr+Qck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/9MZrnoFor51R/G4hnUqA9PWRzU1qr2SGl1RE1Ml3vNs3jDsX7ojk5NaKXIm2dyO5CcZJMUnui1OhuVZ+W9as9khR1w37EyOc931DZrHFrgV9cluU3h+3QuAjsZviaxoOOvC64jCEKcr7bgJjBVxjitIfWyRknU3B13NtKa704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDjPkwBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8832C43390
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705700085;
	bh=IPJp1WoVDiiiQbT0iGWL7OUaMCzCJlc9F76HAwr+Qck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kDjPkwBhsdfseHhGAAHOkc41jzWsqwtjw36OKmGd2PwLdOIUEBhg7trvzxkwgJcPR
	 xTzQ8dDygSZB/mUXweAitAMzTtjjQ7wu7eGQAsMYtGHVpQSX+KfrwqrljdOzco19nL
	 GEJ+iOxMhddDWSjP6cXlM/WdgYHX6GDZYR4/ThKhfLGeeawlZY5xaV3L685TZB75o4
	 nceHD9Fu9OqIkdjWX37BnnWl5XWDMyy7CDpXMUMHQQ8AE6cNGc81iNv4J1N1KdAkns
	 X3pxCDbh90Z3V7Hrq6s0RQRi/A4G7WriZheMsLcLYPIq74VXGhbuTXItSL3abj1X3t
	 uIbqrmRSjLk+Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea98440a7so1318078e87.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:34:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwKKXYJ1IRRbY0zVkcGX/7B3a+iMdgMEmjsaf0AH9qtAOcDen8U
	5JMmg7gaLSjF9Bz1GQzNdVtycmWdN6VleOcs21/sd4Jp3oX1ve63c06BOBYZ9ndaXYrR0HRQkfo
	AgSn/TkcDsilpfEgmTUE18ZEqimE=
X-Google-Smtp-Source: AGHT+IHQ9VtBTbXo65EUsuhKb/uwO3dKsxovylGl/5dt9QicLaYy1PdrRO82xzFRaDWKGg9lxZPMb5fq6jxLdudLiQI=
X-Received: by 2002:ac2:5f10:0:b0:50e:7719:4687 with SMTP id
 16-20020ac25f10000000b0050e77194687mr93419lfq.145.1705700083822; Fri, 19 Jan
 2024 13:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119210201.1295511-1-andrii@kernel.org> <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
 <CAEf4BzZRaKsJ0T3LGxeCchSgLi6Gvs5-0pe0Ba6DQpFFSiF66w@mail.gmail.com> <CAEf4BzaHz3VRUs=vHC7u5rZmTHE7CTs78oYcOHripWM266QA+A@mail.gmail.com>
In-Reply-To: <CAEf4BzaHz3VRUs=vHC7u5rZmTHE7CTs78oYcOHripWM266QA+A@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 13:34:32 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7PZ4aMmtZrTHx-R9yyU6aJbHhmEVhxL=CB6L+4Og9BAw@mail.gmail.com>
Message-ID: <CAPhsuW7PZ4aMmtZrTHx-R9yyU6aJbHhmEVhxL=CB6L+4Og9BAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:30=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 19, 2024 at 1:21=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 19, 2024 at 1:18=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Fri, Jan 19, 2024 at 1:02=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >
> > > > We've ran into issues with using dup2() API in production setting, =
where
> > > > libbpf is linked into large production environment and ends up call=
ing
> > > > uninteded custom implementations of dup2(). These custom implementa=
tions
> > >
> > > typo: unintended
> >
> > oops, but probably doesn't warrant respinning
> >
> > >
> > > > don't provide atomic FD replacement guarantees of dup2() syscall,
> > > > leading to subtle and hard to debug issues.
> > > >
> > > > To prevent this in the future and guarantee that no libc implementa=
tion
> > > > will do their own custom non-atomic dup2() implementation, call dup=
2()
> > > > syscall directly with syscall(SYS_dup2).
> > > >
> > > > Note that some architectures don't seem to provide dup2 and have du=
p3
> > > > instead. Try to detect and pick best syscall.
> > >
> > > I wonder whether we can just always use dup3().
> >
> > dup3() (according to my git foo) was added in 4.17, which is more
> > modern than some other usable BPF, so I don't want to just randomly
> > bump the minimal supported (by libbpf) kernel for something like this.
> >

I believe dup3() was added in 3.7.

>
> Btw, this #ifdef check is the same as what glibc does for its
> implementation of dup2() (except for fd equality check which isn't
> necessary for libbpf), see [0]
>
>   [0] https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux=
/dup2.c

Yep, this looks good.

Thanks,
Song

