Return-Path: <bpf+bounces-8741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5357895F2
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672071C2101E
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E1C8C7;
	Sat, 26 Aug 2023 10:27:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724F8834
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:27:54 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1B1711
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 03:27:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXtLX2vK5z4f3k5m
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 18:27:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB36yeh0+lkyW8iBg--.31085S2;
	Sat, 26 Aug 2023 18:27:48 +0800 (CST)
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, yonghong.song@linux.dev,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
 <200dcce6-34ff-83e0-02fb-709a24403cc6@huaweicloud.com>
 <87zg2e88ds.fsf@all.your.base.are.belong.to.us>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <64873e42-9be1-1812-b80d-5ea86b4677f0@huaweicloud.com>
Date: Sat, 26 Aug 2023 18:27:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87zg2e88ds.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB36yeh0+lkyW8iBg--.31085S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4DAFyrGry3ArW5Ar1kZrb_yoWxZr1kpr
	WfJ3W7GrW8Ar1ktr17Kr15Jryjyr1UA3WUJr18JFyrAr1UWr1jgr18XryjgF1DJr4rZF17
	Jr1DJ3yIvF1UGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/26/2023 5:23 PM, Björn Töpel wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> Hi,
>>
>> On 8/25/2023 11:28 PM, Yonghong Song wrote:
>>>
>>> On 8/25/23 3:32 AM, Björn Töpel wrote:
>>>> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
>>>> selftests on bpf-next 9e3b47abeb8f.
>>>>
>>>> I'm able to reproduce the hang by multiple runs of:
>>>>   | ./test_progs -a link_api -a linked_list
>>>> I'm currently investigating that.
>>>>
>>>> But! Sometimes (every blue moon) I get a warn_on_once hit:
>>>>   | ------------[ cut here ]------------
>>>>   | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
>>>> bpf_mem_refill+0x1fc/0x206
>>>>   | Modules linked in: bpf_testmod(OE)
>>>>   | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE   
>>>> N 6.5.0-rc5-01743-gdcb152bb8328 #2
>>>>   | Hardware name: riscv-virtio,qemu (DT)
>>>>   | epc : bpf_mem_refill+0x1fc/0x206
>>>>   |  ra : irq_work_single+0x68/0x70
>>>>   | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be20
>>>>   |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000000046600
>>>>   |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be70
>>>>   |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b000
>>>>   |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000000000060
>>>>   |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000000735049
>>>>   |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000000001000
>>>>   |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd30
>>>>   |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000ffff
>>>>   |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000000000000
>>>>   |  t5 : ff6000008fd28278 t6 : 0000000000040000
>>>>   | status: 0000000200000100 badaddr: 0000000000000000 cause:
>>>> 0000000000000003
>>>>   | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
>>>>   | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
>>>>   | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
>>>>   | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
>>>>   | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
>>>>   | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
>>>>   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>>>>   | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
>>>>   | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
>>>>   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>>>>   | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
>>>>   | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
>>>>   | [<ffffffff812b6904>] do_irq+0x66/0x98
>>>>   | ---[ end trace 0000000000000000 ]---
>>>>
>>>> Code:
>>>>   | static void free_bulk(struct bpf_mem_cache *c)
>>>>   | {
>>>>   |     struct bpf_mem_cache *tgt = c->tgt;
>>>>   |     struct llist_node *llnode, *t;
>>>>   |     unsigned long flags;
>>>>   |     int cnt;
>>>>   |
>>>>   |     WARN_ON_ONCE(tgt->unit_size != c->unit_size);
>>>>   | ...
>>>>
>>>> I'm not well versed in the memory allocator; Before I dive into it --
>>>> has anyone else hit it? Ideas on why the warn_on_once is hit?
>>> Maybe take a look at the patch
>>>   822fb26bdb55  bpf: Add a hint to allocated objects.
>>>
>>> In the above patch, we have
>>>
>>> +       /*
>>> +        * Remember bpf_mem_cache that allocated this object.
>>> +        * The hint is not accurate.
>>> +        */
>>> +       c->tgt = *(struct bpf_mem_cache **)llnode;
>>>
>>> I suspect that the warning may be related to the above.
>>> I tried the above ./test_progs command line (running multiple
>>> at the same time) and didn't trigger the issue.
>> The extra 8-bytes before the freed pointer is used to save the pointer
>> of the original bpf memory allocator where the freed pointer came from,
>> so unit_free() could free the pointer back to the original allocator to
>> prevent alloc-and-free unbalance.
>>
>> I suspect that a wrong pointer was passed to bpf_obj_drop, but do not
>> find anything suspicious after checking linked_list. Another possibility
>> is that there is write-after-free problem which corrupts the extra
>> 8-bytes before the freed pointer. Could you please apply the following
>> debug patch to check whether or not the extra 8-bytes are corrupted ?
> Thanks for getting back!
>
> I took your patch for a run, and there's a hit:
>   | bad cache ff5ffffffffe8570: got size 96 work ffffffff801b19c8, cache ff5ffffffffe8980 exp size 128 work ffffffff801b19c8

The extra 8-bytes are not corrupted. Both of these two bpf_mem_cache are
valid and there are in the cache array defined in bpf_mem_caches. BPF
memory allocator allocated the pointer from 96-bytes sized-cache, but it
tried to free the pointer through 128-bytes sized-cache.

Now I suspect there is no 96-bytes slab in your system and ksize(ptr -
LLIST_NODE_SZ) returns 128, so bpf memory allocator selected the
128-byte sized-cache instead of 96-bytes sized-cache. Could you please
check the value of KMALLOC_MIN_SIZE in your kernel .config and using the
following command to check whether there is 96-bytes slab in your system:

$ cat /proc/slabinfo |grep kmalloc-96
dma-kmalloc-96         0      0     96   42    1 : tunables    0    0   
0 : slabdata      0      0      0
kmalloc-96          1865   2268     96   42    1 : tunables    0    0   
0 : slabdata     54     54      0

In my system, slab has 96-bytes cached, so grep outputs something, but I
think there will no output in your system.

>   | WARNING: CPU: 3 PID: 265 at kernel/bpf/memalloc.c:847 bpf_mem_free+0xb2/0xe0
>   | ---[ end trace 0000000000000000 ]---
>   | 00000000: 80 e3 dc 85 00 00 60 ff 00 00 00 00 00 00 00 00
>   | 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 00000020: 20 00 00 00 00 00 00 00 c8 19 1b 80 ff ff ff ff
>   | 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 00000040: 60 00 00 00 33 00 00 00 20 00 00 00 60 00 00 00
>   | 00000050: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 00000060: 70 85 fe ff ff ff 5f ff 00 00 00 00 00 00 00 00
>   | 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   | WARNING: CPU: 2 PID: 265 at kernel/bpf/memalloc.c:342 bpf_mem_refill+0x1fc/0x206
>   | ---[ end trace 0000000000000000 ]---
>
>
> Björn


