Return-Path: <bpf+bounces-9341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291F7941A2
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA52281498
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE910955;
	Wed,  6 Sep 2023 16:43:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC71079A
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 16:43:15 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537A1997;
	Wed,  6 Sep 2023 09:43:11 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-792726d3aeeso166957139f.0;
        Wed, 06 Sep 2023 09:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694018591; x=1694623391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fdur3Nxp4iSAbsNGs5pw1u0030rGBz45vpHxbt7j4e4=;
        b=OgOTXeYS/VG52N6PjgrFTm4GkuJc0gabPiRj8bml/povWOdD18QrV0NXCGJ9ZBHJRd
         1CcPgasuP9xqzeuAr+2xJZpf2n+VLTs8Ph0hvi8CKqJe+OoyTy9IRIVXwp/i6r4+TrgP
         k3WG59kMm2NkvR0cGtMl26WdqvGcj51B0agb7nNQM3y26Nc+geJRtb038f9lWUTb2zZb
         ntctYqK/ZL3+MAfU2NlsQGmStFGImxQjDiBFo6tajprSr632JPnzAI9Y0YoCA3VoEupA
         W5iFHVgDLZ8FoqUV/TDvmQJmmm3rwBV0+Lx4tN8a4BKz+hmfDx5lVgPjocp+969jfMxC
         5/dQ==
X-Gm-Message-State: AOJu0YwJ0Ci6pi7ldPQbWzhiIna62/LoOVMGGqs2eaSeZLsJrt2ygVJ4
	UK0UpUA4p8IXoVS2xWf5jyUGYrQzX9oY2iOOKB3UjVRM
X-Google-Smtp-Source: AGHT+IFhzDjwp3J8vlD5TE9XH+TAex8H9QyLYVERxjjZ52pDp1nEDotMOcRPrjS8YLqKgte3ag8nNlPxYqGg5QbHKV8=
X-Received: by 2002:a6b:6f11:0:b0:787:4f3c:730d with SMTP id
 k17-20020a6b6f11000000b007874f3c730dmr19442163ioc.18.1694018590698; Wed, 06
 Sep 2023 09:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830230126.260508-1-namhyung@kernel.org> <20230830230126.260508-2-namhyung@kernel.org>
 <ZPic6Fegc7PGSvmp@kernel.org> <ZPidlwe2yXEDZB+U@kernel.org>
In-Reply-To: <ZPidlwe2yXEDZB+U@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 6 Sep 2023 09:42:59 -0700
Message-ID: <CAM9d7citcFGPiupaJamb3ujdvZUjzuXkVQ_0iTJzpfEjsu71pw@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf tools: Add read_all_cgroups() and __cgroup_find()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arnaldo,

On Wed, Sep 6, 2023 at 8:41=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Sep 06, 2023 at 12:38:17PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Aug 30, 2023 at 04:01:22PM -0700, Namhyung Kim escreveu:
> > > The read_all_cgroups() is to build a tree of cgroups in the system an=
d
> > > users can look up a cgroup using __cgroup_find().
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m=3D'make -k BUILD_BPF_S=
KEL=3D1 CORESIGHT=3D1 O=3D/tmp/build/perf-tools-next -C tools/perf install-=
bin && git status && perf test python'
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> > make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf=
'
> >   BUILD:   Doing 'make -j32' parallel build
> > Warning: Kernel ABI header differences:
> >   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf=
_event.h
> >   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm=
/cpufeatures.h
> >   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/m=
sr-index.h
> >   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/incl=
ude/uapi/asm/perf_regs.h
> >
> >   INSTALL libsubcmd_headers
> >   INSTALL libperf_headers
> >   INSTALL libapi_headers
> >   INSTALL libsymbol_headers
> >   INSTALL libbpf_headers
> >   CC      /tmp/build/perf-tools-next/builtin-lock.o
> >   CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
> > builtin-lock.c: In function =E2=80=98__cmd_contention=E2=80=99:
> > builtin-lock.c:2162:9: error: too few arguments to function =E2=80=98lo=
ck_contention_finish=E2=80=99
> >  2162 |         lock_contention_finish();
> >       |         ^~~~~~~~~~~~~~~~~~~~~~
> > In file included from builtin-lock.c:14:
> > util/lock-contention.h:156:5: note: declared here
> >   156 | int lock_contention_finish(struct lock_contention *con);
> >       |     ^~~~~~~~~~~~~~~~~~~~~~
> > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.b=
uild:97: /tmp/build/perf-tools-next/builtin-lock.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > util/bpf_lock_contention.c: In function =E2=80=98lock_contention_get_na=
me=E2=80=99:
> > util/bpf_lock_contention.c:231:34: error: =E2=80=98struct contention_ke=
y=E2=80=99 has no member named =E2=80=98lock_addr_or_cgroup=E2=80=99
> >   231 |                 u64 cgrp_id =3D key->lock_addr_or_cgroup;
> >       |                                  ^~
> > make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.b=
uild:97: /tmp/build/perf-tools-next/util/bpf_lock_contention.o] Error 1
> > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.b=
uild:150: util] Error 2
> > make[2]: *** [Makefile.perf:662: /tmp/build/perf-tools-next/perf-in.o] =
Error 2
> > make[1]: *** [Makefile.perf:238: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > Trying to figure this out.
>
> So it works on the following patch:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -5
> 94a54d498ae35c66 (HEAD) perf lock contention: Add -g/--lock-cgroup option
> defe88978441a00d perf lock contention: Prepare to handle cgroups
> cc0717270d2f0daa perf cgroup: Add read_all_cgroups() and __cgroup_find()
> 752d73a1dd62cd4a perf shell completion: Support completion of metrics/met=
ricgroups
> 72aa5816258bf9fe perf completion: Support completion of libpfm4 events
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> Please check and submit a v2.

Thanks for the report, I'll fix it.

Thanks,
Namhyung

