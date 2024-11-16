Return-Path: <bpf+bounces-45036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92509D0115
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E5F1F23B37
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072E1AAE33;
	Sat, 16 Nov 2024 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrBC4ibE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC3CA5A;
	Sat, 16 Nov 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793518; cv=none; b=mxcK/cP9lLneKikR5E6pfpDhj+W9un5GrN/JmIDf++0y+gS0o9Tkbom2SnrBR/vg9gureUimeGIV9D9uNG2IDrsOWf4zcsRVqQpJA6O34pkgpJBBx0FXC4pCoo5JR9Jsxhs84K092I5KCUcBvuQ5jL1R8Dwg8R3fRrhh2gdvvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793518; c=relaxed/simple;
	bh=VA7G5R4OMbjA1umZrQ3nYQZKZu+s12TK7GTSpfwkWlM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHXAAgN6lP36hASyhF8xH+lwwxlNsWbBuR64ziBUA0FcpHjt6qXNd3XW6wDr7oBe7DTUHYWPaFmwOCtz1W6P085AAWWdrBsEBgIGQZgG0g8BVijGVHq/UAIF4zqPMkCq4ljVQ1HF73eFYlP9I/X4YrFMUmxDE3fUA07u0tn2YT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrBC4ibE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so491191566b.3;
        Sat, 16 Nov 2024 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793515; x=1732398315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eirc8liM9DGwCdKXydsX14lymRZu7XA+FZBPTFnkgWE=;
        b=lrBC4ibEM4oxb7oHFhQRClx0XsForhzxAJD9e/ZM0yjCQHSUjvIvs0nDCBMNqc98kc
         atAACnrXDxjxZRGkYM2dpjoHGrxKw/FBVihZiPmLruV30uR0cQ0zYW1n0fVe88unJWVD
         gx8LmPZcT84jzDD0VqY+191DKdPpsEMRhnbwhzs6Fmb75dEtwf9Pm+MDBPvERKq46n+w
         tk/2JWmDoTvxpOse0gJY/o7zWVjBqzdGJ3mLo3vD20lQXUNdhOQlcUrMKhX1CQ0d7Nyv
         V0qezn0lI2dh14SBLfBaHn3ReJwzM25wmnTdS6SSu6b+zEjU/hmTngTOgyYxkMQ0PEe8
         1mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793515; x=1732398315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eirc8liM9DGwCdKXydsX14lymRZu7XA+FZBPTFnkgWE=;
        b=OKKMSEDf4YyQKdsYCQG5o7GwmmywznRJa7qgXBNx7kQgO7bsYGsqZqZOi05bc+Pwfq
         5bPofgzDvgzH6E5ZCCIgn/wKn3tzbsLciDHauafKR3rgYNYsJQxBJpiZcamLr3qyyqgy
         kB2by0TKPCtnEuMwFE1545vwXByQHSHsm1Ejlz9pMuOHB+25nay7ol7bn77InVIMqEXC
         bVv07ATMoAW2zgT/KH+K7KtJj7ijjRk9to/dn1KrtPQbv5Q2siFq17ufnXW7hRKlqCDi
         bmZ9HXj3p5Pa0tfTNnLlXNpVi6oSY7tDq5WtldzV6VTPSPvNabx/zl8PHC22bCGB6X4f
         hRpw==
X-Forwarded-Encrypted: i=1; AJvYcCU5wqMZ2yEp7inXckskYFF+ztJAo+DxKPaswpl1eCDuL7jrUMnptie+yfUMf78BOf5OSyC6Axq5jEL5zZrr@vger.kernel.org, AJvYcCUmXm6nuzF7uBRDHIeM6wlnMtkCKzslm94qIhkvV471ZZIxDQl0omvlxV+nw7cmf5S+y4ZMzboM2GSK9auHP3AjmwKi@vger.kernel.org, AJvYcCWUj748Qfu7toEFIqqyUbe2wHTFLdOGtz6YWJ5oAy1v7qtU7WHbKitsaUj5JFOpKByrRc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYQGykg9hfChNEnp7EKiNbPZqueqATMwwT3P1hRBtPkzdJZp/
	PV3O0WERhp4zE2FY5R3z2wChVeAaOmlcn+Z7L1LHYUtefsgDGGVQ
X-Google-Smtp-Source: AGHT+IGtTukmbY9nZP1NMptqVSU5ZMJ1WFIOBJBYgnN9XAmN80g9H7SJdz8E0TqS9eGvKw3ftrfOYA==
X-Received: by 2002:a17:907:1b2a:b0:a9e:82d2:3168 with SMTP id a640c23a62f3a-aa483525ea9mr697639266b.46.1731793514524;
        Sat, 16 Nov 2024 13:45:14 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df268d5sm345366866b.5.2024.11.16.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:45:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:45:01 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 09/11] selftests/bpf: Add usdt trigger bench
Message-ID: <ZzkSXTjGxNGnpzZX@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-10-jolsa@kernel.org>
 <CAEf4BzaXvdXr4dyHrozWYyMHJor5GpaHnPF8=8qy0r_5Crb3wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaXvdXr4dyHrozWYyMHJor5GpaHnPF8=8qy0r_5Crb3wg@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:40:53PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 5:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding usdt trigger bench to meassure optimized usdt probes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c           |  2 +
> >  .../selftests/bpf/benchs/bench_trigger.c      | 45 +++++++++++++++++++
> >  .../selftests/bpf/progs/trigger_bench.c       | 10 ++++-
> >  3 files changed, 56 insertions(+), 1 deletion(-)
> >
> 
> Why not just adding uprobe-nop5 benchmark instead of going all the way
> into USDT? Seems simpler and will benchmark all the same stuff?

ok, perhaps with your new usdt library and the possible nop/nop5 tricks we
might want to have specific usdt benchmarks.. but that's for later anyway

jirka

> 
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> > index 1bd403a5ef7b..dc5121e49623 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -526,6 +526,7 @@ extern const struct bench bench_trig_uprobe_multi_push;
> >  extern const struct bench bench_trig_uretprobe_multi_push;
> >  extern const struct bench bench_trig_uprobe_multi_ret;
> >  extern const struct bench bench_trig_uretprobe_multi_ret;
> > +extern const struct bench bench_trig_usdt;
> >
> >  extern const struct bench bench_rb_libbpf;
> >  extern const struct bench bench_rb_custom;
> > @@ -586,6 +587,7 @@ static const struct bench *benchs[] = {
> >         &bench_trig_uretprobe_multi_push,
> >         &bench_trig_uprobe_multi_ret,
> >         &bench_trig_uretprobe_multi_ret,
> > +       &bench_trig_usdt,
> >         /* ringbuf/perfbuf benchmarks */
> >         &bench_rb_libbpf,
> >         &bench_rb_custom,
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > index 32e9f194d449..bdee8b8362d0 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -8,6 +8,7 @@
> >  #include "bench.h"
> >  #include "trigger_bench.skel.h"
> >  #include "trace_helpers.h"
> > +#include "../sdt.h"
> >
> >  #define MAX_TRIG_BATCH_ITERS 1000
> >
> > @@ -333,6 +334,13 @@ static void *uprobe_producer_ret(void *input)
> >         return NULL;
> >  }
> >
> > +static void *uprobe_producer_usdt(void *input)
> > +{
> > +       while (true)
> > +               STAP_PROBE(trigger, usdt);
> > +       return NULL;
> > +}
> > +
> >  static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
> >  {
> >         size_t uprobe_offset;
> > @@ -383,6 +391,37 @@ static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
> >         }
> >  }
> >
> > +static void __usdt_setup(const char *provider, const char *name)
> > +{
> > +       struct bpf_link *link;
> > +       int err;
> > +
> > +       setup_libbpf();
> > +
> > +       ctx.skel = trigger_bench__open();
> > +       if (!ctx.skel) {
> > +               fprintf(stderr, "failed to open skeleton\n");
> > +               exit(1);
> > +       }
> > +
> > +       bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt, true);
> > +
> > +       err = trigger_bench__load(ctx.skel);
> > +       if (err) {
> > +               fprintf(stderr, "failed to load skeleton\n");
> > +               exit(1);
> > +       }
> > +
> > +       link = bpf_program__attach_usdt(ctx.skel->progs.bench_trigger_usdt,
> > +                                       -1 /* all PIDs */, "/proc/self/exe",
> > +                                       provider, name, NULL);
> > +       if (!link) {
> > +               fprintf(stderr, "failed to attach uprobe!\n");
> > +               exit(1);
> > +       }
> > +       ctx.skel->links.bench_trigger_usdt = link;
> > +}
> > +
> >  static void usermode_count_setup(void)
> >  {
> >         ctx.usermode_counters = true;
> > @@ -448,6 +487,11 @@ static void uretprobe_multi_ret_setup(void)
> >         usetup(true, true /* use_multi */, &uprobe_target_ret);
> >  }
> >
> > +static void usdt_setup(void)
> > +{
> > +       __usdt_setup("trigger", "usdt");
> > +}
> > +
> >  const struct bench bench_trig_syscall_count = {
> >         .name = "trig-syscall-count",
> >         .validate = trigger_validate,
> > @@ -506,3 +550,4 @@ BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprobe-multi-ret");
> >  BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
> >  BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
> >  BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
> > +BENCH_TRIG_USERMODE(usdt, usdt, "usdt");
> > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > index 044a6d78923e..7b7d4a71e7d4 100644
> > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > @@ -1,8 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  // Copyright (c) 2020 Facebook
> > -#include <linux/bpf.h>
> > +#include "vmlinux.h"
> >  #include <asm/unistd.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include <bpf/usdt.bpf.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include "bpf_misc.h"
> >
> > @@ -138,3 +139,10 @@ int bench_trigger_rawtp(void *ctx)
> >         inc_counter();
> >         return 0;
> >  }
> > +
> > +SEC("?usdt")
> > +int bench_trigger_usdt(struct pt_regs *ctx)
> > +{
> > +       inc_counter();
> > +       return 0;
> > +}
> > --
> > 2.47.0
> >

