Return-Path: <bpf+bounces-10116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71D7A11A7
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15D01C20C49
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A72D311;
	Thu, 14 Sep 2023 23:26:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07033F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:26:47 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397262698;
	Thu, 14 Sep 2023 16:26:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so1805281a12.0;
        Thu, 14 Sep 2023 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694734004; x=1695338804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5RHk1zRkAJ4y5BF/R8pbipfkCCCw1UzNiSuYHyN1n4=;
        b=ZpL3u2+M68t0rYDiApxJvgj2d3U+k1btmulkGv0QYuBSBZCOH8y23GMYrtBIWR7sjv
         qT+njsrTEv+1drYUJ+5EitHgP0ezG8TW0bobelc2w11KtW9aj8vMbgAh9wNJ12gg3OYB
         zSt3Gxi+k0amViclDdQ4lOhCcYpeJUMV7mlWU1agxUN62qLGqh+UuipgJ7SpE1SeG4f6
         mjtkqBYzgImhVC8S8sXezp0aLh83UBOeJ+UO3AfOQJzOenJ2CFv0tgy06ozZzPrJjMbB
         uiI4yaf1n+8XW/B0EorwoaOmdjziy7e0oUySRS5UetYdom9EWFcWaaQQoDmrtfvJoFSz
         gxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734004; x=1695338804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5RHk1zRkAJ4y5BF/R8pbipfkCCCw1UzNiSuYHyN1n4=;
        b=Jtr+30wfpgAcZt1sdJSnS0puoqs2p/wqK3BNs5YNVTYvwozOKxTAHalkgFTIJsr1XA
         gkGgbhBjz8HYX/BYP8XdoX+/BvJzuiTWNQ45KxJzY2RO0nUpt3T89OYArqoED6tJJNky
         xyrFuYbhfrDHTRt4z4PUyOiaDv28OQMdYG5eimbAju1NtiFKPsqYdscYDIXa3ZHVVt3z
         h+VHs383zTDnCTAAtbrrE8U24+4A4OrD/AlSil4xvUO7qPnqLQsatYUOSQ6dRi2msLMk
         z6AQjhBEosFxsB5L7gHmjVlJViBrtQQkS2GhZYNql8G7y6fgH/Q1jiaI4hc776ezGXVw
         PPqA==
X-Gm-Message-State: AOJu0Yy2G3ENLOEX7bVilNqY8USgmly6lSoUFNI9jP0V2RmJKBczgJU3
	oOSFZ6MLBj8ODYogsnU9LzjucOj2+zTnLC1p/G8=
X-Google-Smtp-Source: AGHT+IEdS48u/LZvZUdr1by1hlRaatq3Wq+qdVBsDFT/u68o6Brf/aCOv1pnTM86qqP0JANQOmFrXGkuQbPIIuk8MVI=
X-Received: by 2002:aa7:cd0d:0:b0:525:442b:6068 with SMTP id
 b13-20020aa7cd0d000000b00525442b6068mr5945105edw.13.1694734004393; Thu, 14
 Sep 2023 16:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com> <20230912070149.969939-4-zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-4-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 16:26:32 -0700
Message-ID: <CAEf4BzbsBUGiPJ+_RG3c3WdEWNQy2b6h60kLDREcXDsNp3E0_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Introduce process open coded
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
> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_process in open-coded iterat=
or
> style. BPF programs can use these kfuncs or through bpf_for_each macro to
> iterate all processes in the system.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/uapi/linux/bpf.h       |  4 ++++
>  kernel/bpf/helpers.c           |  3 +++
>  kernel/bpf/task_iter.c         | 29 +++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  tools/lib/bpf/bpf_helpers.h    |  5 +++++
>  5 files changed, 45 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index de02c0971428..befa55b52e29 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7322,4 +7322,8 @@ struct bpf_iter_css_task {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_process {
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d6a16becfbb9..9b7d2c6f99d1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2507,6 +2507,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DE=
STROY)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index d8539cc05ffd..9d1927dc3a06 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -851,6 +851,35 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bp=
f_iter_css_task *it)
>         kfree(kit->css_it);
>  }
>
> +struct bpf_iter_process_kern {
> +       struct task_struct *tsk;
> +} __attribute__((aligned(8)));
> +

Few high level thoughts. I think it would be good to follow
SEC("iter/task") naming and approach. Open-coded iterators in many
ways are in-kernel counterpart to iterator programs, so keeping them
close enough within reason is useful for knowledge transfer.

SEC("iter/task") allows to:
a) iterate all threads in the system
b) iterate all threads for a given TGID
c) it also allows to "iterate" a single thread or process, but that's
a bit less relevant for in-kernel iterator, but we can still support
them, why not?

I'm not sure if it supports iterating all processes (as in group
leaders of each task group) in the system, but if it's possible I
think we should support it at least for open-coded iterator, seems
like a very useful functionality.

So to that end, let's design a small set of input arguments for
bpf_iter_process_new() that would allow to specify this as flags +
either (optional) struct task_struct * pointer to represent
task/process or PID/TGID.


> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)

Also, given iterator in the previous is called css_task, and that we
have iter/task, iter/task_vma, etc iterator programs, shouldn't this
one be called bpf_iter_task_new(), which also will be consistent with
Dave's task_vma open-coded iterator?

> +{
> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) !=3D sizeof(str=
uct bpf_iter_process));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=3D
> +                                       __alignof__(struct bpf_iter_proce=
ss));
> +
> +       kit->tsk =3D &init_task;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_pr=
ocess *it)
> +{
> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> +
> +       kit->tsk =3D next_task(kit->tsk);
> +
> +       return kit->tsk =3D=3D &init_task ? NULL : kit->tsk;
> +}
> +
> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
> +{
> +}
> +
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index de02c0971428..befa55b52e29 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7322,4 +7322,8 @@ struct bpf_iter_css_task {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_process {
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index f48723c6c593..858252c2641c 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -310,6 +310,11 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css=
_task *it,
>  extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_ta=
sk *it) __weak __ksym;
>  extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __we=
ak __ksym;
>
> +struct bpf_iter_process;
> +extern int bpf_iter_process_new(struct bpf_iter_process *it) __weak __ks=
ym;
> +extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process=
 *it) __weak __ksym;
> +extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak=
 __ksym;
> +

same, please add this to bpf_experimental, not bpf_helpers.h


>  #ifndef bpf_for_each
>  /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct=
 for
>   * using BPF open-coded iterators without having to write mundane explic=
it
> --
> 2.20.1
>

