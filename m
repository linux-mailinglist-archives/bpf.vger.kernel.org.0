Return-Path: <bpf+bounces-56-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D8B6F79A9
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 01:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ABC1C2162B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EB5D537;
	Thu,  4 May 2023 23:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB476C142
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:15:13 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21783124B0;
	Thu,  4 May 2023 16:15:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64395e2a715so986313b3a.3;
        Thu, 04 May 2023 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683242111; x=1685834111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjP0EmNlXO6ALrWkFxsQZrdnE8TeyGcuWOdh12wVBRc=;
        b=KG0gxaVldcn1eGhfOHLP4fc8ptS5aAPZ7MH/i+5QDbkNoS8KOPwwuYzvNCUgXJPxRH
         wv+V6LmYR4UjlKOoJf1441qe4ijpUiO6Mtwnhiv4FprGSinRTW7paIyNxxTeRGqWHpWZ
         ppvxkGuy3qWRLyc+wjkG4rW/609cax53AFuwAvqIuktNl+B8CWomfioykN3B8oDaLIXW
         lYdXyWn1KAzSijHTpPZC2ZFR0mz1p29fqQREVEH8MFkyLz27yYB2vrJtRUutLB+u998A
         zJvH0TFhB9T8f8qDmuDvVqcSXqjgQKiT5e22m4CeELQK0mWEDNp+83q3kynAZiIhhR+g
         Cz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683242111; x=1685834111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjP0EmNlXO6ALrWkFxsQZrdnE8TeyGcuWOdh12wVBRc=;
        b=d8FNGWNNUa8j+CT8sJl+f7HYP0g6h53V06VqMgpITGEahkEb+2K5R5/uJ6Mc1o3KQT
         L/S5c1XnP/Q4Um+u3Lq8IofLpbmm090qLBfqwEFmWqZRkcvZsbheNZMNsvKYslR0fcwn
         EewmcPSIiUw8neErQGY1cikF9l7yqlCorH6RTGmc/cT5fsrBz1QX2ocQ3c0ilkLxC38a
         D97Yj+8OtJsLPQgoHYmmTZG7rGRytZw5dYL3BqgR/LtaQAA/9vwf0BOHydZmDHz+0Ehw
         OTe0msntHwxmSra9x+gutLbxY4qzYrrGQdzqORXUxcKyEFnT8l28VfukrmHZw9BzFbWP
         YjAA==
X-Gm-Message-State: AC+VfDwP5nrekW04vkKq+MLAF8jqpypwaPxUJMj5ieYifwiyy6Cj9Iuz
	Gu+H++GyB2BEj3+1JS5N6UI=
X-Google-Smtp-Source: ACHHUZ7DihwGaN86FeEfouGMWdMzl9aVDvS5PocKNQNlXPfTQC1aTtJXWl+vW5k1+EbZlUoOoF6ovQ==
X-Received: by 2002:a05:6a00:2443:b0:643:aa2:4dcd with SMTP id d3-20020a056a00244300b006430aa24dcdmr4691186pfj.16.1683242111305;
        Thu, 04 May 2023 16:15:11 -0700 (PDT)
Received: from google.com ([2620:15c:2d4:203:cf29:c3f3:b6aa:dcb5])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b0063f9de332f8sm184642pfm.167.2023.05.04.16.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 16:15:10 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date: Thu, 4 May 2023 16:15:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFQ8fB3yfIFimwhD@google.com>
References: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQ5sjjtfEYzvHNP@krava>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jiri,

On Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa wrote:
> On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> > On Thu, May 4, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > > > instead of using kernel headers?
> > > >
> > > > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > > > programs, it's more a convenience allowing easy access to definitions
> > > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > > > dependency on up-to-date host kernel and such.
> > > >
> > > > > If vmlinux.h generation and usage is causing issues, though, given
> > > > > that perf's BPF programs don't seem to be using many different kernel
> > > > > types, it might be a better option to just use UAPI headers for public
> > > > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > > > definitions locally in perf's BPF code for the other types necessary.
> > > > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > > > suffice:
> > > >
> > > > > struct task_struct {
> > > > >     int pid;
> > > > >     int tgid;
> > > > > } __attribute__((preserve_access_index));
> > > >
> > > > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > > > CO-RE notices that task_struct changed from this two integers version
> > > > (of course) and does the relocation to where it is in the running kernel
> > > > by using /sys/kernel/btf/vmlinux.
> > >
> > > Doing it for one of the skels, build tested, runtime untested, but not
> > > using any vmlinux, BTF to help, not that bad, more verbose, but at least
> > > we state what are the fields we actually use, have those attribute
> > > documenting that those offsets will be recorded for future use, etc.
> > >
> > > Namhyung, can you please check that this works?
> > >
> > > Thanks,
> > >
> > > - Arnaldo
> > >
> > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > index 6a438e0102c5a2cb..f376d162549ebd74 100644
> > > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > @@ -1,11 +1,40 @@
> > >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >  // Copyright (c) 2021 Facebook
> > >  // Copyright (c) 2021 Google
> > > -#include "vmlinux.h"
> > > +#include <linux/types.h>
> > > +#include <linux/bpf.h>
> > 
> > Compared to vmlinux.h here be dragons. It is easy to start dragging in
> > all of libc and that may not work due to missing #ifdefs, etc.. Could
> > we check in a vmlinux.h like libbpf-tools does?
> > https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-generation
> > https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> > 
> > This would also remove some of the errors that could be introduced by
> > copy+pasting enums, etc. and also highlight issues with things being
> > renamed as build time rather than runtime failures.
> 
> we already have to deal with that, right? doing checks on fields in
> structs like mm_struct___old
> 
> > Could this be some shared resource for the different linux tools
> > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > install_headers target that builds a vmlinux.h.
> 
> I tried to do the minimal header and it's not too big,
> I pushed it in here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=perf/vmlinux_h
> 
> compile tested so far
 
Cool.  But I think you missed this.

diff --git a/tools/perf/util/bpf_skel/perf-defs.h b/tools/perf/util/bpf_skel/perf-defs.h
index 1320e1be03b8..4cfa8a9fce39 100644
--- a/tools/perf/util/bpf_skel/perf-defs.h
+++ b/tools/perf/util/bpf_skel/perf-defs.h
@@ -253,6 +253,7 @@ typedef struct {
 } atomic64_t;
 
 struct rw_semaphore {
+	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
 typedef atomic64_t atomic_long_t;


Thanks,
Namhyung

