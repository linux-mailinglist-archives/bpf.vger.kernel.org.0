Return-Path: <bpf+bounces-9667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E30979AA56
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A901C209C4
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B5811715;
	Mon, 11 Sep 2023 16:51:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAC8BF8
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 16:51:52 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3B110
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 09:51:49 -0700 (PDT)
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38BEcbns021496;
	Mon, 11 Sep 2023 16:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=9MkIzcMFArhM3CfVY7roD6tkPH2WqzCwCKRe8qUL5ks=; b=YiE4y9tOaqlv
	U3k/SzINDNGJ1a3XJQkQM2aHcf1yyRazUa/e2gASwUDBcqa2+x6CZck/KRtlhjex
	DBfn1AunzpWRWNkA55iRt7zJkUhHvDOB6mGgN0h2fNhmEwkpEa2Prd2fFFUg7lKq
	6/f2Wg+r2eofVr4oHxBdl9hu9N0ik7EyhWtRyX8O83OfifLbO6vD9/3CKNwMvUZo
	DuIxPsLnknnM7I9jOJItVYCc02miAD4vfzFYEGhkauHLwt4RQQptJ/MVinarDY70
	ZpCflmYdQuh5v2D4c0ykoBnhOfrQNEIxM4qDMQ2Yoz2gQME4h3XaxaNZKs3vnr7h
	cRAMmS5iCw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t14y9uc4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 16:51:29 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 11 Sep
 2023 16:51:27 +0000
Message-ID: <e2be44c7-2ed8-9327-2618-5bc7539c89c0@crowdstrike.com>
Date: Mon, 11 Sep 2023 09:51:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Re: [PATCH bpf-next 1/2] libbpf: add ring_buffer__query
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
 <20230907234041.58388-2-martin.kelly@crowdstrike.com>
 <CAEf4BzZXVZ6LTX2KuXDo427kGwi4g1zGNfgEPrHfnJ4AmDq6Nw@mail.gmail.com>
Content-Language: en-US
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <CAEf4BzZXVZ6LTX2KuXDo427kGwi4g1zGNfgEPrHfnJ4AmDq6Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH11.crowdstrike.sys (10.100.11.115) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: V5lGGfkn6LI2uMJf2Lo-fjCyimUfaTrn
X-Proofpoint-ORIG-GUID: V5lGGfkn6LI2uMJf2Lo-fjCyimUfaTrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxlogscore=857
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309110154
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 17:25, Andrii Nakryiko wrote:
> On Thu, Sep 7, 2023 at 4:42 PM Martin Kelly
> <martin.kelly@crowdstrike.com> wrote:
>> +/* A userspace analogue to bpf_ringbuf_query for a particular ringbuffer index
>> + * managed by this ringbuffer manager. Flags has the same arguments as
>> + * bpf_ringbuf_query, and the index given is a 0-based index tracking the order
>> + * the ringbuffers were added via ring_buffer__add. Returns the data requested
>> + * according to flags.
>> + */
>> +__u64 ring_buffer__query(struct ring_buffer *rb, unsigned int index, __u64 flags)
> I can see how this might be useful, but I don't think this exact API
> and approach will work well.
>
> First, I'd just add getters to get consumer and producer position and
> producer. User-space code can easily derive available data from that
> (and it's always racy and best effort to determine amount of data
> enqueued in ringbuf, so having this as part of user-space API also
> seems a bit off). RING_SIZE is something that user-space generally
> should know already, or it can get it through a bpf_map__max_entries()
> helper.

I agree that getting available data is naturally racy, though there's no 
avoiding that. Since producer and consumer are both read atomically, and 
since producer >= consumer absent kernel bugs, I don't see this causing 
any harm though, as long as we document it in the API. Despite being 
technically racy, it's very useful to know the rough levels of the 
ringbuffers for monitoring things like "the ringbuffer is close to 
full", which usermode may want to take some action on (e.g. alerting or 
lowering log level to add backpressure). Sure, you could do it by having 
BPF populate the levels using bpf_ringbuf_query and a map, but if you're 
just polling on this from usermode, being able to check this directly is 
more efficient and leads to simpler code. For instance, if you do this 
from BPF and have many ringbuffers via a map-in-map type, you end up 
having to create two separate map-in-maps, which uses more memory and is 
yet another map for usermode to manage just to get this info.

If you prefer to simply expose producer and consumer and not available 
data method though, that's ok with me. That said, it means code using 
this directly would break in the future if somehow the implementation 
changed; if we expose available data directly, we can change the 
implementation in that case and avoid the concern.

I have no issue dropping RING_SIZE; I included it simply to mirror 
ringbuf_query, but if we're no longer mirroring it, then we don't need 
to keep it.

> Second, this `unsigned int index` is not a good interface. There is
> nothing in ring_buffer APIs that operates based on such an index.
The index is the heart of the problem, and I expected there might be 
concerns about it. The issue is that right now, only struct ring_buffer 
is exposed to the user, but this struct actually contains many 
ringbuffers, with no API for referencing any particular ringbuffer.

One thing we could do is expose struct ring * as an opaque type:

struct ring *ring_buffer__get(struct ring_buffer *rb, unsigned int index);
__u32 ring_buffer__count(struct ring_buffer *rb);

Then individual ringbuffers could have methods like:

__u64 ring__get_avail_data(struct ring *r);
__u64 ring__get_producer_pos(struct ring *r);
__u64 ring__get_consumer_pos(struct ring *r);

And usermode could do something like this:

for (i = 0; i < ring_buffer__count(rb); i++) {
     struct ring *r = ring_buffer__get(rb);
     avail_data = ring__get_avail_data(r);
     /* do some logic with avail_data */
}

Because struct ring_buffer currently contains many ringbuffers, I think 
we need to add an index, either directly in these methods or by exposing 
struct ring * as an opaque type.

I appreciate your response; please let me know what you think.


