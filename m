Return-Path: <bpf+bounces-12117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4E7C7C64
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 05:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEC21C2119C
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 03:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA21C33;
	Fri, 13 Oct 2023 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790C7F3;
	Fri, 13 Oct 2023 03:57:47 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858D7BC;
	Thu, 12 Oct 2023 20:57:45 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5a1d91a29a0so1282839a12.1;
        Thu, 12 Oct 2023 20:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697169465; x=1697774265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNozd1ni+Cz5fSLucDFdEkSt5iA0mcMvLECDnXGT/RY=;
        b=gZB1WwG5XA08UeaRjJt1/QId2pZGAEEm0dide4cJ6qojWACVgkCIV7dmpc1/dyCOaY
         sOYUtPtiNfZyMwMHw9LNBxY4rr/dqB1FnAv1PR1ofBby2p/EnFirJxIcz3gyzDyaptzj
         wH5izWHCFJqgqLV1Iq2CVDJkLJCunfYYU6nWzTX4YNJxFg5hbTVgapZu82YrwOADjFp0
         LVqynl0dlIhjYkeqcPcsJV3WRAZFueIjn6xH8QrNzFRDMY9NHdNO105aApZSCJdAYsrZ
         wxAwydFdp14wTDO7g+YXzb0tmZMHOsXop+j7rieE9OCgwtMwzQ1lBMJSq0deh21MdURr
         zlZQ==
X-Gm-Message-State: AOJu0YxhHOJG/e/hjMEfjSvEc5A2My3tVLoW4QlJ6J6tL2+CeoFLVc6j
	i8wSliR86G64eGJxMiz9+JnBphbEQawntQ917iQ=
X-Google-Smtp-Source: AGHT+IGGT603rGonIekkwZxglWbdWqNZjFm5mnAk5XSc6weOCIoLUqdBuPZMIJK2zh9zbW8Ll5dkNojEqyeByjJyLLw=
X-Received: by 2002:a05:6a20:7292:b0:14d:f41c:435a with SMTP id
 o18-20020a056a20729200b0014df41c435amr29980371pzk.39.1697169464600; Thu, 12
 Oct 2023 20:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008212251.236023-1-jolsa@kernel.org> <20231008212251.236023-2-jolsa@kernel.org>
In-Reply-To: <20231008212251.236023-2-jolsa@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 12 Oct 2023 20:57:33 -0700
Message-ID: <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] tools/build: Fix -s detection code in tools/build/Makefile.build
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Dmitry Goncharov <dgoncharov@users.sf.net>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Ian Rogers <irogers@google.com>, 
	KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jiri,

On Sun, Oct 8, 2023 at 2:23=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> As Dmitry described in [1] changelog the current way of detecting
> -s option is broken for new make.

I'm not sure what -s option does for perf (at least).
It doesn't seem much different whether I give it or not.
Am I missing something?

Thanks,
Namhyung

>
> Changing the tools/build -s option detection the same way as it was
> fixed for root Makefile in [1].
>
> [1] 4bf73588165b ("kbuild: Port silent mode detection to future gnu make.=
")
>
> Cc: Dmitry Goncharov <dgoncharov@users.sf.net>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/build/Makefile.build | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index fac42486a8cf..5fb3fb3d97e0 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -20,7 +20,15 @@ else
>    Q=3D@
>  endif
>
> -ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
> +# If the user is running make -s (silent mode), suppress echoing of comm=
ands
> +# make-4.0 (and later) keep single letter options in the 1st word of MAK=
EFLAGS.
> +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> +short-opts :=3D $(firstword -$(MAKEFLAGS))
> +else
> +short-opts :=3D $(filter-out --%,$(MAKEFLAGS))
> +endif
> +
> +ifneq ($(findstring s,$(short-opts)),)
>    quiet=3Dsilent_
>  endif
>
> --
> 2.41.0
>

