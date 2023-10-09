Return-Path: <bpf+bounces-11677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3778E7BD330
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F561C20AA0
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925DCBA2F;
	Mon,  9 Oct 2023 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC31BA27;
	Mon,  9 Oct 2023 06:14:26 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E5AB;
	Sun,  8 Oct 2023 23:14:24 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-564b6276941so3077806a12.3;
        Sun, 08 Oct 2023 23:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696832064; x=1697436864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdIseKxNnHvoiSCvYwI9x5coaaanSCFVs/MmGIY9e1w=;
        b=lvQSOQiSj9rnlxCAV5czHruPESj3EYcQj6gnGu8Tlf8QdeQxJ5K1/XjIcx+Tsruar6
         zP/Wtztp+sGpHWaxKEapqgVlCqE7zu37ormgDc5GvO/iJp4Prw/Kxwn3SGSkhpMzqN+x
         xVIB76tKZzWtSDb4g68OED8HHM1AXitZVq6/GnFZm+iS6zSBFNF71Wl6O3hehLyRLLkI
         tHy/r/tgxprHiytccSdjzoUp363X5AqqM7VvFSiZKiCm7PlFVEFkcJiKl3bfeUWx4SAp
         i7NcnrzKf5bTtXAODgFDqY/SaqRxZMrUwwh+RcB65kzEf97q9fvAz3gGf1pIOIP1lJZK
         e1OQ==
X-Gm-Message-State: AOJu0Yylyk3A4UQxncVabzefbGh7RJIFgeT7LpwBhe/VdIzuIH+cZTh7
	nyOEohdoLdzEeD2vDvLlyl7Sav13afVry/QxXUk=
X-Google-Smtp-Source: AGHT+IG4YN77+NfgnWMQwnUP7ZlWmW1mV8JEtpbsLHd3pE4zN7HoIS4XpJ0oM784HlquonmeWmhm3TnsWBlJv6a4TGo=
X-Received: by 2002:a17:90b:38cd:b0:26d:2bac:a0bb with SMTP id
 nn13-20020a17090b38cd00b0026d2baca0bbmr13387049pjb.6.1696832063882; Sun, 08
 Oct 2023 23:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-8-irogers@google.com>
In-Reply-To: <20231005230851.3666908-8-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 23:14:12 -0700
Message-ID: <CAM9d7cjcJKjUnpYEjGap=d1fuukpsDyWCOk2_UKrepXmagceZA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] perf env: Remove unnecessary NULL tests
To: Ian Rogers <irogers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> clang-tidy was warning:
> ```
> util/env.c:334:23: warning: Access to field 'nr_pmu_mappings' results in =
a dereference of a null pointer (loaded from variable 'env') [clang-analyze=
r-core.NullDereference]
>         env->nr_pmu_mappings =3D pmu_num;
> ```
>
> As functions are called potentially when !env was true. This condition
> could never be true as it would produce a segv, so remove the
> unnecessary NULL tests and silence clang-tidy.

IIRC !env was to handle live sessions like perf top
or when it doesn't have a perf data file.  Anyway,
it doesn't seem to work anymore.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/env.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index a164164001fb..44140b7f596a 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -457,7 +457,7 @@ const char *perf_env__cpuid(struct perf_env *env)
>  {
>         int status;
>
> -       if (!env || !env->cpuid) { /* Assume local operation */
> +       if (!env->cpuid) { /* Assume local operation */
>                 status =3D perf_env__read_cpuid(env);
>                 if (status)
>                         return NULL;
> @@ -470,7 +470,7 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
>  {
>         int status;
>
> -       if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
> +       if (!env->nr_pmu_mappings) { /* Assume local operation */
>                 status =3D perf_env__read_pmu_mappings(env);
>                 if (status)
>                         return 0;
> @@ -483,7 +483,7 @@ const char *perf_env__pmu_mappings(struct perf_env *e=
nv)
>  {
>         int status;
>
> -       if (!env || !env->pmu_mappings) { /* Assume local operation */
> +       if (!env->pmu_mappings) { /* Assume local operation */
>                 status =3D perf_env__read_pmu_mappings(env);
>                 if (status)
>                         return NULL;
> --
> 2.42.0.609.gbb76f46606-goog
>

