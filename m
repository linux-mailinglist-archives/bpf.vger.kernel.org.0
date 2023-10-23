Return-Path: <bpf+bounces-12984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132487D2D83
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975EDB20CCB
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A612B71;
	Mon, 23 Oct 2023 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="QWfXkwqL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072920F3
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:01:41 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC7D79
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:01:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1687880f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698051696; x=1698656496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mf+nKan86pP9YxvqNtFB3ioqbhRgtPm5GTm7s8KJe0I=;
        b=QWfXkwqLCedWOyUHj73NFxHU0uVI8X9lDly8xxsv/mWpNgdxIkSjrHEtMvSVOGLohX
         tjhuVyngYNeVeyhQ3yfLJXiT+G559gciUv9pwrF8aslWiX/v3zcgGcp/LQr/rmDeqsVE
         G+O1144nSgElor2Df5Fb336SW5g8+FKdreYn5UgSldu/i1Xwd3h3gx0fJqRbjQmUwklp
         sYm4vYigJ91xTgSJtC4fKGwKdTPAWf88dn8QGoZgTho7g5yHbnkYAInNlshLLVxTuMqa
         3SwbfNthaALXa6MTU0S8Sa7P7uVRNJzWyyBLEqQ2HpZQ4URtdTs61RHwS3bqHqbhrxnj
         R3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051696; x=1698656496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf+nKan86pP9YxvqNtFB3ioqbhRgtPm5GTm7s8KJe0I=;
        b=DTaKjhoRdftgNdkYWW8bqSvwsGERlY520Ty6N/+D/TZ8mulspnKjlILU0Ilz0ToHXt
         TzALtSY6ZL5AMOTpWTbFIVLQzdBSVze0kl7dFG2vgNI3kBopKkknBuHCUz01M+rA/Pxz
         p9xbG+GQgRvvZsPWxjqzwl3eSbplLPBcd1HlrtJ3bmLDUqGFdgZCBafNzSWmUQX7OYrC
         gQz9pk3XLJg82cTGjOMsg8ZfjAj6MZbilg5XKCJnM9/CQlrVI4LzW7Egrqnl+nYdPJnk
         Mg8in5j3rHULLzVHiJ4Xa+gTjVN6fpsjuA5yU2f86KJjXsVk6cs/0jcc5qBrKAchlado
         FZKw==
X-Gm-Message-State: AOJu0YxGyhktf628KKO1EI0b9CGrESHV1mS8+Zf3vCmpPpgZ4s66Vet0
	VdXMC1KZcknZTmVN4FYpBQbRNw==
X-Google-Smtp-Source: AGHT+IGpWjcofGaS/GHzmAITo9rLeiMobJbEAZDzaHpa22JV7SGE2SfbIE4YVP8+tHl7DnA+Q7wPRA==
X-Received: by 2002:adf:e487:0:b0:32d:84a5:bf5f with SMTP id i7-20020adfe487000000b0032d84a5bf5fmr7402288wrm.28.1698051695873;
        Mon, 23 Oct 2023 02:01:35 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:68fb:b41e:9c58:360c? ([2a02:8011:e80c:0:68fb:b41e:9c58:360c])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b00327cd5e5ac1sm7371699wrw.1.2023.10.23.02.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 02:01:35 -0700 (PDT)
Message-ID: <435424a7-efba-4438-917c-61823c374770@isovalent.com>
Date: Mon, 23 Oct 2023 10:01:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] perf parse-events: Remove BPF event support
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Fangrui Song <maskray@google.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Carsten Haitzler <carsten.haitzler@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>,
 James Clark <james.clark@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
 Wang ShaoBo <bobo.shaobowang@huawei.com>, YueHaibing
 <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
 Brendan Gregg <brendan.d.gregg@gmail.com>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com> <ZNZJCWi9MT/HZdQ/@kernel.org>
 <ZNZWsAXg2px1sm2h@kernel.org> <ZTGHRAlQtF7Fq8vn@surya>
 <ZTGa0Ukt7QyxWcVy@kernel.org> <ZTGyWHTOE8OEhQWq@surya>
 <ZTLlfXM4MhW1GEIJ@kernel.org> <ZTMBLllcYRoIF8E1@surya>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZTMBLllcYRoIF8E1@surya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/10/2023 23:37, Manu Bretelle wrote:
> On Fri, Oct 20, 2023 at 05:39:25PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Oct 19, 2023 at 03:48:56PM -0700, Manu Bretelle escreveu:
>>> On Thu, Oct 19, 2023 at 06:08:33PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> I wonder how to improve the current situation to detect these kinds of
>>>> problems in the future, i.e. how to notice that some file needed by some
>>>> Makefile, etc got removed or that some feature test fails because some
>>>> change in the test .c files makes them fail and thus activates fallbacks
>>>> like the one above :-\
>>  
>>> I think it is tricky. Specifically to this situation, some CI could try to build
>>> the different combinaison of bpftool and check the features through the build
>>> `bpftool --version`.
>>
>> Right, if the right packages are installed, we expect to get some
>> bpftool build output, if that changes after some patch, flag it.

Correct, this is what we do on the CI on the GitHub mirror (checking
that the mirrored version builds correctly, with the expected features).

>>
>> Does bpftool have something like:
>>
>> ⬢[acme@toolbox perf-tools-next]$ perf version --build-options
>> perf version 6.6.rc1.ga8dd62d05e56
>>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>>                libpfm4: [ on  ]  # HAVE_LIBPFM
>>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>> ⬢[acme@toolbox perf-tools-next]$
>>
>> ?
>>
> 
> It has
> 
>     $ ./tools/bpf/bpftool/bpftool --version -j | jq .features
>     {
>       "libbfd": false,
>       "llvm": true,
>       "skeletons": true,
>       "bootstrap": false
>     }
> 
> 
> Maybe Quentin knows of something else.

This, or ldd on the binary (unless it was a static build). But "bpftool
version" should be enough to tell whether the LLVM disassembler is built
in or not, so we haven't needed something else so far.

Quentin


