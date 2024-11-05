Return-Path: <bpf+bounces-43983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD609BC2B6
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C89B2134C
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65B1CF96;
	Tue,  5 Nov 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU3XVIMC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE80A94A
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770714; cv=none; b=EytPqqP8VTFMMv2EwACwuy5S1BcdD4tz0y1p89kPn6vFtxuaX5PnvZYNpqya9P5xbpBQhgj4QtxVfK6uA6vQb0zB3TFgbGHYaNW1OFfsiHeh2mktQeJHSlO9cv69a/759vt+jU9vPD48nQHlwKT6h6a9tA2pgQHgQwdUh4KgRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770714; c=relaxed/simple;
	bh=QyLvEyD6a0QgkQ4WPc+bMV/5yLsIJIDI28spRDsN8xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKbVdGoWpIh0LLbXnLD1DkMR364gDWJd2QlWi/Ib7o75tMArqy9qA12VU9AGiWqlvu6Tq9OoNOUwXnLW9rIK0jrK59eavs2gKR2uOL7pS+OwC/61Ao1tw6abyd+vaBfjNuIFHzdt4vN2vCcU+hUNF8h/i204qG3wYrbfJy5GYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU3XVIMC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so43332375e9.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 17:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730770711; x=1731375511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO9wGHtKXaSEl1qDcRgKUm5VcQdWbekiIJV8PR3hLNM=;
        b=PU3XVIMCd4WN3oFrJSzc5YTT+1EGapXhr+BTeWOw3SajUzMm86awTr8ZEZjhjfxrmJ
         c9UIajctiZkgTgu+1H21FFKOII+oTmZJnhoGhJ7xUWPOc3LxeweoRT1h1wI0Vf+zPqq9
         iNXlcFC9WMVjA3wQKu/2666NS42qfNuCcQH2SqX4lolowtZBaW8KiN5IMY6DG+JZwk1c
         fJLj/je8MaS22+WCyF0dQ1tub9ICOuYFjNjUrYZ5dxbH2vPYCqtlrVlQdnm2jKLkWAG2
         o1kYJnWzjLfO0T+wFT9TUIKGEH+jn2hker2Mx4KTHOcdQQg5Vn/ZnKBjJMwgUkhI3pyv
         DiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730770711; x=1731375511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO9wGHtKXaSEl1qDcRgKUm5VcQdWbekiIJV8PR3hLNM=;
        b=eSzrcxCfKFJa0tOK3HQ9/N3V1ua8TfHACHgUuAo6Pr0sVfzs8fRjMHu7NlRFdlqODQ
         QbeczcOBGt27FEpDyK7WWsd6IOArWfJ10Yi34IThT8VvpOt3Z33FXt5W2XnVLYk1dHMd
         nbP+H1rtRU4CvAzOJsATksb3aAIVumz82K5VqxV9uMHtOamCJJdyat+k7pabrfvpMndu
         PQrBB2OVkrGxOTuhjiD/IpHsd1SoK1FLsU2r6K1185ytAJ8FCyIT4jzFRY5/POrbKw30
         YARMSOv6N5Dg/3ZVU4CchiIYpDgCoJyobD5TI+bT+ur5jx6U4JygaTFqmTB1GTS3T/lC
         3h+w==
X-Gm-Message-State: AOJu0Yx+5tflzGlcUCILVD74koAIdCAALrALLpXSvPFNnM2UAgPE0qnl
	DoZGRgOCcE7z1b2p7hagu9q7KBesv4CL8aFksHevvV9dS84lYZY/Aw3sFdyBFyMZlo/Mv6EY7UC
	fM+BAsHDkaInqKW2RFVc6W1rlfllZUExw
X-Google-Smtp-Source: AGHT+IHC/C77XbhtVjaCKPsPVPwj3F8YJ4J7M2AdulOitvxPUJFsuRMoOGkVT/t1EfsF6gFNpl5YexKn8Pq9r2T6ZO8=
X-Received: by 2002:a05:6000:4009:b0:37d:453f:4469 with SMTP id
 ffacd0b85a97d-381be7c7931mr16239779f8f.22.1730770710442; Mon, 04 Nov 2024
 17:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev> <20241104193521.3243984-1-yonghong.song@linux.dev>
In-Reply-To: <20241104193521.3243984-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 17:38:19 -0800
Message-ID: <CAADnVQ+RGgtLtoc_ODv54gt0donCdd_4sLWS1oWA_nGStjb1KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 05/10] bpf: Allocate private stack for
 eligible main prog or subprogs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:38=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> For any main prog or subprogs, allocate private stack space if requested
> by subprog info or main prog. The alignment for private stack is 16
> since maximum stack alignment is 16 for bpf-enabled archs.
>
> If jit failed, the allocated private stack will be freed in the same
> function where the allocation happens. If jit succeeded, e.g., for
> x86_64 arch, the allocated private stack is freed in arch specific
> implementation of bpf_jit_free().
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c |  1 +
>  include/linux/bpf.h         |  1 +
>  kernel/bpf/core.c           | 19 ++++++++++++++++---
>  kernel/bpf/verifier.c       | 13 +++++++++++++
>  4 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..59d294b8dd67 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3544,6 +3544,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>                 prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offse=
t();
>                 hdr =3D bpf_jit_binary_pack_hdr(prog);
>                 bpf_jit_binary_pack_free(hdr, NULL);
> +               free_percpu(prog->aux->priv_stack_ptr);
>                 WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
>         }
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8db3c5d7404b..8a3ea7440a4a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1507,6 +1507,7 @@ struct bpf_prog_aux {
>         u32 max_rdwr_access;
>         struct btf *attach_btf;
>         const struct bpf_ctx_arg_aux *ctx_arg_info;
> +       void __percpu *priv_stack_ptr;
>         struct mutex dst_mutex; /* protects dst_* pointers below, *after*=
 prog becomes visible */
>         struct bpf_prog *dst_prog;
>         struct bpf_trampoline *dst_trampoline;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 14d9288441f2..f7a3e93c41e1 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2396,6 +2396,7 @@ static void bpf_prog_select_func(struct bpf_prog *f=
p)
>   */
>  struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  {
> +       void __percpu *priv_stack_ptr =3D NULL;
>         /* In case of BPF to BPF calls, verifier did all the prep
>          * work with regards to JITing, etc.
>          */
> @@ -2421,11 +2422,23 @@ struct bpf_prog *bpf_prog_select_runtime(struct b=
pf_prog *fp, int *err)
>                 if (*err)
>                         return fp;
>
> +               if (fp->aux->use_priv_stack && fp->aux->stack_depth) {
> +                       priv_stack_ptr =3D __alloc_percpu_gfp(fp->aux->st=
ack_depth, 16, GFP_KERNEL);
> +                       if (!priv_stack_ptr) {
> +                               *err =3D -ENOMEM;
> +                               return fp;
> +                       }
> +                       fp->aux->priv_stack_ptr =3D priv_stack_ptr;
> +               }
> +
>                 fp =3D bpf_int_jit_compile(fp);
>                 bpf_prog_jit_attempt_done(fp);
> -               if (!fp->jited && jit_needed) {
> -                       *err =3D -ENOTSUPP;
> -                       return fp;
> +               if (!fp->jited) {
> +                       free_percpu(priv_stack_ptr);
> +                       if (jit_needed) {
> +                               *err =3D -ENOTSUPP;
> +                               return fp;
> +                       }
>                 }
>         } else {
>                 *err =3D bpf_prog_offload_compile(fp);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e01b3f0fd314..03ae76d57076 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20073,6 +20073,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>  {
>         struct bpf_prog *prog =3D env->prog, **func, *tmp;
>         int i, j, subprog_start, subprog_end =3D 0, len, subprog;
> +       void __percpu *priv_stack_ptr;
>         struct bpf_map *map_ptr;
>         struct bpf_insn *insn;
>         void *old_bpf_func;
> @@ -20169,6 +20170,17 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>
>                 func[i]->aux->name[0] =3D 'F';
>                 func[i]->aux->stack_depth =3D env->subprog_info[i].stack_=
depth;
> +
> +               if (env->subprog_info[i].use_priv_stack && func[i]->aux->=
stack_depth) {
> +                       priv_stack_ptr =3D __alloc_percpu_gfp(func[i]->au=
x->stack_depth, 16,
> +                                                           GFP_KERNEL);
> +                       if (!priv_stack_ptr) {
> +                               err =3D -ENOMEM;
> +                               goto out_free;
> +                       }
> +                       func[i]->aux->priv_stack_ptr =3D priv_stack_ptr;
> +               }
> +
>                 func[i]->jit_requested =3D 1;
>                 func[i]->blinding_requested =3D prog->blinding_requested;
>                 func[i]->aux->kfunc_tab =3D prog->aux->kfunc_tab;
> @@ -20201,6 +20213,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>                         func[i]->aux->exception_boundary =3D env->seen_ex=
ception;
>                 func[i] =3D bpf_int_jit_compile(func[i]);
>                 if (!func[i]->jited) {
> +                       free_percpu(func[i]->aux->priv_stack_ptr);
>                         err =3D -ENOTSUPP;
>                         goto out_free;
>                 }

Looks correct from leaks pov, but this is so hard to follow.
I still don't like this imbalanced alloc/free.
Either both need to be done by core or both by JIT.

And JIT is probably better, since in:
_alloc_percpu_gfp(func[i]->aux->stack_depth, 16

16 alignment is x86 specific.

