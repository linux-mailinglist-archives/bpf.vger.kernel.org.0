Return-Path: <bpf+bounces-1897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9997233B4
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 01:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A51B281440
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637F28C1B;
	Mon,  5 Jun 2023 23:35:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0224133
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:35:37 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B8BE;
	Mon,  5 Jun 2023 16:35:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bad041bf313so6222427276.0;
        Mon, 05 Jun 2023 16:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686008135; x=1688600135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXBa1OF9wyqrqgINd5V2c4ioF1ab+8rAgw8Ep/U3yMA=;
        b=AL+Ge5/YlThoGO4H0zx1pmdE97/tOYhDJ2vX7H6QDbTeus04DgAaicAH1fUh/Mq002
         lLm3Jd1XUmY+Cyipyaq75s3Ms9HOzKwtSNWG46kp9w2GZMxwNMmODDegt/+mji2iTHTR
         iJl6U30grYE2U/s+2OBfR5zKKLG2fNr2wpkxxy3GLS9eFEnTKVYr+kc9YKjgzhYh4Acs
         ImjbIfjg7SkE3TvCZsRK8+9l/1h+t+JoZS+79Ilv8j+gM/h8dlZyM3sMfsQx+4omm6tT
         zQLmrelULh2bd5Y8/COGAOLhSyyWuQjtBQpxRxTW7lnSNzKPmSMT5FYgPtS2T8YRGRma
         NM/Q==
X-Gm-Message-State: AC+VfDxflv9Uri7HfOiD1F94d6uqwGX8mguLcaghiTXMGiwo8GYQ2TdS
	yKPdzymOp5SrZd2ZjXf1QB9oHRRNWLkZ6bhUFZc=
X-Google-Smtp-Source: ACHHUZ5X6EzdLPTNeS7VtKN76AV0N+udS+M5tYINfocpG79PtXLUVvQfElmb+pYat4Fa92Nis/2t+Y5FGWVMQYK58E4=
X-Received: by 2002:a25:ab8a:0:b0:ba8:841f:dd9a with SMTP id
 v10-20020a25ab8a000000b00ba8841fdd9amr12368151ybi.64.1686008135002; Mon, 05
 Jun 2023 16:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com> <20230605202712.1690876-5-irogers@google.com>
In-Reply-To: <20230605202712.1690876-5-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Jun 2023 16:35:23 -0700
Message-ID: <CAM9d7cj9k_FYxmAymHG5Nn6-dhjPT95wrqbHZ_YZSx=oZX7YXQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf build: Filter out BTF sources without a .BTF section
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Mon, Jun 5, 2023 at 1:28=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> If generating vmlinux.h, make the code to generate it more tolerant by
> filtering out paths to kernels that lack a .BTF section.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f1840af195c0..c3bb27a912b0 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -193,6 +193,7 @@ FLEX    ?=3D flex
>  BISON   ?=3D bison
>  STRIP   =3D strip
>  AWK     =3D awk
> +READELF ?=3D readelf
>
>  # include Makefile.config by default and rule out
>  # non-config cases
> @@ -1080,12 +1081,28 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
>         $(Q)CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
>                 OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
>
> -VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                          =
 \
> +# Paths to search for a kernel to generate vmlinux.h from.
> +VMLINUX_BTF_ELF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                      =
 \
>                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
>                      ../../vmlinux                                      \
> -                    /sys/kernel/btf/vmlinux                            \
>                      /boot/vmlinux-$(shell uname -r)
> -VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
> +
> +# Paths to BTF information.
> +VMLINUX_BTF_BTF_PATHS ?=3D /sys/kernel/btf/vmlinux
> +
> +# Filter out kernels that don't exist or without a BTF section.
> +VMLINUX_BTF_ELF_ABSPATHS ?=3D $(abspath $(wildcard $(VMLINUX_BTF_ELF_PAT=
HS)))
> +VMLINUX_BTF_PATHS ?=3D $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); =
\
> +                       do \
> +                               if [ -f $$file ] && ($(READELF) -t "$$fil=
e" | grep .BTF); \

Wouldn't it be `readelf -S` instead?  Also I think grep needs -q to
suppress output.


> +                               then \
> +                                       echo "$$file"; \
> +                               fi; \
> +                       done) \
> +                       $(wildcard $(VMLINUX_BTF_BTF_PATHS))

This changes the order of processing the sysfs file.
But I'm not sure it matters much as both /boot/vmlinux and sysfs
should refer to the running kernel.

Thanks,
Namhyung


> +
> +# Select the first as the source of vmlinux.h.
> +VMLINUX_BTF ?=3D $(firstword $(VMLINUX_BTF_PATHS))
>
>  $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>  ifeq ($(VMLINUX_H),)
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>

