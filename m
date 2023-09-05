Return-Path: <bpf+bounces-9280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BE0792F9E
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 22:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073C71C20A46
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A7DF56;
	Tue,  5 Sep 2023 20:10:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935BCA65
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 20:10:52 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C3E72;
	Tue,  5 Sep 2023 13:10:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so46425271fa.2;
        Tue, 05 Sep 2023 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693944578; x=1694549378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bg2ttwGZhXRH+IvLxorSyd3+PUy2fTzplCQnlymx4A=;
        b=Nfcm+wWwhZhEk3lcVJc5QpJ5Z4mXlecfzPLd8c6WN6SDLYdzVCr/dX5Q0AmKbbUdei
         3Zwo0yJYjQLARYhTz3G73pzojl3k9/0varZvjNHMtMfRPVGHgEYVI+VpOLS34K7nNY+f
         O7S5TpHhp7YNTNuPt5+Cc9t6YkkJMXojFs1nnWb1ox9ipXTpmiwf9G8fZZDKs6J+KM0R
         ec+fpSoVzB4QnmobpGoDK4AS1UdDBuh/yO3/xcIjfY3GikKTsMLZZ9PUe8fuCPRixeC1
         hKNJni7VxI0uvtsFaMIGMVXcCo3k6iP90YkS2i9c1BVtuBGRQq6/ZpVGgJvjYnx7fd5y
         dzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944578; x=1694549378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Bg2ttwGZhXRH+IvLxorSyd3+PUy2fTzplCQnlymx4A=;
        b=bWjEeeHZW+a6utGDhkMpgVi5wuaMSaLygeZ9Dmd+PXZ2Ue3efnyujMQR+wsfSOrqEL
         AklCDFjrcC5q/VerFmgfMgNnJJNh403ISDGscFQ5IEXQrLctsr5C4ENVmlYVUAiKK0bp
         t3ck4Z7UmFYCkrR4vwcYkdELRl05QRZaM6GPOO2Sdr7sNBC7k97ee81ZwjVFTqtRUbIk
         fMmpz9SR4jUio6p6FS4IWmiInuQxz+VApC/4BtI9dDJKofGw2e3H3kndPr/5wo8SsZtD
         UZNTg9HC4f41tx7a/nRL3yTnFG1BVytktkHoJ4osqlvYf3P72KKuNzNN3vR8mKGT64uZ
         i7Sw==
X-Gm-Message-State: AOJu0YzERrrTG0umJHIt9av01t4vZU/CgOSv/lSQBMDaqEDYc6R3+b+X
	wUJ98DM2gftKuw6m8ctT5KZXUc9YoMe450U/fOQ=
X-Google-Smtp-Source: AGHT+IHRWW+Daf1M6sC14e7UZhg9nUBvaleR10o8JR5lHRj0iHpreLU1y1DN4Q2aGqJh3zAcbKIfJzYwBeqSA4psnn4=
X-Received: by 2002:a2e:8706:0:b0:2bc:c2cb:cd3f with SMTP id
 m6-20020a2e8706000000b002bcc2cbcd3fmr537361lji.32.1693944578274; Tue, 05 Sep
 2023 13:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com> <20230827072057.1591929-3-zhouchuyi@bytedance.com>
In-Reply-To: <20230827072057.1591929-3-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Sep 2023 13:09:26 -0700
Message-ID: <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
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
>  kernel/bpf/task_iter.c         | 31 +++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  tools/lib/bpf/bpf_helpers.h    |  5 +++++
>  5 files changed, 47 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2a6e9b99564b..cfbd527e3733 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_process {
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cf113ad24837..81a2005edc26 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DE=
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
> index b1bdba40b684..a6717a76c1e0 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bp=
f_iter_css_task *it)
>         kfree(kit->css_it);
>  }
>
> +struct bpf_iter_process_kern {
> +       struct task_struct *tsk;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
> +{
> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) !=3D sizeof(str=
uct bpf_iter_process));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=3D
> +                                       __alignof__(struct bpf_iter_proce=
ss));
> +
> +       rcu_read_lock();
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
> +       rcu_read_unlock();
> +}

This iter can be used in all ctx-s which is nice, but let's
make the verifier enforce rcu_read_lock/unlock done by bpf prog
instead of doing in the ctor/dtor of iter, since
in sleepable progs the verifier won't recognize that body is RCU CS.
We'd need to teach the verifier to allow bpf_iter_process_new()
inside in_rcu_cs() and make sure there is no rcu_read_unlock
while BPF_ITER_STATE_ACTIVE.
bpf_iter_process_destroy() would become a nop.

