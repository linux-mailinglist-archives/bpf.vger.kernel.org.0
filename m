Return-Path: <bpf+bounces-61758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C8AEBD23
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791806400B8
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFC2EA169;
	Fri, 27 Jun 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JR3+BgZo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B12EA166
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041415; cv=none; b=nCMPSO+nde6OUY+ma24P8Z9jYPbYLsD7vgvcq8PcGZnNAQih/1kYtKoNWAxe3NDNG28S3JUQdWwTIU4Maa3mc2jkFjU3cBrJPMLs8NAhtr31xejVj7N7jF7Udorc80LczVOc/XCRFovswqfG0DsNdYeXsIMaoiy56Uy3U/PGVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041415; c=relaxed/simple;
	bh=1Z5FIvgVxVgOK1v1qVEDoeCNDa+RgVIxtitLI+LQd5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6zfZmc9E/GMGvtTwVfuxluOMT9zsGGbKAi3tKLL9IDVxtNq/ZNP6M3USOwauHxvhUqooNbqJICb6L+AZA/LZGgnPz/NmKeHI1gKwOwud4h/GpBw+CO/ogJ+4Z9VbRY+Y+JW8P2UMq4SO7TZPr7Iwnp/DCZsl9ayFOouHoULSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JR3+BgZo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0de1c378fso261136866b.3
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751041412; x=1751646212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIBFa7vtiai1aZdrnHbI17B2HX5VyBn+7Wdc06Hzja4=;
        b=JR3+BgZopOVs7ONSnpX4gIlqjzIgkrIJFm7vJ4IVpcjYPastG603YjJ8g0sMu32oM0
         FQW8sPvENaGzBXMUki9HLyilZxQDAhFXu1wT6jxtrE5GtQAqbn1vu2ulHN8UFjyF0Oat
         cIJHr3+CocRyChiB9857rvJl/vRmBvwz+Av+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041412; x=1751646212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIBFa7vtiai1aZdrnHbI17B2HX5VyBn+7Wdc06Hzja4=;
        b=m40KKfCn7nhPK9Oou7UV4W8l8XygbwX9DVPw5X+XIrSQpcyRYL6aq3WvXIwT4dY9yJ
         iZMBlhIRq+W+HxvEUZMP7hn3kUsoRG9yIu47wxq270H09Xu1++DVNzDSY6c1jTfdGTfg
         7RnZES9NC5w2vOi2qCFjtYuhVrkMkU1tf83cRt5zBmOkj56DzFJk3WU5ELxMF89wbEfr
         BOPEli1ItWX/IVSfdx3dn1PLDv/bK9Z3mpWhVOpqijInuoqxtMa3mpbJn/QpQPWtGEGV
         Cm6UC5ALS6+x8FIaYkE4pmRxtvdS5WJZjs7F460JXfQ2VpQdnmphpeg/d3Dn51h7WPk4
         iNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP2MefpzrKr3unTbBWGENVCbZ/Ccjyiz9sACJlzi5fm5sXrlWLr4QcvANnfMDUcaJRCjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOFr5JsQZnmwV7B4cVEh5vBx8h2jTQM+OwMYSMNNF8bJsAqZv
	iU+D7tbALvPVINJP7LhKQXDj9Nz6M8aU92evLBYysqVg9XflkUxymLEyYA6g7fzeY6xpJqC6jqx
	7uWfV4HM=
X-Gm-Gg: ASbGncu2+KVqZCJYn90gFg7M7SinsptGv0iW2m5aQt8Yq9+Y+kLyhPftyGEk9ppuICi
	VLfnveA7/b50FvP6zjnyal/rLpSYQsq8wUGRK+zmXjllEPplAvWPmogI5wbR+LId56lpPZDo245
	6g7R5tOkQQJNJmo7VT/iMs4EUwKSpZFcnLkIGnP1PK7pr3SAE3bU+H1ZtOwpI/udUwh46in16wt
	IgsQaxjX5EyaaXlrrz81C0S3xzO35+vunbCraC22BUFZncbIoVRdnr7pQJzKBTHz/edRSzK+bIP
	b2J/BEubTUxnyPqv06M163VZfUKmxHsIf5w6IYx8DuhC4+xmPj2HxEvwihGfWQIr2Fb/YrgDA7k
	9yEWwxVU7eFYLkFf68Fiv0+rJWIqgy8JhUYij
X-Google-Smtp-Source: AGHT+IHa1Z1DEzDxGUjaeriKP/M1ZKDUUXOaR7KjvUUyuoJvfb3aHwWu+YqF0DofT3Yrgwq0Wt/SWw==
X-Received: by 2002:a17:906:e244:b0:ae0:db23:e3e3 with SMTP id a640c23a62f3a-ae34fd2d638mr381449666b.16.1751041411892;
        Fri, 27 Jun 2025 09:23:31 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bc08sm147443066b.131.2025.06.27.09.23.31
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:23:31 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so4781a12.3
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 09:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqGZmFOpjMOUmIOzQhDAnFjUpI/5T9TeR4ZXUJq79Qs9jOg9cl+skvciuDyhs4qjXUKMc=@vger.kernel.org
X-Received: by 2002:a05:6402:34c6:b0:5ff:ef06:1c52 with SMTP id
 4fb4d7f45d1cf-60c88d65540mr3554120a12.3.1751041411199; Fri, 27 Jun 2025
 09:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625225600.555017347@goodmis.org> <20250625225717.187191105@goodmis.org>
 <aF0FwYq1ECJV5Fdi@gmail.com> <20250626081220.71ac3ab6@gandalf.local.home> <20250627100113.7f9ee77b@gandalf.local.home>
In-Reply-To: <20250627100113.7f9ee77b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Jun 2025 09:23:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXsMA3OJ0tnSWFDwqH=H8OAsUwF2hqCuQ6uHaLmpQubg@mail.gmail.com>
X-Gm-Features: Ac12FXwXn1CGZ5TDseyf0yMPbEJKzZlOp6kLfp771zfoaf5rHgLNIhEIXduSSPA
Message-ID: <CAHk-=wiXsMA3OJ0tnSWFDwqH=H8OAsUwF2hqCuQ6uHaLmpQubg@mail.gmail.com>
Subject: Re: [PATCH v11 14/14] unwind_user/x86: Enable compat mode frame
 pointer unwinding on x86
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 07:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That's not a function. It's just setting a macro named arch_unwind_user_next to
> be arch_unwind_user_next. I think adding "()" to the end of that will be
> confusing.

Yeah, we use the pattern

   #define abc abc

just to show "I have my own architecture-specific implementation for
this" without having to make up a *new* name for it.

[ We used to have things like "#define __arch_has_abc" instead, which
is just annoying particularly when people didn't even always agree on
the exact prefix. We still do, but we used to too. These days that
"this arch has" pattern is _mostly_ confined to config variables, I
think. ]

Adding parenthesis not only makes that much more complicated - now you
need to match argument numbers etc - but can actually end up causing
real issues where you now can't use that 'abc' as a function pointer
any more.

That said, parenthesis can also actually help catch mis-uses (ie maybe
you *cannot* use the function as a function pointer, exactly because
some architectures _only_ implement it as a macro), so it's not like
parentheses are necessarily always wrong, but in general, I think that

  #define abc abc

pattern is the simplest and best way for an architecture header file
to say "I have an implementation for this".

And obviously the reason we have to use macros for this is because C
doesn't have a way to test for symbols existing. Other languages do
have things like that (various levels of "reflection"), but in C
you're basically limited to the pre-processor.

             Linus

