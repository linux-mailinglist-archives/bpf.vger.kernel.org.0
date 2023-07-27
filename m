Return-Path: <bpf+bounces-6041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095A764697
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85352820D8
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD48A95A;
	Thu, 27 Jul 2023 06:17:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863371C3E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:17:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309F19B;
	Wed, 26 Jul 2023 23:17:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RBLCJ0g8Mz4f3prt;
	Thu, 27 Jul 2023 14:17:16 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBnwBrpC8Jki6qGOA--.46874S2;
	Thu, 27 Jul 2023 14:17:16 +0800 (CST)
Subject: Re: [PATCH] libbpf: Expose API to consume one ring at a time
From: Hou Tao <houtao@huaweicloud.com>
To: Adam Sindelar <adam@wowsignal.io>, bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
 Brendan Jackman <jackmanb@google.com>, KP Singh <kpsingh@chromium.org>,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Florent Revest <revest@chromium.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20230725162654.912897-1-adam@wowsignal.io>
 <cb844776-9045-1b69-f1db-8ef7d75815b5@huaweicloud.com>
Message-ID: <482ed32c-5650-54a5-d5bb-18b9bb03e838@huaweicloud.com>
Date: Thu, 27 Jul 2023 14:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cb844776-9045-1b69-f1db-8ef7d75815b5@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBnwBrpC8Jki6qGOA--.46874S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF45WF48GF4DZFy7AFyrWFg_yoW5JFWfpr
	s0kFy5Crs5ZryxZFZxWF1SqryYvan29r4xKrWxJw1UA39rAF4kXr1jkr1akr43JrZ5K34a
	yrWYga48CryUW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/27/2023 9:06 AM, Hou Tao wrote:
> Hi,
>
> On 7/26/2023 12:26 AM, Adam Sindelar wrote:
>> We already provide ring_buffer__epoll_fd to enable use of external
>> polling systems. However, the only API available to consume the ring
>> buffer is ring_buffer__consume, which always checks all rings. When
>> polling for many events, this can be wasteful.
>>
>> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
>> ---
>>  tools/lib/bpf/libbpf.h  |  1 +
>>  tools/lib/bpf/ringbuf.c | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 55b97b2087540..20ccc65eb3f9d 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>>  				ring_buffer_sample_fn sample_cb, void *ctx);
>>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
>> +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
>>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>>  
>>  struct user_ring_buffer_opts {
>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
>> index 02199364db136..8d087bfc7d005 100644
>> --- a/tools/lib/bpf/ringbuf.c
>> +++ b/tools/lib/bpf/ringbuf.c
>> @@ -290,6 +290,21 @@ int ring_buffer__consume(struct ring_buffer *rb)
>>  	return res;
>>  }
>>  
>> +/* Consume available data from a single RINGBUF map identified by its ID.
>> + * The ring ID is returned in epoll_data by epoll_wait when called with
>> + * ring_buffer__epoll_fd.
>> + */
>> +int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
>> +{
>> +	struct ring *ring;
>> +
>> +	if (ring_id >= rb->ring_cnt)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	ring = &rb->rings[ring_id];
>> +	return ringbuf_process_ring(ring);
> When ringbuf_process_ring() returns an error, we need to use
> libbpf_err() to set the errno accordingly.

It seems that even when ringbuf_process_ring() returns a positive
result, we also need to cap it under INT_MAX, otherwise it may be cast
into a negative error.
>> +}
>> +
>>  /* Poll for available data and consume records, if any are available.
>>   * Returns number of records consumed (or INT_MAX, whichever is less), or
>>   * negative number, if any of the registered callbacks returned error.
>
>
> .


