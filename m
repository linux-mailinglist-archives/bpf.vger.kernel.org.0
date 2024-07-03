Return-Path: <bpf+bounces-33819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0F926B03
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76310B285B7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047EF194A5E;
	Wed,  3 Jul 2024 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktm0LsEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE2152163;
	Wed,  3 Jul 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043528; cv=none; b=aWWgI8NAd1R5YsOvSkIbaMjp7xm/3Agu0U9w5/T1iq1pMf9Ski+FPzzw5DxPFUKlOnfWckx44H4RewcD3k0AARrjtyBSBCl6s5/IUyZiHDATfkX4hAPCXVk0NKnXb9eIKirGsiu3lTRig3l+3raeLhttAHElWyxwoQh2IMlyOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043528; c=relaxed/simple;
	bh=XI4v98jbo8jSdsquCKJF03MHp3PA97gBJJmQ9hhbbOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhBoxCX0JOJhlwJOykmRWTZxVZnPPBuEj2nu3hTUFPJ0uJxz2oK+Q2mmV3EwSC/V5Qb7SW89s2YaVLXqi2cx4Nen4OxbcTPSKJcAP2H0LRyCXMEt8rq0WzqwyqZh7UpXn+MHWujWXyBZifV9d0pjq5qypaTa6EEdyqc9VfvscHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktm0LsEA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so38458b3a.0;
        Wed, 03 Jul 2024 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043526; x=1720648326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH+pD5XUUgV8lUTIGvODK7qexqDZjWiUCDKCuPZeuBY=;
        b=ktm0LsEAUrS7GkI9daPyund8tFtuqLUx8MOy9kKavoIm8+E/geDAN4pVmg7TyDUTbM
         deKs0iRTxoynWVKfgWkJEiC7XNbyaJU0cJDgvenmMpbpK1XSIHm0YOJT4KPc5qBSNcI6
         WQ73adWzJVgxDfsjTaC7N4m+uUAjbcTs8BcxW6pTVuYcWQ2A+sAsM3BB4J/cbeaupIVJ
         ar0ZpuAbpP0e+bHauEBiVeasL0yeqbQatK3x73wH54nBtvmpMbnCNRwm4mlvW79f0EBx
         r9VZD0jBiJrw4XZ3gh6mxGlT8fkzg2BhMIXyZX7v2ND0UEutjrxyNOQAn9pbPOLmKVy/
         Q7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043526; x=1720648326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH+pD5XUUgV8lUTIGvODK7qexqDZjWiUCDKCuPZeuBY=;
        b=Qzgt2RZPRVEULFc+r/o+JMtw5XMuTHhbNBuxCGRj1CEBSZtoHKED/0cjWmL9ROTR0Z
         pY/me9HYIf4IEatBZjlb/bp6qPmwwQfV0AlEz9oAxdxNohQqD5WvyW/ZdJxTxWqKn/mf
         4I8GpEQtrrzn+d7cpvoP6c07wkEsi6TDUMYTDHSfXPBBzQqWsG5BN9piZMaw2a2wFRPc
         B9FKmtQ3qEgiXigTStSSmo1e/MqFJR2tdbGZkhtkKoN3OAR1zRXt9KD23Jt7718qDuue
         VYjCt6LrOVO2w+Wu3NtZs7YSkeUWEAWYsn7XinEW3iFiAGyc6HN9emUCNylpazbkT9Ci
         ruug==
X-Forwarded-Encrypted: i=1; AJvYcCVxi/YZKj3LUlbVf93OTc2wxSogyE/oHIqIfG0+HzS1EInItktNX7csXLmpaJY3+98DLRWzLTGAsBMrjIwb/6i7UrJHDW3SrZDiOxOz5BmqVo5l0TJfesypUtjkC9PAAk2LdN2kot6A
X-Gm-Message-State: AOJu0YzGrzOAjn7BMFiETDQvGqOKty9MJWulx4UT1pbWIheL+ZyRILrY
	lm7aGbgObkCPxQ1BFE7nJy4GVYluq0OeQTR5o5f/iMXfF2CM0G63OmybHP37f/GG7t/EeQHStqt
	t6fwEDbnMyZNjr93odmJPMjOQ6fY=
X-Google-Smtp-Source: AGHT+IGNI9zhe9mt8WWZd7sFJs8JKZ/arLTVQQ+74Hmxsl92CMsiSKMOssL6Yd6+bcBtUPLwDdYspl2at91Sbyjfc6c=
X-Received: by 2002:a05:6a00:2283:b0:706:720a:72b4 with SMTP id
 d2e1a72fcca58-70aaad2a113mr18249305b3a.3.1720043526443; Wed, 03 Jul 2024
 14:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-2-andrii@kernel.org>
 <20240703113829.GA28444@redhat.com>
In-Reply-To: <20240703113829.GA28444@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 14:51:54 -0700
Message-ID: <CAEf4Bza6=vmfEg9J_PTxcjU9w8oUqF=+Kj+TbeXoxEcLtrhApQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] uprobes: update outdated comment
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:40=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Sorry for the late reply. I'll try to read this version/discussion
> when I have time... yes, I have already promised this before, sorry :/
>

No worries, there will be v3 next week (I'm going on short PTO
starting tomorrow). So you still have time. I appreciate you looking
at it, though!

> On 07/01, Andrii Nakryiko wrote:
> >
> > There is no task_struct passed into get_user_pages_remote() anymore,
> > drop the parts of comment mentioning NULL tsk, it's just confusing at
> > this point.
>
> Agreed.
>
> > @@ -2030,10 +2030,8 @@ static int is_trap_at_addr(struct mm_struct *mm,=
 unsigned long vaddr)
> >               goto out;
> >
> >       /*
> > -      * The NULL 'tsk' here ensures that any faults that occur here
> > -      * will not be accounted to the task.  'mm' *is* current->mm,
> > -      * but we treat this as a 'remote' access since it is
> > -      * essentially a kernel access to the memory.
> > +      * 'mm' *is* current->mm, but we treat this as a 'remote' access =
since
> > +      * it is essentially a kernel access to the memory.
> >        */
> >       result =3D get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,=
 NULL);
>
> OK, this makes it less confusing, so
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>
> ---------------------------------------------------------------------
> but it still looks confusing to me. This code used to pass tsk =3D NULL
> only to avoid tsk->maj/min_flt++ in faultin_page().
>
> But today mm_account_fault() increments these counters without checking
> FAULT_FLAG_REMOTE, mm =3D=3D current->mm, so it seems it would be better =
to
> just use get_user_pages() and remove this comment?
>
> Oleg.
>

