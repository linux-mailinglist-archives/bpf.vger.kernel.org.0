Return-Path: <bpf+bounces-12755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186C7D049A
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33211C20F40
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149342905;
	Thu, 19 Oct 2023 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="dM8DfLrQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA0405E6
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 22:01:36 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59D116
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 15:01:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507cee17b00so178598e87.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697752893; x=1698357693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVH7g5Xn7KERhNbwCPYA3chPVbA58wuAlRpGYKpj+Ag=;
        b=dM8DfLrQRsUlwILnQznK2dZd+bBw2FtHHDC/J5Pc/0SXxpdv2h0eg/Z0buMdSSyCz4
         KxUSKjsXNFqOJ6JAAvwwIueelMMRmunjcM1WEUGyHOzWsotdopnCl45VXg8gPv9lsKts
         DicbsMGt/obSa6o/vpKZ5du0KSqpzFY/1ruetv4sJX7Z1iiNAzbOhn5NWb7Kf85mZjpV
         CTTFFBSBYgsoe691WM8H+0fKS+IHoiAZOg3KY6uoRCvCo5uQ6g4NNz9OOqGtZu0nUTaD
         3iO6BsvlkQScJkbch9ec8sBvPdwM+xziFmDsX/1ZhYH9h7eCmIejZiJ7AeS03JbChj/v
         VeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752893; x=1698357693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVH7g5Xn7KERhNbwCPYA3chPVbA58wuAlRpGYKpj+Ag=;
        b=MZywRU5GuvZjBEYI3PA4AVPVC2tZTB29nP9ru11T7avI9JY8nAmXuMmeF0LAqOW2OQ
         KhiumW4HIUv3/DPNbBmTFYqeTq22i4CGqTLcFwvsFy4UVSupitP6Uv/LSzrUTa93DFxn
         hlwhUwfDehtt2JwxPfC/GZERp+MCPLIGjBH6gwTUQv79amjo1AlyeROsBdKU3NbLGd8v
         xPHRSSFQQbfqYt6trH1nug8O/coUK4h0jotdZP/7rmi55zegOZ7fQfD0nur8YB2phAqD
         hAPCqhbWE1D3nODZLgFDl5uMAYFDz4lFPH8PsvnJt2T0ct9wL3UlUFcREP8OgtvPOY8t
         O9Bg==
X-Gm-Message-State: AOJu0Yxfo16UUoczMTUHwTkzIMMpQPHr5gl2d3ugxcaDASUXZh+Pd2t9
	uFEgGd5ltSwVWddXNcZTRY2DRA==
X-Google-Smtp-Source: AGHT+IGr1MrtHZ96/nhgRMar71OOUSfXGMOyZYoXUPX+20SnusubhbiGhasbj3+M0aAya7InYsY03A==
X-Received: by 2002:ac2:488e:0:b0:503:b65:5d95 with SMTP id x14-20020ac2488e000000b005030b655d95mr5431lfc.6.1697752892966;
        Thu, 19 Oct 2023 15:01:32 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a8cd:a90a:ba21:5ae1? ([2a02:8011:e80c:0:a8cd:a90a:ba21:5ae1])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b0032dc24ae625sm289631wrr.12.2023.10.19.15.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:01:32 -0700 (PDT)
Message-ID: <d1fa32d7-4b1a-4451-b717-e91f75f3c322@isovalent.com>
Date: Thu, 19 Oct 2023 23:01:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools build: Fix llvm feature detection, still used
 by bpftool
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Manu Bretelle <chantr4@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Andrii Nakryiko <andrii@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Carsten Haitzler <carsten.haitzler@arm.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Fangrui Song <maskray@google.com>,
 He Kuang <hekuang@huawei.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Leo Yan <leo.yan@linaro.org>, llvm@lists.linux.dev,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria
 <ravi.bangoria@amd.com>, Rob Herring <robh@kernel.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Tom Rix <trix@redhat.com>,
 Wang Nan <wangnan0@huawei.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Yang Jihong <yangjihong1@huawei.com>, Yonghong Song <yhs@fb.com>,
 YueHaibing <yuehaibing@huawei.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org
References: <ZTGc8S293uaTqHja@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZTGc8S293uaTqHja@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2023 22:17, Arnaldo Carvalho de Melo wrote:
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

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks Arnaldo, Manu!

