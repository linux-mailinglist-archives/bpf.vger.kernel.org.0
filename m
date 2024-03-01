Return-Path: <bpf+bounces-23157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD686E694
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A386282209
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B33D8E;
	Fri,  1 Mar 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2MQR0WM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8F1FDB
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312483; cv=none; b=ncL6YsrHyy6Wy/P7wKDKvnEcUT+fJ26MEtVkeEQ1L0LsRZy11bEX8r0ow1CjU3D4UcszEKQo5+Cs5EKiUko6ee3AkvBkgv0kgwf5OjRpkAYQoQhZO7PFPjsRBKrSIj1Acdp4ZWmMe1YiiXFUMX2UP8XxWZPnkbkAABPxy0IwPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312483; c=relaxed/simple;
	bh=hwkf93LTvrlQ7+7V48K94syhDKJy74N7h2LvqVcoAYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZbyUlseLNLqfRBGTm1pLliDzb0x2CXoW3Z1in5CnwfEPf6N68BYAIQZF/ChduPxYwBfKi9CNZK227MQQ9CavkUsfucTlNqUdzI3bWREsEPN/uh+tlAr/vTyFBVaPAW7luY/Ws+lc0+7Qimoact2pLP/fn8ADfuI+cMfmDJqDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2MQR0WM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33de6da5565so1240110f8f.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709312480; x=1709917280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIaaFH4PX9qnpXWHxgXCzdJO6lBt0OY9ww4z6ZfdFhU=;
        b=i2MQR0WMFqXT6M7j7nm+WaF6LzxxF5enY5v/ToztqoB6NTU7VvDurQmNRxBUBG6p/j
         pCObaxhb7CRBTOdkCfcPoE4B35rx0mQw7TiMk2etIaPcUOZNUS2TSrC8EVWg1MjrFC/A
         NfhkoCwVb8LSxoHyISnoVxtjTZG3y3mkjAuh0rkLt9+UTrMjFOEpuX8trXQKCjf2+iuk
         wvu1W2nZufrTn6V2htoK444PwJ7fpdkjW/AUvJps0dLYbfjS1+v0Seytd4JuvnN59n4/
         wsX1Kkm7NuN6Plyv8Rf1ooLTGzUHxscvmLu1E/dfv3EGF91bx3U7p1Tomwm5p6bE1i7t
         5YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312480; x=1709917280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIaaFH4PX9qnpXWHxgXCzdJO6lBt0OY9ww4z6ZfdFhU=;
        b=rhLHT1yKUmwU8AYurwzF8gnC0sLHWdy1fF6oIcrGnnmhnOf08E8a3gdVJSx5/4bc62
         Ge2jnn2uw++PObiXY8oBcWHjBDotn/pGndGnWs9s9uFCDhtlSzG24peVAp1WTfBKanRu
         7cwByXsy2IPULkbFYgoiYTFyFavPqmPr1conuedTFATbsqbLbH5x0+70DicnCdlxXhxm
         4RqlyAfhWU/Y7bT0NlWo8y2//gC40hxz6g7CLa9cr2U6QtTxo7zm/rIb4u2hiabPB2+1
         II7x4DEwNMmcCriWbQCOHwehM/aqXTW9pBYWr9+NqJNkP2sEX2Hh1c8KXJDu1Q6rdt67
         NToQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEGqgXh9fw0OzIfuL/KOC+iK5zzdgWK418kBQCiK8WCNfIqAL3Uhzk7R3xpOR1iYcJFqeK0+PBZZKXBWSGWnYNlJ7m
X-Gm-Message-State: AOJu0Yx7j3gap3MziyRObVQRd9ItGgLyMWjrqxPF978T4Jkp8TAtVM/4
	Q8fyjR9JNhN44dHITdgseJ5xyhAn+FJBx8GIOO+Xa+h7zyhKIx6g0M1KQDT4WdY/j8AILwSyVgR
	DPQ0G+FTF3kfgQj0KEg+1FPbeEUVLta7P1os=
X-Google-Smtp-Source: AGHT+IHpoaCytbaC8ht9w1MNhfXpicFCl0Jzoj0UGvfWM3mQp7+/lnPCGw5yZujwX2MP9uDbvvEX/GzrqYdYkYUuiI0=
X-Received: by 2002:a5d:4144:0:b0:33d:d2bc:bf41 with SMTP id
 c4-20020a5d4144000000b0033dd2bcbf41mr1870121wrq.31.1709312479329; Fri, 01 Mar
 2024 09:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
In-Reply-To: <ZeGPU8FRqwNuUJwd@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 09:01:07 -0800
Message-ID: <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>, yunwei356@gmail.com
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > One of uprobe pain points is having slow execution that involves
> > > two traps in worst case scenario or single trap if the original
> > > instruction can be emulated. For return uprobes there's one extra
> > > trap on top of that.
> > >
> > > My current idea on how to make this faster is to follow the optimized
> > > kprobes and replace the normal uprobe trap instruction with jump to
> > > user space trampoline that:
> > >
> > >   - executes syscall to call uprobe consumers callbacks
> >
> > Did you get a chance to measure relative performance of syscall vs
> > int3 interrupt handling? If not, do you think you'll be able to get
> > some numbers by the time the conference starts? This should inform the
> > decision whether it even makes sense to go through all the trouble.
>
> right, will do that

I believe Yusheng measured syscall vs uprobe performance
difference during LPC. iirc it was something like 3x.
Certainly necessary to have a benchmark.
selftests/bpf/bench has one for uprobe.
Probably should extend with sys_bpf.

Regarding:
> replace the normal uprobe trap instruction with jump to
user space trampoline

it should probably be a call to trampoline instead of a jump.
Unless you plan to generate a different trampoline for every location ?

Also how would you pick a space for a trampoline in the target process ?
Analyze /proc/pid/maps and look for gaps in executable sections?

We can start simple with a USDT that uses nop5 instead of nop1
and explicit single trampoline for all USDT locations
that saves all (callee and caller saved) registers and
then does sys_bpf with a new cmd.

To replace nop5 with a call to trampoline we can use text_poke_bp
approach: replace 1st byte with int3, replace 2-5 with target addr,
replace 1st byte to make an actual call insn.

Once patched there will be no simulation of insns or kernel traps.
Just normal user code that calls into trampoline, that calls sys_bpf,
and returns back.

