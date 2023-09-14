Return-Path: <bpf+bounces-10117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A807A11AA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E932822E7
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D55D30A;
	Thu, 14 Sep 2023 23:26:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3633F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:26:54 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30042716;
	Thu, 14 Sep 2023 16:26:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso1441545f8f.1;
        Thu, 14 Sep 2023 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694734012; x=1695338812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TZlQmyfZ3ztxFPheOy8Lhwx7RuZLz/KzMM2TITFVNE=;
        b=YD9MyhwzGDSvfNbr3ZOhQh5lhBEOnfrLj1SLLoabBpWadoMj+gXsmIUVml1sYfyjzH
         R1U4wwj7csFbb1KTS23aLXQ+6Wc4IQyPHKK8pzHPGtYEdrPWLfbS69qrnmOWtubH7Pek
         6tWbhThExfHiduzlo7dEnrMQrZQiePpTHUyBX2YR2+qYV2rhpXglFPL+kLwg5RfnDst0
         1TtBD+nPvnKYPcbCD3ZvskZsSrG9xIsYobbTFmZWw7vcWgMzv9iItWkq+m2o7kaxlNbn
         sbjhTTnc51Yn1gJcZ3m8oQ9/lv+DVDrSZDbm8A0h1Q3NKGyQwfKh1ogaXhoncHcEw/Yg
         nWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734012; x=1695338812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TZlQmyfZ3ztxFPheOy8Lhwx7RuZLz/KzMM2TITFVNE=;
        b=GZ8qTqrS56H1Gt2RnzKXjU1UdZatnJmfNCB/s1CDK++d+M8c3GGV24SA+ue2d3EvRu
         MQB6tSZMiE0SX6cb0++/nehLVRFx7+DV6Pt6iQLPzw3FWUJjHo1b8MFo2sxiYvNeuZhd
         3fH2s1uxYpt1yPEF/4KPVeJtBuEiv47MkUhPzGdls8exkUv8BsEYAN6f1WDEoLQat4gS
         3Cl8cxyrR+ALSUEgrgvWN/EqyG/iLdYb8B9PqlatMq6dOy25CmNQaa+vV9G5OVOhahRb
         GEEb4KvfZrMqPNYKH1iRXQrFi4bf1RTe/5TMEVTrLixZ8hv9WYuB5zd/vTQA0N6QlwSL
         BklQ==
X-Gm-Message-State: AOJu0YxZUQzbs+dmui6Icoycp9ok6aPNpyRYFUyJq4yyOiC+aUKqz2Hf
	vvWYOWfaXddZyzfNzUdmhg3YZyZ6uDHNdxMm8Oo=
X-Google-Smtp-Source: AGHT+IHCKMOB/thJ7R47d3uvmOIL+qKnWZ8/keuDJxg6yY1servYNO/Hb4pif5fz5mttejQxTbq7c9fYDG4/xvWgbAc=
X-Received: by 2002:a5d:4952:0:b0:317:6653:60b8 with SMTP id
 r18-20020a5d4952000000b00317665360b8mr21595wrs.50.1694734011765; Thu, 14 Sep
 2023 16:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com> <20230912070149.969939-5-zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-5-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 16:26:39 -0700
Message-ID: <CAEf4BzY4qabpk3SD-GA5n5++REcXCxTtA4ythsR9HKHtGi33xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded
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
> This Patch adds kfuncs bpf_iter_css_{pre,post}_{new,next,destroy} which
> allow creation and manipulation of struct bpf_iter_css in open-coded
> iterator style. These kfuncs actually wrapps css_next_descendant_{pre,
> post}. BPF programs can use these kfuncs through bpf_for_each macro for
> iteration of all descendant css under a root css.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/uapi/linux/bpf.h       |  8 +++++
>  kernel/bpf/helpers.c           |  6 ++++
>  kernel/bpf/task_iter.c         | 53 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  8 +++++
>  tools/lib/bpf/bpf_helpers.h    | 12 ++++++++
>  5 files changed, 87 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index befa55b52e29..57760afc13d0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7326,4 +7326,12 @@ struct bpf_iter_process {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_css_pre {
> +       __u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_css_post {
> +       __u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9b7d2c6f99d1..ca1f6404af9e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2510,6 +2510,12 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_I=
TER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_css_pre_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_css_pre_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_pre_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_css_post_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_css_post_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_post_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 9d1927dc3a06..8963fc779b87 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -880,6 +880,59 @@ __bpf_kfunc void bpf_iter_process_destroy(struct bpf=
_iter_process *it)
>  {
>  }
>
> +struct bpf_iter_css_kern {
> +       struct cgroup_subsys_state *root;
> +       struct cgroup_subsys_state *pos;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
> +               struct cgroup_subsys_state *root)

similar to my comment on previous patches, please see
kernel/bpf/cgroup_iter.c for iter/cgroup iterator program. Let's stay
consistent. We have one iterator that accepts parameters defining
iteration order and starting cgroup. Unless there are some technical
reasons we can't follow similar approach with this open-coded iter,
let's use the same approach. We can even reuse
BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
BPF_CGROUP_ITER_ANCESTORS_UP enums.


> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) !=3D sizeof(struct =
bpf_iter_css_pre));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) !=3D __alignof=
__(struct bpf_iter_css_pre));
> +       kit->root =3D root;
> +       kit->pos =3D NULL;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf=
_iter_css_pre *it)
> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> +
> +       kit->pos =3D css_next_descendant_pre(kit->pos, kit->root);
> +       return kit->pos;
> +}
> +
> +__bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
> +{
> +}
> +
> +__bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
> +               struct cgroup_subsys_state *root)
> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) !=3D sizeof(struct =
bpf_iter_css_post));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) !=3D __alignof=
__(struct bpf_iter_css_post));
> +       kit->root =3D root;
> +       kit->pos =3D NULL;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bp=
f_iter_css_post *it)
> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> +
> +       kit->pos =3D css_next_descendant_post(kit->pos, kit->root);
> +       return kit->pos;
> +}
> +
> +__bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
> +{
> +}
> +
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index befa55b52e29..57760afc13d0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7326,4 +7326,12 @@ struct bpf_iter_process {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_css_pre {
> +       __u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_css_post {
> +       __u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 858252c2641c..6e5bd9ef14d6 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -315,6 +315,18 @@ extern int bpf_iter_process_new(struct bpf_iter_proc=
ess *it) __weak __ksym;
>  extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process=
 *it) __weak __ksym;
>  extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak=
 __ksym;
>
> +struct bpf_iter_css_pre;
> +extern int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
> +               struct cgroup_subsys_state *root) __weak __ksym;
> +extern struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter=
_css_pre *it) __weak __ksym;
> +extern void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it) __weak=
 __ksym;
> +
> +struct bpf_iter_css_post;
> +extern int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
> +               struct cgroup_subsys_state *root) __weak __ksym;
> +extern struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_ite=
r_css_post *it) __weak __ksym;
> +extern void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it) __we=
ak __ksym;
> +
>  #ifndef bpf_for_each
>  /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct=
 for
>   * using BPF open-coded iterators without having to write mundane explic=
it
> --
> 2.20.1
>

