Return-Path: <bpf+bounces-9272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10B792E3D
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EEB1C20946
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D81DDD9;
	Tue,  5 Sep 2023 19:04:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA575DDCA
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:04:10 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4740CFB;
	Tue,  5 Sep 2023 12:03:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so48931841fa.0;
        Tue, 05 Sep 2023 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693940535; x=1694545335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8NiPKI5PhDDcqjH4zcDRbhwV4vLtMzV50YnSL6Mscs=;
        b=dsiOoeC5pEr2HakLCfazcmyO6GF07pZX4mCAiqtKyHY4qSdAwHQCZlOQ3MaEUIL14r
         fIpLLq7kZr2Z3L5qdXSIXuegTcxuWVag4vVVzcAEmhQzIPurdqZKLMz8U9PR3HbTFC9d
         PbrPhrEc3tg+sZnT9/IYypsLDHolUrVjM4w8eQ3iW5TQT1pGqjZTuwh9AwaKlyDecxdc
         dJUpY3DMGmuRSYJa4WQq0Oe/VHW5vJ5ZypSF1quAZAX/AxHgC0H9CpZ5FWvUwPRdMwQ3
         z/2ARzgu2a8hUQrhvfbQiJO27NDimgMxO53tHuJWCEUQppt3FP31OZ27alKC0o4iMADF
         89kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940535; x=1694545335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8NiPKI5PhDDcqjH4zcDRbhwV4vLtMzV50YnSL6Mscs=;
        b=T5zD8sXnEgrEMKkq4ZlfBbCbsNoC9a0iIQ1peOrBWNjJ2X2uyy2HmKcu+YJGCszdMZ
         pwgTks54B2/R0lkXq0DmXBlz+mAQN8mOOE0McncfGg7KVAbE+EBlMyVWEvtt3b+kleWm
         hhr6o++EaPZ80CjpBAeDuDHSEAkUcmBn4Meb3g15guo1wEdPt0Y1L336PJF0H2EADUAl
         xZKr8EtnMtNgwsivP+qYM9yyk/uYa/+bZ/NWsuBLFsyrWv6VJbRHZJMx8EuSiO2h+MoD
         hRpnEDg5iRWJjOkuJOsJwT77gBDzgYKzDbdzCYJXasWZNNod3R0VrlfSbqKeJzJGgBEQ
         M8mw==
X-Gm-Message-State: AOJu0Yynmg4+zTQvTEV8AeY7OrEu0aMvZicS40hOLCVyOnqjN9FdYKwj
	hmLIHOJzKOpZogFTr9vac3y+mgI2p5zIvjcnJC8=
X-Google-Smtp-Source: AGHT+IF+hF4stxcRR9nVxQZa6PvOBsnji9E+Mx0JTzlKdnKeQ1p/yIBj9llAbSod8zAonBqVdJx0rWyHPVoYXlM7kow=
X-Received: by 2002:a2e:a174:0:b0:2bc:e51d:d09c with SMTP id
 u20-20020a2ea174000000b002bce51dd09cmr471221ljl.36.1693940534515; Tue, 05 Sep
 2023 12:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com> <20230827072057.1591929-2-zhouchuyi@bytedance.com>
In-Reply-To: <20230827072057.1591929-2-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Sep 2023 12:02:03 -0700
Message-ID: <CAADnVQJpZRoOtC0JF7uub+vPY5JZusWmPyjOJQD=eTxUFWOr_A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Introduce css_task open-coded
 iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 12:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.co=
m> wrote:
>
> This Patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_css_task in open-coded
> iterator style. These kfuncs actually wrapps
> css_task_iter_{start,next,end}. BPF programs can use these kfuncs through
> bpf_for_each macro for iteration of all tasks under a css.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/uapi/linux/bpf.h       |  4 ++++
>  kernel/bpf/helpers.c           |  3 +++
>  kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  tools/lib/bpf/bpf_helpers.h    |  7 ++++++
>  5 files changed, 57 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59beeab..2a6e9b99564b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7195,4 +7195,8 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_css_task {
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9e80efa59a5d..cf113ad24837 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2455,6 +2455,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
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
> index c4ab9d6cdbe9..b1bdba40b684 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -823,6 +823,45 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
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
> +       kit->css_it =3D kzalloc(sizeof(struct css_task_iter), GFP_KERNEL)=
;
> +       if (!kit->css_it)
> +               return -ENOMEM;
> +       css_task_iter_start(css, flags, kit->css_it);

Some of the flags are internal. Like CSS_TASK_ITER_SKIPPED.
The kfunc should probably only allow CSS_TASK_ITER_PROCS |
CSS_TASK_ITER_THREADED,
and not CSS_TASK_ITER_THREADED alone.

Since they're #define-s it's not easy for bpf prog to use them.
I think would be good to have a pre-patch that converts them to enum,
so that bpf prog can take them from vmlinux.h.


But the main issue of the patch that it adds this iter to common kfuncs.
That's not safe, since css_task_iter_*() does spin_unlock_irq() which
might screw up irq flags depending on the context where bpf prog is running=
.
Can css_task_iter internals switch to irqsave/irqrestore?
css_set_lock is also global, so the bpf side has to be careful in
where it allows to use this iter.
bpf_lsm hooks are safe, most of bpf iter-s are safe too.
Future bpf-oom hooks are probably safe as well.
We probably need an allowlist here.

