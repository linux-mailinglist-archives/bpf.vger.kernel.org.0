Return-Path: <bpf+bounces-6511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DE76A6FB
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D1F1C20DF3
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16954110D;
	Tue,  1 Aug 2023 02:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FC7E;
	Tue,  1 Aug 2023 02:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EBCC433C7;
	Tue,  1 Aug 2023 02:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690857000;
	bh=JqTpuojuSmByA27/5WGpMBYobl6c+pIwWwOPzzkyoSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M59G1iH5RSuy/jK4mIM5hLWCgtxG6QNZHLZsxbkscK3O2uHaIhfgKrCYkun1biidL
	 h5BVJLdxwGiZox9SC4yuEbTvH+z0EzZiSzeNeGDkcpQtmDOGuz18ed6j+CDmBfYULM
	 FSWt+bWY62WmfOHlPVtv3pDus3nXq+Hv2dKdKaoX9WZClxjocAw8mWvKBuben0+vgo
	 CfssLd1IF/jInUY88692Dm3tGAJ3uXgHOW2UPvnhH5/PXNJIXRegBmf7wvWvoy10m2
	 gbzQd+7l7Xyzs++sY+u2JtDEluqmu65wPHHY8br4vZKr240aEYaxhq0CKW86BBwYOu
	 KKjk1TWfinwPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C752240096; Mon, 31 Jul 2023 23:29:56 -0300 (-03)
Date: Mon, 31 Jul 2023 23:29:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Rob Herring <robh@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 4/6] perf build: Disable fewer flex warnings
Message-ID: <ZMhuJK/5+pMThsFd@kernel.org>
References: <20230728064917.767761-1-irogers@google.com>
 <20230728064917.767761-5-irogers@google.com>
 <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com>
 <ZMPJym7DnCkFH7aA@kernel.org>
 <ZMPKekDl+g5PeiH8@kernel.org>
 <CAP-5=fX2LOdd_34ysAYYB5zq5tr7dMje35Nw6hrLXTPLsOHoaw@mail.gmail.com>
 <ZMQEfIi/BYwpDIEB@kernel.org>
 <ZMQMQoCtBytgwB4i@kernel.org>
 <CAP-5=fUOD4hgQBmXjQh0HujO_39zQQhv_Wv5oirgAC4N8Ao1nw@mail.gmail.com>
 <ZMgkthavch7x/z+0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgkthavch7x/z+0@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Jul 31, 2023 at 06:16:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 28, 2023 at 12:05:56PM -0700, Ian Rogers escreveu:
> > On Fri, Jul 28, 2023, 11:43 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > I haven't checked, lemme do it now.
> 
> > > It comes directly from flex's m4 files:
> 
> > > https://github.com/westes/flex/blob/master/src/c99-flex.skl#L2044
> 
> > > So I'll keep the -Wno-misleading-indentation, ok?
>  
> > Makes sense, yes.
> 
> continuing, changed the version check to:
     
>     Committer notes:
>     
>     Added this to the list of ignored warnings to get it building on
>     a Fedora 36 machine with flex 2.6.4:
>     
>       -Wno-misleading-indentation
>     
>     Noticed when building with:
>     
>       $ make LLVM=1 -C tools/perf NO_BPF_SKEL=1 DEBUG=1
>     
>     Take two:
>     
>     We can't just try to canonicalize flex versions by just removing the
>     dots, as we end up with:
>     
>             2.6.4 >= 2.5.37
>     
>     becoming:
>     
>             264 >= 2537
>     
>     Failing the build on flex 2.5.37, so instead use the back to the past
>     added $(call version_ge3,2.6.4,$(FLEX_VERSION)) variant to check for
>     that.
>     
>     Making sure $(FLEX_VERSION) keeps the dots as we may want to use 'sort
>     -V' or something nicer when available everywhere.

Please take a look at the tmp.perf-tools-next on the perf-tools-next git
tree, so far it passed on:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.10/perf/perf-6.5.0-rc2.tar.xz
[perfbuilder@five ~]$ time dm
   1   131.37 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18) , clang version 15.0.7 (Red Hat 15.0.7-1.module_el8.8.0+3466+dfcbc058) flex 2.6.1
   2   133.63 almalinux:9                   : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.7 (Red Hat 15.0.7-2.el9) flex 2.6.4
   3   151.31 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
   4   148.73 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   5   126.35 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   6   125.43 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   7   143.12 alpine:edge                   : Ok   gcc (Alpine 13.1.1_git20230520) 13.1.1 20230520 , Alpine clang version 16.0.4 flex 2.6.4
   8   102.10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
   9    95.36 amazonlinux:2023              : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  10    96.15 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  11   118.48 archlinux:base                : Ok   gcc (GCC) 12.2.0 , clang version 14.0.6 flex 2.6.4
  12   106.42 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18) , clang version 15.0.7 (Red Hat 15.0.7-1.module_el8.8.0+1258+af79b238) flex 2.6.1
  13   127.88 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 13.1.1 20230720 releases/gcc-13.1.0-353-g9aac37ab8a , clang version 16.0.6 flex 2.6.4
  14    88.12 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1 flex 2.6.4
  15   113.56 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
  16   122.58 debian:12                     : Ok   gcc (Debian 12.2.0-14) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
  17   130.89 debian:experimental           : Ok   gcc (Debian 12.3.0-5) 12.3.0 , Debian clang version 14.0.6 flex 2.6.4
  18    23.75 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)  flex 2.6.1
  19    23.52 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)  flex 2.6.1
  20    24.66 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)  flex 2.6.1
  21    26.12 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)  flex 2.6.1
  22    26.06 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)  flex 2.6.4

Tomorrow I'll go back to perf-tools, to get what sat on linux-next
pending-fixes and a few other fixes (the one reported by Thomas, etc)
to send to Linus for v6.5.

- Arnaldo

