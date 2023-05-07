Return-Path: <bpf+bounces-185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDB6F96A0
	for <lists+bpf@lfdr.de>; Sun,  7 May 2023 04:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C822811CB
	for <lists+bpf@lfdr.de>; Sun,  7 May 2023 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD06C15CD;
	Sun,  7 May 2023 02:57:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E715BC
	for <bpf@vger.kernel.org>; Sun,  7 May 2023 02:57:11 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B0100FC;
	Sat,  6 May 2023 19:57:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ba2362d4ea9so658480276.3;
        Sat, 06 May 2023 19:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683428229; x=1686020229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y27uBZQDxoMMmtt5dKQE+mflLBajPhR2V/YDaYqpNNc=;
        b=A90SH9+Br6HbaXDq8LUAqmiSeIlDsq262SOZN+mwQwpJKmeMHQrtByTfQpMc2nhdnC
         jfAyvJzN87Y6cfhHKuZWG+26fO6jjNJu+1497FIwuL0IKiMewIQvUYSiPiqEJwx8XK6i
         rE8vp5S3RqZ4Q2aZbnOBY9sBR2GKW37gK/q5nwoK1brYVSFiI1UvMbdJINPRjxdXw7ze
         Iesd09+Z0Dm+6erB/0uItWl6yRuqQQzrjcCq3LfYM44iJzV+CHKyLdgMUxSmQmsWRgmY
         Vfvc/4FX+a6jO5m5oyRJdU/1aXkrh98Dqm9/+XeUKFS9asrRlHJ4absiejtyFsIAD/fR
         QXNw==
X-Gm-Message-State: AC+VfDwSXVIm6nqoGl2xbQYUEXrlisoYE0nSHt0FXKPS35Qe3gsRtjhI
	A8NNh/JBRhLn+gknh7fgjA1ZbmyS+kaAQARwRoQ=
X-Google-Smtp-Source: ACHHUZ5KYd+Vp866GdYz32Yb8G1anYuwcXULbK3NRkDd6T9rO6BPZvKgFiMbj5mIdsFH380Y3SgiWsJzPH/v6x/8GkQ=
X-Received: by 2002:a25:e648:0:b0:b9e:712f:4a17 with SMTP id
 d69-20020a25e648000000b00b9e712f4a17mr6602071ybh.6.1683428229058; Sat, 06 May
 2023 19:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230506021450.3499232-1-irogers@google.com>
In-Reply-To: <20230506021450.3499232-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 6 May 2023 19:56:56 -0700
Message-ID: <CAM9d7cieo+cF9uNfgQq=R1BofNN5Ae69sjz80rV8-TxXPZFasg@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Add system include paths to BPF builds
To: Ian Rogers <irogers@google.com>
Cc: Song Liu <songliubraving@meta.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Fri, May 5, 2023 at 7:15=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> There are insufficient headers in tools/include to satisfy building
> BPF programs and their header dependencies. Add the system include
> paths from the non-BPF clang compile so that these headers can be
> found.
>
> This code was taken from:
> tools/testing/selftests/bpf/Makefile
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, this fixes the BPF build failure on my machine.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Makefile.perf | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 61c33d100b2b..37befdfa8ac8 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1057,7 +1057,25 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) =
$(LIBPERF_OUTPUT) $(LIBSUBCMD_
>
>  ifndef NO_BPF_SKEL
>  BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
> -BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> +
> +# Get Clang's default includes on this system, as opposed to those seen =
by
> +# '-target bpf'. This fixes "missing" files on some architectures/distro=
s,
> +# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
> +#
> +# Use '-idirafter': Don't interfere with include mechanics except where =
the
> +# build would have failed anyways.
> +define get_sys_includes
> +$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> +       | sed -n '/<...> search starts here:/,/End of search list./{ s| \=
(/.*\)|-idirafter \1|p }') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{pri=
ntf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}')
> +endef
> +
> +ifneq ($(CROSS_COMPILE),)
> +CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> +endif
> +
> +CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_A=
RCH))
> +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_IN=
CLUDES)
>
>  $(BPFTOOL): | $(SKEL_TMP_OUT)
>         $(Q)CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
> --
> 2.40.1.521.gf1e218fcd8-goog
>

