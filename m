Return-Path: <bpf+bounces-36583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50194ACCF
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7861C22B28
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF212A14C;
	Wed,  7 Aug 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlrYeCD1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9C78C92;
	Wed,  7 Aug 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044291; cv=none; b=gFZZwVOE50cDsyy9e9fKlHSa8WA/JCuNoyyyDNwUQAVmVGZ5c9bI1XiIJ3tYjyVGD5rFqfdjGA2gfJDnchHyYvQXpKaJ1UKlBcyiC1PXfLaHUep+2rXq+h7wxCzpIOY+ctBMyLxPGnyWcCal6q1CsnyjNdrk4EzcRLOhwQOUCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044291; c=relaxed/simple;
	bh=F0grU6XKOmeU7PPmj3ZJ0T1fI2//rZxZbQMjDgJ20v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBUs2DVi5LPFJszAT4p+2461sTkRw1DV8ii/HlQueb9pAezsP1nEhjwnj6fImbvSsP6xYCUWYdYrsNTuiu+Y+0pSID0rClslfmEBw7t+3C2EN2e+lG+z5JXOwNbf+4khBmOIusVH7dNUMbboWFSIrwVFXUtN+6tO+F4ZqsivdWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlrYeCD1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so1542709a12.2;
        Wed, 07 Aug 2024 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723044289; x=1723649089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spYQYkEoksKOravFlWCsBEZaebJdFSiEo7zDC7aHQzU=;
        b=hlrYeCD1rw326xHzTh5K6JKGPoBSOT9xyBd0wNyeWzO+pEaFc8249+j2GP087seKzW
         hrYyUGlDFmZTP+gWi3/zwebt7xZbjpoPCuxATQX5tIVjSRgSMfU2WdXt0+EUhFpS0xrY
         orHf9n6BSdNT0TNVRLTVsX0FED8ITTWQjpqRNGPUfsOLvzjiacdfk2k8cInwqg30lBX6
         N4S72KFszeq1eSsh87B9uiUva8jqeYvfaUCMSAwXRTbrXfQLpR+Xz7BvHC30UHOMtHD5
         SIi9qj+7IkU535TzJ4v6BDIhz9o6unN3zfR3CeeZrLzJnD4HOfyLzixWhf9mR2jwufth
         qjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044289; x=1723649089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spYQYkEoksKOravFlWCsBEZaebJdFSiEo7zDC7aHQzU=;
        b=jYmbMRXfoupJSLGfWrKQvArNpwHE4dqwXLFn94z7M5svYPoMO5WKIJBiK8JiwksMTm
         WUzFcdB15cKn1rDjWZ9vzI/veruqH4izM3DDUlhNIP0o/rqq43L94aNuFZO3RrMJ1Yst
         alsFMfgFeQ7v+fWOwc/3aYlpBiBiIoPdmx80lg3yTs/Qf5Sr8maiX+Vz/m9eKZbwarRZ
         YSEHL3mW5k3r1lswpwZ15eJdfzCOx8Vdeg0DABc7qS3F7HN4Ef56/JrLMiVasx39/WIq
         cqwzCEAblUOFyTj/YVnZLkIY/AHLNzjBZAGiYbP4Wb9CEMxNCgmeYPrAqU0TlqHMRVg6
         PfJA==
X-Forwarded-Encrypted: i=1; AJvYcCU777BmPyPCpy87PDhgdb0x4u+KkoPA4l06KoGL2VBDNDh7zC2qrMmjGUwOoIqNG8jBORA1382qZZu/Y+xmed6DQ7eNPrPn7qGb65vDccer6ceKcxTQXM0b2CLBDKCOOZVxyZqxKCXP3LV91fIXx91XvQgTOFWe7YuiOp3zzn59xcBllyl3
X-Gm-Message-State: AOJu0Ywb7CMZnPP/dt8VD3s5psP6xMT+5VkM+Q12M720/6KcEdcyXR5a
	NtqnZP7S6r0OHxOHZmBBIWiI+gPrqctG1YaX3Mtr2t6jSYo7SLpHx5egzScLYxaRU3byN6qyawo
	x0Q4bzrL5w7Fxk3DAzWILyuLl/o0=
X-Google-Smtp-Source: AGHT+IFV1yrtSjfMCnt44nWVkeEBTJGNaa5KawZiyWCUmpAOXLsZ4POZAwJBiFNCT6UFYdLpqBUnplcge0x248d2lQY=
X-Received: by 2002:a17:90a:640d:b0:2d1:530:ba47 with SMTP id
 98e67ed59e1d1-2d10530bca4mr12176770a91.32.1723044289537; Wed, 07 Aug 2024
 08:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-7-andrii@kernel.org>
 <20240807131707.GB27715@redhat.com>
In-Reply-To: <20240807131707.GB27715@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 08:24:37 -0700
Message-ID: <CAEf4BzZT8x0EFowzciYUXvfVTL8WpJcx=Upzm69L+-_q3Jb_3w@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:17=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> I guess you know this, but just in case...
>
> On 07/31, Andrii Nakryiko wrote:
> >
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -478,7 +478,8 @@ static void testmod_unregister_uprobe(void)
> >       mutex_lock(&testmod_uprobe_mutex);
> >
> >       if (uprobe.uprobe) {
> > -             uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> > +             uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer)=
;
> > +             uprobe_unregister_sync();
> >               uprobe.offset =3D 0;
> >               uprobe.uprobe =3D NULL;
>
> this chunk has the trivial conlicts with tip perf/core
>
> db61e6a4eee5a selftests/bpf: fix uprobe.path leak in bpf_testmod
> adds path_put(&uprobe.path) here
>
> 3c83a9ad0295e make uprobe_register() return struct uprobe *
> removes the "uprobe.offset =3D 0;" line.
>

Yep, I'll rebase and adjust everything as needed.

> Oleg.
>

