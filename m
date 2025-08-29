Return-Path: <bpf+bounces-67038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C119DB3C3F3
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7547B2287
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33A346A08;
	Fri, 29 Aug 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S/EUYBlt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB420B7F4
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500730; cv=none; b=bSroPLrWK/gjJID1itkIcVdocVQJedWNo8A7Ktz/gt2lnuXuupmq0Ok6Dm4XPRFLKIWxzj5nnAn4TwreWU7B8vhF4WsTKGFBMzG6cBi7LcM7EDsq9+oumyy0gkzXjef4266DTykAfYxuJZjnGiV64qTbjHzpH66cFiSqD/q9uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500730; c=relaxed/simple;
	bh=ohMVoYLKqK85A8YWDL5s4gkFfq9CRDj3CUysT+XmebM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcHZROMTSsQx9BdDmZWkjAT9aSi29ZxwOks+p/kGCgx/MUsWK/AEAfMnUcnR7vJBG1CmnabfTkFESeUyMHvqfsq0TYbBNkfr0UpFaqgUFsi5hJmuULZnPdX5l7CBsHO8uh4Y+wqkBN22SizM/D6IdgHJ8aH8ADVkTtgHE/aqwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S/EUYBlt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c7942597fso7076240a12.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756500726; x=1757105526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJnIXD44JoqcrcREChaKXOoLztkoHAV/cNICzLJGB4U=;
        b=S/EUYBltCP1ZBgFu5FDNsd5DCvA4Ppgs1eLMOuo3OVd5yunUI02rl3qAjrnmVhyLJj
         0oJJUJgIbfTWcAGw0vDrekP6wj5pld8r8dZ1YYcfOY7mIpKRTQb3tWZp3eNr2rwIP2W1
         skfWcljNNdaJY1rHp5ZQIUXfRk24zz3WTk0HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500726; x=1757105526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJnIXD44JoqcrcREChaKXOoLztkoHAV/cNICzLJGB4U=;
        b=wKlKQXWBa6GgTrkBc1SBOQB1KjMB3+D01/l4Eyb1PoZ1ZzGnjlzq1mQy1/WzLXQrpx
         82lvBgoaTXJP1egBy2MwogQR21yAgbUL0YRqTdQQ++31qfM9UtmMJfEZqOUYPbhkZ+Vz
         CSM38nxNkWV1QwgchRhUoiT/Vquijz4hVgyl5/CWzggIgtjs3Fd+RxEqw0LfAyfSJU6o
         YpAOXqfjgfiBsEw9W+s3c3MJTwri1xVuKv6qx/Cl0HoBo6AItMgNCkeoyLZCjTsG9eqS
         vD8grsoSEGJ/kAoXFcn5xtLoWcSzVEcm1lBB/Ir7pF8e+09OXkBaFXNeo8QjUb72OSLK
         pQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXL88ZwCCDOKR9hbYBCOVqmlr8TE1uHAxISVNeilheShc5HzFg0xj1/CaF/psH6bF3hdDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxzoz/8yLbRulCDkadC7Fx0Nq8JneSo8w/qhps4YgwTz7zKAQV
	7qEGOstlgpwexx9L2QCfCv5fQLqXSsBmudI6wqu6Xa/hIHDGVObZRsRQ8ANRsfGw4PfpujWWrmd
	0JNU0jSHsZA==
X-Gm-Gg: ASbGncsFS5BIcAJf2qCT+cgz6m3ch0JSSu/LkFjCC0NodWIbfcGozMc8l+JG8tgAiE1
	KKwJb89IRFkpynC4ZN+i0ZNAVFII41OyyywBlnUMbWCO2eU0fTaxpv4UIKKBA9jEM1CMzAv6d++
	Nf/pSu3alzk9teKoAg6utCC2/7sNjG/ifXFqP5aPO4ykV+GEqbKMh5nBgaan5IhXJ4R0OCJcJFr
	s88R4kly/GoOTZQro4TPAfNDh07hwBFB4y0eAmI0UqsNLKbabKc2u8DNJz16/4Vhel52EgPmBM9
	0vxiA5BjL5ZQcaH/yDc8HfYEvzsa2d3SlZaiBO0Qw+Md6vdVyOXDvF9zKTmVrIwClqH+fPoqUad
	guzD6CZ7GjA740JWw7ysN1DxWPdRHaa/5ddkaL+EAq2cSLQpl3Kt0y6SRSvJfDC1Y6+hwDELKip
	xRirkqxaY=
X-Google-Smtp-Source: AGHT+IESqgGcWUydbqvcw3ciy4zOX4tpJcgkf1wOX1AFrel9T4l26c5Ulgi/98IKyyHXPj/jsL0tyQ==
X-Received: by 2002:a17:906:4789:b0:afe:56ce:2423 with SMTP id a640c23a62f3a-afeafec6595mr1506539566b.16.1756500726473;
        Fri, 29 Aug 2025 13:52:06 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7eda86sm283246766b.3.2025.08.29.13.52.04
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:52:04 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so6558120a12.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 13:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1wR7yAGWwl4Hmqgoj/edeGs/TS8E3HYMovM5U/wIB9ENgFOs1uj+r25gEdluZghs6WTc=@vger.kernel.org
X-Received: by 2002:a17:907:3e02:b0:afe:84ed:6152 with SMTP id
 a640c23a62f3a-afeafecb9a7mr1571449466b.12.1756500723697; Fri, 29 Aug 2025
 13:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
 <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
 <20250829130239.61e25379@gandalf.local.home> <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
 <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
In-Reply-To: <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 13:51:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxMx4Bew7naxecrivtrdt0mzABSTt==vO-tO9Th083kQ@mail.gmail.com>
X-Gm-Features: Ac12FXyW0nAdh202diR-dvFjPy8CyZHx9x_gTjrEDXtExTrmFznxHPLMFXgTReA
Message-ID: <CAHk-=wjxMx4Bew7naxecrivtrdt0mzABSTt==vO-tO9Th083kQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
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

On Fri, 29 Aug 2025 at 10:58, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Can't we continue with that idea by using some VMA sequential number that don't expose anything critical to user space but allows us to match stack entries to mmap records?

No such record exists.

I guess we could add an atomic ID to do_mmap() and have a 64-bit value
that would be unique and would follow vma splitting and movement
around.

But it would actually be worse than just using the 'struct file'
pointer, and the only advantage would be avoiding the hashing. And the
disadvantages would be many. In particular, it would be much better if
it was per-file, but we are *definitely* not adding some globally
unique value to each file, because we already have seen performance
issues with open/close loads just from the atomic sequence counters we
used to give to anonymous inodes.

(I say "used to give" - see get_next_ino() for what we do now, with
per-cpu counter sequences. We'd have to do similar tricks for some
kind of 'file ID', and I really don't want to do that with no reason).

And if the only reason is "hashing takes a hundred cycles" when
generating traces, that's just not a reason good enough to bloat core
kernel data structures like 'struct file' and make core ops like
open() more expensive.

          Linus

