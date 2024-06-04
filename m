Return-Path: <bpf+bounces-31358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7338FBA1C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2893628519B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094BA146D6E;
	Tue,  4 Jun 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRrv4NXD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F97E2;
	Tue,  4 Jun 2024 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521389; cv=none; b=fKTITyOShOewvPZcom6zceVZT3u14zzfkC9Hm5U1/tbEzR8gY+NmK4uuHBxG7rZqm4NxK/7AhCx69KaWL4F6rII009QpCJz/ucR5DbAPPq7V2PDZfL+gZ6//jAq+sID3tdc1TjAv6Fnv1VXrYq3v3PakC2wVtSZj/lbBbfOMttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521389; c=relaxed/simple;
	bh=RkQhcCUGvhc68yqedqJ3dY1m/xst2V0cFQC1POPV47g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=andcqoXal0Wh5+FD75vjl041/86APmhbG+GhXYhR0JL9cZYUqxA2gfBhZfWF6zc4YWRRZP3kG0zZIDQY3eMRbaauk59FS8Sqf0nk+5D2ozWnW4HPwat1baiJvYS/gYWmNXzFk4bSmNLyZ1S05/omuB2NFWR5jr+71xhvsoiz5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRrv4NXD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6cc3e134f88so1067208a12.0;
        Tue, 04 Jun 2024 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717521387; x=1718126187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SPFGeZYux1GhJ/hsA6QEhYw/FILAzVW/x5wsmvaavg=;
        b=XRrv4NXDKitlXFYtfgRkdwuqSYx/0sjjUALBXow8X4qDnNDXMpPTwEvSDpWS1sQxsp
         vZdMC6vAWYNrZqxdHIrssTKmOogfM46FO4Je6EsWdlIdHdzT1DRoZeLFLc12YHlXAEzt
         e/kAvpNLG9EJyKh0CVUTcj4p9e7+EzYGhvs80Enf4MJvhdBBxRnKODwh+k4YOyh7brcF
         1A0XiJvAjWPxYZCM+nZFu4B6jANWuasQZwy7BIQyLcAD384IpA8X83zgU5mZ3aAHyPyI
         IO1vc+6E/1M8+sbqArYfLVSYnLM4bMmyJ+GO04WLOF9ERlFS6k5lwHYlSARNVij10+/1
         N9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717521387; x=1718126187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SPFGeZYux1GhJ/hsA6QEhYw/FILAzVW/x5wsmvaavg=;
        b=Q5M63cSLPOvoCA3viqGlEbCcuC7r3kl6aM/oZtnBNTFAibp8rEF+ixC9D13tDsvuzT
         V6Sm76fZTMa7GkcCNfod1PHZ3c5XJmN3kNYpV89SlceMjvdQuGd5AuoU1waa7bTSO2BM
         f6JDSqigLXr+rjeXl6UXMp9q/XEF/1sUkNm6JQDWV2lOTWblNWXiXR05v/YSg85k3IIy
         8R2toseoTpFw4RxK86Zn46HTN+ETHT6nOi4shziHDtKxZPSX8SWjgRbLa7QTXlEnsrR/
         4Ath5/8Etsn7X5C9tiGtdB4bIRoo2QringhKn/FBvoFKWHJDsuMYBAK649dH7mjPGvZ0
         EYXw==
X-Forwarded-Encrypted: i=1; AJvYcCVag9sLTXpA+Ntxs1J1zE6ZG6reptkQn3sq/8FB61Nrv+47TjfIiSOCw+LvFTi51oTYpJyzT/zq6e0HpVP7akq7u2P8tCIYLz+sfseJN5bwfZxNNS8SAdW2HAqME5wfUS7Xt0dsS9G2Cx997oE04eKuu9vyX5vpGhFSw2MSk41z6Ct7Gb3sOuIViA==
X-Gm-Message-State: AOJu0YwyIaAtL3FYmicwFLCwPW21FD4IDnT+0oYqe/9m99+iHrB2isUs
	iMe9CaRNGGt8My+CQkk0BI307mRkuBL7pTWnIxfZxUSvrBCuZol+hW5NXAoD8KNstLIf6nD7INY
	/9dJjb+rdstJyLO/CMAkFzubeKwc=
X-Google-Smtp-Source: AGHT+IEDcxzeo4/WotXZhMAU6LLCoOLnWMX1xTVG0+hjNA7Kn3/H4VVWxd7oXR24cOO+MbPXXAaePesnFXNJym1JpFI=
X-Received: by 2002:a17:90a:db81:b0:2b6:7e55:2aad with SMTP id
 98e67ed59e1d1-2c27daf65c1mr99644a91.7.1717521387418; Tue, 04 Jun 2024
 10:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org> <20240522013845.1631305-3-andrii@kernel.org>
 <20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org>
In-Reply-To: <20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 10:16:14 -0700
Message-ID: <CAEf4BzbneP7Zoo5q54eh4=DVgcwPSiZh3=bZk6T2to88613dnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the
 presence of pending uretprobes
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:13=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 21 May 2024 18:38:43 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > When kernel has pending uretprobes installed, it hijacks original user
> > function return address on the stack with a uretprobe trampoline
> > address. There could be multiple such pending uretprobes (either on
> > different user functions or on the same recursive one) at any given
> > time within the same task.
> >
> > This approach interferes with the user stack trace capture logic, which
> > would report suprising addresses (like 0x7fffffffe000) that correspond
> > to a special "[uprobes]" section that kernel installs in the target
> > process address space for uretprobe trampoline code, while logically it
> > should be an address somewhere within the calling function of another
> > traced user function.
> >
> > This is easy to correct for, though. Uprobes subsystem keeps track of
> > pending uretprobes and records original return addresses. This patch is
> > using this to do a post-processing step and restore each trampoline
> > address entries with correct original return address. This is done only
> > if there are pending uretprobes for current task.
> >
> > This is a similar approach to what fprobe/kretprobe infrastructure is
> > doing when capturing kernel stack traces in the presence of pending
> > return probes.
> >
>
> This looks good to me because this trampoline information is only
> managed in uprobes. And it should be provided when unwinding user
> stack.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Thank you!

Great, thanks for reviewing, Masami!

Would you take this fix through your tree, or where should it be routed to?

>
> > Reported-by: Riham Selim <rihams@meta.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/callchain.c | 43 ++++++++++++++++++++++++++++++++++++++-
> >  kernel/events/uprobes.c   |  9 ++++++++
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> >

[...]

