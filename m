Return-Path: <bpf+bounces-54900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9AA75C30
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4121C188AAE1
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455491DE4FF;
	Sun, 30 Mar 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1y6AKiR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7241DE2C2
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743367375; cv=none; b=CPVlH+J9xoHD/0Nd+uJ/bhP0K4nJFXbN8kNvVgWbH4GZ76A871hzc3fM7JJz/J2tM9knvbkvQ02QWNJC/RDsPxIBXdNy9l2Wwa2NjTN8viuGl1OeVhbIJHRZqQdMtUBlcGYdcR1Qq1tLlXFJGlxzo3rlXMhifSPul8B0aca5DT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743367375; c=relaxed/simple;
	bh=ehWKatrLmUvmecRB4zhJ43uwF2+JtIX0Y9h6WFT8VcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKRHpDzGGbKaXkU0QKBg7w0aQNNkHO7/I5EMfv1oEQgO2OlO3LIkeGZL/asmuquoeOda36w+L3nkTkewcCxHZuqWkCFwja/jrsCtMAMgvqraP0RBzr1HcUoke6MDCRe+j1cV0gzeIYc71HJ5Iadjsw/DKVpkxJEb3awWI1Ei6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1y6AKiR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbd96bef64so624457566b.3
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743367372; x=1743972172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9bbo4m0YKczHWopSRDS1sLs4WUH12+PaT6dXT6fcFw=;
        b=N1y6AKiRMnHOEd26dy+GSG0LmIdsw7xCws1G/uOLuV4dVbldda7wKdPlovleOSgfwK
         znIpyXTHbj0aL6VzeifUQuUVO1VJIE5p2xErCD+Nt83cp5V4+JRSObRLPkcfwMLNNvDx
         tlNuwmVIXtdTgYFYqhl1azlMT54sQVd8abWiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743367372; x=1743972172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9bbo4m0YKczHWopSRDS1sLs4WUH12+PaT6dXT6fcFw=;
        b=FSs1Z6FG8PhEX0rfMt0Utk8ieXv2pvVyQR4U6mOIZ1fMjZm55NQyYyRCmln5G+BQSi
         roeI8DDnZcWJFBEt/Um/J9I46k7+e1tj9FK+57aifiNoTCBeIX/Vz/ZWWca0FnD4l79j
         l/5RXnwwVH0uksyRDSxiHaT7oakzyHDF9E9IJWIzjxRy8NBNrCwdA5ukzCvY7vrddaH4
         HUf+S0J8pwFGrKcVTw5aoL6+jo/RKmlfGqWCNUvukPx1h2IhFAUglgN3nmzKCwnHc4rk
         acDE3zD8oWGmZUKqzboLHLPYKjEPHJGWsS8/P/zciq8ssoDQnkd0iSb4qzk2XxJXsA2W
         uvUg==
X-Gm-Message-State: AOJu0Yy9dLAj7fjA6ftANHWC00auoltk4AHuVtxZOE6Ulsv/fKodRojl
	3y1wvfur0QRkuD8yH+IcsaD2Hk7QTYlr/aisTxWfGCOAswsmUQnaOQTkA+57mcGaWNwYOmwhkcB
	3gE4=
X-Gm-Gg: ASbGncvuJOyd5osoBoQNIgjUoi1d4c+IoPADE5VALAulIqJ+yJt07sgDR/8XTCWWrZo
	r2+ILEmISSNqjCQT32thpdDVHqhrreAXJVtwhOWhf6VgsTyehNE83K7AK+tn4cBEynsH/h8QNUH
	05uCbL/hCEYtTI+2bvsQdEZBmBRWTLykTvJIFEQ/h/CTfb3sMKSOuzA3SdWoze95JfW0uJl0LMm
	TJTQNv+OCbhJDdgCv4XoSNKOzK9IPnCiv3vBZ9IU6h6LaexsdirGutzNjEqWC5UHNmD9kZnWPOr
	MnATOWkVaHN/MTigHZggol7tCudtVoI4risiZN/g03VLMoR6dtBTwaCNw6xr99ph98MdY0nW64X
	n47r+0thZd30EN28fI9w=
X-Google-Smtp-Source: AGHT+IFn6SaNZM4kTGIS+V+wMS92EnLDSbAfhxOFLmE71WjUaBAe6j6D/wmScckBkZ+2Or5N7e6F6g==
X-Received: by 2002:a17:906:7955:b0:ac3:bf36:80eb with SMTP id a640c23a62f3a-ac738bf2293mr689384866b.48.1743367371816;
        Sun, 30 Mar 2025 13:42:51 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961be06sm525851366b.109.2025.03.30.13.42.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 13:42:50 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3b12e8518so738801966b.0
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 13:42:50 -0700 (PDT)
X-Received: by 2002:a17:906:d553:b0:abf:6264:a624 with SMTP id
 a640c23a62f3a-ac738a8ea3amr567488066b.32.1743367370064; Sun, 30 Mar 2025
 13:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Mar 2025 13:42:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
X-Gm-Features: AQ5f1Jo5PmHauyYbc5x0xsHSrONdOA84_jiW0Ke6tVTWo1pXzyKY5d-PBNExuF0
Message-ID: <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, akpm@linux-foundation.org, peterz@infradead.org, 
	vbabka@suse.cz, bigeasy@linutronix.de, rostedt@goodmis.org, mhocko@suse.com, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 07:52, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The pull includes work from Sebastian, Vlastimil and myself
> with a lot of help from Michal and Shakeel.
> This is a first step towards making kmalloc reentrant to get rid
> of slab wrappers: bpf_mem_alloc, kretprobe's objpool, etc.
> These patches make page allocator safe from any context.

So I've pulled this too, since it looked generally fine.

The one reaction I had is that when you basically change

        spin_lock_irqsave(&zone->lock, flags);

into

        if (!spin_trylock_irqsave(&zone->lock, flags)) {
                if (unlikely(alloc_flags & ALLOC_TRYLOCK))
                        return NULL;
                spin_lock_irqsave(&zone->lock, flags);
        }

we've seen bad cache behavior for this kind of pattern in other
situations: if the "try" fails, the subsequent "do the lock for real"
case now does the wrong thing, in that it will immediately try again
even if it's almost certainly just going to fail - causing extra write
cache accesses.

So typically, in places that can see contention, it's better to either do

 (a) trylock followed by a slowpath that takes the fact that it was
locked into account and does a read-only loop until it sees otherwise

     This is, for example, what the mutex code does with that
__mutex_trylock() -> mutex_optimistic_spin() pattern, but our
spinlocks end up doing similar things (ie "trylock" followed by
"release irq and do the 'relax loop' thing).

or

 (b) do the trylock and lock separately, ie

        if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
                if (!spin_trylock_irqsave(&zone->lock, flags))
                        return NULL;
        } else
                spin_lock_irqsave(&zone->lock, flags);

so that you don't end up doing two cache accesses for ownership that
can cause extra bouncing.

I'm not sure this matters at all in the allocation path - contention
may simply not be enough of an issue, and the trylock is purely about
"unlikely NMI worries", but I do worry that you might have made the
normal case slower.

It's easily fixable later if it ends up being the case, so I don't
worry too much about it, but I did want to mention it since going
through the code made me react to it.

                Linus

