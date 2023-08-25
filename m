Return-Path: <bpf+bounces-8540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D0F787E6B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 05:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93858281715
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 03:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6480F;
	Fri, 25 Aug 2023 03:17:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A97E0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 03:17:19 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFB1FDF
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 20:17:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RX4qz2QgSz4f3tDp
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:17:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3Mi8uHehkeVfABQ--.6805S2;
	Fri, 25 Aug 2023 11:17:06 +0800 (CST)
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, olsajiri@gmail.com, void@manifault.com
References: <20230824220907.1172808-1-awerner32@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a811af2f-3c5d-64dc-c49a-f865b2de9967@huaweicloud.com>
Date: Fri, 25 Aug 2023 11:17:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230824220907.1172808-1-awerner32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3Mi8uHehkeVfABQ--.6805S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1DWFyUAFW5Gr4kXFWDJwb_yoWxXrykpF
	s8KF4FyrZrZr1rCw17ury0vryrua1kXw4fGF97Kry8Ar1DWFnY9FyxKFW3Kr4fGrykur1F
	v390g3s2kr1UZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/25/2023 6:09 AM, Andrew Werner wrote:
> Before this patch, the producer position could overflow `unsigned
> long`, in which case libbpf would forever stop processing new writes to
> the ringbuf. Similarly, overflows of the producer position could result
> in __bpf_user_ringbuf_peek not discovering available data. This patch
> addresses that bug by computing using the signed delta between the
> consumer and producer position to determine if data is available; the
> delta computation is robust to overflow.
>
> A more defensive check could be to ensure that the delta is within
> the allowed range, but such defensive checks are neither present in
> the kernel side code nor in libbpf. The overflow that this patch
> handles can occur while the producer and consumer follow a correct
> protocol.
>
> Secondarily, the type used to represent the positions in the
> user_ring_buffer functions in both libbpf and the kernel has been
> changed from u64 to unsigned long to match the type used in the
> kernel's representation of the structure. The change occurs in the
> same patch because it's required to align the data availability
> calculations between the userspace producing ringbuf and the bpf
> producing ringbuf.

Because the changes include both the change for ring buffer and user
ring buffer. I think it is better to split the changes into three
patches to ease the backports of these changes: one patch for change in
libbpf for ring buffer, and another two patches for changes in libbpf
and kernel for user ring buffer.
>
> Not included in this patch, a selftest was written to demonstrate the
> bug, and indeed this patch allows the test to continue to make progress
> past the overflow. The shape of the self test was as follows:
>
>  a) Set up ringbuf of 2GB size (the maximum permitted size).
>  b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
>     fast as possible.

ULONG_MAX -> UINT_MAX ?
>
> With 1 million records per second repro time should be about 4.7 hours.
> Such a test duration is impractical to run, hence the omission.
>
> Additionally, this patch adds commentary around a separate point to note
> that the modular arithmetic is valid in the face of overflows, as that
> fact may not be obvious to future readers.
>
> v2->v3:
>   - Changed the representation of the consumer and producer positions
>     from u64 to unsigned long in user_ring_buffer functions. 
>   - Addressed overflow in __bpf_user_ringbuf_peek.
>   - Changed data availability computations to use the signed delta
>     between the consumer and producer positions rather than merely
>     checking whether their values were unequal.
> v1->v2:
>   - Fixed comment grammar.
>   - Properly formatted subject line.
>
> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> ---
>  kernel/bpf/ringbuf.c    | 11 ++++++++---
>  tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
>  2 files changed, 21 insertions(+), 6 deletions(-)

Otherwise, these changes look good to me:

Acked-by: Hou Tao <houtao1@huawei.com>

>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index f045fde632e5..0c48673520fb 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>  {
>  	int err;
>  	u32 hdr_len, sample_len, total_len, flags, *hdr;
> -	u64 cons_pos, prod_pos;
> +	unsigned long cons_pos, prod_pos;
>  
>  	/* Synchronizes with smp_store_release() in user-space producer. */
>  	prod_pos = smp_load_acquire(&rb->producer_pos);
> @@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>  
>  	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
>  	cons_pos = smp_load_acquire(&rb->consumer_pos);
> -	if (cons_pos >= prod_pos)
> +
> +	/* Check if there's data available by computing the signed delta between
> +	 * cons_pos and prod_pos; a negative delta indicates that the consumer has
> +	 * not caught up. This formulation is robust to prod_pos wrapping around.
> +	 */
> +	if ((long)(cons_pos - prod_pos) >= 0)
>  		return -ENODATA;
>  
>  	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> @@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>  
>  static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
>  {
> -	u64 consumer_pos;
> +	unsigned long consumer_pos;
>  	u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
>  
>  	/* Using smp_load_acquire() is unnecessary here, as the busy-bit
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..141030a89370 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring *r)
>  	do {
>  		got_new_data = false;
>  		prod_pos = smp_load_acquire(r->producer_pos);
> -		while (cons_pos < prod_pos) {
> +
> +		/* Check if there's data available by computing the signed delta
> +		 * between cons_pos and prod_pos; a negative delta indicates that the
> +		 * consumer has not caught up. This formulation is robust to prod_pos
> +		 * wrapping around.
> +		 */
> +		while ((long)(cons_pos - prod_pos) < 0) {
>  			len_ptr = r->data + (cons_pos & r->mask);
>  			len = smp_load_acquire(len_ptr);
>  
> @@ -482,8 +488,7 @@ void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample)
>  void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
>  {
>  	__u32 avail_size, total_size, max_size;
> -	/* 64-bit to avoid overflow in case of extreme application behavior */
> -	__u64 cons_pos, prod_pos;
> +	unsigned long cons_pos, prod_pos;
>  	struct ringbuf_hdr *hdr;
>  
>  	/* The top two bits are used as special flags */
> @@ -498,6 +503,11 @@ void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
>  	prod_pos = smp_load_acquire(rb->producer_pos);
>  
>  	max_size = rb->mask + 1;
> +
> +	/* Note that this formulation is valid in the face of overflow of
> +	 * prod_pos so long as the delta between prod_pos and cons_pos is
> +	 * no greater than max_size.
> +	 */
>  	avail_size = max_size - (prod_pos - cons_pos);
>  	/* Round up total size to a multiple of 8. */
>  	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;


