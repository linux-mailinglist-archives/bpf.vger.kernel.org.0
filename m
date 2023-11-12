Return-Path: <bpf+bounces-14908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6747E8DE8
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84221C203BE
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F117F7;
	Sun, 12 Nov 2023 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OduiQ9Sj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AC17EC
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:57:33 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0582D5E
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:57:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so5141461a12.2
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699754250; x=1700359050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncPW04DjdQdxTz65SoZzKqQGu0JOp9QHrwrfK0veAG0=;
        b=OduiQ9SjpRrhCe3FpXtlGPlUCpYvrY/LmyoROC4+Tt3YApMpDr51nY9WWHvTFl+ceM
         YxXXLv3DT/t6oe/HkMdKpt2Yhg4UV3/9Fu+MVZFSa8yY0SYl9mewfMV/bvgocIOAsgJ6
         unToMFsoT8zyaxHbbvookdY/rYJUDX9p7LkE3RCWV83Stmv6RKF4C5gk9W7AsUUROjbw
         LyhVAR/EoZITvpvhcY5G+FMRzq2tit+FvJP88VtcDW6H+bbVfs7hrTRk2rFmBpQw2RE/
         N/WVO7HYQI+HCW3uTVr9jF+QISyDcixTrZNx4V4mBjdBPcQNaf3QodXqwLHHtpaCxB0L
         YMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699754250; x=1700359050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncPW04DjdQdxTz65SoZzKqQGu0JOp9QHrwrfK0veAG0=;
        b=FjeESX0+nYZp8sLkws/IK/hvnRTiYjGgMARmYO/yQh6bL1vCMIUHsBdY1kkmz/SsNX
         VR2kf+Qf2gNrzbGyz0LTJHaszLWLGABylHMaNiHxbOiwcpabCR94fzzpWwpOJNu7BLpz
         1racwhqAIyeY/Qi6vbEWkZGedBalOtErXUzk3eCRcsDsBBmb44vuYrsUfkuI/HVclFaQ
         yeCWHc5my9VNFJXiyOtL8V5Q3QVNMGM9ulDdis1OE7Mpyl3S/HKRe6lYvSG2rAq31mRE
         j7c57GKoqni5oI9NCk98sdt+H04CG1JkrEwEJHdjhbWb8k7b0jOT7Wr9X/eKO2Y7SJTa
         EANQ==
X-Gm-Message-State: AOJu0Yxd0IaHTgoGDvlbFZbMQ+OebmGfYhCC/yZeo8altTo/iteJdcun
	GZJjRRMBVnJzztxARE85ZWFo/vQmk9BmY9+c6fVlhA0h2TY=
X-Google-Smtp-Source: AGHT+IF6GPSnUcS33xbbGEa4pjEQsQDGrwJrLAWIBDmHH/X77xfPwBb7ybSvHPJqpBVRCAB9s1Vw9bRkf8fHHBYWiWE=
X-Received: by 2002:aa7:c250:0:b0:545:50e9:831 with SMTP id
 y16-20020aa7c250000000b0054550e90831mr1985644edo.17.1699754249635; Sat, 11
 Nov 2023 17:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-3-andrii@kernel.org>
 <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
 <CAEf4BzbC9=6haCwQ7U5qzt9=zKTTTYxsh3s74hBBVxwNWPPx3w@mail.gmail.com>
 <df3cb08a39fb2646ce14c8398ace0507bb6e1258.camel@gmail.com> <CAEf4BzYF7m6H6hcT6QnPFoMH9tXiqR4w1CM0jmkPG4X4DBhxEw@mail.gmail.com>
In-Reply-To: <CAEf4BzYF7m6H6hcT6QnPFoMH9tXiqR4w1CM0jmkPG4X4DBhxEw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 11 Nov 2023 17:57:17 -0800
Message-ID: <CAEf4BzZOtAdzfBqP4H0sqhev00mCuRhbMkTX=DkPyh34s7ypeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Tao Lyu <tao.lyu@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 10:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2023-11-09 at 09:20 -0800, Andrii Nakryiko wrote:
> > [...]
> > > > >  struct bpf_insn_hist_entry {
> > > > > -     u32 prev_idx;
> > > > >       u32 idx;
> > > > > +     /* insn idx can't be bigger than 1 million */
> > > > > +     u32 prev_idx : 22;
> > > > > +     /* special flags, e.g., whether insn is doing register stac=
k spill/load */
> > > > > +     u32 flags : 10;
> > > > >  };
> > > >
> > > > Nitpick: maybe use separate bit-fields for frameno and spi instead =
of
> > > >          flags? Or add dedicated accessor functions?
> > >
> > > I wanted to keep it very uniform so that push_insn_history() doesn't
> > > know about all such details. It just has "flags". We might use these
> > > flags for some other use cases, though if we run out of bits we'll
> > > probably just expand bpf_insn_hist_entry and refactor existing code
> > > anyways. So, basically, I didn't want to over-engineer this bit too
> > > much :)
> >
> > Well, maybe hide "(hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK"
> > behind an accessor?
>
> I'll add a single line helper function just to not be PITA, but I
> don't think it's worth it. There are two places we do this, one next
> to the other within the same function. This helper is just going to
> add mental overhead and won't really help us with anything.
>
> >
> > [...]
> >
> > > > > +static int push_insn_history(struct bpf_verifier_env *env, struc=
t bpf_verifier_state *cur,
> > > > > +                          int insn_flags)
> > > > >  {
> > > > >       struct bpf_insn_hist_entry *p;
> > > > >       size_t alloc_size;
> > > > >
> > > > > -     if (!is_jmp_point(env, env->insn_idx))
> > > > > +     /* combine instruction flags if we already recorded this in=
struction */
> > > > > +     if (cur->insn_hist_end > cur->insn_hist_start &&
> > > > > +         (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
> > > > > +         p->idx =3D=3D env->insn_idx &&
> > > > > +         p->prev_idx =3D=3D env->prev_insn_idx) {
> > > > > +             p->flags |=3D insn_flags;
> > > >
> > > > Nitpick: maybe add an assert to check that frameno/spi are not or'e=
d?
> > >
> > > ok, something like
> > >
> > > WARN_ON_ONCE(p->flags & (INSN_F_STACK_ACCESS | INSN_F_FRAMENOMASK |
> > > (INSN_F_SPI_MASK << INSN_F_SPI_SHIFT)));
> > >
> > > ?
> >
> > Something like this, yes.
> >
>
> I added it, and I hate it. It's just a visual noise. Feels too
> paranoid, I'll probably drop it.
>

I ended up with these changes on top of this patch:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 23dbfb5022ba..d234c6f53741 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3167,6 +3167,21 @@ static int check_reg_arg(struct
bpf_verifier_env *env, u32 regno,
        return 0;
 }

+static int insn_stack_access_flags(int frameno, int spi)
+{
+       return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
+}
+
+static int insn_stack_access_spi(int insn_flags)
+{
+       return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
+}
+
+static int insn_stack_access_frameno(int insn_flags)
+{
+       return insn_flags & INSN_F_FRAMENO_MASK;
+}
+
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
        env->insn_aux_data[idx].jmp_point =3D true;
@@ -3187,6 +3202,7 @@ static int push_insn_history(struct
bpf_verifier_env *env, struct bpf_verifier_s

        /* combine instruction flags if we already recorded this instructio=
n */
        if (env->cur_hist_ent) {
+               WARN_ON_ONCE(env->cur_hist_ent->flags & insn_flags);
                env->cur_hist_ent->flags |=3D insn_flags;
                return 0;
        }
@@ -3499,8 +3515,8 @@ static int backtrack_insn(struct
bpf_verifier_env *env, int idx, int subseq_idx,
                 * that [fp - off] slot contains scalar that needs to be
                 * tracked with precision
                 */
-               spi =3D (hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK=
;
-               fr =3D hist->flags & INSN_F_FRAMENO_MASK;
+               spi =3D insn_stack_access_spi(hist->flags);
+               fr =3D insn_stack_access_frameno(hist->flags);
                bt_set_frame_slot(bt, fr, spi);
        } else if (class =3D=3D BPF_STX || class =3D=3D BPF_ST) {
                if (bt_is_reg_set(bt, dreg))
@@ -3512,8 +3528,8 @@ static int backtrack_insn(struct
bpf_verifier_env *env, int idx, int subseq_idx,
                /* scalars can only be spilled into stack */
                if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
                        return 0;
-               spi =3D (hist->flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK=
;
-               fr =3D hist->flags & INSN_F_FRAMENO_MASK;
+               spi =3D insn_stack_access_spi(hist->flags);
+               fr =3D insn_stack_access_frameno(hist->flags);
                if (!bt_is_frame_slot_set(bt, fr, spi))
                        return 0;
                bt_clear_frame_slot(bt, fr, spi);
@@ -4322,7 +4338,7 @@ static int check_stack_write_fixed_off(struct
bpf_verifier_env *env,
        int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE, err;
        struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
        struct bpf_reg_state *reg =3D NULL;
-       int insn_flags =3D INSN_F_STACK_ACCESS | (spi <<
INSN_F_SPI_SHIFT) | state->frameno;
+       int insn_flags =3D insn_stack_access_flags(state->frameno, spi);

        err =3D grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
        if (err)
@@ -4618,7 +4634,7 @@ static int check_stack_read_fixed_off(struct
bpf_verifier_env *env,
        int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
        struct bpf_reg_state *reg;
        u8 *stype, type;
-       int insn_flags =3D INSN_F_STACK_ACCESS | (spi <<
INSN_F_SPI_SHIFT) | reg_state->frameno;
+       int insn_flags =3D insn_stack_access_flags(reg_state->frameno, spi)=
;

        stype =3D reg_state->stack[spi].slot_type;
        reg =3D &reg_state->stack[spi].spilled_ptr;



> > [...]
> >
> > > > > @@ -4713,9 +4711,12 @@ static int check_stack_write_fixed_off(str=
uct bpf_verifier_env *env,
> > > > >
> > > > >               /* Mark slots affected by this stack write. */
> > > > >               for (i =3D 0; i < size; i++)
> > > > > -                     state->stack[spi].slot_type[(slot - i) % BP=
F_REG_SIZE] =3D
> > > > > -                             type;
> > > > > +                     state->stack[spi].slot_type[(slot - i) % BP=
F_REG_SIZE] =3D type;
> > > > > +             insn_flags =3D 0; /* not a register spill */
> > > > >       }
> > > > > +
> > > > > +     if (insn_flags)
> > > > > +             return push_insn_history(env, env->cur_state, insn_=
flags);
> > > >
> > > > Maybe add a check that insn is BPF_ST or BPF_STX here?
> > > > Only these cases are supported by backtrack_insn() while
> > > > check_mem_access() is called from multiple places.
> > >
> > > seems like a wrong place to enforce that check_stack_write_fixed_off(=
)
> > > is called only for those instructions?
> >
> > check_stack_write_fixed_off() is called from check_stack_write() which
> > is called from check_mem_access() which might trigger
> > check_stack_write_fixed_off() when called with BPF_WRITE flag and
> > pointer to stack as an argument.
> > This happens for ST, STX but also in check_helper_call(),
> > process_iter_arg() (maybe other places).
> > Speaking of which, should this be handled in backtrack_insn()?
>
> Note that we set insn_flags only for cases where we do an actual
> register spill (save_register_state calls for non-fake registers). If
> register spill is possible from a helper call somehow, we'll be in
> much bigger trouble elsewhere.
>
> >
> > > [...]
> > >
> > > trimming is good
> >
> > Sigh... sorry, really tried to trim everything today.

