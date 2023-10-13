Return-Path: <bpf+bounces-12181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E337C8F04
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8311C2122A
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B5262BF;
	Fri, 13 Oct 2023 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd7hjyYE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA951262A6
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 21:27:46 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C816B7;
	Fri, 13 Oct 2023 14:27:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53406799540so4444844a12.1;
        Fri, 13 Oct 2023 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697232461; x=1697837261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p64ey+Hmhn7w3szjg3EYf/Ayo/C6KBIGFFRqgW96fX8=;
        b=bd7hjyYEsBrda63hdg63s5Vh4xWK3rTNekLm+RQ2DLUJDo3BfyxnHHIouyj7mHQpV9
         HHLEBUolvJnRr6lN+pBCyFBmSXFct0/AiIvvJEkKcv5dj+oHG9he9wkAWC+/yUZiFMCl
         rUTRIPtlmY5884tGRgLsZxWSUvGq7xtrUYuOYdhb8G9nelEr1yWlZqvzwSv6z4m96616
         SpSeSMlCJV0++W3dz+ErzLSqGZRlwzcQRuaL1emvAXbv3u1fYRcr3yI03DVzlbyG2ocC
         UYHMBFwaiYnLMl/Ax0uMy+wUR/Bsn/SM9g/9WLGrFrUQgPLCRGGVycBPawDQUvigcKhz
         DA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232461; x=1697837261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p64ey+Hmhn7w3szjg3EYf/Ayo/C6KBIGFFRqgW96fX8=;
        b=GQuqEGJ3yKDoGrMUmEeojykGi9LqcYDz+H69T1oWa2147QLyj/BZf7ZFs1bTbUaczI
         hay7Y4Lws/D40ybvtIVVeAa1CJu8lvYqL3XHvFj8yoaJGyFYJIFLHjtogobmGfFiwcbL
         kiOQBiAxZkgAAOSFV4nUXeZyO45vCOEt9HqsHU4BQcehpui/eMTm4XQ1AH3JnOlbyVXr
         MqhDBZuNHGnXOIVocE/UN2JC3M7b9m2XNY0Xc+2YjBPHqJlwDZosX3yi+ibG3Audq7Ch
         LxBB9Sa2BdDT1Yl0uAA2+JmRt/dp/nWrOEEJT+E1+27hqHLt4+3xlmC+YzJzXhz8LXzG
         lu0A==
X-Gm-Message-State: AOJu0YyVGQHVJQ9lTcIi2EGHOumJr3arrlyy/mcfQOzVklkLoLsoKY83
	I6LX+cLnHXRk7Kxl0rqPEsj0gXs7mlb3eYdtUq8=
X-Google-Smtp-Source: AGHT+IHPGcu2EB1bm/0u9gz5uCaZqXdXtC5UVnZ8P9PhwBQnx5m+sVbWM0P8miuQ+kj6z3Jd6yenMsPAQcC1LNKDFwA=
X-Received: by 2002:aa7:d1d8:0:b0:523:4a4e:3b57 with SMTP id
 g24-20020aa7d1d8000000b005234a4e3b57mr24337173edp.13.1697232461447; Fri, 13
 Oct 2023 14:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011120857.251943-1-zhouchuyi@bytedance.com> <20231011120857.251943-8-zhouchuyi@bytedance.com>
In-Reply-To: <20231011120857.251943-8-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 14:27:30 -0700
Message-ID: <CAEf4BzYytbg+ZqR9vWm8f0XSi9ZvAqFhoE_-bD6A7ZBXVkic7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/8] selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
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

On Wed, Oct 11, 2023 at 5:09=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> The newly-added struct bpf_iter_task has a name collision with a selftest
> for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
> renamed in order to avoid the collision.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  .../selftests/bpf/prog_tests/bpf_iter.c        | 18 +++++++++---------
>  .../{bpf_iter_task.c =3D> bpf_iter_tasks.c}      |  0
>  2 files changed, 9 insertions(+), 9 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c =3D> bpf_iter_=
tasks.c} (100%)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..dc60e8e125cd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -7,7 +7,7 @@
>  #include "bpf_iter_ipv6_route.skel.h"
>  #include "bpf_iter_netlink.skel.h"
>  #include "bpf_iter_bpf_map.skel.h"
> -#include "bpf_iter_task.skel.h"
> +#include "bpf_iter_tasks.skel.h"
>  #include "bpf_iter_task_stack.skel.h"
>  #include "bpf_iter_task_file.skel.h"
>  #include "bpf_iter_task_vma.skel.h"
> @@ -215,12 +215,12 @@ static void *do_nothing_wait(void *arg)
>  static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
>                                      int *num_unknown, int *num_known)
>  {
> -       struct bpf_iter_task *skel;
> +       struct bpf_iter_tasks *skel;
>         pthread_t thread_id;
>         void *ret;
>
> -       skel =3D bpf_iter_task__open_and_load();
> -       if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
> +       skel =3D bpf_iter_tasks__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
>                 return;
>
>         ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_l=
ock");
> @@ -239,7 +239,7 @@ static void test_task_common_nocheck(struct bpf_iter_=
attach_opts *opts,
>         ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,
>                      "pthread_join");
>
> -       bpf_iter_task__destroy(skel);
> +       bpf_iter_tasks__destroy(skel);
>  }
>
>  static void test_task_common(struct bpf_iter_attach_opts *opts, int num_=
unknown, int num_known)
> @@ -307,10 +307,10 @@ static void test_task_pidfd(void)
>
>  static void test_task_sleepable(void)
>  {
> -       struct bpf_iter_task *skel;
> +       struct bpf_iter_tasks *skel;
>
> -       skel =3D bpf_iter_task__open_and_load();
> -       if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
> +       skel =3D bpf_iter_tasks__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
>                 return;
>
>         do_dummy_read(skel->progs.dump_task_sleepable);
> @@ -320,7 +320,7 @@ static void test_task_sleepable(void)
>         ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
>                   "num_success_copy_from_user_task");
>
> -       bpf_iter_task__destroy(skel);
> +       bpf_iter_tasks__destroy(skel);
>  }
>
>  static void test_task_stack(void)
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_tasks.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/progs/bpf_iter_task.c
> rename to tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> --
> 2.20.1
>

