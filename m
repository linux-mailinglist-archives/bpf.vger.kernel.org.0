Return-Path: <bpf+bounces-34339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B1392C7E1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67291F23DBE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67996443D;
	Wed, 10 Jul 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAG9n9UM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB8161
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574487; cv=none; b=qS0HUtRpzg+9O8OrgpTI/u3CsKv2xrvmYSotKTZ4tty8v57UW+9EwWxiSjGmU5ZOPLIK2iZDsw/js7dXSBx1o6L3ODFQEYLqtyjQtQccQl2oV4puFvfD1pq1/AQchw89j/3rTOoJkl3Y47BUTFTTMYBWFRsA+xWVtSzGAlLMLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574487; c=relaxed/simple;
	bh=bxcdXTR013nizlYOp3yRDN3TPRxlLYPcarHWhayFv4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EO2mNb5e2h8qSB4TsdoeBiC7fTel6QKrJd8XMNxXW4t8wHEZ5I+ehWRFVV3kJiwgwsQJcL0hWWpRvDnqeHNFwOqxMvX3+4H1ZK6pgHvGQCFkykiruuuQCv6Fls2oroGemHXoT+eScxmSQMwMfiSIHMCQxC/AFhnIwqukkzCiGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAG9n9UM; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d6301e7279so3781206b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574484; x=1721179284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hCOuEIVq4o2cafyABzbH1nBDD6Tve/YNX6E/2UHjQMU=;
        b=ZAG9n9UMdS+9xBM/9bqTRdpqSUTLv5CKiLjocwoNsVPlUaBiSeEXUbp7BArrrEw9hC
         zWc9RFEoNLyzVNFdGel8Th9G2yxtiuuvbOc/899er07d/tTrOOSdP0gPxHrwzTFTv1Ar
         eeP3nsS/fbaiifyk3Hg3olIWO4Kw5nCW3/l/6oOHpqcHZlM8bec2r2N5tWEd9JskupnJ
         WoxlTF8PU8eQjDp9ZnN7MMPJnOw819sfPyVHM50GpH9dO+V6PZzQLjIFIohnCacB9f6v
         1fFI0bzNc6R0DF+I5f3i/o8Ac5XJgvLu6jYU0sEgwWBfB7oe7g+gVx3cekD4PWr9fQCO
         D01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574484; x=1721179284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCOuEIVq4o2cafyABzbH1nBDD6Tve/YNX6E/2UHjQMU=;
        b=nUt3fHJHz9r+V9CAC+owf3xLq5PRw7d+916db66oUuCVkcB10rR3ISWvwOXXvAWOGd
         QT1ELBAbmueqdR2L8Rwi+nYHmr8GdQjK5T8Ga4r58y67WCdYzIeFvcFskjP/CqsKmt+R
         Y3lUBMl+U3qs8pM7PC20gqT0QsE3HHm14eJ8M35+zuayBP6hXXrp3NcZmbL+Hhhh4gNH
         lkq8N63rUpQtImMjsJrgLiV6CFHQuWu8EGZlr3zuE/DT/GOHNfKCDyguHgmR2PVapJZO
         ZIK989PgbL9IYMPNEVQdg5q/h5hqGFGWDFp4kEjb6rihzfEjny+I12URXD8YW1EljWTH
         6qtg==
X-Gm-Message-State: AOJu0Yy51XUeUsU6bdYqeyV3BcOF74tgbJUx9TdHE4QRhBez+yyCrGD0
	3JBgISTTl/yjNsl9yZzAMnxeKavkF1DjoLh+Ig+aUbzfMjtfWr+D
X-Google-Smtp-Source: AGHT+IEdXm3Fg5YqFRrfw6zAlgbbQ17Yn4TYy1IizKHqaDQE7ajOmmqe2xGtRoBXqGV0qLIijiIYzA==
X-Received: by 2002:a05:6808:10d0:b0:3d6:32b4:b8fa with SMTP id 5614622812f47-3d93beff198mr5243041b6e.13.1720574484286;
        Tue, 09 Jul 2024 18:21:24 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d61c012a9sm1989389a12.42.2024.07.09.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:21:23 -0700 (PDT)
Message-ID: <e1551a1e473d0497275f74a005e47841f058cf7b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: track find_equal_scalars history
 on per-instruction level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Tue, 09 Jul 2024 18:21:18 -0700
In-Reply-To: <CAEf4Bzbq8Lg+n1K=V0RjgKh7+PFU5rrwFPP2s0Z+g_nLbUpcPA@mail.gmail.com>
References: <20240705205851.2635794-1-eddyz87@gmail.com>
	 <20240705205851.2635794-2-eddyz87@gmail.com>
	 <CAEf4Bzbq8Lg+n1K=V0RjgKh7+PFU5rrwFPP2s0Z+g_nLbUpcPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 17:34 -0700, Andrii Nakryiko wrote:
> On Fri, Jul 5, 2024 at 1:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Use bpf_verifier_state->jmp_history to track which registers were
> > updated by find_equal_scalars() when conditional jump was verified.
> > Use recorded information in backtrack_insn() to propagate precision.
> >=20
> > E.g. for the following program:
> >=20
> >             while verifying instructions
> >   r1 =3D r0              |
> >   if r1 < 8  goto ...  | push r0,r1 as equal_scalars in jmp_history
> >   if r0 > 16 goto ...  | push r0,r1 as equal_scalars in jmp_history
>=20
> linked_scalars? especially now that Alexei added offsets between
> linked registers

Missed this, will update.

>=20
> >   r2 =3D r10             |
> >   r2 +=3D r0             v mark_chain_precision(r0)
> >=20
> >             while doing mark_chain_precision(r0)
> >   r1 =3D r0              ^
> >   if r1 < 8  goto ...  | mark r0,r1 as precise
> >   if r0 > 16 goto ...  | mark r0,r1 as precise
> >   r2 =3D r10             |
> >   r2 +=3D r0             | mark r0 precise
>=20
> let's reverse the order here so it's linear in how the algorithm
> actually works (backwards)?

I thought the arrow would be enough. Ok, can reverse.

> > Technically, achieve this as follows:
> > - Use 10 bits to identify each register that gains range because of
> >   find_equal_scalars():
>=20
> should this be renamed to find_linked_scalars() nowadays?

That would be sync_linked_regs() if we use naming that you suggest.
Will update.

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e25ad5fb9115..ec493360607e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3335,9 +3335,87 @@ static bool is_jmp_point(struct bpf_verifier_env=
 *env, int insn_idx)
> >         return env->insn_aux_data[insn_idx].jmp_point;
> >  }
> >=20
> > +#define ES_FRAMENO_BITS        3
> > +#define ES_SPI_BITS    6
> > +#define ES_ENTRY_BITS  (ES_SPI_BITS + ES_FRAMENO_BITS + 1)
> > +#define ES_SIZE_BITS   4
> > +#define ES_FRAMENO_MASK        ((1ul << ES_FRAMENO_BITS) - 1)
> > +#define ES_SPI_MASK    ((1ul << ES_SPI_BITS)     - 1)
> > +#define ES_SIZE_MASK   ((1ul << ES_SIZE_BITS)    - 1)
>=20
> ull for 32-bit arches?

Ok

>=20
> > +#define ES_SPI_OFF     ES_FRAMENO_BITS
> > +#define ES_IS_REG_OFF  (ES_SPI_BITS + ES_FRAMENO_BITS)
>=20
> ES makes no sense now, no? LR or LINKREG or something along those lines?
>=20
> > +#define LINKED_REGS_MAX        6
> > +
> > +struct reg_or_spill {
>=20
> reg_or_spill -> linked_reg ?

Ok

>=20
> > +       u8 frameno:3;
> > +       union {
> > +               u8 spi:6;
> > +               u8 regno:6;
> > +       };
> > +       bool is_reg:1;
> > +};
>=20
> Do we need these bitfields for unpacked representation? It's going to
> use 2 bytes for this struct anyways. If you just use u8 for everything
> you end up with 3 bytes. Bitfields are a bit slower because the
> compiler will need to do more bit manipulations, so is it really worth
> it?

Ok, will remove bitfields.

[...]

> > @@ -3844,6 +3974,7 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
> >                          */
> >                         bt_set_reg(bt, dreg);
> >                         bt_set_reg(bt, sreg);
> > +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> >                          /* else dreg <cond> K
>=20
> drop "else" from the comment then? I like this change.

This is actually a leftover from v1. I can drop "else" from the
comment or drop this hunk as it is not necessary for the series.

> >                           * Only dreg still needs precision before
> >                           * this insn, so for the K-based conditional
> > @@ -3862,6 +3993,10 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx, int subseq_idx,
> >                         /* to be analyzed */
> >                         return -ENOTSUPP;
> >         }
> > +       /* Propagate precision marks to linked registers, to account fo=
r
> > +        * registers marked as precise in this function.
> > +        */
> > +       bt_sync_linked_regs(bt, hist);
>=20
> Radical Andrii is fine with this, though I wonder if there is some
> place outside of backtrack_insn() where the first
> bt_sync_linked_regs() could be called just once?

The problem here is that:
- in theory linked_regs could be present for any instruction, thus
  sync() is needed after get_jmp_hist_entry call in
  __mark_chain_precision();
- backtrack_insn() might both remove and add some registers in bt,
  hence, to correctly handle bt_empty() call in __mark_chain_precision
  the sync() is also needed after backtrack_insn().

So, current placement is the simplest I could come up with.

> But regardless, this is only mildly expensive when we do have linked
> registers, so unlikely to have any noticeable performance effect.

Yes, that was my thinking as well.

[...]

> > @@ -15154,14 +15289,66 @@ static bool try_match_pkt_pointers(const stru=
ct bpf_insn *insn,
> >         return true;
> >  }
> >=20
> > -static void find_equal_scalars(struct bpf_verifier_state *vstate,
> > -                              struct bpf_reg_state *known_reg)
> > +static void __find_equal_scalars(struct linked_regs *reg_set, struct b=
pf_reg_state *reg,
> > +                                u32 id, u32 frameno, u32 spi_or_reg, b=
ool is_reg)
>=20
> we should abandon "equal scalars" terminology, they don't have to be
> equal, they are just linked together (potentially with a fixed
> difference between them)
>=20
> how about "collect_linked_regs"?

Sounds good.

[...]

> > @@ -15312,6 +15500,21 @@ static int check_cond_jmp_op(struct bpf_verifi=
er_env *env,
> >                 return 0;
> >         }
> >=20
> > +       /* Push scalar registers sharing same ID to jump history,
> > +        * do this before creating 'other_branch', so that both
> > +        * 'this_branch' and 'other_branch' share this history
> > +        * if parent state is created.
> > +        */
> > +       if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SC=
ALAR_VALUE && src_reg->id)
> > +               find_equal_scalars(this_branch, src_reg->id, &linked_re=
gs);
> > +       if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> > +               find_equal_scalars(this_branch, dst_reg->id, &linked_re=
gs);
> > +       if (linked_regs.cnt > 1) {
>=20
> if we have just one, should it be even marked as linked?

Sorry, I don't understand. Do you suggest to add an additional check
in find_equal_scalars/collect_linked_regs and reset it if 'cnt' equals 1?

[...]
>=20
> > +               err =3D push_jmp_history(env, this_branch, 0, linked_re=
gs_pack(&linked_regs));
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> >         other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *in=
sn_idx,
> >                                   false);
> >         if (!other_branch)
> > @@ -15336,13 +15539,13 @@ static int check_cond_jmp_op(struct bpf_verif=
ier_env *env,
> >         if (BPF_SRC(insn->code) =3D=3D BPF_X &&
> >             src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
> >             !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_=
reg].id)) {
> > -               find_equal_scalars(this_branch, src_reg);
> > -               find_equal_scalars(other_branch, &other_branch_regs[ins=
n->src_reg]);
> > +               copy_known_reg(this_branch, src_reg, &linked_regs);
> > +               copy_known_reg(other_branch, &other_branch_regs[insn->s=
rc_reg], &linked_regs);
>=20
> I liked the "sync" terminology you used for bt, so why not call this
> "sync_linked_regs" ?

I kept the current name for the function.
Suggested name makes sense, though.

[...]

