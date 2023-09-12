Return-Path: <bpf+bounces-9758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F579D426
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B65281E85
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49418B11;
	Tue, 12 Sep 2023 14:57:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF778179A0
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:57:54 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3399115
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 07:57:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso95874541fa.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694530672; x=1695135472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDSjLZPUlLSKkyz9dr/nrzLdl+r9COojL1KDimlXsBo=;
        b=Ri6il9tUQY2dVN+cI1RRKJwcjUQEd9IDEgDOyAOdoia1htrB2/qJKK2htsKnbt4i6L
         I2yNG7wiTdcdCxmgAjd90Tg/IU6FAza+tc5Njy69aIdlPUYr4XHyvg4JLssLSXzQo6Mi
         /S/kltJQlKGr3p7KxW5dDVxvPDdioJ2+48G2xdKt8kl2z5ZdpWdTfCaPyjkB2kAAoRS3
         v6wOcIsJksdx27ZDJ7Mh24z4BKUpPvV7h6a/WnuFLiRAHhYeGzN8b2yD0WAaxwmkzR83
         Kt11goYhCgvBxmUb+MyfOPFZY9xrM8RMocHOV6SbBbKuWHmwA1EJRNAGaMdaE96U4fO/
         ebkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694530672; x=1695135472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDSjLZPUlLSKkyz9dr/nrzLdl+r9COojL1KDimlXsBo=;
        b=kMa0UwK7LjKVFhhd6Ig486+sZhxeS9OdrejLKufSOUtdPEJO2Z2WOFJS0yGNfd/XwR
         ToQqWvCaKNGpGKvXMXQIT/f7HrNv20mXe6TdG/a1wrZxFrmbYMhGwmish63c8QWttMf6
         +U+6uVsPMvTnQgAVeL0kgZKKdJhBf/hGtk81PYb/cXO+pnBkyuCWu7BrYekukMmlpapg
         Cn+lVMYXJctkGTV2SJMIqb9pyB4SWG591RmJKYLxrd+qaifnum4WMyzDsSc4+ver78cG
         UFbrN3zYMt5ItVvgcbsHL25XZ6nZzg1xlroW1z5YtwZ25vGrVTBdPMjdzgHMdvJsTF6y
         iW1w==
X-Gm-Message-State: AOJu0Yy9nUurviqzzz7B24sdkFeBsopHGitBT1HoFiT3Kv7fE5/6m/XN
	kHqLkHvF2nk6HajzaMJ0YPg4QS1mKxcvBiMBjBg=
X-Google-Smtp-Source: AGHT+IEPTFsDvjutGI081t7VTsbS9CzuaoTwA07VL3vXlDbP6/UuQn0zcBURdP1Hr20dXRr7g2ANATojeahbtllaFjw=
X-Received: by 2002:a19:4314:0:b0:502:cc8d:f206 with SMTP id
 q20-20020a194314000000b00502cc8df206mr1643629lfa.23.1694530671667; Tue, 12
 Sep 2023 07:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912141437.366046-1-jolsa@kernel.org>
In-Reply-To: <20230912141437.366046-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 07:57:40 -0700
Message-ID: <CAADnVQ+BfF3fojHCcfq6suJ-4GkTrchtkfrZHtvt0OQDMXLBBA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix kprobe_multi_test/attach_override test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 7:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We need to deny the attach_override test for arm64
> and make it static.
>
> Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64               | 1 +
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 7f768d335698..b32f962dee92 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -9,6 +9,7 @@ kprobe_multi_test/bench_attach                   # bpf_pr=
ogram__attach_kprobe_mu
>  kprobe_multi_test/link_api_addrs                 # link_fd unexpected li=
nk_fd: actual -95 < expected 0
>  kprobe_multi_test/link_api_syms                  # link_fd unexpected li=
nk_fd: actual -95 < expected 0
>  kprobe_multi_test/skel_api                       # libbpf: failed to loa=
d BPF skeleton 'kprobe_multi': -3
> +kprobe_multi_test/attach_override                # test_attach_override:=
FAIL:kprobe_multi_empty__open_and_load unexpected error: -22

why do we need this ?
Andrii, move of kconfig override into common should fix it, no?

>  module_attach                                    # prog 'kprobe_multi': =
failed to auto-attach: -95
>  fentry_test/fentry_many_args                     # fentry_many_args:FAIL=
:fentry_many_args_attach unexpected error: -524
>  fexit_test/fexit_many_args                       # fexit_many_args:FAIL:=
fexit_many_args_attach unexpected error: -524
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index e05477b210a5..4041cfa670eb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -454,7 +454,7 @@ static void test_kprobe_multi_bench_attach(bool kerne=
l)
>         }
>  }
>
> -void test_attach_override(void)
> +static void test_attach_override(void)
>  {
>         struct kprobe_multi_override *skel =3D NULL;
>         struct bpf_link *link =3D NULL;
> --
> 2.41.0
>

