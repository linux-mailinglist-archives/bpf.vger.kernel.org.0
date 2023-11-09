Return-Path: <bpf+bounces-14600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1187E7011
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33650B20B64
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84742232C;
	Thu,  9 Nov 2023 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwW8hBV/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0A1DFCB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:21:00 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6602A30D5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:20:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso194612966b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699550458; x=1700155258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ+rxdI4NYzbS60mypomJP9yeflc4ToBXOExosC5HZs=;
        b=cwW8hBV/8Rrm5QJYhedIxw2LCtkZV6Hmp8T+e8gcnzWNrTJBjQ0y5q/E128RJJwDh1
         KS8KnMD8u5kodkMi2kKfRtmtzZ8kj9tHogWEia1OvTE02yJ8oag/oG12yyqxwooUq5th
         +XGw+9RXqdEjq73pnN6ysfP241jYoFZ2eczdtEDFE7+CROTa7uoDNiwwCi8xV6WDjGI+
         US8HNCsRFkXQvdCZ0ouruN43Ckxf3rQ6YLbr9DR1OOJk8DOYh3nnKsXFA9t3B7m7grd6
         ODVeexPjgAXaHVKtQm/z6bf1/lhxLLUwpQLmv7WM/THc+mExNTyxCvDecVmbWSGRl/CE
         BIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550458; x=1700155258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ+rxdI4NYzbS60mypomJP9yeflc4ToBXOExosC5HZs=;
        b=PVECNd4BkYazVdJRK05FHamuOse1Y2U2BmFS9+njKi1jip6mrRm3yNyY6w/8SU44AL
         XTwJ6xvnQyGrDuiij6wQQvC5BVejZcCW98WY4FErFVaGP8z8e8dlvmkcDxQurHJv9LNm
         341OsA+nRpccdbyUjKC6XdevYZY5U0hhn52qGSWhRAa9WwnV803DO1Zz9U1JoEqyUoeK
         tbSFYp3Z+Tzoe5bWWUOYEjyWE5ZYC6UuqCAL+XVhrODHv3B+Be0lRqTnGsQ9riu/tbGs
         HYkKo3OgKwWe7AXe/BGPe0UKz8L9KhIXZb5LY7O8dA/6TofB9YY3BA4ecGgKTSqqt46n
         9bUA==
X-Gm-Message-State: AOJu0YylTJVdDYcL3CU4Yyf5NhB9WRwmJnU4XH01LnXMMGphZgKoEb2h
	6w8gWPUkOOFAHBZau72kKdtqcspyUBGEN8Kw9Fk=
X-Google-Smtp-Source: AGHT+IGrMyiLm9PnrVfd9WQrU9v5OhyiZnNBIrbAaUXJdMYCt8KidrjlXAOH9DvZmrZoxit2D1DbWbTtvUU/799CF90=
X-Received: by 2002:a17:906:ee81:b0:9c7:5db4:c943 with SMTP id
 wt1-20020a170906ee8100b009c75db4c943mr4357990ejb.40.1699550457592; Thu, 09
 Nov 2023 09:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-3-andrii@kernel.org>
 <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
In-Reply-To: <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:20:46 -0800
Message-ID: <CAEf4BzbC9=6haCwQ7U5qzt9=zKTTTYxsh3s74hBBVxwNWPPx3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Tao Lyu <tao.lyu@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
>
> All makes sense, a few nitpicks below.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +/* instruction history flags, used in bpf_insn_hist_entry.flags field =
*/
> > +enum {
> > +     /* instruction references stack slot through PTR_TO_STACK registe=
r;
> > +      * we also store stack's frame number in lower 3 bits (MAX_CALL_F=
RAMES is 8)
> > +      * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK =
is 512,
> > +      * 8 bytes per slot, so slot index (spi) is [0, 63])
> > +      */
> > +     INSN_F_FRAMENO_MASK =3D 0x7, /* 3 bits */
> > +
> > +     INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
> > +     INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
> > +
> > +     INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
> > +};
> > +
> > +static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
> > +static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK / 8);
> > +
> >  struct bpf_insn_hist_entry {
> > -     u32 prev_idx;
> >       u32 idx;
> > +     /* insn idx can't be bigger than 1 million */
> > +     u32 prev_idx : 22;
> > +     /* special flags, e.g., whether insn is doing register stack spil=
l/load */
> > +     u32 flags : 10;
> >  };
>
> Nitpick: maybe use separate bit-fields for frameno and spi instead of
>          flags? Or add dedicated accessor functions?

I wanted to keep it very uniform so that push_insn_history() doesn't
know about all such details. It just has "flags". We might use these
flags for some other use cases, though if we run out of bits we'll
probably just expand bpf_insn_hist_entry and refactor existing code
anyways. So, basically, I didn't want to over-engineer this bit too
much :)

>
> >
> > -#define MAX_CALL_FRAMES 8
> >  /* Maximum number of register states that can exist at once */
> >  #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) =
* MAX_CALL_FRAMES)
> >  struct bpf_verifier_state {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2905ce2e8b34..fbb779583d52 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3479,14 +3479,20 @@ static bool is_jmp_point(struct bpf_verifier_en=
v *env, int insn_idx)
> >  }
> >
> >  /* for any branch, call, exit record the history of jmps in the given =
state */
> > -static int push_jmp_history(struct bpf_verifier_env *env,
> > -                         struct bpf_verifier_state *cur)
> > +static int push_insn_history(struct bpf_verifier_env *env, struct bpf_=
verifier_state *cur,
> > +                          int insn_flags)
> >  {
> >       struct bpf_insn_hist_entry *p;
> >       size_t alloc_size;
> >
> > -     if (!is_jmp_point(env, env->insn_idx))
> > +     /* combine instruction flags if we already recorded this instruct=
ion */
> > +     if (cur->insn_hist_end > cur->insn_hist_start &&
> > +         (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
> > +         p->idx =3D=3D env->insn_idx &&
> > +         p->prev_idx =3D=3D env->prev_insn_idx) {
> > +             p->flags |=3D insn_flags;
>
> Nitpick: maybe add an assert to check that frameno/spi are not or'ed?

ok, something like

WARN_ON_ONCE(p->flags & (INSN_F_STACK_ACCESS | INSN_F_FRAMENOMASK |
(INSN_F_SPI_MASK << INSN_F_SPI_SHIFT)));

?

>
> [...]
>
> > +static struct bpf_insn_hist_entry *get_hist_insn_entry(struct bpf_veri=
fier_env *env,
> > +                                                    u32 hist_start, u3=
2 hist_end, int insn_idx)
>
> Nitpick: maybe rename 'hist_insn' to 'insn_hist', i.e. 'get_insn_hist_ent=
ry'?

sure, good point, done

>
> [...]
>
> > @@ -4713,9 +4711,12 @@ static int check_stack_write_fixed_off(struct bp=
f_verifier_env *env,
> >
> >               /* Mark slots affected by this stack write. */
> >               for (i =3D 0; i < size; i++)
> > -                     state->stack[spi].slot_type[(slot - i) % BPF_REG_=
SIZE] =3D
> > -                             type;
> > +                     state->stack[spi].slot_type[(slot - i) % BPF_REG_=
SIZE] =3D type;
> > +             insn_flags =3D 0; /* not a register spill */
> >       }
> > +
> > +     if (insn_flags)
> > +             return push_insn_history(env, env->cur_state, insn_flags)=
;
>
> Maybe add a check that insn is BPF_ST or BPF_STX here?
> Only these cases are supported by backtrack_insn() while
> check_mem_access() is called from multiple places.

seems like a wrong place to enforce that check_stack_write_fixed_off()
is called only for those instructions?

>
> >       return 0;
> >  }
> >
> > @@ -4908,6 +4909,7 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
> >       int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
> >       struct bpf_reg_state *reg;
> >       u8 *stype, type;
> > +     int insn_flags =3D INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT=
) | reg_state->frameno;
> >
> >       stype =3D reg_state->stack[spi].slot_type;
> >       reg =3D &reg_state->stack[spi].spilled_ptr;

[...]

trimming is good

