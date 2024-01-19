Return-Path: <bpf+bounces-19914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7728E833049
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17379B23FE4
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6257888;
	Fri, 19 Jan 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsPONiWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053A1DFCB
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699812; cv=none; b=Khm47ruqiaYrS+h5m0o3T4/Y6c4fnQVI7UVeQ4nqby2UIz+q+A6f9qXmRY2tnjmqUgKwMjr9W62ZObnwjGA8PI5Fdo6HrknVY/r9mQSc4F7L8xOGsYXPUoVK8L+ZyBkGL9+UPaKD4dw/QkPvPCB/YzQFHhRy9CL1YgPJ6f816WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699812; c=relaxed/simple;
	bh=PF0FA1vETmfKTnEzLOREgp04SlfWStAELP+VqpnOBtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKYtAivAVNGd94gZEXRbu5lc2vRlE9eS9VMgkdF2p+RMIHrsRA7BBdvFpm0jB29aofu2TQnVveFzI/SaQq2WyHix8tnR80Ax9Miee2mW/cDG0x1MBXnbwGNr9LuxoU6dko6/qI0VK5hXJO3RD8EdNfhCBU/uTrCeT4M6Ah0jksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsPONiWs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da202aa138so1225868b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705699810; x=1706304610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VysGD5M9/OLbIAZUFpAQFWEpktPuzDt6XvLumH/1j+M=;
        b=gsPONiWsZB7PSQvFcd0H0epZMvM0TS4rr2S1qLOXnYIdrt2Mto7cGNTS1IMxIEM+oK
         O7WrD6Oco08k5d2/oueBvI6U758KvsYc6D3nMiPjzzClmiXQFkwvdJe97mS9u6b5uCHv
         dYQ3HlPfczs7tftnmgNcvPTQ4Rthqwx0e8LwtL63FDpxvHMoUoWALjgg9uSo7t9FnkeY
         1RnBGW/dfXPgeb6UrsfeZukmT5MhkokHInDEch036Da24YudeyjXIn7u8MTXkjouXtsn
         8OL9EayYotemRhla/2PEqCYbG/nd02DDsA4pbpP178bL0GQ5VNZn2QLuXUChCtA+x9F3
         jFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699810; x=1706304610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VysGD5M9/OLbIAZUFpAQFWEpktPuzDt6XvLumH/1j+M=;
        b=SpyivfZ8nCfh/gHAy8bm0HlMgysrYaAXSHVttDPZ8NPhWe8MRKj9o4jVXH6ZZD1L4N
         CbntphHYBPicKyGNIGbcM2yVOiqvCCQ3D+x7eznjZuP7rFdXtc4dsw8FF1YiwUDBevKP
         7Xmh56TIboidLX7QSFC20d1OjDhkz0c6RCnBYsd4IRoiJDylpIypJUvFehdbXn1mikK3
         C026eAhiwrfvb64Fw+SBaNlZU0QIRBTCOJM0rQ16mJDRy71yVu6Lv21X99beY8TN44Hq
         tri7vdAwkN/uNh/GdWiziuttGZCsZIEk7mFU28+7VS9HO3JzZfyW5GeuN8Ya72Fyu4Z6
         szpQ==
X-Gm-Message-State: AOJu0YypZiV5spmiu4FNaBTCeRQrGkc+lBhxbxjLKRKfUpfAwJplD+RH
	YAYL3MR4OCxLNkVrsL2heSQbibXClzmBYeD5E3RwclsHN3qma2URV8ddqVQ+iX/2b3WW1VAUzK/
	/RBVWgwl6oyG/ZfqL3vYjiRmJwOaMoaBRkBg=
X-Google-Smtp-Source: AGHT+IHSLw8Lr/Lr+iFLRyXYHY5sbqGKzbox37N+TB7p3lwl2OsdGY2QvqSwmECteEy0F9UNvfqc4bqi4ZeSSpJ1ZiU=
X-Received: by 2002:aa7:9831:0:b0:6d9:a4e6:ce20 with SMTP id
 q17-20020aa79831000000b006d9a4e6ce20mr442017pfl.32.1705699810388; Fri, 19 Jan
 2024 13:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119210201.1295511-1-andrii@kernel.org> <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
 <CAEf4BzZRaKsJ0T3LGxeCchSgLi6Gvs5-0pe0Ba6DQpFFSiF66w@mail.gmail.com>
In-Reply-To: <CAEf4BzZRaKsJ0T3LGxeCchSgLi6Gvs5-0pe0Ba6DQpFFSiF66w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jan 2024 13:29:57 -0800
Message-ID: <CAEf4BzaHz3VRUs=vHC7u5rZmTHE7CTs78oYcOHripWM266QA+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:21=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 19, 2024 at 1:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Fri, Jan 19, 2024 at 1:02=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > We've ran into issues with using dup2() API in production setting, wh=
ere
> > > libbpf is linked into large production environment and ends up callin=
g
> > > uninteded custom implementations of dup2(). These custom implementati=
ons
> >
> > typo: unintended
>
> oops, but probably doesn't warrant respinning
>
> >
> > > don't provide atomic FD replacement guarantees of dup2() syscall,
> > > leading to subtle and hard to debug issues.
> > >
> > > To prevent this in the future and guarantee that no libc implementati=
on
> > > will do their own custom non-atomic dup2() implementation, call dup2(=
)
> > > syscall directly with syscall(SYS_dup2).
> > >
> > > Note that some architectures don't seem to provide dup2 and have dup3
> > > instead. Try to detect and pick best syscall.
> >
> > I wonder whether we can just always use dup3().
>
> dup3() (according to my git foo) was added in 4.17, which is more
> modern than some other usable BPF, so I don't want to just randomly
> bump the minimal supported (by libbpf) kernel for something like this.
>

Btw, this #ifdef check is the same as what glibc does for its
implementation of dup2() (except for fd equality check which isn't
necessary for libbpf), see [0]

  [0] https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/d=
up2.c

> >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Acked-by: Song Liu <song@kernel.org>
> >
> > [...]

