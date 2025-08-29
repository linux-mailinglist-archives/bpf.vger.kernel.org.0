Return-Path: <bpf+bounces-67039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596DBB3C404
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 23:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB773A6A6A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70532367B8;
	Fri, 29 Aug 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DDGmJP1g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E311EEA49
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501253; cv=none; b=hDeo5OYu/LYcuRRlyBGHOA0PQJn+SwpAfm+auDTJqz7t1WD0GWWISlma8rwoQaMaPcGFTAjP/w+4o1rmafWCN0iHYofw0oyGhCcLNipZLRywoxdULhHV/VvpgpFpKWRfxx7rv/7DBll6/+SlNxzYgIPoi3L+J7R1snGrWq1I7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501253; c=relaxed/simple;
	bh=lm0u26OhekurXvbZmRAMXY3a04c03Jb12UfPOAKe1Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+KKM/NTw2DouLbwLUd3N3/GXOtJbh2aIRvrqr4zdxqewygfQ9fVeV/Pwng46Nj6LgWv7ZHZ6KqC3M+4qNkcpYkzPsDbnLQ9oN2/8CRl8i9g6CTizhxI3fDiMFUMnjUSVdJPTSh4Bcp/eHG1dG7rCT4j/k0BgF5inENbLHZQsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DDGmJP1g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f687fd3bdso1526809e87.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756501249; x=1757106049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtxiUTojkJryuwfS4utzOx7v5IFRnxmAU2q8IplphGo=;
        b=DDGmJP1gFORGbExUfJqCtJfYkVAsSWFcsC31Cm39uIPQaopOu3wlEfvEwYq9LL2uBX
         dDKTmQrN5tX7KpsjY1FfqW8UPZm0SbE7EgoYbeZ23iKHjvctaJDrb3de+oSuucRCCS08
         76EIc3kxAdLr46s+OLa/MuUHUOQYVEflSWe/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756501249; x=1757106049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtxiUTojkJryuwfS4utzOx7v5IFRnxmAU2q8IplphGo=;
        b=j6GLEzBuS1XdrgT0VzhDOoB0hZFaXIxBDPkVbq5Yl2/yAmgeMFn54HJLyYjF1RINxF
         lCuliHrFVnY7bnJxX5bGUwv2f1Km6bUD5cAOgtRpAG7B8zjEjXbNA1LQK8YN5iQ6qRu9
         iSxgwGSnfdGe6mQb6JRVLQ99AkrPumr10AEI+pSxOdwYP7lm+AyVDuNC5NeM1FEDKMRN
         TeTvOdFiauo8IZtIsRiMq/APRacv+n29T34WZdEt0t7vSuL8uKuZnfUZpN49FpTmT4SU
         hm4Bg+jxbbB3i4lcHt4D7kRq9XFry3wCsNGlRP4rNIuYa+pYECaMZQDEqw7CyeGML8vL
         vVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFk92+ejItTZVTt6QyZhHKo3F9thF16venoMlay0Ase3r9vzI9A8ZbgPEEhmzFvJcgt/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSu/BAmudmJMjYvKu/mfpz6CPbzh+i6JztGeLh2O7v6LkrfsVH
	/c5c8qwGTr4Na4p7nFdne+TIWxKX9ohuwazL4AiEmeCPb6CMCQyN+z0o53nvgFwP9MjIybAD45A
	gJ31HJwQ4kQ==
X-Gm-Gg: ASbGncuHXpTZBJ1BR33kHdQ/ztdpFDHiv18SAvgXDvQZvJHNsPkaWvsreUjWsnzM5vi
	rdMeSH/3NfeOKT1VWB/gp2XNXUJJmCEcjF0ZdJkCxSF1tqp9kx5cA9avjwPOsiDQQ1UhY/yNvh4
	h2ksTrJipNMMLslQaeSQxLPpDLiaBPoPUqQM4m75lz/y1FXAn8g7YaiWbc/PXYtD4MUlmzj/8Gb
	s5uXHHxJ2bHfn3MbduLrSD6E+jEuF3Zn7huQzJj8K22Tl2dIELu2w764sZszJn6UhaKNXsG4JqB
	zerJYB7szqkIV52fjPxNbAc6RiFdDQ78SHfutuDog640owbasIq3qrk5WAlwJPYek1W/H7o8tpb
	kwRbUsASFIAkcVLkLgNA/lyOwjUp3zECx9zhWO+qlecjZupeSO7fDv0J7NCADcQbykNvOaDMP3g
	P7/4js+DQ=
X-Google-Smtp-Source: AGHT+IGqaa40zfwg+IddeU3MCRp4WszQ5CFPzxQr9jO6uXjhE7KNlOwepyTDFkEqFLb/oWUOIU7ZjQ==
X-Received: by 2002:a05:6512:4409:b0:55f:4746:61d6 with SMTP id 2adb3069b0e04-55f708b6c18mr4721e87.16.1756501248991;
        Fri, 29 Aug 2025 14:00:48 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a4056csm898277e87.121.2025.08.29.14.00.47
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 14:00:48 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f687fd3bdso1526769e87.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 14:00:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpui3Jy0o3s661cxibu36Ja1xtPFD3tug1UFOllR+P/qdrdZM2uycijR7L4aa3afPsofk=@vger.kernel.org
X-Received: by 2002:a17:907:804:b0:afe:ed3c:1f9a with SMTP id
 a640c23a62f3a-afeed3c33a9mr669079266b.38.1756500864690; Fri, 29 Aug 2025
 13:54:24 -0700 (PDT)
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
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home>
In-Reply-To: <20250829141142.3ffc8111@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 13:54:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
X-Gm-Features: Ac12FXxq3CT2Pra5MUu2kfheMZZZIqxJ8O9KYQ-_o6FJemvdl2_01eUe7c4e2AQ
Message-ID: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 11:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The idea is this (pseudo code):
>
>  user_stack_trace() {
>    foreach vma in each stack frame:
>        key = hash(vma->vm_file);
>        if (!lookup(key)) {
>            trace_file_map(key, generate_path(vma), generate_buildid(vma));
>            add_into_hash(key);
>        }
>    }

I see *zero* advantage to this. It's only doing stupid things that
cost extra, and only because you don't want to do the smart thing that
I've explained extensively that has *NONE* of these overheads.

Just do the parsing at parse time. End of story.

Or don't do this at all. Justy forget the whole thing entirely. Throw
the patch that started this all away, and just DON'T DO THIS.

              Linus

