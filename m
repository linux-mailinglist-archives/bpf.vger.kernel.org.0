Return-Path: <bpf+bounces-67046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E305B3C55E
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C174162B77
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13202F6574;
	Fri, 29 Aug 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ci//8evQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488242F39CC
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507687; cv=none; b=BgBj9x84MFq7RQCMRK4FerdgJ1pmGdcmFTjYD3S+07huRDEnleinaiZvhJGwH+2oBsHCW/gfsU6Tza718S7XR35poiSO0n+SMK1d4uqdR6ZOMioog0hJZPKOBrOGSkTaaT8zC73qc1BAy0jA6z4akY2P5cS72Rvg+1rgpgPGYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507687; c=relaxed/simple;
	bh=CtY2mpOi2NxxfnHcuhpi2dhAC8q+hcvmMeWqGSAe4aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u25kZeAdUo46SurB3N+OhL32XCQ4ZS5jlPhhOx+PIiVDZ9Ch+x6Oe7fY867znveX3P52OgH/uxuk9nsXbMfNy3bMXZewxx4wjvb6TRFXxVQatyShGn59BPUwXolCX53Jr7McwB4iSXArdYzonaZ/7FlUP1Suho0pbugRSAg0Wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ci//8evQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f4978bc0dso3020369e87.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756507683; x=1757112483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80fI9uxCwh0sulZ4xikoEydehsTfM/BZBcIbW551mMY=;
        b=Ci//8evQQrjJG62bg9ALsmkhjCI4W2y/6l0/8M1FPDsiAG15DCQH+/ZF36XZ7+Axf9
         QHnB78DikEfMyIQPzXH66SATD78llSd6OS3QjVcuA3v0VV+sPdSZm607Bf3D8IeI9hp9
         bByDE3lzRmEIa/PBzGPFLxZUIBHZk7qDJXFFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507683; x=1757112483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80fI9uxCwh0sulZ4xikoEydehsTfM/BZBcIbW551mMY=;
        b=AoA5kidPNdsZAZPpmySMawxeqJgxRbin2J2BlKFA7nw0ZZ0G5TcLsN6bJYWDzxV4pt
         i/8an3bGDAUuD0QmySv6mKQ1tyjjhAdZQuk3GfhpzeIlNa5jLjP6/LL5oyklFto1umaU
         Yd7Mbe/dkJL8d3v8stIZ36zPh3rTZoowUCggvfPtJrXg5yPZ0hmN+1XxtWzR1T3ctNTq
         yL66G7skvCKeg/sXIC47SxFEFXthjCz8vniq79v/ju8w9Fz57eZrYgLAzD7enjVgE3ia
         5AHxsFFXODAwyc7RmnKG/3yyU9jNop8uiq5rer7YVO1tl57OHZehgVLIAsk65AamO0ev
         WiTA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ULD2JUAYY2kuammgvMBw1No2Byjtq0UvvNyxTJpsKfFsZNjADEgHbnduSne7RoNqCpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+rv9sAvNvdlwuzsrY6uqz0EfIXVgA01c9fv9QlhObSEnC2c+
	qs3HXe1kF6o+gxgXEivG1G8n8AiQicT++wuJ0CHUM27ob0nOK+I7Nv9hPkx8HWLb3yQqf6wt3Le
	1LmdEfrCYFw==
X-Gm-Gg: ASbGncuGCLICEgn36cm3p1pIbU6n0vhF7jvNDdqPgfU9helU46LVQWOx1xDyYISCRDm
	yT5SWcdWjLcfaMUqJRs0FhCIBqfo/bLUlCTu5xlWg6XRSFFGJeCyXh3ITqrqx8PqRlPZuRZCkBv
	KgF3wXDgrfomr/WrfCXgDtyv9ZutK68sWCgANbBFLCWOMCYOsolNqncZaLRriv2DP667WGNJ7sQ
	bhA6cxXtKj9PnBeWG6YBKhyQQUVrurTJskh7RZpcsmK2S7qR8Xy/IX0UHb/9KoOl+d7Qw2SXk7J
	MeIFQXKrR0OSBzghPftM+pxaoi2DOzI5K42lpWUwB60evUSZ4az4nV2B+yJlUgtmpAlMJFQZv+b
	uVLC+ToXTENSk1rYqVz0okjEhhGVzDu4KwmedScrfigDwX+pLNOICxqltuWdevee30JaPB7hkiI
	PAFROc3Og=
X-Google-Smtp-Source: AGHT+IFNGe5jFU3bGl6IhNi1Sar2xg0GrGE2yiWQ1MLplKmLV04fNEET1WjgT9Hm472lHsTPCfFRPA==
X-Received: by 2002:a05:6512:230b:b0:55f:4c9c:27d3 with SMTP id 2adb3069b0e04-55f708a378cmr71422e87.10.1756507683072;
        Fri, 29 Aug 2025 15:48:03 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a41a08sm937327e87.133.2025.08.29.15.48.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 15:48:01 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f4978bc0dso3020340e87.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 15:48:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxKjb5qg7xjJCDB5uDolS9NbWCw0iWbiaw6c8Epk/fjkUSGTLZmt4rzMlKa8gmHspkF1U=@vger.kernel.org
X-Received: by 2002:a17:907:c27:b0:afe:63ec:6938 with SMTP id
 a640c23a62f3a-b01d8a308b8mr19318766b.7.1756507224565; Fri, 29 Aug 2025
 15:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828161718.77cb6e61@batman.local.home>
 <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home>
In-Reply-To: <20250829171855.64f2cbfc@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 15:40:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
X-Gm-Features: Ac12FXyqIi5ZrrVYAf6L3CbDdFJBIuaHmGG9fnmZTA9Sh2oSS7jS6S2QKEpzFcY
Message-ID: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 14:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Just do the parsing at parse time. End of story.
>
> What does "parsing at parse time" mean?

In user space. When parsing the trace events.

Not in kernel space, when generating the events.

Arnaldo already said it was workable.

> When I get a user space stack trace, I get the virtual addresses of each of
> the user space functions. This is saved into an user stack trace event in
> the ring buffer that usually gets mapped right to a file for post
> processing.
>
> I still do the:
>
>  user_stack_trace() {
>    foreach addr each stack frame
>       vma = vma_lookup(mm, addr);
>       callchain[i++] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
>
> Are you saying that this shouldn't be done either?

I'm saying that's ALL that should be done. And then that *ONE* single thing:

     callchain_filehash[i++] = hash(vma->vm_file);

BUT NOTHING ELSE.

None of that trace_file_map() garbage.

None of that add_into_hash() garbage.

NOTHING like that. You don't look at the hash. You don't "register"
it. You don't touch it in any way. You literally just use it as a
value, and user space will figure it out later. At event parsing time.

At most, you could have some trivial optimization to avoid hashing the
same pointer twice, ie have some single-entry cache of "it's still the
same file pointer, I'll just use the same hash I calculated last
time".

And I mean *single*-level, because siphash is fast enough that doing
anything *more* than that is going to be slower than just
re-calculating the hash.

In fact, you should probably do that optimization at the whole
vma_lookup() level, and try to not look up the same vma multiple times
when a common situation is probably that you'll have multiple stack
frames all with entries pointing to the same executable (or library)
mapping. Because "vma_lookup()" is likely about as expensive as the
hashing is.

           Linus

