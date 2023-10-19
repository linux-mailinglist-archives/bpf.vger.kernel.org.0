Return-Path: <bpf+bounces-12759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75E7D0503
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC511C20E67
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF942BF3;
	Thu, 19 Oct 2023 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqUlDcOn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE819447;
	Thu, 19 Oct 2023 22:52:21 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3298;
	Thu, 19 Oct 2023 15:52:19 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57ad95c555eso115883eaf.3;
        Thu, 19 Oct 2023 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697755939; x=1698360739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw+NhNs7Kd8Sn7Jgw+a43o7ZL5jXRR/xNu8rKmPPZ40=;
        b=cqUlDcOn8B2qnMUm367lem/JMGujVIYophyIKNq4aMiXtD9SllwQvbetUbydstn//8
         ufOcYr7Q6jGEB1uFhd6xR/RilEZGFKExrP+XabRSdG/v0KRLY7OQoDRk3K0TVsLtEsgC
         pir6osLTnzboHD8z37Ih0WNL/OjzI6wGwmvwtmieNFZ2P0amKhKOhfdNAbbmYQJvJwh4
         QRqOzVF0xvO3q7C4NZVwggTEtJinGXcUPmyNytBqrVrMl39DGMNGu7gNUVojaYjA4QZG
         2oFE8bjTV9SyxxCt6LdvvYzcdd4OVk+gJe2ySANO/8CZnVG9AZNhYQcVj5LFT4zCDFym
         Uqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697755939; x=1698360739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw+NhNs7Kd8Sn7Jgw+a43o7ZL5jXRR/xNu8rKmPPZ40=;
        b=vG40LavUgaRsEZq88dlRznRPSkgk/EfTgieDjRjJbjWycsHFP5GLsyUwBWHOGRVdeE
         n6A9mzhcf6b0EdUk8LT8etvCLo85EvqT8ouFOZZYP6I2I6uGR+2hBfEPJCU3mOBTIC1K
         I+tfwqv4XRtMWrvufsidyzCsxFdvbFAZeSC15Hge3RY5csyYBb5jIwdkxb+dngs/94cP
         13QQ+tzt7R4rToZw7Pq27fBb4mv+LPwPAGHH0PD5MgRsVO4CtluH8vELz8hoSGukEU46
         fzMN5rM9P3ednzmgMSS2a0SxSW1gc8hIQYRf/hJy93rEfyu8Lrx3v9Rx0sdZFY758fvC
         bHJg==
X-Gm-Message-State: AOJu0YxHBDqIa7hmwCEjdBIPcPwrtlKfs1Qvvc5t8BXQeTzfr21xzSIu
	aWZvwpiUkrDU1O6LMzLRlzg=
X-Google-Smtp-Source: AGHT+IFYnyvkEDIVfG+6uXEDLM3MsKx6hhZ2KQYVQfuI264k9/7LuO5GxhihGAcLJrxNg6KXaIO4ZQ==
X-Received: by 2002:a05:6358:724e:b0:166:dc89:8c92 with SMTP id i14-20020a056358724e00b00166dc898c92mr108490rwa.26.1697755938799;
        Thu, 19 Oct 2023 15:52:18 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:b14a:c750:3938:f592])
        by smtp.gmail.com with ESMTPSA id x26-20020aa79ada000000b006be5af77f06sm289689pfp.2.2023.10.19.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 15:52:18 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:52:15 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Fangrui Song <maskray@google.com>, He Kuang <hekuang@huawei.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	llvm@lists.linux.dev, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Rob Herring <robh@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
	Tom Rix <trix@redhat.com>, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>, Yonghong Song <yhs@fb.com>,
	YueHaibing <yuehaibing@huawei.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix llvm feature detection, still used
 by bpftool
Message-ID: <ZTGzHzhZwJv0+xBH@surya>
References: <ZTGc8S293uaTqHja@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTGc8S293uaTqHja@kernel.org>

On Thu, Oct 19, 2023 at 06:17:37PM -0300, Arnaldo Carvalho de Melo wrote:
> When removing the BPF event for perf a feature test that checks if the
> llvm devel files are availabe was removed but that is also used by
> bpftool.
> 
> bpftool uses it to decide what kind of disassembly it will use: llvm or
> binutils based.
> 
> Removing the tools/build/feature/test-llvm.cpp file made bpftool to
> always fallback to binutils disassembly, even with the llvm devel files
> installed, fix it by restoring just that small test-llvm.cpp test file.
> 
> Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
> Reported-by: Manu Bretelle <chantr4@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Carsten Haitzler <carsten.haitzler@arm.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: He Kuang <hekuang@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: llvm@lists.linux.dev
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Cc: Yang Jihong <yangjihong1@huawei.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Link: https://lore.kernel.org/lkml/ZTGa0Ukt7QyxWcVy@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/feature/test-llvm.cpp | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 tools/build/feature/test-llvm.cpp
> 
> diff --git a/tools/build/feature/test-llvm.cpp b/tools/build/feature/test-llvm.cpp
> new file mode 100644
> index 0000000000000000..88a3d1bdd9f6978e
> --- /dev/null
> +++ b/tools/build/feature/test-llvm.cpp
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "llvm/Support/ManagedStatic.h"
> +#include "llvm/Support/raw_ostream.h"
> +#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)
> +
> +#if NUM_VERSION < 0x030900
> +# error "LLVM version too low"
> +#endif
> +int main()
> +{
> +	llvm::errs() << "Hello World!\n";
> +	llvm::llvm_shutdown();
> +	return 0;
> +}

Thanks for the quick turnaround!


