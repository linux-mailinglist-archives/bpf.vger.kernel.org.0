Return-Path: <bpf+bounces-60551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DCDAD7F59
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95803189841C
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5170256D;
	Fri, 13 Jun 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKL/vnuZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3461AD3FA
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772929; cv=none; b=Cc1/6/CJO480vUJx2eD2LYbbbBiiut7Whcb/HmwwKDMLWAguRWqoDzexV30AmimN+WpoBG8A0H+7tuCeomPQwv8vbWE8DKnAMMfRWJ7YN/mVWY+AAJK7ZzU5RN2zaxktmgb/tjVksvDXGPNQWJdlDSjEUevX10Q9t5nBjuDZAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772929; c=relaxed/simple;
	bh=qee1kxcw1IWn60QfNigpk4yhEaHxahxlSfbHUkMh8lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXgCaSyRLIvyAZZXqCr0Eqim5okCL0CVbs6SFMzak9R4I/n5xUcLpc66SGZxgZE9LrEPgFEVPanQj1qzFbgKuUbvvjKrpBQRKhmSx9f7+liEyYaLKeOnmqMM9AUKO/gydK8uTQLMhYk7HEOeuKQEpKueQydPAULtJHfdUGXFZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKL/vnuZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c384b2945so1206490a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749772927; x=1750377727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMd/YG5C7GsDY+b3m8ixOMLNMNDa6GGsWfxX2dlwWIs=;
        b=JKL/vnuZfPokpnRItMxU5s1UFEqT7gYIf6LlV6YZQPPNGvpYC1hc6YnwGwCsE3H7kF
         BmpEoiJOdUrWuFJb4e3lgnGoYgHyG5ME9Zwd0sSzTb1yL6suebQH9/IpK90MqA+YuJxJ
         RboASFbV7jmu/XxsXFPhIuKsnFCw3usnrCJOcBO+TXwWSPAYWnHcqvvYhh+HgK2c5xYr
         ZJw15NRhKrYTLF55kabg91iFbqoKcQpIDXf9AlrEwj6YqeSvH70rt8zABvkoJxg9xs1w
         4GgJ2ckg6rClXJe1yQxh5XhucCvD1XNqK4ack/5w/0PGBH8XMeghXwCASJIIOkIJAmx3
         2kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749772927; x=1750377727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMd/YG5C7GsDY+b3m8ixOMLNMNDa6GGsWfxX2dlwWIs=;
        b=wjSbdrbsJEX9F5HHYwSx911ujmBuubHxVxYgr3RozqL/HxVHIu90GDi5nwYMszqVlQ
         M7sR+hGnZM4cqP7hkKy9bci4fzXJx1PdqIxyIfGNGsnmMoMAGA5qvJjyXy7XaKgnBY4j
         xvFJGPj9v0Uc8ZAOH3DohjD3haL5RXCrvBg97RP1XVRJqNmkKuBv0HsYap5Y9sxeW2Bv
         MCS09xDOssX8BN6YYubkCIcUeeFjM54t5EGMBF1JSPQGmQVvhmKONCVSxCuIB+msrA9G
         1jpfUSsCdLrwHlcvCJh0nxi/jkIkTK2Jfb9HgfcS1bjJd4ltKqMYvMvjCK4G1cojfZLg
         qSjA==
X-Gm-Message-State: AOJu0YyMtML1/g87winFKH0am7lRvbiC3QovBan5MWy1g7Q/QjC/dhoL
	tYKdaosnmoKS0plgnT4VuxZo+hWfTixX7Q4JY7yfSexP5AKEkT3pvjH0cbC35WzhLcgs+GEa9G7
	mEWYEqWf+mwAbBSNQviA4s/VD9Fm7oqM=
X-Gm-Gg: ASbGncuaBXTh/F30zIfbQnR4bfhvgcDSxQyUVFoxIC8iBQvl7LayccZlFaiHIM9Xrwr
	u65ARBPPhco4LzB4a/eCBKuB/VTE4LzfwyokdWKeZA7mn4dQyLb3iBdHiaCSETWgHoaQjfEWe/1
	tKOKWdKrNnNU3uWGF7yheZ02RSdWIpOCDMfIdFZcWVNQ8DHXn6azUDzmdt+Qdsnt6xaETfsA==
X-Google-Smtp-Source: AGHT+IFYSpyyMe5ZwzhfEedFfqF8FVeun4GkN0ibIP5+ybwrdYHwYSIu9ITizCFF//PMMhHJL0PIaacSgyTYPbxseoA=
X-Received: by 2002:a05:6a20:5493:b0:218:5954:128c with SMTP id
 adf61e73a8af0-21facc39d60mr1027715637.21.1749772926637; Thu, 12 Jun 2025
 17:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612130835.2478649-1-eddyz87@gmail.com> <20250612130835.2478649-3-eddyz87@gmail.com>
In-Reply-To: <20250612130835.2478649-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 17:01:54 -0700
X-Gm-Features: AX0GCFsnhAenkEhjle65Di2MpyO-NfHVea3UIrtmfqEHHj4POvHIafWWJK35oJ0
Message-ID: <CAEf4BzbTxyGXi=ZNU_yebe2a=zgNoeafRTK9pixJMihUwwo0Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] veristat: memory accounting for bpf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This commit adds a new field mem_peak / "Peak memory (MiB)" field to a
> set of gathered statistics. The field is intended as an estimate for
> peak verifier memory consumption for processing of a given program.
>
> Mechanically stat is collected as follows:
> - At the beginning of handle_verif_mode() a new cgroup is created
>   and veristat process is moved into this cgroup.
> - At each program load:
>   - bpf_object__load() is split into bpf_object__prepare() and
>     bpf_object__load() to avoid accounting for memory allocated for
>     maps;
>   - before bpf_object__load():
>     - a write to "memory.peak" file of the new cgroup is used to reset
>       cgroup statistics;
>     - updated value is read from "memory.peak" file and stashed;
>   - after bpf_object__load() "memory.peak" is read again and
>     difference between new and stashed values is used as a metric.
>
> If any of the above steps fails veristat proceeds w/o collecting
> mem_peak information for a program.

"... and reports -1". It's important to note, IMO, because that's how
we distinguish less than 1MB memory vs error.

>
> While memcg provides data in bytes (converted from pages), veristat
> converts it to megabytes to avoid jitter when comparing results of
> different executions.
>
> The change has no measurable impact on veristat running time.
>
> A correlation between "Peak states" and "Peak memory" fields provides
> a sanity check for gathered statistics, e.g. a sample of data for
> sched_ext programs:
>
> Program                   Peak states  Peak memory (MiB)
> ------------------------  -----------  -----------------
> lavd_select_cpu                  2153                 44
> lavd_enqueue                     1982                 41
> lavd_dispatch                    3480                 28
> layered_dispatch                 1417                 17
> layered_enqueue                   760                 11
> lavd_cpu_offline                  349                  6
> lavd_cpu_online                   349                  6
> lavd_init                         394                  6
> rusty_init                        350                  5
> layered_select_cpu                391                  4
> ...
> rusty_stopping                    134                  1
> arena_topology_node_init          170                  0
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 266 ++++++++++++++++++++++++-
>  1 file changed, 259 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index b2bb20b00952..e0ecacd1fe13 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -36,6 +36,9 @@
>  #define min(a, b) ((a) < (b) ? (a) : (b))
>  #endif
>
> +#define STR_AUX(x) #x
> +#define STR(x) STR_AUX(x)
> +
>  enum stat_id {
>         VERDICT,
>         DURATION,
> @@ -49,6 +52,7 @@ enum stat_id {
>         STACK,
>         PROG_TYPE,
>         ATTACH_TYPE,
> +       MEMORY_PEAK,
>
>         FILE_NAME,
>         PROG_NAME,
> @@ -208,6 +212,9 @@ static struct env {
>         int top_src_lines;
>         struct var_preset *presets;
>         int npresets;
> +       char orig_cgroup[PATH_MAX + 1];
> +       char stat_cgroup[PATH_MAX + 1];

nit: PATH_MAX includes NUL terminator, so no need for +1

> +       int memory_peak_fd;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)

[...]

> +/*
> + * This works around GCC warning about snprintf truncating strings like:
> + *
> + *   char a[PATH_MAX], b[PATH_MAX];
> + *   snprintf(a, "%s/foo", b);      // triggers -Wformat-truncation
> + */

um... maybe let's just disable that format-truncation warning instead
of working around with wrapper functions? snprintf() is meant to
handle truncation, so this warning feels bogus.

> +__printf(3, 4)
> +static int snprintf_trunc(char *str, volatile size_t size, const char *f=
mt, ...)
> +{
> +       va_list ap;
> +       int ret;
> +
> +       va_start(ap, fmt);
> +       ret =3D vsnprintf(str, size, fmt, ap);
> +       va_end(ap);
> +       return ret;
> +}
> +
> +static void destroy_stat_cgroup(void)
> +{
> +       char buf[PATH_MAX];
> +       int err;
> +
> +       close(env.memory_peak_fd);
> +
> +       if (env.orig_cgroup[0]) {
> +               snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.o=
rig_cgroup);
> +               err =3D write_one_line(buf, "%d\n", getpid());
> +               if (err < 0)
> +                       log_errno("moving self to original cgroup %s\n", =
env.orig_cgroup);
> +       }
> +
> +       if (env.stat_cgroup[0]) {
> +               err =3D rmdir(env.stat_cgroup);

We need to enter the original cgroup to successfully remove the one we
created, is that right? Otherwise, why bother reentering if we are on
our way out, no?

> +               if (err < 0)
> +                       log_errno("deletion of cgroup %s", env.stat_cgrou=
p);
> +       }
> +
> +       env.memory_peak_fd =3D -1;
> +       env.orig_cgroup[0] =3D 0;
> +       env.stat_cgroup[0] =3D 0;
> +}
> +
> +/*
> + * Creates a cgroup at /sys/fs/cgroup/veristat-accounting-<pid>,
> + * moves current process to this cgroup.
> + */
> +static void create_stat_cgroup(void)
> +{
> +       char cgroup_fs_mount[PATH_MAX + 1];
> +       char buf[PATH_MAX + 1];
> +       int err;
> +
> +       env.memory_peak_fd =3D -1;
> +
> +       if (!output_stat_enabled(MEMORY_PEAK))
> +               return;
> +
> +       err =3D scanf_one_line("/proc/self/mounts", 2, "%*s %" STR(PATH_M=
AX) "s cgroup2 %s",

let's just hard-code 1024 or something and not do that STR() magic,
please (same below).

> +                            cgroup_fs_mount, buf);
> +       if (err !=3D 2) {
> +               if (err < 0)
> +                       log_errno("reading /proc/self/mounts");
> +               else if (!env.quiet)
> +                       fprintf(stderr, "Can't find cgroupfs v2 mount poi=
nt.\n");
> +               goto err_out;
> +       }
> +
> +       /* cgroup-v2.rst promises the line "0::<group>" for cgroups v2 */
> +       err =3D scanf_one_line("/proc/self/cgroup", 1, "0::%" STR(PATH_MA=
X) "s", buf);

do you think just hard-coding /sys/fs/cgroup would not work in
practice? It just feels like we are trying to be a bit too flexible
here...

> +       if (err !=3D 1) {
> +               if (err < 0)
> +                       log_errno("reading /proc/self/cgroup");
> +               else if (!env.quiet)
> +                       fprintf(stderr, "Can't infer veristat process cgr=
oup.");
> +               goto err_out;
> +       }
> +

[...]

