Return-Path: <bpf+bounces-12477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA27CCC36
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE927281B51
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60502D799;
	Tue, 17 Oct 2023 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="MIuRQW1w"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CA2EAEF
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 19:26:48 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BA4E8
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:26:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6934202b8bdso5259731b3a.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697570806; x=1698175606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDot9iblcIn0w6AF1G0uxUEwZFMHjB3wMQ8TKedvYfs=;
        b=MIuRQW1wOl26JrDTgt4y1nTWFo9t47fiF7ZbavL3tg75bDQ9HXAf6W5pYBQuO8k4M3
         Ktu/pSXluTmzvJmOtYnikCKpww7c2m+cvBZ/U+PLVrpHT9L9HeAFF3HXxUrHErw6PoSv
         2a737RbILsV5fUCsgwJIGeEJEuzEPWsXj45ItYba0ZNmp3xKxqKQiOWuiW/EsXedeIJ3
         uSwa3iJbvnSusjkuEYZo1t1klQ+m9daZzi6lDX7HuYuMXT2vCQG4q6lDPrjTOhRQc0yt
         EGfWhT10fnWV06vnzorQabl//5Tncgmd1CrQEHovdjDbNrk0fb3O2oM48rDKlkeRHZVS
         l4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570806; x=1698175606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDot9iblcIn0w6AF1G0uxUEwZFMHjB3wMQ8TKedvYfs=;
        b=wGdsbKvVp+d4wtgdLqWVU6w1fjMc3gsCdTnu4wP6V23MiDIPelCgeQNMoGLVvvkAqm
         uQBp/tvLa80yg2XN7YQBd4/Hhsi/xGtVrUUx1d41Q/jF9ycvZ4dfLsN+d9pW7cE86ha+
         qlJZOnDvFvaN/cG5tXCNGLhfN04VX+hWfdbM4jkNJW038crWmgEUWb5qyNqQfZwUF+Kh
         2qS8KgZUGFZUn8riiI4Q06WuBPUSTznv5dzirA/p1T1+hdANhFfxzU18MAYJ2RrC12cU
         gSLGF1zYwmOqjDZqbCzVx0vszTgf12YqB1M25hlOLx/ubthAgKZaQabntu2RZ7YcJXKD
         uBhQ==
X-Gm-Message-State: AOJu0Ywvx8qo24sw1Nq4csW3tYtGSmMceoEGGAU147womol7NzzkEivG
	snLvn/vH4C1pyWFt81mHA1yDTg==
X-Google-Smtp-Source: AGHT+IHYI3yyhu3JqTTLzLVz52tA4oYjGlWDkzfMtgTEGUIpfjySanG8qpTnjMDKm/wqRtkB07X3Dg==
X-Received: by 2002:a05:6a00:23d3:b0:6bd:2c0a:e7d with SMTP id g19-20020a056a0023d300b006bd2c0a0e7dmr3052248pfc.19.1697570806604;
        Tue, 17 Oct 2023 12:26:46 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b006be22fde07dsm1825381pfp.106.2023.10.17.12.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:26:46 -0700 (PDT)
Message-ID: <512a8ed7-4321-4ffe-a569-da1bee288986@daynix.com>
Date: Wed, 18 Oct 2023 04:26:41 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Use pkg-config to determine ld
 flags
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn@kernel.org
References: <20231016130307.35104-1-akihiko.odaki@daynix.com>
 <4037a83a-c6b6-6eab-1cb1-93339686c4e5@iogearbox.net>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4037a83a-c6b6-6eab-1cb1-93339686c4e5@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/17 23:15, Daniel Borkmann wrote:
> On 10/16/23 3:03 PM, Akihiko Odaki wrote:
>> When linking statically, libraries may require other dependencies to be
>> included to ld flags. In particular, libelf may require libzstd. Use
>> pkg-config to determine such dependencies.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> V3 -> V4: Added "2> /dev/null".
>> V2 -> V3: Added missing "echo".
>> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
>>
>>   tools/testing/selftests/bpf/Makefile   | 4 +++-
>>   tools/testing/selftests/bpf/README.rst | 2 +-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile 
>> b/tools/testing/selftests/bpf/Makefile
>> index caede9b574cb..009e907a8abe 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>>   include ../../../scripts/Makefile.include
>>   CXX ?= $(CROSS_COMPILE)g++
>> +PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>>   CURDIR := $(abspath .)
>>   TOOLSDIR := $(abspath ../../..)
>> @@ -31,7 +32,8 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) 
>> $(SAN_CFLAGS)    \
>>         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)        \
>>         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>>   LDFLAGS += $(SAN_LDFLAGS)
>> -LDLIBS += -lelf -lz -lrt -lpthread
>> +LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib 2> /dev/null || 
>> echo -lelf -lz)    \
>> +      -lrt -lpthread
>>   ifneq ($(LLVM),)
>>   # Silence some warnings when compiled with clang
> 
> Staring at tools/bpf/resolve_btfids/Makefile, I'm trying to understand 
> why we
> cannot replicate something similar for BPF selftests?
> 
> For example, with your patch, why is it necessary to now have PKG_CONFIG 
> and
> another HOSTPKG_CONFIG var?

It's because at least Debian does have wrappers of pkg-config for cross 
compile targets. You can find them below:
https://packages.debian.org/search?searchon=contents&keywords=pkg-config&mode=path&suite=stable&arch=any

> 
> What about the below?
> 
> diff --git a/tools/testing/selftests/bpf/Makefile 
> b/tools/testing/selftests/bpf/Makefile
> index 4225f975fce3..62166d2f937d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -29,13 +29,17 @@ SAN_CFLAGS  ?=
>   SAN_LDFLAGS    ?= $(SAN_CFLAGS)
>   RELEASE                ?=
>   OPT_FLAGS      ?= $(if $(RELEASE),-O2,-O0)
> +
> +LIBELF_FLAGS   := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS    := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null 
> || echo -lelf)

Having dedicated variables and checking --cflags are a good idea.

