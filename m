Return-Path: <bpf+bounces-20110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FD8399DF
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C58B28316E
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167782D81;
	Tue, 23 Jan 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOCuJRey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBEC82D71;
	Tue, 23 Jan 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039503; cv=none; b=J8GKd8Q1tQhHEdtUA2Ih8sPXEpDvJJuufG4hR0o8cewGnHYWp9dPDvATCCwS9GpERD1c6SY3tOfOSVQjXO32Wd2KFFdpbn6WbrHHMAk/X3+7SDFgZIoTvoWUyszevMU1sbIVGOK62DhIJ2DqPhHLhQiD3V5i8zNnnGbQ8rUWjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039503; c=relaxed/simple;
	bh=Mg6HTGHvbdK3Y+wcAHiDOOv6sIj/bdmmVkWaMF69n3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqxbphSZBrbTBqAQ51JBAxNPGIitCRCJ6V0XRa7Jwqq/VMREzxmM2/xH+v1snx94+AHzlJ7mPGJ2eMHUfB7X737pHT933SsUXWAx2RQQ4EsLIa7UvS5Bwakplsz08Vz92v5/aOuHSfbw67hzW95E9nb4yYO2sumnf//NeC/m1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOCuJRey; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dbbcb1aff8so3282730b3a.3;
        Tue, 23 Jan 2024 11:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706039501; x=1706644301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnX6xJcntztU2+O+SnbnhvLkRZ2aFyAH1Edf0zHtFJE=;
        b=LOCuJReyvG3g4CD1hWIkvR98eKqD3jgZ0Srm63JOVRWQF6+PBn58wdbBvCG367SZxg
         itZRivznJ1yLc9MQWxFshXVxvf6m3jEZ1cAeskYKMlht6yK6huePlnqS3tKAIRsw5fLw
         Hcrw1LAKeUOKYvuTK5IKCVqW7rYBNUMTG9BqVDCx3aXu1wQiBOaehBf3kSOGHDQxrjdO
         lXoMbsc6GdoUsW4Qv5gwNoDQHjtSSsBudtqhoBMuN8TBZdKrTk1U4ljck76J3RAzmMY/
         AxBpDM+9C+bZqQ9HeBP8IQfs6ygjRys+e72KqW94o49XhvcViS+s9t5kpNF2twbDpbdc
         UnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039501; x=1706644301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnX6xJcntztU2+O+SnbnhvLkRZ2aFyAH1Edf0zHtFJE=;
        b=PMm2HMHjB6bhdCPy0zFCbHPwAtxbKm96KrAkd82anZOXfV757aq08j/9y6hj0pcfZx
         1AQPH6vkwKShEmyo2v+/ERQhnkBoR4HcabsnTOq2QlxPiH9FBOHoN8ynlgLgp+8BjMfw
         LzzC0BC6hP4oc52R/v66LAKOb0UcObu7wBkcj62rh1w5OgrQohljhIaBxGsShrfUThRr
         mHz6rP0bnXL1meSqrOlR4t4kdOYGRR/+8vQYSEw3XH7+Kxb07pPj8HvhIYCjaIbbWt/a
         uuDQEHOcibCh5ITqI7uvp2MXjX+7/sZ+X2ZQlOB8lhtEcAX09ZG3hhYCJx88jo5oVjax
         iGwA==
X-Gm-Message-State: AOJu0YwgNysM8asyL398focP9WGwjfxd4gIDP5GcpdjKqKEogTHrfR6M
	+pWCSjEMnfQTg62j2STsN0BxMVbR36ERLCs8WHX20Jt1Ld9eDKR8d15sjCOMZnEkeP931wol6jw
	voeioxUC5FwGcZBoz4pZX5fyk5FI=
X-Google-Smtp-Source: AGHT+IF6vMOOP+298euiu1/bk8Rqwtc3OX5Vjv8QQw7W/9jQfMKWSSA5BHGjVPH3i7rCbWqoKLaBkrS4izKPGbOjyik=
X-Received: by 2002:a05:6a20:6ca2:b0:19b:e91c:1a42 with SMTP id
 em34-20020a056a206ca200b0019be91c1a42mr3143539pzb.55.1706039501046; Tue, 23
 Jan 2024 11:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123090351.2207-1-yangtiezhu@loongson.cn> <20240123090351.2207-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240123090351.2207-3-yangtiezhu@loongson.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jan 2024 11:51:28 -0800
Message-ID: <CAEf4BzYCHa0fmjGgwLXq=2Mj6ree3FgjEOynq1DtxC3cJT1cmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:04=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> exist 6 failed tests.
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   #106/p inline simple bpf_loop call FAIL
>   #107/p don't inline bpf_loop call, flags non-zero FAIL
>   #108/p don't inline bpf_loop call, callback non-constant FAIL
>   #109/p bpf_loop_inline and a dead func FAIL
>   #110/p bpf_loop_inline stack locations for loop vars FAIL
>   #111/p inline bpf_loop call in a big program FAIL
>   Summary: 768 PASSED, 15 SKIPPED, 6 FAILED
>
> The test log shows that callbacks are not allowed in non-JITed programs,
> interpreter doesn't support them yet, thus these tests should be skipped
> if jit is disabled.
>
> Add an explicit flag F_NEEDS_JIT_ENABLED to those tests to mark that they
> require JIT enabled in bpf_loop_inline.c, check the flag and jit_disabled
> at the beginning of do_test_single() to handle this case.
>
> With this patch:
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   Summary: 768 PASSED, 21 SKIPPED, 0 FAILED
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/test_verifier.c           | 11 +++++++++++
>  .../testing/selftests/bpf/verifier/bpf_loop_inline.c  |  6 ++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 1a09fc34d093..c65915188d7c 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -67,6 +67,7 @@
>
>  #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS     (1 << 0)
>  #define F_LOAD_WITH_STRICT_ALIGNMENT           (1 << 1)
> +#define F_NEEDS_JIT_ENABLED                    (1 << 2)
>
>  /* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
>  #define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |    \
> @@ -74,6 +75,7 @@
>                     1ULL << CAP_BPF)
>  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>  static bool unpriv_disabled =3D false;
> +static bool jit_disabled;
>  static int skips;
>  static bool verbose =3D false;
>  static int verif_log_level =3D 0;
> @@ -1524,6 +1526,13 @@ static void do_test_single(struct bpf_test *test, =
bool unpriv,
>         __u32 pflags;
>         int i, err;
>
> +       if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
> +               printf("SKIP (callbacks are not allowed in non-JITed prog=
rams)\n");

This should be more generic "SKIP (test requires JIT)" or something.
Whoever will apply this can fix it up, don't resend.

> +               skips++;
> +               sched_yield();

not sure why we need sched_yield(), tbh? It probably won't hurt, though.

> +               return;
> +       }
> +
>         fd_prog =3D -1;
>         for (i =3D 0; i < MAX_NR_MAPS; i++)
>                 map_fds[i] =3D -1;
> @@ -1844,6 +1853,8 @@ int main(int argc, char **argv)
>                 return EXIT_FAILURE;
>         }
>
> +       jit_disabled =3D !is_jit_enabled();
> +
>         /* Use libbpf 1.0 API mode */
>         libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
>
> diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/too=
ls/testing/selftests/bpf/verifier/bpf_loop_inline.c
> index a535d41dc20d..59125b22ae39 100644
> --- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> +++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> @@ -57,6 +57,7 @@
>         .expected_insns =3D { PSEUDO_CALL_INSN() },
>         .unexpected_insns =3D { HELPER_CALL_INSN() },
>         .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>         .result =3D ACCEPT,
>         .runs =3D 0,
>         .func_info =3D { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
> @@ -90,6 +91,7 @@
>         .expected_insns =3D { HELPER_CALL_INSN() },
>         .unexpected_insns =3D { PSEUDO_CALL_INSN() },
>         .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>         .result =3D ACCEPT,
>         .runs =3D 0,
>         .func_info =3D { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
> @@ -127,6 +129,7 @@
>         .expected_insns =3D { HELPER_CALL_INSN() },
>         .unexpected_insns =3D { PSEUDO_CALL_INSN() },
>         .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>         .result =3D ACCEPT,
>         .runs =3D 0,
>         .func_info =3D {
> @@ -165,6 +168,7 @@
>         .expected_insns =3D { PSEUDO_CALL_INSN() },
>         .unexpected_insns =3D { HELPER_CALL_INSN() },
>         .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>         .result =3D ACCEPT,
>         .runs =3D 0,
>         .func_info =3D {
> @@ -235,6 +239,7 @@
>         },
>         .unexpected_insns =3D { HELPER_CALL_INSN() },
>         .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>         .result =3D ACCEPT,
>         .func_info =3D {
>                 { 0, MAIN_TYPE },
> @@ -252,6 +257,7 @@
>         .unexpected_insns =3D { HELPER_CALL_INSN() },
>         .result =3D ACCEPT,
>         .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>         .func_info =3D { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
>         .func_info_cnt =3D 2,
>         BTF_TYPES
> --
> 2.42.0
>

