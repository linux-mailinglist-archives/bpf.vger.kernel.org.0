Return-Path: <bpf+bounces-4529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA774C4B6
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812AD1C20932
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67679E0;
	Sun,  9 Jul 2023 14:45:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8942917
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 14:45:08 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C12120
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 07:45:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8ad356f03so22717525ad.1
        for <bpf@vger.kernel.org>; Sun, 09 Jul 2023 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688913906; x=1691505906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0Pcosb2Ba31z/+QLmH3Cik2zJvWxwpWsM0nizuqcLQ=;
        b=lxZliBCvU1SH34GsvnCDsUKGTdsFhsnkuNjd7VYC6tKvy/hmhXkENFGPDMK6kEmxy/
         9rV0zfQxJpROjB9sNNjo1LsZOxj2i3NXzuap3K/6n/Ve24Bi4abLYbD/VE9iGFvYIeka
         hfRIpZUhEp3SnXCJipz8gQg7pBYBlxwMI/dzYGkmY0NhKdG1+j9qppNdYd4uq60OCRrU
         9yM8VNWBoUt74WtinJ+Yj9FjihjrORlEdaYhdsEy+SVWINydBms1+LL9i5YQ8Z2o4np9
         loO099ekfEbff2wXSO9Kz8K0LyJkTyiYddskj3sgcq5vXFfX87HdRu1qq/DfSgM1eMbl
         GJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688913906; x=1691505906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0Pcosb2Ba31z/+QLmH3Cik2zJvWxwpWsM0nizuqcLQ=;
        b=RGUR5oq+r3/Wtw/3e2sf9GwY14NzgWvO32ssxkuV91syJTCdg7tpIizYBM8K2nBP0S
         chV8+JO2n4b5p4PLJqOLnkOlWM+T5b5ZMMkskIhYm2Is/hJe7RO0F3FKVLs1z2FM05ce
         qc3gcQiDODcOydMo739ySGxarFjPavXYxlezyJAF24zXjSUtgtJTYjgWA9c2dLotVbeR
         86UP+aN9Zm1AP42Dp8yoDYDxlQ9OAqPuaztsQQxip8ePg6+VOe0sypIgn0w8y35eLYQa
         ru9RHDkD8RsWp9E+IpSlmlhXSSlOeups6q2d2QZrdGWDf4h/HRHh+/KYynRituRfBBUn
         neHg==
X-Gm-Message-State: ABy/qLZjmqTYGLwRtmKHl2ZE7q4AL8OovrhMDcpaFuNtvdhwwxFh8npS
	YCgKVivvC9g9GpWZQGpPCt4=
X-Google-Smtp-Source: APBJJlGrroxaPPCCT1NR8XHly9FSh4gX8jSLIecE8h6zm01fxJVhXm7vfZsfbx4E7So/CZiJf8Q0TQ==
X-Received: by 2002:a17:903:1252:b0:1b5:561a:5c9a with SMTP id u18-20020a170903125200b001b5561a5c9amr11235761plh.39.1688913906287;
        Sun, 09 Jul 2023 07:45:06 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b001b80b342f61sm6338345plg.268.2023.07.09.07.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 07:45:05 -0700 (PDT)
Message-ID: <2b48be65-5f63-4658-38cb-03c00c10fdf3@gmail.com>
Date: Sun, 9 Jul 2023 21:45:03 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
 <ZKcDdIYOUQuPP5Px@google.com>
 <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
 <ZKhC9G5ouGOviSOG@google.com>
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZKhC9G5ouGOviSOG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I updated the patch to reflect your suggestion. Thank you!

On 7/7/23 23:53, Stanislav Fomichev wrote:
> On 07/07, Anh Tuan Phan wrote:
>>
>>
>> On 7/7/23 01:09, Stanislav Fomichev wrote:
>>> On 07/06, Anh Tuan Phan wrote:
>>>> This commit fixes a few compilation issues when building out of source
>>>> tree. The command that I used to build samples/bpf:
>>>>
>>>> export KBUILD_OUTPUT=/tmp
>>>> make V=1 M=samples/bpf
>>>>
>>>> The compilation failed since it tried to find the header files in the
>>>> wrong places between output directory and source tree directory
>>>>
>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>>>> ---
>>>>  samples/bpf/Makefile        | 8 ++++----
>>>>  samples/bpf/Makefile.target | 2 +-
>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>> index 615f24ebc49c..32469aaa82d5 100644
>>>> --- a/samples/bpf/Makefile
>>>> +++ b/samples/bpf/Makefile
>>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>>>  # TPROGS_CFLAGS causes conflicts
>>>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
>>>> -		     -I$(src)/../../tools/include \
>>>> +		     -I$(srctree)/tools/include \
>>>
>>> [..]
>>>
>>>>  		     -I$(src)/../../tools/include/uapi \
>>>
>>> Does this $(src) need to be changed as well?
>>
>> I think this line doesn't affect the build. I removed it and it still
>> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_user.c
>> doesn't include any file in tools/include/uapi. Am I missing something
>> or should I remove this line?
> 
> You might have these headers installed on your system already if
> it compiles without this part. So I'd keep this part but do
> s/src/srctree/ (and remove ../..).
> 
>>>
>>>
>>>>  		     -I$(LIBBPF_INCLUDE) \
>>>> -		     -I$(src)/../../tools/testing/selftests/bpf
>>>> +		     -I$(srctree)/tools/testing/selftests/bpf
>>>>
>>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
>>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
>>>> $(src)/xdp_sample_shared.h
>>>>  	@echo "  CLANG-BPF " $@
>>>>  	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
>>>> -		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
>>>> +		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>>>>  		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>>>>  		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>>>>  		-c $(filter %.bpf.c,$^) -o $@
>>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
>>>> xdp_sample.bpf.o
>>>>
>>>>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
>>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
>>>>
>>>> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
>>>> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>>>>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
>>>>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
>>>>
>>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
>>>> index 7621f55e2947..86a454cfb080 100644
>>>> --- a/samples/bpf/Makefile.target
>>>> +++ b/samples/bpf/Makefile.target
>>>> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
>>>>                   $(TPROGCFLAGS_$(basetarget).o)
>>>>
>>>>  # $(objtree)/$(obj) for including generated headers from checkin source
>>>> files
>>>
>>> [..]
>>>
>>>> -ifeq ($(KBUILD_EXTMOD),)
>>>> +ifneq ($(KBUILD_EXTMOD),)
>>>
>>> This parts seems to be copy-pasted all over the place in its 'ifeq'
>>> form. What is it doing and why is it needed?
>>>
>>>>  ifdef building_out_of_srctree
>>>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>>>  endif
>>>> -- 
>>>> 2.34.1

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---

Change from the original patch

- Change "-I$(src)/../../tools/include/uapi" to
"-I$(srctree)/tools/include/uapi"

 samples/bpf/Makefile        | 10 +++++-----
 samples/bpf/Makefile.target |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..cfc960b3713a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
-		     -I$(src)/../../tools/include \
-		     -I$(src)/../../tools/include/uapi \
+		     -I$(srctree)/tools/include \
+		     -I$(srctree)/tools/include/uapi \
 		     -I$(LIBBPF_INCLUDE) \
-		     -I$(src)/../../tools/testing/selftests/bpf
+		     -I$(srctree)/tools/testing/selftests/bpf

 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
@@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
$(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
 	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
-		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
+		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
 		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
@@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
xdp_sample.bpf.o

 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
skel,$(LINKED_SKELS),$($(skel)-deps)))

-BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
+BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
 BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
 BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))

diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
index 7621f55e2947..86a454cfb080 100644
--- a/samples/bpf/Makefile.target
+++ b/samples/bpf/Makefile.target
@@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
                  $(TPROGCFLAGS_$(basetarget).o)

 # $(objtree)/$(obj) for including generated headers from checkin source
files
-ifeq ($(KBUILD_EXTMOD),)
+ifneq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
 _tprogc_flags   += -I $(objtree)/$(obj)
 endif
-- 
2.34.1


