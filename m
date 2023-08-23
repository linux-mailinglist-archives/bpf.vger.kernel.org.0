Return-Path: <bpf+bounces-8333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A4784E67
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 03:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8C281235
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F415AE;
	Wed, 23 Aug 2023 01:49:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1915A4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 01:49:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E7E5E
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 18:49:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVpzJ3FDqz4f3lwY
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:49:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBnPqGLZeVk1U9yBQ--.32982S2;
	Wed, 23 Aug 2023 09:49:02 +0800 (CST)
Subject: Re: [PATCH] libbpf: handle producer position overflow
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrew Werner <awerner32@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev
References: <20230724132404.1280848-1-awerner32@gmail.com>
 <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com>
Date: Wed, 23 Aug 2023 09:48:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBnPqGLZeVk1U9yBQ--.32982S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxAr1fZryxJr4DCr13XFb_yoWrtrW5pF
	45K3WFkrsFqrySv34xZw48ZFyFka1kJw45Jr93Jry8Awn0qF4SyFyxKrWa9rWfZr9Y9r1F
	vrZ0g3srCryUZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/22/2023 1:15 PM, Andrii Nakryiko wrote:
> On Mon, Jul 24, 2023 at 6:24 AM Andrew Werner <awerner32@gmail.com> wrote:
>> Before this patch, the producer position could overflow `unsigned
>> long`, in which case libbpf would forever stop processing new writes to
>> the ringbuf. This patch addresses that bug by avoiding ordered
>> comparison between the consumer and producer position. If the consumer
>> position is greater than the producer position, the assumption is that
>> the producer has overflowed.
>>
>> A more defensive check could be to ensure that the delta is within
>> the allowed range, but such defensive checks are neither present in
>> the kernel side code nor in libbpf. The overflow that this patch
>> handles can occur while the producer and consumer follow a correct
>> protocol.
> Yep, great find!
>
>> A selftest was written to demonstrate the bug, and indeed this patch
>> allows the test to continue to make progress past the overflow.
>> However, the author was unable to create a testing environment on a
>> 32-bit machine, and the test requires substantial memory and over 4
> 2GB of memory for ringbuf, right? Perhaps it would be good to just
> outline the repro, even if we won't have it implemented in selftests.
> Something along the lines of: a) set up ringbuf of 2GB size and
> reserve+commit maximum-sized record (UMAX/4) constantly as fast as
> possible. With 1 million records per second repro time should be about
> 4.7 hours. Can you please update the commit with something like that
> instead of a vague "there is repro, but I won't show it ;)" ? Thanks!

I think it would be great that the commit message can elaborate about
the repo. Andrew had already posted an external link to the reproducer
in v2 [0]: https://github.com/ajwerner/bpf/commit/85e1240e7713

[0]:
https://lore.kernel.org/bpf/20230724132543.1282645-1-awerner32@gmail.com/
>> hours to hit the overflow point on a 64-bit machine. Thus, the test
>> is not included in this patch because of the impracticality of running
>> it.
>>
>> Additionally, this patch adds commentary around a separate point to note
>> that the modular arithmetic is valid in the face of overflows, as that
>> fact may not be obvious to future readers.
>>
>> Signed-off-by: Andrew Werner <awerner32@gmail.com>
>> ---
>>  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
>> index 02199364db13..6271757bc3d2 100644
>> --- a/tools/lib/bpf/ringbuf.c
>> +++ b/tools/lib/bpf/ringbuf.c
>> @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring *r)
>>         do {
>>                 got_new_data = false;
>>                 prod_pos = smp_load_acquire(r->producer_pos);
>> -               while (cons_pos < prod_pos) {
>> +
>> +               /* Avoid signed comparisons between the positions; the producer
> "signed comparisons" is confusing and invalid, as cons_pos and
> prod_pos are unsigned and comparison here is unsigned. What you meant
> is inequality comparison, which is invalid when done naively (like it
> is done in libbpf right now, sigh...), if counters can wrap around.
>
>> +                * position can overflow before the consumer position.
>> +                */
>> +               while (cons_pos != prod_pos) {
> I'm wondering if we should preserve the "consumer pos is before
> producer pos" check just for clarity's sake (with a comment about
> wrapping around of counters, of course) like:
>
> if ((long)(cons_pos - prod_pos) < 0) ?
>
> BTW, I think kernel code needs fixing as well in
> __bpf_user_ringbuf_peek (we should compare consumer/producer positions
> directly, only through subtraction and casting to signed long as
> above), would you be able to fix it at the same time with libbpf?
> Would be good to also double-check the rest of kernel/bpf/ringbuf.c to
> make sure we don't directly compare positions anywhere else.

I missed __bpf_user_ringbuf_peek() when reviewed the patch. I also can
help to double-check kernel/bpf/ringbuf.c.
>
>>                         len_ptr = r->data + (cons_pos & r->mask);
>>                         len = smp_load_acquire(len_ptr);
>>
>> @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
>>         prod_pos = smp_load_acquire(rb->producer_pos);
>>
>>         max_size = rb->mask + 1;
>> +
>> +       /* Note that this formulation in the face of overflow of prod_pos
>> +        * so long as the delta between prod_pos and cons_pos remains no
>> +        * greater than max_size.
>> +        */
>>         avail_size = max_size - (prod_pos - cons_pos);
>>         /* Round up total size to a multiple of 8. */
>>         total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
>> --
>> 2.39.2
>>
>>
> .


