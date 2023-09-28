Return-Path: <bpf+bounces-11016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C57B1159
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 05:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8689F281C34
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 03:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0AA79D8;
	Thu, 28 Sep 2023 03:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EF5397;
	Thu, 28 Sep 2023 03:56:05 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF88114;
	Wed, 27 Sep 2023 20:56:04 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso136392239f.3;
        Wed, 27 Sep 2023 20:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873364; x=1696478164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1awcH8GbI65VhOR4QezMpihuDaAOyYBPaOUcXT8DOQ=;
        b=PQcl133zvRgnxC12XUddAtEOnyfXcJFBjPxU/OglUJdBTC9JZ9uoJ5svtkvwja0WOs
         jV/Nf5BoQWZN1s2wvEUorffz/Byp6zbtZKlu6arLc1N8WsLTTPiMGiIchojvjg95lRqk
         oJtLb6Ti5KT9CtIpKRdjVaSgbFnt1Rt6HmbwsnwyCxXtfaasGyEQF7+ILQkTpLVNRORZ
         Z6M++lkwSmxWe4G63SU4RY0i3ay1WlLJdCfgCeOI0RFjP32E8P4JtU29FvkkMEPmDy6f
         ryOmGb5cxzRmx8JGrLcGdcGBXXR/ICrquiCxhee8f5lYkfX1UnvAirbk1L6PON82ZUSD
         GISQ==
X-Gm-Message-State: AOJu0YzuNTsmgRbcsT9drT+egVOWi1fKfow+UuzlzNQz66MJ7s2trxBQ
	Stk8pSybAwwmXZyRfl+00ahmCaKe2YHvBqGQ3WA=
X-Google-Smtp-Source: AGHT+IHago33rHQQtx98/NHeUgawaFXzjRnUzQ6yOTjvCloDy0RU925WzfS8lEsQf5BYR82jTxwhrUGYYhpO6Q6/1j8=
X-Received: by 2002:a05:6602:21d9:b0:780:c787:637b with SMTP id
 c25-20020a05660221d900b00780c787637bmr88139ioc.0.1695873363822; Wed, 27 Sep
 2023 20:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org> <CAPhsuW6mEWJcZdYbPbqt5ArBMznzQYwHBqTpKCcsB4B0o=PSGA@mail.gmail.com>
In-Reply-To: <CAPhsuW6mEWJcZdYbPbqt5ArBMznzQYwHBqTpKCcsB4B0o=PSGA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 Sep 2023 20:55:52 -0700
Message-ID: <CAM9d7cjUiet5kNxk=opNrhGgZ2QeqB6J5Tzok5GaEwtgiM-FEA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To: Song Liu <song@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 9:09=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Fri, Sep 22, 2023 at 4:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > The BTF func proto for a tracepoint has one more argument than the
> > actual tracepoint function since it has a context argument at the
> > begining.  So it should compare to 5 when the tracepoint has 4
> > arguments.
> >
> >   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_stru=
ct *, struct task_struct *, unsigned int);
> >
> > Also, recent change in the perf tool would use a hand-written minimal
> > vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> > of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> > check the type in the kernel.
> >
> > Fixes: b36888f71c85 ("perf record: Handle argument change in sched_swit=
ch")
> > Cc: Song Liu <song@kernel.org>
> > Cc: Hao Luo <haoluo@google.com>
> > CC: bpf@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Song Liu <song@kernel.org>

Applied to perf-tools-next, thanks!

