Return-Path: <bpf+bounces-7187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9C772C6C
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC9B1C20C49
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CCD125DB;
	Mon,  7 Aug 2023 17:13:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087E125D0
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 17:13:26 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A810E9
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 10:13:03 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso4323606276.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428375; x=1692033175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3aOJIQOm35AgITJDIMD09MqPKL6EICdm0WL8UW7ijM=;
        b=NjJ4vNtcHCNGq3wDfENW6g66tkYgeFM444YJQrmvjONx5pSaqzY4fnSe14KJFiPAnc
         3TETDviDyn/w0e9xh0zXXPoOEGi32Mt22FfiVR8JoMVcHgGvT5/pM2tA57Kmt2FA4+U7
         534RQ8bSFOXf6eacNsG86SDIRl6koMD7eoNQwNLaN1pYu0EOaynXL4C/WfYkmWToN9Nn
         cIdzBhu4OwoaywOuYW1aTSvoQwSPsegSjBIgVmXx098USEAcf/luZN720yUahwi+Bmwz
         OBKy2Eyfgiw+3nrRcJH7PlQyKJcLUUWoJDY9PThBOAX1YpPOsl18QCg1EJEUL8kPB32s
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428375; x=1692033175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3aOJIQOm35AgITJDIMD09MqPKL6EICdm0WL8UW7ijM=;
        b=Xo07Oe8M8M3K1MgfCT4Bz7+YFQGQKJ3h7kAb7KbTABgPDHYzY9AmeCv268SuXpH4Ix
         74LXfWLA1D7Y5RHPy8wW/nmd2ZgUA6PTTHDOXIeNx1MUPwgnRHvQDFJLXwrZoeQZUR9C
         pZNtW3M7sAr3R5n6LCGsHe8cJkHhxFJu8jJOWDrXcc7gb4Y4Gb9N/0cejP/IEHc70rlV
         17QKFmyJaOieNRBtF91EgkUXFZz+Uv4SWEX3oy0jIq5+eWdW5RY5tD35PPVf36fEa/bZ
         cziQLhP8cwRGfMAFOAvCB9W1V4KA5vhG2JMzTQs7eHJDor+sn8Qd6MtAdm68OZih7SYI
         S9Sg==
X-Gm-Message-State: AOJu0YwSibTz+1HcdmT0+VHQRtSz1J86vRrmdXhvSU+0SXIA+VEca4zN
	MF5Eouh211LfDN4u2L9I5j8=
X-Google-Smtp-Source: AGHT+IErzv6nq1ftenQ4qbudgGnXQZcLURhI1MFMIEgB/Izu5YCxnZypy/+MZiF+JK5qHf1xlTMeYw==
X-Received: by 2002:a25:944:0:b0:cb4:6167:a69c with SMTP id u4-20020a250944000000b00cb46167a69cmr8965729ybm.8.1691428374970;
        Mon, 07 Aug 2023 10:12:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:24f0:2f4c:34ea:71b5? ([2600:1700:6cf8:1240:24f0:2f4c:34ea:71b5])
        by smtp.gmail.com with ESMTPSA id c133-20020a254e8b000000b00d2a002a88desm2399913ybb.22.2023.08.07.10.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 10:12:54 -0700 (PDT)
Message-ID: <101e3512-f688-1af2-16f6-70c804888f60@gmail.com>
Date: Mon, 7 Aug 2023 10:12:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix the incorrect verification
 of port numbers.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, dan.carpenter@linaro.org,
 yonghong.song@linux.dev
References: <20230804165831.173627-1-thinker.li@gmail.com>
 <c2776380-7550-3777-24a0-1f155785696c@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c2776380-7550-3777-24a0-1f155785696c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/4/23 14:37, Martin KaFai Lau wrote:
> On 8/4/23 9:58 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Check port numbers before calling htons().
>>
>> According to Dan Carpenter's report, Smatch identified incorrect port
>> number checks. It is expected that the returned port number is an 
>> integer,
>> with negative numbers indicating errors. However, the value was 
>> mistakenly
>> verified after being translated by htons().
>>
>> Major changes from v1:
>>
>>   - Move the variable 'port' to the same line of 'err'.
>>
>> Fixes: 539c7e67aa4a ("selftests/bpf: Verify that the cgroup_skb 
>> filters receive expected packets.")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: 
>> https://lore.kernel.org/bpf/cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain/
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c 
>> b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> index 95bab61a1e57..d686ef19f705 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> @@ -110,11 +110,12 @@ static int connect_client_server_v6(int 
>> client_fd, int listen_fd)
>>           .sin6_family = AF_INET6,
>>           .sin6_addr = IN6ADDR_LOOPBACK_INIT,
>>       };
>> -    int err;
>> +    int err, port;
>> -    addr.sin6_port = htons(get_sock_port_v6(listen_fd));
>> -    if (addr.sin6_port < 0)
>> +    port = get_sock_port_v6(listen_fd);
>> +    if (port < 0)
> 
> Applied. Some follow up questions:
> 
> Does other get_sock_port_v6() usage need to check -1 also?
> 
> It is a good idea to see if similar helpers exist in network_helpers.c 
> e.g. There is get_socket_local_port() that supports both v4 and v6 in 
> network_helpers.c which is equivalent to the get_sock_port_v6() here.
> To a larger extent, I believe many codes in this new test can be saved 
> by using the helpers in network_helpers.c. For example, the 
> connect_client_server_v6() here can be replaced with connect_to_fd() 
> from network_helpers.c to avoid the mistake this patch fixing. It also 
> has some timeout limit on the socket such that it won't block the 
> test_progs for a long time.


Got it! I will check the code to send another patch if necessary.



