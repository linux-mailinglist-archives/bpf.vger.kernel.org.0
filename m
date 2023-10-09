Return-Path: <bpf+bounces-11679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861D7BD360
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 08:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0B51C20ACA
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E58C1F;
	Mon,  9 Oct 2023 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C922BE49;
	Mon,  9 Oct 2023 06:31:14 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF98A4;
	Sun,  8 Oct 2023 23:31:12 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3376430a12.3;
        Sun, 08 Oct 2023 23:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833072; x=1697437872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD0Fv9cM67zX2LwKdhCrzGLuQATLW6HXC5O4/Nd4nTE=;
        b=XQx9nJdNInB7FMmd3ZJTpmO4FS24dWqb1hmTV34meNbtFJzWEWbYnEPI4nCnz5MGug
         h8JeDO/etFa9bWZt7S70L9lC8il0yulMAgzIEF6fprs7MJpcrkzIJPbagJ81F+d+pqw6
         9/8znFo5jqUqbb5h2a99ige5sucIMWMfRl/WrbwQQngNn6tvlDdHX+G1J525e+6kD7Ef
         oS2sYP5qfHxC9Ut/rXsFkHsK/SFz4omAMk9FZBndx17pijibbI0emY9RXlPG7PJ9gfYV
         4eo4pFhgi3IHhqtYrjyB5UU2yAaaoTAwaL0DwvDxiT5NpViiI3X8wOt3NjijZ9VBH851
         Qd3Q==
X-Gm-Message-State: AOJu0YyGTJJBPrjacvj0F4QVe8W2wA9LGSf3rWYsQYKT2sQS/E/hQdrj
	KHbjHi3+UHISKo83F9O1IFaEwI9O+waVvOMbHN/V3occ
X-Google-Smtp-Source: AGHT+IEOQspT2cmBHQKFmpyVLLR+19S0QFb8macQedL/e+/KbEJLcVDbtXZ0lZH43XNvVA3aOx01YcU7aI64n/+lMyk=
X-Received: by 2002:a17:90b:11cc:b0:277:6d6a:33ba with SMTP id
 gv12-20020a17090b11cc00b002776d6a33bamr14075416pjb.28.1696833072180; Sun, 08
 Oct 2023 23:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-14-irogers@google.com>
In-Reply-To: <20231005230851.3666908-14-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 23:31:01 -0700
Message-ID: <CAM9d7cj-ANu1j-6WxGDQ_+pJtDt1xfyuGCNyC_dTpCDECZZgCQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] perf svghelper: Avoid memory leak
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
> On success path the sib_core and sib_thr values weren't being
> freed. Detected by clang-tidy.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-lock.c   | 1 +
>  tools/perf/util/svghelper.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index d4b22313e5fc..1b40b00c9563 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2463,6 +2463,7 @@ static int parse_call_stack(const struct option *op=
t __maybe_unused, const char
>                 entry =3D malloc(sizeof(*entry) + strlen(tok) + 1);
>                 if (entry =3D=3D NULL) {
>                         pr_err("Memory allocation failure\n");
> +                       free(s);
>                         return -1;
>                 }
>

This is unrelated.  Please put it in a separate patch.

Thanks,
Namhyung


> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index 0e4dc31c6c9c..1892e9b6aa7f 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
>         int i, nr_cpus;
>         struct topology t;
>         char *sib_core, *sib_thr;
> +       int ret =3D -1;
>
>         nr_cpus =3D min(env->nr_cpus_online, MAX_NR_CPUS);
>
> @@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
>
>         scan_core_topology(topology_map, &t, nr_cpus);
>
> -       return 0;
> +       ret =3D 0;
>
>  exit:
>         zfree(&t.sib_core);
>         zfree(&t.sib_thr);
>
> -       return -1;
> +       return ret;
>  }
> --
> 2.42.0.609.gbb76f46606-goog
>

