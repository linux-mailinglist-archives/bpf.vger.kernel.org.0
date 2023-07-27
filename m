Return-Path: <bpf+bounces-6027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B840B764337
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 03:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99C81C214A6
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857915A3;
	Thu, 27 Jul 2023 01:06:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B967C
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:06:28 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628571BC1;
	Wed, 26 Jul 2023 18:06:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RBCJY75CDz4f3kFJ;
	Thu, 27 Jul 2023 09:06:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAH_xwNw8FkloRjNw--.11314S2;
	Thu, 27 Jul 2023 09:06:24 +0800 (CST)
Subject: Re: [PATCH] libbpf: Expose API to consume one ring at a time
To: Adam Sindelar <adam@wowsignal.io>, bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
 Brendan Jackman <jackmanb@google.com>, KP Singh <kpsingh@chromium.org>,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Florent Revest <revest@chromium.org>
References: <20230725162654.912897-1-adam@wowsignal.io>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cb844776-9045-1b69-f1db-8ef7d75815b5@huaweicloud.com>
Date: Thu, 27 Jul 2023 09:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230725162654.912897-1-adam@wowsignal.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAH_xwNw8FkloRjNw--.11314S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4rJF1rtrWfXr45tr4fKrg_yoW8tF4rpr
	s0kry3Grs5uryfZFZxWF1Sq3yYvan7Xr4xKrWxJw1UA39rJF4DXr1jkr13Ar43XrWkK34a
	yr1Yga4UCry8WwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/26/2023 12:26 AM, Adam Sindelar wrote:
> We already provide ring_buffer__epoll_fd to enable use of external
> polling systems. However, the only API available to consume the ring
> buffer is ring_buffer__consume, which always checks all rings. When
> polling for many events, this can be wasteful.
>
> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> ---
>  tools/lib/bpf/libbpf.h  |  1 +
>  tools/lib/bpf/ringbuf.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 55b97b2087540..20ccc65eb3f9d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>  				ring_buffer_sample_fn sample_cb, void *ctx);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>  
>  struct user_ring_buffer_opts {
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db136..8d087bfc7d005 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -290,6 +290,21 @@ int ring_buffer__consume(struct ring_buffer *rb)
>  	return res;
>  }
>  
> +/* Consume available data from a single RINGBUF map identified by its ID.
> + * The ring ID is returned in epoll_data by epoll_wait when called with
> + * ring_buffer__epoll_fd.
> + */
> +int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
> +{
> +	struct ring *ring;
> +
> +	if (ring_id >= rb->ring_cnt)
> +		return libbpf_err(-EINVAL);
> +
> +	ring = &rb->rings[ring_id];
> +	return ringbuf_process_ring(ring);

When ringbuf_process_ring() returns an error, we need to use
libbpf_err() to set the errno accordingly.
> +}
> +
>  /* Poll for available data and consume records, if any are available.
>   * Returns number of records consumed (or INT_MAX, whichever is less), or
>   * negative number, if any of the registered callbacks returned error.


