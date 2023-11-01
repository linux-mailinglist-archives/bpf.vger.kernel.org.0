Return-Path: <bpf+bounces-13775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F277DDAE7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6F61C20DA8
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F67ED1;
	Wed,  1 Nov 2023 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/91ylGJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254810EE
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 02:20:04 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E057ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 19:20:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d09b6d007so42886996d6.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 19:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698805201; x=1699410001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mglNxp+dwc2JmCZixRoEAuxVe9Ge0tZCisbmYudd/eA=;
        b=f/91ylGJrJk6SY+ozgRhlhnBkCkCh81B6gkIZiwm23eLJSiJblZC4KLfhB3DcQouZt
         Z8kUwaeYtDU0SQa8KwQgpeu2D5hjdnhUjh1LyZXzSjkDLP4EhSWWbgQEP6Bmqw7fTSvI
         OUe0iyKCahfQe4Mwt46utu4Q/0w9RW/8saqAMdHuB80ljXoVpVUpoEp9uXYvrADVQDBY
         45LnMRZuTSBkZCo9ByZ52oxvIOMlbx3Ql4jdT0zUVHpgsNxq4TC+AbeEa3rHcG/K+ME3
         WhgJgXJXnQ7VSG8UlsIrL3jyOc4lyrY2WVHHto7fMemiwbUKK3C1hQo0HOiYMUyB8gbb
         Dpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698805201; x=1699410001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mglNxp+dwc2JmCZixRoEAuxVe9Ge0tZCisbmYudd/eA=;
        b=Ufkf0wSNUtuLiDr+sL1bqOT7alEUWBeirA8wvNWKH29m22BiWG3D/xX+BiK5FQlFi5
         RgW7YjaE40fhvhIoFbKnUl3RlW76cozL/n3YG8JWocYyUl/wWJMUtMbYP6gO2B7uj+H1
         423T5+Z82hV9njFFxAHyCJ83HkukCWTt7lbgnNxoxTkk+XgQCLvAYq1IaqeMovxlDy9g
         c+G/fpFQOBd+OxWhzkE1X3CvcEDCuirmEH6r3c4RLKv0Vplc6DeIQH9jvgWI1Hna2dnm
         qseELq1buosn9t7Uyj0eEwA+1iAsX7YjIu7782uRmD9ztPnAui2Wpovd7TcgIyb2Drr+
         CK6Q==
X-Gm-Message-State: AOJu0YwNFGspuGwysTLeeatHHA3XESok1oAcJ4VYRc6DlnS7rlSp7+7j
	c959UIvSq86rmW7++C/YZ0e4SHFA12Tf6xhhyW+zmesw3c4=
X-Google-Smtp-Source: AGHT+IGrIfRYoR9DFfoR9fzkKZrwIhdZ6QDe1vNDrxhyRa5EDNENOzr29/zcfRaAe+vaAu1VyUKush8ANE0DvLi54ls=
X-Received: by 2002:a05:6214:19e7:b0:66d:1256:6dbc with SMTP id
 q7-20020a05621419e700b0066d12566dbcmr19510393qvc.44.1698805201322; Tue, 31
 Oct 2023 19:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031215625.2343848-1-davemarchevsky@fb.com>
In-Reply-To: <20231031215625.2343848-1-davemarchevsky@fb.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 1 Nov 2023 10:19:25 +0800
Message-ID: <CALOAHbCRqgSN4ngkokwK2jwAyPvLyjRdhAXqjPBzdyBkQLLEaw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add __bpf_kfunc_{start,end}_defs macros
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 5:56=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb.c=
om> wrote:
>
> BPF kfuncs are meant to be called from BPF programs. Accordingly, most
> kfuncs are not called from anywhere in the kernel, which the
> -Wmissing-prototypes warning is unhappy about. We've peppered
> __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> defined in the codebase to suppress this warning.
>
> This patch adds two macros meant to bound one or many kfunc definitions.
> All existing kfunc definitions which use these __diag calls to suppress
> -Wmissing-prototypes are migrated to use the newly-introduced macros.
> A new __diag_ignore_all - for "-Wmissing-declarations" - is added to the
> __bpf_kfunc_start_defs macro based on feedback from Andrii on an earlier
> version of this patch [0] and another recent mailing list thread [1].
>
> In the future we might need to ignore different warnings or do other
> kfunc-specific things. This change will make it easier to make such
> modifications for all kfunc defs.
>
>   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6uwq=
CTChK2Dcb1Xig@mail.gmail.com/
>   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <olsajiri@gmail.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>
> v1 -> v2: https://lore.kernel.org/bpf/20231030210638.2415306-1-davemarche=
vsky@fb.com/
>   * Update Documentation/bpf/kfuncs.rst to use new macros (Yafang, Andrii=
)
>   * Update recently-added open-coded {task,cgroup} iters to use new
>     macros (Yafang, Andrii)
>   * Add Andrii ack
>
>  Documentation/bpf/kfuncs.rst     |  6 ++----
>  include/linux/btf.h              |  9 +++++++++
>  kernel/bpf/bpf_iter.c            |  6 ++----
>  kernel/bpf/cgroup_iter.c         |  6 ++----
>  kernel/bpf/cpumask.c             |  6 ++----
>  kernel/bpf/helpers.c             |  6 ++----
>  kernel/bpf/map_iter.c            |  6 ++----
>  kernel/bpf/task_iter.c           | 18 ++++++------------
>  kernel/trace/bpf_trace.c         |  6 ++----
>  net/bpf/test_run.c               |  7 +++----
>  net/core/filter.c                | 13 ++++---------
>  net/core/xdp.c                   |  6 ++----
>  net/ipv4/fou_bpf.c               |  6 ++----
>  net/netfilter/nf_conntrack_bpf.c |  6 ++----
>  net/netfilter/nf_nat_bpf.c       |  6 ++----
>  net/xfrm/xfrm_interface_bpf.c    |  6 ++----
>  16 files changed, 46 insertions(+), 73 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 0d2647fb358d..723408e399ab 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -37,16 +37,14 @@ prototype in a header for the wrapper kfunc.
>  An example is given below::
>
>          /* Disables missing prototype warnings */
> -        __diag_push();
> -        __diag_ignore_all("-Wmissing-prototypes",
> -                          "Global kfuncs as their definitions will be in=
 BTF");
> +        __bpf_kfunc_start_defs();
>
>          __bpf_kfunc struct task_struct *bpf_find_get_task_by_vpid(pid_t =
nr)
>          {
>                  return find_get_task_by_vpid(nr);
>          }
>
> -        __diag_pop();
> +        __bpf_kfunc_end_defs();
>
>  A wrapper kfunc is often needed when we need to annotate parameters of t=
he
>  kfunc. Otherwise one may directly make the kfunc visible to the BPF prog=
ram by
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index c2231c64d60b..dc5ce962f600 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -84,6 +84,15 @@
>   */
>  #define __bpf_kfunc __used noinline
>
> +#define __bpf_kfunc_start_defs()                                        =
      \
> +       __diag_push();                                                   =
      \
> +       __diag_ignore_all("-Wmissing-declarations",                      =
      \
> +                         "Global kfuncs as their definitions will be in =
BTF");\
> +       __diag_ignore_all("-Wmissing-prototypes",                        =
      \
> +                         "Global kfuncs as their definitions will be in =
BTF")
> +
> +#define __bpf_kfunc_end_defs() __diag_pop()
> +
>  /*
>   * Return the name of the passed struct, if exists, or halt the build if=
 for
>   * example the structure gets renamed. In this way, developers have to r=
evisit
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 833faa04461b..0fae79164187 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -782,9 +782,7 @@ struct bpf_iter_num_kern {
>         int end; /* final value, exclusive */
>  } __aligned(8);
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int=
 end)
>  {
> @@ -843,4 +841,4 @@ __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter=
_num *it)
>         s->cur =3D s->end =3D 0;
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index 209e5135f9fb..d1b5c5618dd7 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -305,9 +305,7 @@ struct bpf_iter_css_kern {
>         unsigned int flags;
>  } __attribute__((aligned(8)));
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -               "Global functions as their definitions will be in vmlinux=
 BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
>                 struct cgroup_subsys_state *start, unsigned int flags)
> @@ -358,4 +356,4 @@ __bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter=
_css *it)
>  {
>  }
>
> -__diag_pop();
> \ No newline at end of file
> +__bpf_kfunc_end_defs();
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 6983af8e093c..e01c741e54e7 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -34,9 +34,7 @@ static bool cpu_valid(u32 cpu)
>         return cpu < nr_cpu_ids;
>  }
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global kfuncs as their definitions will be in BTF");
> +__bpf_kfunc_start_defs();
>
>  /**
>   * bpf_cpumask_create() - Create a mutable BPF cpumask.
> @@ -407,7 +405,7 @@ __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const =
struct cpumask *src1,
>         return cpumask_any_and_distribute(src1, src2);
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(cpumask_kfunc_btf_ids)
>  BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e46ac288a108..0e4657606eaa 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1886,9 +1886,7 @@ void bpf_rb_root_free(const struct btf_field *field=
, void *rb_root,
>         }
>  }
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign=
)
>  {
> @@ -2505,7 +2503,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>         WARN(1, "A call to BPF exception callback should never return\n")=
;
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(generic_btf_ids)
>  #ifdef CONFIG_KEXEC_CORE
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index 6fc9dae9edc8..6abd7c5df4b3 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -193,9 +193,7 @@ static int __init bpf_map_iter_init(void)
>
>  late_initcall(bpf_map_iter_init);
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
>  {
> @@ -213,7 +211,7 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct b=
pf_map *map)
>         return ret;
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(bpf_map_iter_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 59e747938bdb..6cd8295c9683 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -824,9 +824,7 @@ struct bpf_iter_task_vma_kern {
>         struct bpf_iter_task_vma_kern_data *data;
>  } __attribute__((aligned(8)));
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>                                       struct task_struct *task, u64 addr)
> @@ -892,7 +890,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf=
_iter_task_vma *it)
>         }
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  struct bpf_iter_css_task {
>         __u64 __opaque[1];
> @@ -902,9 +900,7 @@ struct bpf_iter_css_task_kern {
>         struct css_task_iter *css_it;
>  } __attribute__((aligned(8)));
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>                 struct cgroup_subsys_state *css, unsigned int flags)
> @@ -950,7 +946,7 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf=
_iter_css_task *it)
>         bpf_mem_free(&bpf_global_ma, kit->css_it);
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  struct bpf_iter_task {
>         __u64 __opaque[3];
> @@ -971,9 +967,7 @@ enum {
>         BPF_TASK_ITER_PROC_THREADS
>  };
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
>                 struct task_struct *task__nullable, unsigned int flags)
> @@ -1043,7 +1037,7 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_i=
ter_task *it)
>  {
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..84e8a0f6e4e0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1252,9 +1252,7 @@ static const struct bpf_func_proto bpf_get_func_arg=
_cnt_proto =3D {
>  };
>
>  #ifdef CONFIG_KEYS
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "kfuncs which will be used in BPF programs");
> +__bpf_kfunc_start_defs();
>
>  /**
>   * bpf_lookup_user_key - lookup a key by its serial
> @@ -1404,7 +1402,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct b=
pf_dynptr_kern *data_ptr,
>  }
>  #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(key_sig_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SL=
EEPABLE)
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 0841f8d82419..c9fdcc5cdce1 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -503,9 +503,8 @@ static int bpf_test_finish(const union bpf_attr *katt=
r,
>   * architecture dependent calling conventions. 7+ can be supported in th=
e
>   * future.
>   */
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
> +
>  __bpf_kfunc int bpf_fentry_test1(int a)
>  {
>         return a + 1;
> @@ -605,7 +604,7 @@ __bpf_kfunc void bpf_kfunc_call_memb_release(struct p=
rog_test_member *p)
>  {
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(bpf_test_modify_return_ids)
>  BTF_ID_FLAGS(func, bpf_modify_return_test)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 21d75108c2e9..383f96b0a1c7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11767,9 +11767,7 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>         return func;
>  }
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>  __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
>                                     struct bpf_dynptr_kern *ptr__uninit)
>  {
> @@ -11816,7 +11814,7 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct=
 bpf_sock_addr_kern *sa_kern,
>
>         return 0;
>  }
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
>                                struct bpf_dynptr_kern *ptr__uninit)
> @@ -11879,10 +11877,7 @@ static int __init bpf_kfunc_init(void)
>  }
>  late_initcall(bpf_kfunc_init);
>
> -/* Disables missing prototype warnings */
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  /* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error co=
de.
>   *
> @@ -11916,7 +11911,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_comm=
on *sock)
>         return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>  }
>
> -__diag_pop()
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(bpf_sk_iter_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index df4789ab512d..b6f1d6dab3f2 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -696,9 +696,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
>         return nxdpf;
>  }
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +__bpf_kfunc_start_defs();
>
>  /**
>   * bpf_xdp_metadata_rx_timestamp - Read XDP frame RX timestamp.
> @@ -738,7 +736,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct=
 xdp_md *ctx, u32 *hash,
>         return -EOPNOTSUPP;
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(xdp_metadata_kfunc_ids)
>  #define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF=
_TRUSTED_ARGS)
> diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
> index 3760a14b6b57..4da03bf45c9b 100644
> --- a/net/ipv4/fou_bpf.c
> +++ b/net/ipv4/fou_bpf.c
> @@ -22,9 +22,7 @@ enum bpf_fou_encap_type {
>         FOU_BPF_ENCAP_GUE,
>  };
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in BTF")=
;
> +__bpf_kfunc_start_defs();
>
>  /* bpf_skb_set_fou_encap - Set FOU encap parameters
>   *
> @@ -100,7 +98,7 @@ __bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff=
 *skb_ctx,
>         return 0;
>  }
>
> -__diag_pop()
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(fou_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_skb_set_fou_encap)
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index b21799d468d2..475358ec8212 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -230,9 +230,7 @@ static int _nf_conntrack_btf_struct_access(struct bpf=
_verifier_log *log,
>         return 0;
>  }
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in nf_co=
nntrack BTF");
> +__bpf_kfunc_start_defs();
>
>  /* bpf_xdp_ct_alloc - Allocate a new CT entry
>   *
> @@ -467,7 +465,7 @@ __bpf_kfunc int bpf_ct_change_status(struct nf_conn *=
nfct, u32 status)
>         return nf_ct_change_status_common(nfct, status);
>  }
>
> -__diag_pop()
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(nf_ct_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_xdp_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
> index 141ee7783223..6e3b2f58855f 100644
> --- a/net/netfilter/nf_nat_bpf.c
> +++ b/net/netfilter/nf_nat_bpf.c
> @@ -12,9 +12,7 @@
>  #include <net/netfilter/nf_conntrack_core.h>
>  #include <net/netfilter/nf_nat.h>
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in nf_na=
t BTF");
> +__bpf_kfunc_start_defs();
>
>  /* bpf_ct_set_nat_info - Set source or destination nat address
>   *
> @@ -54,7 +52,7 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___in=
it *nfct,
>         return nf_nat_setup_info(ct, &range, manip) =3D=3D NF_DROP ? -ENO=
MEM : 0;
>  }
>
> -__diag_pop()
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(nf_nat_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
> diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.=
c
> index d74f3fd20f2b..7d5e920141e9 100644
> --- a/net/xfrm/xfrm_interface_bpf.c
> +++ b/net/xfrm/xfrm_interface_bpf.c
> @@ -27,9 +27,7 @@ struct bpf_xfrm_info {
>         int link;
>  };
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "Global functions as their definitions will be in xfrm_=
interface BTF");
> +__bpf_kfunc_start_defs();
>
>  /* bpf_skb_get_xfrm_info - Get XFRM metadata
>   *
> @@ -93,7 +91,7 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff =
*skb_ctx, const struct bp
>         return 0;
>  }
>
> -__diag_pop()
> +__bpf_kfunc_end_defs();
>
>  BTF_SET8_START(xfrm_ifc_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_skb_get_xfrm_info)
> --
> 2.34.1
>


--=20
Regards
Yafang

