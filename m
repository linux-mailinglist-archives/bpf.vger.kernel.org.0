Return-Path: <bpf+bounces-109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729686F8017
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 11:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB99280EF5
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22087481;
	Fri,  5 May 2023 09:36:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF11FC9
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 09:36:19 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85310F3;
	Fri,  5 May 2023 02:36:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965d2749e2eso121534666b.1;
        Fri, 05 May 2023 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683279371; x=1685871371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+4bTW2iXQuPUhD6F2rTrgXPNpZoWABuiI82ZSrn6ZeQ=;
        b=ZgJD0jzisd17mwG6/TAJZoOe9THtXUtJROaL2dPa9EAXG6sWl5vFMaIVuwF+dreRbQ
         K9lji+Gf94C2msPVo32PZQvaUZ9W1KeNqeF18POQkmtBbRR/Hjzd3eaB4ZpKuuzgfxTh
         1lV5V8+tp4TW2nkbA5ZVsvy9B4XtgNua1ePuvGKawj9VAA9vkpVli1uek42hGNOEjVHj
         I85M/JG6putiRDHrfqcjgd/l+lZj/eaa+HDKxEkThQ62PBflpgofwfmIDWmWH8ps15Kq
         I8N6dj6hUSVT6c4EeP44+u/3U5oJK1EKXLxFVsJDebYI9Qcd1BWa6SA/s6i34nK1v/Ia
         B9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683279371; x=1685871371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4bTW2iXQuPUhD6F2rTrgXPNpZoWABuiI82ZSrn6ZeQ=;
        b=MXAc1cKBxrUW2I3cjWQS+c2Ikrv42dpAIX4tG5LJT/qokE6vozPvNeJY2y25ZTtZUH
         UNid7h2bqKmvjPTu6rfA2Jw2IxsRKYGavTbzFIK+VevmjfkdJk76gU6aG/A/6RSh/x3I
         K2F4jFT51IWR7B7O+AMIWGV/jBKDqnB6kKuRrdZdqOj9cgbwQ8Yf6fBIQdyiGnTdfcxz
         KjG+4OVI6R19potgehLA6iqENY9e/0XH7uRI04q38cgsWhoKcLgPb72M1rXmIPFFoSft
         6PzF5wv+Ad/vGy1T0Oluy9aW8groDUK0s2RqIEoG1xKEJIJA2bERIpYV8xOoWgCc5B6l
         jjpg==
X-Gm-Message-State: AC+VfDwroR9C/OXfA6sbOg9IIvh8UFKvH7jxPN9auY4UnRQ8+0G9E7ma
	eTNvxnDkSCQBbfyrU8RpO8o=
X-Google-Smtp-Source: ACHHUZ6iEMd2LVpNbbs8NBcnocM2nbglOzIoCa+ZQRbGy2sxfgnz6bLEJ6mNIqOehEnDaxe1WtjxGA==
X-Received: by 2002:a17:906:ee8e:b0:95e:c549:9ace with SMTP id wt14-20020a170906ee8e00b0095ec5499acemr500737ejb.62.1683279370940;
        Fri, 05 May 2023 02:36:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id bu26-20020a170906a15a00b00965cd3a037fsm709594ejb.112.2023.05.05.02.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 02:36:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 May 2023 11:36:07 +0200
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
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
Message-ID: <ZFTOB9ZXsKuxXm/6@krava>
References: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <ZFQ8fB3yfIFimwhD@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQ8fB3yfIFimwhD@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 04:15:08PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa wrote:
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
> > 
> > > Could this be some shared resource for the different linux tools
> > > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > > install_headers target that builds a vmlinux.h.
> > 
> > I tried to do the minimal header and it's not too big,
> > I pushed it in here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=perf/vmlinux_h
> > 
> > compile tested so far
>  
> Cool.  But I think you missed this.
> 
> diff --git a/tools/perf/util/bpf_skel/perf-defs.h b/tools/perf/util/bpf_skel/perf-defs.h
> index 1320e1be03b8..4cfa8a9fce39 100644
> --- a/tools/perf/util/bpf_skel/perf-defs.h
> +++ b/tools/perf/util/bpf_skel/perf-defs.h
> @@ -253,6 +253,7 @@ typedef struct {
>  } atomic64_t;
>  
>  struct rw_semaphore {
> +	atomic_long_t owner;
>  } __attribute__((preserve_access_index));

ah right, I did not see that because my clang took another #ifdef leg

thanks,
jirka

>  
>  typedef atomic64_t atomic_long_t;
> 
> 
> Thanks,
> Namhyung

