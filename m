Return-Path: <bpf+bounces-7036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB7770728
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0480A1C217AB
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791F51AA9C;
	Fri,  4 Aug 2023 17:32:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7741AA8E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 17:32:24 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7249EA
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:32:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58439daf39fso25403027b3.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691170335; x=1691775135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbU/I9bXCueM2/HIRsIrQHRAB+7w/eqi30LbATyo1tA=;
        b=GyM0yyuGw6VS9lXW7AqMxerhEdxbrsdZeNcNYQ5R4D9VUoID/74Q2fXoClo0AiWov4
         BRA6KXOPdYgPYOSySJSQl+QRVyJV9Tjtbb97VGzW/z2fYxUc6Qb3onYP6FjmL0im1C12
         C6RXCZsZbg9lPGOPpoVZU0EWXNpaip0xz1wWMMqZvRLOa5obeQmph8vF6XFaCIJQ3rgY
         t+Vqui1eBYdYeuc5vtSpJnP7drD+NgVV55RFqkpiWFDtxfNgwKlQwImQuvTAV/NhWN+q
         bPwr0rj6FdnjVZFBbx9zMETvEyd4rYYjiKb56L/0lwz7ejTdjqAaxa3ni+fe74Z4/cRo
         7X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170335; x=1691775135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbU/I9bXCueM2/HIRsIrQHRAB+7w/eqi30LbATyo1tA=;
        b=QBeVTNAqUaxV8Y6mSt0cNGXxva1KuspS+1Nh1ZGp0gLWevcPeRgxum6CM6/hdRS0wl
         f6lTGDJFeqrmmKssQc61A8T4ntSnaXJUvKOOc9fm208K4uSlSc6UtThbQObpSM5hlMw5
         Ddq6NxjIHM21woceXIfCxsQhSaDj8KVDmxX04ehKRWJCO9FN+ECPQyl6rDI3gXNwkohf
         0pS64XUFqzEUTVnFKzkTeMBPAduKzbQkZaRSE2vUqyszaxfsbHfpeNBm8rLrnyDYpKVb
         bMlAAlW/4gNtJROeIHBz72bAqVQ6IISZTbgQKwWGDS5wGLlHqOUhd/n9oNQDMaDFQUmj
         FJ2g==
X-Gm-Message-State: AOJu0Ywr4H9h2ayyiOM80Ey5ka/LIqCxU6hc84KUBUO9LsK7cfSWw/os
	WrR6dGn1j7pkFy3fwNIdAR8GgyAXJ9k=
X-Google-Smtp-Source: AGHT+IHips3eMRamo0CqciA2WeRA0UjdfAkmcj7Czx7lG0VkWpFn6/ukYtweLIUdNwNfbU5WqWr5CA==
X-Received: by 2002:a0d:d641:0:b0:586:9e0a:e3c4 with SMTP id y62-20020a0dd641000000b005869e0ae3c4mr2365637ywd.30.1691170334988;
        Fri, 04 Aug 2023 10:32:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:174:cd0c:d94f:4c1f? ([2600:1700:6cf8:1240:174:cd0c:d94f:4c1f])
        by smtp.gmail.com with ESMTPSA id m124-20020a0dca82000000b00570599de9a5sm846838ywd.88.2023.08.04.10.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 10:32:14 -0700 (PDT)
Message-ID: <0efe1e4d-fd1f-4841-862f-8686ef366c40@gmail.com>
Date: Fri, 4 Aug 2023 10:32:13 -0700
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
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org
References: <cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain>
 <8820810d-572f-1e63-0b58-a496fe49b4f1@gmail.com>
 <eb2997ef-0fd4-a564-d166-9459b017e10c@gmail.com>
 <d52eeb7b-55b3-4696-83bc-4d64f2853dfe@kadam.mountain>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d52eeb7b-55b3-4696-83bc-4d64f2853dfe@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 22:13, Dan Carpenter wrote:
> On Thu, Aug 03, 2023 at 01:43:33PM -0700, Kui-Feng Lee wrote:
>>>>       113         int err;
>>>>       114
>>>>       115         addr.sin6_port = htons(get_sock_port_v6(listen_fd));
>>>> --> 116         if (addr.sin6_port < 0)
>>>>                       ^^^^^^^^^^^^^^^^^^
>>>> Impossible and also it doesn't make sense to compare network endian data
>>>> with < 0.
>>>
>>> Hi Dan,
>>>
>>> Thank you for pointing it out. It should check the returned value
>>> of get_sock_port_v6() before calling htons(). I will send a patch
>>> to fix it asap.
>>
>> Could you show me how to run Smatch againt bpf selftests?
>>
> 
> Oh wow...  You don't want to know.  So sometimes I'll go through and
> do a `find -name \*.c` and if there isn't a matching .o file I'll just
> run:
> 
> 	~/path/to/smatch tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> 
> Smatch has a thing where if the .h file is missing it will just include
> the nearest .h file with a similar name.  This doesn't work well and
> generates a ton of errors.  But I grep the output for specific types
> of errors like "is never less than zero".

Got it! Thanks!

> 
> regards,
> dan carpenter
> 

