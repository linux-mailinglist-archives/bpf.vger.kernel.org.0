Return-Path: <bpf+bounces-15472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C4B7F2277
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F511C21531
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8915C1;
	Tue, 21 Nov 2023 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9R2Psav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA1CD
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:46:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a62d4788so7078902e87.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527581; x=1701132381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa3xMWoAQf1VaC1S8a6TWCbpTdOC2N9pWVnPuGL7khY=;
        b=H9R2Psavu+XmnhyOMENlnTcJLSPJw+49q5DOwzMXBw9GZXyo6xDVtIkYuyZjHzRZFg
         Oqcg4OT/0feoweeNZYszpca4MHUKa2YRnQ9d/5S4dKz7oGXKhONqk35+3cFBtXbTPBJ4
         M1cZ56kxvnjxDYDEdeCWrYo8DHwBNixHfhdqaPCgpep9nkZ4Rp9GcU6ZyS0H1ieKSrx/
         KK5N0Wh369CWoP+dTIgCuVVLqfduk8LHlnBgoIB/VBgOG4pB57rdGX90cb4Bz3ECMwKY
         tndE9z3jMnyp/okMnLdeQ+SxEMJ6m4SRyVMH/scy8YC5Eohm2Z/chQ+9P5Tm6fB1rdaW
         AnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527581; x=1701132381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa3xMWoAQf1VaC1S8a6TWCbpTdOC2N9pWVnPuGL7khY=;
        b=Q6pDa31A93UyYJhva+bWQaP/p0vs2/TIXBUgia8Ts6Feh+dkfwDB7VviESzMenAnia
         8s1mkSEy90jGHWDoDG9nIYgxJBQQRP9fG1rYx446MkhOLpF9ukvPhsDzQwC0iTEcLwqW
         RUmuaYhI4Ap1RFEz+7OHM7xCNhMDBS14UMi7FE4D1CPbr4KgzPU4Xi+MS4+LdAxwHbQA
         nyGTvTBzZQIgsZBJItleQoCwnVSazHGKqok6sVGsGSRoGbR25EPevZ2dAifUcEO0BTLm
         NoAJn3mIlPbpYAET5veKm/HEmx0tbd65U7GhRpLzYpVpRfybt1Z40IfZ6lo6TCo8/PGX
         pcXg==
X-Gm-Message-State: AOJu0YyGU/pFk4qlIbYuTHie4+x7kopBPDFJfUGL39dBUN1vs4X8qSyF
	UmXNzuujCs6GtFAmYavEjcqyeGzxquvG3/3U4IpDNvwHnEI=
X-Google-Smtp-Source: AGHT+IET5pxzznvs3txaL5CYYthjXybpl7VjDybB8o2MqQ5D2fGkhXy81WnSZWAPdjDiW+ZN9UfXe1PG1jOln8M+brg=
X-Received: by 2002:a05:6512:2112:b0:503:36cb:5438 with SMTP id
 q18-20020a056512211200b0050336cb5438mr5538199lfr.21.1700527581045; Mon, 20
 Nov 2023 16:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113235008.127238-1-andreimatei1@gmail.com>
In-Reply-To: <20231113235008.127238-1-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Nov 2023 16:46:09 -0800
Message-ID: <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
To: Andrei Matei <andreimatei1@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, sunhao.th@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 3:51=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> Before this patch, writes to the stack using registers containing a
> variable offset (as opposed to registers with fixed, known values) were
> not properly contributing to the function's needed stack size. As a
> result, it was possible for a program to verify, but then to attempt to
> read out-of-bounds data at runtime because a too small stack had been
> allocated for it.
>
> Each function tracks the size of the stack it needs in
> bpf_subprog_info.stack_depth, which is maintained by
> update_stack_depth(). For regular memory accesses, check_mem_access()
> was calling update_state_depth() but it was passing in only the fixed
> part of the offset register, ignoring the variable offset. This was
> incorrect; the minimum possible value of that register should be used
> instead.
>
> This patch fixes it by pushing down the update_stack_depth() call into
> grow_stack_depth(), which then correctly uses the registers lower bound.
> grow_stack_depth() is responsible for tracking the maximum stack size
> for the current verifier state, so it seems like a good idea to couple
> it with also updating the per-function high-water mark. As a result of
> this re-arrangement, update_stack_depth() is no longer needlessly called
> for reads; it is now called only for writes (plus other cases like
> helper memory access). I think this is a good thing, as reads cannot
> possibly grow the needed stack.

I'm going to disagree. I think we should calculate max stack size both
on reads and writes. I'm not sure why it's ok for a BPF program to
access a stack with some big offset, but the BPF verifier not
rejecting this. What do I miss?

>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=3D1qbuZUi20tGoUXoU0=
7FPf-5FLvhOKOY+Q@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c | 47 ++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a2267d5ed14e..303a3572b169 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1669,8 +1669,29 @@ static int resize_reference_state(struct bpf_func_=
state *state, size_t n)
>         return 0;
>  }
>
> -static int grow_stack_state(struct bpf_func_state *state, int size)
> +static int update_stack_depth(struct bpf_verifier_env *env,
> +                             const struct bpf_func_state *func,
> +                             int off)
> +{
> +       u16 stack =3D env->subprog_info[func->subprogno].stack_depth;
> +
> +       if (stack >=3D -off)
> +               return 0;
> +
> +       /* update known max for given subprogram */
> +       env->subprog_info[func->subprogno].stack_depth =3D -off;
> +       return 0;
> +}

given this is targeting bpf tree and will probably be backported to
stable kernels, let's minimize code movement. Can you just add
update_stack_depth forward declaration here instead?

> +
> +/* Possibly update state->allocated_stack to be at least size bytes. Als=
o
> + * possibly update the function's high-water mark in its bpf_subprog_inf=
o.
> + */
> +static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_fun=
c_state *state, int size)
>  {
> +       int err =3D update_stack_depth(env, state, -size);
> +       if (err) {
> +               return err;
> +       }
>         size_t old_n =3D state->allocated_stack / BPF_REG_SIZE, n =3D siz=
e / BPF_REG_SIZE;
>
>         if (old_n >=3D n)
> @@ -4638,7 +4659,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>         struct bpf_reg_state *reg =3D NULL;
>         u32 dst_reg =3D insn->dst_reg;
>
> -       err =3D grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE))=
;
> +       err =3D grow_stack_state(env, state, round_up(slot + 1, BPF_REG_S=
IZE));
>         if (err)
>                 return err;
>         /* caller checked that off % size =3D=3D 0 and -MAX_BPF_STACK <=
=3D off < 0,
> @@ -4796,7 +4817,7 @@ static int check_stack_write_var_off(struct bpf_ver=
ifier_env *env,
>             (!value_reg && is_bpf_st_mem(insn) && insn->imm =3D=3D 0))
>                 writing_zero =3D true;
>
> -       err =3D grow_stack_state(state, round_up(-min_off, BPF_REG_SIZE))=
;
> +       err =3D grow_stack_state(env, state, round_up(-min_off, BPF_REG_S=
IZE));
>         if (err)
>                 return err;
>
> @@ -5928,20 +5949,6 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
>                                            strict);
>  }
>
> -static int update_stack_depth(struct bpf_verifier_env *env,
> -                             const struct bpf_func_state *func,
> -                             int off)
> -{
> -       u16 stack =3D env->subprog_info[func->subprogno].stack_depth;
> -
> -       if (stack >=3D -off)
> -               return 0;
> -
> -       /* update known max for given subprogram */
> -       env->subprog_info[func->subprogno].stack_depth =3D -off;
> -       return 0;
> -}
> -
>  /* starting from main bpf function walk all instructions of the function
>   * and recursively walk all callees that given function can call.
>   * Ignore jump and exit insns.
> @@ -6822,7 +6829,6 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  {
>         struct bpf_reg_state *regs =3D cur_regs(env);
>         struct bpf_reg_state *reg =3D regs + regno;
> -       struct bpf_func_state *state;
>         int size, err =3D 0;
>
>         size =3D bpf_size_to_bytes(bpf_size);
> @@ -6965,11 +6971,6 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>                 if (err)
>                         return err;
>
> -               state =3D func(env, reg);
> -               err =3D update_stack_depth(env, state, off);
> -               if (err)
> -                       return err;
> -

It *feels* like this stack depth update *and* growing allocated stack
slots should happen somewhere in check_stack_access_within_bounds() or
right after it. It shouldn't matter whether we read or write to the
stack slot: either way that slot becomes part of the verifier state
that we should take into account during state comparison. Eduard not
so long ago added a change that allows reading STACK_INVALID slots, so
it's completely valid to read something that was never written to (and
so grow_stack_state() wasn't called for that slot, as it is
implemented right now). So I think we should fix that.

Let's also add a test that will trigger this situation with both
direct stack slot read into register and through helper?

cc'ing Eduard just in case I'm missing some subtle detail here

>                 if (t =3D=3D BPF_READ)
>                         err =3D check_stack_read(env, regno, off, size,
>                                                value_regno);
> --
> 2.39.2
>
>

