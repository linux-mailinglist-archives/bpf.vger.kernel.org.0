Return-Path: <bpf+bounces-35011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1799350DC
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D95B227BB
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FC145336;
	Thu, 18 Jul 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScrKvlXX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F92F877;
	Thu, 18 Jul 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321173; cv=none; b=t/jhiQHjUcywUKw42kIuIJRC4ZJblLQJdqUsu8N+zGjpDefDp/dsokwVgXGzYsT0/jaSFQ0xy2k1gW4TLYOy0zxZH1rud+OsAmto79zyvWfkPCxXNiX7VJWBFMnZKBOrE+cnP8QcMvZEMimSbQhrCX6/eG4UsrSkdfrSx1OXs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321173; c=relaxed/simple;
	bh=arhQFPA35GKI/93FWGqsJVzt2AdCMpET0AJ4iJUPkU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2hfnlRSvM64BeNP+9mUSZSokXxUX2DgJ+xLlPsgWZQmrT3Lt8LIuTxp5b3p3veCLcY+r9lsN/jOTfSHLtZ43gpIXtLn91EWAcEo8+TGKVaixXseGgzI+uDCWnrIo8+be3hP0kMoCk03IX/WwlS/7K2w9xJNZw1uQxTssa12fxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScrKvlXX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso31578b3a.3;
        Thu, 18 Jul 2024 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321171; x=1721925971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arhQFPA35GKI/93FWGqsJVzt2AdCMpET0AJ4iJUPkU0=;
        b=ScrKvlXXiDuzpYxPkXWinR1r0D5CtZyqra4CDo8MImTGEUARScCs9g+A9Do5a4YQGJ
         KH4t0NieO/xzQfwk70Fr5i64eowAoXzaD+CEGzSyyEa3JtOrA2XZ2YWCSt5s3wzQpTfP
         OW9eBE3BfcVlmJFSucE2oASE1303WAG4//oABDsXwpxSjQP27O9hfScGykKG5sTLQBsR
         Y5mPcHgQtKnbANwsbv9M1usXTerwuqM7ngROWVRL9nxdrI1GUgtnyGNvmx5VBOxR54iY
         Y7Koz57On6F7T6fTbakogdOQ779tHkU9o5WfruGsMhjXIZel7bXNkr9Rua447kZcYR14
         wIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321171; x=1721925971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arhQFPA35GKI/93FWGqsJVzt2AdCMpET0AJ4iJUPkU0=;
        b=aZXTAJwRSk5W6Yg46JMdA4TbWEWGC2J44DSoqqOcbj54XjCm564wji21gENXro4epR
         ip0pwnAkng3FswD9TFIDvjZ2U1qJGS+AO+JYfW8HjLNULAqb+wcAYbdWtd4Huc92nH8a
         FYj0nSJD8XUEljXDyZG5B1McCYUFr0r0sR9QzO8hF7hf/5AmH55asxRRNzAOPtuPXxvj
         ZqU+jtnExFjxm1H/ZsZuNZiZIm+Ttgt5lyanXBg+0sFy1FKzNvKmKjU5ISgULZg27rZv
         5/+LmSJpuIxIyUm0ttiIMniZAvGqpyxsrrtXI/N3bYAn3pTBq0fQLQVs350fj0wIJAaw
         dTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvLNjlttN43EvXMcB31JMyA1Wt2AlCizggwT05NHsF6UWQPz/1R7xf0HZj+Ta2aVPesMckKyFQNXdQ5oUECbE+Hjns1ejbbEmPqXm6jrNyrPzKQPOiliEITgRsPU4VJuQivnLjoUglm59sLkdjJKip/yJvZ6X/RoN8z3X5Q/jUrQ8yM6wCt424Jci1uoQo+JQbG6zNnwkh2gw8EisaiG0k22smtZlXFQ==
X-Gm-Message-State: AOJu0YyGdLhnqW5Mf3aYHRZGH/6tEIACPZLP3D61gMew8XWwhRpi8Udy
	SnHsZnbTresnSXDOv25iZxGcfhiWD+xAGe00W3SwKULqx/gdFp80t0NrBCcZJl8/e5Hi3x7Tc2M
	PajWiaIm8cLXIdaZzNb1NAPkDIzw=
X-Google-Smtp-Source: AGHT+IFHq/HyFGjzo5nT29rrLEfgvMPTpXRQf82XzBKasZvQqN+a6kU4Jb41QlgaO1cXmg4e697XxADWX/sczTUn/ek=
X-Received: by 2002:a05:6a21:3985:b0:1bd:288f:e8b4 with SMTP id
 adf61e73a8af0-1c3fdc661b0mr6776285637.7.1721321171572; Thu, 18 Jul 2024
 09:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710193653.1175435-1-andrii@kernel.org> <CAEf4BzaTEUkRU37fsuGy+-otWk9K0-c9=hs0APRz7pJy7rq-5w@mail.gmail.com>
 <20240718114521.4b0220b7@rorschach.local.home>
In-Reply-To: <20240718114521.4b0220b7@rorschach.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jul 2024 09:45:59 -0700
Message-ID: <CAEf4BzYGWLYBOYxK6YteDNu3tEkF00MBm4d1Z7twXF-SfSZXJw@mail.gmail.com>
Subject: Re: [PATCH v5] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com, 
	tglx@linutronix.de, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:45=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 18 Jul 2024 08:29:23 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > Ping. What's the status of this patch? Is it just waiting until after
> > the merge window, or it got lost?
>
> It's probably best to re-ping after rc1 is out. With recent events, a
> lot of us are way behind in our work.
>

I understand, will resend later, thanks for quickly getting back to me!

> Thanks,
>
> -- Steve

