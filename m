Return-Path: <bpf+bounces-110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F06F8029
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B85280F25
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA1748E;
	Fri,  5 May 2023 09:39:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CD1FC9
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 09:39:23 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84219928;
	Fri,  5 May 2023 02:39:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so246057366b.2;
        Fri, 05 May 2023 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683279560; x=1685871560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUktY4jStI4pioqhxhiQLqN7xdp1S8+7gGDVuIEND74=;
        b=a/m+zAdVmVzY7n3IFMrOHes7piGpofgyMv0chbeHFQJBDhvUL1B1CocjQ5kUigMoyu
         DGNr6C2U70w0fj8H8M+WIReDJv4hqiBYgywhuAEoahNjqg4sMkspLl3PDKe9RawCXvOr
         L77U8IOhjtF6xkL3h906lXiVngWu4h6Q1UdUHFTa0M+wCllEBVaMea5oeHAzpkABD97l
         Qmpcbe6MbTvJFOTfKFv0AaOPCMI+CAw9uu9Vx5FIx7U+uc8NOhjgF2xfc14yi1wWY3Hu
         SvE98SUCKG8uqK532gzKmdqq+YfZMyPe2Kaz5RdxEdxu8lTF4o30w3qh3lOKY5nNt+tP
         629g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683279560; x=1685871560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUktY4jStI4pioqhxhiQLqN7xdp1S8+7gGDVuIEND74=;
        b=dwHEUn0uwNtBWkL5b9jB+2YTdaUxVzZzssJMPCwSgagRPfqsw7ptCJ2cL/vUOWquWM
         G4+nrEK3bhLKiWnzklsYutEkGcjXQCTilefkeozrcLVyh49FrCzpl8IyvfghWE3Q3Sw8
         48Qrw77OFHTozewAo13TmGNMhbdaGFDzyGvwpkQBhF5rLM2WBWh1eCtQp/cXe5GR90+J
         KqoPVcX+9cLPThcwQrnEqEH3wnaJGHNxewMnyxVlE+FRwdsdfJdlwH1aapQE8+DfPfGP
         0J5QVvrWBbbEzJzwpalWHiswc76KfWYdirUQNjlETtooD7lfVdUAesk3v1bqUh0Wcwmq
         9Ghw==
X-Gm-Message-State: AC+VfDxJ6hWU27LCB/yCaBXBN45Mgo7rKVUDuexkJrTnEmANKh98lZpF
	YolnLO/CuKbHxsMv+Mc4QmM=
X-Google-Smtp-Source: ACHHUZ5QYFD4IELsY0R7LPQMp/0MWV54qghTOrO9jyvy11VxKC4OuAqTMSBTYwCjrBV0h68SeRTpYA==
X-Received: by 2002:a17:907:6289:b0:961:8d21:a480 with SMTP id nd9-20020a170907628900b009618d21a480mr582683ejc.58.1683279559773;
        Fri, 05 May 2023 02:39:19 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065da500b00965e68b8df5sm437929ejv.76.2023.05.05.02.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 02:39:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 May 2023 11:39:16 +0200
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <ZFTOxBDsbboKeEr9@krava>
References: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <CAP-5=fXgtNQ5KQv_M+b-mR-dm_s8AAgRkotXifFiTqBo9FHJzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXgtNQ5KQv_M+b-mR-dm_s8AAgRkotXifFiTqBo9FHJzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 04:19:47PM -0700, Ian Rogers wrote:
> On Thu, May 4, 2023 at 4:03 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> > > On Thu, May 4, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > >
> > > > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > > > > instead of using kernel headers?
> > > > >
> > > > > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > > > > programs, it's more a convenience allowing easy access to definitions
> > > > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > > > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > > > > dependency on up-to-date host kernel and such.
> > > > >
> > > > > > If vmlinux.h generation and usage is causing issues, though, given
> > > > > > that perf's BPF programs don't seem to be using many different kernel
> > > > > > types, it might be a better option to just use UAPI headers for public
> > > > > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > > > > definitions locally in perf's BPF code for the other types necessary.
> > > > > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > > > > suffice:
> > > > >
> > > > > > struct task_struct {
> > > > > >     int pid;
> > > > > >     int tgid;
> > > > > > } __attribute__((preserve_access_index));
> > > > >
> > > > > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > > > > CO-RE notices that task_struct changed from this two integers version
> > > > > (of course) and does the relocation to where it is in the running kernel
> > > > > by using /sys/kernel/btf/vmlinux.
> > > >
> > > > Doing it for one of the skels, build tested, runtime untested, but not
> > > > using any vmlinux, BTF to help, not that bad, more verbose, but at least
> > > > we state what are the fields we actually use, have those attribute
> > > > documenting that those offsets will be recorded for future use, etc.
> > > >
> > > > Namhyung, can you please check that this works?
> > > >
> > > > Thanks,
> > > >
> > > > - Arnaldo
> > > >
> > > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > index 6a438e0102c5a2cb..f376d162549ebd74 100644
> > > > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > @@ -1,11 +1,40 @@
> > > >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >  // Copyright (c) 2021 Facebook
> > > >  // Copyright (c) 2021 Google
> > > > -#include "vmlinux.h"
> > > > +#include <linux/types.h>
> > > > +#include <linux/bpf.h>
> > >
> > > Compared to vmlinux.h here be dragons. It is easy to start dragging in
> > > all of libc and that may not work due to missing #ifdefs, etc.. Could
> > > we check in a vmlinux.h like libbpf-tools does?
> > > https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-generation
> > > https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> > >
> > > This would also remove some of the errors that could be introduced by
> > > copy+pasting enums, etc. and also highlight issues with things being
> > > renamed as build time rather than runtime failures.
> >
> > we already have to deal with that, right? doing checks on fields in
> > structs like mm_struct___old
> 
> We do, but the way I detected the problems in the first place was by
> building against older kernels. Now the build will always succeed but
> fail at runtime.
> 
> > > Could this be some shared resource for the different linux tools
> > > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > > install_headers target that builds a vmlinux.h.
> >
> > I tried to do the minimal header and it's not too big,
> > I pushed it in here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=perf/vmlinux_h
> >
> > compile tested so far
> >
> > jirka
> 
> Cool, could we just call it vmlinux.h rather than perf-defs.h?

right, it also makes the change smaller

> 
> I notice cgroup_subsys_id is in there which is called out in Andrii's
> CO-RE  guide/blog:
> https://nakryiko.com/posts/bpf-core-reference-guide/#relocatable-enums
> perhaps we can do something with names/types to make sure a helper is
> being used for these enum values.

ok, I'll check on that..  so far I made some clean ups and updated the branch

thanks,
jirka

