Return-Path: <bpf+bounces-4013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11B747ACA
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 02:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A52280FA7
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB67EF;
	Wed,  5 Jul 2023 00:46:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10663C
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 00:46:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2BE64
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 17:46:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwgvT4yHXz4f3njw
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:46:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHLCdRvaRkWGQNMg--.56614S2;
	Wed, 05 Jul 2023 08:46:14 +0800 (CST)
Subject: Re: [v3 PATCH bpf-next 5/6] selftests/bpf: test map percpu stats
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
 <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
 <ZKQ0iF+8fMND5Qmg@zh-lab-node-5> <ZKQ5chXIwe0ItMbT@zh-lab-node-5>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ec62d127-2cc5-3f0a-6eb7-d77a9aaaa7a3@huaweicloud.com>
Date: Wed, 5 Jul 2023 08:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKQ5chXIwe0ItMbT@zh-lab-node-5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHLCdRvaRkWGQNMg--.56614S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW5uw4kZr4DJF1fuw4UJwb_yoWDJwbEvr
	WUArykCw1Ygw4Dt398tr45XasxJry3Zr4ktryDKryxZ345JaykArs29wn5Aan3XFsxtrsI
	qr4Fqa4Yv3WavjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/4/2023 11:23 PM, Anton Protopopov wrote:
> On Tue, Jul 04, 2023 at 03:02:32PM +0000, Anton Protopopov wrote:
>> On Tue, Jul 04, 2023 at 10:41:10PM +0800, Hou Tao wrote:
>>> Hi,
>>>
>>> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
>>> [...]
>>>> +}
>>>> +
>>>> +void test_map_percpu_stats(void)
>>>> +{
>>>> +	map_percpu_stats_hash();
>>>> +	map_percpu_stats_percpu_hash();
>>>> +	map_percpu_stats_hash_prealloc();
>>>> +	map_percpu_stats_percpu_hash_prealloc();
>>>> +	map_percpu_stats_lru_hash();
>>>> +	map_percpu_stats_percpu_lru_hash();
>>>> +}
>>> Please use test__start_subtest() to create multiple subtests.
> After looking at code, I think that I will leave the individual functions here,
> as the test__start_subtest() function is only implemented in test_progs (not
> test_maps), and adding it here looks like out of scope for this patch.
> .
I see. But can we just add these tests in test_progs instead which is
more flexible ?


