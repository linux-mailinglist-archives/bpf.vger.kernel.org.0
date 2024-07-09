Return-Path: <bpf+bounces-34298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B692C50E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118A728366B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FDA182A45;
	Tue,  9 Jul 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ6YiXk6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80301B86DD;
	Tue,  9 Jul 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558788; cv=none; b=nDrkfXshYH7zhy/fpY/cL6hmFP6M7ucKCU9/9X3gFfn7PwO1dnxZyC1m8TqwAv3AfguJ559yQlLgEveuqYKfOoLnAICVLRd0H8sUIquiTO/bMFFWeQdm77mDUBMTqocQDv/kS7atqsp6CsaB2VmaXFMiLrpgvJuphgNhbcqfG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558788; c=relaxed/simple;
	bh=fLStet2KUohwSOk/JQSU9bG3OKKl1quvtghhUTPamaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH+d45jgM9X5X/crj0vO89eSBkv3jQ83tt7+4hM/8OO4nq6A562tUZzFJM4UJ/rkcXsXclj1dMI5VuCTOGiVMdgxlzCaZGg2kwVJ+HLqXOQ+AXpPmiMspln0vjAEJskCKwlcJ6D6TwoPW7uuw2DEm3bmQlfUYuuhDSB4H+JbtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ6YiXk6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7611b6a617cso3507184a12.3;
        Tue, 09 Jul 2024 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720558786; x=1721163586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLStet2KUohwSOk/JQSU9bG3OKKl1quvtghhUTPamaY=;
        b=nJ6YiXk6Bk6gqHPlefrIrcU3PreUWepIhDP56Jukuyw7sKi21sg1ZjvHY7wMW/dsan
         6e4qMkFuvVOc3uVpvH6kwjiSQk5jXUnXpQuWlQ9RmgEWP2kRYca+PgjM21ZBly4H1YpT
         OLuLAoGY1E5yPcyOnXd41WJ+lqFFkin3hWSOcmPzSZqpBC7emKsO7N1tDx9IAOCJrMqL
         ZAofRISZ3xejWk+nFg9Nhh6KifWa904PnU24YI4Cz0WttkOGvwy6BuBAhJZNnNGS2Mye
         3r+onPzoct2ItqNK/EyTsr9EmMJQAJxi+COPg2W6Vx3K1z31ZfWxlJfws/LQaVL5NB4m
         48DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558786; x=1721163586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLStet2KUohwSOk/JQSU9bG3OKKl1quvtghhUTPamaY=;
        b=o3QYoYYxc2bYB4kQRSPFvh7FZ6YPqQlABNB95KiTi/rguvWfFVdnYqIyks/NyNn6qU
         IYxpGemW82agYEwKpF/o7LP4qAl8RjHc1fI4/aTVISSWlsXgILZHW/vEiyE9yCJWZLi0
         Cy9493pACOJwP5G40yWwnrJYyRdvqBptq7HIKPIUwrivk07iRCA63cWNESi81luI0bXp
         vcbkC/NJbbtbd91mT1DBhT1SMCIF0/wyNuayIStlEExg2A4Hf8lfulz4ZXtCD/ghlfBn
         NRiLXECq2Lw/lfBo9WMOeHzs8wya5KKGqbLfxvNAn/lQhpSOv6Qf2iDqQjaVsbtGsuxl
         Kn1w==
X-Forwarded-Encrypted: i=1; AJvYcCUieUxgzBh/+9LAk6mqeraqrG9mycVt/4x8OlAlrHol1pZb9kDQSGKSR5CNRDO+b8y1gzt1jIS4XmvbhPaziTl+at1VHZaSJGdhH6WtZbG6gQtVp7gLKUqAmpLVW3m8fKArk/NgG68k
X-Gm-Message-State: AOJu0Yw9H9BScy0SeQ9qThaD7/dGSX+9ON74sHl5ZGXEpI/K4g3NybQI
	EA8Dsk17iz0hm00DJhXEqPWAGCNwOXLxbojhJjdV2Bg4vMOx7Kd1R9zen9XrkZm3HI0+uXobs9S
	q+sflGjhy9SoIeAWdwiL4n8s9b9x10g==
X-Google-Smtp-Source: AGHT+IGNiqi0du7mfda6XsJvlCjUkh7b7/gWfg+nSLtSbKchDfK+52qAC6hI5Z1a0VB65uZCA9aMNT8LyqSBR3Ii/oI=
X-Received: by 2002:a05:6a20:3c8b:b0:1c0:eefc:9287 with SMTP id
 adf61e73a8af0-1c297d7ec70mr4100903637.0.1720558786138; Tue, 09 Jul 2024
 13:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com> <20240707144653.GB11914@redhat.com>
 <CAEf4BzYZCVNFQcVBPue4uom+StiCQA6ObR7Z-sKzcEZyTiSyRA@mail.gmail.com> <20240709184754.GA3892@redhat.com>
In-Reply-To: <20240709184754.GA3892@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 13:59:33 -0700
Message-ID: <CAEf4BzZFJ-fQRJELsCYRjdPg8ezQwOOEhHbF9Nb5=4e8WE9bzQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 11:49=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/08, Andrii Nakryiko wrote:
> >
> > On Sun, Jul 7, 2024 at 7:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> =
wrote:
> > >
> > > And I forgot to mention...
> > >
> > > In any case __uprobe_unregister() can't ignore the error code from
> > > register_for_each_vma(). If it fails to restore the original insn,
> > > we should not remove this uprobe from uprobes_tree.
> > >
> > > Otherwise the next handle_swbp() will send SIGTRAP to the (no longer)
> > > probed application.
> >
> > Yep, that would be unfortunate (just like SIGILL sent when uretprobe
> > detects "improper" stack pointer progression, for example),
>
> In this case we a) assume that user-space tries to fool the kernel and

Well, it's a bad assumption. User space might just be using fibers and
managing its own stack. Not saying SIGILL is good, but it's part of
the uprobe system regardless.

> b) the kernel can't handle this case in any case, thus uprobe_warn().
>
> > but from
> > what I gather it's not really expected to fail on unregistration given
> > we successfully registered uprobe.
>
> Not really expected, and that is why the "TODO" comment in _unregister()
> was never implemented. Although the real reason is that we are lazy ;)

Worked fine for 10+ years, which says something ;)

>
> But register_for_each_vma(NULL) can fail. Say, simply because
> kmalloc(GFP_KERNEL) in build_map_info() can fail even if it "never" shoul=
d.
> A lot of other reasons.
>
> > I guess it's a decision between
> > leaking memory with an uprobe stuck in the tree or killing process due
> > to some very rare (or buggy) condition?
>
> Yes. I think in this case it is better to leak uprobe than kill the
> no longer probed task.

Ok, I think it's not hard to keep uprobe around if
__uprobe_unregister() fails, should be an easy addition from what I
can see.

>
> Oleg.
>

