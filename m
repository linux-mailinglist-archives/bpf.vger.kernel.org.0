Return-Path: <bpf+bounces-6586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A576B934
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E104281B0F
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027701ADF8;
	Tue,  1 Aug 2023 15:56:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7A1ADCC
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 15:56:50 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1E1AA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:56:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ed1d2594so5529681b3a.2
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690905408; x=1691510208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5brpN+JyRMs3vCB0iiWfT8qohlTk0adzoJMdwAMhRRw=;
        b=chwMJPsT+e2dYwtSqJJQ+OhavdHRWJV0je94Nq3zltA8xtXrzEBqnoVrgKF1O/mv3V
         6ztWfqtYgdbAU/WXYxhOAMlySpTr1NL0Imks7mO1M3tHz5ImDub+Fqa/QqqTbaIqvvip
         nf4SXqRkOw0l4EShfsMDfOOA9iLrEYFzZh0ryCQZxCQrgn2/XFU1GL8fRJxHlQmDOoFm
         kb1vJXaxaHeOScD5skcn6ricXfbSolu8prKZOh6pB8OAygKezyBggN5h5+nOiXFmmVTH
         Bj1zk8rASqRfrAzUiu6ZmIcm0BhkTECMSbzoFhnlEBUE1N5KFU1ZHjQtbvpln46XA5jM
         UO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905408; x=1691510208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5brpN+JyRMs3vCB0iiWfT8qohlTk0adzoJMdwAMhRRw=;
        b=OzSTX0P12GsvkS+1X5KjjTilLQ5qiyjYz+w79YJBwTBfv55PvdsdCGKY9H/xNyxCsK
         t8xJ0Wlmbaj8h25Uy29qHauvTMLdMLqrSdwC5mh08ACNQZ7fhZQBvYH+WqMeRtNXAmOl
         yOg/fkClBVb427RX71x+xw645Pcz2uUK+ZzoQfC0GBbWSsMD6sTx06DwjWHU6OfMwjz3
         1YPTlf+K7gWn/miu4hRTF+Kcyr6tbqqdYeXGMi9FeAttb37WQ5VDF2FWK9y0G55M0cel
         Gb+P/F0zYmd9QS3Wasukhh5ioAt3qOgiK/KYDwxHvq/3wwTHK2o/0q4irDgnP2PYjsC4
         eL8A==
X-Gm-Message-State: ABy/qLafF+4DrUeZsF5rQ0vGHBtHxAZcePHNk6QyhQrpnUoacuT72ilN
	8abtB5AWLV7d4kbuBszNmQmlAxzHO9FAqJcq
X-Google-Smtp-Source: APBJJlGO4N2A+QNfVphxi3jNVqcxGseldJglR9AdCSYPrDVmcMjthurG8n3KtVAxoxLP6HEIaauI9w==
X-Received: by 2002:a05:6a00:150a:b0:687:4323:ec31 with SMTP id q10-20020a056a00150a00b006874323ec31mr6803175pfu.13.1690905408456;
        Tue, 01 Aug 2023 08:56:48 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id t7-20020aa79387000000b00686b649cdd0sm9541673pfe.86.2023.08.01.08.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 08:56:47 -0700 (PDT)
Message-ID: <34890307-ca7a-ffa8-321d-eb5ad0db4a5a@gmail.com>
Date: Tue, 1 Aug 2023 22:56:44 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] samples/bpf: Fix build out of source tree
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, bpf@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20230730131750.16552-1-tuananhlfc@gmail.com>
 <CAKH8qBtNaEW4pEj7Y1WiLoPk2aMPoq3AuO14D=OF_NCN255awQ@mail.gmail.com>
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <CAKH8qBtNaEW4pEj7Y1WiLoPk2aMPoq3AuO14D=OF_NCN255awQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 01/08/2023 00:17, Stanislav Fomichev wrote:
> On Sun, Jul 30, 2023 at 6:18 AM Anh Tuan Phan <tuananhlfc@gmail.com> wrote:
>>
>> This commit fixes a few compilation issues when building out of source
>> tree. The command that I used to build samples/bpf:
>>
>> export KBUILD_OUTPUT=/tmp
>> make V=1 M=samples/bpf
>>
>> The compilation failed since it tried to find the header files in the
>> wrong places between output directory and source tree directory
> 
> Still doesn't apply cleanly, most likely due to commit bbaf1ff06af4
> ("bpf: Replace deprecated -target with --target= for Clang").
> Please rebase and repost. Also add [PATCH bpf-next v4] tag.
> 

I rebased the commit from bpf tree so it's the reason for your failed 
applied. Have rebased from bpf-next tree and sent a "PATCH bpf-next v4" 
patch.

Thank you!

> 
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>> Changes from v1:
>> - Unconditionally add "-I $(objtree)/$(obj)" to _tprogc_flags and drop unnecessary part
>> Reference:
>> - v1: https://lore.kernel.org/all/67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com/
>> - v2: https://lore.kernel.org/all/2ba1c076-f5bf-432f-50c1-72c845403167@gmail.com/
>> ---
>>   samples/bpf/Makefile        | 10 +++++-----
>>   samples/bpf/Makefile.target |  9 +--------
>>   2 files changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 615f24ebc49c..cfc960b3713a 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>>   # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>>   # TPROGS_CFLAGS causes conflicts
>>   XDP_SAMPLE_CFLAGS += -Wall -O2 \
>> -                    -I$(src)/../../tools/include \
>> -                    -I$(src)/../../tools/include/uapi \
>> +                    -I$(srctree)/tools/include \
>> +                    -I$(srctree)/tools/include/uapi \
>>                       -I$(LIBBPF_INCLUDE) \
>> -                    -I$(src)/../../tools/testing/selftests/bpf
>> +                    -I$(srctree)/tools/testing/selftests/bpf
>>
>>   $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>>   $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>>   $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
>>          @echo "  CLANG-BPF " $@
>>          $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
>> -               -Wno-compare-distinct-pointer-types -I$(srctree)/include \
>> +               -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>>                  -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>>                  -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>>                  -c $(filter %.bpf.c,$^) -o $@
>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
>>
>>   LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
>>
>> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
>> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>>   BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
>>   BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
>>
>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
>> index 7621f55e2947..d2fab959652e 100644
>> --- a/samples/bpf/Makefile.target
>> +++ b/samples/bpf/Makefile.target
>> @@ -38,14 +38,7 @@ tprog-cobjs  := $(addprefix $(obj)/,$(tprog-cobjs))
>>   # Handle options to gcc. Support building with separate output directory
>>
>>   _tprogc_flags   = $(TPROGS_CFLAGS) \
>> -                 $(TPROGCFLAGS_$(basetarget).o)
>> -
>> -# $(objtree)/$(obj) for including generated headers from checkin source files
>> -ifeq ($(KBUILD_EXTMOD),)
>> -ifdef building_out_of_srctree
>> -_tprogc_flags   += -I $(objtree)/$(obj)
>> -endif
>> -endif
>> +                 -I $(objtree)/$(obj)
>>
>>   tprogc_flags    = -Wp,-MD,$(depfile) $(_tprogc_flags)
>>
>> --
>> 2.34.1
>>

