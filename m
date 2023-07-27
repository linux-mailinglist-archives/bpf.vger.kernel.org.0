Return-Path: <bpf+bounces-6033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623897643BA
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 04:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933791C2147B
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADA15BC;
	Thu, 27 Jul 2023 02:15:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7947C
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 02:15:08 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0961BDA
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:15:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RBDqm5cMRz4f3jXq
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 10:15:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBHVuci08FkjJVQOw--.1208S2;
	Thu, 27 Jul 2023 10:15:01 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev, Andrii Nakryiko <andrii@kernel.org>
References: <20230724132543.1282645-1-awerner32@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d4822c80-134a-e446-cf26-17d2a71323f8@huaweicloud.com>
Date: Thu, 27 Jul 2023 10:14:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230724132543.1282645-1-awerner32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBHVuci08FkjJVQOw--.1208S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryfAw4DGw47WryrKFWrGrg_yoW8WF18pF
	WrtryFkrsrJr4Syw4xCr4xAF1rCrs7AanxJrn3Gr1Fv3Z0gr1IkF97KayYqr1fCrn5uFWY
	v34Yq3s7CFyUZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/2023 9:25 PM, Andrew Werner wrote:
> Before this patch, the producer position could overflow `unsigned
> long`, in which case libbpf would forever stop processing new writes to
> the ringbuf. This patch addresses that bug by avoiding ordered
> comparison between the consumer and producer position. If the consumer
> position is greater than the producer position, the assumption is that
> the producer has overflowed.
>
> A more defensive check could be to ensure that the delta is within
> the allowed range, but such defensive checks are neither present in
> the kernel side code nor in libbpf. The overflow that this patch
> handles can occur while the producer and consumer follow a correct
> protocol.
>
> A selftest was written to demonstrate the bug, and indeed this patch
> allows the test to continue to make progress past the overflow.
> However, the author was unable to create a testing environment on a
> 32-bit machine, and the test requires substantial memory and over 4
> hours to hit the overflow point on a 64-bit machine. Thus, the test
> is not included in this patch because of the impracticality of running
> it.
>
> Additionally, this patch adds commentary around a separate point to note
> that the modular arithmetic is valid in the face of overflows, as that
> fact may not be obvious to future readers.
>
> v1->v2:
>  - Fixed comment grammar.
>  - Properly formatted subject line.
>
> Reference:
> [v1]: https://lore.kernel.org/bpf/20230724132404.1280848-1-awerner32@gmail.com/T/#u
>
> Signed-off-by: Andrew Werner <awerner32@gmail.com>

Acked-by: Hou Tao <houtao1@huawei.com>


