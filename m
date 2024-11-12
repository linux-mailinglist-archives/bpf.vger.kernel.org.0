Return-Path: <bpf+bounces-44611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A629C5645
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB528FB15
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388C2101B8;
	Tue, 12 Nov 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgBGqXXI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C420EA2C
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409342; cv=none; b=Q7r8SwJfmxuoDVQ1ZyjoclatGWLGsydV0zdhvG7fwDTIhEQ5DnMEdpn/XIA3YioAvZti6gCAh40z+CZMk2M4D8CqWmMvpxg4dahzz36nouw4Z2gVudkxGM9hDRL19F9Q0R27XNI4Ao0Pbx9ep9rtreMlkVk55gzviPXGJ0Lrcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409342; c=relaxed/simple;
	bh=n2UxfHc4Pp7rnfvOdLckmahIFz0HaAUwdvxutc72j8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isVqrDG2+NbbUMigUKzqF1g7D9bTI3aa2BMFiQ1somVqmaTxOtY15/MirH6ylgN3LqyE9/uoqbMvCmDRJnhALpzUljzq6MFL++ttYBKikXXO9w6QlzFwE8Kg8HVD/73leDVMRyeC0w/PVspU3N6P74ryLCKGbfzHBWf+e2rfBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgBGqXXI; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2689e7a941fso3175203fac.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409340; x=1732014140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=obRO/IX1U1aN0FddclWpw3EZEtQl6kDzJORByPgx9OI=;
        b=XgBGqXXIiNxMqK7GaCVCSUEeGV/nurcOWfGWRxgwJFliggrJRaJC8Zmkij1MYm7/mp
         GsX4Xme8Lh3BL2exYlzDH1PGzkNV7wURsnIMLdXboYgi9TLHFofeIfREQrkbvnGpZnuc
         qZPlN2mNWzDmDf2kVtdA6ZahI2PuQ23/O0dsEhzS0Onf51sd8K3PO0J1cs5dopzhJeTf
         6wGsytXsd6v5k4mYwo4m44I3JuKLqccPZqOLCjNiY7VUYWoI3a54TBK6OHxU2ChjiGzJ
         hwl6L7QNhMkM50cxsbX1R2qy8xIvAT1F3fLTGnu3fTt+zg8rYyG4GmwV2+BDMMkhefGD
         ggTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409340; x=1732014140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obRO/IX1U1aN0FddclWpw3EZEtQl6kDzJORByPgx9OI=;
        b=hOhG2SPWzd8t3q19WwPP8HbRKqjMDcqOEOCo0BxVWV2mIAZaZRn4IOnVnJbr7pfY/J
         WYBoVG3fboW1QWA9RTIO4PJChE4Het209RitvPbZYM5SvMcUt4pFGZNT447Wy2YTXK4u
         MoCMf+JDhjJnoNc1SXqaReANfvKc30AfmdM3WnO/HhRarMCRyseAEzlC97gSCwptuqAA
         cAtKf/d/g/tgS7Y7WmXIVm78nFicrzVhWIzb+MbamnYugVBOdvLx4q3h+dA1rXzZwq5g
         89WkWdqxIkkfwnZkFTiWvFAnDYenScYnv3Bq2L5jTPcO/709956+mYpClKMZlUYUZ61l
         HXqw==
X-Gm-Message-State: AOJu0YyUngq083N2dqpHDKDAh7VOAdJMHa3rF3ZXuAPvv8eBQBaCWeNM
	+X34HPB4+mZNXwy6sN9AhNh7EtHDQ3Woc6C3C7jOcQYMrAj8jcgp0eE+Awtktk+30esBO+3kEsf
	95aMugagwlBpjuC4C3JHhbWorKlPbCQTJ
X-Google-Smtp-Source: AGHT+IEcjOhFl+zIHMy9YFmMF26TZfhH/s2Wr6bF9lsiFCFln76QCGjpml5rW8MfcrXKlCgB/RSatjlhd/WJmw6Q+CU=
X-Received: by 2002:a05:6871:10c:b0:267:df02:f7c0 with SMTP id
 586e51a60fabf-29560281175mr13140371fac.33.1731409339809; Tue, 12 Nov 2024
 03:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111140305.832808-1-daan.j.demeyer@gmail.com> <1319dcc5-979b-43d5-8737-ae7716648937@qmon.net>
In-Reply-To: <1319dcc5-979b-43d5-8737-ae7716648937@qmon.net>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Tue, 12 Nov 2024 12:02:08 +0100
Message-ID: <CAO8sHcmpfR-2S15HVNwxqjRZZXViny9bXX4sNxAAU_yRsvK97g@mail.gmail.com>
Subject: Re: [PATCH v2] bpftool: Set srctree correctly when not building out
 of source tree
To: Quentin Monnet <qmo@qmon.net>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> My understanding of the check on building_out_of_srctree in
> tools/bpf/Makefile (from commit 55d554f5d140's description) is that it
> fixes the build from "make TARGETS=bpf kselftest", not from "make -C
> tools/bpf".

> Trying again "make ARCH=x86 -C tools/bpf/bpftool bootstrap" at the root
> of the Linux repo, not building out-of-tree, this works fine for me,
> without the need for your patch. I'm trying to understand what you
> setup is and what creates the failure that you observe (and that I can't
> reproduce), so I'd like more context if possible. Are you just running
> that command from the root of the tree? If that's the case, what values
> do you observe for $(srctree) and $(building_out_of_srctree) when
> entering bpftool's Makefile?

I do the same thing and I get this error, srctree is set to ".". I have no clue
what's different about my environment that would cause this error. This is
a Fedora Rawhide image and I'm using the master branch from Linus's repo
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git)

Cheers,

Daan

On Mon, 11 Nov 2024 at 16:39, Quentin Monnet <qmo@qmon.net> wrote:
>
> 2024-11-11 15:02 UTC+0100 ~ Daan De Meyer <daan.j.demeyer@gmail.com>
> > This allows building bpftool directly via "make -C tools/bpf/bpftool".
> >
> > Without this change, building bpftool via "make -C tools/bpf/bpftool"
> > fails with the following error:
> >
> > """
> > + make ARCH=x86 -C tools/bpf/bpftool bootstrap
> > Makefile:127: tools/build/Makefile.feature: No such file or directory
> > make[3]: *** No rule to make target 'tools/build/Makefile.feature'.  Stop.
> > error: Bad exit status from /var/tmp/rpm-tmp.3p0IcJ (%build)
> > """
> >
> > This is the same workaround that is also applied in tools/bpf/Makefile.
>
>
> My understanding of the check on building_out_of_srctree in
> tools/bpf/Makefile (from commit 55d554f5d140's description) is that it
> fixes the build from "make TARGETS=bpf kselftest", not from "make -C
> tools/bpf".
>
> Trying again "make ARCH=x86 -C tools/bpf/bpftool bootstrap" at the root
> of the Linux repo, not building out-of-tree, this works fine for me,
> without the need for your patch. I'm trying to understand what your
> setup is and what creates the failure that you observe (and that I can't
> reproduce), so I'd like more context if possible. Are you just running
> that command from the root of the tree? If that's the case, what values
> do you observe for $(srctree) and $(building_out_of_srctree) when
> entering bpftool's Makefile?
>
> Your v2 also still misses your sign-off, and please remember as well to
> add all relevant maintainers in copy of your email.
>
>
> > ---
> >  tools/bpf/bpftool/Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index ba927379eb20..7c7d731077c9 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -2,6 +2,12 @@
> >  include ../../scripts/Makefile.include
> >
> >  ifeq ($(srctree),)
> > +update_srctree := 1
> > +endif
> > +ifndef building_out_of_srctree
> > +update_srctree := 1
> > +endif
> > +ifeq ($(update_srctree),1)
> >  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> >  srctree := $(patsubst %/,%,$(dir $(srctree)))
> >  srctree := $(patsubst %/,%,$(dir $(srctree)))
>

