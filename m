Return-Path: <bpf+bounces-6896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25476F41D
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 22:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C71C21606
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9F2591C;
	Thu,  3 Aug 2023 20:43:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3A1F92A
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 20:43:37 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97DF30EA
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 13:43:35 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-585fd99ed8bso36150257b3.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691095415; x=1691700215;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQoyZZ/10l+Rrl6KnM4XlkCHK0oCVWe3BDjvX7ucPAY=;
        b=h2YN3Uix+FYSwEuitKyVW/LZhFgOSsXOAw5q9PJUjp9faVQO/1jOJAjCxttrBpqW85
         x0exce+YJv8FJY35Vl1d3FwskDl1Tm9LAWxh5KKCkszskyc3fAkdTAV17y9PsDoYIWdF
         tX1bjkMGjlLD2AuvH0i3v110j/g25Xyj0CU4iSIC4XIeKuXNMHX+HDC24sWxvo4WXav2
         TAnTYY4yDeUN1qLhP9yK0HigmzaQpayObV1I9HrSSJc25sLKWsOGZXZyPmmju59NWcuW
         A3F9R0hfD78ujHKavGY2UKvcSNskVzKXVWKevgUkvr9hBs5qu7dUuLja8Oj+gBsRgIsk
         40Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095415; x=1691700215;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQoyZZ/10l+Rrl6KnM4XlkCHK0oCVWe3BDjvX7ucPAY=;
        b=S6oWG+3sFVoFBNTVsUZtZHa+GdOhX8ZGpSOJBAXtjJ5HMW9tjfYrmujQqeANVW2+Dt
         VzkPQnc4/vR6S4ZokgF5QDnRede00+gmxcm768oeedJndm/KwChFEBCAJL+YjBT3oMAf
         0OFgGgH194kFXmupmVl8OTCMC1tNy/timsJ2KXVIMcFnnqYmOJV7KWBe6nteqECYNPdB
         jO5grgTjZhFcKue3JCiyElj8XQ1HEFouRugpIchU5RZrIfXpw9mGgmHFeJhkwGR8XMcT
         mGx/cXcvr0v2U0fXKJaGp5zjutGZU4emD/3wqVGM3IjMyoRn7DtXJKUqB3LtJYO0xOny
         Lz8A==
X-Gm-Message-State: ABy/qLYO8gPInwM1SbMFbFtpH8bHBdCqDK3PCsNAkij0XW3YixKgB/4A
	oU1j8g6bHr3zdKWcpDS6vP+8beyBfw8=
X-Google-Smtp-Source: APBJJlEiOrLBtiQ7lQoUoCeW6Anhmc/4Yu0QNfg+3nignAoTQQh0/QIEpIpLiotzLQ7f8p29EzjtUQ==
X-Received: by 2002:a0d:ea0a:0:b0:56c:e480:2b2b with SMTP id t10-20020a0dea0a000000b0056ce4802b2bmr22336290ywe.12.1691095415099;
        Thu, 03 Aug 2023 13:43:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:c07f:1e98:63f3:8107? ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id r3-20020a815d03000000b0057682d3f95fsm211779ywb.136.2023.08.03.13.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 13:43:34 -0700 (PDT)
Message-ID: <eb2997ef-0fd4-a564-d166-9459b017e10c@gmail.com>
Date: Thu, 3 Aug 2023 13:43:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] selftests/bpf: Verify that the cgroup_skb filters
 receive expected packets.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org
References: <cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain>
 <8820810d-572f-1e63-0b58-a496fe49b4f1@gmail.com>
In-Reply-To: <8820810d-572f-1e63-0b58-a496fe49b4f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 12:52, Kui-Feng Lee wrote:
> 
> 
> On 7/31/23 00:27, Dan Carpenter wrote:
>> Hello Kui-Feng Lee,
>>
>> The patch 539c7e67aa4a: "selftests/bpf: Verify that the cgroup_skb
>> filters receive expected packets." from Jun 23, 2023 (linux-next),
>> leads to the following Smatch static checker warning:
>>
>>     ./tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c:116 
>> connect_client_server_v6()
>>     warn: unsigned 'addr.sin6_port' is never less than zero.
>>
>> ./tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>>      107 static int connect_client_server_v6(int client_fd, int 
>> listen_fd)
>>      108 {
>>      109         struct sockaddr_in6 addr = {
>>      110                 .sin6_family = AF_INET6,
>>      111                 .sin6_addr = IN6ADDR_LOOPBACK_INIT,
>>      112         };
>>      113         int err;
>>      114
>>      115         addr.sin6_port = htons(get_sock_port_v6(listen_fd));
>> --> 116         if (addr.sin6_port < 0)
>>                      ^^^^^^^^^^^^^^^^^^
>> Impossible and also it doesn't make sense to compare network endian data
>> with < 0.
> 
> Hi Dan,
> 
> Thank you for pointing it out. It should check the returned value
> of get_sock_port_v6() before calling htons(). I will send a patch
> to fix it asap.

Could you show me how to run Smatch againt bpf selftests?

> 
> 
>>
>>      117                 return -1;
>>      118
>>      119         err = connect(client_fd, (struct sockaddr *)&addr, 
>> sizeof(addr));
>>      120         if (err < 0) {
>>      121                 perror("connect");
>>      122                 return -1;
>>      123         }
>>      124
>>      125         return 0;
>>      126 }
>>
>> regards,
>> dan carpenter
>>

