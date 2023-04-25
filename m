Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2456EDE97
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjDYI5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDYI5X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 04:57:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0B10DE
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 01:57:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so26670045e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682413039; x=1685005039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IatPhWkS7kXHNYw/LMRL8AKSu2Xban6SY9XiEQ0UbuE=;
        b=A4qlge16yFv+9UUBED8DwB3CpwcMvkHy47I9ZPC3tVY2qFmyQkVEAT+Ifre5YvtJt2
         Xb5SNcrz9qpm4DgOO4DmjrN6dZqkqvbTygoRXDF3YdJHiEDFF0NZd/zySjhHERKg/bWa
         LNSvaOQvBBl1EOZfh6GywgBChs3CS5MZHtaZ8VS+NeizsM/I/qQFQWkoOpAzI7+qsz7z
         RmaMhP9x2oqtrrxq3QkmYvqOGyazp0qtrnzpNxQLoRm9e45M2UdYX92KxXIapjz99gHe
         lPKZxByRISbqo46iqL6ExBUZkjQTJ1RXQQulHAHcW6Hx34ZZoTiMUaeOWhOgncfGlT4h
         0LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682413039; x=1685005039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IatPhWkS7kXHNYw/LMRL8AKSu2Xban6SY9XiEQ0UbuE=;
        b=P9hh0N6kVMOFeDi3l0UZIwAIzIiEUnBu2tmpRrP9ed0eqKvmwBlrfJv/NcKSEv7Srr
         yCq4c3PskZdkrbb++WIb2Vhuz8qqt1Qo8qGEeLGAGwbfZyIYkA/ExqEC84eLnCfsbmN3
         H+m9MJDB2MFjwnqevrfAnp6wMfrOqawZUjs/mcQUFTVQMdPDmU0/vjd9z5FkqgLsGWrF
         G1SHoAClvmkMRdDNRoRYct0LwMEuNDS8S+1+jebW+YzpMDC9LucjT6U0OrAWSqQ8ou+3
         ou28wfgebLVOw0z32QyazvCfoJvAlouxfOGQ5hYfrn+3tsQCBokpjlIa3wnP78lqFRqD
         TGCw==
X-Gm-Message-State: AAQBX9cWhMu5kfqVP4mCMSfZH7kZ7IzY0eEJJh72O+S5yVkg1C46jqLT
        MGWd451HfhLF75H6H8Z4eiZi0Q==
X-Google-Smtp-Source: AKy350ZfqbGzh3y7nA6BysMdjdjoeKVHTAZG8yejEO8cIxrcwf4n7Z9FsaXanJbDCjOudEBOO/ZeMg==
X-Received: by 2002:a05:600c:24cd:b0:3f1:79ad:f3a8 with SMTP id 13-20020a05600c24cd00b003f179adf3a8mr9037127wmu.16.1682413038872;
        Tue, 25 Apr 2023 01:57:18 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:fc75:a52a:6ef6:7ac6? ([2a02:8011:e80c:0:fc75:a52a:6ef6:7ac6])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c365500b003f182a10106sm14443185wmq.8.2023.04.25.01.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 01:57:18 -0700 (PDT)
Message-ID: <fa14348d-b7ce-2a0e-d0f6-387162621ae8@isovalent.com>
Date:   Tue, 25 Apr 2023 09:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for
 map_of_maps types
Content-Language: en-GB
To:     Xueming Feng <kuro@kuroa.me>, yhs@meta.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org, yhs@fb.com
References: <561b0f03-4a3a-89d3-5793-a0d69535ca0f@meta.com>
 <20230425063750.72642-1-kuro@kuroa.me>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230425063750.72642-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-04-25 14:37 UTC+0800 ~ Xueming Feng <kuro@kuroa.me>
>> On 4/24/23 9:10 PM, Xueming Feng wrote:
>>>> On 4/24/23 2:09 AM, Xueming Feng wrote:
>>>>> When using `bpftool map dump` in plain format, it is usually
>>>>> more convenient to show the inner map id instead of raw value.
>>>>> Changing this behavior would help with quick debugging with
>>>>> `bpftool`, without disrupting scripted behavior. Since user
>>>>> could dump the inner map with id, and need to convert value.
>>>>>
>>>>> Signed-off-by: Xueming Feng <kuro@kuroa.me>
>>>>> ---
>>>>> Changes in v2:
>>>>>     - Fix commit message grammar.
>>>>> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
>>>>> 	  `n` to `arg_size`.
>>>>>     - Make `print_uint` able to take any size of argument up to `unsigned long`,
>>>>> 		and print it as unsigned decimal.
>>>>>
>>>>> Thanks for the review and suggestions! I have changed my patch accordingly.
>>>>> There is a possibility that `arg_size` is larger than `unsigned long`,
>>>>> but previous review suggested that it should be up to the caller function to
>>>>> set `arg_size` correctly. So I didn't add check for that, should I?
>>>>>
>>>>>    tools/bpf/bpftool/main.c | 15 +++++++++++++++
>>>>>    tools/bpf/bpftool/main.h |  1 +
>>>>>    tools/bpf/bpftool/map.c  |  9 +++++++--
>>>>>    3 files changed, 23 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>>>>> index 08d0ac543c67..810c0dc10ecb 100644
>>>>> --- a/tools/bpf/bpftool/main.c
>>>>> +++ b/tools/bpf/bpftool/main.c
>>>>> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>>>>>    	return 0;
>>>>>    }
>>>>>    
>>>>> +void print_uint(const void *arg, unsigned int arg_size)
>>>>> +{
>>>>> +	const unsigned char *data = arg;
>>>>> +	unsigned long val = 0ul;
>>>>> +
>>>>> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>>>> +		memcpy(&val, data, arg_size);
>>>>> +	#else
>>>>> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
>>>>> +		       data, arg_size);
>>>>> +	#endif
>>>>> +
>>>>> +	fprintf(stdout, "%lu", val);
>>>>> +}
>>>>> +
>>>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>>>>>    {
>>>>>    	unsigned char *data = arg;
>>>>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>>>>> index 0ef373cef4c7..0de671423431 100644
>>>>> --- a/tools/bpf/bpftool/main.h
>>>>> +++ b/tools/bpf/bpftool/main.h
>>>>> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>>>>>    
>>>>>    bool is_prefix(const char *pfx, const char *str);
>>>>>    int detect_common_prefix(const char *arg, ...);
>>>>> +void print_uint(const void *arg, unsigned int arg_size);
>>>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>>>>>    void usage(void) __noreturn;
>>>>>    
>>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>>> index aaeb8939e137..f5be4c0564cf 100644
>>>>> --- a/tools/bpf/bpftool/map.c
>>>>> +++ b/tools/bpf/bpftool/map.c
>>>>> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>>>>>    		}
>>>>>    
>>>>>    		if (info->value_size) {
>>>>> -			printf("value:%c", break_names ? '\n' : ' ');
>>>>> -			fprint_hex(stdout, value, info->value_size, " ");
>>>>> +			if (map_is_map_of_maps(info->type)) {
>>>>> +				printf("id:%c", break_names ? '\n' : ' ');
>>>> 1> +				print_uint(value, info->value_size);
>>>
>>> On Mon, 24 Apr 2023 18:07:27 -0700, Yonghong Song wrote:
>>>> For all map_in_map types, the inner map value size is 32bit int which
>>>> represents a fd (for map creation) and a id (for map info), e.g., in
>>>> show_prog_maps() in prog.c. So maybe we can simplify the code as below:
>>>> 	printf("id: %u", *(unsigned int *)value);
>>>
>>> That is true, maybe the "id" could also be changed to "map_id" to follow the
>>> convention. Do you think that `print_uint` could be useful in the future?
>>> If that is the case, should I keep using it here as an example usage, and to
>>> avoid dead code? Or should I just remove it?

This makes me think we could also have something similar for prog_array
maps (but not necessarily as part of your patchset).

> 
> On Mon, 24 Apr 2023 22:58:10 -0700, Yonghong Song wrote:
>> Maybe, "inner_map_id" is a better choice. For array of maps, some array 
>> element value could be 0, implying "inner_map_id 0", but I think it is
>> okay, people should know a real inner_map_id (or any map_id) should 
>> never be 0.
>>
>> Function "print_uint" is not needed any more. Please remove it.
> 
> Will reflect this in v3.
> 
>>
>> Please add the command line to dump map values triggering the above 
>> change, also the actual dumps with and without this patch.
> 
> $ bpftool map dump id 138
> Without patch:
> ```
> key:
> fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
> 27 16 06 00
> value:
> 8b 00 00 00
> Found 1 element
> ```
> With patch:
> ```
> key:
> fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
> 27 16 06 00
> inner_map_id:
> 139 
> Found 1 element
> ```

Thanks! Please add those sample outputs to the commit description for
v3. Can you please also add an example with JSON ("-p")?

Quentin

