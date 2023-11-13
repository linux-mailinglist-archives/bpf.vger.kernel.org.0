Return-Path: <bpf+bounces-14962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05517E93CD
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 01:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC341C208FA
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 00:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52A4401;
	Mon, 13 Nov 2023 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6B3D72
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:57:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331819A3
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 16:57:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ST9xr2sXVz4f3lW9
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 08:57:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5B6841A0199
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 08:57:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDniklxdFFlFrAwAw--.54219S2;
	Mon, 13 Nov 2023 08:57:24 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Add missed allocation hint for
 bpf_mem_cache_alloc_flags()
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231111043821.2258513-1-houtao@huaweicloud.com>
 <ZVEmS3Eu3Dd4BZBe@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a16c9040-9ca5-91e3-4e55-8025fe1f02e3@huaweicloud.com>
Date: Mon, 13 Nov 2023 08:57:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZVEmS3Eu3Dd4BZBe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDniklxdFFlFrAwAw--.54219S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw47Aw4DAryrWFyUury8Krg_yoWfKFg_uF
	W0qF98Z3y3XF4xG3ZYy3WxWF9rKa1xJryI9rZ8Jr1fJFyUuw4kXw4vy3sayF4xtanIvF1r
	Zwnak398W3sF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/13/2023 3:23 AM, Stanislav Fomichev wrote:
> On 11/11, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> bpf_mem_cache_alloc_flags() may call __alloc() directly when there is no
>> free object in free list, but it doesn't initialize the allocation hint
>> for the returned pointer. It may lead to bad memory dereference when
>> freeing the pointer, so fix it by initializing the allocation hint.
>>
>> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Makes sense from briefly looking at the code. But I'll defer to Alexei
> on this one. There is also __alloc call from alloc_bulk and I can't
> quickly grasp why you're fixing this single place only.

alloc_bulk() will allocate new objects through __alloc() and add these
objects into free_llist. When unit_alloc() gets free object from
free_llist, it has already assign the allocation hint for the allocated
object.

> .


