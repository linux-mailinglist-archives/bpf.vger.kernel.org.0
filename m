Return-Path: <bpf+bounces-1491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137067177EB
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 09:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50191C20DA2
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8FA942;
	Wed, 31 May 2023 07:21:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34304A928
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 07:21:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A38E68
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685517649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUomhbHM3sHNHKTgH3rUBxT+G1/QKLncq7myLsfou5s=;
	b=b/1aOrrLXmE48m/QFvY4G7d3prWXYsbM7iX2XTMXr0h1nGpcTPhMBNL8/kPkn5RXO8wFSr
	wmRtoIsFqc9hGl3oEA9dHG4AJkU7j4HkYwFeOHxxyFBBa1Xfx6oWmyBxabLTFI0FTcY+u2
	BWGWoxZvMe5v9j+TU0TO2cbqvlm3+MY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-K1NgGEZrMOCat7_KV6mrjg-1; Wed, 31 May 2023 03:20:47 -0400
X-MC-Unique: K1NgGEZrMOCat7_KV6mrjg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fd6bd135dso586426266b.1
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 00:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517646; x=1688109646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUomhbHM3sHNHKTgH3rUBxT+G1/QKLncq7myLsfou5s=;
        b=ljuVtSI9DNyMxzeQFMlCU87m1pclBSOQB3bOTDG2pTe1PU8w0PZGc1R7fA+lkq3Fym
         LuKYy4McDqBds4+ErNj64pltn9fDH4T08PN3vMl1M3FK6dpdO/GfxXnt5PHB8ot5AS0r
         1uVQiPvFZfhKODWt9wfO9GMYYTQmbmeSpRIFSEsfy2qxyMOfMWNKraPHeFcXamLGkG/z
         DOOQVhNdO9frwJn6TrTWvcpkZQvMJu11oO/dUNxsUbqxnuweDNbAzJHPaG1IhzjqSBbS
         Awaulu1D9OOjRA54VYjx+7eJKS8LbOOnbXhpaCO4US/7djM3RuT+9vybSf6naGXOQ420
         viHg==
X-Gm-Message-State: AC+VfDxej9lYsNtbCCqKPCp1fjRlfrWQtMtrTi65OC4psucru/XltIiv
	lQJLM/KcK5FJCpsSzB83MwFGGvhp6XBkuDAZfrUBp/GrWgpmCoFVk1USSnMSsmpZkXNkzIE61sR
	6yDgfiqAixiQ=
X-Received: by 2002:a17:906:dac7:b0:96f:8b64:c0 with SMTP id xi7-20020a170906dac700b0096f8b6400c0mr5007575ejb.39.1685517646080;
        Wed, 31 May 2023 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cxWtep0z8xdK8KXZ1ZxyMcSg5EPNfA0B62fkdpvV+FDhQKSmB0JfaXQT5jpOe4lin77ALbw==
X-Received: by 2002:a17:906:dac7:b0:96f:8b64:c0 with SMTP id xi7-20020a170906dac700b0096f8b6400c0mr5007541ejb.39.1685517645685;
        Wed, 31 May 2023 00:20:45 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709064d9100b00969f25b96basm8426985eju.204.2023.05.31.00.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:20:45 -0700 (PDT)
Message-ID: <d565f28f-dbb3-f9bf-8635-c57a2a218b88@redhat.com>
Date: Wed, 31 May 2023 09:20:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
 Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
References: <20230530123352.1308488-1-vmalik@redhat.com>
 <ZHX6SuWQHkm3hJl+@krava>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZHX6SuWQHkm3hJl+@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/30/23 15:29, Jiri Olsa wrote:
> On Tue, May 30, 2023 at 02:33:52PM +0200, Viktor Malik wrote:
>> Building BPF selftests with custom HOSTCFLAGS yields an error:
>>
>>     # make HOSTCFLAGS="-O2"
>>     [...]
>>       HOSTCC  ./tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
>>     main.c:73:10: fatal error: linux/rbtree.h: No such file or directory
>>        73 | #include <linux/rbtree.h>
>>           |          ^~~~~~~~~~~~~~~~
>>
>> The reason is that tools/bpf/resolve_btfids/Makefile passes header
>> include paths by extending HOSTCFLAGS which is overridden by setting
>> HOSTCFLAGS in the make command (because of Makefile rules [1]).
>>
>> This patch fixes the above problem by passing the include paths via
>> `HOSTCFLAGS_resolve_btfids` which is used by tools/build/Build.include
>> and can be combined with overridding HOSTCFLAGS.
>>
>> [1] https://www.gnu.org/software/make/manual/html_node/Overriding.html
>>
>> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/bpf/resolve_btfids/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>> index ac548a7baa73..4b8079f294f6 100644
>> --- a/tools/bpf/resolve_btfids/Makefile
>> +++ b/tools/bpf/resolve_btfids/Makefile
>> @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>  
>> -HOSTCFLAGS += -g \
>> +HOSTCFLAGS_resolve_btfids += -g \
>>            -I$(srctree)/tools/include \
>>            -I$(srctree)/tools/include/uapi \
>>            -I$(LIBBPF_INCLUDE) \
>> @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
>>  
>>  LIBS = $(LIBELF_LIBS) -lz
>>  
>> -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
>> +export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
> 
> hum, AFAICS this way the spacified HOSTCFLAGS="-O2" won't be pushed
> to the libbpf and libsubcmd dependencies, right?

IIUC, it will, b/c we're doing:

    HOST_OVERRIDES := ... EXTRA_CFLAGS="$(HOSTCFLAGS)"

and then pass HOST_OVERRIDES to libbpf and libsubcmd builds, which will
then pick EXTRA_CFLAGS as a part of their build.

Confirmed for libsubcmd:

    $ make HOSTCFLAGS="-O2" V=1 | grep libsubcmd | grep O2 | wc -l
    14
    $ make V=1 | grep libsubcmd | grep O2 | wc -l
    0

Interestingly, I couldn't do the same for libbpf. It looks like libbpf
is not rebuilt for resolve_btfids b/c resolve_btfids/Makefile uses
$(BPFOBJ) as the libbpf target and selftests/bpf/Makefile passes
BPFOBJ=$(HOST_BPFOBJ) to the resolve_btfids build. So, an already built
libbpf is reused and that one hasn't picked HOSTCFLAGS.

> how about we add the EXTRA_CFLAGS variable like we do in libbpf,
> libsubcmd or perf
> 
> with the change below you'd need to run:
> 
>   $ make EXTRA_CFLAGS="-O2"
> 

I'd like to avoid that b/c then, we would need to issue a different make
command for the BPF selftests than for the rest of the kernel to pass
custom flags to host-built programs.

> I'll dig up the cross build scenarious we broke last time we
> touched this stuff, perhaps Ian might remember as well ;-)

That will be useful, thanks :-)

Viktor

> 
> jirka
> 
> 
> ---
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index ac548a7baa73..58cfedc9c2db 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -18,8 +18,8 @@ else
>  endif
>  
>  # Overrides for the prepare step libraries.
> -HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> -		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
> +HOST_OVERRIDES = AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> +		  CROSS_COMPILE=""
>  
>  RM      ?= rm
>  HOSTCC  ?= gcc
> @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>  
> -HOSTCFLAGS += -g \
> +HOSTCFLAGS += $(EXTRA_CFLAGS) -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
>  
>  LIBS = $(LIBELF_LIBS) -lz
>  
> -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR EXTRA_CFLAGS
>  include $(srctree)/tools/build/Makefile.include
>  
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> 


