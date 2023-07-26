Return-Path: <bpf+bounces-5936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF976352A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92A11C21242
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BCDBA46;
	Wed, 26 Jul 2023 11:38:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEE8466
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:38:14 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C761BF8
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 04:38:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9sN02r76z4f4Fmd
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:38:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgD31tSgBcFkVZ4gOw--.57522S2;
	Wed, 26 Jul 2023 19:38:09 +0800 (CST)
Subject: Re: [PATCH bpf 1/2] bpf/memalloc: Non-atomically allocate freelist
 during prefill
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
References: <cover.1689885610.git.zhuyifei@google.com>
 <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
 <0f90694e-308c-65e6-5360-a3d5dc7337b1@huaweicloud.com>
 <CAA-VZPmhm3SoD+tX-xPSj6wuOvFg=uZoar0b=sgAyLRz=5n+2A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0d242e21-3f53-87ca-7aa8-bb55b5223552@huaweicloud.com>
Date: Wed, 26 Jul 2023 19:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAA-VZPmhm3SoD+tX-xPSj6wuOvFg=uZoar0b=sgAyLRz=5n+2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgD31tSgBcFkVZ4gOw--.57522S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4UuFWftr48Zry8GF4DArb_yoWkCFb_uF
	4kZrsF93y5GryIk3Z3ta1Ygr9rKw4kXF1UGrZ8J3sxXFZ5Xa97WF12kr1fZ3yxJayxZrnI
	ga4Fqa13Zr12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/21/2023 10:31 AM, YiFei Zhu wrote:
> On Thu, Jul 20, 2023 at 6:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> On 7/21/2023 4:44 AM, YiFei Zhu wrote:
>>> Sometimes during prefill all precpu chunks are full and atomic
>>> __alloc_percpu_gfp would not allocate new chunks. This will cause
>>> -ENOMEM immediately upon next unit_alloc.
>>>
>>> Prefill phase does not actually run in atomic context, so we can
>>> use this fact to allocate non-atomically with GFP_KERNEL instead
>>> of GFP_NOWAIT. This avoids the immediate -ENOMEM. Unfortunately
>>> unit_alloc runs in atomic context, even from map item allocation in
>>> syscalls, due to rcu_read_lock, so we can't do non-atomic
>>> workarounds in unit_alloc.
>>>
>>> Fixes: 4ab67149f3c6 ("bpf: Add percpu allocation support to bpf_mem_alloc.")
>>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Make sense to me, so
>>
>> Acked-by: Hou Tao <houtao1@huawei.com>
>>
>> But I don't know whether or not it is suitable for bpf tree.
> I don't mind either way :) If changing to bpf-next requires a resend I
> can do that too.

Please resend and rebase the patch again bpf-next tree.


