Return-Path: <bpf+bounces-16127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510B7FCED1
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AC41C210F7
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA38FD514;
	Wed, 29 Nov 2023 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJgMj4WW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E7270C
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:05:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a178e82a445so8917666b.2
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701237928; x=1701842728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT6Qn3Y3VLBQIKm8YaDj8MdihKmngBmGrvNujLcV4rc=;
        b=JJgMj4WWN4D/Cuv/+/E2zPNjmCQ8JM866+AsKt6BOxxNEcLAf5aMfISBaw8Bp5jhgt
         mkBJW6Rh1M/psowgURTb4wxldS6rJB/THbcy5LxyWlRYWc7MEoYh4BTU9xi5q4IpTrY+
         /Tq9whZvhPs2y33AFORCB7j1TDr+PU7a4Djv7D7Rqq4PLnjI2zGgHPoyy+Ut6UAFpnHj
         5a0Ihkro6TtZCLHIeoTOMjBhj+/9+mQlbH0NYXAXIQjJzq9LOcJ/hNR14eUS4QhVHaCK
         cKuiSZK3N9zLlICJsBVCxEw/gnVcu3Jq3QTLaLKjl5KXE6WXIIe5nd+fZggHPAMDg9LK
         zPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237928; x=1701842728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT6Qn3Y3VLBQIKm8YaDj8MdihKmngBmGrvNujLcV4rc=;
        b=Y1eHE31POdkpYMUOaEahxbV+bFx//rAIXsLwGt0LL40yTCm4grMoBEKY0pRsTznjd9
         ywVmDCYzeMVpBh6SE193CnUn6kUVUStG0+1hbn1xin9gdaD5yc3wEJkYUP4KLDPYMBR0
         parKVCHjXBsd9Dr6n15FQcPZ2efHRoIt1F6WY9V95qdNE4Qu8ziHQhLNpsAvyLatxG5r
         oN2v01KfwfZRf3VlihxYzj+9RQYMsd9iEEAJBifm46R4hSw20zOOmnNVQ4FoHI26U+3a
         K+wR9KAf5VtCybwRpNxfTfiKVUj63I5mDi5Nx8bbJk4odet8u2sfsQie7ztcWjrD5f4/
         CNbg==
X-Gm-Message-State: AOJu0YzPyjPalu1+chZ6pebUFTHjoGsclUW0Gho3jFMOQ4LTq2gxO9v8
	wqXAcyeI1uidW/gvrK+tiLVgDEgqxxYjuoOPVcltWkg0
X-Google-Smtp-Source: AGHT+IEvEznZEcfvp39Vv78mGkj49BAtqeekvJmkLPKdnZ6kMYWtRZTEAcubhbN6mXF/PlbQVNlS3W6XHLkglijXi/g=
X-Received: by 2002:a17:907:3101:b0:9c5:844f:a7f4 with SMTP id
 wl1-20020a170907310100b009c5844fa7f4mr11483593ejb.35.1701237927645; Tue, 28
 Nov 2023 22:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126015045.1092826-1-andreimatei1@gmail.com> <20231126015045.1092826-2-andreimatei1@gmail.com>
In-Reply-To: <20231126015045.1092826-2-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 22:05:15 -0800
Message-ID: <CAEf4BzacRRwzdQH8LuQkV695=rm65jnv1bX2n9gks6G+wGAw6w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 5:53=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> Privileged programs are supposed to be able to read uninitialized stack
> memory (ever since 6715df8d5) but, before this patch, these accesses
> were permitted inconsistently. In particular, accesses were permitted
> above state->allocated_stack, but not below it. In other words, if the
> stack was already "large enough", the access was permitted, but
> otherwise the access was rejected instead of being allowed to "grow the
> stack". This undesired rejection was happening in two places:
> - in check_stack_slot_within_bounds()
> - in check_stack_range_initialized()
> This patch arranges for these accesses to be permitted.
>
> This patch also fixes the tracking of the stack size for variable-offset
> reads. This second fix is bundled in the same commit as the first one
> because they're inter-related. Before this patch, writes to the stack
> using registers containing a variable offset (as opposed to registers
> with fixed, known values) were not properly contributing to the
> function's needed stack size. As a result, it was possible for a program
> to verify, but then to attempt to read out-of-bounds data at runtime
> because a too small stack had been allocated for it.
>
> Each function tracks the size of the stack it needs in
> bpf_subprog_info.stack_depth, which is maintained by
> update_stack_depth(). For regular memory accesses, check_mem_access()
> was calling update_state_depth() but it was passing in only the fixed
> part of the offset register, ignoring the variable offset. This was
> incorrect; the minimum possible value of that register should be used
> instead.
>
> This tracking is now fixed by centralizing the tracking of stack size in
> grow_stack_state(), and by lifting the calls to grow_stack_state() to
> check_stack_access_within_bounds() as suggested by Andrii. The code is
> now simpler and more convincingly tracks the correct maximum stack size.
> check_stack_range_initialized() can now rely on enough stack having been
> allocated for the access; this helps with the fix for the first issue.
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=3D1qbuZUi20tGoUXoU0=
7FPf-5FLvhOKOY+Q@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |  4 ++
>  kernel/bpf/verifier.c                         | 70 ++++++++-----------
>  .../selftests/bpf/progs/test_global_func16.c  |  2 +-
>  .../bpf/progs/verifier_basic_stack.c          |  6 +-
>  .../selftests/bpf/progs/verifier_int_ptr.c    |  2 +-
>  .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
>  .../selftests/bpf/progs/verifier_var_off.c    |  4 +-
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
>  tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
>  9 files changed, 42 insertions(+), 61 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index aa4d19d0bc94..5fc389e8be35 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -630,6 +630,10 @@ struct bpf_verifier_env {
>         int exception_callback_subprog;
>         bool explore_alu_limits;
>         bool allow_ptr_leaks;
> +       /* Allow access to uninitialized stack memory. Writes with fixed =
offset are
> +        * always allowed, so this refers to reads (with fixed or variabl=
e offset),
> +        * to writes with variable offset and to indirect (helper) access=
es.
> +        */
>         bool allow_uninit_stack;
>         bool bpf_capable;
>         bool bypass_spec_v1;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af2819d5c8ee..f9546dd73f3c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1685,10 +1685,12 @@ static int resize_reference_state(struct bpf_func=
_state *state, size_t n)
>         return 0;
>  }
>
> -static int grow_stack_state(struct bpf_func_state *state, int size)
> +/* Possibly update state->allocated_stack to be at least size bytes. Als=
o
> + * possibly update the function's high-water mark in its bpf_subprog_inf=
o.
> + */
> +static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_fun=
c_state *state, int size)
>  {
>         size_t old_n =3D state->allocated_stack / BPF_REG_SIZE, n =3D siz=
e / BPF_REG_SIZE;

shouldn't this be rounding up? (size + BPF_REG_SIZE - 1) / BPF_REG_SIZE?

> -

According to kernel code style, there should be an empty line between
variable declaration and other statements. Please keep this empty
line.

>         if (old_n >=3D n)
>                 return 0;
>

[...]

> @@ -6761,13 +6748,15 @@ static int check_ptr_to_map_access(struct bpf_ver=
ifier_env *env,
>   * The minimum valid offset is -MAX_BPF_STACK for writes, and
>   * -state->allocated_stack for reads.
>   */
> -static int check_stack_slot_within_bounds(int off,
> -                                         struct bpf_func_state *state,
> -                                         enum bpf_access_type t)
> +static int check_stack_slot_within_bounds(
> +               struct bpf_verifier_env *env,
> +               int off,
> +               struct bpf_func_state *state,
> +               enum bpf_access_type t)

nit: please keep code style, first argument is normally on the same
line as opening parenthesis

>  {
>         int min_valid_off;
>
> -       if (t =3D=3D BPF_WRITE)
> +       if (t =3D=3D BPF_WRITE || env->allow_uninit_stack)
>                 min_valid_off =3D -MAX_BPF_STACK;
>         else
>                 min_valid_off =3D -state->allocated_stack;

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools=
/testing/selftests/bpf/progs/verifier_var_off.c
> index 83a90afba785..bbf3628c625a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -61,7 +61,7 @@ __naked void stack_read_priv_vs_unpriv(void)
>
>  SEC("lwt_in")
>  __description("variable-offset stack read, uninitialized")
> -__failure __msg("invalid variable-offset read from stack R2")
> +__success
>  __naked void variable_offset_stack_read_uninitialized(void)
>  {
>         asm volatile ("                                 \
> @@ -255,7 +255,7 @@ __naked void access_min_out_of_bound(void)
>
>  SEC("lwt_in")
>  __description("indirect variable-offset stack access, min_off < min_init=
ialized")
> -__failure __msg("invalid indirect read from stack R2 var_off")
> +__success

as Eduard mentioned, can you please try updating program type to
something that is allowed in unprivileged mode, e.g., SEC("socket")
and make sure that it still fails in unpriv mode

>  __naked void access_min_off_min_initialized(void)
>  {
>         asm volatile ("                                 \

[...]

