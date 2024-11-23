Return-Path: <bpf+bounces-45511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC089D6A9A
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B806B21AD4
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087413B298;
	Sat, 23 Nov 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UMDroGWF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8517BA6
	for <bpf@vger.kernel.org>; Sat, 23 Nov 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732383534; cv=none; b=Je7AHBlTq/xN/xM+YNXljT0YO49zvunnouoJcfChtdv1K3nhZ3YimmaWciR2lyExEV8qTbKC3Fin601srLfyOId52pGVutB0eGSpQEhrerhJ/TkGVEnjQDkOxAZZP45jU7w+y9ldlMfAshB5UdJoVh0e9yUDj5TqQ7jNQ0sB5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732383534; c=relaxed/simple;
	bh=Z2N+kTJzZXoQJzfXPyysOgIn5Wbo9WbTTSH/hpfAXyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHGVl2zIq09AKxcRvmGyHPZyOLbbPIa/tAOGZfj1Y96kBJlGDIHVUSP/3ktYBHxP15G6UBgev1TGacZ03hG4X7JidIGrAKUzBZxYklE3nrRbJHY172QzluGLSbjL/8xO9wfx9bfv7ln0ThZnSqfYqxDxi0l1amhyQoR6TfGXUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UMDroGWF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa52edbcb63so152877866b.1
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2024 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732383531; x=1732988331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpM1fsZfdZBok4MSDnesEhvbM53AiXvjDwKI+kJlxP0=;
        b=UMDroGWF1+7vELjsmAXzd2LAZEjNp880pmEcFq6eKCbmgRJZNH2uzdXNlaj+5T90L9
         iknr/bZ82UM8jLlcWT+7cMvoDniVtGVeP2YeewGqfmf5Q/ZYVaRiFcMvIt1o/Rwnt3+b
         NiwXL7qcOgK8k6V8k+2YaJif9xh1S0p49PNQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732383531; x=1732988331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpM1fsZfdZBok4MSDnesEhvbM53AiXvjDwKI+kJlxP0=;
        b=QTQBk7q+wbDqNS28uxzPFP0NQNOzeGZL7ebYvepxvoTHXryYq6pf11ZfQC3rt2iI/x
         VPnbzf1rt5xXBLQXDpEV+WAuZsv+x8cNZllzavXWmQ4SJ7nmYVXbzCbNhe9jU7NvVTX4
         nOuJqwKeEVuGk92IPM3jofLvx9o0Tm/EUjJAyEeJqhFG2GVZL4QXQZKr0kRYOe6LfrKw
         wkD5/KkLn7ILJQM+lpBzHIEbDeqVLHXwjPcGCJ24Wx8nk6BaEGHgwT6JBki3SD2+Is3P
         zznl+Vfkpp36DxLkVzigJVLx7B5HqdTOOKXhV5OzpFKGisVj8mjyiSgmKQE6PTI6DAH1
         GEUw==
X-Forwarded-Encrypted: i=1; AJvYcCUIPtf80F3cDW03dpvgUDICKMipLJ321KEfmTWA65yBHdQPNsa99ZytgvdHKjgMZWUE0zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZon+eFEZPifqQZjz/91gpGc3kZDshkSdKsHser/s9QE6Ehwig
	Lp5ugA36x9H/+8YJIuZlxCNjwjbAOuBv0qTpKe1pALZYJFFb791UHB/p/yrKnfGiFe8sqhfbEpC
	eZae3vg==
X-Gm-Gg: ASbGnctb4VE8Ltpi956Zw25ygFpaPKPy4Jv1h9us2AQUzhQ73kYYYyl29t96GgHdl9k
	Mxnj7v4s9bpUVZ7nMCe0QSAroq4wEW8OV9q+1Us0Tj3Sw955W5cHDwwT8ctP2CjC0r9L6tdGJvC
	0QYNoZSbXC5lsVFgAB+Qzq0NUam+Nb8chzzvOeaKD06cTFZDQf3fbXILn6Gm4Ea/i0JLWVzUx9+
	rgi/YDQwxS2TYrdB/W6qzaeqKUq298riXOmWgQ7kZBPCAnianHETPOulMjFBJa+pKONDhvymSYP
	tNu53sB3TpVW5iE6Bsr0/Ji/
X-Google-Smtp-Source: AGHT+IEQlmSeXzwZbCJi6/cG9fM41DOhWOdPKMdfTfX8wU22sR0lXvCuOSPNwYDSXiQ1sa0GtfC/uQ==
X-Received: by 2002:a17:907:8312:b0:a9e:b5d0:4714 with SMTP id a640c23a62f3a-aa509d08a1amr603189066b.21.1732383531082;
        Sat, 23 Nov 2024 09:38:51 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f9e25sm250666966b.78.2024.11.23.09.38.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:38:50 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa20944ce8cso758687266b.0
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2024 09:38:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUnmi2GQxY/ZPJ+ZZ9iGYZdrrlZDcXsUvQYqjOzLg5snZHqSRVnll2aIwZyj0+ruMK9mc=@vger.kernel.org
X-Received: by 2002:a17:907:7853:b0:a9a:17be:fac7 with SMTP id
 a640c23a62f3a-aa509a07836mr857912866b.14.1732383529933; Sat, 23 Nov 2024
 09:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com> <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:38:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
Message-ID: <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Michael Jeanson <mjeanson@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 07:31, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>  include/linux/tracepoint.h | 45 ++++++++++----------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)

Thanks. This looks much more straightforward, and obviously is smaller too.

Side note: I realize I was the one suggesting "scoped_guard()", but
looking at the patch I do think that just unnecessarily added another
level of indentation. Since you already wrote the

    if (cond) {
        ..
    }

part as a block statement, there's no upside to the guard having its
own scoped block, so instead of

    if (cond) { \
        scoped_guard(preempt_notrace)           \
            __DO_TRACE_CALL(name, TP_ARGS(args)); \
    }

this might be simpler as just a plain "guard()" and one less indentation:

    if (cond) { \
        guard(preempt_notrace);           \
        __DO_TRACE_CALL(name, TP_ARGS(args)); \
    }

but by now this is just an unimportant detail.

I think I suggested scoped_guard() mainly because that would then just
make the "{ }" in the if-statement superfluous, but that's such a
random reason that it *really* doesn't matter.

             Linus

