Return-Path: <bpf+bounces-66883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D771FB3ABC6
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F82F5671D5
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0C29E10B;
	Thu, 28 Aug 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K4g+bBQK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874E29A30D
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413472; cv=none; b=MvpBeLdQe0GIx5kP5hO/w5HT79qvlfK2YiwN+cbqrKyPf9r2Eh9p7OstoavcECSNNGcyD6Tk2gUBQL9c1KouuOVk5XpJw0Zy0i8NwgLbhdsY2rzeJ5WTshGvPAkZA/yjbsF+Uwno0RaimM8LwwGgiSjlqvBAOqLJg70DOSKQkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413472; c=relaxed/simple;
	bh=y4xkTZyyIp9xVQ83g6/iKJQ8eneIBd8o2R89VeAI4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj6TspyKwHFtO7I0pJ4VIKSTP/ufeJ8l9rtYbXE3scHKz7KR6Na1QpEI/YOg10xlfOkrfsmiDz6qqJFMkA35T3uzaEjE8KAg+pt9SE5SgaNpTM6c0iR610IAlpNJkNO8H0RnpkMeImpE7JeUAc9+p+bLvk+xSNNMCDu1+y+ODts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K4g+bBQK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78f5df4so241829366b.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413469; x=1757018269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGpm2okOCdPx1/l3bBzBQf+T/Xu4e5L+15QkBeqqePM=;
        b=K4g+bBQKHP5TMKS5riwwqfcXtFuo4moyFURPDLiX3LDjmgzGaGhU+qSHljMemyKTs8
         iYY21oUSSEgRwggDWk2heloinorzL3tCYrzsg4E0+ubYXPJtJlCCaorDwri0dD8D0uLK
         C850YbT69bAvvtOWjoEDip/eIinT7cM8gS3RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413469; x=1757018269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGpm2okOCdPx1/l3bBzBQf+T/Xu4e5L+15QkBeqqePM=;
        b=XPmtRvRaLnPbgiMebdh9zbwL5nXXfTK8DuSz+1Si+BtRMqq1r++QOSzKmgOe8Ja5O0
         1YHnZ7wjikRTv6CcatlFLxDTdDy1yauW8BRPkkxqDrCpzg7Q/zFxVjKG7XyVkg/TAEmS
         fXjmC36J85WcF9aXckH1lMcyT+nVAdEWJ/eBzK+YkTiHxz5mpRXs2BKnqWUrsOWNoySt
         CgNXx1Znyvsvs5GfAyE55YwpFYSNw7jHFhaEBFYFTf0l9VJyZmskC1AOZjGHKjDBJ63v
         Oju8PnuR4f91s1DHFybE4xa8kAHeNbvnjaLy9J+tdO0p6Jez5qdbMFmVO0vuOeRyTvTc
         6wdg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Sk14vZAWM+SP05MbRyG8TPr+3H1/IpVe/r+5DZUJQb2TmYqlAV04r1u74DEd19yTFdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WJCojNrSbgKi+/oL9lQrffY7WMBh1YOYxiFh3L0qC3XtHvA+
	acbYC+2lFHGwX1jY7QxQ88n9xWRPFnenkrDM3DmIqr1O0Y8zoc2fHYkb3IyR/EeAOdXU5Fz0XeR
	VaaTaXps=
X-Gm-Gg: ASbGnctoPtjn9xsKsxkbc3LPgrfFWhL3yQZPqG2V5vx6tVk+Q2QqmmFdl4xxfJScSoY
	PRAAak5ExWLDbRU1ifnwuG1MbM39cqMkQwzH9gEcvp1KnpDzlCyLIePc2Jvzqq/raE7xYb/ZIl1
	NXZRMfxXQY5i98TznzhHlBgU5Y4W9qewT9AO8Oj+msXxhVMOEvzfF37s0UVcwGvyGalfaeXaapR
	VQx/yPA9VDoAFmvfnOJhXk1xnMapUKnQt9lIfz9uHVjj0YU6SBFa9/OhKQMiab5PAwBv48bNk6e
	6voAdvJ4hQTS6tIsQbRvosKwH4DJbc6XnrPBFygO6gnk3GL5LnEiglo9Hc4LqW3dAEfuzR1L7ao
	EiDFqdcFeAPs6ncHrWRWYqS2yC0PeBNCTd5sp+PlU4+qJcFkd7pmyFdBCab+bxmGzX2q4p8k/
X-Google-Smtp-Source: AGHT+IHHC7WOaX8enh5ErS9jj/Pr6D75FyyyUzr76cTfqB82utceiabX3tzVHc4ga91QBKGgOUIJxA==
X-Received: by 2002:a17:907:720c:b0:afe:ea46:e80b with SMTP id a640c23a62f3a-afeea479aabmr383901966b.10.1756413468691;
        Thu, 28 Aug 2025 13:37:48 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7ee6b6sm35846566b.16.2025.08.28.13.37.46
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:37:47 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afeec747e60so151226566b.0
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe1212w5eiYtsTKJteAGCNs1F86X+dOJ00hiZCBPjcoFtND/7SOunu1Po7tQvuh7t6Lws=@vger.kernel.org
X-Received: by 2002:a17:907:1c17:b0:af9:1184:68b3 with SMTP id
 a640c23a62f3a-afe296358ebmr2525636066b.55.1756413466215; Thu, 28 Aug 2025
 13:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <aLC2Vs06UifGU2HZ@x1>
In-Reply-To: <aLC2Vs06UifGU2HZ@x1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiELUbwzPCKuA7xbN5SGyZSD12q6W6=eK4NfHDcMY58Zg@mail.gmail.com>
X-Gm-Features: Ac12FXwzzxmh7ZDt_iicZFn3gldj2XWLlsQdgYy8wB5yLOCnfQ4IOOdrcFwGY8M
Message-ID: <CAHk-=wiELUbwzPCKuA7xbN5SGyZSD12q6W6=eK4NfHDcMY58Zg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, 
	"Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:04, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > That said, I think they are problematic too, in that I don't think
> > they are universally available, so if you want to trace some
> > executable without build ids - and there are good reasons to do that -
> > you might hate being limited that way.
>
> Right, but these days gdb (and other traditional tools) supports it and
> downloads it (perf should do it with a one-time sticky question too,
> does it already in some cases, unconditionally, that should be fixed as
> well), most distros have it:

So I'm literally thinking one very valid case is debugging some
third-party binary with tracing.

End result: the whole "most distros have it" is just not relevant to
that situation.

          Linus

