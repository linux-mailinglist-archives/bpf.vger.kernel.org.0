Return-Path: <bpf+bounces-12758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CF7D04FE
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B216282302
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6E42936;
	Thu, 19 Oct 2023 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XIjimzjD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489D19440
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 22:50:28 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340E115
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 15:50:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40837ebba42so1550825e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697755822; x=1698360622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jdr6puVGLRO0RmMF34iaJR4HMguVgSrk1Dz2ZWASTGA=;
        b=XIjimzjDpnxFkaDMIpwNwEr9TBnrQhlvBeA+DYXh+sBfpMU/2COWtKKe9YdlUxZk/9
         PLW5hOPhZV1t5YEKNtMBte5E5dbisvOadWLh9wFQwxfAjxlJGl2WgZsFFeF3Mbce9vzI
         9tMUvqCaLhJnC2cHpKghiEuERuN+vn9ALOEZ8kEK0cNwYz5/ofQ6+Cq6xKtjvk41EoUL
         czXECoBPGw6/eSj9UFV+b5wXUy5kPlw3cMeuTFoJwZQJA4QRADN2tDnPT0o3ExjIwGHY
         XKXWffiyMaCzMaStzYITB6ZOR5G0rGFdmLTLuRpcCLNJM3A6JAB5FMrJ5++BH3m8ad4w
         4qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697755822; x=1698360622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdr6puVGLRO0RmMF34iaJR4HMguVgSrk1Dz2ZWASTGA=;
        b=j0nNUOQm/a23iMdsx9xFGMN+J6wSPj3nXMG+iJHY1nUo0kq0MioxZIvTP1xVpmtev0
         Ks+zG4kmTTtYyY8JYH8cZuu83l9KmufKbadcfWDIsdlWM2Ruu2nlnosqY3RkbzTBZrSU
         /pCp3XQYIH08YtGJ5ujPhwPe4omjfL43mtrLl/abzujDEVBAIZq+aO6s9wk5er+KOsOh
         BnHbvhBqbTGSDTTym1ozqvYt1MSzQHvnbnXShFsVEsxhQqqYeAPXRsJ+tLV8UKWgW3+7
         oa2v2Zr4S+2UUv+8XGop79+JNwuOHspO4RygYM6p6DMj4hTyGmAXR8FQ6mkLiBGntY9C
         Fgxw==
X-Gm-Message-State: AOJu0YxDu1Lbz/XoQ/7aprzIvmRaGKrR88RW2DFw92F5yXl+ZDsA+Ovw
	lLQgxbuzpJhJZNqz2t7/uagZDg==
X-Google-Smtp-Source: AGHT+IFlk3PHTvUyJ39TE4N+dMbY5ycoWERcj/slQTNy/uDLm1uVMvps5E2gM8CZ+Ywfb6zET7o6gw==
X-Received: by 2002:a05:600c:154e:b0:401:73b2:f043 with SMTP id f14-20020a05600c154e00b0040173b2f043mr175919wmg.1.1697755822117;
        Thu, 19 Oct 2023 15:50:22 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a8cd:a90a:ba21:5ae1? ([2a02:8011:e80c:0:a8cd:a90a:ba21:5ae1])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00326f0ca3566sm341243wrm.50.2023.10.19.15.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:50:21 -0700 (PDT)
Message-ID: <a0a7b15e-5b43-4aa3-8ba8-291e1dbd2890@isovalent.com>
Date: Thu, 19 Oct 2023 23:50:20 +0100
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
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
 <CAEf4BzYC01Uvj5R+eipu8wmWpNH6K_=_ptj-Wxezdk_O7AFAyA@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYC01Uvj5R+eipu8wmWpNH6K_=_ptj-Wxezdk_O7AFAyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/10/2023 23:47, Andrii Nakryiko wrote:
> On Thu, Oct 19, 2023 at 2:17 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> When removing the BPF event for perf a feature test that checks if the
>> llvm devel files are availabe was removed but that is also used by
>> bpftool.
>>
>> bpftool uses it to decide what kind of disassembly it will use: llvm or
>> binutils based.
>>
>> Removing the tools/build/feature/test-llvm.cpp file made bpftool to
>> always fallback to binutils disassembly, even with the llvm devel files
>> installed, fix it by restoring just that small test-llvm.cpp test file.
>>
>> Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
> 
> Should we route this through the bpf-next tree to get the fix for
> bpftool into Github mirror ASAP?

It shouldn't be necessary. The GitHub mirror for bpftool uses its own
feature detection mechanism, and is not affected here. This patch won't
even make it to the mirror.

Quentin

