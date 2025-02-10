Return-Path: <bpf+bounces-51037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7120DA2F719
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D9C161B9B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB2257424;
	Mon, 10 Feb 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uPPNNnS0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF71F8BC5
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212268; cv=none; b=GS+NJAUj0MVaXIYLAGI0zkgfSCRXcO+VTOz3Q8nOv88wD5clWHR8qFMFkY7KTiO24KcY+hZHbLqEbUKtVXTCFnPoEng1dH7MnRkeRuuG+iXjNPEtmhYxyP1qsuyymOrCyXuX+WaayKQLaRZpXjwQQTHM8+MsYOgdWREzbQnzFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212268; c=relaxed/simple;
	bh=NGOFeQX/94iKLC7KRyXn9K4Nt0CwgBBrM/PM50W0oY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tww3hjUdCfOd5Jdxzz65R8X73uBa3lFdOJeUXGN5+3pldjz2Ng8tCnkITNmC76LcosODdznAMm5Hu15SOagmwXkWjo4xKPcDvpC4h+ZiKIOJlzzQ759UzdhueNe/irLMtYMHR/E6rnFAR6BwRmSa7eRxboEUx1xoRoM3z+7F+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uPPNNnS0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e46ebe19489so3476850276.2
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 10:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739212265; x=1739817065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPwb4aI7pixw1RFAv20MaBbqn02tdpDM4Y6srTWRmRk=;
        b=uPPNNnS04+JKCnArBtaVzbXinW+Z6sw8obI2LEZkIcEuXfK4sD6xH2vRUV7pbUuNlG
         Y5k5sN9uXUvWVBhFL0VE3mesvv+WGMgHMAx/FjICw2cpmWW4KQ2u4FKPwG+rQ+lgzK8S
         ZT6oikXG8OZ+vDptV+whm4dY2IU1UZCXfpKophp8tFe3E6KqtqNDqbgqaAon61IPwLBj
         zUWF6Wson0GFjgnijp7GdoeTCDRIKDPzQnp3HHq6TZ7aH/iwoP7HjiTVzwBFOoePAPoZ
         cpH77Motu1kIJmk+GTJZ9yym2DtuNZgfNEnSB8iJ0b1HB/a3C+GT4MAMOUEQKvJosiov
         7XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212265; x=1739817065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPwb4aI7pixw1RFAv20MaBbqn02tdpDM4Y6srTWRmRk=;
        b=DHxNmtusPGVYRm7a505L9VO9qfIh54hYD5CJLBbgz2+TGlurQ5yxFBfSh8YXnsbzeO
         08oKRAzNSsqx0O+HP1DyKWXSgrv/4ejAWpaxoBPQZZ7XuO9Iug7neNVwjd35UFaBVC45
         pJPxJGBFEtWQOLwW1Bou/Iau490vFpxpnAs6UzZy8g6DjKMGTWtJAupp0c9BkuvKJ1uw
         cjna8gmlAkuGFeIm9Ipk6T7S6Rga8wRm/9V9qxI4wh8F9p1d/LlD+X011RYDbq4SBqTB
         P8mgQKAyyRvlmZr2XndnQZAHwW+2YL5V3qbgeHQD3Eo5yqls8WFG0ohnwfAn2VXl8XR/
         QMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1979uPg4ZLLBTopgVtgSVsO5AEtyKucvcvFwQ0w8p+n6Ods051Pl5r2IOjdLK5lS3fTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzs2trezfJNhpaf+6rrqSvIDb0M7u4TkZ6TJZfzbsgyX+8jfz
	eZjHAMpL7o5XJv6OMVTsZMJLu144cL5TFLq5Ud6sysrfakWZlQ9uQlHC1eWlpxA=
X-Gm-Gg: ASbGncvMpWDNujSvdIodIHFabMKUS4HEJtVKXMYoVa8LAuB+uJ9FN3bhoBDTHHicGqS
	Mq/hx+nbfCYpFqhjPZoz/b59VXfILes8hqm+WuBBWp8wD3KEonaQ0oNmyllQTN2oiCDnpWMRnfv
	7qNR9aD4kkajxmh28vevTgcGbs4NbtEs5CB1snmfNt6ON/XYWucD62GvvpvPfetPMD7E/kyxxdT
	MDaUO+gV8l6JIj+RDh7M+ru9XhW0IZ0CPgbZJ7Lv95WipE5Dm0hO/cr3QKzFdJi5guOtGsOWquv
	SLQ=
X-Google-Smtp-Source: AGHT+IHP4/PfYe0pzIQUijWibiRiqcclWIqX6MxksiY/orFAxERUC+/zAt6c1cAXqUao8PQOqCSyhA==
X-Received: by 2002:a05:6902:1793:b0:e5b:3394:ea0c with SMTP id 3f1490d57ef6-e5b461672f5mr12395154276.10.1739212264835;
        Mon, 10 Feb 2025 10:31:04 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a45d7f1sm2703301276.40.2025.02.10.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:31:04 -0800 (PST)
Date: Mon, 10 Feb 2025 10:31:02 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z6pF5pkH_bqvDwMK@ghost>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost>
 <Z6JksXDRh8OSAh-u@google.com>
 <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
 <Z6Khl1rHIAb7wOXw@ghost>
 <CAEf4Bza5nKk6_fVY2vmJjZgPb40zB+R3REy8==ZLc98eg1iHTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza5nKk6_fVY2vmJjZgPb40zB+R3REy8==ZLc98eg1iHTA@mail.gmail.com>

On Wed, Feb 05, 2025 at 05:28:19PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 4, 2025 at 3:24 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Tue, Feb 04, 2025 at 11:02:42PM +0000, Alexei Starovoitov wrote:
> > > On Tue, Feb 4, 2025 at 7:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> > > > > On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> > > > > > On Tue, Feb 4, 2025 at 12:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > > >
> > > > > > > The quiet infrastructure was moved out of Makefile.build to accomidate
> > > > > > > the new syscall table generation scripts in perf. Syscall table
> > > > > > > generation wanted to also be able to be quiet, so instead of again
> > > > > > > copying the code to set the quiet variables, the code was moved into
> > > > > > > Makefile.perf to be used globally. This was not the right solution. It
> > > > > > > should have been moved even further upwards in the call chain.
> > > > > > > Makefile.include is imported in many files so this seems like a proper
> > > > > > > place to put it.
> > > > > > >
> > > > > > > To:
> > > > > > >
> > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > ---
> > > > > > > Charlie Jenkins (2):
> > > > > > >       tools: Unify top-level quiet infrastructure
> > > > > > >       tools: Remove redundant quiet setup
> > > > > > >
> > > > > > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > > > > > >  tools/bpf/Makefile                        |  6 -----
> > > > > > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > > > > > >  tools/bpf/bpftool/Makefile                |  6 -----
> > > > > > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > > > > > >  tools/bpf/runqslower/Makefile             |  5 +---
> > > > > > >  tools/build/Makefile                      |  8 +-----
> > > > > > >  tools/lib/bpf/Makefile                    | 13 ----------
> > > > > >
> > > > > > Nack.
> > > > > > libbpf and bpftool are synced independently to github
> > > > > > and released from there.
> > > > > > This change breaks it.
> > > >
> > > > Sorry, I overlooked this part and merged a change that touched the
> > > > common files into the perf tree.
> > > >
> > > > f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in Makefile.perf")
> > > >
> > > > Unfortunately, it's already in v6.14-rc1.
> > > >
> > > > >
> > > > > Can you explain how it breaks it? Currently bpftool and resolve_btfids
> > > > > don't build quietly so this was an attempt to fix that.
> > > >
> > > > So I think you will need something like this for v6.14.  Again, sorry
> > > > about the trouble.
> > >
> > > Just revert f2868b1a66d4f40f that created this mess.
> >
> > Why are you opposed to unifying this helpers among the various projects
> > in tools? Can you explain what about this breaks the Github syncing flow
> > and why it cannot be resolved? It doesn't make sense to duplicate "Q="
> > in every Makefile anybody ever wants to add to tools just because bpf
> > syncing isn't robust.
> 
> Alexei's concern about Github mirrors of bpftool and libbpf isn't
> valid. Github versions of those projects use their own independent
> Makefiles anyways, so your change doesn't break that aspect.
> 
> But your change *does* break both libbpf's and bpftool's make output
> *in the kernel repo*. With this patch we basically don't have "quiet"
> mode anymore:
> 
> $ git co f2868b1a66d4f40f07e985b0beead606b2753602
> HEAD is now at f2868b1a66d4 perf tools: Expose quiet/verbose variables
> in Makefile.perf
> $ git log --oneline -n1
> f2868b1a66d4 (HEAD) perf tools: Expose quiet/verbose variables in Makefile.perf
> $ pwd
> /home/andriin/linux/tools/lib/bpf
> $ make
>   gcc -Wp,-MD,/data/users/andriin/linux/tools/lib/bpf/staticobjs/.libbpf.o.d
> -Wp,-MT,/data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o -g
> -O2 -std=gnu89 -Wbad-function-cast -Wdeclaration-after-statement
> -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations
> -Wmissing-prototypes -Wnested-externs -Wno-system-headers
> -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes
> -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat
> -Wno-type-limits -Wstrict-aliasing=3 -Wshadow -Wno-switch-enum -Werror
> -Wall -I/data/users/andriin/linux/tools/lib/bpf/
> -I/data/users/andriin/linux/tools/include
> -I/data/users/andriin/linux/tools/include/uapi
> -I/data/users/andriin/linux/tools/arch/x86/include -fvisibility=hidden
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D"BUILD_STR(s)=#s" -c -o
> /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o libbpf.c
> ^Cmake[2]: *** [/data/users/andriin/linux/tools/build/Makefile.build:86:
> /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o] Interrupt
> make[1]: *** [Makefile:165:
> /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf-in.o]
> Interrupt
> make: *** [Makefile:143: all] Interrupt
> 
> $ git co HEAD~
> Previous HEAD position was f2868b1a66d4 perf tools: Expose
> quiet/verbose variables in Makefile.perf
> HEAD is now at e9cbc854d8b1 perf config: Add a function to set one
> variable in .perfconfig
> $ make
>   CC      /data/users/andriin/linux/tools/lib/bpf/staticobjs/libbpf.o
> ^C
> 
> So, can you please check and fix?

I think I am misunderstanding what you are saying. The patch that we are
discussing on is the patch to fix this? You are showing the output from
the patch that is being fixed in this series.

> 
> Also, looking at your patch:
> 
> a) you removed the `"$(origin V)", "command line"` check from both
> perf and libbpf, so that's not really an equivalent change/behavior
> now

I don't believe it is required to keep that check.

> 
> b) a bit sloppy on assignment:
> 
> +ifeq ($(V),1)
> +  quiet =
> +  Q =
> +else
> +  quiet=quiet_
> +  Q=@
> +endif
> 
> note the spaces around '=', try to keep stuff like this consistent
> (and if this was shell, it would bite you as well)

Yes, I can make that consistent.

> 
> >
> > - Charlie
> >

