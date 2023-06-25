Return-Path: <bpf+bounces-3400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D673D17F
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A1C280FD4
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96805664;
	Sun, 25 Jun 2023 14:30:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FF20F4
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:30:51 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5344C9;
	Sun, 25 Jun 2023 07:30:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3fde9739e20so22285151cf.2;
        Sun, 25 Jun 2023 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703449; x=1690295449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeibCqUbvcmHuiSJN61eHglXHtJ9ELZv+P7LwghKaaY=;
        b=Wb1xR45KGqfHYc3De/viuKv4KI/6FEU+wRkdebkkJ+qFLwlUlnNU0es7K+Gj9lfgTE
         hQ9dt/OXDUhdybh6tI5RDvxiRGb8gvm2sCfjfzYS8Z8XCa9MHOs6xg4ZQUJy5Ojcwk5G
         fjQihpIVVzc3l1c7nSlknbiLVQTHqoOEg4PHF2GxpfHgqrS+p8vDFS8R7USsmKEnjDl6
         IievSIQDz71xQDndgPhcWWLExuDp3bEHZkUjEViyZE7COgQMwGUTdhoB8EzBaX6s5f2c
         Qca+FTz09BeasBg07CEMXNm8yX2QoMhFRfP3PnRywUfu+rmHvvWJaHqxDY9IOR+MAIn/
         pJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703449; x=1690295449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeibCqUbvcmHuiSJN61eHglXHtJ9ELZv+P7LwghKaaY=;
        b=NzYERmwtsk7e9UjGwIvzuFfD9Rqks29lHGRUv6jBHFof7J8T6i1nLE/NfYCiAw45ig
         veF8MrzWAP21WaykhnIP1v2bLQBl6xZDOap481wJyu3/5ITpWGGroiCB31yds/tpweam
         UqjJOv+ekMHAYp0TJ5f1ixWlhcShzkUIt9VGHznfwIIEPhsbqbLkqlrleG/jzfrxUBkG
         pM6o/6PszocHTbhwEwkuqzgniKoVnilDz/u0qSy0NwxqB+hP8IgVLoF6/BhHX7VWemNe
         QfD4uhLFwFawfiMjNDiPv7zkzeuICQhnYaMLt+eDHQYvCmXQhufWNm2EZfHnSiCqN+ML
         5ehA==
X-Gm-Message-State: AC+VfDzRqqQIt7o8VkbQMdjQZlQBApWG1LHAHDhgAB9y9mjcYsAEBgwZ
	Mq7OXoT37FIqNtgw2se9Sz5qyR6AYfrmgAaBksgHLWbQ
X-Google-Smtp-Source: ACHHUZ4/mDfJdRR/BoS8fMmLxZ8QUH2xqEDF+mU68mKH1UHzNdtV0MSnT/5yahcko5VZuXZG7VVMATK9sMuNkLMp5r8=
X-Received: by 2002:a05:6214:d0b:b0:625:aa49:19f1 with SMTP id
 11-20020a0562140d0b00b00625aa4919f1mr27779474qvh.62.1687703449072; Sun, 25
 Jun 2023 07:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-11-laoar.shao@gmail.com>
 <74aab2b3-db85-abde-5361-f638c272c096@isovalent.com>
In-Reply-To: <74aab2b3-db85-abde-5361-f638c272c096@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:30:13 +0800
Message-ID: <CALOAHbB19cmkTC8aEXSiq-cncZCnv0jRoJeBiq6kiEtnn+=62Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/11] bpftool: Add perf event names
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

On Sat, Jun 24, 2023 at 12:49=E2=80=AFAM Quentin Monnet <quentin@isovalent.=
com> wrote:
>
> 2023-06-23 14:15 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > Add new functions and macros to get perf event names. These names are
> > copied from tool/perf/util/{parse-events,evsel}.c, so that in the futur=
e we
> > will have a good chance to use the same code.
> >
> > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 8461e6d..e5aeee3 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/err.h>
> >  #include <linux/netfilter.h>
> >  #include <linux/netfilter_arp.h>
> > +#include <linux/perf_event.h>
> >  #include <net/if.h>
> >  #include <stdio.h>
> >  #include <unistd.h>
> > @@ -19,6 +20,72 @@
> >  static struct hashmap *link_table;
> >  static struct dump_data dd =3D {};
> >
> > +static const char *perf_type_name[PERF_TYPE_MAX] =3D {
> > +     [PERF_TYPE_HARDWARE]                    =3D "hardware",
> > +     [PERF_TYPE_SOFTWARE]                    =3D "software",
> > +     [PERF_TYPE_TRACEPOINT]                  =3D "tracepoint",
> > +     [PERF_TYPE_HW_CACHE]                    =3D "hw-cache",
> > +     [PERF_TYPE_RAW]                         =3D "raw",
> > +     [PERF_TYPE_BREAKPOINT]                  =3D "breakpoint",
> > +};
>
> These ones (above) are not defined in perf, are they?

Right. Will add an explanation in the commit log in the next version.

>
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
> > +#define perf_event_name(array, id) ({                        \
> > +     const char *event_str =3D NULL;                   \
> > +                                                     \
> > +     if ((id) >=3D 0 && (id) < ARRAY_SIZE(array))      \
> > +             event_str =3D array[id];                  \
> > +     event_str;                                      \
> > +})
> > +
> >  static int link_parse_fd(int *argc, char ***argv)
> >  {
> >       int fd;
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>



--=20
Regards
Yafang

