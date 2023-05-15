Return-Path: <bpf+bounces-554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42711703406
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDFA1C20C62
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434CFBF6;
	Mon, 15 May 2023 16:43:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CBD512
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:43:48 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC25349F3
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:43:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so38590325e9.2
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684169025; x=1686761025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmgoKlx7kMj04wNMyX3SeU11ZEtpR4XsOpJT5G1ALns=;
        b=cYLTQJrd+a/IRnuCnxS8ByiQgMVOwQaTOZbDUBgirfef8lxpe2ADh5fYyNwr2rB8q5
         wP37fOJTdRTgnvLmCvurOkLtkxexML4/ryxl5uPNNoD8kQEv2a1pNsSv/LUvK5lyx+Ow
         iBmel0jc+PoSZXCUjuKusVud8Vty5xuzQ0ZqIkWFVTr+BJPMcsIgPDk92asaHvIwiOE8
         P8h9zkCnw3viE7nblMkecD3L4Tn+sZIjMUcZKZuFSJM2q3bhvA5WCdMlJxiEsQugTQNu
         vbS/khmD73uOW6sSTgi+r8gzuY7yfMmFRaJxwQQvbULGoYwNQXRoUGHNeelB0A10oTU4
         ji6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169025; x=1686761025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmgoKlx7kMj04wNMyX3SeU11ZEtpR4XsOpJT5G1ALns=;
        b=OAGxnf66W2smpXDjcBKkOFL+nK4PUIyEde3HPYpi43nLay2yhRrcL5edYdkJDMwIqx
         acC7rh9rxDcPQkJwal37H+4gF4g02GIsuqJHzTrJAVIzCrPNVIy9DKJsNCV5RlJP4jCP
         ACYpQQ8G2EINJykKNL9Ig9slR4n/Mu7mEyB7Sl1EhQqbpNmlMyeMPFd8xvfV8QN0k5EG
         iBfN8Sm2HlgiM2l8Yn0UwzTL+Y56d9tmXpZptq54oKefo/Hud8hQZD4q9Luzox9/SvdL
         W8Rysog06aZAzXcfUCyHm1kSn6PlgClszyIFzskpGpxiHVU4N5Vdx2T6W1pLpwQpXLRI
         nz9A==
X-Gm-Message-State: AC+VfDwmQd5ODCE7U7Ei14+gVRGWlco1BAXI31pcKECZKV8a6p1YjDzp
	aeb/ozeWIcr2jvWHReEIY9hunw==
X-Google-Smtp-Source: ACHHUZ7bb/VnLptviKcjLZJvlzHQacLahOr1ou4d/PbfTM3KYvwshCjlJKP5NjN2ZO6VU4i7d8ubpw==
X-Received: by 2002:a05:600c:378d:b0:3f4:fffc:cd74 with SMTP id o13-20020a05600c378d00b003f4fffccd74mr4697091wmr.16.1684169025339;
        Mon, 15 May 2023 09:43:45 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cdc:e9dc:864d:1455? ([2a02:8011:e80c:0:9cdc:e9dc:864d:1455])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003f182a10106sm9946wml.8.2023.05.15.09.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:43:44 -0700 (PDT)
Message-ID: <b027a4f4-a373-6b37-b851-5dabd498d28a@isovalent.com>
Date: Mon, 15 May 2023 17:43:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next 2/4] bpftool: define a local bpf_perf_link to fix
 accessing its fields
Content-Language: en-GB
To: Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Alexander Lobakin <alobakin@pm.me>
References: <20230512103354.48374-1-quentin@isovalent.com>
 <20230512103354.48374-3-quentin@isovalent.com>
 <40817aae-bb4b-31b7-6853-eb4d37ca2518@meta.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <40817aae-bb4b-31b7-6853-eb4d37ca2518@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-12 07:47 UTC-0700 ~ Yonghong Song <yhs@meta.com>
> 
> 
> On 5/12/23 3:33 AM, Quentin Monnet wrote:
>> From: Alexander Lobakin <alobakin@pm.me>
>>
>> When building bpftool with !CONFIG_PERF_EVENTS:
>>
>> skeleton/pid_iter.bpf.c:47:14: error: incomplete definition of type
>> 'struct bpf_perf_link'
>>          perf_link = container_of(link, struct bpf_perf_link, link);
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:74:22:
>> note: expanded from macro 'container_of'
>>                  ((type *)(__mptr - offsetof(type, member)));    \
>>                                     ^~~~~~~~~~~~~~~~~~~~~~
>> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:68:60:
>> note: expanded from macro 'offsetof'
>>   #define offsetof(TYPE, MEMBER)  ((unsigned long)&((TYPE *)0)->MEMBER)
>>                                                    ~~~~~~~~~~~^
>> skeleton/pid_iter.bpf.c:44:9: note: forward declaration of 'struct
>> bpf_perf_link'
>>          struct bpf_perf_link *perf_link;
>>                 ^
>>
>> &bpf_perf_link is being defined and used only under the ifdef.
>> Define struct bpf_perf_link___local with the `preserve_access_index`
>> attribute inside the pid_iter BPF prog to allow compiling on any
>> configs. CO-RE will substitute it with the real struct bpf_perf_link
>> accesses later on.
>> container_of() is not CO-REd, but it is a noop for
> 
> 'container_of() is not CO-REd' is incorrect.
> 
> #define container_of(ptr, type, member)                         \
>         ({                                                      \
>                 void *__mptr = (void *)(ptr);                   \
>                 ((type *)(__mptr - offsetof(type, member)));    \
>         })
> 
> 
> offsetof() will do necessary CO-RE relocation if the field is specified
> with preserve_access_index attribute. So container_of will actually
> do CO-RE relocation as well.

Thanks! I'll amend the description for the next iteration.

Quentin

