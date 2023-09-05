Return-Path: <bpf+bounces-9281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FABC792FDD
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 22:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493671C209D6
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65362DF58;
	Tue,  5 Sep 2023 20:22:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEBDDCE
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 20:22:49 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77740CC;
	Tue,  5 Sep 2023 13:22:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so44141011fa.2;
        Tue, 05 Sep 2023 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945366; x=1694550166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG5rfBSuPXfXle+iI7qfryofXP3nifEMoZ37UvmA0n8=;
        b=sThmf14zJl8SRFMRn6NvBI4FNvLHQzOTRCvnp/i1N8ogDRsnU3kFHUU2mjwEJ88yGG
         5g4t/bGnuXaEOajN7Wf3tjhr4KXARGwDEsGdEUBXx3cBOXv/6pLBsgask/UaqoCQBvoK
         wppxyQu3Y6X5+TJEtiDllzQQCp7Ifwx1NO9zRm7vauLFCMa/njWiYnFIkgZrQDena4EZ
         wQKHSyVgVd/d//NQDmmP798Ib7YJYMgCuQgNCVf44TZ+qv8qUXCyVWTM7YGYEuVuOdn9
         rEHddAw4do8PCPQ18OyJbM+ulpAVonlDEm9Oa4bveNvOIm+UBnAaCtr+ST4o4N5WSpSX
         EuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945366; x=1694550166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG5rfBSuPXfXle+iI7qfryofXP3nifEMoZ37UvmA0n8=;
        b=NtB0HK/SC3bKn+WC6qH454NEqHP5bsaEwKKt966e/fgVEDDyFcMIddlaGgp5GurjBC
         E964i3gX4I5wxotqi+kwTvKOA5pVQeVvEIdRS3w9NluRoG3F96KZTCfXKfi45Hjfm3Nk
         PCdu/OQ26OLuGdpp48jv3SNL6CXdoFC+Aa4vrARNSZY/xNNJjlEnIPhgNeQmIalIiUx9
         hKohmS3KQvW5wBVCPEM/7h3CPF0zGIFsDGqKe7eNOdALwBIfv7Gpn22Y8AjilcebQHmS
         emD40R9UD1BbEpctYgBS4MATM+yaCzwI3pgTD52yGf19zE7m6tBAwEiPrF8Mo6HKwwOE
         gqJA==
X-Gm-Message-State: AOJu0YzLoNZbWEB0yE3QXVgoaSWcPg8ZlK0GfrXmNocu6Lg2FogDJF6d
	96AoAnKC6asD2gKyasTZXpanhOe/nEhQW3UYg4A=
X-Google-Smtp-Source: AGHT+IElFCbjQ8SNtWknYAVBmUIgOQnWgkA8SKNq1xMdkZKmNfW5urzHgHNVH3M6IIja9nXx7Gmyy5EEMK046lLflyQ=
X-Received: by 2002:a2e:9646:0:b0:2bc:b9cd:8bc2 with SMTP id
 z6-20020a2e9646000000b002bcb9cd8bc2mr596401ljh.4.1693945366347; Tue, 05 Sep
 2023 13:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com> <20230827072057.1591929-4-zhouchuyi@bytedance.com>
In-Reply-To: <20230827072057.1591929-4-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Sep 2023 13:22:35 -0700
Message-ID: <CAADnVQLbDWUxFen-RS67C86sOE5DykEPD8xyihJ2RnG1WEnTQg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/4] bpf: Introduce css_descendant open-coded
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
> This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow creati=
on
> and manipulation of struct bpf_iter_css in open-coded iterator style. The=
se
> kfuncs actually wrapps css_next_descendant_{pre, post}. BPF programs can
> use these kfuncs through bpf_for_each macro for iteration of all descenda=
nt
> css under a root css.
>
> Normally, css_next_descendant_{pre, post} should be called with rcu
> locking. Although we have bpf_rcu_read_lock(), here we still calls
> rcu_read_lock in bpf_iter_css_new and unlock in bpf_iter_css_destroy
> for convenience use.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/bpf/helpers.c           |  3 +++
>  kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  tools/lib/bpf/bpf_helpers.h    |  6 ++++++
>  5 files changed, 58 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index cfbd527e3733..19f1f1bf9301 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7203,4 +7203,9 @@ struct bpf_iter_process {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_css {
> +       __u64 __opaque[2];
> +       char __opaque_c[1];

Burning extra 8 bytes for flags seems excessive.
Maybe let's add two iterators for descendant_post/_pre ?
The bpf prog code will be easier to read (no need to guess
what bool flag does).

> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 81a2005edc26..47d46a51855f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2461,6 +2461,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_IT=
ER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index a6717a76c1e0..ef9aef62f1ac 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -893,6 +893,45 @@ __bpf_kfunc void bpf_iter_process_destroy(struct bpf=
_iter_process *it)
>         rcu_read_unlock();
>  }
>
> +struct bpf_iter_css_kern {
> +       struct cgroup_subsys_state *root;
> +       struct cgroup_subsys_state *pos;
> +       char flag;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
> +               struct cgroup_subsys_state *root, char flag)
> +{
> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) !=3D sizeof(struct =
bpf_iter_css));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) !=3D __alignof=
__(struct bpf_iter_css));
> +       kit->root =3D root;
> +       kit->pos =3D NULL;
> +       kit->flag =3D flag;
> +       rcu_read_lock();

Same request as in previous patch.
let's make bpf prog do explicit bpf_rcu_read_lock() instead.

