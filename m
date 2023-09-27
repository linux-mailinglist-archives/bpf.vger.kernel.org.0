Return-Path: <bpf+bounces-11010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA77B0F97
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DC7C8281C8B
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 23:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3A4D8FC;
	Wed, 27 Sep 2023 23:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622315B6
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 23:37:22 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65033F9;
	Wed, 27 Sep 2023 16:37:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso1507084366b.0;
        Wed, 27 Sep 2023 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695857837; x=1696462637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OxzetWkN1SscgRTbAJVQV5Koq8cE2AuXIAJBttysKc=;
        b=RuNu9iuIs5/URyLtsCqkBrpv9tFJnZtwDi74ORsQOhib8AeNWDr2xvqxja1kkX9+WT
         5lJAP/KFnIWbmzRb85ogDvLR+Qtgh7lS8E0qtEt+j+qwUsAf7Ypul0/qEqwkgT9aqf0A
         Db0EMPawvW/W4uZKHD42BVfyql/DExW6QAPjgEGf3xYybzbdmXZBQOPofCMBQhRPZ0iJ
         2ZNxBkiao2bxpjXQX/3F/gK9RltPWa2CSX88B6IVKjrBkACRJFXhR6IO3VnPytmudhi5
         WEc5OHHSc/cQL2x/nxZ1wxM7gryYliO/JpE8UgXmkfG/TWFoFiJZikBlVncoLayQgF8K
         O2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695857837; x=1696462637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OxzetWkN1SscgRTbAJVQV5Koq8cE2AuXIAJBttysKc=;
        b=u+ZneLIN4gA+B7BsSLtaeqY/FmskDzxHNMzMUD4oLd1CMzwLs74vlzDrjbCEd0ECEb
         BPzmiHQaWraZdZGd5Fu1eDpwGxZNborBmpGt4NGC4bmujb5roPOXiwC1SXzmtwUS6o9B
         FfTDNSn0pSmRcRIQcHQkOkPjQ8nLYesC36/OJBQztnFeu0JCLob3z/gAFQ4lgybixZvK
         qcmnfARXsoso9BlEM9nOqhCdR256OXDltMjUm2z+yEVNnI/x+hJJnbMiFoA9LZbqqbb0
         nChzDfEbZIQdETUQcvY+lMf9lVyauG9SSD2/2xC6JCvQvWr6Q9TPffegfDve0WK55/w5
         bo+A==
X-Gm-Message-State: AOJu0YyGxu16lt7ZRKhY1gaytS9cEeup+emq2dm1ktszf7ntaHYkz8pP
	mMNWSd9E8J8O19RxbZK23hOSny0hbFGZC9PpIX8=
X-Google-Smtp-Source: AGHT+IHY4eTQ0vcHUEOCkyWsul07b34kuXtFvgc5YiaHNYFt+fCJ5YgnRGuziexRVhN4g/Y6UCVAZTcI2PmLYX2LTiQ=
X-Received: by 2002:a17:906:18a1:b0:9ae:69ff:bcdb with SMTP id
 c1-20020a17090618a100b009ae69ffbcdbmr2962842ejf.31.1695857836745; Wed, 27 Sep
 2023 16:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com> <20230925105552.817513-7-zhouchuyi@bytedance.com>
In-Reply-To: <20230925105552.817513-7-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Sep 2023 16:37:05 -0700
Message-ID: <CAEf4BzZKR7OXtpxak2ye5hsF3w9k8VLQb2u-dwGQQgqVG1sx+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: Let bpf_iter_task_new accept null
 task ptr
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> When using task_iter to iterate all threads of a specific task, we enforc=
e
> that the user must pass a valid task pointer to ensure safety. However,
> when iterating all threads/process in the system, BPF verifier still
> require a valid ptr instead of "nullable" pointer, even though it's
> pointless, which is a kind of surprising from usability standpoint. It
> would be nice if we could let that kfunc accept a explicit null pointer
> when we are using BPF_TASK_ITER_ALL/BPF_TASK_ITER_PROC and a valid pointe=
r
> when using BPF_TASK_ITER_THREAD.
>
> Given a trival kfunc:
>         __bpf_kfunc void FN(struct TYPE_A *obj)
>
> BPF Prog would reject a nullptr for obj. The error info is:
> "arg#x pointer type xx xx must point to scalar, or struct with scalar"
> reported by get_kfunc_ptr_arg_type(). The reg->type is SCALAR_VALUE and
> the btf type of ref_t is not scalar or scalar_struct which leads to the
> rejection of get_kfunc_ptr_arg_type.
>
> This patch reuse the __opt annotation which was used to indicate that
> the buffer associated with an __sz or __szk argument may be null:
>         __bpf_kfunc void FN(struct TYPE_A *obj__opt)
> Here __opt indicates obj can be optional, user can pass a explicit nullpt=
r
> or a normal TYPE_A pointer. In get_kfunc_ptr_arg_type(), we will detect
> whether the current arg is optional and register is null, If so, return
> a new kfunc_ptr_arg_type KF_ARG_PTR_TO_NULL and skip to the next arg in
> check_kfunc_args().
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/task_iter.c |  7 +++++--
>  kernel/bpf/verifier.c  | 13 ++++++++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 9bcd3f9922b1..7ac007f161cc 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -867,7 +867,7 @@ struct bpf_iter_task_kern {
>         unsigned int type;
>  } __attribute__((aligned(8)));
>
> -__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_=
struct *task, unsigned int type)
> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_=
struct *task__opt, unsigned int type)
>  {
>         struct bpf_iter_task_kern *kit =3D (void *)it;
>         BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) !=3D sizeof(struct=
 bpf_iter_task));
> @@ -877,14 +877,17 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_t=
ask *it, struct task_struct *
>         switch (type) {
>         case BPF_TASK_ITER_ALL:
>         case BPF_TASK_ITER_PROC:
> +               break;
>         case BPF_TASK_ITER_THREAD:
> +               if (!task__opt)
> +                       return -EINVAL;
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
>         if (type =3D=3D BPF_TASK_ITER_THREAD)
> -               kit->task =3D task;
> +               kit->task =3D task__opt;
>         else
>                 kit->task =3D &init_task;
>         kit->pos =3D kit->task;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a065e18a0b3a..a79204c75a90 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10331,6 +10331,7 @@ enum kfunc_ptr_arg_type {
>         KF_ARG_PTR_TO_CALLBACK,
>         KF_ARG_PTR_TO_RB_ROOT,
>         KF_ARG_PTR_TO_RB_NODE,
> +       KF_ARG_PTR_TO_NULL,
>  };
>
>  enum special_kfunc_type {
> @@ -10425,6 +10426,12 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct =
bpf_kfunc_call_arg_meta *meta)
>         return meta->func_id =3D=3D special_kfunc_list[KF_bpf_rcu_read_un=
lock];
>  }
>
> +static inline bool is_kfunc_arg_optional_null(struct bpf_reg_state *reg,
> +                               const struct btf *btf, const struct btf_p=
aram *arg)
> +{
> +       return register_is_null(reg) && is_kfunc_arg_optional(btf, arg);
> +}
> +
>  static enum kfunc_ptr_arg_type
>  get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>                        struct bpf_kfunc_call_arg_meta *meta,
> @@ -10497,6 +10504,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>          */
>         if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(en=
v, meta->btf, ref_t, 0) &&
>             (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> +                       if (is_kfunc_arg_optional_null(reg, meta->btf, &a=
rgs[argno]))
> +                               return KF_ARG_PTR_TO_NULL;

This nested check seems misplaced. Maybe we shouldn't reuse __opt
suffix which already has a different meaning (coupled with __sz). Why
not add "__nullable" convention and just check it separately?

>                 verbose(env, "arg#%d pointer type %s %s must point to %ss=
calar, or struct with scalar\n",
>                         argno, btf_type_str(ref_t), ref_tname, arg_mem_si=
ze ? "void, " : "");
>                 return -EINVAL;
> @@ -11028,7 +11037,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                 }
>
>                 if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &=
&
> -                   (register_is_null(reg) || type_may_be_null(reg->type)=
)) {
> +                   (register_is_null(reg) || type_may_be_null(reg->type)=
) && !is_kfunc_arg_optional(meta->btf, &args[i])) {

nit: looks like a very long line, probably wrap to the next line?

>                         verbose(env, "Possibly NULL pointer passed to tru=
sted arg%d\n", i);
>                         return -EACCES;
>                 }
> @@ -11053,6 +11062,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         return kf_arg_type;
>
>                 switch (kf_arg_type) {
> +               case KF_ARG_PTR_TO_NULL:
> +                       continue;
>                 case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>                 case KF_ARG_PTR_TO_BTF_ID:
>                         if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu=
(meta))
> --
> 2.20.1
>

