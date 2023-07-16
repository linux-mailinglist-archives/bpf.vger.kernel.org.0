Return-Path: <bpf+bounces-5064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B650E754E21
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 11:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906091C209B3
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3DB5C9A;
	Sun, 16 Jul 2023 09:42:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211103C26
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 09:42:43 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651310D0
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 02:42:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2503603b3a.1
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689500561; x=1692092561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7w38njytlQQK/lDRhdcGMZatxsHZDYd38JkE7J9iPvw=;
        b=qpW6J/SE+heS8miBLI8KWRsx9q8J9hupShQT0wA1qyTXho0zEVn2wmUnf6OobaAu9C
         yxTWsA2wArq/oiOjf/Nrnqid6UXQIsstGGG6gAN3RoMgy+tcBhoitPp85i0ePJ5DIWFV
         OMtiE+MRHyJ9Bc+7gNJ/ii72hfLeL8xZjs9Q5F3tR/vAieHgH07I46I6p9DQ5Rn1kb44
         pXwrm2SWlfuGRICBWROa2T4RZZy0Nau/7P9/EndW4Z8Fc8i89FyVFZMPK22bMh/FFpy4
         qfteEKO0gz1TI0DssM6Uun/jzY5mQOgLqBkd7uQg891x/tls1+O6m/6bjU/3nb7gAMcr
         LKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689500561; x=1692092561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w38njytlQQK/lDRhdcGMZatxsHZDYd38JkE7J9iPvw=;
        b=VpgJfJxJzmxhv91r5KAHYKJ4dsFqkwopuTficG2V97bI+uD861J2MHk2IKvaSh52Gw
         ViGrrfnuCRKq9eUOpziox6rNUYd989qKM3kDdLA0SAu0kkaKH0WBPhXIznr2+E5j2SDu
         CzdXyK7mJqWifYCDfwK87/OiFwyAhvP46l9wcUIs9mLtDyDLZg/cKMJVRhZkYQzrHE0W
         sO5p+euJWnGFKXsUwlVmprUjrCwSIHcvM41B5IaB5VbuOwvzkwirlglb6IFMyaZrUMu/
         WmOJ79GV5ml6gZeDuAotu9oKKQlqF81y7Y0QCoWl8et3wwB2MhjIKKlH+78CTnBqqOBp
         0ROQ==
X-Gm-Message-State: ABy/qLaOPH1KrD6fgPzb2/RdR4++EoYxdCp42rSP5AmNUcN7nlQnnzAr
	8H2gK7XkVDYgYPMTaTi7Ll4=
X-Google-Smtp-Source: APBJJlGSY1h2pGXRpMV8MjIwqnxnYDbDbBWSQQaB/TAXUgzpKO3Df0x6DvyDGbKgyEy97jteCpD9Pw==
X-Received: by 2002:a05:6a20:3d8e:b0:134:5c75:3c99 with SMTP id s14-20020a056a203d8e00b001345c753c99mr3349288pzi.36.1689500561215;
        Sun, 16 Jul 2023 02:42:41 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b0063b8ddf77f7sm9882883pff.211.2023.07.16.02.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 02:42:40 -0700 (PDT)
Message-ID: <32972dd6-1c6c-d59f-3f13-d90dd6e4b400@gmail.com>
Date: Sun, 16 Jul 2023 16:42:37 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
 <ZKcDdIYOUQuPP5Px@google.com>
 <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
 <ZKhC9G5ouGOviSOG@google.com>
 <2b48be65-5f63-4658-38cb-03c00c10fdf3@gmail.com>
 <ZKw9XQGOza6qGDLf@google.com>
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZKw9XQGOza6qGDLf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/11/23 00:18, Stanislav Fomichev wrote:
> On 07/09, Anh Tuan Phan wrote:
>> I updated the patch to reflect your suggestion. Thank you!
> 
> In the future, can you please post a new one with v+1 instead of replying
> to the old one? Thx!

Will do in the next version.

> 
>> On 7/7/23 23:53, Stanislav Fomichev wrote:
>>> On 07/07, Anh Tuan Phan wrote:
>>>>
>>>>
>>>> On 7/7/23 01:09, Stanislav Fomichev wrote:
>>>>> On 07/06, Anh Tuan Phan wrote:
>>>>>> This commit fixes a few compilation issues when building out of source
>>>>>> tree. The command that I used to build samples/bpf:
>>>>>>
>>>>>> export KBUILD_OUTPUT=/tmp
>>>>>> make V=1 M=samples/bpf
>>>>>>
>>>>>> The compilation failed since it tried to find the header files in the
>>>>>> wrong places between output directory and source tree directory
>>>>>>
>>>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>>>>>> ---
>>>>>>  samples/bpf/Makefile        | 8 ++++----
>>>>>>  samples/bpf/Makefile.target | 2 +-
>>>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>>>> index 615f24ebc49c..32469aaa82d5 100644
>>>>>> --- a/samples/bpf/Makefile
>>>>>> +++ b/samples/bpf/Makefile
>>>>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>>>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>>>>>  # TPROGS_CFLAGS causes conflicts
>>>>>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
>>>>>> -		     -I$(src)/../../tools/include \
>>>>>> +		     -I$(srctree)/tools/include \
>>>>>
>>>>> [..]
>>>>>
>>>>>>  		     -I$(src)/../../tools/include/uapi \
>>>>>
>>>>> Does this $(src) need to be changed as well?
>>>>
>>>> I think this line doesn't affect the build. I removed it and it still
>>>> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_user.c
>>>> doesn't include any file in tools/include/uapi. Am I missing something
>>>> or should I remove this line?
>>>
>>> You might have these headers installed on your system already if
>>> it compiles without this part. So I'd keep this part but do
>>> s/src/srctree/ (and remove ../..).
>>>
>>>>>
>>>>>
>>>>>>  		     -I$(LIBBPF_INCLUDE) \
>>>>>> -		     -I$(src)/../../tools/testing/selftests/bpf
>>>>>> +		     -I$(srctree)/tools/testing/selftests/bpf
>>>>>>
>>>>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>>>>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
>>>>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>>>>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
>>>>>> $(src)/xdp_sample_shared.h
>>>>>>  	@echo "  CLANG-BPF " $@
>>>>>>  	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
>>>>>> -		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
>>>>>> +		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>>>>>>  		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>>>>>>  		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>>>>>>  		-c $(filter %.bpf.c,$^) -o $@
>>>>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
>>>>>> xdp_sample.bpf.o
>>>>>>
>>>>>>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
>>>>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
>>>>>>
>>>>>> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
>>>>>> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>>>>>>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
>>>>>>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
>>>>>>
>>>>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
>>>>>> index 7621f55e2947..86a454cfb080 100644
>>>>>> --- a/samples/bpf/Makefile.target
>>>>>> +++ b/samples/bpf/Makefile.target
>>>>>> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
>>>>>>                   $(TPROGCFLAGS_$(basetarget).o)
>>>>>>
>>>>>>  # $(objtree)/$(obj) for including generated headers from checkin source
>>>>>> files
>>>>>
>>>>> [..]
>>>>>
>>>>>> -ifeq ($(KBUILD_EXTMOD),)
>>>>>> +ifneq ($(KBUILD_EXTMOD),)
>>>>>
>>>>> This parts seems to be copy-pasted all over the place in its 'ifeq'
>>>>> form. What is it doing and why is it needed?
>>>>>
>>>>>>  ifdef building_out_of_srctree
>>>>>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>>>>>  endif
>>>>>> -- 
>>>>>> 2.34.1
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>>
>> Change from the original patch
>>
>> - Change "-I$(src)/../../tools/include/uapi" to
>> "-I$(srctree)/tools/include/uapi"
>>
>>  samples/bpf/Makefile        | 10 +++++-----
>>  samples/bpf/Makefile.target |  2 +-
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 615f24ebc49c..cfc960b3713a 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>  # TPROGS_CFLAGS causes conflicts
>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
>> -		     -I$(src)/../../tools/include \
>> -		     -I$(src)/../../tools/include/uapi \
>> +		     -I$(srctree)/tools/include \
>> +		     -I$(srctree)/tools/include/uapi \
>>  		     -I$(LIBBPF_INCLUDE) \
>> -		     -I$(src)/../../tools/testing/selftests/bpf
>> +		     -I$(srctree)/tools/testing/selftests/bpf
>>
>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
>> $(src)/xdp_sample_shared.h
>>  	@echo "  CLANG-BPF " $@
>>  	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
>> -		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
>> +		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>>  		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>>  		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>>  		-c $(filter %.bpf.c,$^) -o $@
>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
>> xdp_sample.bpf.o
>>
>>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
>> skel,$(LINKED_SKELS),$($(skel)-deps)))
>>
>> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
>> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
>>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
>>
>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
>> index 7621f55e2947..86a454cfb080 100644
>> --- a/samples/bpf/Makefile.target
>> +++ b/samples/bpf/Makefile.target
>> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
>>                   $(TPROGCFLAGS_$(basetarget).o)
>>
>>  # $(objtree)/$(obj) for including generated headers from checkin source
>> files
> 
> [..]
> 
>> -ifeq ($(KBUILD_EXTMOD),)
>> +ifneq ($(KBUILD_EXTMOD),)
>>  ifdef building_out_of_srctree
>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>  endif
> 
> This question left undressed. Can you share more on why this change
> is needed? Because it looks like it's actually needed for M='' case.
> IOW, maybe we should add $(objtree)/$(obj) somewhere else?

If it's needed for both cases M='' and M != '', is it better to just
remove the condition with $(KBUILD_EXTMOD)? FMPOV, -I $(objtree)/$(obj)
is only needed in case of building_out_of_srctree, no matter what
KBUILD_EXTMOD.

