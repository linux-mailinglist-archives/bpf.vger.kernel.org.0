Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B646D105
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhLHKeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 05:34:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29161 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhLHKeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 05:34:00 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J8D046c5czXdZm;
        Wed,  8 Dec 2021 18:28:20 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 18:30:26 +0800
Subject: Re: [PATCH -next 1/2] string.h: Introduce memset_range() for wiping
 members
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <keescook@chromium.org>, <laniel_francis@privacyrequired.com>,
        <andriy.shevchenko@linux.intel.com>, <adobriyan@gmail.com>,
        <linux@roeck-us.net>, <andreyknvl@gmail.com>, <dja@axtens.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
References: <20211208030451.219751-1-xiujianfeng@huawei.com>
 <20211208030451.219751-2-xiujianfeng@huawei.com>
 <20211207202829.48d15f0ffa006e3656811784@linux-foundation.org>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <e2d5936d-8490-5871-b3d4-b286d256832a@huawei.com>
Date:   Wed, 8 Dec 2021 18:30:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20211207202829.48d15f0ffa006e3656811784@linux-foundation.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


�� 2021/12/8 12:28, Andrew Morton д��:
> On Wed, 8 Dec 2021 11:04:50 +0800 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
>> Motivated by memset_after() and memset_startat(), introduce a new helper,
>> memset_range() that takes the target struct instance, the byte to write,
>> and two member names where zeroing should start and end.
> Is this likely to have more than a single call site?
There maybe more call site for this function, but I just use bpf as an 
example.
>
>> ...
>>
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -291,6 +291,26 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>>   	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
>>   })
>>   
>> +/**
>> + * memset_range - Set a value ranging from member1 to member2, boundary included.
> I'm not sure what "boundary included" means.
I mean zeroing from member1 to member2(including position indicated by 
member1 and member2)
>
>> + *
>> + * @obj: Address of target struct instance
>> + * @v: Byte value to repeatedly write
>> + * @member1: struct member to start writing at
>> + * @member2: struct member where writing should stop
> Perhaps "struct member before which writing should stop"?
memset_range should include position indicated by member2 as well
>
>> + *
>> + */
>> +#define memset_range(obj, v, member_1, member_2)			\
>> +({									\
>> +	u8 *__ptr = (u8 *)(obj);					\
>> +	typeof(v) __val = (v);						\
>> +	BUILD_BUG_ON(offsetof(typeof(*(obj)), member_1) >		\
>> +		     offsetof(typeof(*(obj)), member_2));		\
>> +	memset(__ptr + offsetof(typeof(*(obj)), member_1), __val,	\
>> +	       offsetofend(typeof(*(obj)), member_2) -			\
>> +	       offsetof(typeof(*(obj)), member_1));			\
>> +})
> struct a {
> 	int b;
> 	int c;
> 	int d;
> };
>
> How do I zero out `c' and `d'?
if you want to zero out 'c' and 'd', you can use it like 
memset_range(a_ptr, c, d);
>
>
> .
