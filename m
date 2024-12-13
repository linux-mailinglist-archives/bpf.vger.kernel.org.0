Return-Path: <bpf+bounces-46912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D29F1840
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1642F1884C92
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF31B2180;
	Fri, 13 Dec 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvRoQU8V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63372196D90;
	Fri, 13 Dec 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127140; cv=none; b=C2+XziwRszkSOloMAZdELOS4LyfkqZgP/We5tYa8jcBn7+/x8Eb3/WlETVuiCWvCaXzJPNIRByLfkbLV2LI8xnDaRQgbxLu6NP1ppYffsmTxpY1anhnAFLx3+j0/i3MR+0tTbDmpgrBw1VpDwlvOjZqFgJwX76Ffy1t0cdFB2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127140; c=relaxed/simple;
	bh=9OYyN1lCmG3NcnyAnO4tMH4A0Hiq/8Zv2zzp0A83swQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fH7yDo8YbZibI8xLfbbUwFRDW2Ew1rDmqgc92DyUG+/eLIFQRWGZYo7ElrRvSTFReuReZJC1hr2RCsm8i95qESj8rvOajPWCocmOJ9eCkEHLuZTAPRZU/I0G97RBr15nAVYRuPhtDu09b9i/DYhcYbBpMUmWCyby80r42WIwPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvRoQU8V; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so1516205a91.3;
        Fri, 13 Dec 2024 13:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127138; x=1734731938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPni75heBWhnT9QZ82QOtsN8uoBifEgaS5c9YsgM2RM=;
        b=NvRoQU8VHMbqJBZ1rOMUKyCwhq74XIIJIavEqV8TSfZtX+1IHtEl000Ak49udeTuRW
         UHmTsNu+WnceGgpAmA8ycB/6EgPk631rqAWjZaurlE0sCWfSP96Yry29SyynNwUouejE
         8tqL5fycJ1sSBtfA8bfpZ/ywnLm9bKgvWX1OJjvpsv5OGyOn60lllPaBv/q2PDbDDRE8
         gej12MGOikKP4yX7vwqp8rLu13BM+KCkv2sBuVLsr2mvau1L8lu6kOVlzuoE5hnxecpD
         +uOWLrn/DszNlIFYOoZuo3Yc3gog96I+KxVO/0jliVxEr1+4Cm2zjcslp1Zp8kypLiZG
         LZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127138; x=1734731938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPni75heBWhnT9QZ82QOtsN8uoBifEgaS5c9YsgM2RM=;
        b=LsZSeek2pXSaNMftHsdmuMqj+aYyaFRs5MTLpAFDcybsKQwAwmZQDUcwtc4a3/Oob/
         KA6132+KvU8aGcw9zMrIp3sWM4G/409ZyTkr5TWV+rXOx8NHZKpQhpiBhTmw3B+/1NM+
         c3CCJQYhGXcBeqcrgTn/EUhzte29atPpJYWMPfOFApoJt34mqcwEH7Sj3XnHaVc3u1m/
         wS1hMWRBUyg7aopGt5pMeqfK/R9Y34I+hESVzwPf8GEGKmEDIoQYNxuHZqHSOS0Lx45h
         dOMT6HOxjfM7JXoPGkGSXRFzvjgHITIYMJD5yKdmwnrPTCHNeAQJdHHi2ggJGl4Tbz6l
         YYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0dxi7Lt/9D4uOMS1LCPXPlcNhIO+wEfudjiEFX5qXZV2kxv0/yP5XyRufqAVuo1giTpo=@vger.kernel.org, AJvYcCX5vgNe+MmAUSIYzPt+ZSlGXZJev4fi2LGi3FUjejseMksfH1MJrIae7Gz8LJAXPOODm4v2D+PE3YYLiovXSQjDEvoJ@vger.kernel.org, AJvYcCX6l8nBcs4KsAkrGPqDWYTI+Vsll6l/FmCHy0trS+X5V6ct2PMIbPsHj2VF7nv+x4jN8osh/69Jk8+4RW5n@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA22V/DlRKDPruH2Hl3idW6cHv2xcLN6q9T7Gdpz4SjLWjaWr
	hKmNtvbnVMpiCcvekx18eDq42Zf3MN34wfaua1Ki5ZhVAQh30wi1l6QCcuJUrX7b6sSEXHmpAQN
	+yHt1ILG3/BjiCkKSFv4sgYx8k50=
X-Gm-Gg: ASbGncur+TIX98OrKIuZSaYfSUVSC/9qO/Um4DJzIHQIb5dGBfqD59bgjQS4aasm/cZ
	8zARNMuAmpBhM2NDj4Sj3Di/k+RZy0lQCvSYeHdqKAkXczudQgaCwew==
X-Google-Smtp-Source: AGHT+IFqsd+CQYV6AtSjJGIg3BJGuyQc+l2hvw+ngJYzXO0eWUFUV36NYq6709MmzgHRyKb5prvA7Xz/y4ThGv6a4bI=
X-Received: by 2002:a17:90a:e70d:b0:2ee:dd79:e03c with SMTP id
 98e67ed59e1d1-2f28fd6e848mr6715668a91.20.1734127138686; Fri, 13 Dec 2024
 13:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-12-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:58:43 -0800
Message-ID: <CAEf4BzaSqWudSq6tEW3g+szAbcf+n4RO4T2wTnF2Kof0tSMW5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/13] selftests/bpf: Add hit/attach/detach race
 optimized uprobe test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that makes sure parallel execution of the uprobe and
> attach/detach of optimized uprobe on it works properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 1dbc26a1130c..eacd14db8f8d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -532,6 +532,81 @@ static void test_uprobe_usdt(void)
>  cleanup:
>         uprobe_optimized__destroy(skel);
>  }
> +
> +static bool race_stop;

volatile?

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
> +       struct uprobe_optimized *skel;
> +       unsigned long rounds =3D 0;
> +
> +       skel =3D uprobe_optimized__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
> +               goto cleanup;
> +
> +       while (!race_stop) {
> +               skel->links.test_2 =3D bpf_program__attach_uprobe_multi(s=
kel->progs.test_2, -1,
> +                                               "/proc/self/exe", "uprobe=
_test_nop5", NULL);
> +               if (!ASSERT_OK_PTR(skel->links.test_2, "bpf_program__atta=
ch_uprobe_multi"))
> +                       break;
> +               bpf_link__destroy(skel->links.test_2);
> +               skel->links.test_2 =3D NULL;
> +               rounds++;
> +       }
> +
> +       printf("tid %d attach rounds: %lu hits: %lu\n", gettid(), rounds,=
 skel->bss->executed);
> +
> +cleanup:
> +       uprobe_optimized__destroy(skel);
> +       return NULL;
> +}
> +
> +static void test_uprobe_race(void)
> +{
> +       int err, i, nr_cpus, nr;
> +       pthread_t *threads;
> +
> +        nr_cpus =3D libbpf_num_possible_cpus();

check whitespaces

> +       if (!ASSERT_GE(nr_cpus, 0, "nr_cpus"))
> +               return;
> +
> +       nr =3D nr_cpus * 2;
> +       threads =3D malloc(sizeof(*threads) * nr);
> +       if (!ASSERT_OK_PTR(threads, "malloc"))
> +               return;
> +
> +       for (i =3D 0; i < nr_cpus; i++) {
> +               err =3D pthread_create(&threads[i], NULL, worker_trigger,=
 NULL);
> +               if (!ASSERT_OK(err, "pthread_create"))
> +                       goto cleanup;
> +       }
> +
> +       for (; i < nr; i++) {
> +               err =3D pthread_create(&threads[i], NULL, worker_attach, =
NULL);
> +               if (!ASSERT_OK(err, "pthread_create"))
> +                       goto cleanup;
> +       }
> +
> +       sleep(4);
> +
> +cleanup:
> +       race_stop =3D true;
> +       for (i =3D 0; i < nr; i++)
> +               pthread_join(threads[i], NULL);

what happens with pthread_join() when called with uninitialized
threads[i] (e.g., when error happens in the middle of creating
threads)?


> +}
>  #else
>  static void test_uretprobe_regs_equal(void)
>  {
> @@ -567,6 +642,11 @@ static void test_uprobe_usdt(void)
>  {
>         test__skip();
>  }
> +
> +static void test_uprobe_race(void)
> +{
> +       test__skip();
> +}
>  #endif
>
>  void test_uprobe_syscall(void)
> @@ -585,4 +665,6 @@ void test_uprobe_syscall(void)
>                 test_uprobe_multi();
>         if (test__start_subtest("uprobe_usdt"))
>                 test_uprobe_usdt();
> +       if (test__start_subtest("uprobe_race"))
> +               test_uprobe_race();
>  }
> --
> 2.47.0
>

