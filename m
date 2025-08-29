Return-Path: <bpf+bounces-67016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C4B3C17C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034DC5A15BA
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C3335BB4;
	Fri, 29 Aug 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D5H1xhbD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047D222584
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487130; cv=none; b=LZjDMSQrOC3oS7Bsq5ZQnmqr0OFJOIx4oc8iHQvcjZNAuvO8qgF7UUfv7qCzRDj8dJGGXIM2aGJ/ukrt7ZAMh/Gc5v0eEvk5KDZi5hEvNT+R3mPmBHcrbebIbmHzLRWZLrPkFG8h0P3QwUsfd33KUpAyb9AGF8VaZgvGETno3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487130; c=relaxed/simple;
	bh=SoJHOnBFCfoGCBXTsMVg+w/WiCD13CEgrKBCjixr8RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAy6JR2z6EgIWg4mhx8hMRiCeQlnqw7KbUj/pJXbMq/+GWJUmnyPEGEziY6MKTgT1a9fIHkobgjD5B1MZ3aLxIQFQg09zlMqcfF8RR5ftlWSTinyr/oVkRNbdqjuzdfiHePFP00Uq1Aw3xBKHx+JGANoywCa1CNHQAZ55vpTQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D5H1xhbD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f69e15914so950562e87.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756487125; x=1757091925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mkhd78GreWWyO+3GVa0xKo1UMaxxdaoGBAEK0+06R70=;
        b=D5H1xhbDtlggOD/ql2z8ZasQM6ZuPr5ak63C/m/EGSympd6zE6kJXq60u1ng+4wFH+
         VHBH0n9+2ltz7PzYWhu+nlThGY72Dk9tzW7RCPDiUhxNdYBNvqlRRdEmEkCFM52xiAtA
         XQ5vnQBXHUAxlz+KASs+568DR38fSEHA1C4ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487125; x=1757091925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkhd78GreWWyO+3GVa0xKo1UMaxxdaoGBAEK0+06R70=;
        b=d/0VjSKusUK9p8IFFP36jxOrHZe/X9niXlLAzKwVxKqTMFZPv9maE+psBjw7sTzjN6
         7CKqRt3lRoo5staL3vmNPlqFg8oL87K25Fj43545dgOSl9f7rbI4px0coO1Ha2nT3U+I
         ViJmLM45a47pVu8r9knH5ePzJ5JaEDR3Qeffo1D9452kSoDeQbZpXbtTvhRTCB57ziK5
         DL/6LtOgSEz/LUAdo/AGflMvIzXS0xYvbkKjLYYH4v2+TAQrgcEFK1Zb+CDxLRz9Tqmh
         NiCZLqZxwHLzjCPqH5YPt/s65BbXiSZA+JLY58oLAmk3TBkD1q4LDIMgjDzjP/64XHoB
         5nUA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgdkeZalhrIHzORI/ziKLsG93T5FCFIQGjz6zqTB8d3gtZiAbM1UdnQ6Z2IrpK8RFlVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/l2wNQnBfBy+2h2T1gkve3YrRNGiUkkDhjd/2z6j9bTUhiQ12
	yDqHwM37RfdmW5jBXL4QRl4Q1hOYt3Fs/bUEhcqenFrtL3Wxn2mb0KNJ+/sV726Y/4wfofDzZHu
	B+OFtfwgv4g==
X-Gm-Gg: ASbGnct129d0FO6GbtRNb2ZZJlu8RoiZsKBa2g36Ro2EgCC/GEjAzNn7luOADa/mjnA
	oPJ4P+wk6TLIikMMDDtcL4SSctXdi9cN1KF2+40HnefUaeoYpOaqkvquvWBjIDR2OLZzt+yJJpm
	FawXU04nj/byP03z0Q3pylXW9Mm0N/lPgsAKQuitWZsE+kXgWy++vQi3UH+jaafkQR5t4TOI3sV
	c1t0NbZJoZiw4Bq5+d72rYpwlDcqmVXXn1NggFbuLOEHKXqkUi6XDimFsp8U/yNo7/JXjOxGB+r
	iuKK9xOCdlxn4SJF5PPQNSkrrN1VFCEKzFsgbqgnPlyyLCsujGC5tJE8+oyppc+B+RJGVQgR48Z
	NzlyWj2ze6s1jRXKMFiEQgG9V0muoryQkYEv7AQ3VZ3wY9k6sDy6CFoDTKZPkWSI+wsBxIraa
X-Google-Smtp-Source: AGHT+IHOxUTX2x88GBIqqipvOHgcNQLFuiiukt+9TcMKS992sdb2iy2JqaodPoN9nbRCaXTQRykfPw==
X-Received: by 2002:a05:6512:32d4:b0:55f:67db:5a1b with SMTP id 2adb3069b0e04-55f67db63bcmr1026884e87.19.1756487125188;
        Fri, 29 Aug 2025 10:05:25 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6784fdcbsm776669e87.98.2025.08.29.10.05.24
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:05:24 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f646b1db8so1888588e87.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:05:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEDtWxF5HvBwi1gmP+Ctp8zfMvxqsaQRGmheeFLdf7SmbMy0XkuXLa3DhHq0/JPMkN9Tw=@vger.kernel.org
X-Received: by 2002:a17:906:7306:b0:afe:f418:2294 with SMTP id
 a640c23a62f3a-afef4183758mr490846066b.49.1756486778196; Fri, 29 Aug 2025
 09:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home>
In-Reply-To: <20250829124922.6826cfe6@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:59:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
X-Gm-Features: Ac12FXzoWvnofwTTj2JxozA4t3wVRQGACFrkZ3mDbu-fxUdeCzXWr6mKd0oudcA
Message-ID: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
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

On Fri, 29 Aug 2025 at 09:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> What do I use to make the hash?

Literally just '(unsigned long)(vma->vm_file)'.

Nothing else.

> One thing this is trying to do is not have to look up the path name for
> every line of a stack trace.

That's the *opposite* of what I've been suggesting. I've literally
been talking about just saving off the hash of the file pointer.

(And I just suggested that what you actually save off isn't even the
hash - just the value - and that you can hash it later at a less
critical point in time)

Don't do *any* work at all at trace collection time. All you need is
to literally access three fields in the 'vma':

 - 'vm_start' and 'vm_pgoff' are needed to calculate the offset in the
file using the user space address

 - save off the value of 'vm_file' for later hashing

and I really think you're done.

Then, for the actual trace, you need two things:

 - you need the mmap trace event that has the 'file' value, and you
create a mmap event with that value hashed, and at that point you also
output the pathname and/or things like the build ID

 - for the stack trace events, you output the offset in the file, and
you hash and output the file value

now, in user space, you have all you need. All you do is match the
hashes. They are random numbers, and user space cannot know what they
are. They are just cookies as a mapping ID.

And look, now you have the pathname and the build ID - or whatever you
saved off in that mmap event. And at stack trace time, you needed to
do *nothing*.

And mmap is rare enough - and heavy enough - that doing that pathname
and build ID at *that* point is a non-issue.

See what I'm trying to say?

               Linus

