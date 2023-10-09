Return-Path: <bpf+bounces-11735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909D77BE673
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909B01C20C28
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A07BE49;
	Mon,  9 Oct 2023 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYHqckFZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4E1A702
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:33:47 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560C9C
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:33:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50348c54439so7213e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696869224; x=1697474024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgAUhHJmbAWVKMj/qj7uBpSpsL5yIQNcIBFI1M3KUrE=;
        b=UYHqckFZjMRtNKJc9ZHT+a9mD9KooKG2TR+i3KjqXu6ent+qp2MQFs2toi5zQigWMz
         z+ENkt0r0w4pbxkUyZdzSR09ESntGcyYuM1y1aoI3rg0nZgQO0MWX8mHPMp3yuhzPIUX
         tzGxXgP4cXYLgiq2H1unVbupMm84Ih3cLBKjo7tvKyVZ+2xyj1SyIe+cFgHQ6i7/x6jK
         zsT+cXdifKsTAS3hssZJ6YWzjdGaZKx2vAfeTsMJPWWquWOiWMVK1OpI+iSf971SZz6d
         G3+JiH0YTxmmCWfwZbPosjpia6PeOgry6R6PkqYKn74KXKm4fw5siJGdpwPpRDaIwqgW
         gEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869224; x=1697474024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgAUhHJmbAWVKMj/qj7uBpSpsL5yIQNcIBFI1M3KUrE=;
        b=MZcBgo8McLeLHDtgMfp0ngbiOBtBgTsdFp+qIWyjDsZvGPoK1ChIe8PZ5E4o2tlYrQ
         GwdOw3atzbretzcwJ6P2O+gF+aNWpOd+0e9H1BkqM8uVjAATRXkjRR/K5/U2T2aPA96P
         Ua4yquncAivynb0nR1401Cz5VVr1JQDb0yqmRN5BLb1S0N6vCiwjRjm9OG9QzlbTWJDG
         HHT5UMoXtN/isUkB+wNVqQVbJBcwX9wD8mui4cxTCqkCJXBdTN91OWz42x9eDBWmgtPs
         1e4FLUhJ0o9c+hvjow+SiqimSGwS6nltQ5em5/sT6+HJlF5haa82ninU8VxoatjUP4qJ
         gydA==
X-Gm-Message-State: AOJu0Yyp85Qb72bHsyN32B3Vky4esRkTkGoiXFlhhM2IcUgJM/pXT+FL
	73f4NmEnQ4eaKnDr0tfpQI0Fm0fSx4FHZjTlCnTXzQ==
X-Google-Smtp-Source: AGHT+IGXiscr4EwxJpJQCI+XewTXiBNpPjwzDfqPDNFwxJs+1vHuH0y0A/ysZtYnjJFzd+aiIxPaVy3GoJQMOtBy2aw=
X-Received: by 2002:ac2:44db:0:b0:505:7c88:9e45 with SMTP id
 d27-20020ac244db000000b005057c889e45mr230791lfm.0.1696869223703; Mon, 09 Oct
 2023 09:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-8-irogers@google.com>
 <CAM9d7cjcJKjUnpYEjGap=d1fuukpsDyWCOk2_UKrepXmagceZA@mail.gmail.com>
In-Reply-To: <CAM9d7cjcJKjUnpYEjGap=d1fuukpsDyWCOk2_UKrepXmagceZA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 09:33:32 -0700
Message-ID: <CAP-5=fX1f022Z052mOxgJODg_jOPCqHScjZam2_3YwUXqriO4A@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] perf env: Remove unnecessary NULL tests
To: Namhyung Kim <namhyung@kernel.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 11:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > clang-tidy was warning:
> > ```
> > util/env.c:334:23: warning: Access to field 'nr_pmu_mappings' results i=
n a dereference of a null pointer (loaded from variable 'env') [clang-analy=
zer-core.NullDereference]
> >         env->nr_pmu_mappings =3D pmu_num;
> > ```
> >
> > As functions are called potentially when !env was true. This condition
> > could never be true as it would produce a segv, so remove the
> > unnecessary NULL tests and silence clang-tidy.
>
> IIRC !env was to handle live sessions like perf top
> or when it doesn't have a perf data file.  Anyway,
> it doesn't seem to work anymore.

I trust the analyzer here and it would be better to crash earlier,
from env being NULL, than in a particular conditional branch. Like
you, I wasn't able to find a failure from removing the checks.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/env.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index a164164001fb..44140b7f596a 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -457,7 +457,7 @@ const char *perf_env__cpuid(struct perf_env *env)
> >  {
> >         int status;
> >
> > -       if (!env || !env->cpuid) { /* Assume local operation */
> > +       if (!env->cpuid) { /* Assume local operation */
> >                 status =3D perf_env__read_cpuid(env);
> >                 if (status)
> >                         return NULL;
> > @@ -470,7 +470,7 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
> >  {
> >         int status;
> >
> > -       if (!env || !env->nr_pmu_mappings) { /* Assume local operation =
*/
> > +       if (!env->nr_pmu_mappings) { /* Assume local operation */
> >                 status =3D perf_env__read_pmu_mappings(env);
> >                 if (status)
> >                         return 0;
> > @@ -483,7 +483,7 @@ const char *perf_env__pmu_mappings(struct perf_env =
*env)
> >  {
> >         int status;
> >
> > -       if (!env || !env->pmu_mappings) { /* Assume local operation */
> > +       if (!env->pmu_mappings) { /* Assume local operation */
> >                 status =3D perf_env__read_pmu_mappings(env);
> >                 if (status)
> >                         return NULL;
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

