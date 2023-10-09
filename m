Return-Path: <bpf+bounces-11678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA67BD348
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 08:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B854281498
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0EBA4B;
	Mon,  9 Oct 2023 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C822BA34;
	Mon,  9 Oct 2023 06:21:17 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5EA4;
	Sun,  8 Oct 2023 23:21:15 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3371180a12.1;
        Sun, 08 Oct 2023 23:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696832475; x=1697437275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqzxkQ2kaFA3LhoAZmBsNaaLHYDoJFZNDM8wtB/redY=;
        b=vOtJOzfmgoDQpbLLBWDLVmcr+uVZVAYeptrHPew9/FJdw6mGM10Q8V+Fv0GYUWdoWh
         SGUXaY9j6wTvMpyxDDuDiLzbdRds2A0dYQ20WAJc5IvM5uT8gl4pFDaGSJ+P6uy3BwIW
         n7aRTj5sJ3o3gw6BSC/bX2LZoeDQkvEWMwOtwlWX/iPKST9kCnhoxju+Vt+kNTyRkSDa
         bqZShR+uStwo/lGEOQOeLb80P7/P0lQqFByM9mRf09VWrBwb76y43Ytrf59cwBk2oaan
         9gWfEtSOJg9E0M9N3ptLQ/LyKRQrkYfIoZkOskdYp9dZNiKSd/DaCltxtOYJB3w+DHQu
         zmyA==
X-Gm-Message-State: AOJu0Yw17SS7LhOIPpI/OTTs6NkagiLhPvJg4AvwO8pgt/VMF47LwkmB
	CKs/9yTifBjQdNkg0dWNHi3DU5F259xScnH7XxE=
X-Google-Smtp-Source: AGHT+IHipStQxQb3cJsEmsKyjG2x73hMhk0WqgsHINOilfTS5PE0o/18YQpFkwA82j4XWhtNLoMGqq0ExLQXvPsOs/w=
X-Received: by 2002:a05:6a21:7881:b0:15e:a653:fed5 with SMTP id
 bf1-20020a056a21788100b0015ea653fed5mr18979636pzc.16.1696832475036; Sun, 08
 Oct 2023 23:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-11-irogers@google.com>
In-Reply-To: <20231005230851.3666908-11-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 23:21:03 -0700
Message-ID: <CAM9d7cj3AuAo-+ncd6nULusvgw1NUhBdSAED9vf_eDQ7Z=cEPQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] perf dlfilter: Be defensive against potential
 NULL dereference
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
> In the unlikely case of having a symbol without a mapping, avoid a
> NULL dereference that clang-tidy warns about.

I'm not sure if it's possible to have a symbol without a map,
but I'm also fine with being conservative.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dlfilter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 1dbf27822ee2..5e54832137a9 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -52,8 +52,10 @@ static void al_to_d_al(struct addr_location *al, struc=
t perf_dlfilter_al *d_al)
>                 d_al->sym_end =3D sym->end;
>                 if (al->addr < sym->end)
>                         d_al->symoff =3D al->addr - sym->start;
> -               else
> +               else if (al->map)
>                         d_al->symoff =3D al->addr - map__start(al->map) -=
 sym->start;
> +               else
> +                       d_al->symoff =3D 0;
>                 d_al->sym_binding =3D sym->binding;
>         } else {
>                 d_al->sym =3D NULL;
> --
> 2.42.0.609.gbb76f46606-goog
>

