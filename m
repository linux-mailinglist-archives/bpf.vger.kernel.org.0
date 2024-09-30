Return-Path: <bpf+bounces-40580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBB98A776
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50447B2476E
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7469192B6E;
	Mon, 30 Sep 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAChLzLK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D81922E5
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707357; cv=none; b=WEFx5OvsysVUiwB2WcMO+uzX31vgDNaajASGsyOyWQUFVtfTJKDWNt+fVyo7OJXMI9xQQL6HB0A741UuL+nXBZcvS2pW4V/IyzSB49cXKMYggbuTjIYYJ0RMUBPidAxRHAKKza+wnAZ82+V/oNf21GUnERI2JjcCvnU4rEdhNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707357; c=relaxed/simple;
	bh=WvGErlw9UI+2PXmPdtk8TdOlW9ZEu/5pSdUPSy7XMEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFzYx00z/nShye2PtwGW+an5Mb3qwwSu687Aihc2zTinTSikNJ2puNbShXuWs8tRSZ0PfmONRPZ6xKDFiaA0X10MXvgs4c6DVsGwZFDqIAJ9adEUXuNAyehpYqXT4vvPAq9h+nO9YayIFOHXijo0BPMPZMySvp0LWDglfXO4+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAChLzLK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so32624715e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707354; x=1728312154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcRSTp+KHcdgB1YDIkAhWniFdGhnRkZKpY6n4wGhSPQ=;
        b=OAChLzLKiQbhGZIFs1BGnnHIIkVmRetRfxOL+VqNI3y7FbjNBVWN7Ci8i9lSNwtnxa
         HoRmwjb7SodKFF/+TSnSwnIxbnpValJFPshYSNm8CB7LsuqATqIVCjIO50RSQrLd/e7v
         fLna+fnaG/QVwsWN4Vmv2fvU3URJv6Myd25qHfT196L2phVz/iS3E5eat3pc4q5nxLRu
         vbwO/rvKiyfnZmBY6mgkoPjMpJPQadRcI107Zh0JKVWWp4sAR1P8mctUR/xjVoZoR4WQ
         FNKNomwHOhj6Mtb2iWRnbU5ieydBCOOCC5zNFXzrf6vcyFhwcFBkVclddLBSU6ivdScG
         E2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707354; x=1728312154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcRSTp+KHcdgB1YDIkAhWniFdGhnRkZKpY6n4wGhSPQ=;
        b=G3TvBeyj/JN21DFYaYWjDp8Ns49cGUvujzDulBidzSuT+fkoITVywcGv91190PFIZf
         Jhlkkf3Ya7oWHOLExXZ9cl0wChxyRwuAcGdIyh0F3h6j0bcvU6xqGE9E2gooOLkX7vKW
         UyvsAuEpq4ZcD8PXlAYbLDd8U9iqkGmFLfe+mqwZOe2ldX/NoR11EWmC2ozEHrmzU3ZY
         hjkBMifbT/D6MjD8rKho80/D6OEhSwDbecYWJ49LAn9FiOUcostWuVSY32Ha/5y2DbEZ
         +gULZqcjR17Fjl8RwhRQj+WbUk3IwTg73iwufWiwyuQFgjuOGE4V4lB5HxWs1KH7Qkxd
         jU6A==
X-Gm-Message-State: AOJu0Yzco9e6m1cjUMrCXAfrBtvzp6FqU7F9M2f2UPilaguoDZQWLmJ2
	ZenhKZ6T4i0ge2AbgOXxt9SxREsvZjZwUtLRZ5izZ18BO+WIrrkNsswX786SVsWReBj0Vh4Ydzy
	mHt7xIdTPXETM/uwOU8WDLvTKLlw=
X-Google-Smtp-Source: AGHT+IHmjKV6mcD2tNMt8CJ+A9mGxh9QMws6OghxFD72Th4+ZnCvfqogUWmlfHqqnQRBz8/QZea8UgnEV5iLIX7aQWA=
X-Received: by 2002:a05:600c:35cd:b0:426:6ed5:d682 with SMTP id
 5b1f17b1804b1-42f58415f75mr87905235e9.12.1727707353538; Mon, 30 Sep 2024
 07:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev> <20240926234516.1770154-1-yonghong.song@linux.dev>
In-Reply-To: <20240926234516.1770154-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 07:42:22 -0700
Message-ID: <CAADnVQJ4XQLH_UDXEAARn+2vt5Ak179_vPX44D+8YewZhkkp0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Collect stack depth information
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:45=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Private stack memory allocation is based on call subtrees. For example,
>
>   main_prog     // stack size 50
>     subprog1    // stack size 50
>       subprog2  // stack size 50
>     subprog3    // stack size 50
>
> Overall allocation size should be 150 bytes (stacks from main_prog,
> subprog1 and subprog2).
>
> To simplify jit, the root of subtrees is either the main prog
> or any callback func. For example,
>
>   main_prog
>     subprog1    // callback subprog10
>       ...
>         subprog10
>           subprog11

This is an odd example.
We have MAX_CALL_FRAMES =3D 8
So there cannot be more than 512 * 8 =3D 4k of stack.

>
> In this case, two subtrees exist. One root is main_prog and the other
> root is subprog10.
>
> The private stack is used only if
>  - the subtree stack size is greater than 128 bytes and
>    smaller than or equal to U16_MAX, and

U16 limit looks odd too.
Since we're not bumping MAX_CALL_FRAMES at the moment
let's limit to 4k.

>  - the prog type is kprobe, tracepoint, perf_event, raw_tracepoint
>    and tracing, and
>  - jit supports private stack, and
>  - no tail call in the main prog and all subprogs
>
> The restriction of no tail call is due to the following two reasons:
>  - to avoid potential large memory consumption. Currently maximum tail
>    call count is MAX_TAIL_CALL_CNT=3D33. Considering private stack memory
>    allocation is per-cpu based. It will be a very large memory consumptio=
n
>    to support current MAX_TAIL_CALL_CNT.
>  - if the tailcall in the callback function, it is not easy to pass
>    the tail call cnt to the callback function and the tail call cnt
>    is needed to find proper offset for private stack.
> So to avoid complexity, private stack does not support tail call
> for now.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h          |  3 +-
>  include/linux/bpf_verifier.h |  3 ++
>  kernel/bpf/verifier.c        | 81 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 62909fbe9e48..156b9516d9f6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1566,7 +1566,8 @@ struct bpf_prog {
>                                 call_get_stack:1, /* Do we call bpf_get_s=
tack() or bpf_get_stackid() */
>                                 call_get_func_ip:1, /* Do we call get_fun=
c_ip() */
>                                 tstamp_type_access:1, /* Accessed __sk_bu=
ff->tstamp_type */
> -                               sleepable:1;    /* BPF program is sleepab=
le */
> +                               sleepable:1,    /* BPF program is sleepab=
le */
> +                               pstack_eligible:1; /* Candidate for priva=
te stacks */

I'm struggling with this abbreviation.
pstack is just too ambiguous.
It means 'pointer stack' in perf.
'man pstack' means 'print stack of a process'.
Let's use something more concrete.

How about priv_stack ?
And use it this way in all other names.
Instead of:
calc_private_stack_alloc_subprog
do:
calc_priv_stack_alloc_subprog

>         enum bpf_prog_type      type;           /* Type of BPF program */
>         enum bpf_attach_type    expected_attach_type; /* For some prog ty=
pes */
>         u32                     len;            /* Number of filter block=
s */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4513372c5bc8..63df10f4129e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -659,6 +659,8 @@ struct bpf_subprog_info {
>          * are used for bpf_fastcall spills and fills.
>          */
>         s16 fastcall_stack_off;
> +       u16 subtree_stack_depth;
> +       u16 subtree_top_idx;
>         bool has_tail_call: 1;
>         bool tail_call_reachable: 1;
>         bool has_ld_abs: 1;
> @@ -668,6 +670,7 @@ struct bpf_subprog_info {
>         bool args_cached: 1;
>         /* true if bpf_fastcall stack region is used by functions that ca=
n't be inlined */
>         bool keep_fastcall_stack: 1;
> +       bool pstack_eligible:1;
>
>         u8 arg_cnt;
>         struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 97700e32e085..69e17cb22037 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
>
>  #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
>
> +#define BPF_PSTACK_MIN_SUBTREE_SIZE    128
> +
>  static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
>  static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> @@ -6192,6 +6194,82 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
>         return 0;
>  }
>
> +static int calc_private_stack_alloc_subprog(struct bpf_verifier_env *env=
, int idx)
> +{
> +       struct bpf_subprog_info *subprog =3D env->subprog_info;
> +       struct bpf_insn *insn =3D env->prog->insnsi;
> +       int depth =3D 0, frame =3D 0, i, subprog_end;
> +       int ret_insn[MAX_CALL_FRAMES];
> +       int ret_prog[MAX_CALL_FRAMES];
> +       int ps_eligible =3D 0;
> +       int orig_idx =3D idx;
> +
> +       subprog[idx].subtree_top_idx =3D idx;
> +       i =3D subprog[idx].start;
> +
> +process_func:
> +       depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
> +       if (depth > U16_MAX)
> +               return -EACCES;
> +
> +       if (!ps_eligible && depth >=3D BPF_PSTACK_MIN_SUBTREE_SIZE) {
> +               subprog[orig_idx].pstack_eligible =3D true;
> +               ps_eligible =3D true;
> +       }
> +       subprog[orig_idx].subtree_stack_depth =3D
> +               max_t(u16, subprog[orig_idx].subtree_stack_depth, depth);
> +
> +continue_func:
> +       subprog_end =3D subprog[idx + 1].start;
> +       for (; i < subprog_end; i++) {
> +               int next_insn, sidx;
> +
> +               if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn +=
 i))
> +                       continue;
> +               /* remember insn and function to return to */
> +               ret_insn[frame] =3D i + 1;
> +               ret_prog[frame] =3D idx;
> +
> +               /* find the callee */
> +               next_insn =3D i + insn[i].imm + 1;
> +               sidx =3D find_subprog(env, next_insn);
> +               if (subprog[sidx].is_cb) {
> +                       if (!bpf_pseudo_call(insn + i))
> +                               continue;
> +               }
> +               i =3D next_insn;
> +               idx =3D sidx;
> +               subprog[idx].subtree_top_idx =3D orig_idx;
> +
> +               frame++;
> +               goto process_func;
> +       }
> +       if (frame =3D=3D 0)
> +               return ps_eligible;
> +       depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
> +       frame--;
> +       i =3D ret_insn[frame];
> +       idx =3D ret_prog[frame];
> +       goto continue_func;
> +}

This looks very similar to check_max_stack_depth_subprog()
Can you share the code?

