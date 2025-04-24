Return-Path: <bpf+bounces-56595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66182A9ADEC
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241DD4A035B
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEF727BF79;
	Thu, 24 Apr 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3PFYCP8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687227B4FE;
	Thu, 24 Apr 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498994; cv=none; b=SuEC2FFZjwRFnt3S0B3xcOXtiR6mZIcoGHU6kubSEhBTPGlmfZE6keE3N85900rxKK0R1XjRMU5YIRIMPBKEtwyxKLNjYTN3PtGZztDaL1otpaf+lv05HGo4KwlL4VJGvIcYYoE0CjKmriBN6rA9295RUpujM+S6SHAFPVUVK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498994; c=relaxed/simple;
	bh=p/rOd3i5b7qQhyyW137PcSqdscgC3kk2Uqz0GR+eId4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd9+uLigNo1XlYmooHbDoMo/ej2XK6GzUqbqm43/imhnzkOdGaY3Fb+YlbiJ64AFgoUscMesMIYIJbxUA0W+kFR+vX9OKb/BMfGAwNksirJo/m/q85wCZlcQVs7NROuUaw0uFWFKD6HJ7KvnRhTVSpFyT8noNrLXGEAnsW2neTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3PFYCP8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so1441890a12.1;
        Thu, 24 Apr 2025 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498990; x=1746103790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSEWW9BbAPEs6rJriEsn5xHrbM7UPcDq+siupWsOBdY=;
        b=S3PFYCP8SWx5DQSArpR5kdWkKPN6wm1FlSKfBtuxmnmCX+5cQKvh13uY5vruqw20RT
         cKcyGcGIW5K14fG7YlzQzHiZWtnQxAx0W0NvJmuwFV6a6LMA9dtyejrk1RopOBjp/bU7
         Gab+f4PP1Ny5Jb3ZvRl01xE0LuXTW0HZzYOry3oOdgpil0GzzC7DchN74Cr2x0qbJc5i
         jVYSuNgP5pJbothL80p34q277MvyGJPTyqPolLcmYDg18X6p5co0EmCS1pdJLH3YHg+J
         UiXi1LghcwySEwM2f0v9UW/A81WpGKev9A1Wh9vSxYSlxpue2SfLfW1YAuRKiQUtBOls
         XfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498990; x=1746103790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSEWW9BbAPEs6rJriEsn5xHrbM7UPcDq+siupWsOBdY=;
        b=g5G2OX5zKZ9bI63pEWn+9lM5/EYLaZs0e6O0tvhgoHmFAaRFxWFonNwS9gOpTlUnt0
         /75oYMPMReVtE2pKsOVRcWoBJHN0BVkSLyPfBFUkmF8MFPZODr0ohm5JzqH0Y6LshwPU
         Z6uuxJs5c4RnGlISrpqBPpqjd3blP9lHlgUiQK1B4t1LRPFanz+549YBgMU3snjMQWDN
         D5/g6yb/39SRQfibwGU4XH5di+4b5CPU1OMvh/VqbhUmVbL4mCCjZxGXv/rN3TcNz2Ga
         G90TBKl+RplyYpavLPO0akpSUNtwUuXVjPg/mu7BN4hnYPLGlq9fEcsKfFyI1D4JHBHB
         Lofw==
X-Forwarded-Encrypted: i=1; AJvYcCVjeL3jPfHgMvIS9DimEUGikU5Ht3nJ1r+blKEXKoVnfsfS2Lk7Mblt9YTPOJX8PYBUNcqDu/mXgjNEjTmO@vger.kernel.org, AJvYcCWkwViEyxL3z30HiZ0yM1jUDttvIXAWisnAU65AmpwhRss5/ZOsmVBOMbcNgodjARBOE2VzO1A1jL/KIHLlRdsKv+GA@vger.kernel.org, AJvYcCXx1UAdthuQO2rpe2V6Wh0QokcmZmo+FCgO4ggO+UCB0Rtv5+9MiBOyub9fukkO0aUmu5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXRzCvRU+vM/iYNc0tvriA1TnJfBLo2C+fto0I9rVcHKbSgKo
	IF38CA8g8rtb3aRM4a9mRVpwqkumRGac/ZBrA1ozGZaCxFA8f9/l
X-Gm-Gg: ASbGncuQLDX+aEMVFB08yrRG+RZOwiw5cBCDPgbQvQZONXbja0/ZowzpW1YFfG2wFut
	4lZGCk5lz7xGQPHRjFQIQVU1dPHQhyM9k3OhfCAa8dP2faD6+854iPY9o3re2en5OI3WTijIxhg
	NRu1lAqkFef5VnHy+d/blzyIRjUTOXY0gvoqF7lNMtzm4t6Jqgk2Dfp4q3zB+I2YkcHXjmK+7H/
	Jx3k/N1DoOEQQpGtXcLYxNlH46r7Pcr6wci+bPLrqJjNnhf8Shn0Z6gkVrAPzt2mUJx5LdmM39o
	wEusTk9tps5LN5whJGILGMXuwjo=
X-Google-Smtp-Source: AGHT+IHwf+ATNXMNvlohklaZixX6tEmD6VTz/rgQ+v+dYzN9OnnLOdigEmIPwGRkY9F0n92qwmmR6g==
X-Received: by 2002:a05:6402:26d2:b0:5e5:bfab:524 with SMTP id 4fb4d7f45d1cf-5f6ddb0c615mr2618635a12.3.1745498989867;
        Thu, 24 Apr 2025 05:49:49 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6eb43e1casm1124307a12.17.2025.04.24.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:49:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Apr 2025 14:49:47 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 14/22] selftests/bpf: Add uprobe/usdt syscall
 tests
Message-ID: <aAoza2tZYEo6gvKF@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-15-jolsa@kernel.org>
 <CAEf4BzaK+as2YtN1L6aNT6m6R+iRs_VjOdV7mtDNAvKFdouoEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaK+as2YtN1L6aNT6m6R+iRs_VjOdV7mtDNAvKFdouoEA@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:40:58AM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 21, 2025 at 2:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding tests for optimized uprobe/usdt probes.
> >
> > Checking that we get expected trampoline and attached bpf programs
> > get executed properly.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 278 +++++++++++++++++-
> >  .../bpf/progs/uprobe_syscall_executed.c       |  37 +++
> >  2 files changed, 314 insertions(+), 1 deletion(-)
> >
> 
> [...]
> 
> >  static void __test_uprobe_syscall(void)
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > index 2e1b689ed4fb..7bb4338c3ee2 100644
> > --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/usdt.bpf.h>
> >  #include <string.h>
> >
> >  struct pt_regs regs;
> > @@ -9,9 +11,44 @@ char _license[] SEC("license") = "GPL";
> >
> >  int executed = 0;
> >
> > +SEC("uprobe")
> > +int BPF_UPROBE(test_uprobe)
> > +{
> 
> I'd add a PID filter to all of these to guard against potential
> unrelated triggerings if in the future there is some parallel test
> that attaches to all uprobes or something like that. Better safe than
> sorry.

ok, makes sense, will add

thanks,
jirka

> 
> > +       executed++;
> > +       return 0;
> > +}
> > +
> > +SEC("uretprobe")
> > +int BPF_URETPROBE(test_uretprobe)
> > +{
> > +       executed++;
> > +       return 0;
> > +}
> > +
> > +SEC("uprobe.multi")
> > +int test_uprobe_multi(struct pt_regs *ctx)
> > +{
> > +       executed++;
> > +       return 0;
> > +}
> > +
> >  SEC("uretprobe.multi")
> >  int test_uretprobe_multi(struct pt_regs *ctx)
> >  {
> >         executed++;
> >         return 0;
> >  }
> > +
> > +SEC("uprobe.session")
> > +int test_uprobe_session(struct pt_regs *ctx)
> > +{
> > +       executed++;
> > +       return 0;
> > +}
> > +
> > +SEC("usdt")
> > +int test_usdt(struct pt_regs *ctx)
> > +{
> > +       executed++;
> > +       return 0;
> > +}
> > --
> > 2.49.0
> >

