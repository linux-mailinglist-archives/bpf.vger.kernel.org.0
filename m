Return-Path: <bpf+bounces-18260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412C818006
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 04:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED081C22C3E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B1469D;
	Tue, 19 Dec 2023 03:04:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11C4411
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SvM3M4B6wz4f3l2J
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:03:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4EB1A1A0A1C
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:04:02 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBXbLohCIFlQ_DkDw--.427S2;
	Tue, 19 Dec 2023 11:04:02 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231218063031.3037929-1-yonghong.song@linux.dev>
 <20231218063047.3040611-1-yonghong.song@linux.dev>
Message-ID: <69fa30e8-81d2-5f61-3248-4ce7320cbfe8@huaweicloud.com>
Date: Tue, 19 Dec 2023 11:04:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231218063047.3040611-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBXbLohCIFlQ_DkDw--.427S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8CFWDuF1DCF18ZrW7CFg_yoW5GFyfpa
	yDW34rCF90vrnrGw4kK3WkCr1rG3yrWr1DJ3yYyr4qkrnxJ3WIkryktws09a4kZws5GF1Y
	qayDZr17XayjvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/18/2023 2:30 PM, Yonghong Song wrote:
> Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem allocation")
> added support for non-fix-size percpu memory allocation.
> Such allocation will allocate percpu memory for all buckets on all
> cpus and the memory consumption is in the order to quadratic.
> For example, let us say, 4 cpus, unit size 16 bytes, so each
> cpu has 16 * 4 = 64 bytes, with 4 cpus, total will be 64 * 4 = 256 bytes.
> Then let us say, 8 cpus with the same unit size, each cpu
> has 16 * 8 = 128 bytes, with 8 cpus, total will be 128 * 8 = 1024 bytes.
> So if the number of cpus doubles, the number of memory consumption
> will be 4 times. So for a system with large number of cpus, the
> memory consumption goes up quickly with quadratic order.
> For example, for 4KB percpu allocation, 128 cpus. The total memory
> consumption will 4KB * 128 * 128 = 64MB. Things will become
> worse if the number of cpus is bigger (e.g., 512, 1024, etc.)
>
> In Commit 41a5db8d8161, the non-fix-size percpu memory allocation is
> done in boot time, so for system with large number of cpus, the initial
> percpu memory consumption is very visible. For example, for 128 cpu
> system, the total percpu memory allocation will be at least
> (16 + 32 + 64 + 96 + 128 + 196 + 256 + 512 + 1024 + 2048 + 4096)
>   * 128 * 128 = ~138MB.
> which is pretty big. It will be even bigger for larger number of cpus.
>
> Note that the current prefill also allocates 4 entries if the unit size
> is less than 256. So on top of 138MB memory consumption, this will
> add more consumption with
> 3 * (16 + 32 + 64 + 96 + 128 + 196 + 256) * 128 * 128 = ~38MB.
> Next patch will try to reduce this memory consumption.
>
> Later on, Commit 1fda5bb66ad8 ("bpf: Do not allocate percpu memory
> at init stage") moved the non-fix-size percpu memory allocation
> to bpf verificaiton stage. Once a particular bpf_percpu_obj_new()
> is called by bpf program, the memory allocator will try to fill in
> the cache with all sizes, causing the same amount of percpu memory
> consumption as in the boot stage.
>
> To reduce the initial percpu memory consumption for non-fix-size
> percpu memory allocation, instead of filling the cache with all
> supported allocation sizes, this patch intends to fill the cache
> only for the requested size. As typically users will not use large
> percpu data structure, this can save memory significantly.
> For example, the allocation size is 64 bytes with 128 cpus.
> Then total percpu memory amount will be 64 * 128 * 128 = 1MB,
> much less than previous 138MB.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Hou Tao <houtao1@huawei.com>


