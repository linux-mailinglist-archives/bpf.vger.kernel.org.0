Return-Path: <bpf+bounces-2514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4172E683
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE0E1C20CAC
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63F39240;
	Tue, 13 Jun 2023 15:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5323DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:01:58 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2EE56;
	Tue, 13 Jun 2023 08:01:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62df5fbb186so5968796d6.1;
        Tue, 13 Jun 2023 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686668516; x=1689260516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwvbZEDaH9pOLGuaz61biqmcghw88BrYNNMc8V4F+10=;
        b=EkPhiuOnM29E61X/mDt7mvpqFyjv8OTAQCD49imcS8x0L4wd9aAZy7ZmuwVaWx9qXN
         LV7HYn/ybH9FseKHqUjii4w8bxEGblZSGYXFBhTlVm6EQRL+qgblFzxNmN4hAYuOwSjy
         j959qFvQ8uPmAtbZ4Sq6DfA83nZ+MboI7cKs5oge0YD0Q+n+G4oviNy+7bSFwn14GBWt
         JnBdMp+NO0W2yZeJu+JAVRKKKx+qghp392g3JEAGPH1g4YnTuMcN3PTEkTdGMIqcimGc
         Vsz5sWn6JwlDKGemYhHK3bos/5HSBRPh0hy5YGHSAii2vvlWbdaVCtv9L5zp6Ikhyd98
         /nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668516; x=1689260516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwvbZEDaH9pOLGuaz61biqmcghw88BrYNNMc8V4F+10=;
        b=H2SOoAsH4T+EJQtT1jUrxk5nHGFQxIzq5+7LtOmwVBp8AKvNCK8r3NMIto7kYRjit1
         TFfUq4mwGTDf1jFsDG1wse1fyukYKzR5cbWgnaN5hcAWGNyWul4rsdJT6drBo5nNoWsb
         AMnBRZiOue7lzTSJDdEpkHgmFAiDyAiqFxlkTpNoiXzebidP76PdYJbvLOsdTKzU0aBn
         ruRhhm1hPvmiHd7BvV2EC6AW33/e5p1PPAFk92KrYKq/EkGpw363vhRmazj15EokJtOm
         OpqlbosqFFg/RxBoyV75dQzhowX1qYZkJzbBNKGhljBWWvqPfe1mJoCV0xG81jThjdVs
         tr3Q==
X-Gm-Message-State: AC+VfDxbY5NgtzZgZqQ5XZ4bmD+eqx6BsvY+oRRzbgMlLN+HY30HH7Oj
	ZEMioAgPynDdxlm70LV7J9hESuaNLYs/EC43qhQ8MPXWF9nsCQ==
X-Google-Smtp-Source: ACHHUZ6ZaR+92bdmYTSeZifmUkLg1g3EhxRAyO2OPNqDu3vQiagPB/fFTX2QLPtTH8qqUm51TazkHoA0SvUVxVvtclc=
X-Received: by 2002:a05:6214:623:b0:5ef:59d1:8d14 with SMTP id
 a3-20020a056214062300b005ef59d18d14mr15098488qvx.2.1686668516457; Tue, 13 Jun
 2023 08:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-10-laoar.shao@gmail.com>
 <1cd688c3-f633-8ae7-97bb-8e899545118e@isovalent.com>
In-Reply-To: <1cd688c3-f633-8ae7-97bb-8e899545118e@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Jun 2023 23:01:17 +0800
Message-ID: <CALOAHbAnXi5gRnxHH4-G+T6fVhRm=gsYR6_u0d5GRY8zFftwSg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/10] bpftool: Add perf event names
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 9:42=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > Add new functions and macros to get perf event names. These names are
> > copied from tool/perf/util/{parse-events,evsel}.c, so that in the futur=
e we
> > will have a good chance to use the same code.
> >
> > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/perf.c | 107 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  tools/bpf/bpftool/perf.h |  11 +++++
>
> Although the names are deceiving, I think these should all be moved to
> link.c and link.h, where we'll actually use them, or to some other file
> with a new name. File perf.c is for implementing "bpftool perf ...".

Got it. Will move them into link.c.

>
> >  2 files changed, 118 insertions(+)
> >  create mode 100644 tools/bpf/bpftool/perf.h
> >
> > diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
> > index 9174344..fbdf88c 100644
> > --- a/tools/bpf/bpftool/perf.c
> > +++ b/tools/bpf/bpftool/perf.c
> > @@ -18,6 +18,113 @@
> >  #include <bpf/bpf.h>
> >
> >  #include "main.h"
> > +#include "perf.h"
> > +
> > +static const char *perf_type_name[PERF_TYPE_MAX] =3D {
> > +     [PERF_TYPE_HARDWARE]                    =3D "hardware",
> > +     [PERF_TYPE_SOFTWARE]                    =3D "software",
> > +     [PERF_TYPE_TRACEPOINT]                  =3D "tracepoint",
> > +     [PERF_TYPE_HW_CACHE]                    =3D "hw-cache",
> > +     [PERF_TYPE_RAW]                         =3D "raw",
> > +     [PERF_TYPE_BREAKPOINT]                  =3D "breakpoint",
> > +};
> > +
> > +const char *event_symbols_hw[PERF_COUNT_HW_MAX] =3D {
> > +     [PERF_COUNT_HW_CPU_CYCLES]              =3D "cpu-cycles",
> > +     [PERF_COUNT_HW_INSTRUCTIONS]            =3D "instructions",
> > +     [PERF_COUNT_HW_CACHE_REFERENCES]        =3D "cache-references",
> > +     [PERF_COUNT_HW_CACHE_MISSES]            =3D "cache-misses",
> > +     [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D "branch-instructions"=
,
> > +     [PERF_COUNT_HW_BRANCH_MISSES]           =3D "branch-misses",
> > +     [PERF_COUNT_HW_BUS_CYCLES]              =3D "bus-cycles",
> > +     [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D "stalled-cycles-front=
end",
> > +     [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  =3D "stalled-cycles-backe=
nd",
> > +     [PERF_COUNT_HW_REF_CPU_CYCLES]          =3D "ref-cycles",
> > +};
> > +
> > +const char *event_symbols_sw[PERF_COUNT_SW_MAX] =3D {
> > +     [PERF_COUNT_SW_CPU_CLOCK]               =3D "cpu-clock",
> > +     [PERF_COUNT_SW_TASK_CLOCK]              =3D "task-clock",
> > +     [PERF_COUNT_SW_PAGE_FAULTS]             =3D "page-faults",
> > +     [PERF_COUNT_SW_CONTEXT_SWITCHES]        =3D "context-switches",
> > +     [PERF_COUNT_SW_CPU_MIGRATIONS]          =3D "cpu-migrations",
> > +     [PERF_COUNT_SW_PAGE_FAULTS_MIN]         =3D "minor-faults",
> > +     [PERF_COUNT_SW_PAGE_FAULTS_MAJ]         =3D "major-faults",
> > +     [PERF_COUNT_SW_ALIGNMENT_FAULTS]        =3D "alignment-faults",
> > +     [PERF_COUNT_SW_EMULATION_FAULTS]        =3D "emulation-faults",
> > +     [PERF_COUNT_SW_DUMMY]                   =3D "dummy",
> > +     [PERF_COUNT_SW_BPF_OUTPUT]              =3D "bpf-output",
> > +     [PERF_COUNT_SW_CGROUP_SWITCHES]         =3D "cgroup-switches",
> > +};
> > +
> > +const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX] =3D {
> > +     [PERF_COUNT_HW_CACHE_L1D]               =3D "L1-dcache",
> > +     [PERF_COUNT_HW_CACHE_L1I]               =3D "L1-icache",
> > +     [PERF_COUNT_HW_CACHE_LL]                =3D "LLC",
> > +     [PERF_COUNT_HW_CACHE_DTLB]              =3D "dTLB",
> > +     [PERF_COUNT_HW_CACHE_ITLB]              =3D "iTLB",
> > +     [PERF_COUNT_HW_CACHE_BPU]               =3D "branch",
> > +     [PERF_COUNT_HW_CACHE_NODE]              =3D "node",
> > +};
> > +
> > +const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX] =3D {
> > +     [PERF_COUNT_HW_CACHE_OP_READ]           =3D "load",
> > +     [PERF_COUNT_HW_CACHE_OP_WRITE]          =3D "store",
> > +     [PERF_COUNT_HW_CACHE_OP_PREFETCH]       =3D "prefetch",
> > +};
> > +
> > +const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D=
 {
> > +     [PERF_COUNT_HW_CACHE_RESULT_ACCESS]     =3D "refs",
> > +     [PERF_COUNT_HW_CACHE_RESULT_MISS]       =3D "misses",
> > +};
> > +
> > +const char *perf_type_str(enum perf_type_id t)
> > +{
> > +     if (t < 0 || t >=3D ARRAY_SIZE(perf_type_name))
> > +             return NULL;
> > +
> > +     return perf_type_name[t];
> > +}
> > +
> > +const char *perf_hw_str(enum perf_hw_id t)
> > +{
> > +     if (t < 0 || t >=3D ARRAY_SIZE(event_symbols_hw))
> > +             return NULL;
> > +
> > +     return event_symbols_hw[t];
> > +}
> > +
> > +const char *perf_hw_cache_str(enum perf_hw_cache_id t)
> > +{
> > +     if (t < 0 || t >=3D ARRAY_SIZE(evsel__hw_cache))
> > +             return NULL;
> > +
> > +     return evsel__hw_cache[t];
> > +}
> > +
> > +const char *perf_hw_cache_op_str(enum perf_hw_cache_op_id t)
> > +{
> > +     if (t < 0 || t >=3D ARRAY_SIZE(evsel__hw_cache_op))
> > +             return NULL;
> > +
> > +     return evsel__hw_cache_op[t];
> > +}
> > +
> > +const char *perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_i=
d t)
> > +{
> > +     if (t < 0 || t >=3D ARRAY_SIZE(evsel__hw_cache_result))
> > +             return NULL;
> > +
> > +     return evsel__hw_cache_result[t];
> > +}
> > +
> > +const char *perf_sw_str(enum perf_sw_ids t)
> > +{
> > +     if (t < 0 || t >=3D ARRAY_SIZE(event_symbols_sw))
> > +             return NULL;
> > +
> > +     return event_symbols_sw[t];
> > +}
> >
> >  /* 0: undecided, 1: supported, 2: not supported */
> >  static int perf_query_supported;
> > diff --git a/tools/bpf/bpftool/perf.h b/tools/bpf/bpftool/perf.h
> > new file mode 100644
> > index 0000000..3fd7e42
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/perf.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#include <linux/perf_event.h>
> > +
> > +const char *perf_type_str(enum perf_type_id t);
> > +const char *perf_hw_str(enum perf_hw_id t);
> > +const char *perf_hw_cache_str(enum perf_hw_cache_id t);
> > +const char *perf_hw_cache_op_str(enum perf_hw_cache_op_id t);
> > +const char *perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_i=
d t);
> > +const char *perf_sw_str(enum perf_sw_ids t);
>
> I'm not sure we need all these API functions if we keep the arrays in
> bpftool. I'd probably have just a generic one and pass it the name of
> the relevant array in argument. Although I've got no objection with the
> current form if it helps unifying the code with perf in the future.
>

Sure, I will use a generic one instead.

--=20
Regards
Yafang

