Return-Path: <bpf+bounces-112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AF06F8232
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91AA1C2181B
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5C79FC;
	Fri,  5 May 2023 11:42:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA17156C6
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 11:42:17 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB411607;
	Fri,  5 May 2023 04:42:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so11393215e9.3;
        Fri, 05 May 2023 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683286934; x=1685878934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwA4RNzHLoe51BKJcNUYfJNJRyNu9DKsCjgDMwmTA7A=;
        b=WF62c/j6RiITYW667aRT9w0LZy3zB+wgpx/WJ54+TRNLcLn4nTSikrpYai6OPrVGkz
         IhgIvNnPGGl2SqlqbS+XLVcmzlBBB3OIewdGD/Mc7jw1zvkSCZS0gO6g4I18UKjJpoj1
         FO9voODgeBvwtJghqcm99OfSx20ZYAYuzHd2L/pDpWIFnzEdDA3BDtg027bp6yGvd9Dy
         qmFj4Wp7HLufi3CpLf5X1VBmgRP2xFU6Kl41WtHiVSFzxiRuFE36kp27VfhPHPstuWxI
         64+hwtMFhwaAojMK5K/YmDlC2xrKZsqTNtkbqts5wT+hjaUtZQ2H9I3Ym5HgEfVBlr30
         j7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683286934; x=1685878934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwA4RNzHLoe51BKJcNUYfJNJRyNu9DKsCjgDMwmTA7A=;
        b=e/mr5PElj8n0EMnDDEUQ19+O3x5Zdr3t8VmUh93yvsoaMFdsMogYYy15fPAxd1T3PW
         yU4qDoIOoD2TIJktpgZzzvH6rMrGak1VW2snljc+09rvjNY64xlRx0XVDo/V+pDC039y
         VbfULTcewhhBnp9yCtoHNjj5bqvT28oB2tRVN3i9J/4EZqfm9JTvWsdBRuyqxhQsFBpe
         Y1g1iJWACcBPP/iTWOxSh1uSMWbCmTDXpy2g7QoTMPv7tZfPZ1YFS4AacUAI0RUmJMxI
         geMOioyVM3+9fGX06c3YjAYHO7YQIzvtQwt3iYuaF3QgBDLizmOVwSdP5rUfi+3pkO60
         iZng==
X-Gm-Message-State: AC+VfDxcU7eFgZrlqZH+5Ri0VIHSVXYNdA+y78uxgbALkzaBy2uJemDW
	HR9wKLnYWYfucxF/GroU85+2U0hCPI6OCg==
X-Google-Smtp-Source: ACHHUZ5w3w27K7kl40zFdLW88ML+N5pSdsni2WgKoruZX/PkX3r58fPaDnqKsJGOacQJD5I58y5CNA==
X-Received: by 2002:a7b:c8d9:0:b0:3f1:78a7:6bd2 with SMTP id f25-20020a7bc8d9000000b003f178a76bd2mr930562wml.27.1683286934055;
        Fri, 05 May 2023 04:42:14 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c029400b003f16932fe7dsm7803364wmk.38.2023.05.05.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:42:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 May 2023 13:42:10 +0200
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
Message-ID: <ZFTrkjccQ4cW6kYZ@krava>
References: <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <CAP-5=fXgtNQ5KQv_M+b-mR-dm_s8AAgRkotXifFiTqBo9FHJzA@mail.gmail.com>
 <ZFTOxBDsbboKeEr9@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFTOxBDsbboKeEr9@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 05, 2023 at 11:39:19AM +0200, Jiri Olsa wrote:
> On Thu, May 04, 2023 at 04:19:47PM -0700, Ian Rogers wrote:
> > On Thu, May 4, 2023 at 4:03 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> > > > On Thu, May 4, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > >
> > > > > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > > > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > > > > > instead of using kernel headers?
> > > > > >
> > > > > > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > > > > > programs, it's more a convenience allowing easy access to definitions
> > > > > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > > > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > > > > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > > > > > dependency on up-to-date host kernel and such.
> > > > > >
> > > > > > > If vmlinux.h generation and usage is causing issues, though, given
> > > > > > > that perf's BPF programs don't seem to be using many different kernel
> > > > > > > types, it might be a better option to just use UAPI headers for public
> > > > > > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > > > > > definitions locally in perf's BPF code for the other types necessary.
> > > > > > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > > > > > suffice:
> > > > > >
> > > > > > > struct task_struct {
> > > > > > >     int pid;
> > > > > > >     int tgid;
> > > > > > > } __attribute__((preserve_access_index));
> > > > > >
> > > > > > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > > > > > CO-RE notices that task_struct changed from this two integers version
> > > > > > (of course) and does the relocation to where it is in the running kernel
> > > > > > by using /sys/kernel/btf/vmlinux.
> > > > >
> > > > > Doing it for one of the skels, build tested, runtime untested, but not
> > > > > using any vmlinux, BTF to help, not that bad, more verbose, but at least
> > > > > we state what are the fields we actually use, have those attribute
> > > > > documenting that those offsets will be recorded for future use, etc.
> > > > >
> > > > > Namhyung, can you please check that this works?
> > > > >
> > > > > Thanks,
> > > > >
> > > > > - Arnaldo
> > > > >
> > > > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > > index 6a438e0102c5a2cb..f376d162549ebd74 100644
> > > > > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > > @@ -1,11 +1,40 @@
> > > > >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > >  // Copyright (c) 2021 Facebook
> > > > >  // Copyright (c) 2021 Google
> > > > > -#include "vmlinux.h"
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/bpf.h>
> > > >
> > > > Compared to vmlinux.h here be dragons. It is easy to start dragging in
> > > > all of libc and that may not work due to missing #ifdefs, etc.. Could
> > > > we check in a vmlinux.h like libbpf-tools does?
> > > > https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-generation
> > > > https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> > > >
> > > > This would also remove some of the errors that could be introduced by
> > > > copy+pasting enums, etc. and also highlight issues with things being
> > > > renamed as build time rather than runtime failures.
> > >
> > > we already have to deal with that, right? doing checks on fields in
> > > structs like mm_struct___old
> > 
> > We do, but the way I detected the problems in the first place was by
> > building against older kernels. Now the build will always succeed but
> > fail at runtime.
> > 
> > > > Could this be some shared resource for the different linux tools
> > > > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > > > install_headers target that builds a vmlinux.h.
> > >
> > > I tried to do the minimal header and it's not too big,
> > > I pushed it in here:
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=perf/vmlinux_h
> > >
> > > compile tested so far
> > >
> > > jirka
> > 
> > Cool, could we just call it vmlinux.h rather than perf-defs.h?
> 
> right, it also makes the change smaller
> 
> > 
> > I notice cgroup_subsys_id is in there which is called out in Andrii's
> > CO-RE  guide/blog:
> > https://nakryiko.com/posts/bpf-core-reference-guide/#relocatable-enums
> > perhaps we can do something with names/types to make sure a helper is
> > being used for these enum values.

both bperf_cgroup and off_cpu programs use bpf_core_enum_value, so we should be fine

jirka

