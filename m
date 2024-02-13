Return-Path: <bpf+bounces-21826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51DA85279F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 03:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E391B1C23216
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE58C0A;
	Tue, 13 Feb 2024 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKXotUu6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755C8BEB
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707793121; cv=none; b=inL3txIEehPbW732ijasykI+uwxfTLHE8j3/8NroVwJCVQlaQI1rKn/MWIWlYRirxFZ+R/agTPGqa3xW38OjbJK3N8hhCkLPNLbIAva+LdnI8PHGtDwQHr8RxmGEG1VwxNZY7T/qBAAja2N4ZCUhXkceYlVxSqiP6O1EwaXxY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707793121; c=relaxed/simple;
	bh=xIztOWD5ZEAdJ9A5XLvKF0tO0WoXD88cewVqrKvAbeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIksmQeHJ1EE0O0xHXDlQBH06KbmmdhWq2ZhuvLXtkon7iJo0XrNAoNzAz2FFliinuk4IjRH7KVWb6cbni63ii1ipjQPp/jhjPK8g7pkxN/XwtuGxbf/ShRzlRV+nu4pA5c4DSet2pwF7rf1ZY2hAzlFJT384f9BoBpIwQSS3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKXotUu6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b66883de9so2731577f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707793118; x=1708397918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5DyR8fDFLIzSIkcDfBvNVsU4P0IM/S18QO0AAjZ5vI=;
        b=MKXotUu62RJJgWqSrFORBNhzBx0gkYjWRqAnkKdpupCNDZC0FBnt1hNSlZhfYRrEqY
         ZX9QEC7/xX2fIQZRwY+2Vldrhmb5SEhjiJd2ukBwCN9Z1BYQz5+M+aFyb/dA3g/EPqub
         teFRgWEfNprlm2LBShzcbZaLY8/DTVv17HhjSLbZHGYU6utkmttN2zOYF8QA53RP3Ylu
         u4WNYLhYJ4sI7r6RIy9bqogLJLCWZu/Y2KIVRxdgCSmLhXHPqChm+fqEtTLA6VktaMWN
         j7rzv7IR1vzm8oa4zdd/5vDEWCMNiqUGky7Lw76qpzL446A0c9HM7rYFIiaQwRnY+pJZ
         L0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707793118; x=1708397918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5DyR8fDFLIzSIkcDfBvNVsU4P0IM/S18QO0AAjZ5vI=;
        b=Ig6lE8wih6CXUofVG8QSohI5XgMt/f36ttyWgVG04+udK2I/lpG722rUDn6Y6iN6sB
         YY7mGfSvqIauVMevp3BM8HfnNdoqV2TsSgvdLiCRyQkrI/VyPgePPNfoEaBGHijoYeIX
         gW7C7uKY5wTArTo/byhEfmrJIoLB4/DV7g90df7L02y//wJFqyPkMQ5dKG+/pJt/wreR
         trV5cb9EAAtfQH/F3sfAKzrRyTN0XZ0nWWE7/MuGwe9SQxZnPiFZ5JO+KB0FXFH9KoI9
         FPsBd5twcD064rUsLmpUoi/GGamvjs9uAUx821HQFPArYDUrVkkMCDNPgPLTkalg4rSH
         I74A==
X-Gm-Message-State: AOJu0Yxk+N6O+/PMG74KEW0rSA6F2gJ4g0sH0t+yKK4GNhLqddNF6Kjw
	zarVfI/yN4mIllOMHY42BlXOLX5cShpaNG5l689fIGdq5s31Q2sb34kOweSWJSLHHi8SctEuZG9
	Pw2JGqLnVV14pRFWLHflB5QQaXlsWw7jLG28=
X-Google-Smtp-Source: AGHT+IFbWRDdv8vEgmsMld/P0q++IFNkDvO1Qj/yaxFVFy3l5mfHNaa0qcOeNttbJrumnue4eXuOSr5EwjstzMgGO7U=
X-Received: by 2002:a5d:56d2:0:b0:33b:1ae4:10bb with SMTP id
 m18-20020a5d56d2000000b0033b1ae410bbmr5902430wrw.56.1707793117709; Mon, 12
 Feb 2024 18:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-10-alexei.starovoitov@gmail.com> <ed656ef900c33cb1bf9ffb06d0f4f59d7708e29c.camel@gmail.com>
In-Reply-To: <ed656ef900c33cb1bf9ffb06d0f4f59d7708e29c.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 18:58:26 -0800
Message-ID: <CAADnVQKfJsq6abdL5ShmmzOUKyBard4-9CH_j_V-yARfdn31qA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/20] bpf: Recognize cast_kern/user
 instructions in the verifier.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-02-08 at 20:05 -0800, Alexei Starovoitov wrote:
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3c77a3ab1192..5eeb9bf7e324 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [...]
>
> > @@ -13837,6 +13844,21 @@ static int adjust_reg_min_max_vals(struct bpf_=
verifier_env *env,
> >
> >       dst_reg =3D &regs[insn->dst_reg];
> >       src_reg =3D NULL;
> > +
> > +     if (dst_reg->type =3D=3D PTR_TO_ARENA) {
> > +             struct bpf_insn_aux_data *aux =3D cur_aux(env);
> > +
> > +             if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
> > +                     /*
> > +                      * 32-bit operations zero upper bits automaticall=
y.
> > +                      * 64-bit operations need to be converted to 32.
> > +                      */
> > +                     aux->needs_zext =3D true;
>
> It should be possible to write an example, when the same insn is
> visited with both PTR_TO_ARENA and some other PTR type.
> Such examples should be rejected as is currently done in do_check()
> for BPF_{ST,STX} using save_aux_ptr_type().

Good catch. Fixed reg_type_mismatch_ok().
Didn't craft a unit test. That will be in a follow up.

> [...]
>
> > @@ -13954,16 +13976,17 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >       } else if (opcode =3D=3D BPF_MOV) {
> >
> >               if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > -                     if (insn->imm !=3D 0) {
> > -                             verbose(env, "BPF_MOV uses reserved field=
s\n");
> > -                             return -EINVAL;
> > -                     }
> > -
> >                       if (BPF_CLASS(insn->code) =3D=3D BPF_ALU) {
> > -                             if (insn->off !=3D 0 && insn->off !=3D 8 =
&& insn->off !=3D 16) {
> > +                             if ((insn->off !=3D 0 && insn->off !=3D 8=
 && insn->off !=3D 16) ||
> > +                                 insn->imm) {
> >                                       verbose(env, "BPF_MOV uses reserv=
ed fields\n");
> >                                       return -EINVAL;
> >                               }
> > +                     } else if (insn->off =3D=3D BPF_ARENA_CAST_KERN |=
| insn->off =3D=3D BPF_ARENA_CAST_USER) {
> > +                             if (!insn->imm) {
> > +                                     verbose(env, "cast_kern/user insn=
 must have non zero imm32\n");
> > +                                     return -EINVAL;
> > +                             }
> >                       } else {
> >                               if (insn->off !=3D 0 && insn->off !=3D 8 =
&& insn->off !=3D 16 &&
> >                                   insn->off !=3D 32) {
>
> I think it is now necessary to check insn->imm here,
> as is it allows ALU64 move with non-zero imm.

great catch too. Fixed.

> > @@ -13993,7 +14016,12 @@ static int check_alu_op(struct bpf_verifier_en=
v *env, struct bpf_insn *insn)
> >                       struct bpf_reg_state *dst_reg =3D regs + insn->ds=
t_reg;
> >
> >                       if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> > -                             if (insn->off =3D=3D 0) {
> > +                             if (insn->imm) {
> > +                                     /* off =3D=3D BPF_ARENA_CAST_KERN=
 || off =3D=3D BPF_ARENA_CAST_USER */
> > +                                     mark_reg_unknown(env, regs, insn-=
>dst_reg);
> > +                                     if (insn->off =3D=3D BPF_ARENA_CA=
ST_KERN)
> > +                                             dst_reg->type =3D PTR_TO_=
ARENA;
>
> This effectively allows casting anything to PTR_TO_ARENA.
> Do we want to check that src_reg somehow originates from arena?
> Might be tricky, a new type modifier bit or something like that.

Yes. Casting anything is fine.
I don't think we need to enforce anything.
Those insns will be llvm generated. If src_reg is somehow ptr_to_ctx
or something it's likely llvm bug or crazy manual type cast
by the user, but if they do so let them experience debug pains.
The kernel won't crash.

> > +                             } else if (insn->off =3D=3D 0) {
> >                                       /* case: R1 =3D R2
> >                                        * copy register state to dest re=
g
> >                                        */
> > @@ -14059,6 +14087,9 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >                                               dst_reg->subreg_def =3D e=
nv->insn_idx + 1;
> >                                               coerce_subreg_to_size_sx(=
dst_reg, insn->off >> 3);
> >                                       }
> > +                             } else if (src_reg->type =3D=3D PTR_TO_AR=
ENA) {
> > +                                     mark_reg_unknown(env, regs, insn-=
>dst_reg);
> > +                                     dst_reg->type =3D PTR_TO_ARENA;
>
> This describes a case wX =3D wY, where rY is PTR_TO_ARENA,
> should rX be marked as SCALAR instead of PTR_TO_ARENA?

That was a leftover from earlier experiments when alu64->alu32 was
done early.
Removed this hunk now.

> [...]
>
> > @@ -18235,6 +18272,31 @@ static int resolve_pseudo_ldimm64(struct bpf_v=
erifier_env *env)
> >                               fdput(f);
> >                               return -EBUSY;
> >                       }
> > +                     if (map->map_type =3D=3D BPF_MAP_TYPE_ARENA) {
> > +                             if (env->prog->aux->arena) {
>
> Does this have to be (env->prog->aux->arena && env->prog->aux->arena !=3D=
 map) ?

No. all maps in used_maps[] are unique.
Adding "env->prog->aux->arena !=3D map" won't make any difference.
It will only be confusing.

> > +                                     verbose(env, "Only one arena per =
program\n");
> > +                                     fdput(f);
> > +                                     return -EBUSY;
> > +                             }
>
> [...]
>
> > @@ -18799,6 +18861,18 @@ static int convert_ctx_accesses(struct bpf_ver=
ifier_env *env)
> >                          insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_W) |=
|
> >                          insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_DW))=
 {
> >                       type =3D BPF_WRITE;
> > +             } else if (insn->code =3D=3D (BPF_ALU64 | BPF_MOV | BPF_X=
) && insn->imm) {
> > +                     if (insn->off =3D=3D BPF_ARENA_CAST_KERN ||
> > +                         (((struct bpf_map *)env->prog->aux->arena)->m=
ap_flags & BPF_F_NO_USER_CONV)) {
> > +                             /* convert to 32-bit mov that clears uppe=
r 32-bit */
> > +                             insn->code =3D BPF_ALU | BPF_MOV | BPF_X;
> > +                             /* clear off, so it's a normal 'wX =3D wY=
' from JIT pov */
> > +                             insn->off =3D 0;
> > +                     } /* else insn->off =3D=3D BPF_ARENA_CAST_USER sh=
ould be handled by JIT */
> > +                     continue;
> > +             } else if (env->insn_aux_data[i + delta].needs_zext) {
> > +                     /* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU64=
 to 32-bit ALU */
> > +                     insn->code =3D BPF_ALU | BPF_OP(insn->code) | BPF=
_SRC(insn->code);
>
> Tbh, I think this should be done in do_misc_fixups(),
> mixing it with context handling in convert_ctx_accesses()
> seems a bit confusing.

Good point. Moved.

Thanks a lot for the review!

