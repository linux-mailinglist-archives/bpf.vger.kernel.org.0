Return-Path: <bpf+bounces-4403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4174AA03
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968CA1C20F04
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E31FAB;
	Fri,  7 Jul 2023 04:42:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF478EA0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:42:20 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098FE1BDB
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:42:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so11978675e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704937; x=1691296937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBlbDVL7PD31dBtmiWDtn75nbruR/5tJjCjtg5iIEYc=;
        b=pxMapko4aSC+WD2aK4/dcfxW01Ib6WmZ2DMvwtqHvrMX7uHXmY9hCjuOT2jl/UGiwH
         ELQ88ydz2m+47ymKwURVc6Ek+9B+GXK/ypEPZpGxfq51xioG0JWPYO/RMclswfF1ljaf
         tOdwOt++jpJ8rIUbHL49cAcfat1ZPRDi2WNtMGg9p8lyUB8Bdd0kBb8fV81FRaL/ig26
         enggk/9/13oodwNLKLp6WWwwRgHuzSdYr7jUi++ug9ZyuyfoIrn9A6JfusPlim8Rtery
         kqT2VjHLgSAudNv32ujo1nEMx/FAQakld/wO/QSdYQYYyYd3v1/qzVfBPTHbpO/CP5BY
         HkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704937; x=1691296937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBlbDVL7PD31dBtmiWDtn75nbruR/5tJjCjtg5iIEYc=;
        b=IVucQJDEzS1F/cWyBB9ApAI58SBVz3O7RK3QsHmrvr7YFpRHDug5NQ5EMZroRQC7mx
         t+cMTKU8b8ux57WcJVdQZhDlYY/JV3zHrXX6UhTDywhMb/ibU92IsAYE7n/2eEXO+ClX
         kkIh450WGTclETs+EGaly9BVq9SjOAJAZx8R75zUAhL8EGgh0LdS4txHiVB7bVvn9Ln+
         LOMDXADwi05qSoqww8HwjY7bIaxBPYPunKJGcYDiMMnaeDU906v4OsDcJ5wGLI78bDYE
         6BysHlao+bLlZPI194wMSf2IG7MhlNkOhCSGQku2q8PSdamh7dJ+Ycg8+DQkasa+HsGv
         vKig==
X-Gm-Message-State: ABy/qLZKDmPZN0pnAhVl8nxp51NrowdfHgjwdZvj7sslD365DvTH8qDL
	wfh+pyaYQlyv+KFvDTCTczs3sBh0Sd1GAssULvo=
X-Google-Smtp-Source: APBJJlEa3CV4FJPYYzG4NuJOoxhxmXy5Eaup4QWjrG4P/7gNGtywX/YTL7ssL2+qx/yVZZbijQXfEgRF5Hie4ceGVxo=
X-Received: by 2002:a7b:c8d4:0:b0:3fb:e1d0:6417 with SMTP id
 f20-20020a7bc8d4000000b003fbe1d06417mr6692142wml.19.1688704937186; Thu, 06
 Jul 2023 21:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-24-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-24-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:42:05 -0700
Message-ID: <CAEf4BzYgeoUfwqtnk_FWUo7-=ughWstWy8DDMjQi4sohvmU1Qg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 23/26] selftests/bpf: Add usdt_multi bench test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that attaches 50k usdt probes in usdt_multi binary.
>
> After the attach is done we run the binary and make sure we get
> proper amount of hits.
>
> With current uprobes:
>
>   # perf stat --null ./test_progs -n 254/6
>   #254/6   uprobe_multi_test/bench_usdt:OK
>   #254     uprobe_multi_test:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>    Performance counter stats for './test_progs -n 254/6':
>
>       1353.659680562 seconds time elapsed
>

20 minutes, I commend your patience!

> With uprobe_multi link:
>
>   # perf stat --null ./test_progs -n 254/6
>   #254/6   uprobe_multi_test/bench_usdt:OK
>   #254     uprobe_multi_test:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>    Performance counter stats for './test_progs -n 254/6':
>
>          0.322046364 seconds time elapsed

This is an impressive speed up, especially taking into account that
there is no batch attachment magic that we had to do for kprobes. Very
nice!

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 50 +++++++++++++++++++
>  .../selftests/bpf/progs/uprobe_multi_usdt.c   | 16 ++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 547d46965d70..b12dc1f992e5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -4,6 +4,7 @@
>  #include <test_progs.h>
>  #include "uprobe_multi.skel.h"
>  #include "bpf/libbpf_elf.h"
> +#include "uprobe_multi_usdt.skel.h"
>
>  static char test_data[] =3D "test_data";
>
> @@ -256,6 +257,53 @@ static void test_bench_attach_uprobe(void)
>         printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
>  }
>
> +static void test_bench_attach_usdt(void)
> +{
> +       struct uprobe_multi_usdt *skel =3D NULL;
> +       long attach_start_ns, attach_end_ns;
> +       long detach_start_ns, detach_end_ns;
> +       double attach_delta, detach_delta;
> +       struct bpf_program *prog;
> +       int err;
> +
> +       skel =3D uprobe_multi_usdt__open();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
> +               goto cleanup;
> +
> +       bpf_object__for_each_program(prog, skel->obj)
> +               bpf_program__set_autoload(prog, false);
> +
> +       bpf_program__set_autoload(skel->progs.usdt0, true);

there is nothing else in that skeleton, why this set_autoload() business?

> +
> +       err =3D uprobe_multi_usdt__load(skel);
> +       if (!ASSERT_EQ(err, 0, "uprobe_multi_usdt__load"))
> +               goto cleanup;
> +
> +       attach_start_ns =3D get_time_ns();
> +
> +       skel->links.usdt0 =3D bpf_program__attach_usdt(skel->progs.usdt0,=
 -1, "./usdt_multi",
> +                                                    "test", "usdt", NULL=
);
> +       if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt")=
)
> +               goto cleanup;
> +
> +       attach_end_ns =3D get_time_ns();
> +
> +       system("./usdt_multi");
> +
> +       ASSERT_EQ(skel->bss->count, 50000, "usdt_count");
> +
> +cleanup:
> +       detach_start_ns =3D get_time_ns();
> +       uprobe_multi_usdt__destroy(skel);
> +       detach_end_ns =3D get_time_ns();
> +
> +       attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0=
;
> +       detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0=
;
> +
> +       printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> +       printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> +}
> +
>  void test_uprobe_multi_test(void)
>  {
>         if (test__start_subtest("skel_api"))
> @@ -268,4 +316,6 @@ void test_uprobe_multi_test(void)
>                 test_link_api();
>         if (test__start_subtest("bench_uprobe"))
>                 test_bench_attach_uprobe();
> +       if (test__start_subtest("bench_usdt"))
> +               test_bench_attach_usdt();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c b/tool=
s/testing/selftests/bpf/progs/uprobe_multi_usdt.c
> new file mode 100644
> index 000000000000..9e1c33d0bd2f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/usdt.bpf.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int count;
> +
> +SEC("usdt")
> +int usdt0(struct pt_regs *ctx)
> +{
> +       count++;
> +       return 0;
> +}
> --
> 2.41.0
>

