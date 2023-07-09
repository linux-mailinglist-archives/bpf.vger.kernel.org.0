Return-Path: <bpf+bounces-4527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B974C10D
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 07:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268891C20936
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 05:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1011FA9;
	Sun,  9 Jul 2023 05:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2C1C06
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 05:12:38 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BEE43
	for <bpf@vger.kernel.org>; Sat,  8 Jul 2023 22:12:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5577905ef38so1163758a12.0
        for <bpf@vger.kernel.org>; Sat, 08 Jul 2023 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688879555; x=1691471555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNF19ZMVxPJxD4f7WudQdS1jVPLGXr8B+mLMhECWzsc=;
        b=fVEyg/oJHqCRwBhmhCApjYwZfoaRWvciDV6nxC13Y/vHNGEQnv6wugFL+KG8RUVRC9
         S9QxOG8IxuaP/GNjV2mGeNngwn364pSSi+y00HgLoJyYMQmmyFRAk4fhNXSkdg3/eA/A
         7f65lzv5Px5CZuMmup/pitzuwrakBakRygoDBSyb2xqFnJK15NEHxtlf/Bd8z8FHDXND
         OXfMt8yqbjXcoPw6RCRmKO+EckIGUWpN0HRK9n9NSgWDNMpQvq9R0vBDKN3HlEmc7bPe
         YmwzySw1/yh0a0P/GzFqL68nMXxgaDjkzhuqn0hv1sAwnXZbnqudoESUzu50tlQLhOrN
         0Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688879555; x=1691471555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNF19ZMVxPJxD4f7WudQdS1jVPLGXr8B+mLMhECWzsc=;
        b=PF7Ny3ed51JhI3IRDGNxCN8WFHUIspHPQhb4YabILjB0cOKY9ZjunoaQSE65mHrS0s
         dNNphCKYp8jiCB0lZhNGZWdx7Jtje1oVaojTpx9jj0+65TaEqeIagIBYB4DmCHVU0Y1R
         CTgYhoucaawDPvObNGcpT7dtJZOl03uFD6EDui5/2Isy1oGwN+x/y6cuX7z7Ry9Nc9F0
         Z9L+WduKxNJyfOvez6FpDYznl3vuFS8Dwq+NOCxZc+pYngZ24eTWjM+3K8tBLOhbKcva
         6Jz/GxSVWA63hEmB7eiwuL75yYrmgVQI9g+c3an9iJn+EoL/IZZwdLx8DlKQLA/U+fWg
         N1kw==
X-Gm-Message-State: ABy/qLZEZxgKH5mzVB4CfOZznw1j4WGZiGcWs+qvqb0n35mmEcfmeQYV
	CPFw9qqSsxhqhu9MqGZzh6M=
X-Google-Smtp-Source: APBJJlEqXwMw0x/zBgTyLTWou0rNKbY1GbIW53YQpZ05waizLgLQmHoAwMEXgp/OD5B9czGx3ieG1g==
X-Received: by 2002:a17:903:260e:b0:1b8:7483:d488 with SMTP id jd14-20020a170903260e00b001b87483d488mr6624432plb.57.1688879555469;
        Sat, 08 Jul 2023 22:12:35 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090acc0600b00263b4b1255esm3752018pju.51.2023.07.08.22.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 22:12:35 -0700 (PDT)
Message-ID: <38ff5cf8-0f71-a156-d88b-e3ec74897790@gmail.com>
Date: Sun, 9 Jul 2023 12:12:31 +0700
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adding one more discussion around your previous question that I missed.

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

Sorry for missing this question. As I understand KBUILD_EXTMOD
corresponding to external module. In my case, it's $M=samples/bpf. I
don't really know why it's needed here.

> 
>>  ifdef building_out_of_srctree
>>  _tprogc_flags   += -I $(objtree)/$(obj)
>>  endif
>> -- 
>> 2.34.1

