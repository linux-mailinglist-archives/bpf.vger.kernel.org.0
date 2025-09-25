Return-Path: <bpf+bounces-69714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B82B9F4F2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 14:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E38084E1FF3
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2B1AA7BF;
	Thu, 25 Sep 2025 12:43:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A014B953;
	Thu, 25 Sep 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804201; cv=none; b=CvLsAV8VtFLZeAXLIzMGT4tEZpANwi/CYBs1BM/D2EkaFb/7VnMS7AUw4cc6UA4NJICMcVL0i8bfn99ClRNyw+3R3b3kLMW6S7owKofeHz9dr95Ce7NZG5thLF1VvPSbrlRj1pOIUX3hJsOIyheZ9tWDA7c9qE0x0OzWH7Jzw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804201; c=relaxed/simple;
	bh=gcHZwcDMSIGu3KYmFLAtCFzPUJCXH64+5aDEv1Ci6FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UET+8kSKiPVrIr4Ut1l+pQEmo82gP29dv9fW5kR6XOsIN5w1JUIYT+RG3p5AGQzQYza+bSGPNg55ndIxUS6TjrOdQcqnc4hgx6q2y477W9PCY8kFRHKbR1Y4339ymbNN6szDfyneb0sQtOof2hvvW3ncYV2JzLfecFcGbm3rGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DAD91692;
	Thu, 25 Sep 2025 05:43:10 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0841B3F694;
	Thu, 25 Sep 2025 05:43:18 -0700 (PDT)
Date: Thu, 25 Sep 2025 13:43:16 +0100
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 3/8] bpftool: Conditionally add -Wformat-signedness flag
Message-ID: <20250925124316.GA7985@e132581.arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
 <20250925-perf_build_android_ndk-v1-3-8b35aadde3dc@arm.com>
 <52fe87ef-0797-4cf1-9e70-dc218f904e77@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fe87ef-0797-4cf1-9e70-dc218f904e77@kernel.org>

On Thu, Sep 25, 2025 at 11:42:39AM +0100, Quentin Monnet wrote:
> 2025-09-25 11:26 UTC+0100 ~ Leo Yan <leo.yan@arm.com>
> > clang-18.1.3 on Ubuntu 24.04.2 reports warning:
> > 
> >   warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
> > 
> > Conditionally add the option only when it is supported by compiler.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> 
> Hi, how annoying is this warning?

Not too bad, it prints out 5~6 times warnings (see the build log below).
Though the warnings are a bit noisy, they does not break the build.

> I'm asking because as far as I
> understand, the option has been introduced in LLVM 19.1.0 [0] - the
> latest being 21.1.0 already - so we won't need this check once distros
> have transitioned, and I'm a bit reluctant to add it.

I agree the warning likely won't affect distros, as package maintainers
will hide it. But it can annoy _paranoid_ developers in day-to-day
builds ;)

As the warning doesn't block anything, so I am fine with not merging
this patch.

Thanks,
Leo

> [0]
> https://github.com/llvm/llvm-project/commit/ea92b1f9d0fc31f1fd97ad04eb0412003a37cb0d


---8<---

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ OFF ]
...                                  libcap: [ on  ]
...                                  libbfd: [ OFF ]
...                          libbfd-liberty: [ OFF ]
...                        libbfd-liberty-z: [ OFF ]
...                  disassembler-four-args: [ OFF ]
...                disassembler-init-styled: [ OFF ]
...                             libelf-zstd: [ o
  MKDIR   /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
  MKDIR   /build/util/bpf_skel/.tmp/bootstrap/libbpf/
  MKDIR   /build/util/bpf_skel/.tmp/bootstrap/
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
1 warning generated.
  GEN     /build/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
  INSTALL /build/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
  INSTALL libbpf_headers
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/features.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_iter.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_relocate.o
  LD      /build/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK    /build/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
  CC      /build/util/bpf_skel/.tmp/bootstrap/main.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/common.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/json_writer.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/gen.o
  CC      /build/util/bpf_skel/.tmp/bootstrap/btf.o
warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]warning:
unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.
  LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool

