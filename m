Return-Path: <bpf+bounces-7025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FBE7705AC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D87A1C21876
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE45198AC;
	Fri,  4 Aug 2023 16:14:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586A1805D
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:14:41 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C2BB2
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:14:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso2450046276.2
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691165679; x=1691770479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy2JIU353wbCbQbN7Tel2gpmmHTjuzDFhXI8/QXqwDA=;
        b=C0e04tdL6K7wQD/Jh6B7E8WSmgWwAD/duwFMvzFI4bGY6HjGqBzIJnnnqdKts+j5M3
         vzOe+vaTWSnajl9sq9e2dWdzAkGoAFFRDnoFTRBjYt55NphO54rXn7Vllj500t69bUK+
         r/8NpYgFVnc3tzMsEF0ypLn+AmLmEu5k+JQ2Eaj1xzHKPShyhp87OOpQ1AuhsV0K88pO
         dYjSVEtsjuYmJdbPU7xzcZfbkaga9v2mD2SvKjJaMYjxT8awzvZvilxwVPuBDi2g6bFl
         GoDWYIufG4eAoTFfmUkcneCD+rsgdk35jUNdkt5Wow5XW03r6ROBbcBlc8bBwGZOpJTf
         67Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165679; x=1691770479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy2JIU353wbCbQbN7Tel2gpmmHTjuzDFhXI8/QXqwDA=;
        b=VySaQdH5DdV1ZWpWGOrqGMSN1PfB1AqrTCNvDrL2IdNhLiVJwNXnVrnf3lnXt541mC
         N1qw0LMCrK48LhIXvwN89Rlu0ZglbrK77s+exOnB2lJ+3IL4XEfWEzGmJwTcTpLJHD6F
         AzRDQUv+LXMdbu4is+8CX3MXEGCUgE6Eh9UZ0RujZEteEmCBQMPglSMdlTSi6I8lh1ZV
         ORclPAQrs+lGok1xPuwXGkEA+gaRcqZ14uokJd2kM5uIvrcEN+a45LLPP0uv4ZNa7/3u
         o1YWQY+L+kOWUjMKHLPznPW4klBvCBSbtvvvMAEY5ZR8sSxjs/LYDUHxbV9RdmazKm2p
         xiBw==
X-Gm-Message-State: AOJu0Yw8fNTfepuVGfMD1M2qhBFyIyDuuM8eGFfP4ZimoVuUk2EDP3Cg
	btNBL+FzPxZvgegjErKDPpA=
X-Google-Smtp-Source: AGHT+IFIGEpmx4nIPfMvP/0jD5Rf0xQbWkJ4pUVA1dt6GlM5U8MrYv+3tP9XXSW44u8fGYJFAUoKDA==
X-Received: by 2002:a25:6806:0:b0:d17:6abc:4695 with SMTP id d6-20020a256806000000b00d176abc4695mr2998985ybc.62.1691165678979;
        Fri, 04 Aug 2023 09:14:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:174:cd0c:d94f:4c1f? ([2600:1700:6cf8:1240:174:cd0c:d94f:4c1f])
        by smtp.gmail.com with ESMTPSA id j131-20020a255589000000b00d0bad22d652sm711888ybb.36.2023.08.04.09.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:14:38 -0700 (PDT)
Message-ID: <76c674b9-1298-5f90-2202-d56570b95792@gmail.com>
Date: Fri, 4 Aug 2023 09:14:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix the incorrect verification of
 port numbers.
To: yonghong.song@linux.dev, thinker.li@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, dan.carpenter@linaro.org
Cc: kuifeng@meta.com
References: <20230803215316.688220-1-thinker.li@gmail.com>
 <2501f80c-23c6-a509-fd6a-c44797d9f345@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <2501f80c-23c6-a509-fd6a-c44797d9f345@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 18:30, Yonghong Song wrote:
> 
> 
> On 8/3/23 2:53 PM, thinker.li@gmail.com wrote:
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
>> Fixes: 8a8c2231cab2 ("selftests/bpf: fix the incorrect verification of 
>> port numbers.")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: 
>> https://lore.kernel.org/bpf/cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain/
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Ack with a small nit below.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
>> ---
>>   tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c 
>> b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> index 95bab61a1e57..0df95bc88a9b 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> @@ -110,11 +110,13 @@ static int connect_client_server_v6(int 
>> client_fd, int listen_fd)
>>           .sin6_family = AF_INET6,
>>           .sin6_addr = IN6ADDR_LOOPBACK_INIT,
>>       };
>> +    int port;
>>       int err;
> 
> No need for a separate line for 'int port'.
> Just doing 'int err, port;' sounds better.

Got it! Thanks!

> 
>> -    addr.sin6_port = htons(get_sock_port_v6(listen_fd));
>> -    if (addr.sin6_port < 0)
>> +    port = get_sock_port_v6(listen_fd);
>> +    if (port < 0)
>>           return -1;
>> +    addr.sin6_port = htons(port);
>>       err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
>>       if (err < 0) {

