Return-Path: <bpf+bounces-10487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5527A8E41
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5792F1C2091D
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2743CD18;
	Wed, 20 Sep 2023 21:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5E41A80;
	Wed, 20 Sep 2023 21:11:23 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF9C2;
	Wed, 20 Sep 2023 14:11:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d81b803b09aso397227276.2;
        Wed, 20 Sep 2023 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695244282; x=1695849082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ck01rY7g6eieWdyN/838nrtggmL0o8sQJFo5pWQPmMI=;
        b=SN/WTUCL2ZGJ6ZLqKEkYdKLTqh30LIzYETOjjz+Ox7n8XvATtQFYgIeVP9DVx3wY72
         /cf0PVzRGcuEqtyOYrzYmj8f2sKX01g+t3YNQuQGs4XXAXQa05JFVbvN3LCyDTF6tG1n
         rOXZsQXyEJwuLiQToMUo6kh8yHpUpJdp5gXufzZ7kGeOMJbx8ipcw0Ud9P12d8uyN84l
         HbNX70XH45AIsEsCS9o1vlUrC/0DFrQkV/GQDgS0iLAEcdewkGlHjHs5Ofy2r0ZBuHQp
         ppARf0azo+jMXDJY6ubrQQOXMSCUqahuZSdo23EdEKCbZ94L51HOfcN4fxcj4ZWHKRJv
         0q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695244282; x=1695849082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck01rY7g6eieWdyN/838nrtggmL0o8sQJFo5pWQPmMI=;
        b=sqIF9d4VF/UpEq6RDz704Kw9lcmf9pzShL/mzMRf3mm9SAde/r8uSy2vaSAWefYNqZ
         pVrFdJronjOhQP4WP8XvBzCDGbI1ULUm2AgIt4ohfWfUdsPY98aacn6csl1i3Y6g7E/X
         nx4VV3yo6gMlT1k99Ny+kmzijZHB06vyoNcmG5BDQxUkdPeFC27es04hYhdREbwT86bA
         ygvm9xu1qrjJPI9/j7/VA51FMm1bhzK4OZcLTr4e8z1BWwbrLelWhLpKsmrmXXX30gNF
         TrdvonQ7JwdV7s7+t8WYJYuc3whOAs3Y8k2F+WifT89/0pJyfdGKjmdC0YeUAML+K87S
         +GnA==
X-Gm-Message-State: AOJu0YxGnKgVi/F5AcFtzqUvCMyMy/x9WaiTUMy38UAE5ZVBiw0awWc1
	y4BNK1s+OjmC9d+DWQPgQbLe1BkOuCw=
X-Google-Smtp-Source: AGHT+IHJdK7nOnt0hU3D91rCQjheuhXxVnULYhHnjKmmqbgHHKpSh7W6Y+okZfiiJHPzQ1PvWYIZ9g==
X-Received: by 2002:a25:d2c2:0:b0:d08:2101:562d with SMTP id j185-20020a25d2c2000000b00d082101562dmr3841349ybg.34.1695244281751;
        Wed, 20 Sep 2023 14:11:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:dcd2:9730:2c7c:239f? ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id 142-20020a250394000000b00d8161769507sm15506ybd.25.2023.09.20.14.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:11:21 -0700 (PDT)
Message-ID: <3b0af149-2561-a672-a03c-241dbb1672c1@gmail.com>
Date: Wed, 20 Sep 2023 14:11:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH bpf] bpf, sockmap: Reject sk_msg egress redirects to
 non-TCP sockets
Content-Language: en-US
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20230920102055.42662-1-jakub@cloudflare.com>
 <1224b3f1-4b2a-3c49-5f29-cfce0652ba94@gmail.com>
 <87wmwk7dy5.fsf@cloudflare.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <87wmwk7dy5.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/20/23 13:59, Jakub Sitnicki wrote:
> On Wed, Sep 20, 2023 at 11:19 AM -07, Kui-Feng Lee wrote:
>> On 9/20/23 03:20, Jakub Sitnicki wrote:
>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>> index cb11750b1df5..4292c2ed1828 100644
>>> --- a/net/core/sock_map.c
>>> +++ b/net/core/sock_map.c
>>> @@ -668,6 +668,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>>>    	sk = __sock_map_lookup_elem(map, key);
>>>    	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>>>    		return SK_DROP;
>>> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>>> +		return SK_DROP;
>>>      	msg->flags = flags;
>>>    	msg->sk_redir = sk;
>>> @@ -1267,6 +1269,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>>>    	sk = __sock_hash_lookup_elem(map, key);
>>>    	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>>>    		return SK_DROP;
>>> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>>> +		return SK_DROP;
>>>      	msg->flags = flags;
>>>    	msg->sk_redir = sk;
>>
>> Just be curious! Can it happen to other socket types?
>> I mean to redirect a msg from a sk of any type to one of another type.
> 
> Today sk_msg redirects are implemented only for tcp4 and tcp6.
> 
> Here's a full matrix of what redirects are supported [1].
> 
> [1] https://gist.github.com/jsitnicki/578fdd614d181bed2b02922b17972b4e

Thanks!

