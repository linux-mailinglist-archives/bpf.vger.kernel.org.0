Return-Path: <bpf+bounces-8729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B31789356
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 04:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996A81C21084
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 02:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378217FB;
	Sat, 26 Aug 2023 02:22:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4F394
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 02:22:32 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545452682
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:22:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXgZT0qPSz4f3jMD
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:22:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCHYaTgYelk1c1iBg--.57114S2;
	Sat, 26 Aug 2023 10:22:28 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Enable preemption after
 irq_work_raise() in unit_alloc()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com>
 <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com>
 <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
 <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com>
 <CAADnVQLHPx-0dR7nBXAfBHOpF09Jr6+cqGjfGf9mT2BHCid5YA@mail.gmail.com>
 <5fe435aa-526f-4b54-b0d2-e0ae1c6c234c@huaweicloud.com>
 <CAADnVQLtJBOTueuGZHM0PUhskMZY-uaaehvgfx7pkpq0qfhvVA@mail.gmail.com>
 <a6a78ccf-4a48-be46-f2c7-aa0a5a3285d8@huaweicloud.com>
 <CAADnVQ+NyR-d-P3fdw14ehy2fficAhPikJ2ZrQi1Db-yGNTiCQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <189f54aa-7b5f-f223-c340-1548aec55ab2@huaweicloud.com>
Date: Sat, 26 Aug 2023 10:22:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+NyR-d-P3fdw14ehy2fficAhPikJ2ZrQi1Db-yGNTiCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCHYaTgYelk1c1iBg--.57114S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFykZw17KFykAr43Zr1kXwb_yoW8WrWxpF
	45JFy8ta18Xa42gw1Iva1xGF1aqw48K3WxX3y5Ww13XrWqkryDCFyxKw1agF9Y9r4kKrWI
	yr4vyayft34rZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/26/2023 1:16 AM, Alexei Starovoitov wrote:
> On Thu, Aug 24, 2023 at 11:04 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Could you try the following:
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index 9c49ae53deaf..ee8262f58c5a 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>>> @@ -442,7 +442,10 @@ static void bpf_mem_refill(struct irq_work *work)
>>>
>>>  static void notrace irq_work_raise(struct bpf_mem_cache *c)
>>>  {
>>> -       irq_work_queue(&c->refill_work);
>>> +       if (!irq_work_queue(&c->refill_work)) {
>>> +               preempt_disable_notrace();
>>> +               preempt_enable_notrace();
>>> +       }
>>>  }
>>>
>>> The idea that it will ask for resched if preemptible.
>>> will it address the issue you're seeing?
>>>
>>> .
>> No. It didn't work.
> why?

Don't know the extra reason. It seems preempt_enable_notrace() inovked
in the preemption task doesn't return the CPU back to the preempted
task. Will add some debug info to check that.
>
>> If you are concerning about the overhead of
>> preempt_enabled_notrace(), we could use local_irq_save() and
>> local_irq_restore() instead.
> That's much better.
> Moving local_irq_restore() after irq_work_raise() in process ctx
> would mean that irq_work will execute immediately after local_irq_restore()
> which would make bpf_ma to behave like sync allocation.
> Which is the ideal situation. preempt disable/enable game is more fragile.

OK. So you are OK to wrap the whole implementation of unit_alloc() and
unit_free() by local_irq_saved() and local_irq_restore(), right ?


