Return-Path: <bpf+bounces-69269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AF3B934E0
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91D6D4E1F74
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D42E8DE1;
	Mon, 22 Sep 2025 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwrEXRLu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04AA95E
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574719; cv=none; b=BifO9Rr3Rt/bYkbpa8WeJjq7QYOf/cN1OjlLp8TY8EzKmAAKhRLwUZq2GutDP6g+zkBHNJ0mfvP1ZI1ogaReSYNzXhbPHUdtZUlu3I/KdJD6R6OiMh4QhmBN5Gc1NZAQomed4wsgmisAamKk+kerx8/B3cfi/egoLeDOimrO47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574719; c=relaxed/simple;
	bh=P/EYxKGUt4KlDQqc4dEWoyq9uVkW2ANWEyhW33wPUUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPbar+yOiyPrI8HeM686hIhoGX6c5F4ADizDO514b3pUeykfGRQ2W8Qfs2WsBIOMtIvOfvnyJEH5ei2rn2UsWvjMcqmIl2Vvqup7xbbeeo7EHrhhqRi2mu2cXpKMFUACG8x0mSbzcAeVGYNGTjFm0LQaP3w+MtOgC2LhZUjNMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwrEXRLu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso2076293a91.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758574717; x=1759179517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyg+CfbJEgucw+GOG7zODfpjV9/l3Y90q5rDgYgLXfk=;
        b=gwrEXRLu5PPgCBN/gXbp43k0sykMVoB/Wc7pIiiib4y2slEE/LU1FR+ksYJBsFG0rH
         Wbch4zEGp+F97H+ZJfQ+YN2OlG8p0lFHWQk0oG54ZrmEoaa1s65+QulHXxgzAupLczBc
         YaHoyAt+R4mhPCaM4vabGOEeQOq0VP23zBOLJTDeHhUr30weZSbNkpp5tPGNh5LUDumR
         1DgtCsh86NOaaCaBfQ000Ic/kQH9zMQu4hWdOvqTcaFFNaZMcKEubxIOOkk+D2cp+RN/
         IrLRXWYYT6M7YPVOq6quUCh0BE66EMWmdLW1yT03um5MSET9nj4VNv6fpsBIqc2XpM1n
         NuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574717; x=1759179517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cyg+CfbJEgucw+GOG7zODfpjV9/l3Y90q5rDgYgLXfk=;
        b=Q3JCT6wBXutGqj2JJyiL1hn61quxmShVCa55kxliWZBbPYED1AggaRgp78gnDPM+6Q
         KJMAJfZFSApQhatCiN7Nfpo1CE+dig+SKTfqjHTg3xXpb0M2L5XBnGR0Ljf/1Ei73ac8
         BQwJ3yPmIZIfHryDRMViP6GP1j/hfzlRqoYA+5ILlR9qbL0+0RdUXQCDkZdFFQDalj5s
         2j/dRnukY0alzUv4b8bSUcHf7aZscCUpyyhTgsWjAbbg8Z99fwRMn5zX9hwd5YXjkFIC
         14u5gCVGEgd0dt9h2RebkYikb8nOARFqWBbmkjyI58OGY4lzsgFeEVTNDzbOpUlyBqJH
         QZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURFRUdvqn3u1lc+T2sFjAE9lxpeWOuG6t6N4qzGNwrqTG2dxiTjcvyC5oJR0sMLraBSYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQV9kOgwOnRp2Pgi7zIftlmrM8DHbWkEKXAB9Kr8o7n8jj7GHc
	7YZ8Bm22QUlXx9FprJT2qhJldEUVuyLR/y1NAFTsEbYMRUKw+pPs72CbDnN+GzgawzyOJ/28C7c
	z2vSUN9h4KlediMaQGtJ90LGZ3sWc+oo=
X-Gm-Gg: ASbGncuVRQ/bQN2EQUa4NSn989KgXDKf1GEcXZoKbLpkxGgH66zYqdcYGoA0HGHxhrX
	1hGtrteuWQz62kimfvavGgKhm8/pG997LIIp7HBeq0zQpVAxoqyJkyXcGrw6Ys5ANA89Wb5MweU
	10HSHWJTbCWzAfNPFi8r84QbcPbnneJtTB+em8RZ3DgXRzvJEmZocrVSDlCp7ZSa2SAE7NHdJ6m
	ECwbwmuU3WMM61M0K7peHU=
X-Google-Smtp-Source: AGHT+IGL9vPdRVkkKOqUJtNXq5UND6cfJRafkIFi74NGkbo62GVIzwufNt9wpETV57+hWfbc3Yfj3PA1LgxMyK1lu5g=
X-Received: by 2002:a17:90b:5650:b0:32e:aaac:907 with SMTP id
 98e67ed59e1d1-332a94df129mr296854a91.5.1758574717173; Mon, 22 Sep 2025
 13:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922140317.1468691-1-chen.dylane@linux.dev> <20250922140317.1468691-2-chen.dylane@linux.dev>
In-Reply-To: <20250922140317.1468691-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 13:58:22 -0700
X-Gm-Features: AS18NWAKfciGnImUAyNfbcv-dsltpq9HmGDY7Qw5FgXfnyWV2jcScfFt47-sxBA
Message-ID: <CAEf4BzbwkmeiRb5v3TRLxNEywvtn7tynYu850E-sh8Z--hM-dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:03=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Add tests for stacktrace map lookup and delete:
> 1. use bpf_map_lookup_and_delete_elem to lookup and delete the target
>    stack_id,
> 2. lookup the deleted stack_id again to double check.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/stacktrace_map.c | 21 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/to=
ols/testing/selftests/bpf/prog_tests/stacktrace_map.c
> index 84a7e405e91..d50659fc25e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> @@ -3,7 +3,7 @@
>
>  void test_stacktrace_map(void)
>  {
> -       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> +       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, =
stack_key_map_fd;
>         const char *prog_name =3D "oncpu";
>         int err, prog_fd, stack_trace_len;
>         const char *file =3D "./test_stacktrace_map.bpf.o";
> @@ -11,6 +11,8 @@ void test_stacktrace_map(void)
>         struct bpf_program *prog;
>         struct bpf_object *obj;
>         struct bpf_link *link;
> +       __u32 stack_id;
> +       char val_buf[PERF_MAX_STACK_DEPTH * sizeof(struct bpf_stack_build=
_id)];
>
>         err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, =
&prog_fd);
>         if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> @@ -41,6 +43,10 @@ void test_stacktrace_map(void)
>         if (CHECK_FAIL(stack_amap_fd < 0))
>                 goto disable_pmu;
>
> +       stack_key_map_fd =3D bpf_find_map(__func__, obj, "stack_key_map")=
;
> +       if (CHECK_FAIL(stack_key_map_fd < 0))

please don't use CHECK*() macros, they are superseded by more targeted
ASSERT_xxx() ones

pw-bot: cr


> +               goto disable_pmu;
> +
>         /* give some time for bpf program run */
>         sleep(1);
>
> @@ -68,6 +74,19 @@ void test_stacktrace_map(void)
>                   "err %d errno %d\n", err, errno))
>                 goto disable_pmu;
>
> +       err =3D bpf_map_lookup_elem(stack_key_map_fd, &key, &stack_id);
> +       if (CHECK(err, "stack_key_map lookup", "err %d errno %d\n", err, =
errno))
> +               goto disable_pmu;
> +
> +       err =3D bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id, &v=
al_buf);
> +       if (CHECK(err, "stackmap lookup and delete",
> +                 "err %d errno %d\n", err, errno))
> +               goto disable_pmu;
> +
> +       err =3D bpf_map_lookup_elem(stackmap_fd, &stack_id, &val_buf);
> +       CHECK((!err || errno !=3D ENOENT), "stackmap lookup deleted stack=
_id",
> +             "err %d errno %d\n", err, errno);

bpf_map_lookup_elem() returns error code directly, no need to use
errno, just check that err =3D=3D -ENOENT

> +
>  disable_pmu:
>         bpf_link__destroy(link);
>  close_prog:
> diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/to=
ols/testing/selftests/bpf/progs/test_stacktrace_map.c
> index 47568007b66..3bede76c151 100644
> --- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> @@ -38,6 +38,13 @@ struct {
>         __type(value, stack_trace_t);
>  } stack_amap SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, __u32);
> +} stack_key_map SEC(".maps");
> +
>  /* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
>  struct sched_switch_args {
>         unsigned long long pad;
> @@ -64,6 +71,7 @@ int oncpu(struct sched_switch_args *ctx)
>         /* The size of stackmap and stackid_hmap should be the same */
>         key =3D bpf_get_stackid(ctx, &stackmap, 0);
>         if ((int)key >=3D 0) {
> +               bpf_map_update_elem(&stack_key_map, &val, &key, 0);

ugh... you'd just use a global variable if this test was used through
skeleton... maybe convert the test to skeleton and get rid of all
those unnecessary bpf_find_map() calls as well?

>                 bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
>                 stack_p =3D bpf_map_lookup_elem(&stack_amap, &key);
>                 if (stack_p)
> --
> 2.48.1
>

