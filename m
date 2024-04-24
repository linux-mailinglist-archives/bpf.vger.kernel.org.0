Return-Path: <bpf+bounces-27605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846278AFD52
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65E51C20D49
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B409803;
	Wed, 24 Apr 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3EfZWxw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C517FF
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918456; cv=none; b=KQEJLs+xr5owgE/nz4Cmuo1i3oYEtWXHrDpJwa06VOkdlKFAlRdZ4QBQI+rmCdst7KlHaTeh6TgEpxtzzfBe8r5ZJ30HPdf7fxENrlWwxzSjuhyK4eUBoSF7ZKhkAXo2DV9BjDkQdS/RknkO5vijQbDYxKnWaCztDWWgpaxkgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918456; c=relaxed/simple;
	bh=szDVMy0i2e67WGTP63e/mQstU/hrph8MZxn/bS6jDBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEjaS6KQ0DQjAhjom1uD1/RA6GK5R2R0/8v+hTVQCcO1S1VNwhnQmSVEkHDDr5yHa2bL21ibpUEdOjJ16V/32SFs8ldfBIWvZfZ8td+UdMWGPfVJ6EApORP03vLYOXulj26LADxiw/U5WZgXQ9E9pzwXZpmXq1QnHfFLCNoLbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3EfZWxw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so5235418a91.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918455; x=1714523255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JXUv6NfiOTCbdG55a52hEaBIOuzx9ywMj83az9RujY=;
        b=S3EfZWxwNm+gfXB+mQ2QaCT6CtVRkH9HNA+V61w06w/hnQTNb4EzMlOZzLWpZjH0tA
         ax0IvC2TJBNL1LLjyA32WaHTJAT4sEFkywOqftXlvbMrHNdnc7Fby+p8P/MEctGErJYV
         S5rzS4/YOu5mYjUm6L73+ffyJMyHqn24gwTkCz3+WpGoM4nfNU90P3mTrfEdoU+vM/MV
         qqpP3jFgGc1HOXcz2xXVsdxTsmk5A2SXBhda/ObxN7IzbFO3Eie9/7hVS0MDKta77lMR
         28+WHTHG9zG+WBHwl81fkrfkc5geKTxF0wziTkHhxSC0yGTTCkSx3CQ/V52mXGMeZq7l
         x4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918455; x=1714523255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JXUv6NfiOTCbdG55a52hEaBIOuzx9ywMj83az9RujY=;
        b=tM2SF8TAg9OTUvW9ZeCmDgUtFEaK54WLZ34DRO64U3yM4p0iUBvanNy72k2qhT4xkE
         0B70tPRteI81XepSLsbTmsVZUJ+ekLLKMPzzVKMv00JXk53uZvKm+ipMZON2LXRuA3Lu
         hg7s5HoB85cAzVNksQ0UzQPTaRkVScoH9H1vAquK+4V9rmW3aUjnyDd659nSXIZin63I
         3tka44sobMBygPjRTX3fP83zc5sq8aMlRk0MmoFANea4EStfUEXYVCHYupaNF69Fqysu
         4Nj9nbfLr+s0LiK/uehZbUJGphTGR6ThSqpr1UiK9XC2Z2jeo+LaI/k42N6XeZhGtLW9
         lbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDDbktoRonqL2aPhjeHb1Dh6TzIqR3NtldXB+ICSTaTLICSWIn6R/4COho44cH9DCMqE9SprLf/RAFQEopJYBIQnUD
X-Gm-Message-State: AOJu0YzHy80pXv9P6Kk41X5Gyqi6SLn9X1IdTasbacVwE1jokCvDGNHZ
	uwjvCuVrLuIBiNJK0hblx7saJrUOujFhrJUbxLDDZYcJdZJRMXb1EhRN5Y9+Ro9S731LdJh6wTs
	0c/6lv77T9UWaITIqekuhW0U+bVo=
X-Google-Smtp-Source: AGHT+IHr3UkwT1XVqcy6k8RGz0BSIzDEEAU6tKwbQouoLfItq7wNVgUUx5mB2sYqEbLBvpUuEBA94Ka+seLQmPFyns4=
X-Received: by 2002:a17:90a:b102:b0:2a6:a760:79f1 with SMTP id
 z2-20020a17090ab10200b002a6a76079f1mr853764pjq.4.1713918454682; Tue, 23 Apr
 2024 17:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-8-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:27:22 -0700
Message-ID: <CAEf4BzbyQpKvZS-mUECLRq3gyBJbsqQghOKyAbutoB76mJM8xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Add kprobe multi wrapper
 cookie test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding kprobe multi session test that verifies the cookie
> value get properly propagated from entry to return program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Forgot to update subject (still using "wrapper" naming)

overall LGTM, see nits

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/bpf_kfuncs.h      |  1 +
>  .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++
>  .../bpf/progs/kprobe_multi_session_cookie.c   | 56 +++++++++++++++++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sessio=
n_cookie.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 180030b5d828..0281921cd654 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -77,4 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr=
 *data_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
>
>  extern bool bpf_session_is_return(void) __ksym;
> +extern __u64 *bpf_session_cookie(void) __ksym;

btw, should we use `long *` as return type to avoid relying on having
__u64 alias be available? Long is always an 8-byte value in the BPF
world, it should be fine.

>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index d1f116665551..2896467ca3cd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -5,6 +5,7 @@
>  #include "kprobe_multi_empty.skel.h"
>  #include "kprobe_multi_override.skel.h"
>  #include "kprobe_multi_session.skel.h"
> +#include "kprobe_multi_session_cookie.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "bpf/hashmap.h"
>
> @@ -373,6 +374,38 @@ static void test_session_skel_api(void)
>         kprobe_multi_session__destroy(skel);
>  }
>
> +static void test_session_cookie_skel_api(void)
> +{
> +       struct kprobe_multi_session_cookie *skel =3D NULL;
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       struct bpf_link *link =3D NULL;
> +       int err, prog_fd;
> +
> +       skel =3D kprobe_multi_session_cookie__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
> +               goto cleanup;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D kprobe_multi_session_cookie__attach(skel);
> +       if (!ASSERT_OK(err, " kprobe_multi_wrapper__attach"))
> +               goto cleanup;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.trigger);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_run");
> +       ASSERT_EQ(topts.retval, 0, "test_run");
> +
> +       ASSERT_EQ(skel->bss->test_kprobe_1_result, 1, "test_kprobe_1_resu=
lt");
> +       ASSERT_EQ(skel->bss->test_kprobe_2_result, 2, "test_kprobe_2_resu=
lt");
> +       ASSERT_EQ(skel->bss->test_kprobe_3_result, 3, "test_kprobe_3_resu=
lt");
> +
> +cleanup:
> +       bpf_link__destroy(link);
> +       kprobe_multi_session_cookie__destroy(skel);
> +}
> +
>  static size_t symbol_hash(long key, void *ctx __maybe_unused)
>  {
>         return str_hash((const char *) key);
> @@ -739,4 +772,6 @@ void test_kprobe_multi_test(void)
>                 test_attach_override();
>         if (test__start_subtest("session"))
>                 test_session_skel_api();
> +       if (test__start_subtest("session_cookie"))
> +               test_session_cookie_skel_api();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cooki=
e.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> new file mode 100644
> index 000000000000..b5c04b7b180c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +#include "bpf_kfuncs.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int pid =3D 0;
> +
> +__u64 test_kprobe_1_result =3D 0;
> +__u64 test_kprobe_2_result =3D 0;
> +__u64 test_kprobe_3_result =3D 0;
> +
> +/*
> + * No tests in here, just to trigger 'bpf_fentry_test*'
> + * through tracing test_run
> + */
> +SEC("fentry/bpf_modify_return_test")
> +int BPF_PROG(trigger)
> +{
> +       return 0;
> +}
> +
> +static int check_cookie(__u64 val, __u64 *result)
> +{
> +       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> +               return 1;
> +
> +       __u64 *cookie =3D bpf_session_cookie();

we don't enforce this, but let's stick to C89 variable declaration
style (or rather positioning in this case)?


> +
> +       if (bpf_session_is_return())
> +               *result =3D *cookie =3D=3D val ? val : 0;
> +       else
> +               *cookie =3D val;
> +       return 0;
> +}
> +
> +SEC("kprobe.session/bpf_fentry_test1")
> +int test_kprobe_1(struct pt_regs *ctx)
> +{
> +       return check_cookie(1, &test_kprobe_1_result);
> +}
> +
> +SEC("kprobe.session/bpf_fentry_test1")
> +int test_kprobe_2(struct pt_regs *ctx)
> +{
> +       return check_cookie(2, &test_kprobe_2_result);
> +}
> +
> +SEC("kprobe.session/bpf_fentry_test1")
> +int test_kprobe_3(struct pt_regs *ctx)
> +{
> +       return check_cookie(3, &test_kprobe_3_result);
> +}
> --
> 2.44.0
>

