Return-Path: <bpf+bounces-33689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E95924A34
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CDD1C22C41
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772C2205E17;
	Tue,  2 Jul 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niPPaf0q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89B1BD512;
	Tue,  2 Jul 2024 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957471; cv=none; b=ca9PoNQkEQNbFzM0H8ntodKMgC8zV1WUH/SVpgaVmJvsPW5ziDBbCbzUnRgOmDox4vj3VVKE48GShcn6909/Wk/dBmpIwC+JKcL5v6Hlo95q2A+SDZJpJ3g9d+nUeV+hzrUIPxjJw2NVE5YeKYElLQf7Z06kue5anBA++2vs/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957471; c=relaxed/simple;
	bh=3IoNLmFrW04h5NZct8LpCc5lx5DRX/yIR+IZxZhLabU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acgl5pbaaajAtvyLjBAaMYFmar0i7lUf1mrt2XFwO9ZZz59B80HP5n4DytlyLOjjyeSm4ciYChg8EWKp24MgTk3yvHWIoQy6lfLqKylopUtxyBohqbDsDvxeCSHTXLQcz00t54hKHUtOLELKRGjYIDJS2CpLtjtFUPa4Q639kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niPPaf0q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a724598cfe3so592316566b.1;
        Tue, 02 Jul 2024 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957467; x=1720562267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qVUlcxGg0CHOekHZ6+YIbM0eY0VoswlJ0lYpz49cnw=;
        b=niPPaf0qL7/cCI55fzipByy82mm4fRwqTj435f38/0Ri9XpOVV4hNSLkmjM0iYJVTj
         Qw2Sjdo3MyCJbYLskKj78NFchwc6z1OQZpiYRPpl3XTr+GaQUJP/zyWOCC2TPTJJIQ77
         MmUgq1fRDmeNJXPg3Hh+1zS2K4NcL0bzE+An0T/umxpOymBFt2mQxwRW+OGsnXVY9vGN
         3ZlZ2YTdjp3knEccISCqH95GsjeBVvF3alxJLS5f09KkMuExc+oe5r0VBIKSVqSQHZAT
         XLDFXCdqOKvOvX19JTzJEKMwpHp08bojkOErkUTkYzi13Adsz/VswZoxqJnvYgc5FZeL
         1wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957467; x=1720562267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qVUlcxGg0CHOekHZ6+YIbM0eY0VoswlJ0lYpz49cnw=;
        b=UQxQMTIWiQl9V5ZdUIjjMQHEy7A7jXhXrQ6V7vCwxuxTaKazzjWqegS9PduJh9Pu2L
         /bw0aQU9O6Kq0bpxQCVcrjojIeyndksRD5CwGDEmgnXnloaj4aiAunHDd5VLEymYROth
         B1eY8QbvCdKKVLZWHuiHRmQFyyNyfrkk0UdKOu9DiKZQSw+wvLhGWrXeKWCqsTsB4ILp
         AoV4fnbOiH8DD890JrmgcvVGUotwW5ItO+aUYcgIQKpYaTWoeE7+azNoOiwo2FDCyL1h
         1B+VCNmxy9RYcvW1KWVbwssQL45oXgGn0aeTElTM4zge88HtSS7KZai4xXgnoX3Z7fEV
         VTmw==
X-Forwarded-Encrypted: i=1; AJvYcCVSkznQorx/vYU1TyNQa+tdHoP40V67IBh75yAjgh/N38mhd5OKk/HA69KaChaxoITJl/3hEmWsd40MHK+RbQt5ThXY4vuyr7nZxW0Lr3OqqjTpen+fpGKRdLbmYyCgQNeIYjRBDGPxAq08yvI5GkTBNoQvgai/2GiGLBhhbeQ7jh5UqX5z
X-Gm-Message-State: AOJu0Yy0wII6a6w53qPXklFWd/naUucCcpvJE/9h8AoErhjR6aHa43zI
	Vch97yDjCFyiwDbyKbH77q9gW6Z9tUxhJIgv7Qc50BF7mlkrHAtLMMqdSxoYdY8VsMRXDbzoV28
	Ihv0jlFgny1BD+J1Mi1oljLEyd30=
X-Google-Smtp-Source: AGHT+IEWKwRh13zALGUZeYb54SJjh/VFz3E8OF502MPQpiXuwMwTmJpwUAyI27pPStrbjgG0Mr0sC0aGcS91RQtdCZc=
X-Received: by 2002:a17:906:b897:b0:a72:4402:9344 with SMTP id
 a640c23a62f3a-a7514488e8amr754070866b.20.1719957467509; Tue, 02 Jul 2024
 14:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-7-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:57:33 -0700
Message-ID: <CAEf4Bzby-7tt3fmLocL8_TXrP+ZuUOQYv9TnBg1vnb4GpXTzXg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 6/9] selftests/bpf: Add uprobe session test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe session test and testing that the entry program
> return value controls execution of the return probe program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 42 +++++++++++++++
>  .../bpf/progs/uprobe_multi_session.c          | 53 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n.c
>

LGTM.
Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index bf6ca8e3eb13..cd9581f46c73 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -6,6 +6,7 @@
>  #include "uprobe_multi.skel.h"
>  #include "uprobe_multi_bench.skel.h"
>  #include "uprobe_multi_usdt.skel.h"
> +#include "uprobe_multi_session.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
>  #include "../sdt.h"
> @@ -615,6 +616,45 @@ static void test_link_api(void)
>         __test_link_api(child);
>  }
>
> +static void test_session_skel_api(void)
> +{
> +       struct uprobe_multi_session *skel =3D NULL;
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       struct bpf_link *link =3D NULL;
> +       int err;
> +
> +       skel =3D uprobe_multi_session__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
> +               goto cleanup;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D uprobe_multi_session__attach(skel);
> +       if (!ASSERT_OK(err, " uprobe_multi_session__attach"))
> +               goto cleanup;
> +
> +       /* trigger all probes */
> +       skel->bss->uprobe_multi_func_1_addr =3D (__u64) uprobe_multi_func=
_1;
> +       skel->bss->uprobe_multi_func_2_addr =3D (__u64) uprobe_multi_func=
_2;
> +       skel->bss->uprobe_multi_func_3_addr =3D (__u64) uprobe_multi_func=
_3;
> +
> +       uprobe_multi_func_1();
> +       uprobe_multi_func_2();
> +       uprobe_multi_func_3();
> +
> +       /*
> +        * We expect 2 for uprobe_multi_func_2 because it runs both entry=
/return probe,
> +        * uprobe_multi_func_[13] run just the entry probe.
> +        */
> +       ASSERT_EQ(skel->bss->uprobe_session_result[0], 1, "uprobe_multi_f=
unc_1_result");
> +       ASSERT_EQ(skel->bss->uprobe_session_result[1], 2, "uprobe_multi_f=
unc_2_result");
> +       ASSERT_EQ(skel->bss->uprobe_session_result[2], 1, "uprobe_multi_f=
unc_3_result");
> +
> +cleanup:
> +       bpf_link__destroy(link);
> +       uprobe_multi_session__destroy(skel);
> +}
> +
>  static void test_bench_attach_uprobe(void)
>  {
>         long attach_start_ns =3D 0, attach_end_ns =3D 0;
> @@ -703,4 +743,6 @@ void test_uprobe_multi_test(void)
>                 test_bench_attach_usdt();
>         if (test__start_subtest("attach_api_fails"))
>                 test_attach_api_fails();
> +       if (test__start_subtest("session"))
> +               test_session_skel_api();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/t=
ools/testing/selftests/bpf/progs/uprobe_multi_session.c
> new file mode 100644
> index 000000000000..72c00ae68372
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +#include "bpf_kfuncs.h"
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +__u64 uprobe_multi_func_1_addr =3D 0;
> +__u64 uprobe_multi_func_2_addr =3D 0;
> +__u64 uprobe_multi_func_3_addr =3D 0;
> +
> +__u64 uprobe_session_result[3];
> +
> +int pid =3D 0;
> +
> +static int uprobe_multi_check(void *ctx, bool is_return)
> +{
> +       const __u64 funcs[] =3D {
> +               uprobe_multi_func_1_addr,
> +               uprobe_multi_func_2_addr,
> +               uprobe_multi_func_3_addr,
> +       };
> +       unsigned int i;
> +       __u64 addr;
> +
> +       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> +               return 1;
> +
> +       addr =3D bpf_get_func_ip(ctx);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(funcs); i++) {
> +               if (funcs[i] =3D=3D addr) {
> +                       uprobe_session_result[i]++;
> +                       break;
> +               }
> +       }
> +
> +       /* only uprobe_multi_func_2 executes return probe */
> +       if ((addr =3D=3D uprobe_multi_func_1_addr) ||
> +           (addr =3D=3D uprobe_multi_func_3_addr))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
> +int uprobe(struct pt_regs *ctx)
> +{
> +       return uprobe_multi_check(ctx, bpf_session_is_return());
> +}
> --
> 2.45.2
>

