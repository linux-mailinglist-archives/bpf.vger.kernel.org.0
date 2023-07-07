Return-Path: <bpf+bounces-4401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D874A9FA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AA8281660
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A291FB2;
	Fri,  7 Jul 2023 04:38:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72E1847
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:38:36 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474B1BD2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:38:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso2175011e87.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704712; x=1691296712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f882D05rjydvaIuWjMhcG3iPCcr6sZXqYG9o5EUosC0=;
        b=K4m3CgXgJBEWc4qGGTDgMZ1TllQSBzbz6T18SqWoKm0Lo/Bv1E1k9ZFOliykmKWoIa
         wcQ4/9YpwzxKdcIUq6e69oICwb/1an1fWQhZwP2H0ymq9VYFC9xziqdLXq+AtVXgzPkz
         D+8HuFnk3XXcjtC2LmWas+uTEA4eJomvBeXLUF4xqbiaSA1w4k/iUTbbJmgEW7f42sbz
         oTw7aYt48drmwn9tow3UcKUvW2i+vKZ+thL1NBMsU6598zEk0bdoQfinkLWRFrYhx9AH
         gB9oCwE8Tg/JyeUOiagGyj6b9PDRql0eDsh9Mn6kSTRsgDpGsM3nL0cT5RXec7SwLSlt
         6sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704712; x=1691296712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f882D05rjydvaIuWjMhcG3iPCcr6sZXqYG9o5EUosC0=;
        b=V0sL+lZbruvT+1S8ukm6fWmLMAOGhX3U8rYTYchkXgGAy9IMeU0O8VnzLwkdLK7oS/
         ztLtM8SarQsmhOQjRD71cW4/D1ouTjzSG5LS/hTeLi+d1QBTNaJ8RsRQQ2MlgozDeWYy
         AxobLIghdryxZa1xTmMCkAyaYb/5NLb9a+C3oRaKtw95L1Scr79YN4HrBsaea8pgO4E+
         vLM5g4Ct3N0awGVJazy6wk3ucjZw8EGEnFkxgA8DnLJUP0geHnpCbyuVt+OjbGxNXI7P
         4REE+/gxMBUUgiievYfYTuyRrN75Nfe8KySWj63MilXDG1NGnNzmQKfvspqJeOC1FcAm
         Zpwg==
X-Gm-Message-State: ABy/qLYNEnfHuCz16IOz3Rgf3sAIM7cH47YRZyh8pfRPXZRko7ejg28N
	16jwObC2qOBcfFDUxB9IutYMQfqlk/3JnApjnvo=
X-Google-Smtp-Source: APBJJlEcMlFvp/qurCVSS3KUjDyJRT/JdteOOgILDP37zF5gufhIGgm1wSAKxaGW94TwKvNZV8SM69i0Shw4lTcUDYE=
X-Received: by 2002:a19:e059:0:b0:4fb:8bad:1cdf with SMTP id
 g25-20020a19e059000000b004fb8bad1cdfmr2815355lfj.42.1688704712485; Thu, 06
 Jul 2023 21:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-22-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-22-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:38:20 -0700
Message-ID: <CAEf4BzYrKXWskLfHY+FOLWjNMvm_ujvmHVB6ai8zrMevFXEg2Q@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 21/26] selftests/bpf: Add uprobe_multi bench test
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
> Adding test that attaches 50k uprobes in uprobe_multi binary.
>
> After the attach is done we run the binary and make sure we
> get proper amount of hits.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 56 +++++++++++++++++++
>  .../selftests/bpf/progs/uprobe_multi.c        |  9 +++
>  2 files changed, 65 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index fd858636b8b0..547d46965d70 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -202,6 +202,60 @@ static void test_link_api(void)
>         free(offsets);
>  }
>
> +static inline __u64 get_time_ns(void)
> +{
> +       struct timespec t;
> +
> +       clock_gettime(CLOCK_MONOTONIC, &t);
> +       return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
> +}
> +

hmm.. I would expect we have this helper somewhere in common headers.
If not, we should probably move all such helpers into one header and
use it everywhere

> +static void test_bench_attach_uprobe(void)
> +{
> +       long attach_start_ns, attach_end_ns;
> +       long detach_start_ns, detach_end_ns;
> +       double attach_delta, detach_delta;
> +       struct uprobe_multi *skel =3D NULL;
> +       struct bpf_program *prog;
> +       int err;
> +
> +       skel =3D uprobe_multi__open();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
> +               goto cleanup;
> +
> +       bpf_object__for_each_program(prog, skel->obj)
> +               bpf_program__set_autoload(prog, false);
> +
> +       bpf_program__set_autoload(skel->progs.test_uprobe_bench, true);

I don't get why you bothered adding this test_uprobe_bench into
progs/uprobe_multi and go through this manual auto-load
setting/resetting, instead of just having test_uprobe_bench in a
separate skeleton?...

> +
> +       err =3D uprobe_multi__load(skel);
> +       if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
> +               goto cleanup;
> +
> +       attach_start_ns =3D get_time_ns();
> +
> +       err =3D uprobe_multi__attach(skel);
> +       if (!ASSERT_OK(err, "uprobe_multi__attach"))
> +               goto cleanup;
> +
> +       attach_end_ns =3D get_time_ns();
> +
> +       system("./uprobe_multi");
> +
> +       ASSERT_EQ(skel->bss->count, 50000, "uprobes_count");
> +
> +cleanup:
> +       detach_start_ns =3D get_time_ns();
> +       uprobe_multi__destroy(skel);
> +       detach_end_ns =3D get_time_ns();
> +
> +       attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0=
;
> +       detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0=
;
> +
> +       printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> +       printf("%s: detached in %7.3lfs\n", __func__, detach_delta);

and for us lazy folks, what are the numbers you see on your machine?

> +}
> +
>  void test_uprobe_multi_test(void)
>  {
>         if (test__start_subtest("skel_api"))
> @@ -212,4 +266,6 @@ void test_uprobe_multi_test(void)
>                 test_attach_api_syms();
>         if (test__start_subtest("link_api"))
>                 test_link_api();
> +       if (test__start_subtest("bench_uprobe"))
> +               test_bench_attach_uprobe();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/tes=
ting/selftests/bpf/progs/uprobe_multi.c
> index 1eeb9b7b9cad..cd73139dc881 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> @@ -89,3 +89,12 @@ int test_uretprobe_sleep(struct pt_regs *ctx)
>         uprobe_multi_check(ctx, true, true);
>         return 0;
>  }
> +
> +int count;
> +
> +SEC("?uprobe.multi/./uprobe_multi:uprobe_multi_func_*")
> +int test_uprobe_bench(struct pt_regs *ctx)
> +{
> +       count++;
> +       return 0;
> +}
> --
> 2.41.0
>

