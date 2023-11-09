Return-Path: <bpf+bounces-14617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526797E714C
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DEEB20D10
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F0341BF;
	Thu,  9 Nov 2023 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2/sFmiW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DB32C9A
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:20:10 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3BB3ABF
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:20:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9be02fcf268so188039366b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699554008; x=1700158808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MyJv0VMQuKvqKxipMEv0LbQieQbqkozkl6o9kCUjTO8=;
        b=U2/sFmiW+GUBom5Sd64TAf/SGUSX5L8RWid1HZuNgiajOnu9lBnWkauoTEf5bPF0VS
         5b9nzbxmFTTTWwg243Ps+cbwSpIjCplnD3lpduYvGlrD27tF7Qg5Y1d2Wsz4MDlYk0hk
         +woXFTiQlcvo60WsuLINACqWAZR7zODwxV1doGGXgGWWZ9tS5Jw2nffXZT5/BUzniSq7
         LhDGq3Sfp7cEOdyGYsIWz2oSoQ2wCdNGbh0s8voEu99FHYiuYNvIrdBwzxy0gRXTCR3U
         L14uZ4R9ZqiZB2yp0Xhscqx7Bm6BnztLysmTiL1YP51XPydf5BoP4wwOf4ggePusVCJJ
         v3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554008; x=1700158808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyJv0VMQuKvqKxipMEv0LbQieQbqkozkl6o9kCUjTO8=;
        b=BSqFxr51r+j6qy9TiKimZ6eyV4WGD5lkpxdxdVgqCXRc/9THOGopoNF49bwBnDTHxj
         kwyUxD4QlVaeIzXK+ditoORmh1GaEcURH+Dmj2r9UWk/ZBtvhpfI4JKjV8Z+hM7P5tZt
         CGIArs6YDnedvJgZ2AlEfreIy44I7lt0ig//imjGFDM3EZweG4RSZJ1XSjSK313pyTmU
         bwfJIFJFNI4ukYHauj6tcYwkRIlC6sY8FSisr1pAWMzjT5E99tyoN+UY1NvBWFYNpvjR
         LqDY4fid9dMWGkz6OdHfP0LhEbpECHWDWJJd1o8PsOuZdwVFaTmIzGMDCM+n1FzgVC9W
         YImA==
X-Gm-Message-State: AOJu0YxAwt8p2qFzO10QKeOwj8urjcLLxmFEKtEmNMwW7cxULn8+JeHQ
	HkmqNzdkNXpkLtmtuhNCNf4=
X-Google-Smtp-Source: AGHT+IEW4V49TtgLkoEXEB7uUDxEFR6uQELwtlGflT0FqWii4SOLWMnqGEFWx9dskJiDzOiWLgUpUQ==
X-Received: by 2002:a17:906:e097:b0:9e5:cef:6ff with SMTP id gh23-20020a170906e09700b009e50cef06ffmr602058ejb.33.1699554007558;
        Thu, 09 Nov 2023 10:20:07 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fp2-20020a1709069e0200b009e5ded7d090sm62370ejc.97.2023.11.09.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:20:06 -0800 (PST)
Message-ID: <df3cb08a39fb2646ce14c8398ace0507bb6e1258.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Tao Lyu <tao.lyu@epfl.ch>
Date: Thu, 09 Nov 2023 20:20:05 +0200
In-Reply-To: <CAEf4BzbC9=6haCwQ7U5qzt9=zKTTTYxsh3s74hBBVxwNWPPx3w@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-3-andrii@kernel.org>
	 <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
	 <CAEf4BzbC9=6haCwQ7U5qzt9=zKTTTYxsh3s74hBBVxwNWPPx3w@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 09:20 -0800, Andrii Nakryiko wrote:
[...]
> > >  struct bpf_insn_hist_entry {
> > > -     u32 prev_idx;
> > >       u32 idx;
> > > +     /* insn idx can't be bigger than 1 million */
> > > +     u32 prev_idx : 22;
> > > +     /* special flags, e.g., whether insn is doing register stack sp=
ill/load */
> > > +     u32 flags : 10;
> > >  };
> >=20
> > Nitpick: maybe use separate bit-fields for frameno and spi instead of
> >          flags? Or add dedicated accessor functions?
>=20
> I wanted to keep it very uniform so that push_insn_history() doesn't
> know about all such details. It just has "flags". We might use these
> flags for some other use cases, though if we run out of bits we'll
> probably just expand bpf_insn_hist_entry and refactor existing code
> anyways. So, basically, I didn't want to over-engineer this bit too
> much :)

Well, maybe hide "(hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK"
behind an accessor?

[...]

> > > +static int push_insn_history(struct bpf_verifier_env *env, struct bp=
f_verifier_state *cur,
> > > +                          int insn_flags)
> > >  {
> > >       struct bpf_insn_hist_entry *p;
> > >       size_t alloc_size;
> > >=20
> > > -     if (!is_jmp_point(env, env->insn_idx))
> > > +     /* combine instruction flags if we already recorded this instru=
ction */
> > > +     if (cur->insn_hist_end > cur->insn_hist_start &&
> > > +         (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
> > > +         p->idx =3D=3D env->insn_idx &&
> > > +         p->prev_idx =3D=3D env->prev_insn_idx) {
> > > +             p->flags |=3D insn_flags;
> >=20
> > Nitpick: maybe add an assert to check that frameno/spi are not or'ed?
>=20
> ok, something like
>=20
> WARN_ON_ONCE(p->flags & (INSN_F_STACK_ACCESS | INSN_F_FRAMENOMASK |
> (INSN_F_SPI_MASK << INSN_F_SPI_SHIFT)));
>=20
> ?

Something like this, yes.

[...]

> > > @@ -4713,9 +4711,12 @@ static int check_stack_write_fixed_off(struct =
bpf_verifier_env *env,
> > >=20
> > >               /* Mark slots affected by this stack write. */
> > >               for (i =3D 0; i < size; i++)
> > > -                     state->stack[spi].slot_type[(slot - i) % BPF_RE=
G_SIZE] =3D
> > > -                             type;
> > > +                     state->stack[spi].slot_type[(slot - i) % BPF_RE=
G_SIZE] =3D type;
> > > +             insn_flags =3D 0; /* not a register spill */
> > >       }
> > > +
> > > +     if (insn_flags)
> > > +             return push_insn_history(env, env->cur_state, insn_flag=
s);
> >=20
> > Maybe add a check that insn is BPF_ST or BPF_STX here?
> > Only these cases are supported by backtrack_insn() while
> > check_mem_access() is called from multiple places.
>=20
> seems like a wrong place to enforce that check_stack_write_fixed_off()
> is called only for those instructions?

check_stack_write_fixed_off() is called from check_stack_write() which
is called from check_mem_access() which might trigger
check_stack_write_fixed_off() when called with BPF_WRITE flag and
pointer to stack as an argument.
This happens for ST, STX but also in check_helper_call(),
process_iter_arg() (maybe other places).
Speaking of which, should this be handled in backtrack_insn()?

> [...]
>=20
> trimming is good

Sigh... sorry, really tried to trim everything today.

