Return-Path: <bpf+bounces-11008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BF7B0F8F
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 429601C2094A
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A74D8EE;
	Wed, 27 Sep 2023 23:24:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A41C6B3
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 23:24:37 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D2F4;
	Wed, 27 Sep 2023 16:24:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b2b53e17feso287939866b.3;
        Wed, 27 Sep 2023 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695857074; x=1696461874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP4F85bbzFRNqjMlm7kZPQ+nNsT3kjeP+jCG/TYrq88=;
        b=fYmmKUjP/nq2jxphtDeohGJ2FsjtZNI7sojMyYd/0iobLIrGfdNxibVzOANkCHNLqF
         3PjsjnHjbx+qd3xXvQGXmXrzTVBZQCcgXAHFmmOX9GbWhBQcS0g1rArKPiEwNfBLQe5p
         AaUVoHqWWzyiXduQ+/9Klyiwp1EadC/N+f5wHRGxXzCYUuSxMOFbWaQv9zThh1qd8Hlt
         Vsx3B7VM/+ChgGs3HCgca4+qt5eLwyQeR7PNhyixYW6o0wQKudvUqO3voCyOHyX6zjDN
         aLSKysrZH0PDe1uM1XjL5rmysrViAEtxjow1cgD3FvFlTuSQpfTAVGMJm4osnCjAq9/T
         1lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695857074; x=1696461874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP4F85bbzFRNqjMlm7kZPQ+nNsT3kjeP+jCG/TYrq88=;
        b=SNXJgHc3f7g16EdjRbBRhuS8vTQRiTU79KYq4YSpPXubJyQAwHiYV6F87luzGCVhhz
         jZ78jIkkBW6Jt274CmnZjnY8Gm7U1FgXcePZCTSSCZ5xjcr4wicLX7N3dtlTrWLwZwNe
         kW0s3WlfBZo/7/gsUFr/P2uHUC5w9dNuq1v5yP65G9mblp/zUzF0xXfzC1dDbOP7YbOK
         DoG/+4MQdo9wLK8Uu5YxqwUNJazOEvSnt0/KuOWEpLTHAkGSfnoiaAeJtmocKSNiGSSH
         F07ABQMzCThGhbcGFtJGcrBdTobjhrlxUM7PNhOmW1FnNv2jigjYOyyWI9ciOZkFdprO
         zxBQ==
X-Gm-Message-State: AOJu0Ywn4T8DnyJDOLoKI0w0CUt5wZd1csfb+40S/7eEmemicilJ8tnq
	Q8nMLKL+fIapGeTOAX+4y0YOKHNvyCpHMGTWnZC/S4MKkKQ=
X-Google-Smtp-Source: AGHT+IGYks/ROw19A7ZBt3HAY8xGrI6pa8dgE2boz3KYtutGfXF7STZtC324zScNazvQpwGj/KHJ1t9AZBgkIK7/Pq4=
X-Received: by 2002:a17:907:75ef:b0:9ae:594d:d3fc with SMTP id
 jz15-20020a17090775ef00b009ae594dd3fcmr2658272ejc.17.1695857073839; Wed, 27
 Sep 2023 16:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com> <20230925105552.817513-5-zhouchuyi@bytedance.com>
In-Reply-To: <20230925105552.817513-5-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Sep 2023 16:24:22 -0700
Message-ID: <CAEf4BzbYgf1t8tfQJ4xwfDH-o_3n+PRMBgC4AZRLbXGM=QJtzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce css open-coded iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_css in open-coded iterator
> style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
> css_iter can be used to:
>
> 1) iterating a sepcific cgroup tree with pre/post/up order
>
> 2) iterating cgroup_subsystem in BPF Prog, like
> for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
>
> The API design is consistent with cgroup_iter. bpf_iter_css_new accepts
> parameters defining iteration order and starting css. Here we also reuse
> BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
> BPF_CGROUP_ITER_ANCESTORS_UP enums.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/cgroup_iter.c                      | 57 +++++++++++++++++++
>  kernel/bpf/helpers.c                          |  3 +
>  .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
>  3 files changed, 66 insertions(+)
>
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index 810378f04fbc..ebc3d9471f52 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -294,3 +294,60 @@ static int __init bpf_cgroup_iter_init(void)
>  }
>
>  late_initcall(bpf_cgroup_iter_init);
> +
> +struct bpf_iter_css {
> +       __u64 __opaque[2];
> +       __u32 __opaque_int[1];
> +} __attribute__((aligned(8)));
> +

same as before, __opaque[3] only


> +struct bpf_iter_css_kern {
> +       struct cgroup_subsys_state *start;
> +       struct cgroup_subsys_state *pos;
> +       int order;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
> +               struct cgroup_subsys_state *start, enum bpf_cgroup_iter_o=
rder order)

Similarly, I wonder if we should go for a more generic "flags" argument?

> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;

empty line

> +       kit->start =3D NULL;
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) !=3D sizeof(struct =
bpf_iter_css));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) !=3D __alignof=
__(struct bpf_iter_css));

please move this up before kit->start assignment, and separate by empty lin=
es

> +       switch (order) {
> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
> +       case BPF_CGROUP_ITER_ANCESTORS_UP:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       kit->start =3D start;
> +       kit->pos =3D NULL;
> +       kit->order =3D order;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_ite=
r_css *it)
> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;

empty line

> +       if (!kit->start)
> +               return NULL;
> +
> +       switch (kit->order) {
> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> +               kit->pos =3D css_next_descendant_pre(kit->pos, kit->start=
);
> +               break;
> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
> +               kit->pos =3D css_next_descendant_post(kit->pos, kit->star=
t);
> +               break;
> +       default:

we know it's BPF_CGROUP_ITER_ANCESTORS_UP, so why not have that here explic=
itly?

> +               kit->pos =3D kit->pos ? kit->pos->parent : kit->start;
> +       }
> +
> +       return kit->pos;

wouldn't this implementation never return the "start" css? is that intentio=
nal?

> +}
> +
> +__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
> +{
> +}
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 556262c27a75..9c3af36249a2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2510,6 +2510,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_IT=
ER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index d989775dbdb5..aa247d1d81d1 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -174,4 +174,10 @@ extern int bpf_iter_task_new(struct bpf_iter_task *i=
t, struct task_struct *task,
>  extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) =
__weak __ksym;
>  extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksy=
m;
>
> +struct bpf_iter_css;
> +extern int bpf_iter_css_new(struct bpf_iter_css *it,
> +                               struct cgroup_subsys_state *start, enum b=
pf_cgroup_iter_order order) __weak __ksym;
> +extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css=
 *it) __weak __ksym;
> +extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
> +
>  #endif
> --
> 2.20.1
>

