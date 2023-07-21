Return-Path: <bpf+bounces-5567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251375BBB1
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 03:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05522820CC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101C386;
	Fri, 21 Jul 2023 01:05:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A72363
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:05:39 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDBE75
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 18:05:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad356f03so9138695ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689901537; x=1690506337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBAln2M+sLrf4Xhwd6957idGEUES9XiV8hz/o+kpEDs=;
        b=brYgMpcZpm28L3U/pq8FNSrxos1dhibF0qp2oWCKCoSmiSCrCVU+pVpJZHD98VlmJN
         MWIuDSaSGcfAp9xK8iLUSxBsS+IuA1vbkAxqI/jiJi+bqCgmpMc7nhB0rFun1anZYM0c
         5KpfJc9jmPmCvCP79+2JkHahsHP3yPXZtlooP1qhw0/cCc1BeOzSnwZSEIZJwKjyBBtT
         cjA7RLLPbvwfxGMLv3EGVzmKFlmqYlkZuo5BjIOowilnvziwUmczFmJx3iPTUJ0opAgh
         YwZbk+nZJd1X0R6uHI2NebFJgR6t/jkrPZ12fP83ZPkMQmtz5lV9fy55wW7qJpVIZkVP
         HBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689901537; x=1690506337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBAln2M+sLrf4Xhwd6957idGEUES9XiV8hz/o+kpEDs=;
        b=MIuJ8Uq4OR7zsipsgg6AZ9sewCfTRM2HHGdnmzkUrCjR+7+vkI0Dj9/mEEFLXzUPYf
         pGBQbe8USDaFV+vZGqW72UW1PC02wGgxd6QW9bsdqhO9XjvuITS61NgkX4+coiLF/wnX
         Hx5o3VYdGsHyUDavybXxO9Rmk/X7WOF8iS+InCiV3W9lv0deyU3OuSoaeRqxrUWXRfwO
         lv25aChaDx0cIKnyH30k/yCpr4rjt8B0lmeXmKN7HSLRJBbXHf+SlE84aKruPD996/ik
         KYL1pgfLlBuNE19vVZ5W4sJ77oxMcj9fLxjEvgyiNjPBgS+GIBg/Pk+lb8XBOVoA1KvO
         fluA==
X-Gm-Message-State: ABy/qLa7huxOQKYcZU9ntLipcdGPy7Tu+JhiFstr8BKZS2egoLQUuzur
	hsuMTv+xd2+V0U/9tDK3Tsw=
X-Google-Smtp-Source: APBJJlHP01bYvhYvdwbqtY6HXZlEIOofcUQjH+ijCP84ccziqW+x9Lwss59Ti/Ve+wr3dLYmANDSwA==
X-Received: by 2002:a17:902:ba88:b0:1b8:944a:a932 with SMTP id k8-20020a170902ba8800b001b8944aa932mr521773pls.2.1689901536599;
        Thu, 20 Jul 2023 18:05:36 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001ab39cd875csm2039011plg.133.2023.07.20.18.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 18:05:36 -0700 (PDT)
Message-ID: <0fac0326-ffd0-98a7-a1b9-7f0bead6ec58@gmail.com>
Date: Fri, 21 Jul 2023 08:05:32 +0700
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
 <32972dd6-1c6c-d59f-3f13-d90dd6e4b400@gmail.com>
 <CAKH8qBspx+7ZsCWZVxFzdPaMWWQem3+Thpa65973-H3sphGoSA@mail.gmail.com>
 <dfe68d18-d031-b6ef-ef96-97f7a119d3e1@gmail.com>
 <CAKH8qBtTvTnWYQwyHp9RWzJG8oO3FjW+AQvr+rjxTNeAxtNvxQ@mail.gmail.com>
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <CAKH8qBtTvTnWYQwyHp9RWzJG8oO3FjW+AQvr+rjxTNeAxtNvxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/21/23 00:05, Stanislav Fomichev wrote:
> On Wed, Jul 19, 2023 at 9:13 AM Anh Tuan Phan <tuananhlfc@gmail.com> wrote:
>>
>>
>>
>> On 7/17/23 23:46, Stanislav Fomichev wrote:
>>> On Sun, Jul 16, 2023 at 2:42 AM Anh Tuan Phan <tuananhlfc@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/11/23 00:18, Stanislav Fomichev wrote:
>>>>> On 07/09, Anh Tuan Phan wrote:
>>>>>> I updated the patch to reflect your suggestion. Thank you!
>>>>>
>>>>> In the future, can you please post a new one with v+1 instead of replying
>>>>> to the old one? Thx!
>>>>
>>>> Will do in the next version.
>>>>
>>>>>
>>>>>> On 7/7/23 23:53, Stanislav Fomichev wrote:
>>>>>>> On 07/07, Anh Tuan Phan wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/7/23 01:09, Stanislav Fomichev wrote:
>>>>>>>>> On 07/06, Anh Tuan Phan wrote:
>>>>>>>>>> This commit fixes a few compilation issues when building out of source
>>>>>>>>>> tree. The command that I used to build samples/bpf:
>>>>>>>>>>
>>>>>>>>>> export KBUILD_OUTPUT=/tmp
>>>>>>>>>> make V=1 M=samples/bpf
>>>>>>>>>>
>>>>>>>>>> The compilation failed since it tried to find the header files in the
>>>>>>>>>> wrong places between output directory and source tree directory
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>  samples/bpf/Makefile        | 8 ++++----
>>>>>>>>>>  samples/bpf/Makefile.target | 2 +-
>>>>>>>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>>>>>>>> index 615f24ebc49c..32469aaa82d5 100644
>>>>>>>>>> --- a/samples/bpf/Makefile
>>>>>>>>>> +++ b/samples/bpf/Makefile
>>>>>>>>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>>>>>>>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>>>>>>>>>  # TPROGS_CFLAGS causes conflicts
>>>>>>>>>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
>>>>>>>>>> -                     -I$(src)/../../tools/include \
>>>>>>>>>> +                     -I$(srctree)/tools/include \
>>>>>>>>>
>>>>>>>>> [..]
>>>>>>>>>
>>>>>>>>>>                       -I$(src)/../../tools/include/uapi \
>>>>>>>>>
>>>>>>>>> Does this $(src) need to be changed as well?
>>>>>>>>
>>>>>>>> I think this line doesn't affect the build. I removed it and it still
>>>>>>>> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_user.c
>>>>>>>> doesn't include any file in tools/include/uapi. Am I missing something
>>>>>>>> or should I remove this line?
>>>>>>>
>>>>>>> You might have these headers installed on your system already if
>>>>>>> it compiles without this part. So I'd keep this part but do
>>>>>>> s/src/srctree/ (and remove ../..).
>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>                       -I$(LIBBPF_INCLUDE) \
>>>>>>>>>> -                     -I$(src)/../../tools/testing/selftests/bpf
>>>>>>>>>> +                     -I$(srctree)/tools/testing/selftests/bpf
>>>>>>>>>>
>>>>>>>>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>>>>>>>>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
>>>>>>>>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>>>>>>>>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
>>>>>>>>>> $(src)/xdp_sample_shared.h
>>>>>>>>>>          @echo "  CLANG-BPF " $@
>>>>>>>>>>          $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
>>>>>>>>>> -                -Wno-compare-distinct-pointer-types -I$(srctree)/include \
>>>>>>>>>> +                -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>>>>>>>>>>                  -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>>>>>>>>>>                  -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>>>>>>>>>>                  -c $(filter %.bpf.c,$^) -o $@
>>>>>>>>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
>>>>>>>>>> xdp_sample.bpf.o
>>>>>>>>>>
>>>>>>>>>>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
>>>>>>>>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
>>>>>>>>>>
>>>>>>>>>> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
>>>>>>>>>> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>>>>>>>>>>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
>>>>>>>>>>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
>>>>>>>>>>
>>>>>>>>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
>>>>>>>>>> index 7621f55e2947..86a454cfb080 100644
>>>>>>>>>> --- a/samples/bpf/Makefile.target
>>>>>>>>>> +++ b/samples/bpf/Makefile.target
>>>>>>>>>> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
>>>>>>>>>>                   $(TPROGCFLAGS_$(basetarget).o)
>>>>>>>>>>
>>>>>>>>>>  # $(objtree)/$(obj) for including generated headers from checkin source
>>>>>>>>>> files
>>>>>>>>>
>>>>>>>>> [..]
>>>>>>>>>
>>>>>>>>>> -ifeq ($(KBUILD_EXTMOD),)
>>>>>>>>>> +ifneq ($(KBUILD_EXTMOD),)
>>>>>>>>>
>>>>>>>>> This parts seems to be copy-pasted all over the place in its 'ifeq'
>>>>>>>>> form. What is it doing and why is it needed?
>>>>>>>>>
>>>>>>>>>>  ifdef building_out_of_srctree
>>>>>>>>>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>>>>>>>>>  endif
>>>>>>>>>> --
>>>>>>>>>> 2.34.1
>>>>>>
>>>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> Change from the original patch
>>>>>>
>>>>>> - Change "-I$(src)/../../tools/include/uapi" to
>>>>>> "-I$(srctree)/tools/include/uapi"
>>>>>>
>>>>>>  samples/bpf/Makefile        | 10 +++++-----
>>>>>>  samples/bpf/Makefile.target |  2 +-
>>>>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>>>> index 615f24ebc49c..cfc960b3713a 100644
>>>>>> --- a/samples/bpf/Makefile
>>>>>> +++ b/samples/bpf/Makefile
>>>>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>>>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>>>>>  # TPROGS_CFLAGS causes conflicts
>>>>>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
>>>>>> -                 -I$(src)/../../tools/include \
>>>>>> -                 -I$(src)/../../tools/include/uapi \
>>>>>> +                 -I$(srctree)/tools/include \
>>>>>> +                 -I$(srctree)/tools/include/uapi \
>>>>>>                   -I$(LIBBPF_INCLUDE) \
>>>>>> -                 -I$(src)/../../tools/testing/selftests/bpf
>>>>>> +                 -I$(srctree)/tools/testing/selftests/bpf
>>>>>>
>>>>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>>>>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
>>>>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>>>>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
>>>>>> $(src)/xdp_sample_shared.h
>>>>>>      @echo "  CLANG-BPF " $@
>>>>>>      $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
>>>>>> -            -Wno-compare-distinct-pointer-types -I$(srctree)/include \
>>>>>> +            -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>>>>>>              -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>>>>>>              -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>>>>>>              -c $(filter %.bpf.c,$^) -o $@
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
>>>>>>  ifdef building_out_of_srctree
>>>>>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>>>>>  endif
>>>>>
>>>>> This question left undressed. Can you share more on why this change
>>>>> is needed? Because it looks like it's actually needed for M='' case.
>>>>> IOW, maybe we should add $(objtree)/$(obj) somewhere else?
>>>>
>>>> If it's needed for both cases M='' and M != '', is it better to just
>>>> remove the condition with $(KBUILD_EXTMOD)? FMPOV, -I $(objtree)/$(obj)
>>>> is only needed in case of building_out_of_srctree, no matter what
>>>> KBUILD_EXTMOD.
>>>
>>> My guess is that we're missing -I $(objtree)/$(obj) somewhere else.
>>> Depending on what/where it fails, we probably need to add $(objtree)
>>> to some of the $(obj)s?
>>> I'm mostly speculating here, because I see that "ifeq
>>> ($(KBUILD_EXTMOD),) + ifdef building_out_of_srctree" pattern being
>>> used in the other places.
>>
>> It turns out that your guess is right. "-I $(objtree)/$(obj)" is only
>> needed for the following objects: xdp_redirect_map_multi_user,
>> xdp_redirect_cpu_user, xdp_redirect_map_user, xdp_redirect_user,
>> xdp_monitor_user and xdp_router_ipv4_user. There is a variable to add
>> flags for gcc named $(TPROGCFLAGS_$(basetarget).o) but it has not been
>> set. My proposed fix is to set the following variables:
> 
> Looks like these are the tests that use bpf skeleton.
> 
>> +TPROGCFLAGS_xdp_redirect_map_multi_user.o += -I$(objtree)/$(obj)
>> +TPROGCFLAGS_xdp_redirect_cpu_user.o += -I$(objtree)/$(obj)
>> +TPROGCFLAGS_xdp_redirect_map_user.o += -I$(objtree)/$(obj)
>> +TPROGCFLAGS_xdp_redirect_user.o += -I$(objtree)/$(obj)
>> +TPROGCFLAGS_xdp_monitor_user.o += -I$(objtree)/$(obj)
>> +TPROGCFLAGS_xdp_router_ipv4_user.o += -I$(objtree)/$(obj)
>>
>> It works with the original "ifeq
>>> ($(KBUILD_EXTMOD),) + ifdef building_out_of_srctree" pattern. What do
>> you think about my proposed fix?
> 
> Maybe we should just unconditionally add "-I $(objtree)/$(obj)" to
> _tprogc_flags ?
> 
> And then we can drop that whole part:
> ifeq ($(KBUILD_EXTMOD),)
> ifdef building_out_of_srctree
> _tprogc_flags   += -I $(objtree)/$(obj)
> endif
> endif
> 
> IOW, replace that $(TPROGCFLAGS_$(basetarget).o) part with -I
> $(objtree)/$(obj) and call it a day?
> I honestly have no clue why it's this complicated and I doubt anybody
> at this point remembers...

That is the simplest way. I intended to do it but I didn't as I think
the condition is there for some reasons that I haven't understood yet.


