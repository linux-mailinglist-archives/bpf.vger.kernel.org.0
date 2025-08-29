Return-Path: <bpf+bounces-66997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A4B3C0AD
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B14F1C8440D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDA32A3C5;
	Fri, 29 Aug 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RcYN7D1i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84688322C72
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484944; cv=none; b=KHxZUyA2TCux3rbT4nIG48IPOklcXGnv5MLqjBkKo4eM9pHX8Fv2cZa9NT+UVEIk3rXPQNeH+Yq4vDCwO5wsxJRH+PIRxY8X7NtA3DAHycr9QOq8d+YHCqo0mRDmrVaOOUrXiXztyBjnCvzAMwRFfzACMJR0fFeEbVBq/un/+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484944; c=relaxed/simple;
	bh=JAYlCBf5lvQf2RAI2BCV6usuwiQQx3hpU17cVIVxX3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc72sv3X3fWyDi/McfVZqDwSK7PctORl0fPIX+cgQo4zX4Y+qWtDxz2S5VE96iKuWHfF3JNsIHNIXLKORpys9856H9TnWbU8Rlbpv+lMKNCDieNfhJtrOgZx2veot0ohSFPVo/jILErnHZtHtCJRSoK9/jY7dwOskN3UUAMQDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RcYN7D1i; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afede1b3d05so403583466b.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756484941; x=1757089741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhtkB5kKKP+MCd/lsnF5BgjvtsGJ8UuOa5gag5oWTg=;
        b=RcYN7D1iBfnilB2DjUeLN/g3Nf8eQHwC2fqBXBayJDn6oXltykmx/WM4Yqx66pUY4O
         NGkC+lcfpeUdTWY7aQ7UKUlTT3obkR7SAZR5WOi1MZfLVUHDJgrNCRS5L1AIR9zhMYfF
         dz6/rRLS2gPjiGXepEsRR+O1JCsR+QUWsHg4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484941; x=1757089741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayhtkB5kKKP+MCd/lsnF5BgjvtsGJ8UuOa5gag5oWTg=;
        b=JgIrvKtxF3PztRzkxHv+HzEhUOfYtdmC5cYtVYZG4qGjddX2StU9dTGU4HlCq+OiM/
         JZouHoJYlC1cqwzsOdxHFKI84RkD2jcdiR6rYdi++h3anSqYNLrHXA6K+sPNPXikn7wj
         WeNUZCvNIz5RIM6vFE3PIHCdirclhIKruHnocFiozqOgYnDhkdaHjo1rV/e5tluAErvQ
         lFgrlWHfrr1X10VoC7bHSmiGNchjm6dDsrez4YS2dUtMn5DdByTl4gft6VPPNtazEt+y
         cdhwCf0gHfoD+qdjS06ht3Ub7RJS4YQI6G35xXwhIBUMcA6q0w5J9wjZ/qZgq3r2V/Jz
         SlSA==
X-Forwarded-Encrypted: i=1; AJvYcCWYOeTDdKdabtRuNXXBRw1j7L6O9hvvPhhSjltFWF9BDS8TbNfhR1WCTkXX8BR1alZxBHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxazfa5iZWmjt7+cMLdfMQQ2szSz74ZkzrkGR3BtnYx+wCuc1rC
	4caUTk1dwDauMbQJUq9RA0FGqUIWhEl98/WWF7YPCJCyOZ9s7fGjU7tX7WYUplETrme/PRrzCdb
	0SLWFugG39w==
X-Gm-Gg: ASbGncvTq+Ml4g/qaEH0hXxT4AmjlIyyjUpj6/6v45cZjLxxwjWaJ1vB6UR254PekvO
	2NGO2SVhOAdEKLXhddrSzla7hjkTh8mpHwX1Io7RAT1AZwx8Lnn6EPmUr91KDmSipYCosv/eB3a
	JfeLZzxCxvQ1bg6JUBTZnm4VxGh39WemINk6sY7qIFYFKp0Wy0+ZS9m29DV2Z8VKos3TXKn7i22
	TbGxi2NpyGnYzWg4jGtKFlspADr0URPqjY8s6WMqFGKMfNvLnl4kkbeK37AZxePO58TImjsQL+d
	aLcwnlrs8OZCoEeFW3K9sJYla5WNT9DPVHl3+edfp9CtTU827LbFIoce3Aju9VcrqoRyJ6nlpj+
	caFZqBSlnZNgT8eas8Wuz0cXgFivC1S0p76YwPKN2n8Dj2LYrGKUN+Uktl5eDEd4OTDTCwlWc
X-Google-Smtp-Source: AGHT+IH6AzhHY856R28Nuve58R5cTO4d7CCL5DIhptpZliZE3I/KsFGNFIDrKx6i4ZgXlmMz4VPaJg==
X-Received: by 2002:a17:907:1c17:b0:af9:1184:68b3 with SMTP id a640c23a62f3a-afe296358ebmr2906537466b.55.1756484940643;
        Fri, 29 Aug 2025 09:29:00 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca40df5sm230176166b.47.2025.08.29.09.28.58
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:28:59 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78f5df4so393245866b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcHBQOgnpirjlYZzu25ALctPx1Ep+EHR55BbM14jX7Lkj1n5WSOtnclYvQaaNKv77LWUc=@vger.kernel.org
X-Received: by 2002:a17:906:c116:b0:af9:a1e4:a35b with SMTP id
 a640c23a62f3a-afe28f864bamr2310935766b.7.1756484937731; Fri, 29 Aug 2025
 09:28:57 -0700 (PDT)
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
 <20250829121900.0e79673c@gandalf.local.home>
In-Reply-To: <20250829121900.0e79673c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:28:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
X-Gm-Features: Ac12FXzKsn5qgiNoTPpUW92vL8XQH-QBVsXDCKCPAfj3-whVMqZU-D3ENWgGNVI
Message-ID: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Basically what I need is that every time I add a file/hash mapping to the
> hashtable, I really need a callback to know when that file goes away. And
> then I can remove it from the hash table, so that the next time that hash is
> added, it will trigger another "print the file associated with this hash".

That works, but why would you care?

Why don't you just register the hash value and NOT CARE.

Leave it all to later when the trace gets analyzed.

Leave it be. The normal situation is presumably going to be that
millions of stack traces will be generated, and nobody will even look
at them.

> My question now is, is there a callback that can be registered by the
> file_cache to know when the vma or the file change?

No. And what's the point? I just told you that unmap doesn't matter.
All that matters is mmap.

Don't try to "reuse" hashes. Just treat them as opaque numbers.

             Linus

