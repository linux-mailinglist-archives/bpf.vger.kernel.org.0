Return-Path: <bpf+bounces-43777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3C9B98E2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3401F2225B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD571D0BA4;
	Fri,  1 Nov 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbGrqDVh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB751CACF2
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490434; cv=none; b=CNrd6/sgb3uonvye/GmnWHZ5L3MhIZnJ3gbHobbTpaB870kEmNTkW8lGQiy62oAZ7n1ng8Ybezo1vL/VYaU6vqV1M2rawSr/BCjgEC+WuANj9Yvyr1SKTDaHaXUSLB2VdLl4ZLZrIK3odT2Y44xwt47S+XcpK7NePwRw/39M4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490434; c=relaxed/simple;
	bh=ayhGUVdU93QuoBzkHuCQMta5+pjYzeb3JoVbru3fBLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOvmWjk72Hp56Rd8dCMmbOWdEQAjjIaywU0JA5jxcKEMeXmsK1BdpFw61MiYb/GidJAmMXLTC7c4hO1kYWesa+qF4OT/XZzmyB40A8u4vDQbhMdXTpKYisyHukQVnNaug+lPdk1Tld/c9HQIOnQsrdbG2uBAAFHZABzHm+9RSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbGrqDVh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so17935945e9.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730490430; x=1731095230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AQHglOKIRelJOR6XcY/nJ8dF2q2ea+4YqDXWhtEzgg=;
        b=FbGrqDVh7ln4TsYJ/qM3fhgZDwAezpUFxH8suK0paRkuq3QIm/rPf1UqD8rjmxOcEQ
         EtmccHmIRPEMiOUkPZqwTwrXXN+PM8xjzAyZ0TTClibjp7F6Sabe1hp+Aeoh6Xx8j8+l
         ehG4uJxfJ63SkrEnx7G/WmN2JQiXosG7Rr4BJhXdVuCbq5svA6Vuz1RqfbKeDn11PFU/
         rwiWIMu6O6I4SQjHQQ+9wI5QI2qt01Uo2RVZlHbPxBFHZ5tSzv07cONcP3vCHoa9JeMU
         mFGa/OxKlSxWMka9PYBJcB+vJe2Ugtp7jdxKGK/81CA7XkQpDC9uBen/6KM5g5WQscBO
         qCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490430; x=1731095230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AQHglOKIRelJOR6XcY/nJ8dF2q2ea+4YqDXWhtEzgg=;
        b=YI3Uazel/7aCXobP3cc+4m8DKfZ9J9oXcgdu8T8fc4ougcV/04zGz9EshghZbTpWQq
         NW9rOgW+DjGqCmaI2J6cO2/7Haw1WxaPtYTCCdhCKiS8X3BG8MavxGfivKsVSRZFcb/D
         01tfBaJPlRnUnApMVha/CPTJ7vjCVeQgSKwhWyJcL1f1P8EP01J0/rdFFS2c/PEtvVGl
         ntybKmmWvDp5NFb1+i26KUeEPy20ePox2pvtJTCgLj5x4SgEUvWDf8EdJJZHN0Q5+iDG
         Oig7yaA5UxkGa9DfJOt79FkMO35EbuJm4TM5G4umLYhaqXLoJ8gpe/kbERMFsIn2mGhV
         WB9A==
X-Gm-Message-State: AOJu0YyZRsohs6d5l31/IsQKvjmek15wswQkG7nWv+NyrfQewf3M8u5M
	zebV/YffJJD8p7vRQ/DZOJL3SyXd4SEKqM6VLTVqf/2+746cyYecZNbn3DvF+8K3lxoPJLD7FPG
	57GKCvaBsLAJdZXet1e4sEIvhIIc=
X-Google-Smtp-Source: AGHT+IGAQrMVSp66qs9DNywuMnN1WDsXxFqO2TXklIjwJISBrAkN2eWvuBU+isclSkbgcTivS7MYIDp6p6rQJexdymA=
X-Received: by 2002:a05:600c:4215:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-431bb9e6031mr101300645e9.33.1730490430076; Fri, 01 Nov 2024
 12:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101030950.2677215-1-yonghong.song@linux.dev> <20241101031000.2677657-1-yonghong.song@linux.dev>
In-Reply-To: <20241101031000.2677657-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 12:46:58 -0700
Message-ID: <CAADnVQL3ZrMPjt5exuvRD7_+fLvCzn_=3A9VXy7sbSFD2f09qA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/9] bpf: Allow private stack to have each
 subprog having stack size of 512 bytes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:12=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With private stack support, each subprog can have stack with up to 512
> bytes. The limit of 512 bytes per subprog is kept to avoid increasing
> verifier complexity since greater than 512 bytes will cause big verifier
> change and increase memory consumption and verification time.
>
> If private stack is supported and certain stack size threshold is reached=
,
> that subprog will have its own private stack allocated.
>
> In this patch, some tracing programs are allowed to use private
> stack since tracing prog may be triggered in the middle of some other
> prog runs. The supported tracing programs already have recursion check
> such that if the same prog is running on the same cpu again, the nested
> prog run will be skipped. This ensures bpf prog private stack is not
> over-written.
>
> Note that if any tail_call is called in the prog (including all subprogs)=
,
> then private stack is not used.
>
> Function bpf_enable_priv_stack() return values include NO_PRIV_STACK,
> PRIV_STACK_ADAPTIVE, PRIV_STACK_ALWAYS and negative errors. The
> NO_PRIV_STACK represents priv stack not enable, PRIV_STACK_ADAPTIVE for
> priv stack enabled with some conditions (e.g. stack size threshold), and
> PRIV_STACK_ALWAYS for priv stack always enabled. The negative error
> represents a verification failure. The PRIV_STACK_ALWAYS and negative err=
or
> will be used by later struct_ops progs.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h          |  1 +
>  include/linux/bpf_verifier.h |  1 +
>  include/linux/filter.h       |  1 +
>  kernel/bpf/core.c            |  5 +++
>  kernel/bpf/verifier.c        | 75 ++++++++++++++++++++++++++++++++----
>  5 files changed, 75 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c3ba4d475174..8db3c5d7404b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1523,6 +1523,7 @@ struct bpf_prog_aux {
>         bool exception_cb;
>         bool exception_boundary;
>         bool is_extended; /* true if extended by freplace program */
> +       bool use_priv_stack;
>         u64 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
>         struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
>         struct bpf_arena *arena;
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4513372c5bc8..bc28ce7996ac 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -668,6 +668,7 @@ struct bpf_subprog_info {
>         bool args_cached: 1;
>         /* true if bpf_fastcall stack region is used by functions that ca=
n't be inlined */
>         bool keep_fastcall_stack: 1;
> +       bool use_priv_stack: 1;
>
>         u8 arg_cnt;
>         struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 7d7578a8eac1..3a21947f2fd4 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1119,6 +1119,7 @@ bool bpf_jit_supports_exceptions(void);
>  bool bpf_jit_supports_ptr_xchg(void);
>  bool bpf_jit_supports_arena(void);
>  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
> +bool bpf_jit_supports_private_stack(void);
>  u64 bpf_arch_uaddress_limit(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
>  bool bpf_helper_changes_pkt_data(void *func);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 233ea78f8f1b..14d9288441f2 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3045,6 +3045,11 @@ bool __weak bpf_jit_supports_exceptions(void)
>         return false;
>  }
>
> +bool __weak bpf_jit_supports_private_stack(void)
> +{
> +       return false;
> +}
> +
>  void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip,=
 u64 sp, u64 bp), void *cookie)
>  {
>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 89b0a980d0f9..d3f4cbab97bc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
>
>  #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
>
> +#define BPF_PRIV_STACK_MIN_SIZE                64
> +
>  static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
>  static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> @@ -6015,6 +6017,40 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
>                                            strict);
>  }
>
> +#define NO_PRIV_STACK          0
> +#define PRIV_STACK_ADAPTIVE    1
> +#define PRIV_STACK_ALWAYS      2

Please use enum.

> +
> +static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
> +{
> +       struct bpf_subprog_info *si;
> +
> +       if (!bpf_jit_supports_private_stack())
> +               return NO_PRIV_STACK;
> +
> +       switch (env->prog->type) {
> +       case BPF_PROG_TYPE_KPROBE:
> +       case BPF_PROG_TYPE_TRACEPOINT:
> +       case BPF_PROG_TYPE_PERF_EVENT:
> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +               break;
> +       case BPF_PROG_TYPE_TRACING:
> +               if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
> +                       break;
> +               fallthrough;
> +       default:
> +               return NO_PRIV_STACK;
> +       }

Probably worth adding:
if (!bpf_prog_check_recur(env->prog))
   return NO_PRIV_STACK;

and remove case BPF_PROG_TYPE_TRACING entry
with comment that bpf_prog_check_recur() checks all prog types
that use bpf trampoline while kprobe/tp/raw_tp don't use trampoline
hence checked explicitly.

> +
> +       si =3D env->subprog_info;
> +       for (int i =3D 0; i < env->subprog_cnt; i++) {
> +               if (si[i].has_tail_call)
> +                       return NO_PRIV_STACK;
> +       }
> +
> +       return PRIV_STACK_ADAPTIVE;
> +}
> +
>  static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
>  {
>         if (env->prog->jit_requested)
> @@ -6033,11 +6069,12 @@ static int round_up_stack_depth(struct bpf_verifi=
er_env *env, int stack_depth)
>   * only needs a local stack of MAX_CALL_FRAMES to remember callsites
>   */
>  static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
> -                                        int *subtree_depth, int *depth_f=
rame)
> +                                        int *subtree_depth, int *depth_f=
rame,
> +                                        int priv_stack_supported)
>  {
>         struct bpf_subprog_info *subprog =3D env->subprog_info;
>         struct bpf_insn *insn =3D env->prog->insnsi;
> -       int depth =3D 0, frame =3D 0, i, subprog_end;
> +       int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
>         bool tail_call_reachable =3D false;
>         int ret_insn[MAX_CALL_FRAMES];
>         int ret_prog[MAX_CALL_FRAMES];
> @@ -6070,11 +6107,23 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>                         depth);
>                 return -EACCES;
>         }
> -       depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
> +       subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_de=
pth);
> +       depth +=3D subprog_depth;
>         if (depth > MAX_BPF_STACK && !*subtree_depth) {
>                 *subtree_depth =3D depth;
>                 *depth_frame =3D frame + 1;
>         }
> +       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> +               if (!subprog[idx].use_priv_stack) {
> +                       if (subprog_depth > MAX_BPF_STACK) {
> +                               verbose(env, "stack size of subprog %d is=
 %d. Too large\n",
> +                                       idx, subprog_depth);
> +                               return -EACCES;
> +                       }
> +                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
> +                               subprog[idx].use_priv_stack =3D true;
> +               }
> +       }
>  continue_func:
>         subprog_end =3D subprog[idx + 1].start;
>         for (; i < subprog_end; i++) {
> @@ -6174,19 +6223,29 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
>  {
>         struct bpf_subprog_info *si =3D env->subprog_info;
>         int ret, subtree_depth =3D 0, depth_frame;
> +       int priv_stack_supported;
> +
> +       priv_stack_supported =3D bpf_enable_priv_stack(env);
> +       if (priv_stack_supported < 0)
> +               return priv_stack_supported;

if it was enum, the compiler would have warned that the above is meaningles=
s.

>
>         for (int i =3D 0; i < env->subprog_cnt; i++) {
>                 if (!i || si[i].is_async_cb) {
> -                       ret =3D check_max_stack_depth_subprog(env, i, &su=
btree_depth, &depth_frame);
> +                       ret =3D check_max_stack_depth_subprog(env, i, &su=
btree_depth, &depth_frame,
> +                                                           priv_stack_su=
pported);
>                         if (ret < 0)
>                                 return ret;
>                 }
>         }
> -       if (subtree_depth > MAX_BPF_STACK) {
> -               verbose(env, "combined stack size of %d calls is %d. Too =
large\n",
> -                       depth_frame, subtree_depth);
> -               return -EACCES;
> +       if (priv_stack_supported =3D=3D NO_PRIV_STACK) {
> +               if (subtree_depth > MAX_BPF_STACK) {

no need for extra indent. Use:
if (priv_stack_supported =3D=3D NO_PRIV_STACK &&
    subtree_depth > MAX_BPF_STACK) {

> +                       verbose(env, "combined stack size of %d calls is =
%d. Too large\n",
> +                               depth_frame, subtree_depth);
> +                       return -EACCES;
> +               }
>         }
> +       if (si[0].use_priv_stack)
> +               env->prog->aux->use_priv_stack =3D true;
>         return 0;
>  }

pw-bot: cr

