Return-Path: <bpf+bounces-40582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2B98A7C3
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A3BB239AC
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A85193418;
	Mon, 30 Sep 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO4lB0dp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E519258B
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707767; cv=none; b=VUJ6YGFl4enbCuE53v7Vp0HZXOWHV8xyKl7a07bRM9NPd1FJoxZR28M58X7y4F6/RocT5orC78gGf16MSGozoDjF9sXPJFP3PUlUpBVFHLdLFEGpHV8OPhTYbseLOEzA3ePsEASNJqLt9umbESG3vkgWdHYGEopoZcbZhVTc/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707767; c=relaxed/simple;
	bh=JXf+JlsptORMKsxwhBaD6alV4G8sGpjQ1vEzSBDDqkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8ajRo9vo7V1KOMnmJNERNg6Dwuacdh3ZwsbTlYF4rGUgns3GKnHUbxeo/u1XaEfOpTg4hMNPLAOTa/VTgLv8UCoFdoknb+j5CgSn8vKcZwHEA1bjodVNEgH9hX2Ng/revH3XEKdjcIQbw1SXWDZ5sWNIeABsYDOrmPb8WVqrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO4lB0dp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso2248101f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707763; x=1728312563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0NUYUK8zjABobDwHzbu1IajnnRH1YzHK3ydd9laBmA=;
        b=GO4lB0dpj++2Ixh3gcCNfi8bHDKKWrxee8+jKOlqVQ6MdVxPnVTVPQA7mcvZZ7XAa1
         FiqAKCydQp5iUVw2lwYo2FwyxLF5plaUDR57rdXhmFNtSRtwqIN09SMzYf7OPxPzocjG
         tzEHfvd8TNjocZNOZOoGqk2L+EKsQmxVWSorecpK0uwL+3/Z2MyCqGq2gkfeNofCVQWM
         sCQww6k8DisTxH+ce6y+y6UzGZY42XTeIHrOS+2C5Xwf8k+ZtWyUeMlTUQydTvFCxc3A
         /UmzfGLPY9FlGmiX/KHHztfjPyBzT6BFftRKGFbPzVAyZRbeiS/6I0XqWJxwgJLo4adg
         S23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707763; x=1728312563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0NUYUK8zjABobDwHzbu1IajnnRH1YzHK3ydd9laBmA=;
        b=XjnnPEZMWmuyBDJ5TDnJ+vx7jsRiMhmEauT2dnGmNANGV41PPxGthXeixOZscQCLnL
         UNl96sQ1JdYj3jmOR5AyrKbQaMlWyvBAnH+Q3ol91+u1A16V5YrWA0oCNREq0qWwU3M3
         cOblQcmfOtNgctLE1UGUqNFDvxx4aRIioGhYsn6wTPA6Un0aufR+6TIGTmtSVhsJ/3uZ
         SaX1x9ZiNLrRR/Hp5fWPMHRShOeaYqw5K+RXkDm8FN8tLwL/tVgxbiM78E7LMuBKxjVY
         qV+fbAOGbwqwhvbr5pvq7NTkTBaHi9kzVO7dHHE6dqIi5+FSTIyP04J55YnSIz56FEY9
         CyJQ==
X-Gm-Message-State: AOJu0YzPFc12obmg1TYFyzP26A9XMG01lLnx09NfJovkdmsB+FlLbuNc
	KuhHJnaajvhbMXArkIyzs9RcHlct9eVnbMQnkaRm2sjbrd4nsEtMGMFxmSeTGS1981Drh+SzIuu
	TNNrQE49d+C/5Kc73+gvtsJO4qzKAAg==
X-Google-Smtp-Source: AGHT+IHPe6yCvr9hZUOOx68x0sPsfTvoAYIRiBmUEWtLoHSA6SODYDaVl/KaZK5V36vOCHW+T4kL+/3x5ekGc4KvQFI=
X-Received: by 2002:adf:e80f:0:b0:374:bd93:9bd4 with SMTP id
 ffacd0b85a97d-37cd5b07419mr7221140f8f.56.1727707763370; Mon, 30 Sep 2024
 07:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev> <20240926234521.1770481-1-yonghong.song@linux.dev>
In-Reply-To: <20240926234521.1770481-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 07:49:11 -0700
Message-ID: <CAADnVQ+BQ+hkpyyWKH+W-j4FbXmh1STycEEpeGfTxOnafSO8og@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Mark each subprog with proper pstack states
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:45=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Three private stack states are used to direct jit action:
>   PSTACK_TREE_NO:       do not use private stack
>   PSTACK_TREE_INTERNAL: adjust frame pointer address (similar to normal s=
tack)
>   PSTACK_TREE_ROOT:     set the frame pointer
>
> Note that for subtree root, even if the root bpf_prog stack size is 0,
> PSTACK_TREE_INTERNAL is still used. This is for bpf exception handling.
> More details can be found in subsequent jit support and selftest patches.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  9 +++++++++
>  kernel/bpf/core.c     | 19 +++++++++++++++++++
>  kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 156b9516d9f6..8f02d11bd408 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1550,6 +1550,12 @@ struct bpf_prog_aux {
>         };
>  };
>
> +enum bpf_pstack_state {
> +       PSTACK_TREE_NO,
> +       PSTACK_TREE_INTERNAL,
> +       PSTACK_TREE_ROOT,
> +};

The names could be improved and 'state' doesn't quite fit imo.
How about:
enum bpf_priv_stack_mode {
   NO_PRIV_STACK,
   PRIV_STACK_SUB_PROG,
   PRIV_STACK_MAIN_PROG,
};

> +
>  struct bpf_prog {
>         u16                     pages;          /* Number of allocated pa=
ges */
>         u16                     jited:1,        /* Is our filter JIT'ed? =
*/
> @@ -1570,15 +1576,18 @@ struct bpf_prog {
>                                 pstack_eligible:1; /* Candidate for priva=
te stacks */
>         enum bpf_prog_type      type;           /* Type of BPF program */
>         enum bpf_attach_type    expected_attach_type; /* For some prog ty=
pes */
> +       enum bpf_pstack_state   pstack:2;       /* Private stack state */
>         u32                     len;            /* Number of filter block=
s */
>         u32                     jited_len;      /* Size of jited insns in=
 bytes */
>         u8                      tag[BPF_TAG_SIZE];
> +       u16                     subtree_stack_depth; /* Subtree stack dep=
th if PSTACK_TREE_ROOT prog, 0 otherwise */

All the extra vars can be in prog->aux.
No need to put them in struct bpf_prog.

>         struct bpf_prog_stats __percpu *stats;
>         int __percpu            *active;
>         unsigned int            (*bpf_func)(const void *ctx,
>                                             const struct bpf_insn *insn);
>         struct bpf_prog_aux     *aux;           /* Auxiliary fields */
>         struct sock_fprog_kern  *orig_prog;     /* Original BPF program *=
/
> +       void __percpu           *private_stack_ptr;

same as this one. prog->aux should be fine.

>         /* Instructions for interpreter */
>         union {
>                 DECLARE_FLEX_ARRAY(struct sock_filter, insns);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0727fff6de0e..d6eb052f6631 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1239,6 +1239,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
>                 struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
>
>                 bpf_jit_binary_free(hdr);
> +               free_percpu(fp->private_stack_ptr);
>                 WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>         }
>
> @@ -2420,6 +2421,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
>                 if (*err)
>                         return fp;
>
> +               if (fp->pstack_eligible) {
> +                       if (!fp->aux->stack_depth) {
> +                               fp->pstack =3D PSTACK_TREE_NO;
> +                       } else {
> +                               void __percpu *private_stack_ptr;
> +
> +                               fp->pstack =3D PSTACK_TREE_ROOT;
> +                               private_stack_ptr =3D
> +                                       __alloc_percpu_gfp(fp->aux->stack=
_depth, 8, GFP_KERNEL);
> +                               if (!private_stack_ptr) {
> +                                       *err =3D -ENOMEM;
> +                                       return fp;
> +                               }
> +                               fp->subtree_stack_depth =3D fp->aux->stac=
k_depth;
> +                               fp->private_stack_ptr =3D private_stack_p=
tr;
> +                       }
> +               }
> +
>                 fp =3D bpf_int_jit_compile(fp);
>                 bpf_prog_jit_attempt_done(fp);
>                 if (!fp->jited && jit_needed) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69e17cb22037..9d093e2013ca 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20060,6 +20060,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>  {
>         struct bpf_prog *prog =3D env->prog, **func, *tmp;
>         int i, j, subprog_start, subprog_end =3D 0, len, subprog;
> +       int subtree_top_idx, subtree_stack_depth;
>         struct bpf_map *map_ptr;
>         struct bpf_insn *insn;
>         void *old_bpf_func;
> @@ -20138,6 +20139,35 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>                 func[i]->is_func =3D 1;
>                 func[i]->sleepable =3D prog->sleepable;
>                 func[i]->aux->func_idx =3D i;
> +
> +               subtree_top_idx =3D env->subprog_info[i].subtree_top_idx;
> +               if (env->subprog_info[subtree_top_idx].pstack_eligible) {
> +                       if (subtree_top_idx =3D=3D i)
> +                               func[i]->subtree_stack_depth =3D
> +                                       env->subprog_info[i].subtree_stac=
k_depth;
> +
> +                       subtree_stack_depth =3D func[i]->subtree_stack_de=
pth;
> +                       if (subtree_top_idx !=3D i) {
> +                               if (env->subprog_info[subtree_top_idx].su=
btree_stack_depth)
> +                                       func[i]->pstack =3D PSTACK_TREE_I=
NTERNAL;
> +                               else
> +                                       func[i]->pstack =3D PSTACK_TREE_N=
O;
> +                       } else if (!subtree_stack_depth) {
> +                               func[i]->pstack =3D PSTACK_TREE_INTERNAL;
> +                       } else {
> +                               void __percpu *private_stack_ptr;
> +
> +                               func[i]->pstack =3D PSTACK_TREE_ROOT;
> +                               private_stack_ptr =3D
> +                                       __alloc_percpu_gfp(subtree_stack_=
depth, 8, GFP_KERNEL);
> +                               if (!private_stack_ptr) {
> +                                       err =3D -ENOMEM;
> +                                       goto out_free;
> +                               }
> +                               func[i]->private_stack_ptr =3D private_st=
ack_ptr;
> +                       }
> +               }
> +
>                 /* Below members will be freed only at prog->aux */
>                 func[i]->aux->btf =3D prog->aux->btf;
>                 func[i]->aux->func_info =3D prog->aux->func_info;
> --
> 2.43.5
>

