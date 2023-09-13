Return-Path: <bpf+bounces-9954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C353B79F151
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 20:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C77128198F
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63923649;
	Wed, 13 Sep 2023 18:44:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F037F
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 18:44:01 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E20AF
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 11:44:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so20487566b.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694630639; x=1695235439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mx9ptfUq3cRH1GDICHCpRLSVMhV/M/bSGDjGhuRMy8=;
        b=HgalyFsO1AWiX34EWpp58iJmATWdr2mBXlvEhciSX8w7Zew9TgZFIwjeIBTw2G6w8D
         W3Xk+JXcr+JS+QWoVUuuJnr0RVkeRcpZ1Ovx4EzyJT3jHczCATczEQ/VHWf/PQydLfOu
         EfUSVNZnRAsnGn/P16svgZq/lBdFtTloxSf2Bs6aj8QwmlbaGAY3lgSM5N6+8BnTII+C
         spSKfiqMto1KRag6BJu27dNrOFecANGFcaK281hbLRXk3oNms2ow1TcCzjAvRmDEIun2
         MuJutTX9BaJ1LX53dqvAttfO24mavTQk+dskasyzsd+9JpdP4PJpFX0FiOfCLO31QAEZ
         nJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694630639; x=1695235439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mx9ptfUq3cRH1GDICHCpRLSVMhV/M/bSGDjGhuRMy8=;
        b=lM+H2C92PnJQEOj2LncMvT037qfzeIU1iGbgcs3SxT0EqGqPvFpi4J5rnj8RhtNQ4D
         QLjx+Nfhylp2yQxakhVsnk2Zh6swg/nfDR4fQdiDLNcLL4drL7XfyS3PFUZKTqh8EmEA
         2MfduowSGD9Zv1axq8FFGylkpA2zceqCr4oY/ymV+zUI8eWlyFV1uqqSADYh+8oyLXSP
         3ZeU2/mYLP3ZImEiktA51GmpbM7BiDGFo27fkx4nQiXBzAPkYKXKat8NM21fi7QqFOFC
         nHXGDzs2mZ3MaY8Fe+t5Bel9cxdQpORCAh6t4EmfUL+dU1K2m1c40fJ5PsHPki9s+wMs
         CUVg==
X-Gm-Message-State: AOJu0Ywehvwlt/GRyOMFB0KbyEBo6NM/Yr7rERGPFfT2BG/wOYSieQMp
	9bJ/p1ngvOQtCQPhvM85b9roZGhx1OZTFbdShuQ=
X-Google-Smtp-Source: AGHT+IFf7fgOgfoOZ59GbNdBRRlEGkCc0m/9vZtfadsSdm2woE8ru9yov35MB97Q7UCCXjpXRyRH0ljwxtXX6Qd9ggI=
X-Received: by 2002:a17:907:2cf6:b0:99b:4668:865f with SMTP id
 hz22-20020a1709072cf600b0099b4668865fmr2574349ejc.10.1694630639047; Wed, 13
 Sep 2023 11:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913114711.499829-1-jolsa@kernel.org>
In-Reply-To: <20230913114711.499829-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Sep 2023 11:43:47 -0700
Message-ID: <CAEf4Bza6GiLXgB1mmo7jUcQPT4PW+tCRTQ266bZ706cqG7sOSg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf] selftests/bpf: Fix kprobe_multi_test/attach_override
 test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 4:47=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We need to deny the attach_override test for arm64, denying the
> whole kprobe_multi_test suite. Also making attach_override static.
>
> Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64             | 9 +--------
>  .../testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> v2 changes:
>   - rebased on latest bpf/master, used just kprobe_multi_test suite name
>     in DENYLIST.aarch64 to cover all kprobe_multi tests
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 7f768d335698..b733ce16c0f8 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,14 +1,7 @@
>  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api=
_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api=
_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  fexit_sleep                                      # The test never return=
s. The remaining tests cannot start.
> -kprobe_multi_bench_attach                        # bpf_program__attach_k=
probe_multi_opts unexpected error: -95

did you drop kprobe_multi_bench_attach from DENYLIST intentionally?
I'll leave it in DENYLIST.aarch64 for now when applying

> -kprobe_multi_test/attach_api_addrs               # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> -kprobe_multi_test/attach_api_pattern             # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> -kprobe_multi_test/attach_api_syms                # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> -kprobe_multi_test/bench_attach                   # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> -kprobe_multi_test/link_api_addrs                 # link_fd unexpected li=
nk_fd: actual -95 < expected 0
> -kprobe_multi_test/link_api_syms                  # link_fd unexpected li=
nk_fd: actual -95 < expected 0
> -kprobe_multi_test/skel_api                       # libbpf: failed to loa=
d BPF skeleton 'kprobe_multi': -3
> +kprobe_multi_test                                # needs CONFIG_FPROBE
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

