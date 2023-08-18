Return-Path: <bpf+bounces-8033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA47802A2
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 02:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305B41C21554
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E03374;
	Fri, 18 Aug 2023 00:15:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3190360
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 00:15:08 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B53AA4
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:14:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58cbdf3eecaso3900757b3.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692317687; x=1692922487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YShY8SG7dmj5eUOZQo+5F83hx/JGrBjroLn+xGmXts=;
        b=bS3ntVuOQcyuBuMx2xI9sxBQMkC0D803SGcrcXd1ZveRziTMN2/vhqzUQHX3X2qjjY
         V0brPTS+dytZkK08K+HN5wHayLXbWdsOY9OdVBCcY1GcV81b9QSuwuMnfnhLXq+BFxMN
         VtrQq698vsbCQHl8nvjpqqUKNWI/Uia0yPojPWHeQFnANSibPsP6dmC9eOF0k69/GVPv
         Kny8m7FB0J+QtCFJqqKpLRtle3UVlTQdws2aAA7IX7nPb+MsxQbWyMOJcSGkjYaXKB+/
         i9Ls4jax9iu5qU6qp/URT5c0cShIY1JH77grc7bOei+aLZHZAa6CP7dA5vKPtTPui3d1
         E1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317687; x=1692922487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YShY8SG7dmj5eUOZQo+5F83hx/JGrBjroLn+xGmXts=;
        b=RVdXrUbhqDLN5Wsl6yBDMrva4bpadPFZ+W6yzQ8rQza38tjrIGUFGSi2Ki51yhvMfc
         w/6MTEFEjT4m7a7hOYO55Bm8/FOu8eVBdhllZ+YWfXf9axKXB8f+iH5qXyPscoB79+Gf
         bLYVs5r0Hogtx0pMsDGJBqTCRi8XHjRx3IaumZy8s3itmzw7S/+PiGdW1S7tPSI1TxMO
         aufQGpoVisc3jXZuchjIFxp0RXdbMOANX97Tpu2/lj694HYvY+AQA0rCQLVL7l5Iq9Ax
         5DzHrq2r2OJpvJYsJCdSC0eePxXWA67c7VqNBKvFbhEkQBIlMaHGs+wBGVhJVHPZowK8
         yVPA==
X-Gm-Message-State: AOJu0Yxp+QEqiGf+1ea+NVSMyaJzZfzZCY1cz3go1r5tw/QLA3jkWb/+
	AX6XuAAmIxA/u8QYUGDpTvI=
X-Google-Smtp-Source: AGHT+IH7ir/heHA2veLfeYN/R6fZIOaBRqiDndv6hi9ZC/hkZlhfqdtvqmrDpLxWwQhXkKN/jDJrZA==
X-Received: by 2002:a0d:ea01:0:b0:58c:873e:3174 with SMTP id t1-20020a0dea01000000b0058c873e3174mr896810ywe.6.1692317687006;
        Thu, 17 Aug 2023 17:14:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4ed5:7c96:4512:c40? ([2600:1700:6cf8:1240:4ed5:7c96:4512:c40])
        by smtp.gmail.com with ESMTPSA id r6-20020a0de806000000b00586ba973bddsm194321ywe.110.2023.08.17.17.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 17:14:46 -0700 (PDT)
Message-ID: <8a1aef40-3c16-fde5-35ae-7d92a04cbfa6@gmail.com>
Date: Thu, 17 Aug 2023 17:14:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for
 CGRUP_SOCKOPT.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Kui-Feng Lee <kuifeng@meta.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-5-thinker.li@gmail.com>
 <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local>
 <5dd24d8c-17b8-53d3-3701-93693a11279b@gmail.com>
 <CAADnVQLsqueyOQ4p0nJbGjhW7ULx+aB87Rr9ox3VJK55Xj=2Lg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQLsqueyOQ4p0nJbGjhW7ULx+aB87Rr9ox3VJK55Xj=2Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/23 12:43, Alexei Starovoitov wrote:
> On Thu, Aug 17, 2023 at 12:00 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 8/16/23 18:25, Alexei Starovoitov wrote:
>>> On Tue, Aug 15, 2023 at 10:47:11AM -0700, thinker.li@gmail.com wrote:
>>>>
>>>> +BTF_SET8_START(cgroup_common_btf_ids)
>>>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_copy_to, KF_SLEEPABLE)
>>>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_alloc, KF_SLEEPABLE)
>>>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_install, KF_SLEEPABLE)
>>>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_release, KF_SLEEPABLE)
>>>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_from, KF_SLEEPABLE)
>>>> +BTF_SET8_END(cgroup_common_btf_ids)
>>>
>>> These shouldn't be sockopt specific.
>>> If we want dynptr to represent a pointer to a user contiguous user memory
>>> we should use generic kfunc that do so.
>>>
>>> I suspect a single new kfunc: bpf_dynptr_from_user_mem() would do.
>>> New dynptr type can be hidden in the kernel and all existing
>>> kfuncs dynptr_slice, dynptr_data, dynptr_write could be made to work
>>> with user memory.
>>>
>>> But I think we have to step back. Why do we need this whole thing in the first place?
>>> _why_ sockopt bpf progs needs to read and write user memory?
>>>
>>> Yes there is one page limit, but what is the use case to actually read and write
>>> beyond that? iptables sockopt was mentioned, but I don't think bpf prog can do
>>> anything useful with iptables binary blobs. They are hard enough for kernel to parse.
>>
>> The ideal behind the design is let the developers of filters to decide
>> when to replace the existing buffer.  And, access the content of
>> buffers just like accessing raw pointers. However, seems almost everyone
>> love to use *_read() & *_write(). I will move to that direction.
> 
> That doesn't answer my question about the use case.
> What kind of filters want to parse more than 4k of sockopt data?

I don't have any existing use case for this. It is just something
can/allow to happen.

