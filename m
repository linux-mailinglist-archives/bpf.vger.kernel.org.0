Return-Path: <bpf+bounces-69794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9EBA1F38
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63258622E92
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF182EBDC8;
	Thu, 25 Sep 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrIK6RiW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590752D24B4
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842327; cv=none; b=sJ2LHXVDP6DQM3ENc2m6jiqig+ifrF3de9nm0d4V+tCIrhDtrjq19seb2q1W1j8zWSJ2zFvkOLeUcAds6KcaD6zwm/cV/suiuhafzYd63DvU2Fcq3wT9SVrZJRJzCTApmYk7CKf1VGiz+iqRceXnNOxL7gZoW8XKu+SNt498a1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842327; c=relaxed/simple;
	bh=qFTJssQ7V5gmIShr5SgtCLAlxH+JqTUzhHAJY7SopgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTBDRV9CiPpNrorCuLOQo3+gkEH7dkc/79dVjpwO4PdEZ9CTYArq37KrD3Jh63EfUCz4GuiavmjlGP7/Xq4xjbb3wqyG6VBePkIwjw0CXOJLJwlXJoMPMIlQMuumTh+luLYxGliP+thW6gN+0cKDuE75i7fz1eeH7D5KzzMHDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrIK6RiW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330b4739538so1644641a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842325; x=1759447125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYYGKGreb8msl9z8V8yfwZfE9vFx1hRwTOFI3F2vUF0=;
        b=TrIK6RiWrSyvC+FHnrh9L721bEyEF5BxKth+zzVWDW+DgUdgAMieen8MgmqujOjMsd
         o5cjg6OH/CXRzbj0g7axaHL5Md0yZQ7zwY0QhbK26veCOTVhirmUtZI3Fp35OOhTlUvD
         gEr/dnWyHZKEFCnpzs1/qetFdRuEhEqbtA96751n3vBcGHBTq6PHh9cmXuvWlcgKJl7i
         0ZuWHz9+AsO9lRTfhvKsH3d56D5dzasyDwVg+P/YkWckoQw65cH6YnZZqUtn2SwYpdJv
         wQiEeTRjz34JnZMqHZ8U7dKLOORhzY5fIG/bqSXZAbTaY8LhtedymkLpc1OW+uxeEXsP
         mFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842325; x=1759447125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYYGKGreb8msl9z8V8yfwZfE9vFx1hRwTOFI3F2vUF0=;
        b=Vyql6TrN5A4o36dVY+APiT96Ldzb93gcZRtdubV0aFBnCuPw/gDnv31SPmYVWDjiNW
         5TEtlOAriollqPx5TTVj5K/zoRJ4u36bwRRRkyzaPLiF6vnKyDoT0p2Vw025M/W/sQCy
         znccdpnLhn5FjAIv2U1GbQZeqQX/pp7dJTHQImnWKfhaPdcpOc2aA04aWG+Pv0O2T252
         7A2jlRhEMGAOmMqZWXINLyKe4UZa2KkMLbxsU3uJ34VnMh2B0vRIdge1We0hiti+BrFs
         b4isCMQ920u0snJtG9aLJ3cHb01dDAA1XmcfQ9QHQRWvqSLlWRf1H5Nj6WxfvEyMrb/y
         aUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXc4iC9lwMW6IarJozWluu+M0V/2++YUwdJpUzH0ibNvXacPW3IgP1Bpdb4Hf/aZXXo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vnlU/m7Aj9zwPwp/rzLyoVuL/q9/lRrFQyXiGFcf9tPhxBpR
	UV+2eM69UmXAjRvpH4CG6hvLCpFK26Akc3TR+SARms2aJoRx25fjKn18utbzqvRUMRk0guMJ/qb
	JAhmM8sUAAksOXcFZGRC1yf/YVpuijcM=
X-Gm-Gg: ASbGncvLS0RWM37sQSxcarEU2E4fiWJDHDEIO3U1NZP7xw9FP+028RKLsU1Ip5RFQhW
	IFiF2+gEWHKxN/06XuEiGvQhGdTwd7wUREdEFO8AL8f9/Oe5Iqn+ZEFGvcTTgRkcjWPyc6lQYoC
	MPMzQ6yo+RIZHMLdB4J8XtrFC/9PaJFyu5aX03VXXbys5Ezi4y86JWtaqXcsIiC1pxMkdTEQ7y0
	Q/LGHBS3i/5G3UXWSsl0/iK9eKHMOWqvw==
X-Google-Smtp-Source: AGHT+IGYld1+llGw0fhAWvRZbyedILYQkjNTXEXfvu9zej1pt8n/zCDLxGKEF9uLrkyd65OzdUqtAVI7tzNoAAffd4c=
X-Received: by 2002:a17:90b:57c6:b0:32e:c649:e583 with SMTP id
 98e67ed59e1d1-3342a2abae9mr4943477a91.22.1758842325551; Thu, 25 Sep 2025
 16:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925175030.1615837-1-chen.dylane@linux.dev> <20250925175030.1615837-2-chen.dylane@linux.dev>
In-Reply-To: <20250925175030.1615837-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:18:29 -0700
X-Gm-Features: AS18NWBkW02RquM0j6OscS-5CT4rojiZgFssMTzBdUlAfYFPAnAj4IHKeCYzs4g
Message-ID: <CAEf4BzYE7vYob3ZC8Zyjnfxh0oN3hv1TWFZkjXvi5hTeuqfiwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/3] selftests/bpf: Refactor stacktrace_map
 case with skeleton
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:51=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> The loading method of the stacktrace_map test case looks too outdated,
> refactor it with skeleton, and we can use global avariable feature in

typo: variable, fixed

> the next patch.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/stacktrace_map.c | 52 ++++++++-----------
>  .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  2 +-
>  ...test_stacktrace_map.c =3D> stacktrace_map.c} |  0
>  3 files changed, 22 insertions(+), 32 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{test_stacktrace_map.c =3D> sta=
cktrace_map.c} (100%)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/to=
ols/testing/selftests/bpf/prog_tests/stacktrace_map.c
> index 84a7e405e91..0a79bf1d354 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> @@ -1,46 +1,38 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "stacktrace_map.skel.h"
>
>  void test_stacktrace_map(void)
>  {
> +       struct stacktrace_map *skel;
>         int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> -       const char *prog_name =3D "oncpu";
> -       int err, prog_fd, stack_trace_len;
> -       const char *file =3D "./test_stacktrace_map.bpf.o";
> +       int err, stack_trace_len;
>         __u32 key, val, duration =3D 0;
> -       struct bpf_program *prog;
> -       struct bpf_object *obj;
> -       struct bpf_link *link;
>
> -       err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, =
&prog_fd);
> -       if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> +       skel =3D stacktrace_map__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>                 return;
>
> -       prog =3D bpf_object__find_program_by_name(obj, prog_name);
> -       if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name)=
)
> -               goto close_prog;
> -
> -       link =3D bpf_program__attach_tracepoint(prog, "sched", "sched_swi=
tch");
> -       if (!ASSERT_OK_PTR(link, "attach_tp"))
> -               goto close_prog;
> -
>         /* find map fds */
> -       control_map_fd =3D bpf_find_map(__func__, obj, "control_map");
> +       control_map_fd =3D bpf_map__fd(skel->maps.control_map);
>         if (CHECK_FAIL(control_map_fd < 0))
> -               goto disable_pmu;
> +               goto out;
>
> -       stackid_hmap_fd =3D bpf_find_map(__func__, obj, "stackid_hmap");
> +       stackid_hmap_fd =3D bpf_map__fd(skel->maps.stackid_hmap);
>         if (CHECK_FAIL(stackid_hmap_fd < 0))
> -               goto disable_pmu;
> +               goto out;
>
> -       stackmap_fd =3D bpf_find_map(__func__, obj, "stackmap");
> +       stackmap_fd =3D bpf_map__fd(skel->maps.stackmap);
>         if (CHECK_FAIL(stackmap_fd < 0))
> -               goto disable_pmu;
> +               goto out;
>
> -       stack_amap_fd =3D bpf_find_map(__func__, obj, "stack_amap");
> +       stack_amap_fd =3D bpf_map__fd(skel->maps.stack_amap);
>         if (CHECK_FAIL(stack_amap_fd < 0))
> -               goto disable_pmu;
> +               goto out;

none of the above CHECK_FAIL checks are necessary anymore, skeleton
loading makes sure all those maps are there. I dropped this section
altogether


>
> +       err =3D stacktrace_map__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto out;
>         /* give some time for bpf program run */
>         sleep(1);
>
> @@ -55,21 +47,19 @@ void test_stacktrace_map(void)
>         err =3D compare_map_keys(stackid_hmap_fd, stackmap_fd);
>         if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
>                   "err %d errno %d\n", err, errno))
> -               goto disable_pmu;
> +               goto out;
>
>         err =3D compare_map_keys(stackmap_fd, stackid_hmap_fd);
>         if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
>                   "err %d errno %d\n", err, errno))
> -               goto disable_pmu;
> +               goto out;
>
>         stack_trace_len =3D PERF_MAX_STACK_DEPTH * sizeof(__u64);
>         err =3D compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace=
_len);
>         if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
>                   "err %d errno %d\n", err, errno))
> -               goto disable_pmu;
> +               goto out;
>
> -disable_pmu:
> -       bpf_link__destroy(link);
> -close_prog:
> -       bpf_object__close(obj);
> +out:
> +       stacktrace_map__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp=
.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> index e0cb4697b4b..e985d51d3d4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> @@ -5,7 +5,7 @@ void test_stacktrace_map_raw_tp(void)
>  {
>         const char *prog_name =3D "oncpu";
>         int control_map_fd, stackid_hmap_fd, stackmap_fd;
> -       const char *file =3D "./test_stacktrace_map.bpf.o";
> +       const char *file =3D "./stacktrace_map.bpf.o";
>         __u32 key, val, duration =3D 0;
>         int err, prog_fd;
>         struct bpf_program *prog;
> diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/to=
ols/testing/selftests/bpf/progs/stacktrace_map.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> rename to tools/testing/selftests/bpf/progs/stacktrace_map.c
> --
> 2.48.1
>

