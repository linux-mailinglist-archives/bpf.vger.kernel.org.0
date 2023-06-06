Return-Path: <bpf+bounces-1907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363E723586
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 04:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A8D2814FF
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5339F;
	Tue,  6 Jun 2023 02:57:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EF361
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 02:57:15 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D57102;
	Mon,  5 Jun 2023 19:57:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30af56f5f52so4838705f8f.1;
        Mon, 05 Jun 2023 19:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686020232; x=1688612232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrvUy89BvIUPEyxGx6YhXaN1N8mQsZqXnnNriiDSvME=;
        b=jztOKtGtWaW4lJiqwG6Jn63CphDAucHhmfhEZVF0n7eK3l+gqdPZGYnpr829f9Xl8C
         GR5eyaw9zjC676MPXMWww+Y66mrXEUO60Cxsd25GVH7O1lNlPuRseon6E8dWu2g+lsKe
         aCtXZkCuNn9z6vByVQqLzBwMCl51FkDI0t6Zn/R399eR2qoNedrfYpz1Qf2oJqZq0oZA
         0OBkAXCQYc/3/RW0j68bWeaynUII842+Z+noRXH2cEQjojHjGSshoXrz67aYEg32R0HO
         GCzKxCtKQaFMJdbKZQdvCZ2AsKR1SOOUQaa4p5e7vBygsfONGislCbjdzOVd7cbmG83A
         ghGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686020232; x=1688612232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrvUy89BvIUPEyxGx6YhXaN1N8mQsZqXnnNriiDSvME=;
        b=X2S1R/hVRGHbisc0Mkp30OH5T74V2aqfRTUTc2S8jFsheu3Laf65o8FQyBnbCP8q34
         plDy3rR1/ulJrgyZq3msvrBxu6bevGdYghGF94N+/FoFdXLPQdYy5/l6hJ/iK7qrwdtz
         gMZv0KNtU1xt6Vq5P3EaNglRY9Fb5Z8MLlTXWEP6ab+rS8YR6OYGYEQpfE7kubnyyxKF
         JNgkf05f//cOGKRNZQP08vDGyU1zaC1aC41Z2y9Dma/yU3JhjOWhmvD1I8VvryHj1rek
         cuzh/qPCTq4pxz0c7A1eoER6vi0szZ0ZSZuCJJI3Zj6T3EHkZb4uQwlYKkxmVEuS5LJ2
         RtjQ==
X-Gm-Message-State: AC+VfDzx1+q42JZcVZmjDWRZVjfuw9Cyge3RNNZErzqcMKoK65GWUIjn
	62ZiYsG8A6FMli2kaLH93f8=
X-Google-Smtp-Source: ACHHUZ7nGp/lJQb6dwofZStNfHBGcrDqqlqYtXbLcL+6qXMsnTiupV4dSOZgNCAnRUQk5m/hpSfB/Q==
X-Received: by 2002:a5d:510c:0:b0:309:3af4:8c8c with SMTP id s12-20020a5d510c000000b003093af48c8cmr539800wrt.54.1686020231479;
        Mon, 05 Jun 2023 19:57:11 -0700 (PDT)
Received: from krava ([80.149.170.9])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c205200b003f427687ba7sm12383930wmg.41.2023.06.05.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:57:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Jun 2023 04:56:38 +0200
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 1/4] perf build: Add ability to build with a generated
 vmlinux.h
Message-ID: <ZH6gZgcwAbDrEiqX@krava>
References: <20230605202712.1690876-1-irogers@google.com>
 <20230605202712.1690876-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605202712.1690876-2-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 05, 2023 at 01:27:09PM -0700, Ian Rogers wrote:
> Commit a887466562b4 ("perf bpf skels: Stop using vmlinux.h generated
> from BTF, use subset of used structs + CO-RE") made it so that
> vmlinux.h was uncondtionally included from
> tools/perf/util/vmlinux.h. This change reverts part of that change (so
> that vmlinux.h is once again generated) and makes it so that the
> vmlinux.h used at build time is selected from the VMLINUX_H
> variable. By default the VMLINUX_H variable is set to the vmlinux.h
> added in change a887466562b4, but if GEN_VMLINUX_H=1 is passed on the
> build command line then the previous generation behavior kicks in.
> 
> The build with GEN_VMLINUX_H=1 currently fails with:
> ```
> util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> struct rq {};
>        ^
> /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
> struct rq {
>        ^
> 1 error generated.
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/perf/Makefile.config                       |  4 ++++
>  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
>  tools/perf/util/bpf_skel/.gitignore              |  1 +
>  tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h |  0
>  4 files changed, 20 insertions(+), 1 deletion(-)
>  rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (100%)

looks good, but I don't understand why you moved the vmlinux.h

jirka

> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a794d9eca93d..08d4e7eaa721 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -680,6 +680,10 @@ ifdef BUILD_BPF_SKEL
>    CFLAGS += -DHAVE_BPF_SKEL
>  endif
>  
> +ifndef GEN_VMLINUX_H
> +  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
> +endif
> +
>  dwarf-post-unwind := 1
>  dwarf-post-unwind-text := BUG
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f48794816d82..f1840af195c0 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1080,7 +1080,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
>  	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
>  		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
>  
> -$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
> +VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
> +		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
> +		     ../../vmlinux					\
> +		     /sys/kernel/btf/vmlinux				\
> +		     /boot/vmlinux-$(shell uname -r)
> +VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> +
> +$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> +ifeq ($(VMLINUX_H),)
> +	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> +else
> +	$(Q)cp "$(VMLINUX_H)" $@
> +endif
> +
> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
>  	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>  	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
>  
> diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_skel/.gitignore
> index 7a1c832825de..cd01455e1b53 100644
> --- a/tools/perf/util/bpf_skel/.gitignore
> +++ b/tools/perf/util/bpf_skel/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  .tmp
>  *.skel.h
> +vmlinux.h
> diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> similarity index 100%
> rename from tools/perf/util/bpf_skel/vmlinux.h
> rename to tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

