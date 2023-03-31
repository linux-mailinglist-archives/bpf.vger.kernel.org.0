Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE56D2A13
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCaViK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCaViJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 17:38:09 -0400
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210351EFE3
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 14:38:07 -0700 (PDT)
Message-ID: <ed663574-bf37-f7a6-633f-b472f4ef2db7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680298686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WP8eVCZrW4M8nSz2YAF7sY2uo044VW8i7c0J+1xvNA4=;
        b=AvvFDF5H4/UgRM+n72y8MtBKdy/NjzTPoEcHm01hwNalsvcUH+ZQZhwlDAz6oi298OU8mp
        Lx/SYnDZ4BT7n1GZeSDhjRxuAGNcnlIukYJ09Hpkbq0nZ3ygfP8UuQArxNMyBSgRDbbDX3
        BJZ8r3UvKUDRl9pg10vk/XMxALORR44=
Date:   Fri, 31 Mar 2023 14:37:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 6/7] selftests/bpf: Add helper to get port
 using getsockname
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-7-aditi.ghag@isovalent.com>
 <ZCXX1LF5FXpT1ALr@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZCXX1LF5FXpT1ALr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 11:41 AM, Stanislav Fomichev wrote:
>> +int get_sock_port6(int sock_fd, __u16 *out_port)
>> +{
>> +    struct sockaddr_in6 addr = {};
>> +    socklen_t addr_len = sizeof(addr);
>> +    int err;
>> +
>> +    err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
>> +    if (err < 0)
>> +        return err;
>> +    *out_port = addr.sin6_port;
> 
> The rest of the helpers don't usually care about v4 vs v6.
> Making it work for both v4 and v6 seems trivial, so maybe let's do it?

A nit on top of this. Rename it to 'int get_local_port(int sock_fd)' such that 
it is clear which port it is getting.

> 
>> +
>> +    return err;
>> +}
>> diff --git a/tools/testing/selftests/bpf/network_helpers.h 
>> b/tools/testing/selftests/bpf/network_helpers.h
>> index f882c691b790..2ab3b50de0b7 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.h
>> +++ b/tools/testing/selftests/bpf/network_helpers.h
>> @@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data, 
>> unsigned int data_len,
>>   int make_sockaddr(int family, const char *addr_str, __u16 port,
>>             struct sockaddr_storage *addr, socklen_t *len);
>>   char *ping_command(int family);
>> +int get_sock_port6(int sock_fd, __u16 *out_port);
> 
>>   struct nstoken;
>>   /**
>> -- 
>> 2.34.1
> 

