Return-Path: <bpf+bounces-9951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC079F0A9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33C3281CE2
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08438200BA;
	Wed, 13 Sep 2023 17:52:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28D1798E
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 17:52:02 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA219AE
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:52:01 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DCkuDc001090;
	Wed, 13 Sep 2023 17:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=3opAj+WIUwSNLqzssd6SWYu0SjP5kwIcytxUUgqYLSg=; b=SQHwPuGGKcGx
	vgosVKIr9R15a48RiOEM0xeOTb+Xft42bgXkJabf1eU9IZj4t2MTSpC6yvC2FmMR
	jv3Y5NmSmf32NmWX9/lNxilY6vDQsEqcNroav2ommZNb9q4MRBnEo+TJGPQTxefZ
	rQzfJF9V4cbZmeSBLcW+ZKyXuV1BN8Sn+EMprUCDyRA9eljRod19Vt4Ux8l2LcXr
	KOeDXBCKx4tlWrUFYk6CbdDUAYZQaSD8qZ5z3IM9apxUgZ8myMX3OBo9uKF3Nqzb
	QwJ8yP9iTbBA5j+I4ImYaF5iOJpJi37zipP0aRiTIxvhK1VaEfoYprUH4aXpQJi0
	ZJiRqL/p6g==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9fjhef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Sep 2023 17:51:40 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Wed, 13 Sep
 2023 17:51:39 +0000
Message-ID: <6a66e8a9-bd13-9960-e43f-b6d8be71ab4f@crowdstrike.com>
Date: Wed, 13 Sep 2023 10:51:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Re: Re: [PATCH bpf-next 1/2] libbpf: add ring_buffer__query
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
 <20230907234041.58388-2-martin.kelly@crowdstrike.com>
 <CAEf4BzZXVZ6LTX2KuXDo427kGwi4g1zGNfgEPrHfnJ4AmDq6Nw@mail.gmail.com>
 <e2be44c7-2ed8-9327-2618-5bc7539c89c0@crowdstrike.com>
 <CAEf4BzYdNhsFS+xBdhcCrY-m+SFwHOcJnk_AJETnOdiyDo+JxQ@mail.gmail.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <CAEf4BzYdNhsFS+xBdhcCrY-m+SFwHOcJnk_AJETnOdiyDo+JxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH10.crowdstrike.sys (10.100.11.114) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: 47QTi0k_MStnZh8LEOXXVNB-NWADJfGm
X-Proofpoint-GUID: 47QTi0k_MStnZh8LEOXXVNB-NWADJfGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_12,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=568 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309130149

On 9/12/23 17:23, Andrii Nakryiko wrote:
>>> Second, this `unsigned int index` is not a good interface. There is
>>> nothing in ring_buffer APIs that operates based on such an index.
>> The index is the heart of the problem, and I expected there might be
>> concerns about it. The issue is that right now, only struct ring_buffer
>> is exposed to the user, but this struct actually contains many
>> ringbuffers, with no API for referencing any particular ringbuffer.
>>
>> One thing we could do is expose struct ring * as an opaque type:
>>
>> struct ring *ring_buffer__get(struct ring_buffer *rb, unsigned int index);
>> __u32 ring_buffer__count(struct ring_buffer *rb);
>>
>> Then individual ringbuffers could have methods like:
>>
>> __u64 ring__get_avail_data(struct ring *r);
>> __u64 ring__get_producer_pos(struct ring *r);
>> __u64 ring__get_consumer_pos(struct ring *r);
>>
>> And usermode could do something like this:
>>
>> for (i = 0; i < ring_buffer__count(rb); i++) {
>>       struct ring *r = ring_buffer__get(rb);
>>       avail_data = ring__get_avail_data(r);
>>       /* do some logic with avail_data */
>> }
>>
>> Because struct ring_buffer currently contains many ringbuffers, I think
>> we need to add an index, either directly in these methods or by exposing
>> struct ring * as an opaque type.
>>
>> I appreciate your response; please let me know what you think.
>>
> I don't really have a better proposal (I tried). Let's go with
> basically what you proposed, let's just follow libbpf naming
> convention to not use "get" in getters. Something like this (notice
> return types):
The below API looks good to me; I'll work on this.
>
> struct ring *ring_buffer__ring(struct ring_buffer *rb, int idx);
>
> unsigned long ring__producer_pos(const struct ring *r);
> unsigned long ring__consumer_pos(const struct ring *r);
> /* document that this is racy estimate */
> size_t ring__avail_data_size(const struct ring *r);
> size_t ring__size(const struct ring *r);
> int ring__map_fd(const struct ring *r);
>
> so we have a more-or-less complete set of getters. We can probably
> also later add consume() implementation (but not poll!).
>
> Also, we'll need to decide whether returned struct ring * pointers are
> invalidated on ring_buffer__add() or not. It probably would be less
> error-prone if they were not, and it's easy to implement. Instead of
> having `struct ring *rings` inside struct ring_buffer, we can have an
> array of pointers and keep struct ring * pointers stable.

I agree with that; this seems like a big foot-gun otherwise, especially 
as much of the time realloc will expand in-place and therefore nothing 
will break, so it could easily lead to a "rare crash" type of scenario 
for users.

>
> BTW, we should probably add producer/consumer pos for
> user_ring_buffer, which is much more straightforward API-wise, because
> it's always a single ringbuf, so no need to build extra abstractions.

