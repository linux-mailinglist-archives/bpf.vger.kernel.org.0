Return-Path: <bpf+bounces-48429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E22A07FBF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F477A2944
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE319CD1B;
	Thu,  9 Jan 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QkzusyPU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723C198A37
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447069; cv=none; b=cExnk8USavgjfzy3CrFdyNHP61RhkR4KUzV7CLBJJwlDvXNA7V4T2sxcAzel6CKswauDxaWe7x70a6j1Yp4xnBmjAF0EvSfaGr/ZiMMhluxEsCwbUrHUj1klQWnme/rte1oGJwMl62DnWeDrp2t+F6DPz/OJUWjhyLybgV+/T9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447069; c=relaxed/simple;
	bh=+vLgqIeCzolaIxQPxdz01oEdjsD8WPzfx1aPdgzHvxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyNCk21BH+ES/uKP8GnD+0es+ZTcn/yhKeDneMWtpek91ByHPhOXXU32wVICcgzn3Yf4aCUPPQjjsKfuuoT+RyYQNcSu5jmk1P8SKl/hiMA4+pzVK66c3t+olFX3UvJl9SXN+65FIL+ZbHxwbgLGIQEBDYACu/+jiXiH5DiirfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QkzusyPU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec111762bso248538866b.2
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736447064; x=1737051864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cUcTIvdqWsHncGSnTDzqP6lVvkAKHUvwz4H9h8Ij3CM=;
        b=QkzusyPULuNegBalTYmpY9eiFWfLn029zhUixhXSTBT+PJEvI+LztM3O6IbJygvl0t
         m9SVvfOweTeQxBhL9w1t9d1upMUNi7Fw6nmdVyLfc7Q9JF623GXqzU2VS1fO/NdcRwsG
         a8do5BGv7dxvHEmlsgV8zzgV8VSxremCeRojA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447064; x=1737051864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUcTIvdqWsHncGSnTDzqP6lVvkAKHUvwz4H9h8Ij3CM=;
        b=X1p9BdpFg42t1SM1OYbqC/NsP9HlNlq+v6/425y1/it3LhEPqBwy61e/coKSYxvny4
         LSX+wnyOxKoMdLXiO6WP4k6EknRvAwbJqybNrrlNCbJrihvG7WHVbsesjkxyJ7KE0ylj
         xdAQbxCko7kgkrOQzDVUKUF5lRuG69cmMdNTbCLy4wLcYdFKnslxW8CUbyrdvb6ciIWZ
         ObzlJPE5u+yKkBuGbh4/MTiX3wQjBdckx9EZscAjLgDwDDtyoxw4PTIXvS7xZVFgxePM
         sD0t+dE6tIr4Oc+8YtSrw7Aj5nztvkJT9vge1GWADs+XHLhQEmqd3Qsr/ep/AsNAecor
         LpPA==
X-Forwarded-Encrypted: i=1; AJvYcCVhH4kJSUaamdpV2KtX//yl2q/2YTDWYHuhcd2Hnx3J8rpGAIgFXi6XQNsgMeXBV/B0fMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkGyNbrMcpnZQrH5NElKylsBHJmoBkLwFHIiOnXoSxYF7477O
	q91EhjdoZ0AJoP4C4LC/X/+HkFuFLlffqInfkqTyiuZypG4aMj/h46nfXuxjAPyTFlcX0D6i0kO
	kmsY=
X-Gm-Gg: ASbGncuSyI2itgkdLdnpTZvuH+3Z3ZXxjssYiUHB+Sd2uKWV6uGHsYyEA3zqOV3Q8+0
	ywOyZDc0NmU9yXUjHLNFYWbNbICA+wRZuXXZ66s6rNTh5LPPA69GBjT+9H1CwIzDcrnFyUjDmKw
	zLRtE38trCNzhbMxi6kKemmCt3pNRma/7x2vrrkIDkdbjI+PhQHZaE3KW29oDXh2M8oPgqBMbxx
	ll5cVcf7baxDg+jHM4GYkWeXg6yOtTYpQwD/zQlCS0iympflj8X5bJPQFMAWW6lzFYU2+n0xNjm
	oxZ3/U0hJaxOnQ9hJEdF9Y3YGaQcBPI=
X-Google-Smtp-Source: AGHT+IEIQ4XcvgbISZSKJj8BS3N0MJ5/vfEw5mfppBJAVN6XtS9qXprPOEDU65QPQu0kDm5s9AqHog==
X-Received: by 2002:a17:907:3f26:b0:ab2:da92:d0bc with SMTP id a640c23a62f3a-ab2da92d9cemr57781366b.3.1736447063991;
        Thu, 09 Jan 2025 10:24:23 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c913628csm93926466b.86.2025.01.09.10.24.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 10:24:22 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso2184793a12.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 10:24:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZOuL5MVb+H4k+1AQ55cK6IXpN8WgkvmbMGUcTj3ggAQkr9mngtmfEXTPHezXhST+BCdo=@vger.kernel.org
X-Received: by 2002:a17:907:9691:b0:aaf:ab71:67b6 with SMTP id
 a640c23a62f3a-ab2ab73c487mr689359966b.31.1736447061714; Thu, 09 Jan 2025
 10:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107223217.6f7f96a5@gandalf.local.home>
In-Reply-To: <20250107223217.6f7f96a5@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jan 2025 10:24:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com>
X-Gm-Features: AbW1kvYdQlWHwGkmwwAN8JZw7YnlZKyVkSwXwOwVP1gd8FGuLMeyZPa3VRecA5o
Message-ID: <CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/sorttable: Move code from sorttable.h into sorttable.c
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 19:30, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +
> +static int (*compare_extable)(const void *a, const void *b);
> +static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
> +static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
...

Side note - and independently of the pure code movement - wouldn't it
be nice to just make this a structure of function pointers, and then
instead of this:

>         case ELFCLASS32:
> +               compare_extable         = compare_extable_32;
> +               ehdr_shoff              = ehdr32_shoff;
> +               ehdr_shentsize          = ehdr32_shentsize;
> +               ehdr_shstrndx           = ehdr32_shstrndx;
> +               ehdr_shnum              = ehdr32_shnum;
...

>         case ELFCLASS64:
> -               {
> +               compare_extable         = compare_extable_64;
> +               ehdr_shoff              = ehdr64_shoff;
> +               ehdr_shentsize          = ehdr64_shentsize;
> +               ehdr_shstrndx           = ehdr64_shstrndx;
> +               ehdr_shnum              = ehdr64_shnum;
...

just pick one of two static structure pointers with these things.

            Linus

