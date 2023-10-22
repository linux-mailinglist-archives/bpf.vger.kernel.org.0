Return-Path: <bpf+bounces-12947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1187D2401
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7401C209AD
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82FD10968;
	Sun, 22 Oct 2023 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nds5iSFf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154B6133
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 15:59:06 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF999B
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:59:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40853c639abso16168975e9.0
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697990343; x=1698595143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAXzudsf8cFqMXCW5L8pje60sCJ9Apzs/7PyKAlSUC4=;
        b=Nds5iSFfS5v8XMQvqUbZt/GVc0RAgS5j6DcX5UC5KWifm/sn8GOQuO7XWkTvv4A0Va
         DzmXZjlbI7atvg0FfxzoB4HA8Vt1oQl1zqqFp1Z8DuGd/Y6IUI+qWKBirryqIEm4O5R3
         usRcnnuGOtW+i/Ox580YOkNYG1rsMSXs1oEqSWuextLukzAI5vmmtwgaskjCF800I9tR
         jFYxbToXac4nBwkTmRHFoKY6EiAkBiBZIJyuLj+2fDPUPG23Irfv9Sm5sv/DNCu5Khgm
         emAkZNQ/VRVkH6CZxxD9D2LDSAHbXzGtFxkRRgRNZVsGT9eTwYx1xo5Y24nP3xOWgJxk
         QOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697990343; x=1698595143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAXzudsf8cFqMXCW5L8pje60sCJ9Apzs/7PyKAlSUC4=;
        b=PWAf/ZU4Fl7toWEM1lo1k4a6dxmc5+vtQXFy0MRloHbJo2JAhIfl85GNHo0HBHGvUn
         HpfAbR7QEpkxYqF3jpCoWRS9hx93k8eFASTpF34v+P/i8VXhQcWeaGZlVZGQaSDykeiu
         tF/H4dXe2sVzB5tWaZhDg7SXtBclYgGZyPW/NmntgFcoGm2mGz6CcX/ACNa9jtBAQG9Q
         I/rl33YRSHHpIZKA2jTxvqTLTxRgfwLbTc6mukzhXuujpawXKpb83fVrvXLxXzViVtZ8
         gNOKGnbkixsfF2Nl0GEjbDw2mdkjbpWJidBV49P2eqWtCAIC4/ZoSwC82nZmCmt1H2wf
         s31w==
X-Gm-Message-State: AOJu0Yy/moS9hPaVNa4kzaqZOinDutp8JyFPJLNIDmGrSt0x008z5P8e
	ZXdaJ+JBbWQ+UKYJMj3ZNouZ9E2lJq94xKJF/zxavKbTyXU=
X-Google-Smtp-Source: AGHT+IFWwee0LTUB9JcGX6uBe3EzPYSaIm+7bSG0JWul7cTWuIFUXwMV6BpIq1IoUs0HdXNVXpWNDMNzfK5Zv/Jasmo=
X-Received: by 2002:adf:ef42:0:b0:32d:6c35:db55 with SMTP id
 c2-20020adfef42000000b0032d6c35db55mr5015546wrp.29.1697990342765; Sun, 22 Oct
 2023 08:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022154527.229117-1-zhouchuyi@bytedance.com> <20231022154527.229117-2-zhouchuyi@bytedance.com>
In-Reply-To: <20231022154527.229117-2-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 22 Oct 2023 08:58:51 -0700
Message-ID: <CAADnVQ+M-+0No8qpiRvg9h3JF=aOXwhiUdxUhwPGAeGxZkkE+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Relax allowlist for css_task iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 8:45=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> The newly added open-coded css_task iter would try to hold the global
> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be careful =
in
> where it allows to use this iter. The mainly concern is dead locking on
> css_set_lock. check_css_task_iter_allowlist() in verifier enforced css_ta=
sk
> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>
> This patch relax the allowlist for css_task iter. Any lsm and any iter
> (even non-sleepable) and any sleepable are safe since they would not hold
> the css_set_lock before entering BPF progs context.
>
> This patch also fixes the misused BPF_TRACE_ITER in
> check_css_task_iter_allowlist which compared bpf_prog_type with
> bpf_attach_type.
>
> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs=
")
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/verifier.c                             | 15 ++++++++++-----
>  .../selftests/bpf/progs/iters_task_failure.c      |  4 ++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e9bc5d4a25a1..cc79cd555337 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11088,17 +11088,22 @@ static int process_kf_arg_ptr_to_rbtree_node(st=
ruct bpf_verifier_env *env,
>                                                   &meta->arg_rbtree_root.=
field);
>  }
>
> +/*
> + * css_task iter allowlist is needed to avoid dead locking on css_set_lo=
ck.
> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
> + * Any sleepable progs are also safe since bpf_check_attach_target() enf=
orce
> + * them can only be attached to some specific hook points.
> + */
>  static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>  {
>         enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> -
>         switch (prog_type) {
>         case BPF_PROG_TYPE_LSM:
>                 return true;
> -       case BPF_TRACE_ITER:
> -               return env->prog->aux->sleepable;
> +       case BPF_PROG_TYPE_TRACING:
> +               return env->prog->expected_attach_type =3D=3D BPF_TRACE_I=
TER;

I think it needs to be
if (env->prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
   return true;
/* else: fall through to check sleepable */

>         default:
> -               return false;
> +               return env->prog->aux->sleepable;
>         }
>  }
>
> @@ -11357,7 +11362,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                 case KF_ARG_PTR_TO_ITER:
>                         if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_iter_css_task_new]) {
>                                 if (!check_css_task_iter_allowlist(env)) =
{
> -                                       verbose(env, "css_task_iter is on=
ly allowed in bpf_lsm and bpf iter-s\n");
> +                                       verbose(env, "css_task_iter is on=
ly allowed in bpf_lsm, bpf_iter and sleepable progs\n");
>                                         return -EINVAL;
>                                 }
>                         }
> diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/too=
ls/testing/selftests/bpf/progs/iters_task_failure.c
> index c3bf96a67dba..6b1588d70652 100644
> --- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
> +++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
> @@ -84,8 +84,8 @@ int BPF_PROG(iter_css_lock_and_unlock)
>         return 0;
>  }
>
> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> -__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s=
")
> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")

so that fentry/sys_foo is rejected, but fentry.s/sys_foo loads ok.

> +__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and =
sleepable progs")
>  int BPF_PROG(iter_css_task_for_each)
>  {
>         u64 cg_id =3D bpf_get_current_cgroup_id();
> --
> 2.20.1
>

