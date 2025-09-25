Return-Path: <bpf+bounces-69796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8ABA1F6B
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21551C016E2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15A2ECE9A;
	Thu, 25 Sep 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwgRKnav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE352E540D
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842786; cv=none; b=nYiMEuamHYsahFWsXffSsh5YMylwwAnFwnY030guXOw23tLrpYlST8+1nVEP/9WAzY6WaxsCh6uNQ6X+bZ7DXRNlWchPcmy9CD7aMkZZE3OacXdP9uaPVCo0zWnfNM0BW8c6pNbJGsAv8JtfHa4z32aRoBy2tXUFfhxi+e/DTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842786; c=relaxed/simple;
	bh=E8JBJ89W1dnA5B4rSPdZ1pucaMGftVXzHEUT+mTcTqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfR2VYAh1NzZ12psks9qW4BKXRZiJZMXeMyGSiUjyzTQi+4SlWas2c1IKVzGAJI0IKDfFM44/btNVEyAKSwhegLSthuWRa3FZPS2k0ZeQ/vV/YY+Vazk+wT1Myi6+0Mra8X3MGtRuNVRy9jG7lSuferAgpUMtyb4Qjw2FuFAdTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwgRKnav; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1570089a91.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842783; x=1759447583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jOiIchMQ1JJMZIH01vn39aIJsVrycaAu0pdlEpcR2Y=;
        b=VwgRKnavQXqLhS+wmgMA0yHLFSVBzAzeTDrKroPgJ3Vc4xc94vZTo6PQ8t+74oaa50
         9kCGpQ8BQ8hMAasWQpgOb1hDRYd9f8SUaz4l649BSn8XJQ0dF7oflD4cmczFPPh/JDUM
         tl0pZjuvjn/T0onUZ/RrRcqF5AjYZWj4n8RM/s1syPrZa0NKj+U5EV+8zMHvJEPd2rjT
         1QR6r60lnni/F6K/92OIWQUgPjzOgvdFYGxwIaP8kFmEhQWFXht11f/fABD4Hc5WWP+P
         2ef7pw4RtH4QaWyydvvyT+HDdCr9uMO+XnRQg9BCRmsV+QdmeZr/oFFP9HPNBSmmeLLV
         wF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842783; x=1759447583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jOiIchMQ1JJMZIH01vn39aIJsVrycaAu0pdlEpcR2Y=;
        b=eftJN+/iMHKOZLhmtPW2U4ttCFZXBj+ipjkC583EBCqKHu9OlBxEEdVBkjrAGQ4JPM
         0WwHyYoNB/uDg9D0ZPOYO5sAQhbJuPCfXv1DoI3zudRiAeSVpFnZUrXvhwCyxUZuO1qU
         N8Tz7qIBEH8RHtl1yJx9DXWR0vwRiSfs0V0ZOdwvJNp49qLdDQnZQ8AIrz0Jg4Jj4Ea1
         BGUr/Tzmq554lpUhtvHwZ2Wa93oDyE28NxSx6xPxZ+8qanJQrI8/tnrIbbOGgaEzNT8i
         YeQPlcqxY6alK2XFv5dXwx8YBuNOafBFMNtVTX5oXtGb79oB2Zr5ydjqmQRjOs8Nn80y
         Z1pg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oSuAk8HGcbnhU8lbh/9aulkQzkuW87ASKY1ih1k0TZ9YLlOtqw7Ddtt6jC5mqrOG/EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQqsrfyRNKLMe4wh2DDvCW7to//PQSK6qdUsd/hNY9xw39mO7
	j0Dw9zqeHl61FkwULATGRuzRb4kgS2Lik3/ceIdML6AGYcx4Rr33sLVMlKzzOB8dhL0ZJM66qdd
	8m5CrUz5LiTYZMXiCMahLY866XL3lXSQ=
X-Gm-Gg: ASbGncv/bcL5chF4kaUyslvytKiKOKwg176UaZtQSaYbQ7NG2bJEYsVe6FElp8FIt8D
	hKX0hkuip7zaYc++RZP+urRozsohowTxP3fTs/W1AoghWUaeK7Ocn8CEOALIJ526nxD9pBjfdZZ
	OFprkyC3g70pbEf8ECV5Qkb68TQUGBHr4JUUcMPrVVdS8Z2DtH+Yvu3Jy7QNvtg/gwBIGpIdjP1
	yCs0elNHXAA/EzJ55hpV8w=
X-Google-Smtp-Source: AGHT+IHf1jfsAiU5hPHlXehiGDqM+d/xqS5v8XwFiSK8R2NFV+i7UZyjbTub5Pk71oMcUMT4N+4J5OvxLzgyrVg3H3M=
X-Received: by 2002:a17:90b:3b4b:b0:329:e4d1:c20f with SMTP id
 98e67ed59e1d1-3342a2595a2mr5598729a91.9.1758842783479; Thu, 25 Sep 2025
 16:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115145.1916664-1-jolsa@kernel.org>
In-Reply-To: <20250925115145.1916664-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:26:08 -0700
X-Gm-Features: AS18NWCqWPVGvQ2HpYY5Hmu8gt4Sw3DbGNn3h3pGF_fIMXhUQoyMv2d6y6Jt8d0
Message-ID: <CAEf4BzYPkuD0SnfhjwWU3X_HaRGk-gSVqe_-AxYe7P5kfAZ9Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add stacktrace test for kprobe multi
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Feng Yang <yangfeng59949@163.com>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:51=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding stacktrace test for kprobe multi probe.
>
> Cc: Feng Yang <yangfeng59949@163.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> test for arm64 fix posted separately in here:
>   https://lore.kernel.org/bpf/20250925020822.119302-1-yangfeng59949@163.c=
om/
>
>  .../selftests/bpf/prog_tests/stacktrace_map.c | 107 +++++++++++++-----
>  .../selftests/bpf/progs/test_stacktrace_map.c |  28 ++++-
>  2 files changed, 106 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/to=
ols/testing/selftests/bpf/prog_tests/stacktrace_map.c
> index 84a7e405e912..922224adc86b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> @@ -1,13 +1,44 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "test_stacktrace_map.skel.h"
>

Tao just refactored this to skeleton, so please rebase and adjust according=
ly

pw-bot: cr


> -void test_stacktrace_map(void)
> +static void check_stackmap(int control_map_fd, int stackid_hmap_fd,
> +                          int stackmap_fd, int stack_amap_fd)
> +{
> +       __u32 key, val, duration =3D 0;
> +       int err, stack_trace_len;
> +
> +       /* disable stack trace collection */
> +       key =3D 0;
> +       val =3D 1;
> +       bpf_map_update_elem(control_map_fd, &key, &val, 0);
> +
> +       /* for every element in stackid_hmap, we can find a corresponding=
 one
> +        * in stackmap, and vice versa.
> +        */
> +       err =3D compare_map_keys(stackid_hmap_fd, stackmap_fd);
> +       if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
> +                 "err %d errno %d\n", err, errno))
> +               return;
> +
> +       err =3D compare_map_keys(stackmap_fd, stackid_hmap_fd);
> +       if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
> +                 "err %d errno %d\n", err, errno))
> +               return;
> +
> +       stack_trace_len =3D PERF_MAX_STACK_DEPTH * sizeof(__u64);
> +       err =3D compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace=
_len);
> +       CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> +               "err %d errno %d\n", err, errno);
> +}
> +
> +static void test_stacktrace_map_tp(void)
>  {
>         int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
>         const char *prog_name =3D "oncpu";
> -       int err, prog_fd, stack_trace_len;
> +       int err, prog_fd;
>         const char *file =3D "./test_stacktrace_map.bpf.o";
> -       __u32 key, val, duration =3D 0;
> +       __u32 duration =3D 0;
>         struct bpf_program *prog;
>         struct bpf_object *obj;
>         struct bpf_link *link;
> @@ -44,32 +75,56 @@ void test_stacktrace_map(void)
>         /* give some time for bpf program run */
>         sleep(1);
>
> -       /* disable stack trace collection */
> -       key =3D 0;
> -       val =3D 1;
> -       bpf_map_update_elem(control_map_fd, &key, &val, 0);
> -
> -       /* for every element in stackid_hmap, we can find a corresponding=
 one
> -        * in stackmap, and vice versa.
> -        */
> -       err =3D compare_map_keys(stackid_hmap_fd, stackmap_fd);
> -       if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
> -                 "err %d errno %d\n", err, errno))
> -               goto disable_pmu;
> -
> -       err =3D compare_map_keys(stackmap_fd, stackid_hmap_fd);
> -       if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
> -                 "err %d errno %d\n", err, errno))
> -               goto disable_pmu;
> -
> -       stack_trace_len =3D PERF_MAX_STACK_DEPTH * sizeof(__u64);
> -       err =3D compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace=
_len);
> -       if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> -                 "err %d errno %d\n", err, errno))
> -               goto disable_pmu;
> +       check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stac=
k_amap_fd);
>
>  disable_pmu:
>         bpf_link__destroy(link);
>  close_prog:
>         bpf_object__close(obj);
>  }
> +
> +static void test_stacktrace_map_kprobe_multi(bool retprobe)
> +{
> +       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
> +               .retprobe =3D retprobe
> +       );
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       struct test_stacktrace_map *skel;
> +       struct bpf_link *link;
> +       int prog_fd, err;
> +
> +       skel =3D test_stacktrace_map__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_stacktrace_map__open_and_load"))
> +               return;
> +
> +       link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.kprobe=
,
> +                                                    "bpf_fentry_test1", =
&opts);
> +       if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts")=
)
> +               goto cleanup;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.trigger);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_run");
> +       ASSERT_EQ(topts.retval, 0, "test_run");
> +
> +       control_map_fd  =3D bpf_map__fd(skel->maps.control_map);
> +       stackid_hmap_fd =3D bpf_map__fd(skel->maps.stackid_hmap);
> +       stackmap_fd     =3D bpf_map__fd(skel->maps.stackmap);
> +       stack_amap_fd   =3D bpf_map__fd(skel->maps.stack_amap);
> +
> +       check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stac=
k_amap_fd);
> +
> +cleanup:
> +       test_stacktrace_map__destroy(skel);
> +}
> +
> +void test_stacktrace_map(void)
> +{
> +       if (test__start_subtest("tp"))
> +               test_stacktrace_map_tp();
> +       if (test__start_subtest("kprobe_multi"))
> +               test_stacktrace_map_kprobe_multi(false);
> +       if (test__start_subtest("kretprobe_multi"))
> +               test_stacktrace_map_kprobe_multi(true);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/to=
ols/testing/selftests/bpf/progs/test_stacktrace_map.c
> index 47568007b668..7a27e162a407 100644
> --- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> @@ -3,6 +3,7 @@
>
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
>
>  #ifndef PERF_MAX_STACK_DEPTH
>  #define PERF_MAX_STACK_DEPTH         127
> @@ -50,8 +51,7 @@ struct sched_switch_args {
>         int next_prio;
>  };
>
> -SEC("tracepoint/sched/sched_switch")
> -int oncpu(struct sched_switch_args *ctx)
> +static inline void test_stackmap(void *ctx)
>  {
>         __u32 max_len =3D PERF_MAX_STACK_DEPTH * sizeof(__u64);
>         __u32 key =3D 0, val =3D 0, *value_p;
> @@ -59,7 +59,7 @@ int oncpu(struct sched_switch_args *ctx)
>
>         value_p =3D bpf_map_lookup_elem(&control_map, &key);
>         if (value_p && *value_p)
> -               return 0; /* skip if non-zero *value_p */
> +               return; /* skip if non-zero *value_p */
>
>         /* The size of stackmap and stackid_hmap should be the same */
>         key =3D bpf_get_stackid(ctx, &stackmap, 0);
> @@ -69,7 +69,29 @@ int oncpu(struct sched_switch_args *ctx)
>                 if (stack_p)
>                         bpf_get_stack(ctx, stack_p, max_len, 0);
>         }
> +}
> +
> +SEC("tracepoint/sched/sched_switch")
> +int oncpu(struct sched_switch_args *ctx)
> +{
> +       test_stackmap(ctx);
> +       return 0;
> +}
>
> +/*
> + * No tests in here, just to trigger 'bpf_fentry_test*'
> + * through tracing test_run.
> + */
> +SEC("fentry/bpf_modify_return_test")
> +int BPF_PROG(trigger)
> +{
> +       return 0;
> +}
> +
> +SEC("kprobe.multi")
> +int kprobe(struct pt_regs *ctx)
> +{
> +       test_stackmap(ctx);
>         return 0;
>  }
>

Can you please expland the set of program types you are testing:
kprobe/kretprobe, kprobe.multi/kretprobe.multi, fentry/fexit/fmod_ret,
maybe even uprobe/uretprobe?

Also, for check_stack_ips(), can we make sure that we look for
expected >1 IPs there? We had (still have?) issues where we'd get
(successfully) stack trace with just single (but valid!) entry
corresponding to traced function, but nothing beyond that. Which
clearly is broken. So it would be good to be able to detect this going
forward.

> --
> 2.51.0
>

