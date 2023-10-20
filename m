Return-Path: <bpf+bounces-12863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3A7D172A
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9F1F23969
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6022309;
	Fri, 20 Oct 2023 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQAL7fTF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C21DA50;
	Fri, 20 Oct 2023 20:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43957C433C8;
	Fri, 20 Oct 2023 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697834367;
	bh=ZKOUkKpmzLJ4Oe8gj86+MBT/cFfPWTMJrQMWrCMlLRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQAL7fTFj73N9mM17vO7a1XNixX0srzkwvr30qZUA8sPcIXo6f6GD3XCMHBwpvnii
	 +sCJehoG1dQw/quOQxyee96FL6M2Sfzu2A2SNIE5YBMtxC8cVUXjKdMUp2BfLsKycz
	 NPbSxvES6U+nuY//yvUzhucrHcqX0tWP+czV7T39Ra6JuvC2UH9tnGOpPAWOH777JA
	 EoDEsYhfcoq/tdDTk3y8swxIe9nVX7YbJUoS+UpyMVfMsFIdpT4cbjYPks+ZHU/eDv
	 Wwui7oB22qAf88qYV9N6z62ZcvQBdtaV9SfSYGfbDArlDgd5QsOxzbV/wdV8i6sYMw
	 vn6PxhkmQj5jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 24B354035D; Fri, 20 Oct 2023 17:39:25 -0300 (-03)
Date: Fri, 20 Oct 2023 17:39:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Manu Bretelle <chantr4@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v1 1/4] perf parse-events: Remove BPF event support
Message-ID: <ZTLlfXM4MhW1GEIJ@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com>
 <ZNZJCWi9MT/HZdQ/@kernel.org>
 <ZNZWsAXg2px1sm2h@kernel.org>
 <ZTGHRAlQtF7Fq8vn@surya>
 <ZTGa0Ukt7QyxWcVy@kernel.org>
 <ZTGyWHTOE8OEhQWq@surya>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTGyWHTOE8OEhQWq@surya>
X-Url: http://acmel.wordpress.com

Em Thu, Oct 19, 2023 at 03:48:56PM -0700, Manu Bretelle escreveu:
> On Thu, Oct 19, 2023 at 06:08:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > I wonder how to improve the current situation to detect these kinds of
> > problems in the future, i.e. how to notice that some file needed by some
> > Makefile, etc got removed or that some feature test fails because some
> > change in the test .c files makes them fail and thus activates fallbacks
> > like the one above :-\
 
> I think it is tricky. Specifically to this situation, some CI could try to build
> the different combinaison of bpftool and check the features through the build
> `bpftool --version`.

Right, if the right packages are installed, we expect to get some
bpftool build output, if that changes after some patch, flag it.

Does bpftool have something like:

⬢[acme@toolbox perf-tools-next]$ perf version --build-options
perf version 6.6.rc1.ga8dd62d05e56
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
⬢[acme@toolbox perf-tools-next]$

?

> This is actually a test that I run internally to make sure our build has some
> feature enabled.
> This is actually tested by bpftool in the GH CI:
> https://github.com/libbpf/bpftool/blob/main/.github/workflows/build.yaml#L62
 
> As a matter of fact, it would not have been detected because that CI uses a
> different Makefile.feature.
 
> Quentin and I were talking offline how we could improve bpftool CI at diff time.
> This is an example where it would have helped :)
> 
> > I'll get this merged in my perf-tools-fixes-for-v6.6 that I'll submit
> > tomorrow to Linus, thanks for reporting!
> > 
> > I'll add your:
> > 
> > Reported-by: Manu Bretelle <chantr4@gmail.com>
> > 
> > And:
> > 
> > Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
> > 
> > Ok?
 
> SGTM. Thanks for the quick turnaround.
 
> Reviewed-by: Manu Bretelle <chantr4@gmail.com>

You're welcome, thanks for the detailed report, the patch was just sent
to Linus.

- Arnaldo

