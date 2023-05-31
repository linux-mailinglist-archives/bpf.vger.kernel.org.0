Return-Path: <bpf+bounces-1507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC66717E99
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 13:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34751C20DFD
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225D14267;
	Wed, 31 May 2023 11:41:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032413AEE
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:41:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CCA185
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685533262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VqhKRE+/crq9HvaYl7NTpR69WVd2rUk93S7U0y6IeI=;
	b=b4swBIAiYHZ5Oufd9SbAkUg3FKMGEJEZe5RWX/tgzZcWGAlfw4IrCfCkDyqKF+CejhmEyR
	aMdI+bgnoSqtxsASwVe+Pv60t/MOsdIwkAd0Quk5eg+VllIXg9OVYL6uToPhcCc6LXyUkW
	EMaO9NiDy38YFnPKablhxyWtffl/vGU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662--ewDWQFmMYC4AQAwrOLekA-1; Wed, 31 May 2023 07:41:00 -0400
X-MC-Unique: -ewDWQFmMYC4AQAwrOLekA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-514a1501b0eso2384160a12.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685533260; x=1688125260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VqhKRE+/crq9HvaYl7NTpR69WVd2rUk93S7U0y6IeI=;
        b=F/fYyWL9trAdP+cwM1TcQI2v0No3HnGDdHg8uBY3H+wim5+0Nz2pLcBOnaluKCwVyN
         UJkNmMnE3UtLun4sRMda8G2BA0sY46b851mSCSFxWnAQQqvWPNwvqdv+GMei+SNf8BdJ
         s4GeLK47BkDdqZeG5eWPkSaa8eEi6S2aVI7+Su5nOkwNoPxPRVYbmMkatO/73bxwPXXK
         brfIJFyOVXRje1GXbadS9TiuWMVe2meIirOua1WVRfk6b1i8TnuhxT52dexy3RxH9D9/
         +DQhOB2VfdeyoQQEAM9ulQHr3LgvXyxE5RoNl/zjrhR7tJIqnPzpUNjnv2qkMDWVct+/
         mlOQ==
X-Gm-Message-State: AC+VfDwmUUihoCz3m8wWXxv6f5itUZkdqDUWRIEF2aZ0VE55BZx72CWE
	12otvjkUhn+BlPOkiiXNI9Hq53WbtQL6wiAPLhpsYBst8cFo6kzQXdFEK2NLBqhlkHEBcEaPGf/
	uKPYo6h66nu0=
X-Received: by 2002:a50:ec86:0:b0:514:8f21:651f with SMTP id e6-20020a50ec86000000b005148f21651fmr3191983edr.3.1685533259779;
        Wed, 31 May 2023 04:40:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Vuzyww/Cz3QQBqMyRSGFm2CG2NGllemcywxQophPt+DcW3zTQ8K0kbYyY45EJGtvjZ5Hy7g==
X-Received: by 2002:a50:ec86:0:b0:514:8f21:651f with SMTP id e6-20020a50ec86000000b005148f21651fmr3191965edr.3.1685533259424;
        Wed, 31 May 2023 04:40:59 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7cad3000000b00510b5051f95sm5664789edt.90.2023.05.31.04.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 04:40:59 -0700 (PDT)
Message-ID: <6b6cce9e-f3c3-5316-10b9-63d58c8b432f@redhat.com>
Date: Wed, 31 May 2023 13:40:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
 Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
References: <20230530123352.1308488-1-vmalik@redhat.com>
 <ZHX6SuWQHkm3hJl+@krava> <d565f28f-dbb3-f9bf-8635-c57a2a218b88@redhat.com>
 <ZHcGpUbEX5vBFrON@krava>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZHcGpUbEX5vBFrON@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/31/23 10:34, Jiri Olsa wrote:
> On Wed, May 31, 2023 at 09:20:44AM +0200, Viktor Malik wrote:
>> On 5/30/23 15:29, Jiri Olsa wrote:
>>> On Tue, May 30, 2023 at 02:33:52PM +0200, Viktor Malik wrote:
>>>> Building BPF selftests with custom HOSTCFLAGS yields an error:
>>>>
>>>>     # make HOSTCFLAGS="-O2"
>>>>     [...]
>>>>       HOSTCC  ./tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
>>>>     main.c:73:10: fatal error: linux/rbtree.h: No such file or directory
>>>>        73 | #include <linux/rbtree.h>
>>>>           |          ^~~~~~~~~~~~~~~~
>>>>
>>>> The reason is that tools/bpf/resolve_btfids/Makefile passes header
>>>> include paths by extending HOSTCFLAGS which is overridden by setting
>>>> HOSTCFLAGS in the make command (because of Makefile rules [1]).
>>>>
>>>> This patch fixes the above problem by passing the include paths via
>>>> `HOSTCFLAGS_resolve_btfids` which is used by tools/build/Build.include
>>>> and can be combined with overridding HOSTCFLAGS.
>>>>
>>>> [1] https://www.gnu.org/software/make/manual/html_node/Overriding.html
>>>>
>>>> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>> ---
>>>>  tools/bpf/resolve_btfids/Makefile | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>>>> index ac548a7baa73..4b8079f294f6 100644
>>>> --- a/tools/bpf/resolve_btfids/Makefile
>>>> +++ b/tools/bpf/resolve_btfids/Makefile
>>>> @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>>>  
>>>> -HOSTCFLAGS += -g \
>>>> +HOSTCFLAGS_resolve_btfids += -g \
>>>>            -I$(srctree)/tools/include \
>>>>            -I$(srctree)/tools/include/uapi \
>>>>            -I$(LIBBPF_INCLUDE) \
>>>> @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
>>>>  
>>>>  LIBS = $(LIBELF_LIBS) -lz
>>>>  
>>>> -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
>>>> +export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
>>>
>>> hum, AFAICS this way the spacified HOSTCFLAGS="-O2" won't be pushed
>>> to the libbpf and libsubcmd dependencies, right?
>>
>> IIUC, it will, b/c we're doing:
>>
>>     HOST_OVERRIDES := ... EXTRA_CFLAGS="$(HOSTCFLAGS)"
>>
>> and then pass HOST_OVERRIDES to libbpf and libsubcmd builds, which will
>> then pick EXTRA_CFLAGS as a part of their build.
>>
>> Confirmed for libsubcmd:
>>
>>     $ make HOSTCFLAGS="-O2" V=1 | grep libsubcmd | grep O2 | wc -l
>>     14
>>     $ make V=1 | grep libsubcmd | grep O2 | wc -l
>>     0
>>
>> Interestingly, I couldn't do the same for libbpf. It looks like libbpf
>> is not rebuilt for resolve_btfids b/c resolve_btfids/Makefile uses
>> $(BPFOBJ) as the libbpf target and selftests/bpf/Makefile passes
>> BPFOBJ=$(HOST_BPFOBJ) to the resolve_btfids build. So, an already built
>> libbpf is reused and that one hasn't picked HOSTCFLAGS.
>>
>>> how about we add the EXTRA_CFLAGS variable like we do in libbpf,
>>> libsubcmd or perf
>>>
>>> with the change below you'd need to run:
>>>
>>>   $ make EXTRA_CFLAGS="-O2"
>>>
>>
>> I'd like to avoid that b/c then, we would need to issue a different make
>> command for the BPF selftests than for the rest of the kernel to pass
>> custom flags to host-built programs.
> 
> ok
> 
>>
>>> I'll dig up the cross build scenarious we broke last time we
>>> touched this stuff, perhaps Ian might remember as well ;-)
>>
>> That will be useful, thanks :-)
> 
> there's test described by Nathan in here:
> 
> https://lore.kernel.org/bpf/Y9mFVNEi5wAINARY@dev-arch.thelio-3990X/

Thanks, I ran the commands and it builds fine.

Running:
    $ make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 V=1 prepare

Current master:
    [...]
    clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include  -D"BUILD_STR(s)=#s"   -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c
    [...]

With this patch:
    [...]
    clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o  -D"BUILD_STR(s)=#s"  -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include  -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c
    [...]

With this patch and HOSTCFLAGS=-O2:
    [...]
    clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o -O2 -D"BUILD_STR(s)=#s"  -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include  -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c
    [...]

The flags in the first two are the same, they are just reordered. The
last one correctly adds -O2. Other than that, this patch only drops
resolve_btfids-specific flags (those -I...) from building
resolve_btfids/fixdep but that's, IIUC, fine.

Viktor

> 
> jirka
> 
>>
>> Viktor
>>
>>>
>>> jirka
>>>
>>>
>>> ---
>>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>>> index ac548a7baa73..58cfedc9c2db 100644
>>> --- a/tools/bpf/resolve_btfids/Makefile
>>> +++ b/tools/bpf/resolve_btfids/Makefile
>>> @@ -18,8 +18,8 @@ else
>>>  endif
>>>  
>>>  # Overrides for the prepare step libraries.
>>> -HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
>>> -		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
>>> +HOST_OVERRIDES = AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
>>> +		  CROSS_COMPILE=""
>>>  
>>>  RM      ?= rm
>>>  HOSTCC  ?= gcc
>>> @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>>  
>>> -HOSTCFLAGS += -g \
>>> +HOSTCFLAGS += $(EXTRA_CFLAGS) -g \
>>>            -I$(srctree)/tools/include \
>>>            -I$(srctree)/tools/include/uapi \
>>>            -I$(LIBBPF_INCLUDE) \
>>> @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
>>>  
>>>  LIBS = $(LIBELF_LIBS) -lz
>>>  
>>> -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
>>> +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR EXTRA_CFLAGS
>>>  include $(srctree)/tools/build/Makefile.include
>>>  
>>>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
>>>
>>
> 


