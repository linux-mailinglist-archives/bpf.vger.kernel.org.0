Return-Path: <bpf+bounces-4372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AA74A85C
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8612A1C20EF2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE91106;
	Fri,  7 Jul 2023 01:11:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E637F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:11:04 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE6173F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:11:03 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a3eae37625so44848b6e.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 18:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688692262; x=1691284262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Rzjvwgn5/XEhBOCYb0rbSMaE6vN9vTAoFTgB1e81Q=;
        b=UFMmAe8uK0CO29DW8rB7qr2OAljKYxNRxfDXTsxcqUmU23kRrfJ/+XU+b4o1pqSj9z
         HnsM6I9/uMIalHrEkzaATt0oCDm/YkJi7FpFKRI0t7AGwuBq+linl3krAh/p+6WA0JkL
         ZzpMxMQfvR6gUU9jsiUGtWcQs/rU/krLlrAqP+DnqDBc9xPhwKreaG5KfRwBfrAbEdOK
         sdnRJ2MpgH0TG2Iy/yxcjUTo3339GQ3lRXLei8VlAp2Kl0XVPNe0NDDLBxaofXjzifDB
         KcXOXWIFopxh8GWmoc9MWElI39xEESsNUdO0UO0mNQwNOJ1MDmrnYKAz8/eJrqteDXcG
         CzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688692262; x=1691284262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1Rzjvwgn5/XEhBOCYb0rbSMaE6vN9vTAoFTgB1e81Q=;
        b=c0BuhJbLIVOAB78WpkqipoTE6aJfHjRqBDPGKbEhb6+5MDP6wj5akr2AWOBCzgCgki
         FJJLlZ/isfdmEMhv57cyj1gI2BTP0QNKwTKbNg3IJyu6k4vFVczMHfTuohkuoz/bG+Og
         HSKl6YEhp+a/374YY+zkshvu17l15x8yXKjcY+V+v1ZUMAv/3X7E1t4smMPnl0gCQutF
         reSWLK8c206oGG/oOdL9caVCyezobbnYMWPT+Bh0k7i3YHoB5//1mfIlzu5z4TyeIJAB
         f8KWtD1QxfU1e4cqvv4TQk7LooKzDow0IBwIPoALwFBiJVF+HjibOZnQS2PqyVVLlIgB
         E55w==
X-Gm-Message-State: ABy/qLbMxcjpFdSRhjGdPU8O79VoogeSWXdCIUKw/CRxuQA9ytn/gZUm
	urnW4BWY/u/TlMgUtL73YFE=
X-Google-Smtp-Source: APBJJlEGqLdM5NdTNIs18isCp6cS+qe6U6awx6G6zzyHujXWDdv8J1qbUe5fO6mUmIbT3TITjnhefQ==
X-Received: by 2002:a05:6808:119:b0:3a3:6950:bb33 with SMTP id b25-20020a056808011900b003a36950bb33mr2873301oie.16.1688692262314;
        Thu, 06 Jul 2023 18:11:02 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id j13-20020a62b60d000000b006765cb3255asm1808395pff.68.2023.07.06.18.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 18:11:01 -0700 (PDT)
Message-ID: <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
Date: Fri, 7 Jul 2023 08:10:59 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
 <ZKcDdIYOUQuPP5Px@google.com>
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZKcDdIYOUQuPP5Px@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/7/23 01:09, Stanislav Fomichev wrote:
> On 07/06, Anh Tuan Phan wrote:
>> This commit fixes a few compilation issues when building out of source
>> tree. The command that I used to build samples/bpf:
>>
>> export KBUILD_OUTPUT=/tmp
>> make V=1 M=samples/bpf
>>
>> The compilation failed since it tried to find the header files in the
>> wrong places between output directory and source tree directory
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>>  samples/bpf/Makefile        | 8 ++++----
>>  samples/bpf/Makefile.target | 2 +-
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 615f24ebc49c..32469aaa82d5 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>  # TPROGS_CFLAGS causes conflicts
>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
>> -		     -I$(src)/../../tools/include \
>> +		     -I$(srctree)/tools/include \
> 
> [..]
> 
>>  		     -I$(src)/../../tools/include/uapi \
> 
> Does this $(src) need to be changed as well?

I think this line doesn't affect the build. I removed it and it still
compiles (after "make -C samples/bpf clean"). I guess xdp_sample_user.c
doesn't include any file in tools/include/uapi. Am I missing something
or should I remove this line?

> 
> 
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
> 
> This parts seems to be copy-pasted all over the place in its 'ifeq'
> form. What is it doing and why is it needed?
> 
>>  ifdef building_out_of_srctree
>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>  endif
>> -- 
>> 2.34.1

