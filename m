Return-Path: <bpf+bounces-56523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E3A996E9
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CD53B1894
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7A28B51F;
	Wed, 23 Apr 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+XDfQKt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B571E2606;
	Wed, 23 Apr 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430191; cv=none; b=efCa/ZrisRCSACJGq8mbisufJ06rax4SXgg4d/POXsR1N1sDb/hInM33yhcCuM49cjyGUF8gQiB2Ziq5Fhacq3+uRUGr5pUl2vsE6L8PLgkUgFWPKXwV+Jbk5kRXoA067jhUn0dBHgq2YNQAgTI3w+9F6zyiFnptcF4zbkVI8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430191; c=relaxed/simple;
	bh=+8FuCXliR7Sh5+WQAqDov6nkJq5rLDmeeDLHLPKGMns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooihD2RMtVN2NAZqBGFkemcjf6oQNJy6WLrXpz5xzVyup5FoTAHqa4p71nzK9FDrUmBvVHKrcpPjUtej8PehAQPhBuOaTo9Cu2wMcQb92wEXe8qBRduHTZYilVrhYvUwOFHQuDb3GruGeOUJS2dIeWT19wucyREH16Z1Y32uAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+XDfQKt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so74005a12.3;
        Wed, 23 Apr 2025 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430188; x=1746034988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eYzztrxqYmwtL32idvJrHAmTSxdLtXWuOg4q1z2AgA=;
        b=m+XDfQKt+O4kRvJtHyN02y6023JtlmpuUk71yn0G/cwnL2aToOzUHgAnUIXegBapSX
         6jFxo4DyfqLZ0790UuS59Zt3ov3kg/DzNWQXvuE4PGN42iVokQsGRVor+GXPMDXsKmac
         0AWIRKSFX8GBJWGISpLUCv4VkFPISa7XXgN9b1NJraefxZeQO8kv2VoUP/lU/4uIqNwg
         kWSLr+o3vRCd0ZcIEUXk2iUarvxJW+dl80LwZ2toUfs2N325+9jPjG6X/aRfu6S9/jrf
         9OoO4GGrGRQ6HzfWUj7Zz/q1s1S4deFUZAbdTv1rQu4SvvRTDk5tclcqWTvWw2AVAY1z
         8KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430188; x=1746034988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eYzztrxqYmwtL32idvJrHAmTSxdLtXWuOg4q1z2AgA=;
        b=olsZfbIX5u/Qrpdovu8WUREDghwkY6S5RNlWSpUc/YFI4ysq7ljq5H887HJCVwRpBh
         m/YlgS07I0LS8EdZSGhY8L72OqqNPnQCatKh05/06M5B9O8LyXEP02rJZRk2/pMzZkPT
         R2OyJVMa+yXOIvEMcTlJd751ABeCqV8Hi+fOkw0LxKNoFxDGPZJpx0GWN7k/6hp+WL3b
         RY4oUXqnkte2865NlCLeqAYh9arNME0VlgM0kiUQW4/z4yIApaEwWWccbSYQ4ZRA1O+Q
         MFI7Yz9r0EVdArgsNfOWAw6/ufk9fy2+sYfVia8svWFVqoEVfh5QdmTFyUfEkvBPRPk1
         TsMg==
X-Forwarded-Encrypted: i=1; AJvYcCUriJy/JhLLvAfogcfzTFUSoDN8VRCQRFB89lqdLzLoYQ1yIJBsunVS0E0pGr/crAEpwwfNrkvYamKYnXqJ@vger.kernel.org, AJvYcCUvI+YS2Zpooyq8FORfc5iQDZnSqO20BXcbK96KDQnOPi3+J0R6rVckfYmsnHct5vjL2EI=@vger.kernel.org, AJvYcCXj9xFDAJKn0u4yoCY5Xswq19H9UW+7MYlHVI7XQIHeoNJpfLApbqg6TgExVJTXUrRHmypAREqlgyE2XtUvlldlFreJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6aqb6pDhx33bue/t7seSJqU0WVnSv9WXNW/R2taxBYOVEJKC
	XkYiTKAsEjdRbmKirpJx+tl/M3h8phHhA6Aea2J4LvIxPRcjPNUtWPwVXjHLO+VSCk2mJ0buPeq
	E2DFlkSucXO+pZzCqgxy+9aF2sb4=
X-Gm-Gg: ASbGncsCw3s/8vEN4xpvHyuFpJbBNXKFPkeAkP5Xn2Goc0hlpTjWupmH8/t2+ZctEQw
	jLCJ1WDYJ7INaJ8pUoibTAMLX/9C2Xqg7mcY3/K774PCv9HEkIOz5pKYGth7qVF6nXonPOXhTL3
	s6riLqf/EMxcrLWaE6hpefcac/Pl1dxnK2tTJFLQ==
X-Google-Smtp-Source: AGHT+IHXd0on92VT+gmVZt1P4fLkld0sTQVZDwvJsJccEsFCbUff8BPcfSvd3qVXWnEguhpeO/Qdslc8xzwk36haHHs=
X-Received: by 2002:a17:907:961e:b0:ac3:aae:40c6 with SMTP id
 a640c23a62f3a-ace54d9eb86mr955466b.8.1745430187628; Wed, 23 Apr 2025 10:43:07
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-16-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-16-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:42:43 -0700
X-Gm-Features: ATxdqUExMatx3OeFiDoCcS4IOVeLXgYX5IwL4jpxPEJRvx4gZYVr45AlrufaKtQ
Message-ID: <CAEf4Bzb+LT2nTTjVXi3ATu9AsYSxZJr2XzegA09Cm8izNG=grg@mail.gmail.com>
Subject: Re: [PATCH perf/core 15/22] selftests/bpf: Add hit/attach/detach race
 optimized uprobe test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:47=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that makes sure parallel execution of the uprobe and
> attach/detach of optimized uprobe on it works properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 16effe0bca1d..57ef1207c3f5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -619,6 +619,78 @@ static void test_uretprobe_shadow_stack(void)
>         ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
>  }
>
> +static volatile bool race_stop;
> +
> +static void *worker_trigger(void *arg)
> +{
> +       unsigned long rounds =3D 0;
> +
> +       while (!race_stop) {
> +               uprobe_test();
> +               rounds++;
> +       }
> +
> +       printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
> +       return NULL;
> +}
> +
> +static void *worker_attach(void *arg)
> +{
> +       struct uprobe_syscall_executed *skel;
> +       unsigned long rounds =3D 0, offset;
> +
> +       offset =3D get_uprobe_offset(&uprobe_test);
> +       if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
> +               return NULL;
> +
> +       skel =3D uprobe_syscall_executed__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"=
))
> +               return NULL;
> +
> +       while (!race_stop) {
> +               skel->links.test_uprobe =3D bpf_program__attach_uprobe_op=
ts(skel->progs.test_uprobe,
> +                                       0, "/proc/self/exe", offset, NULL=
);
> +               if (!ASSERT_OK_PTR(skel->links.test_uprobe, "bpf_program_=
_attach_uprobe_opts"))
> +                       break;
> +
> +               bpf_link__destroy(skel->links.test_uprobe);
> +               skel->links.test_uprobe =3D NULL;
> +               rounds++;
> +       }
> +
> +       printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, =
skel->bss->executed);
> +       uprobe_syscall_executed__destroy(skel);
> +       return NULL;
> +}
> +
> +static void test_uprobe_race(void)
> +{
> +       int err, i, nr_threads;
> +       pthread_t *threads;
> +
> +       nr_threads =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))

I hope there are strictly more than zero CPUs... ;)

> +               return;
> +
> +       threads =3D malloc(sizeof(*threads) * nr_threads);
> +       if (!ASSERT_OK_PTR(threads, "malloc"))
> +               return;
> +
> +       for (i =3D 0; i < nr_threads; i++) {
> +               err =3D pthread_create(&threads[i], NULL, i % 2 ? worker_=
trigger : worker_attach,
> +                                    NULL);

What happens when three is just one CPU?

> +               if (!ASSERT_OK(err, "pthread_create"))
> +                       goto cleanup;
> +       }
> +
> +       sleep(4);
> +
> +cleanup:
> +       race_stop =3D true;
> +       for (nr_threads =3D i, i =3D 0; i < nr_threads; i++)
> +               pthread_join(threads[i], NULL);
> +}
> +
>  static void __test_uprobe_syscall(void)
>  {
>         if (test__start_subtest("uretprobe_regs_equal"))
> @@ -637,6 +709,8 @@ static void __test_uprobe_syscall(void)
>                 test_uprobe_session();
>         if (test__start_subtest("uprobe_usdt"))
>                 test_uprobe_usdt();
> +       if (test__start_subtest("uprobe_race"))
> +               test_uprobe_race();
>  }
>  #else
>  static void __test_uprobe_syscall(void)
> --
> 2.49.0
>

