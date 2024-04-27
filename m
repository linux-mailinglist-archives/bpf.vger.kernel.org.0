Return-Path: <bpf+bounces-28031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D68B48C9
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 00:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB271C20B98
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E45146D47;
	Sat, 27 Apr 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzCrTV7t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7E1465A7
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714255517; cv=none; b=pfmLlth8tplnCtuSSd3crsRc2n/a620BhVYXhWLnA7/yPAGdjpZw1+ofMWL5uvDWMSR4eEI/3U2Sq70l2CUwI1WaoP0CZYarmXNjOdHk3iDznCO406GTsPGMtJzc/l/DMbp+4pOsUUQVMIS9Fs73NLTYYx3R7QhnOYkNXLEUC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714255517; c=relaxed/simple;
	bh=dL4ZiQXnuAbCs7nRZSmWKa0wsJGikLg3kAIMUDVMbJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUUhWBGql+ZQWRD2Qz08yceee5RkRKY9Sqn0W4zAXepxTgsUQl80bjvCG5I1lBsQHt150Vn2uvC+mTHVUISThrD2qOuVQnbD41VrZlRGLGgpfvmLBMEiXZkbjFlyFodzavn3Zv8mS1L5036aSg2hZA0uP7VALSDMoqBgbecpf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzCrTV7t; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36b3738f01cso131955ab.0
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714255515; x=1714860315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev2ja+lSmiOzY64QoBLLWUXCoL4iQJQ9t2WV8bOp35Q=;
        b=lzCrTV7tx+S+YY8j2c3WLhJ0MIBL1KIYXRAeBPSNFSRpgdFue2ZzHvRkyfsOtk6jRw
         Bu/BHoHjk/q9R1lN9Ft9W0JIdBo3B5EujiR8VBdw9Qkf7BdfiDQaqthKTmWraCqLzPFc
         s60sT2LaZ1UCRC4UK0ezxh7zuSvmoHkcgXCe3nNPPsqkuXBLkoaOKPhYWHrV5rz9B5hX
         xkyJKobH4ha2Xqonci5hPdowEQKII7yzIDQtjCSr6ia6pvQ4vkn8kxaHaKjmgpo0fY4P
         wUSiGWbW8tpR/Ps0wU/1Dovskya9Fz4pUS+Z9VUhDMVWvHIoPUt1qfKpeyzlxpwj24tx
         PMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714255515; x=1714860315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev2ja+lSmiOzY64QoBLLWUXCoL4iQJQ9t2WV8bOp35Q=;
        b=pwNqSaHYx84UoOt7DftOlNr8hmguxH5XuZanu7NGpYkqmuXElNjaeC6H7bpdLZCkrh
         WbSLvG5QKNHzs2nwmmOtwhS+JfNRj6mKkWqWcDQsSTGfVlutCCZYpNBpksAAVC4DuBXR
         4sFPNmsd13qFj/IP5oLy78c6I5ukhsqQYxI15cvGAZrs1nv8Wm6l6lUygukreG8cS3MG
         9tP5ye+cUMFZGU7hAa1yCtldDqNtWbezHsw8tmqRKU6jGqTtzN3gegMVUDhS5Okmq3h1
         QjbdwXdzlLaAtdBiDuavOgfXXC8x8mnZrTr0fT92fKPVkBqtuJ1L9fQm0ObsaQWWLSS1
         41Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXoa9BQVY0kNucJg7kNoYJ3XvWSqFYnIf5IgZ4f0t7ciDPbUsgjar56DrChs+B5xKf3ZIJw0oPz1yTjna7JJ88hSLRO
X-Gm-Message-State: AOJu0YwRjuH6dsnidbIIoCZU3xx+uMckY3ZTeadBsZO4Y3KBvzbxhD7B
	zCDnHN2V1Fbf1PY9k7mWcKSDo7FtFNQ+anilmbb5zfC8oHDDT6Xwkvss0obhzlQKEVFMUu79/nm
	ZDQp8/qVzAcJm6DgtHCg+AtwSjwQPkpxviAvU
X-Google-Smtp-Source: AGHT+IEO3FABo7bJtP1TZzhuy5KcTdsQQuF8Ot6ogc+4XIRMXJdBlJnjK+wLjTHicCMFRokmznKYolzRrUz6TLlZywU=
X-Received: by 2002:a92:cb52:0:b0:36c:38c9:c1ab with SMTP id
 f18-20020a92cb52000000b0036c38c9c1abmr210173ilq.26.1714255515191; Sat, 27 Apr
 2024 15:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com> <20240416061533.921723-12-irogers@google.com>
 <ZixWfypP4FtKgv0F@x1> <ZixWn-ZCBpwH_2xp@x1>
In-Reply-To: <ZixWn-ZCBpwH_2xp@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 27 Apr 2024 15:05:01 -0700
Message-ID: <CAP-5=fW-j03Rg9LyJqGJvU9w2Sm5hA+OcOAD=BCUbswKUh7yoA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] perf parse-events: Improve error message for bad numbers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 6:36=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Apr 26, 2024 at 10:36:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Apr 15, 2024 at 11:15:27PM -0700, Ian Rogers wrote:
> > > Use the error handler from the parse_state to give a more informative
> > > error message.
> > >
> > > Before:
> > > ```
> > > $ perf stat -e 'cycles/period=3D99999999999999999999/' true
> > > event syntax error: 'cycles/period=3D99999999999999999999/'
> > >                                   \___ parser error
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf stat [<options>] [<command>]
> > >
> > >     -e, --event <event>   event selector. use 'perf list' to list ava=
ilable events
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf stat -e 'cycles/period=3D99999999999999999999/' true
> > > event syntax error: 'cycles/period=3D99999999999999999999/'
> > >                                   \___ parser error
> > >
> >
> > This ended up in perf-tools-next, will have to look at what this proble=
m
> > is:
> >
> >    9    11.46 amazonlinux:2                 : FAIL gcc version 7.3.1 20=
180712 (Red Hat 7.3.1-17) (GCC)
> >      yy_size_t parse_events_get_leng (yyscan_t yyscanner );
> >                ^~~~~~~~~~~~~~~~~~~~~
> >     util/parse-events.l:22:5: note: previous declaration of 'parse_even=
ts_get_leng' was here
> >      int parse_events_get_leng(yyscan_t yyscanner);
> >          ^~~~~~~~~~~~~~~~~~~~~
> >      yy_size_t parse_events_get_leng  (yyscan_t yyscanner)
> >                ^~~~~~~~~~~~~~~~~~~~~
> >     util/parse-events.l:22:5: note: previous declaration of 'parse_even=
ts_get_leng' was here
> >      int parse_events_get_leng(yyscan_t yyscanner);
> >          ^~~~~~~~~~~~~~~~~~~~~
> >     make[3]: *** [util] Error 2
> >
> >
> > Unsure if this will appear on the radar on other distros, maybe this is
> > just something that pops up with older distros...
> >
> > Ran out of time today...
>
> Context:
>
> perfbuilder@number:~$ export BUILD_TARBALL=3Dhttp://192.168.86.42/perf/pe=
rf-6.9.0-rc5.tar.xz
> perfbuilder@number:~$ time dm
>    1   102.33 almalinux:8                   : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-20) , clang version 16.0.6 (Red Hat 16.0.6-2.module_el8.9=
.0+3621+df7f7146) flex 2.6.1
>    2   102.44 almalinux:9                   : Ok   gcc (GCC) 11.4.1 20230=
605 (Red Hat 11.4.1-2) , clang version 16.0.6 (Red Hat 16.0.6-1.el9) flex 2=
.6.4
>    3   124.34 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git=
20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
>    4   109.42 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git=
20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
>    5    90.08 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git=
20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
>    6    84.85 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git=
20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
>    7    94.18 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_git=
20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
>    8    95.45 alpine:edge                   : Ok   gcc (Alpine 13.2.1_git=
20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
>    9    11.46 amazonlinux:2                 : FAIL gcc version 7.3.1 2018=
0712 (Red Hat 7.3.1-17) (GCC)
>      yy_size_t parse_events_get_leng (yyscan_t yyscanner );
>                ^~~~~~~~~~~~~~~~~~~~~
>     util/parse-events.l:22:5: note: previous declaration of 'parse_events=
_get_leng' was here
>      int parse_events_get_leng(yyscan_t yyscanner);
>          ^~~~~~~~~~~~~~~~~~~~~
>      yy_size_t parse_events_get_leng  (yyscan_t yyscanner)
>                ^~~~~~~~~~~~~~~~~~~~~
>     util/parse-events.l:22:5: note: previous declaration of 'parse_events=
_get_leng' was here
>      int parse_events_get_leng(yyscan_t yyscanner);
>          ^~~~~~~~~~~~~~~~~~~~~
>     make[3]: *** [util] Error 2
>   10    88.41 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230=
605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn20=
23.0.1) flex 2.6.4
>   11    89.72 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221=
121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn20=
23.0.2) flex 2.6.4
>   12   115.65 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230=
801 , clang version 17.0.6 flex 2.6.4
>   13    93.87 centos:stream                 : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-21) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8+7=
67+9fa966b8) flex 2.6.1

Did RedHat do value add on flex output? yyget_leng is documented to
have an int return type:
https://github.com/westes/flex/blob/master/doc/flex.texi#L4613
This patch just adds a forward declaration in order to use it in a
helper function.

Thanks,
Ian

