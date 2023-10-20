Return-Path: <bpf+bounces-12875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131047D1939
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA81C2826C5
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A01E524;
	Fri, 20 Oct 2023 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E06HzQXh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB3354FF;
	Fri, 20 Oct 2023 22:37:41 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A251391;
	Fri, 20 Oct 2023 15:37:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1caa7597af9so10042915ad.1;
        Fri, 20 Oct 2023 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697841459; x=1698446259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uEORB8UKz3jI9V2Uw1z+6Bx6hXJ3JKuB176UcboEYQQ=;
        b=E06HzQXhAHjuC8/FObDcU8VOUOBJuTI0LhYygq6sxyfgxVaRbY4bNANe+DwRPYXami
         bxy6RoADp2Iwf+Fn+37HOOaZ+N+y/os9VkbH+y2nlhz7Lb3lADSqJFrDlzl7pQm9EPZk
         kCchqO3tU2fCYCX9ROXSOAZj9mKWGyD8PcqTwVL//4jNNYs3TUjFE3dYTwfQijhBBIlT
         UBVdNMZSJGthfix8aXUpeS3W+p+EvsQuqdzSUyuG9kbxCurYNXclIk/gIQ0ubZ3SuRO5
         BCqN88ZQQUN0T1F9HMkUjCvsPZoK7hn8MeFJI++pv9v67TgFZOS4fZLRvaAukNJG8KDj
         pKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697841459; x=1698446259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEORB8UKz3jI9V2Uw1z+6Bx6hXJ3JKuB176UcboEYQQ=;
        b=AXcdki8bJ7C3gWlktjTeDdbwbs6jtpOXF0GE++7ENrzJteIMDGwXtVaEWGV45klQ3f
         sHVCuMppqkawpIL6pphvx84TSCUkHHIT3ax8iGlWM6jmE81F2l7OrN3vAcTgUSkV9MUg
         hd5ET8gOhhn6R5aajI7EWPw+Jl7PBEC+pMBdHATWukSmO2VLZeGpchZ2uq0DPBljTLef
         77jdsKwXVleLL8UMM8H20uFukvo4VnoUDXI7aFAhBIIGPVaEvIYyutL4ReWej3ZgFhso
         IGPR8UUC5jU9ZbXI0c89EthlN4zw2MygXXQ43ZNeTy9kK7XBHoH6++hqL86fgLOBCCQd
         mmJA==
X-Gm-Message-State: AOJu0YxA10QQXvcdm82GYXRzZMufhHqyODorNY8B41MXCHj3WMQlgRQ6
	hGmobMpWRRGxssilavacdxA=
X-Google-Smtp-Source: AGHT+IGDx74zBr973fPDYRRWSy7BhSeYD83FvBZ2Wq/ZqrYovtFkadRQ539xvE9cm7qcKBSc53U5vA==
X-Received: by 2002:a17:902:da83:b0:1c7:4973:7b34 with SMTP id j3-20020a170902da8300b001c749737b34mr3285436plx.50.1697841458914;
        Fri, 20 Oct 2023 15:37:38 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:69fb:d3e1:a14b:fe38])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902bccb00b001c613b4aa33sm1978264pls.287.2023.10.20.15.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:37:38 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:37:34 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <ZTMBLllcYRoIF8E1@surya>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com>
 <ZNZJCWi9MT/HZdQ/@kernel.org>
 <ZNZWsAXg2px1sm2h@kernel.org>
 <ZTGHRAlQtF7Fq8vn@surya>
 <ZTGa0Ukt7QyxWcVy@kernel.org>
 <ZTGyWHTOE8OEhQWq@surya>
 <ZTLlfXM4MhW1GEIJ@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTLlfXM4MhW1GEIJ@kernel.org>

On Fri, Oct 20, 2023 at 05:39:25PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 19, 2023 at 03:48:56PM -0700, Manu Bretelle escreveu:
> > On Thu, Oct 19, 2023 at 06:08:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > I wonder how to improve the current situation to detect these kinds of
> > > problems in the future, i.e. how to notice that some file needed by some
> > > Makefile, etc got removed or that some feature test fails because some
> > > change in the test .c files makes them fail and thus activates fallbacks
> > > like the one above :-\
>  
> > I think it is tricky. Specifically to this situation, some CI could try to build
> > the different combinaison of bpftool and check the features through the build
> > `bpftool --version`.
> 
> Right, if the right packages are installed, we expect to get some
> bpftool build output, if that changes after some patch, flag it.
> 
> Does bpftool have something like:
> 
> ⬢[acme@toolbox perf-tools-next]$ perf version --build-options
> perf version 6.6.rc1.ga8dd62d05e56
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> ⬢[acme@toolbox perf-tools-next]$
> 
> ?
> 

It has

    $ ./tools/bpf/bpftool/bpftool --version -j | jq .features
    {
      "libbfd": false,
      "llvm": true,
      "skeletons": true,
      "bootstrap": false
    }


Maybe Quentin knows of something else.

> > This is actually a test that I run internally to make sure our build has some
> > feature enabled.
> > This is actually tested by bpftool in the GH CI:
> > https://github.com/libbpf/bpftool/blob/main/.github/workflows/build.yaml#L62
>  
> > As a matter of fact, it would not have been detected because that CI uses a
> > different Makefile.feature.
>  
> > Quentin and I were talking offline how we could improve bpftool CI at diff time.
> > This is an example where it would have helped :)
> > 
> > > I'll get this merged in my perf-tools-fixes-for-v6.6 that I'll submit
> > > tomorrow to Linus, thanks for reporting!
> > > 
> > > I'll add your:
> > > 
> > > Reported-by: Manu Bretelle <chantr4@gmail.com>
> > > 
> > > And:
> > > 
> > > Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
> > > 
> > > Ok?
>  
> > SGTM. Thanks for the quick turnaround.
>  
> > Reviewed-by: Manu Bretelle <chantr4@gmail.com>
> 
> You're welcome, thanks for the detailed report, the patch was just sent
> to Linus.
> 
> - Arnaldo

