Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050016EDB22
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 07:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjDYFT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 01:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDYFT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 01:19:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C71BC9;
        Mon, 24 Apr 2023 22:19:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b996127ec71so4206664276.0;
        Mon, 24 Apr 2023 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682399994; x=1684991994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+2gV9DQiHmLQJdOqC+WhOvIWGTo3P7fJoIundTeuNU=;
        b=SL66LD7/Yx+ry8j2b/Rbvh4aFxXaawJf5pzga/S+om1kdbebVMYYFWlxZDsQMAa3ik
         i7ZuPqs+sVh7HeqLLdc0jrWHyPUbkLw/8kIs37R6ucRQPRMDHu+8wanPQid55CNRUMcx
         xMVN7/Zc8M6yRryJ7l3qYZzAboz5XP4w+Xcy7p2rE86ld+lNQOQiZBynQ7lu5iwUbet5
         9x0Ofu8iC+3f0lsObL9Cc5DZWCqH1X+vZS7du7HaBrUhbl23XlMzLblo2TGmQVN7k2AJ
         ui6250cJtfX2ku4dag6utC+DAKTIoqwkXZDi4+UB7Q6ewAOHMoBW/YLQxHJrkuAZAc3P
         cn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682399994; x=1684991994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+2gV9DQiHmLQJdOqC+WhOvIWGTo3P7fJoIundTeuNU=;
        b=XIkwzU9T5BLisUN02KHdj+Dlxx1SKtK7lLO3zFziA/rrEft1epmhPMx5syrdT2Kntl
         GUMpXPEbl87qB3RdZe9Y9A1bUTvNGzuufxlMNLicwVE7pQSibRtIrT8CusiO+rh7LKh5
         hyXe0lnUoTpE4VOWxjYZyZ1E0Sr/g2FhT5lWpP9pB2n44QQdd4QP4yvheF7VV/p2BRzz
         9Zrxtl9RDrwoHl4VGjiCjKS6FXMhdMMnYmO5z05LUWWrMawkWrJ0WcnsO/VKmdyIcJ6R
         LoLnQ8kPugENQGi3vINZVspAo68EtsYkthBmrq+onvuGIUhAhhZcpdq1HW4DQLwhy1rX
         /RQw==
X-Gm-Message-State: AAQBX9d52rOg+I5CGJytgV8Dj6T1EyH5i6pU4b2MIQpRhlZXpZfvrHAR
        FXyr5t8Iqoezms9I1iav0mg=
X-Google-Smtp-Source: AKy350bLfv0pBevlxtfGW/6CL7b+uW0xyWO9gCC2Q4op1yUG+r3QVYszjMxD5qSJTJ0OUQYYbec3rw==
X-Received: by 2002:a25:2493:0:b0:b93:6a15:5dda with SMTP id k141-20020a252493000000b00b936a155ddamr12822323ybk.29.1682399994352;
        Mon, 24 Apr 2023 22:19:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:10e6:a48a:c0d5:4f85? ([2600:1700:6cf8:1240:10e6:a48a:c0d5:4f85])
        by smtp.gmail.com with ESMTPSA id l16-20020a0de210000000b00555ccdd7948sm3384204ywe.98.2023.04.24.22.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 22:19:53 -0700 (PDT)
Message-ID: <6353e12d-6fe6-f42b-4277-b32e2b2268a8@gmail.com>
Date:   Mon, 24 Apr 2023 22:19:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for
 map_of_maps types
Content-Language: en-US
To:     Xueming Feng <kuro@kuroa.me>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, quentin@isovalent.com, sdf@google.com,
        song@kernel.org, yhs@fb.com
References: <f804fd67-87a9-4762-7e31-23abacdf6086@gmail.com>
 <20230425035803.49919-1-kuro@kuroa.me>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230425035803.49919-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 20:58, Xueming Feng wrote:
>> On 4/24/23 02:09, Xueming Feng wrote:
>>> When using `bpftool map dump` in plain format, it is usually
>>> more convenient to show the inner map id instead of raw value.
>>> Changing this behavior would help with quick debugging with
>>> `bpftool`, without disrupting scripted behavior. Since user
>>> could dump the inner map with id, and need to convert value.
>>>
>>> Signed-off-by: Xueming Feng <kuro@kuroa.me>
>>> ---
>>> Changes in v2:
>>>     - Fix commit message grammar.
>>> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
>>> 	  `n` to `arg_size`.
>>>     - Make `print_uint` able to take any size of argument up to `unsigned long`,
>>> 		and print it as unsigned decimal.
>>>
>>> Thanks for the review and suggestions! I have changed my patch accordingly.
>>> There is a possibility that `arg_size` is larger than `unsigned long`,
>>> but previous review suggested that it should be up to the caller function to
>>> set `arg_size` correctly. So I didn't add check for that, should I?
>>>
>>>    tools/bpf/bpftool/main.c | 15 +++++++++++++++
>>>    tools/bpf/bpftool/main.h |  1 +
>>>    tools/bpf/bpftool/map.c  |  9 +++++++--
>>>    3 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>>> index 08d0ac543c67..810c0dc10ecb 100644
>>> --- a/tools/bpf/bpftool/main.c
>>> +++ b/tools/bpf/bpftool/main.c
>>> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>>>    	return 0;
>>>    }
>>>    
>>> +void print_uint(const void *arg, unsigned int arg_size)
>>> +{
>>> +	const unsigned char *data = arg;
>>> +	unsigned long val = 0ul;
>>> +
>>> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>> +		memcpy(&val, data, arg_size);
>>> +	#else
>>> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
>>> +		       data, arg_size);
>>> +	#endif
> 
> On Mon, 24 Apr 2023 09:44:18 -0700, Kui-Feng Lee wrote:
>> Is it possible that arg_size is bigger than sizeof(val)?
> 
> Yes it is possible, I had the thought of adding a check. But as I mentioned
> before the diff section, previous review
> https://lore.kernel.org/bpf/20230421101154.23690-1-kuro@kuroa.me/ suggested that
> I should leave it to the caller function to behave. If I were to add a check,
> what action do you recommend if the check fails? Print a '-1', do nothing,
> or just use the first sizeof(val) bytes?

In the previous patch, it may have integer overflow, but it is never 
buffer underrun.  This version uses memcpy and may cause buffer underrun 
if arg_size is bigger than sizeof(val).  I would say that at least 
prevent buffer underrun from happening.

> 
>>> +
>>> +	fprintf(stdout, "%lu", val);
>>> +}
>>> +
>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>>>    {
>>>    	unsigned char *data = arg;
>>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>>> index 0ef373cef4c7..0de671423431 100644
>>> --- a/tools/bpf/bpftool/main.h
>>> +++ b/tools/bpf/bpftool/main.h
>>> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>>>    
>>>    bool is_prefix(const char *pfx, const char *str);
>>>    int detect_common_prefix(const char *arg, ...);
>>> +void print_uint(const void *arg, unsigned int arg_size);
>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>>>    void usage(void) __noreturn;
>>>    
>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>> index aaeb8939e137..f5be4c0564cf 100644
>>> --- a/tools/bpf/bpftool/map.c
>>> +++ b/tools/bpf/bpftool/map.c
>>> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>>>    		}
>>>    
>>>    		if (info->value_size) {
>>> -			printf("value:%c", break_names ? '\n' : ' ');
>>> -			fprint_hex(stdout, value, info->value_size, " ");
>>> +			if (map_is_map_of_maps(info->type)) {
>>> +				printf("id:%c", break_names ? '\n' : ' ');
>>> +				print_uint(value, info->value_size);
>>> +			} else {
>>> +				printf("value:%c", break_names ? '\n' : ' ');
>>> +				fprint_hex(stdout, value, info->value_size, " ");
>>> +			}
>>>    		}
>>>    
>>>    		printf("\n");
