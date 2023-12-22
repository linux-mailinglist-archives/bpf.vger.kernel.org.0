Return-Path: <bpf+bounces-18595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F56081C75D
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 10:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FBD1F241C1
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E334DF55;
	Fri, 22 Dec 2023 09:36:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304ADF42
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SxMcZ3Jkjz4f48lc
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 17:36:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B757E1A0180
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 17:36:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCH6riRWIVlhRkEEQ--.48700S2;
	Fri, 22 Dec 2023 17:36:19 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v6 5/8] bpf: Use smaller low/high marks for
 percpu allocation
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231222031729.1287957-1-yonghong.song@linux.dev>
 <20231222031755.1289671-1-yonghong.song@linux.dev>
Message-ID: <b4782d61-2398-5862-474b-d2878885e5c0@huaweicloud.com>
Date: Fri, 22 Dec 2023 17:36:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222031755.1289671-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCH6riRWIVlhRkEEQ--.48700S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUCF18JF13Kr1DArWrKrg_yoWDGFbEkw
	1ktF4fA343Ja48tw4vqa1kJrW0grWrJ3Z0gFnxtw1fJa4FyFs7t39Fqw1Sqa17Jw17ur93
	urnxJ3WYqr17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UGYL9UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/22/2023 11:17 AM, Yonghong Song wrote:
> Currently, refill low/high marks are set with the assumption
> of normal non-percpu memory allocation. For example, for
> an allocation size 256, for non-percpu memory allocation,
> low mark is 32 and high mark is 96, resulting in the
> batch allocation of 48 elements and the allocated memory
> will be 48 * 256 = 12KB for this particular cpu.
> Assuming an 128-cpu system, the total memory consumption
> across all cpus will be 12K * 128 = 1.5MB memory.
>
> This might be okay for non-percpu allocation, but may not be
> good for percpu allocation, which will consume 1.5MB * 128 = 192MB
> memory in the worst case if every cpu has a chance of memory
> allocation.
>
> In practice, percpu allocation is very rare compared to
> non-percpu allocation. So let us have smaller low/high marks
> which can avoid unnecessary memory consumption.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Hou Tao <houtao1@huawei.com>


