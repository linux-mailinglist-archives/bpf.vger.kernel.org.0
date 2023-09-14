Return-Path: <bpf+bounces-10115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C67A11A5
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE99F282148
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2BD308;
	Thu, 14 Sep 2023 23:26:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8B33F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:26:40 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DE1FE5;
	Thu, 14 Sep 2023 16:26:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53087f0e18bso82985a12.3;
        Thu, 14 Sep 2023 16:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694733998; x=1695338798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8S+/VTA8YpPOP0TMPbEv9qezFi+CjZX1hX0AW8uUSc=;
        b=W7dpTm2TESAci2MHfIlrrBC7W9tuzXYhTppTKfWwCpCh3GtwvE9GKls+Je4i3JevYk
         VoDde5bWn+A8X9qBnwEDdKFTkKiXrKayWzTvAA5D+VceEJEHpxEabeaq8xlYt4WpoG9Y
         TPyUnqvWA/pi53yBOhicq5pcKKzDSaOQ39yYq7z1DQVS5lJvHkoyvD8JrpeHA0Olckbf
         r0XtNq41wfdGtjEcfL7k3saL2dHj8hhGGQKID+6CmIltwmdlKAFEHMtqzsQpsZCxKZZc
         pe0dtXQgXQJAQaxTTPMklKGDqtCQ9h0bDP79r+tsbs117XFskiuFrAPeArDCKPb8kRix
         9WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694733998; x=1695338798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8S+/VTA8YpPOP0TMPbEv9qezFi+CjZX1hX0AW8uUSc=;
        b=O/0vg2nfx3x+EXQQkZZP33+pbSCSjCABe+8KZEGYlNQ1k2GFLmkK5mQ0jh15S+uE4j
         az2O8J5G9m9EuEpE+ier7ndLcBes6Y9n4zlrJC8Mw6/42oG3HQOu+1LjXnKG/0dxnNGg
         WjIDsIff3eIlrpLVf3VBn+O8z9Gya8Flnc2YaTZ+MNqOdBPQh3WH3lLtfpn8wT4YqZ9B
         sAwfKKDGMGiWha5avtUlb1AlIBYH4D0bS/ftFrMo9qmGJblmWv3dvv/OePho+O842sVg
         5VaiBgQbJePrSnRkjPMS1VZ2QCPZKilFtyo7e4xQT1bKdT2XxtXNcv5vZ4oD/C23K8sB
         iW4Q==
X-Gm-Message-State: AOJu0Ywn6TCbIksXLnV0+heblXoUf21HNFDisyrNsObWAF+AMrO1VKEp
	7x1XKaj8jRPfEX+knua6S36HE/10Gq2WB/fv0ko=
X-Google-Smtp-Source: AGHT+IE9R6D0D8HivqmuSNTi+Moc0dYX3D3giVNZbd06j0uTQjxWL7qDuaTb+IJHLF5Y6maMmeO4RjtBSPRFR5gCEHo=
X-Received: by 2002:aa7:d804:0:b0:52f:2521:d234 with SMTP id
 v4-20020aa7d804000000b0052f2521d234mr4742212edq.42.1694733997729; Thu, 14 Sep
 2023 16:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com> <20230912070149.969939-3-zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-3-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 16:26:26 -0700
Message-ID: <CAEf4Bzars2B3NMDRZs3ZivQt6YjagCN9XBw6RH8uVv0D+YV8Ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded
 iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:02=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.co=
m> wrote:
>
> This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_css_task in open-coded
> iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
> end}. BPF programs can use these kfuncs through bpf_for_each macro for
> iteration of all tasks under a css.
>
> css_task_iter_*() would try to get the global spin-lock *css_set_lock*, s=
o
> the bpf side has to be careful in where it allows to use this iter.
> Currently we only allow it in bpf_lsm and bpf iter-s.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/uapi/linux/bpf.h       |  4 +++
>  kernel/bpf/helpers.c           |  3 +++
>  kernel/bpf/task_iter.c         | 48 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 23 ++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 +++
>  tools/lib/bpf/bpf_helpers.h    |  7 +++++
>  6 files changed, 89 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 73b155e52204..de02c0971428 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7318,4 +7318,8 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_css_task {
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b0a9834f1051..d6a16becfbb9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2504,6 +2504,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 7473068ed313..d8539cc05ffd 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -803,6 +803,54 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>         .arg5_type      =3D ARG_ANYTHING,
>  };
>
> +struct bpf_iter_css_task_kern {
> +       struct css_task_iter *css_it;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
> +               struct cgroup_subsys_state *css, unsigned int flags)
> +{
> +       struct bpf_iter_css_task_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) !=3D sizeof(st=
ruct bpf_iter_css_task));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=3D
> +                                       __alignof__(struct bpf_iter_css_t=
ask));
> +
> +       switch (flags) {
> +       case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> +       case CSS_TASK_ITER_PROCS:
> +       case 0:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       kit->css_it =3D kzalloc(sizeof(struct css_task_iter), GFP_KERNEL)=
;

Dave used bpf_mem_alloc() inside his iterator, any reason to not use it her=
e?


> +       if (!kit->css_it)
> +               return -ENOMEM;
> +       css_task_iter_start(css, flags, kit->css_it);
> +       return 0;
> +}
> +
> +__bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_c=
ss_task *it)
> +{
> +       struct bpf_iter_css_task_kern *kit =3D (void *)it;
> +
> +       if (!kit->css_it)
> +               return NULL;
> +       return css_task_iter_next(kit->css_it);
> +}
> +
> +__bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
> +{
> +       struct bpf_iter_css_task_kern *kit =3D (void *)it;
> +
> +       if (!kit->css_it)
> +               return;
> +       css_task_iter_end(kit->css_it);
> +       kfree(kit->css_it);
> +}
> +
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dbba2b806017..2367483bf4c2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10332,6 +10332,7 @@ enum special_kfunc_type {
>         KF_bpf_dynptr_clone,
>         KF_bpf_percpu_obj_new_impl,
>         KF_bpf_percpu_obj_drop_impl,
> +       KF_bpf_iter_css_task_new,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -10354,6 +10355,7 @@ BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
>  BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
> +BTF_ID(func, bpf_iter_css_task_new)
>  BTF_SET_END(special_kfunc_set)
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -10378,6 +10380,7 @@ BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
>  BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
> +BTF_ID(func, bpf_iter_css_task_new)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -10902,6 +10905,20 @@ static int process_kf_arg_ptr_to_rbtree_node(str=
uct bpf_verifier_env *env,
>                                                   &meta->arg_rbtree_root.=
field);
>  }
>
> +static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
> +{
> +       enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> +
> +       switch (prog_type) {
> +       case BPF_PROG_TYPE_LSM:
> +               return true;
> +       case BPF_TRACE_ITER:
> +               return env->prog->aux->sleepable;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfu=
nc_call_arg_meta *meta,
>                             int insn_idx)
>  {
> @@ -11152,6 +11169,12 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                         break;
>                 }
>                 case KF_ARG_PTR_TO_ITER:
> +                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_iter_css_task_new]) {
> +                               if (!check_css_task_iter_allowlist(env)) =
{
> +                                       verbose(env, "css_task_iter is on=
ly allowed in bpf_lsm and bpf iter-s\n");
> +                                       return -EINVAL;
> +                               }
> +                       }
>                         ret =3D process_iter_arg(env, regno, insn_idx, me=
ta);
>                         if (ret < 0)
>                                 return ret;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 73b155e52204..de02c0971428 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7318,4 +7318,8 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_css_task {
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 77ceea575dc7..f48723c6c593 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -303,6 +303,13 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it,=
 int start, int end) __weak
>  extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
>  extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
>
> +struct bpf_iter_css_task;
> +struct cgroup_subsys_state;
> +extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
> +               struct cgroup_subsys_state *css, unsigned int flags) __we=
ak __ksym;
> +extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_ta=
sk *it) __weak __ksym;
> +extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __we=
ak __ksym;

please move this into bpf_experimental.h under selftests, this
shouldn't be in libbpf's stable API headers


> +
>  #ifndef bpf_for_each
>  /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct=
 for
>   * using BPF open-coded iterators without having to write mundane explic=
it
> --
> 2.20.1
>

