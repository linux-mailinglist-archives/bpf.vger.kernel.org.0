Return-Path: <bpf+bounces-11578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0E7BC121
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113DC2820F5
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902A44494;
	Fri,  6 Oct 2023 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6SYoa2Y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92C42C13;
	Fri,  6 Oct 2023 21:27:30 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF34BD;
	Fri,  6 Oct 2023 14:27:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317c3ac7339so2270409f8f.0;
        Fri, 06 Oct 2023 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696627647; x=1697232447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LOMLFTaNBQx5qytUiXEAPk+GRgb6gB7gLtxh/K3vXk=;
        b=f6SYoa2Y6B4l7ij2EVjFyxrnHBrdvOP99XSqx2WwyPKZkz6YdLsz8Q1WaDkoj2HEMm
         sapsjYbHm6rvc/+s7FbK8cRhkzCkcta28BrsT8Lzy0JmRfl13nCIHUcVy1eIBMCwZN84
         ZuHsQr6hEZ3dltTvpNImncrL0w2DUB6QcmRKoWXwBlusSJWn/Bj3D8jLoqL4glQvh1FT
         v7+2Mq31XZb5vPQT28Wx/1Gkks+4utqqPXBCmBv0fScyUzmDmPUZr0kIb+6x4da4lepv
         x0Y9QjmDw15PkSN5gcHA9HdlwihD2p0RYy2h/GeLMc0cZlMEc6gp9bJuVHyOCfR0lWwl
         +kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627647; x=1697232447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LOMLFTaNBQx5qytUiXEAPk+GRgb6gB7gLtxh/K3vXk=;
        b=uktGU8HwEv1VC2T4Ozj4AbzQEMc8/Wsu+nDjQorHfkp8hHSIcLhVYZ/wmw/sdPmAgc
         +QtZ8WC2MyQt8DoFLDDOXIaUMdxBgVZmksnHMLLJQw8ZpmuHrX2uUwGgLwpf543dLt5i
         03lyuBtAtKmiznTS4k5LBiXEwFbFrvA09YVOwpmm4uzV68tFpD3sCblqEta4as0iPoLt
         bNGOEd/L3sSSWJA/epzT7d5v7JLvs00kvQyq+ONpsXmnVX2oHshYC91U42NTzC1HXQ8P
         eQtgHrkbGTImWQOAfXkKUmO4pVE9jkHM09d4K46Hprd/OGnFl98sny3EBUm+f1iNh7cM
         xwZg==
X-Gm-Message-State: AOJu0YxW62n3YSYZ/UbUnVx49p8vZe68y/dDBiVj2QPufWaNNZxztuuM
	iNe6EC0jnqGkv/LjJnY+uyI=
X-Google-Smtp-Source: AGHT+IEcGEWB6ShYFg/G7LTKWR1VOCfl2Qbc9+Er22OsxHRH9DDfdbbl3YUFckQA4fimPKUEVdw2nQ==
X-Received: by 2002:adf:f585:0:b0:322:7174:7d28 with SMTP id f5-20020adff585000000b0032271747d28mr8058998wro.55.1696627646496;
        Fri, 06 Oct 2023 14:27:26 -0700 (PDT)
Received: from krava ([83.240.63.40])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b0040531f5c51asm4556377wmj.5.2023.10.06.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 14:27:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Oct 2023 23:27:23 +0200
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>
Cc: Dmitry Goncharov <dgoncharov@users.sf.net>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] tools/build: Fix -s detection code for new make
Message-ID: <ZSB7u/jmxpjGSrVt@krava>
References: <20231004135956.987903-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004135956.987903-1-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 03:59:56PM +0200, Jiri Olsa wrote:
> As Dmitry described in [1] changelog the current way of detecting
> -s option is broken for new make.
> 
> Changing the tools/build -s option detection the same way as it was
> fixed for root Makefile in [1].
> 
> [1] 4bf73588165b ("kbuild: Port silent mode detection to future gnu make.")
> 
> Cc: Dmitry Goncharov <dgoncharov@users.sf.net>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

we actually need same change in tools/scripts/Makefile.include as well,
I'll resend v2

jirka

> ---
>  tools/build/Makefile.build | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index fac42486a8cf..5fb3fb3d97e0 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -20,7 +20,15 @@ else
>    Q=@
>  endif
>  
> -ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
> +# If the user is running make -s (silent mode), suppress echoing of commands
> +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> +short-opts := $(firstword -$(MAKEFLAGS))
> +else
> +short-opts := $(filter-out --%,$(MAKEFLAGS))
> +endif
> +
> +ifneq ($(findstring s,$(short-opts)),)
>    quiet=silent_
>  endif
>  
> -- 
> 2.41.0
> 

