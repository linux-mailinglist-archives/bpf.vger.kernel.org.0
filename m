Return-Path: <bpf+bounces-14726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A37E791B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE312817D5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5027567B;
	Fri, 10 Nov 2023 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guQsjUED"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECA538F
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:18:10 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921DE5FEA
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:18:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so2625259a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597085; x=1700201885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGbypyb8n0gS409f13j5BgZ7GQFunkz77+JA8kIAk0Y=;
        b=guQsjUED/jLQM/6USk5HFgxDEQTwh0ddx0iksKPbO0nZH18/Sh3ARrnBNFkPMAXELo
         N7Qty+ZNbXTE727X/Hr9QoZc9VJFvLKear6yzYUZefYz1Ey5CTl9GlxHB3xHnWIJfYuh
         1naMQDxKKpVRKPpRBGGvAGytu5N7g+VkKbxGZOCRTiHj+SvHk5v5IWgc59+/GQduN7wL
         PhHkekOQV0wbbt6hZgnT4Wxt9tGaZNQZhWk3BZgVG2MSgVOEtt7cJaL1y7nwnJFDTGxA
         qmqfx+eYjCQb1IgZFSMjxXw6Hq44baMIqnwurv5inBM/syaVAywWACc0FpVvFM2gp2Jl
         XR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597085; x=1700201885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGbypyb8n0gS409f13j5BgZ7GQFunkz77+JA8kIAk0Y=;
        b=NiGftRrGW3+uxcNpIbRPVSX0bw2/1sD19LOD2PrlZ/anER0OZ9PrXzwznxVT19mM3o
         tL7r5tXxLWvvw38otbESg1ghyJsX9cx/te8YMInIeg4tThDok4TdKlA7oJs15zQD7BFn
         UDvDr9IJLK9Xkjeo0Coj84OG2/h6e1MRwmTYUZbzvvjYBDCgPkdPE293iOsq0WpdabT3
         /IgRJUNsJRVA9vWBzbdjUfH/rIRJ/YZeBcaCfGcFz8opuqV5JAFl59KH5BqS0BCib7rQ
         qBZegkAfkYhxMo7YxUil36V+SxqBLLt+UeQGFdDdWvdMPDYt9vYFXwUgQFvcz6DKkwD7
         A+iw==
X-Gm-Message-State: AOJu0YyIK1OyqruFHK15LyDNOg3lr4QEsTWq0Y1hYD39Tg0yMZjqI/vm
	W9D5sqvQzahlTPj0IaOFnnsGn3R4Mzr7mjz6or+hLbquyw4=
X-Google-Smtp-Source: AGHT+IGYNO1ON1819pk3I9vNGZhwVaZytkEeditW+uthYwA3acJx4YNrAgTTqSwc+5Hle1mBjpPtuvR6SZ15MeutLck=
X-Received: by 2002:a17:907:3e1c:b0:9b2:d554:da0e with SMTP id
 hp28-20020a1709073e1c00b009b2d554da0emr6757187ejc.69.1699595348321; Thu, 09
 Nov 2023 21:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-3-andrii@kernel.org>
 <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
 <CAEf4BzbC9=6haCwQ7U5qzt9=zKTTTYxsh3s74hBBVxwNWPPx3w@mail.gmail.com> <df3cb08a39fb2646ce14c8398ace0507bb6e1258.camel@gmail.com>
In-Reply-To: <df3cb08a39fb2646ce14c8398ace0507bb6e1258.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:48:56 -0800
Message-ID: <CAEf4BzYF7m6H6hcT6QnPFoMH9tXiqR4w1CM0jmkPG4X4DBhxEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Tao Lyu <tao.lyu@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 10:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-11-09 at 09:20 -0800, Andrii Nakryiko wrote:
> [...]
> > > >  struct bpf_insn_hist_entry {
> > > > -     u32 prev_idx;
> > > >       u32 idx;
> > > > +     /* insn idx can't be bigger than 1 million */
> > > > +     u32 prev_idx : 22;
> > > > +     /* special flags, e.g., whether insn is doing register stack =
spill/load */
> > > > +     u32 flags : 10;
> > > >  };
> > >
> > > Nitpick: maybe use separate bit-fields for frameno and spi instead of
> > >          flags? Or add dedicated accessor functions?
> >
> > I wanted to keep it very uniform so that push_insn_history() doesn't
> > know about all such details. It just has "flags". We might use these
> > flags for some other use cases, though if we run out of bits we'll
> > probably just expand bpf_insn_hist_entry and refactor existing code
> > anyways. So, basically, I didn't want to over-engineer this bit too
> > much :)
>
> Well, maybe hide "(hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK"
> behind an accessor?

I'll add a single line helper function just to not be PITA, but I
don't think it's worth it. There are two places we do this, one next
to the other within the same function. This helper is just going to
add mental overhead and won't really help us with anything.

>
> [...]
>
> > > > +static int push_insn_history(struct bpf_verifier_env *env, struct =
bpf_verifier_state *cur,
> > > > +                          int insn_flags)
> > > >  {
> > > >       struct bpf_insn_hist_entry *p;
> > > >       size_t alloc_size;
> > > >
> > > > -     if (!is_jmp_point(env, env->insn_idx))
> > > > +     /* combine instruction flags if we already recorded this inst=
ruction */
> > > > +     if (cur->insn_hist_end > cur->insn_hist_start &&
> > > > +         (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
> > > > +         p->idx =3D=3D env->insn_idx &&
> > > > +         p->prev_idx =3D=3D env->prev_insn_idx) {
> > > > +             p->flags |=3D insn_flags;
> > >
> > > Nitpick: maybe add an assert to check that frameno/spi are not or'ed?
> >
> > ok, something like
> >
> > WARN_ON_ONCE(p->flags & (INSN_F_STACK_ACCESS | INSN_F_FRAMENOMASK |
> > (INSN_F_SPI_MASK << INSN_F_SPI_SHIFT)));
> >
> > ?
>
> Something like this, yes.
>

I added it, and I hate it. It's just a visual noise. Feels too
paranoid, I'll probably drop it.

> [...]
>
> > > > @@ -4713,9 +4711,12 @@ static int check_stack_write_fixed_off(struc=
t bpf_verifier_env *env,
> > > >
> > > >               /* Mark slots affected by this stack write. */
> > > >               for (i =3D 0; i < size; i++)
> > > > -                     state->stack[spi].slot_type[(slot - i) % BPF_=
REG_SIZE] =3D
> > > > -                             type;
> > > > +                     state->stack[spi].slot_type[(slot - i) % BPF_=
REG_SIZE] =3D type;
> > > > +             insn_flags =3D 0; /* not a register spill */
> > > >       }
> > > > +
> > > > +     if (insn_flags)
> > > > +             return push_insn_history(env, env->cur_state, insn_fl=
ags);
> > >
> > > Maybe add a check that insn is BPF_ST or BPF_STX here?
> > > Only these cases are supported by backtrack_insn() while
> > > check_mem_access() is called from multiple places.
> >
> > seems like a wrong place to enforce that check_stack_write_fixed_off()
> > is called only for those instructions?
>
> check_stack_write_fixed_off() is called from check_stack_write() which
> is called from check_mem_access() which might trigger
> check_stack_write_fixed_off() when called with BPF_WRITE flag and
> pointer to stack as an argument.
> This happens for ST, STX but also in check_helper_call(),
> process_iter_arg() (maybe other places).
> Speaking of which, should this be handled in backtrack_insn()?

Note that we set insn_flags only for cases where we do an actual
register spill (save_register_state calls for non-fake registers). If
register spill is possible from a helper call somehow, we'll be in
much bigger trouble elsewhere.

>
> > [...]
> >
> > trimming is good
>
> Sigh... sorry, really tried to trim everything today.

