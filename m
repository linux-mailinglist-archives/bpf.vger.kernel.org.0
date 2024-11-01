Return-Path: <bpf+bounces-43783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622CA9B994D
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EDB1C21543
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B81D0E15;
	Fri,  1 Nov 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwIWy1Tb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE814D2A3
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492298; cv=none; b=m7DoIuhp6tTCsf9GSQLlqyyy6j3lCCvdptzccfxocBFkopD2uRPagtNeXq49JQaaKhuW0LJu6+nXh2zh2hZlG7xumHvhEDbqRGJXT0LCU1bXMGhlwnKCipinAaJb8elkB9+OJF4JncATB/JJvNT7jkxIVCzcQbG6OD1+I50c0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492298; c=relaxed/simple;
	bh=/wxjfjT2RcIU/4fkGCK8GA5jEZPo732lHH8nuP9yRHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY0BF+EQl2PBGi7SgHYPVKDYGt0le+TKRQyHcmfsIs7AmJSHPfGCjC2hMyh5YdxVDxJrslkAZnYgRS5RXZc787av4JNvJRQ5BexuqjShdfWPC9knSBkPFdZtxV3NXRmL1TRmWc2wEWpKHkIXljIZvPRTf0sh8w99lHG2+2T+DBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwIWy1Tb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso3924003e87.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730492294; x=1731097094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMeso5GguPbZetI8lu/6aggkHG7VjsGsfRzK6pYVvc4=;
        b=FwIWy1TbwVT3ti+GG0W/YSiXhON01zvD3rJWkq4/jIS4tqBJzz0y/RyJZhWXDakI6F
         c5tWTNSvnQAk/J5aXq1UccCmHvs6ScBIww/wZ1DDUldDJvSWsRw7OL+uXZFXnqUUeMUF
         M5aO/x4OJxjCtEEAW45NS03AW4sE1FULBkOo9q3nCx8+HhXY/0Ayd/HuzMuHirZGoEjv
         aBjvtQRDsfh/Y5ACPpKgrhFjLVYuj/c9+7gSydNPkcfXLHX3oaAv04JPIV/WxSktjf8O
         8TcXV/uWmMRyv2X29+YlNhh4j4m0rxOqgdZnBjE1Fqa1YMTDez69C8vYw4XmD30FYK7B
         ASjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492294; x=1731097094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMeso5GguPbZetI8lu/6aggkHG7VjsGsfRzK6pYVvc4=;
        b=KBhCwAnsanfyF0Fkx/TQ19Bz3QX6AatMoDdQ+KJgKum9d9r7/hqbSQ9s2E68R4i0du
         n2lWWfRiOqjSzQCg0dQ6FJlCpVBFGBp0lAn7jMInXgI5uOSRAYve3L/n9wLBKpD+rnyy
         3D1MT87BiMIBXBYZEkLaIyehxTQD+4DJC39q/b4WlVBcgG6WZUlvkNd/nFBeRJ5cbyUH
         CkeQsOkavISRbh+gbwBPzZkkunSGQdr78mUTSloluNl2gqsM7dz283e2cBu8nL8sVxuJ
         JtKV+owHrlFmBbbDZqkQdAoxl8DBE4JNkkho4f3G4n1MPxzUCRJ8zEwQmnyP/oaBCo4+
         t7+w==
X-Gm-Message-State: AOJu0Ywa/H6mhhbagZptbE7C8r1ns78Q8qXTZkXe7VVuZ6kjXvLRNmIR
	WjxHRGlMMvjmhalTdatnwPAQcnTqIb+vVz5rCyPx6GeFAkhkCMQgZ5dYm2bFzuJFn/Su1NjXAtr
	dZMwsXuc9hhTInKOHPOILT4yXl45vt3yC
X-Google-Smtp-Source: AGHT+IG9wzWBwgKvumT34+RKMdWVU+QVgQSuFqg31gPeIz/s9jSDXyiHnCEgyZKvixev8q8B3v6lhgmrw5VoL3eJpRc=
X-Received: by 2002:a05:6512:12c8:b0:52c:d819:517e with SMTP id
 2adb3069b0e04-53b348e2efbmr12703835e87.30.1730492293992; Fri, 01 Nov 2024
 13:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101030950.2677215-1-yonghong.song@linux.dev> <20241101031011.2679361-1-yonghong.song@linux.dev>
In-Reply-To: <20241101031011.2679361-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 13:18:03 -0700
Message-ID: <CAADnVQ+3XKiR4YNjZUbZd-UA8pcc697m0-D9x_oNTjo2iCd6QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/9] bpf: Allocate private stack for eligible
 main prog or subprogs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:10=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> For any main prog or subprogs, allocate private stack space if requested
> by subprog info or main prog. The alignment for private stack is 16
> since maximum stack alignment is 16 for bpf-enabled archs.
>
> For x86_64 arch, the allocated private stack is freed in arch specific
> implementation of bpf_jit_free().
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c |  1 +
>  include/linux/bpf.h         |  1 +
>  kernel/bpf/core.c           | 10 ++++++++++
>  kernel/bpf/verifier.c       | 12 ++++++++++++
>  4 files changed, 24 insertions(+)
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

I'm 99% certain there are memory leaks when free and alloc
are imbalanced like this:
arch code doing free while generic code doing alloc.

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
> index 14d9288441f2..6905f250738b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2396,6 +2396,7 @@ static void bpf_prog_select_func(struct bpf_prog *f=
p)
>   */
>  struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  {
> +       void __percpu *priv_stack_ptr;
>         /* In case of BPF to BPF calls, verifier did all the prep
>          * work with regards to JITing, etc.
>          */
> @@ -2421,6 +2422,15 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
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

what happens if this jit_compile fails?
Which part will free priv_stack_ptr?
I suspect it's a memory leak.

>                 bpf_prog_jit_attempt_done(fp);
>                 if (!fp->jited && jit_needed) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 596afd29f088..30e74db6a85f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20080,6 +20080,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>  {
>         struct bpf_prog *prog =3D env->prog, **func, *tmp;
>         int i, j, subprog_start, subprog_end =3D 0, len, subprog;
> +       void __percpu *priv_stack_ptr;
>         struct bpf_map *map_ptr;
>         struct bpf_insn *insn;
>         void *old_bpf_func;
> @@ -20176,6 +20177,17 @@ static int jit_subprogs(struct bpf_verifier_env =
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
> --
> 2.43.5
>

