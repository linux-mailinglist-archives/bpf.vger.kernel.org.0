Return-Path: <bpf+bounces-67053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21729B3C6B5
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 02:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390D6179965
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F20F19F464;
	Sat, 30 Aug 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W/KJ3qJq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1881D54FE
	for <bpf@vger.kernel.org>; Sat, 30 Aug 2025 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514764; cv=none; b=mLHOgu6f9hDj9CA/5f4wvx2uVde40RBs0vZznFiNqaIOhMrsaUJb0Y65gr9XPom7XBLWA869QhkledXGS9C0f03oUO8DxTSpQwrycDOHymEL39J7/4DWTDWAWpOSQElQm0O3hFdFo+uojtOQZusIUQ9xsfqpf+nAQIkkbnWHwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514764; c=relaxed/simple;
	bh=8mek4otXRSBa5jdsIR7RcX9metPdhjWZ8Su46YZiXvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtYxg2JPmfzZVETEMGiF3cIUBHUVkI6pmlxJZoE1Gq8jnRiW1bKPwzAF94v/D8Dwi1Ms4t8B6j6UMkpnDlx8V/Mgn8oCRok/GXMN6n+HfUJdWeS1mAq/6jVqRTMkrPrzryMW9Qtjez+7phoLfGesJ4TgDBfclhHnb53avzchuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W/KJ3qJq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb72d51dcso391689466b.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756514760; x=1757119560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/LOKtbCFYx6ow3+8rmdtjbSkdbgBd5ekJbYw0X8HI=;
        b=W/KJ3qJqwMWOcC98qtx4r+zKYIwbcAEuzPJtlkfW9WIreSi77xkd2ZrbQw1V/3vCNl
         mjBEjpCVQA/WyAXBZCj0IO3reTmd/Y4U9SC2DRSk69ucyCc6jlLpsfj8KX0YawHFvqV4
         HIRQG+DIspIVi5z1OTauTOt8zkbI7WFFGU34I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756514760; x=1757119560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh/LOKtbCFYx6ow3+8rmdtjbSkdbgBd5ekJbYw0X8HI=;
        b=szJRoY+iCv67ZzD7Q3ChJwRueNNJPHFbTNefPX5P1b3O0xLKzSA/jXVOIOTfoEHTlM
         DaVygGdiV8KKK2ol+H3hF7TnoTWzR5g/t+Yn7hOohuZVP1dw0Zd3gNXakx2vFiGJp7oA
         iVx39bVnZssMEWJG9Us06ZjVHQeJgP/XUPPZApMOV4B6vjajzsun9F0sNTSPB6Vuei/l
         bPQ4dmdX3+9a4nj4GXidXQefLUd6jaYtwvuNOghN6d8KHq/CPjMu1tuqfwaC72+Z9nfU
         BZkS8MKZi1/fXyh2js54rs4lF52NBczgSaNYjcZBaBPUWcxZHy/UTu072vUQJtcupC3y
         uDfw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1VNsqnfROYJQqk2fbj1IFD6WJ19NAqDcX5NK8Y8kD1Y2kPq+VqBzA0/sOKrJ9FXlGyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJgTBbKNNxcdoYBSBKmrzI91RYvu12IcckRUfNSuxNe9xIGys
	e6VCR6NwPcXWQyXXiMRgvHimfsaLeD/x5v+u6nGv88IKPJqZ7jCIC4q/UA7EsmJ6cfSn0aVM1A/
	U0pQVzI8RnQ==
X-Gm-Gg: ASbGncsTfY/gq51t8cqZTvjqC+uJt5Fmmu4poXTCm7sxlfxwCQYtOl6F/3dvhaZpy7E
	FiskSmELNkrqgEjAAyjQta4KSe83/MWllkyhDPsox33SSQjRjez7PuR7BS7Nz8dDP0UVO72zRwe
	fj0gjfJl1cTKFIrPnVFoLsjm6shnSn/W8VYaMARPYOB/ijZN4SswM6wB8r6aHe0mlMIedWFESAT
	xE18LB6swfux9ULJ8r9AJDgkNei8tIDp7eFETimOBiGWWIA/xuF2lOKq5SC//kW9rU4j+zorasM
	WFbdUz58atTbYrRoLa4K6Zo5S9ui0uQ+QC/Fm16nv1V0on7ZLuj/PHTP2oinkNACRlT9dsnDUpS
	Mu2LDH+rGLDwWsyzLjqZvAsY9HlLf8/1pwXQJ9O2kaefMXqFPs+rjLo+K3nWAUzVx9WGbkdCvho
	M/a+ga0v4=
X-Google-Smtp-Source: AGHT+IEHSEkd0G2hTq1I4dUb21zvT0aYVHIZLK5PxIjVWjPUFaRj1M4LBfAypT3ZRtuSkJFw+cheUA==
X-Received: by 2002:a17:907:a48:b0:afe:c795:9ad5 with SMTP id a640c23a62f3a-b01d8a32186mr38362966b.2.1756514760144;
        Fri, 29 Aug 2025 17:46:00 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff138a8c1dsm153530666b.99.2025.08.29.17.45.56
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 17:45:56 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afead3cf280so346375566b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUT/vsciAo8ITo4RlQY3M6bbEs++V3k4WWoIYOgmH+MOIYtF1CBMGlbZUPRnU/WoRDev+A=@vger.kernel.org
X-Received: by 2002:a17:907:7289:b0:ade:c108:c5bf with SMTP id
 a640c23a62f3a-b01d976d963mr49768666b.43.1756514756264; Fri, 29 Aug 2025
 17:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828164819.51e300ec@batman.local.home>
 <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home>
In-Reply-To: <20250829190935.7e014820@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 17:45:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
X-Gm-Features: Ac12FXzHUWBAlxqQk5ohlyV44LW67utXZUBljhzh_p3civTAmgJnlakeCHnJEkU
Message-ID: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 16:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Perf does do things differently, as I believe it processes the events as it
> reads from the kernel (Arnaldo correct me if I'm wrong).
>
> For the tracefs code, the raw data gets saved directly into a file, and the
> processing happens after the fact. If a tool is recording, it still needs a
> way to know what those hash values mean, after the tracing is complete.

But the data IS ALL THERE.

Really. That's the point.

It's there in the same file, it just needs those mmap events that
whoever pasrses it - whether it be perf, or somebody reading some
tracefs code - sees the mmap data, sees the cookies (hash values) that
implies, and then matches those cookies with the subsequent trace
entry cookies.

But what it does *NOT* need is munmap() events.

What it does *NOT* need is translating each hash value for each entry
by the kernel, when whoever treads the file can just remember and
re-create it in user space.

I'm done arguing. You're not listening, so I'll just let you know that
I'm not pulling garbage. I've had enough garbage in tracefs, I'm still
smarting from having to fix up the horrendous VFS interfaces, I'm not
going to pull anything that messes up this too.

        Linus

