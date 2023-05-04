Return-Path: <bpf+bounces-54-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1AC6F798E
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 01:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635FB1C2155D
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0BC15D;
	Thu,  4 May 2023 23:03:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A440C156
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:03:20 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5594111D80;
	Thu,  4 May 2023 16:03:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd87539c2so1786665a12.0;
        Thu, 04 May 2023 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683241397; x=1685833397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yWOua6diagEP9w5UDlQh2ycV9iT1GzUYH6J+nVD3eqI=;
        b=JOAqTnfq2v2NoKHBjFk5s3WofNsDwxh5HmOdKEE+W1tN6tefO9iZvJmDvJU5wgniar
         2kg2d/wPux24xedU19v/X1Hl1YbFDokk0hgcMeD5lzSva0Q+Z9k2SaFNgwmf9MThF6dd
         wujDiEPmjdLLf3pCexeDDNamwe1iVonEqvOxx30zdLZL63BQsFnyjI9MRCgsp65N22gJ
         IxqSGE1/6mGHHuYGrXd31y8nMvfWg7BYE7d6LuRIMNWGuz3FMaxlUInXjI2uiamuenDs
         93WlqBfO+mSluSWlC+er610/cQcfDs/U6HJSY8LAR3yhwH9PkMavKsdER1gguoO/79G3
         xQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683241397; x=1685833397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWOua6diagEP9w5UDlQh2ycV9iT1GzUYH6J+nVD3eqI=;
        b=CLaxHLfcS7B6W39NeFlUcg2VMsJbpaDLuOqHGNNE93+rVwt2ogqYdfaOKvk0cyQe3f
         x5HwUXuUjbJqV88221gnEg1y5gc9qEIuBiKT4U9dx8nrBuDBbQKv8fBejlTWGQYohVGp
         KdM7qSmJd/EApwFGKmdKVhECfnvX2dPzHio0UdB08ZI9XGIY7lGstCaNuDN0ch7xFlHM
         lh1j/R5+tcS8pz7nFZKioeWgGb0cSFQhub5tZqMcQ4vExn8MKoYAci+NpkK3uY9od6hg
         k0f2ND3c/JsERYuPaFnjBS20BQuD7bhiHhxU8qxO9N8ZIxqNgRc3zutW75nV7GFBqwpy
         YjLA==
X-Gm-Message-State: AC+VfDymeCJ9hqYgMkTdZAoOVNKE6lNxXRcGBX3jMpsJLn9f8Biq2V1B
	GVfcMUEoCcJGxFNfuOE5LtU=
X-Google-Smtp-Source: ACHHUZ6vBzjNsow+SMHuZ82EJHJLQtHJmiwifuvN6I4pxG0+/jC+M9At6bUXX6Dw8p7HUh2RXaXLcg==
X-Received: by 2002:a17:907:98a:b0:94b:d57e:9d4b with SMTP id bf10-20020a170907098a00b0094bd57e9d4bmr382506ejc.2.1683241396599;
        Thu, 04 May 2023 16:03:16 -0700 (PDT)
Received: from krava ([83.240.61.110])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170906b04600b0096595cc0810sm139867ejb.72.2023.05.04.16.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 16:03:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 May 2023 01:03:14 +0200
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <ZFQ5sjjtfEYzvHNP@krava>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> On Thu, May 4, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > > instead of using kernel headers?
> > >
> > > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > > programs, it's more a convenience allowing easy access to definitions
> > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > > dependency on up-to-date host kernel and such.
> > >
> > > > If vmlinux.h generation and usage is causing issues, though, given
> > > > that perf's BPF programs don't seem to be using many different kernel
> > > > types, it might be a better option to just use UAPI headers for public
> > > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > > definitions locally in perf's BPF code for the other types necessary.
> > > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > > suffice:
> > >
> > > > struct task_struct {
> > > >     int pid;
> > > >     int tgid;
> > > > } __attribute__((preserve_access_index));
> > >
> > > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > > CO-RE notices that task_struct changed from this two integers version
> > > (of course) and does the relocation to where it is in the running kernel
> > > by using /sys/kernel/btf/vmlinux.
> >
> > Doing it for one of the skels, build tested, runtime untested, but not
> > using any vmlinux, BTF to help, not that bad, more verbose, but at least
> > we state what are the fields we actually use, have those attribute
> > documenting that those offsets will be recorded for future use, etc.
> >
> > Namhyung, can you please check that this works?
> >
> > Thanks,
> >
> > - Arnaldo
> >
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > index 6a438e0102c5a2cb..f376d162549ebd74 100644
> > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -1,11 +1,40 @@
> >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  // Copyright (c) 2021 Facebook
> >  // Copyright (c) 2021 Google
> > -#include "vmlinux.h"
> > +#include <linux/types.h>
> > +#include <linux/bpf.h>
> 
> Compared to vmlinux.h here be dragons. It is easy to start dragging in
> all of libc and that may not work due to missing #ifdefs, etc.. Could
> we check in a vmlinux.h like libbpf-tools does?
> https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-generation
> https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> 
> This would also remove some of the errors that could be introduced by
> copy+pasting enums, etc. and also highlight issues with things being
> renamed as build time rather than runtime failures.

we already have to deal with that, right? doing checks on fields in
structs like mm_struct___old

> Could this be some shared resource for the different linux tools
> projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> install_headers target that builds a vmlinux.h.

I tried to do the minimal header and it's not too big,
I pushed it in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=perf/vmlinux_h

compile tested so far

jirka

