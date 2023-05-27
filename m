Return-Path: <bpf+bounces-1344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F067130C9
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 02:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E57F281984
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6417D9;
	Sat, 27 May 2023 00:03:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2847E
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 00:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF89C433D2;
	Sat, 27 May 2023 00:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685145812;
	bh=iu9+NFhbI0BAPXcc+Uw6qHUPhwcZ6dpVVB3MfirmE+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kVAGhggnXBaor8aBGW62jkO9bEkKP1Im7yJffXqEHovO01b/EDeTltwQQSB+dy9gG
	 Oz9P0nYqRQS6ALZTEifhu6TahCzmY+DkxfZQ2HBcAaiKAiUBl8eJHhFkVb43YIRQ/B
	 9ZvWu99tezMUlBcbyAOxzq2r4GNnZtwOomisb3S4qUKRsoFsmGBuY5JSA/JZ41FeeL
	 0+3+75aZBYNBgO1VDo0TiA7FiU2I422vT1TG+JuXVJ7CgqPr4iKmUhd0uHzzuVw7SD
	 O22pC4OuDjHwVQu3XbfF+yu69bCi+z011p5NM0tAq4ltWUO+9Jepq4vKE++kQscXJt
	 xzZa7tH57QlnQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f3b9755961so1418986e87.0;
        Fri, 26 May 2023 17:03:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDyfLwVWdAlQWXI2mZ20gFmwt36NJdI7J1cqaXoHNm21Xi36uH+W
	96Zzoj8SSJoufQI1EuYLIWs5nxl1fyw8fBScnxg=
X-Google-Smtp-Source: ACHHUZ46/GJKliuFs7r1O59ubHTKy8wEb5XGrFtaDNO8sRYxzXsH5yGKzEdx3V8HQuG9pjPzRF+4qQ9duzAIp5k8xnQ=
X-Received: by 2002:ac2:5e87:0:b0:4ef:d3f3:c421 with SMTP id
 b7-20020ac25e87000000b004efd3f3c421mr1067658lfq.4.1685145810185; Fri, 26 May
 2023 17:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <20230526051529.3387103-2-song@kernel.org>
 <ZHEy5SkFwI+dZjOC@moria.home.lan> <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
 <ZHFDO/95KMXRdOWI@moria.home.lan>
In-Reply-To: <ZHFDO/95KMXRdOWI@moria.home.lan>
From: Song Liu <song@kernel.org>
Date: Fri, 26 May 2023 17:03:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5CTANR_B57w5n3HvdDjvHXOCSGTDc=a4s+JR0pKCAOcw@mail.gmail.com>
Message-ID: <CAPhsuW5CTANR_B57w5n3HvdDjvHXOCSGTDc=a4s+JR0pKCAOcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 4:39=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
[...]

>
> But it should be an internal implementation detail, I don't think we
> want the external interface tied to vmalloc -
>
> > These two APIs allow the core code work with all archs. They won't brea=
k
> > sub-page allocations. (not all archs will have sub-page allocations)
>
> So yes, text_poke() doesn't work on all architectures, and we need a
> fallback.
>
> But if the fallback needs to go the unprotect/protect route, I think we
> need to put that in the helper, and not expose it. Part of what people
> are wanting is to limit or eliminate pages that are RWX, so we
> definitely shouldn't be creating new interfaces to flipping page
> permissions: that should be pushed down to as low a level as possible.
>
> E.g., with my jitalloc_update(), a more complete version would look like
>
> void jitalloc_update(void *dst, void *src, size_t len)
> {
>         if (text_poke_available) {
>                 text_poke(...);
>         } else {
>                 unprotect();
>                 memcpy();
>                 protect();
>         }
> }

I think this doesn't work for sub page allocation?

>
> See? We provide a simpler, safer interface, and this also lets us handle
> multiple threads racing to update/flip permissions on the same page in a
> single place (e.g. with sticking a lock somewhere in the jitalloc
> structures).
[...]
>
> This must have been part of the previous discussion since you started
> with execmem_alloc(), but I did scan through that and I'm still not
> seeing the justification for why this needs to handle non-text
> allocations.
>
> If I had to hazard a guess it would be because of tglx wanting to solve
> tlb fragmentation for modules, but to me that doesn't sound like a good
> enough reason and it looks like we're ending up with a messy "try to be
> all things to all people" interface as a result :/
>
> Do we _really_ need that?
>
> Mike was just saying at LSF that direct map fragmentation turned out to
> be a non issue for performance for non-text, so maybe we don't.

At the end of all this, we will have modules running from huge pages, data
and text. It will give significant performance benefit when some key driver
cannot be compiled into the kernel.

>
> Also - module_memory_fill_type(), module_memory_invalidate_type() - I
> know these are for BPF, but could you explain why we need them in the
> external interface here? Could they perhaps be small helpers in the bpf
> code that use something like jitalloc_update()?

These are used by all users, not just BPF. 1/3 uses them in
kernel/module/main.c. I didn't use them in 3/3 as it is arch code, but I ca=
n
use them instead of text_poke_* (and that is probably better code style).
As I am writing the email, I think I should use it in ftrace.c (2/3) to avo=
id
the __weak function.

>
> > OTOH, jit_alloc (as-is) solves a subset of the problem (only the text).
> > We can probably use it (with some updates) instead of the vmap_area
> > based allocator. But I guess we need to align the direction first.
>
> Let's see if we can get tglx to chime in again, since he was pretty
> vocal in the last discussion.
>
> It's also good practice to try to summarize all the relevant "whys" from
> the discussion that went into a feature and put that in at least the
> commit message - or even better, header file comments.
>
> Also, organization: the module code is a huge mess, let's _please_ do
> split this out and think about organization a bit more, not add to the
> mess :)

I don't really think module code is very messy at the moment. If
necessary, we can put module_alloc_type related code in a
separate file.

Thanks,
Song

