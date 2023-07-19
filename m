Return-Path: <bpf+bounces-5348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F51759C7F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8AC1C210D7
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C71FB5E;
	Wed, 19 Jul 2023 17:35:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA11FB48
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:35:56 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421A1FC8
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 10:35:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so11706421e87.1
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689788150; x=1692380150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeilNh/X9iTPkhm+EoZ3CaLxTAJS2yjhX1F8rt/POPg=;
        b=DdCVsADAdch4ubysd+pjLSKOyvbwmNmwq3M+51zu5/rCJnVKx853QfFadMbkKr2tA8
         Ey32YZemeRElBuB4ku5U7i8EjL4Cyyiyy6iIdMHq3R3Ivyq6C/5uJvfZuF0Y1pO/FXjF
         BunmxKz4bThlbEoVbgWacFg4Vn5Pwgq2pGbj5bCHciXyEig5yPH3ZYfXOojUwLaSkdS8
         h7um3R9HWgevwHoL3TlPbbsHHs+SMaopwGBq4JdOYirpttsb1R6c/4/TvOBT6WFfLeDX
         HU2Cy2Rx9RHywb3mzaAaDKBT43RFhgWxzDFns4ojXRwg5W9eHP9j6VS9IMAhSFdoNAJL
         1x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788150; x=1692380150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeilNh/X9iTPkhm+EoZ3CaLxTAJS2yjhX1F8rt/POPg=;
        b=No2WUo8GjbO8M7qgBfDq93e3FmnDSPq/fUolqJw+dhp75mG5xE7KrRODqD1p2QYIGw
         ewvCApwsakp70nsNCD84EeSzh/i9AOxkhzLqP+TF8f/98+2DHJi2p+73KkuqLI3Z87rs
         Sj69ZuaPVlOKfGRlYtpeT+kzuZp7BESELqD57Bt34zKayqst4xyAM4iDfg1Ge/bIf6B4
         YnQoEz2Nnw/tyLKQg3zMsTs+5lg5ylii8MSuXNIVa3On3m+ZYTr0/xlTb+c8yLacJLKc
         jNP3TFeyvXKd2/lEsuIx9pt5LLRx2ceF0sKFeZKTYYLGPCSnANXXMOawTmhLJsI3gIRN
         GQ6w==
X-Gm-Message-State: ABy/qLamuSpFT3pTFTjP4eKTCWqebKb0CDYg+m3P3//aJ0nl7hbrMUYX
	xeoORE9InH7eXBtB9Rzr7eiqW2iBiiaq5sMIoYE=
X-Google-Smtp-Source: APBJJlGmY94jXyFJcPYKI64gCe/9rAy4kDbqVlPHms8I/zEnxipiUkdhWuhnAdES76Ws7nBlwghto/k+OxBGhpD6Qk0=
X-Received: by 2002:a2e:9899:0:b0:2b9:4410:9174 with SMTP id
 b25-20020a2e9899000000b002b944109174mr480419ljj.34.1689788150194; Wed, 19 Jul
 2023 10:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719014744.3480131-1-awerner32@gmail.com>
In-Reply-To: <20230719014744.3480131-1-awerner32@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jul 2023 10:35:39 -0700
Message-ID: <CAADnVQLzUN8DUEpjt7xtr=zqSoTaTrHkt16ifEi3znttdSc_NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix ringbuf benchmark output
To: Andrew Werner <awerner32@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 6:50=E2=80=AFPM Andrew Werner <awerner32@gmail.com>=
 wrote:
>
> The headers were confusing.
> ---

SOB is missing.

commit log is too terse.
Pls explain what you're fixing.

>  tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/t=
ools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> index 91e3567962ff..8dd97f5108f0 100755
> --- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> @@ -6,12 +6,12 @@ set -eufo pipefail
>
>  RUN_RB_BENCH=3D"$RUN_BENCH -c1"
>
> -header "Single-producer, parallel producer"
> +header "Single-consumer, parallel producer"
>  for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
>         summarize $b "$($RUN_RB_BENCH $b)"
>  done
>
> -header "Single-producer, parallel producer, sampled notification"
> +header "Single-consumer, parallel producer, sampled notification"

Single-producer, consumer/producer competing on the same CPU, low batch cou=
nt

should also be fixed?

