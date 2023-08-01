Return-Path: <bpf+bounces-6597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8C76BBB3
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEFD1C20F15
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627BE23596;
	Tue,  1 Aug 2023 17:51:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391A2CA5
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 17:51:50 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3B1BF6
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 10:51:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so70690891fa.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690912307; x=1691517107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RxHGAKAkT40oCAeuXDbpfqceRSfwGBZtFaw1XYirCY=;
        b=OVpPkRKTi7SAIc/LgTd14XuNr+R07nCjkpEuWf0xx1iVayPQysvim1LMjTUVTRnBMR
         12xYvHkmaYo7YYQ1G0RDpKSyisD39HgQYpH/1chCOdbY8/5LtNGWPyYd2c4QKFGFO/Ko
         GDA5/ay0GQLqOrSEoQC+ndUH/ijude1n6FkJ+/5p0dpbJxnwVnL1G3FyIp5OxvnHeS7I
         CG5DUfVHqdjPQ6uGQNl3j3hIObR/dvVKrMeWN8V9in1W6XTTyzzNqifbGdKIgfz49qd1
         2BDsyd+ldnNbsX5wB5u5LT9gZXO+9XqbBeC1ItdhXmJSI8RwXT7IwfGez9eB5c+P3hwl
         qhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690912307; x=1691517107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RxHGAKAkT40oCAeuXDbpfqceRSfwGBZtFaw1XYirCY=;
        b=GeotjzzFsOaKZdDUMc73xv1BfNdgkgPfeLriia+7t4pSVqKXbBN2DMp6l1MaBSwIZE
         AuRFPT4HxrpwSsVgmUT/D4567h5Q5ddAE/E7hyKiu0pOwHL0rAY+bY4bngfGX6tQgA2o
         n34ujpt9l/ijy+BM1cRPWumuJv34cVPzWvx7Wf+EDH6TTG4bLl1nIJmSa/5ux6dxDYCu
         g4KXGmxv+Fr80RKRK/aKq+QJi/Yxa6MSnlSFPPnmTyhvK/g2i2ryHhlAA82IbBemAaHE
         cPz9DFBxrzfLgt4WlMHNNLGo8sm4JFQ53LCZqvV+alsTkPy+1ef8gaennVD+By8r1a62
         lkIQ==
X-Gm-Message-State: ABy/qLZiWUwo7RaG4oXcJjjALta+br9sUtYQh7SiAONjAuNQr16oUk0S
	iENBnca97vcGJswi0pdcm1olycGGY1eRh8gw9VA=
X-Google-Smtp-Source: APBJJlFAVZ6Tme6VBwMQedmoZDF838nGwKdK8kJIEohO5MUoXwnFXIyPi7BmWcw0CMPAZULAwomNwwIF5xnHzSHaOEU=
X-Received: by 2002:a05:651c:1032:b0:2b2:1f2f:705f with SMTP id
 w18-20020a05651c103200b002b21f2f705fmr2835138ljm.4.1690912306615; Tue, 01 Aug
 2023 10:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730134223.94496-1-jolsa@kernel.org> <20230730134223.94496-26-jolsa@kernel.org>
In-Reply-To: <20230730134223.94496-26-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 10:51:35 -0700
Message-ID: <CAADnVQKdrMo+sMNbuKZt1HU5RXN7qfN+kEyTWXtN3U5uvGRjrQ@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 25/28] selftests/bpf: Add uprobe_multi usdt
 bench test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 30, 2023 at 6:46=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 39 +++++++++++++++++++
>  .../selftests/bpf/progs/uprobe_multi_usdt.c   | 16 ++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 56c2062af1c9..19a66431a61f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -4,6 +4,7 @@
>  #include <test_progs.h>
>  #include "uprobe_multi.skel.h"
>  #include "uprobe_multi_bench.skel.h"
> +#include "uprobe_multi_usdt.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
>
> @@ -234,6 +235,42 @@ static void test_bench_attach_uprobe(void)
>         printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
>  }
>
> +static void test_bench_attach_usdt(void)
> +{
> +       struct uprobe_multi_usdt *skel =3D NULL;
> +       long attach_start_ns, attach_end_ns;
> +       long detach_start_ns, detach_end_ns;
> +       double attach_delta, detach_delta;
> +
> +       skel =3D uprobe_multi_usdt__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
> +               goto cleanup;
> +
> +       attach_start_ns =3D get_time_ns();
> +
> +       skel->links.usdt0 =3D bpf_program__attach_usdt(skel->progs.usdt0,=
 -1, "./uprobe_multi",
> +                                                    "test", "usdt", NULL=
);
> +       if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt")=
)
> +               goto cleanup;
> +
> +       attach_end_ns =3D get_time_ns();
> +
> +       system("./uprobe_multi usdt");
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

It fails CI.
/tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.=
c:338:6:
error: variable 'attach_start_ns' is used uninitialized whenever 'if'
condition is true [-Werror,-Wsometimes-uninitialized]
if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))

