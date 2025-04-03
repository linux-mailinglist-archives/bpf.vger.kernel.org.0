Return-Path: <bpf+bounces-55241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B295AA7A77D
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632247A7169
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953F250BF7;
	Thu,  3 Apr 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXEgo/DP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC272505D6
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696267; cv=none; b=CEqdgXdEYJHTctitnYieY+njwTxSMzNWi9RyUOyAQAGEGDB++a4P/aO7WXh91cagBjfkLWSlF6iuQzv88H7rSmSwfd/yn7Z9RCkrM8OKtP8dwwAokv2c3vwQaGFXm/5e/PpI8ASc6BdB5pYpC/zy869X1bHLwoo/GLOkGZ8zK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696267; c=relaxed/simple;
	bh=fa3ys9lU0cBO9nO9ewD9e4iTmEoBwAFSFNOEhc4Quhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYwGYnhVS+eAhaE1g9BW9d/L4GgFRs8wi8EmijiU6tGWAulGkdWsgn0nPS1wp2YXlxg6kxDHxiOHEtEH0xLaiXmq+oS8unTCkRqOtlekq+IhjcMI+ixM5/cCufXy/ylKXlo5adnoN+0urcoUT7zi/TkU8Hj5KvcAsYrVHoIU7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXEgo/DP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736a7e126c7so1056337b3a.3
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743696265; x=1744301065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa3ys9lU0cBO9nO9ewD9e4iTmEoBwAFSFNOEhc4Quhw=;
        b=kXEgo/DPGX835N4ogzRhqRXiD/9s78jDusF6wfX2wSxjSeOOYsqNrJKFIlmZ6nioDW
         1U4639fwPyoKY6n7t/1Hv/lmx/hb1zE7q6L4DWt3KGLmKSlYgpBDSm4E27tNlG38DXTt
         9c1qKUusKcCJQzLY19aGZfM70R44OADb12SLUgXITHIDqYPCvt89Zd5cTwwKaxX7djMl
         uxF3GKQrkZneHTaKv50t/DT6Znmy9xlwK4Ne53mK5bkfYV/aEaziWVpNU6nJxm0G7K2X
         Ozd40IzOAucIJ/Wbsy5pp4W9ElZ3mhYR0arC1SDyux6RhQbgTfhHo2w9ib5ZlwAfSkwh
         BCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743696265; x=1744301065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa3ys9lU0cBO9nO9ewD9e4iTmEoBwAFSFNOEhc4Quhw=;
        b=fTBmDmMqZlS53xQmILGxLNe19l1xRtGv81srvhcWft5J/dhm8PSNpEbD5gsXRBqhdP
         MNYF8Vk9sf4BKW0+zaSlm1Ww9HzHRG0hubtkMcVN4DYT0ojDKAqkiUuxZrGiUFKWfgnP
         lFDSCkJ2l32k77lwpfbS148g/nC6kGUjnIRrdSTV+JEhbU+LOiTABEkwt8BuQOZ3ys39
         gv+e76gLpnijnCHABQ78ZA0UQMrLICvcFCoYA59yF7xJ2L1Qks870NoAuZOAQXBFgTtj
         x55FhV9jUm+pWIl8TwAXGXp6pERKtxwG4v2I5imdkX/usN8qs89PLe08JQ8YDvy1pf7k
         GD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXUhFLXemfpq9FQzSvJ+CMStSm4ztZ2sivDsYeM7yH1mM0ocPugpKcbtiX4oRwjsNZ4lK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgq2XVP73uCeqPkVZkdADzN62jNeBhUzWpcqMJqJNTc649ZmD
	IFyv325ZYtcLnNpsDY959w6AhxQQV4kFA6kjUOzfefYx6WmViK9z3ezQjk/BrQUGFVkYdPXLScc
	UtuLC1pWCM/pXSAlPLn0ntHU5VA4=
X-Gm-Gg: ASbGncuDNnYJvIyjQL/znp/3toW1pp0jCGtQKoYri/JB9GdjOVR46e+KXra0HN4IIv/
	19B7/i1/TLfbGdZxyfaXsr57e6/rtYy0/x+/ZvL0urqq4AM2uKVNDqWNCIk/mH78bt4XJV5wECX
	5glTChGMm8xF6lv/b+IWpZWb0l/czybJwct64pZ4xcvA==
X-Google-Smtp-Source: AGHT+IGCe9HKN2DFXXwxis1djyQo35z8nFGfEoCbh++hEB3PzdyD/D8Wwflc5wlV4/XzCtvmidDa6z5hw7lxXJSyFuo=
X-Received: by 2002:a05:6a00:809:b0:730:9946:5973 with SMTP id
 d2e1a72fcca58-739e48d622cmr169333b3a.5.1743696264813; Thu, 03 Apr 2025
 09:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401172225.06b01b22@gandalf.local.home> <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com> <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com> <20250402121315.UdZVK1JE@linutronix.de>
 <20250402121850.GI22091@redhat.com> <20250402122447.B3XIrQnG@linutronix.de>
 <20250402141245.GK22091@redhat.com> <20250403073728.c7kEmd8l@linutronix.de> <20250403122756.GB16254@redhat.com>
In-Reply-To: <20250403122756.GB16254@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 3 Apr 2025 09:04:12 -0700
X-Gm-Features: AQ5f1Jo04f-q9nvolo85oRFeLbAaeyLBC4Hd9u135cdZUHmhtYC7m3e-Fpest3M
Message-ID: <CAEf4BzZ95Ays8=EWFWuf57WbveK2=QbujezU5C4QNyM4dxzfGw@mail.gmail.com>
Subject: Re: uprobe splat in PREEMP_RT
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Ziljstra <peterz@infradead.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 5:28=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 04/03, Sebastian Sewior wrote:
> >
> > On 2025-04-02 16:12:46 [+0200], Oleg Nesterov wrote:
> > > >
> > > > Yes. This would work for here just to skip the check because of all
> > > > details that are hard to express. Therefore I suggested to use
> > > > raw_write_seqcount_begin() instead of write_seqcount_begin() in
> > > > 20250402122158.j_8VoHQ-@linutronix.de. Would that work?
> > >
> > > If this can work, then let me repeat: why can't we turn ->ri_seqcount
> > > into a boolean?
> >
> > I just stumbled here due to the warning. Now that you ask the question,
> > it is used a bool in the current construct. So yes, I also don't see
> > why.
>
> Well, Andrii has already explained why he decided to abuse seqcount_t,
> to avoid the explicti barriers in this code... I won't argue.
>
> So, just in case, I agree that your suggestion to use
> raw_write_seqcount_begin/end should obviously fix the problem.
>

Sounds good, I'll switch to raw_ variants and will point out more
explicitly in the comment that I rely on seqcount barriers and
visibility rules.

> Oleg.
>

