Return-Path: <bpf+bounces-144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FE6F8A4E
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 22:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087181C219F3
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6047D2F4;
	Fri,  5 May 2023 20:43:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C822F33
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 20:43:43 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135454C38;
	Fri,  5 May 2023 13:43:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so3422643a12.2;
        Fri, 05 May 2023 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683319420; x=1685911420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uFSWihGIKzKwGYwd6QR8vSRSSJMeBujbJbHEQXcQhYk=;
        b=sQ6du13TUE8vgmOrUSv+QgdSBNFbdRtCl46u/hEmhiLh79gr7whoaE5IX1bl3vV79N
         xObP1dWOXW0g5Pa46HM5xW54N3wUmXbQ9zGbBA4yqS1TGs19jV6XK/QEcVndYHrUPtSo
         7ouL5m0guLygMtI/sRcpqkwlCcAprApRl609ODXcJQ9ucU8wLnegSv6/8Ze+hLhdt0nk
         r2eCAhtElcsEuku6OS9zLwz9EzsFAvbLae/tXEXGEuXeHkaVVo+fSHbHnkynaOj2c2eP
         vPO3pzTivNswN65uN7nqSbqJAelhtL22SW+LRkDjPlYeDXf09iqoxCbdmOgUUrUizPmT
         WDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319420; x=1685911420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFSWihGIKzKwGYwd6QR8vSRSSJMeBujbJbHEQXcQhYk=;
        b=c77Hq17iEPSG0ItJerH9AdJVe2X1rh/3m4V82mglDEx0v8B8mkg5R2o5LH9krQDvI9
         V7jZMnxh40kKLR/qxBfZV2m5TZBiQavYPIQdBJD+2CunrswhHMrKczXw5m2jmHhSRfBK
         YTsf9BnaZ/0o7YC6qWo3/Lg15ObUbPw0znV3g8ZPLxvU4SE4H/kKW8OM9SANHZJbwYSI
         8mfLvN1uoyBTrcXDnslCXa3Cy3ZS9u+E9eIX1zZvburgGk4YsS2uDMlHbLus3i/V3IWW
         IP9s5byUkimEwrsD1E7l1Z3jU3pQBYnwaENBWINwzHjzddYkx61DvtdL/62cRMI8ncli
         NmyQ==
X-Gm-Message-State: AC+VfDwfWzjw21RxAIENtnprV8NZoM40E2UgIUVhE9w5CFbcYUFrgUL8
	zMzM3PJDnCFitke7/J8NGkwVenNJgAAhag==
X-Google-Smtp-Source: ACHHUZ7qcRFHtffY40JLebb/nkCMevDLaMxi9rCSTL8pLWNRtXP779vtO/jGG1XtQ+anuM99Qf4UEw==
X-Received: by 2002:a17:906:974e:b0:94a:44bc:31e7 with SMTP id o14-20020a170906974e00b0094a44bc31e7mr2263150ejy.60.1683319420106;
        Fri, 05 May 2023 13:43:40 -0700 (PDT)
Received: from krava ([83.240.60.209])
        by smtp.gmail.com with ESMTPSA id hh15-20020a170906a94f00b00965b5f3568fsm1369623ejb.43.2023.05.05.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:43:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 May 2023 22:43:36 +0200
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFVqeKLssg7uzxzI@krava>
References: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <ZFUFmxDU/6Z/JEsi@kernel.org>
 <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> On Fri, May 5, 2023 at 9:56 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > That with the preserve_access_index isn't needed, we need just the
> > > fields that we access in the tools, right?
> >
> > I'm now doing build test this in many distro containers, without the two
> > reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> > test build and also for the functionality tests on the tools using such
> > bpf skels, see below, no touching of vmlinux nor BTF data during the
> > build.
> >
> > - Arnaldo
> >
> > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Thu, 4 May 2023 19:03:51 -0300
> > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated from BTF,
> >  use subset of used structs + CO-RE
> >
> > Linus reported a build break due to using a vmlinux without a BTF elf
> > section to generate the vmlinux.h header with bpftool for use in the BPF
> > tools in tools/perf/util/bpf_skel/*.bpf.c.
> >
> > Instead add a vmlinux.h file with the structs needed with the fields the
> > tools need, marking the structs with __attribute__((preserve_access_index)),
> > so that libbpf's CO-RE code can fixup the struct field offsets.
> >
> > In some cases the vmlinux.h file that was being generated by bpftool
> > from the kernel BTF information was not needed at all, just including
> > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > types were not being used.
> >
> > To keep te patch small, include those UAPI headers from the trimmed down
> > vmlinux.h file, that then provides the tools with just the structs and
> > the subset of its fields needed for them.
> >
> > Testing it:
> >
> >   # perf lock contention -b find / > /dev/null

I tested perf lock con -abv -L rcu_state sleep 1
and needed fix below

jirka


---
From b12aea55f1171dc09cde2957f9019c84bda7adbb Mon Sep 17 00:00:00 2001
From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 May 2023 13:28:46 +0200
Subject: [PATCH] perf tools: Fix lock_contention bpf program

We need to define empty 'struct rq' so the runqueues gets
resolved properly:

  # ./perf lock con -b
  libbpf: extern (var ksym) 'runqueues': incompatible types, expected [99] fwd rq, but kernel has [19783] struct rq
  libbpf: failed to load object 'lock_contention_bpf'
  libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
  Failed to load lock-contention BPF skeleton

Also rq__old/rq__new need additional '_' so the suffix is ignored
properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 8911e2a077d8..c2bf24c68c14 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -416,13 +416,15 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
+struct rq {};
+
 extern struct rq runqueues __ksym;
 
-struct rq__old {
+struct rq___old {
 	raw_spinlock_t lock;
 } __attribute__((preserve_access_index));
 
-struct rq__new {
+struct rq___new {
 	raw_spinlock_t __lock;
 } __attribute__((preserve_access_index));
 
@@ -434,8 +436,8 @@ int BPF_PROG(collect_lock_syms)
 
 	for (int i = 0; i < MAX_CPUS; i++) {
 		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
-		struct rq__new *rq_new = (void *)rq;
-		struct rq__old *rq_old = (void *)rq;
+		struct rq___new *rq_new = (void *)rq;
+		struct rq___old *rq_old = (void *)rq;
 
 		if (rq == NULL)
 			break;
-- 
2.40.1


