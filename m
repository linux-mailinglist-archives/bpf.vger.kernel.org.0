Return-Path: <bpf+bounces-8731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569FF7893B3
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 05:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B181C20F35
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 03:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1E818;
	Sat, 26 Aug 2023 03:48:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9727E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 03:48:26 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94E213D
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 20:48:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXjTT4D5Xz4f3jXg
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 11:48:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3jaD9delkSHdnBg--.43954S2;
	Sat, 26 Aug 2023 11:48:16 +0800 (CST)
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, yonghong.song@linux.dev,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <200dcce6-34ff-83e0-02fb-709a24403cc6@huaweicloud.com>
Date: Sat, 26 Aug 2023 11:48:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
Content-Type: multipart/mixed;
 boundary="------------F8A338A4793F84B37BC09D79"
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3jaD9delkSHdnBg--.43954S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr47Xry7Gr4DAw15JryfCrg_yoWrAw4kpr
	WfJ347Gr4vkr4vgr4UGry5Jry8Cr18Aa47Jr18XFy5AF1UWr1jgr18JrWYgw1DJr4rXF17
	Xr1qq3y0vF1UGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4xvF2IEb7IF0Fy26I8I
	3I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4
	xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUzNVyDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------F8A338A4793F84B37BC09D79
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/25/2023 11:28 PM, Yonghong Song wrote:
>
>
> On 8/25/23 3:32 AM, Björn Töpel wrote:
>> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
>> selftests on bpf-next 9e3b47abeb8f.
>>
>> I'm able to reproduce the hang by multiple runs of:
>>   | ./test_progs -a link_api -a linked_list
>> I'm currently investigating that.
>>
>> But! Sometimes (every blue moon) I get a warn_on_once hit:
>>   | ------------[ cut here ]------------
>>   | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
>> bpf_mem_refill+0x1fc/0x206
>>   | Modules linked in: bpf_testmod(OE)
>>   | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE   
>> N 6.5.0-rc5-01743-gdcb152bb8328 #2
>>   | Hardware name: riscv-virtio,qemu (DT)
>>   | epc : bpf_mem_refill+0x1fc/0x206
>>   |  ra : irq_work_single+0x68/0x70
>>   | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be20
>>   |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000000046600
>>   |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be70
>>   |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b000
>>   |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000000000060
>>   |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000000735049
>>   |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000000001000
>>   |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd30
>>   |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000ffff
>>   |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000000000000
>>   |  t5 : ff6000008fd28278 t6 : 0000000000040000
>>   | status: 0000000200000100 badaddr: 0000000000000000 cause:
>> 0000000000000003
>>   | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
>>   | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
>>   | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
>>   | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
>>   | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
>>   | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
>>   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>>   | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
>>   | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
>>   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>>   | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
>>   | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
>>   | [<ffffffff812b6904>] do_irq+0x66/0x98
>>   | ---[ end trace 0000000000000000 ]---
>>
>> Code:
>>   | static void free_bulk(struct bpf_mem_cache *c)
>>   | {
>>   |     struct bpf_mem_cache *tgt = c->tgt;
>>   |     struct llist_node *llnode, *t;
>>   |     unsigned long flags;
>>   |     int cnt;
>>   |
>>   |     WARN_ON_ONCE(tgt->unit_size != c->unit_size);
>>   | ...
>>
>> I'm not well versed in the memory allocator; Before I dive into it --
>> has anyone else hit it? Ideas on why the warn_on_once is hit?
>
> Maybe take a look at the patch
>   822fb26bdb55  bpf: Add a hint to allocated objects.
>
> In the above patch, we have
>
> +       /*
> +        * Remember bpf_mem_cache that allocated this object.
> +        * The hint is not accurate.
> +        */
> +       c->tgt = *(struct bpf_mem_cache **)llnode;
>
> I suspect that the warning may be related to the above.
> I tried the above ./test_progs command line (running multiple
> at the same time) and didn't trigger the issue.

The extra 8-bytes before the freed pointer is used to save the pointer
of the original bpf memory allocator where the freed pointer came from,
so unit_free() could free the pointer back to the original allocator to
prevent alloc-and-free unbalance.

I suspect that a wrong pointer was passed to bpf_obj_drop, but do not
find anything suspicious after checking linked_list. Another possibility
is that there is write-after-free problem which corrupts the extra
8-bytes before the freed pointer. Could you please apply the following
debug patch to check whether or not the extra 8-bytes are corrupted ?




>
>>
>>
>> Björn
>>
>
> .


--------------F8A338A4793F84B37BC09D79
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Debug-for-bpf_mem_free.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-bpf-Debug-for-bpf_mem_free.patch"

RnJvbSA2OWU5YTI4MTA3N2VhZGNjNzNhNDk4NzZlZTZjNDEwM2VhOTRiMjU3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIb3UgVGFvIDxob3V0YW8xQGh1YXdlaS5jb20+CkRh
dGU6IFNhdCwgMjYgQXVnIDIwMjMgMTE6MzA6NDUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBi
cGY6IERlYnVnIGZvciBicGZfbWVtX2ZyZWUoKQoKU2lnbmVkLW9mZi1ieTogSG91IFRhbyA8
aG91dGFvMUBodWF3ZWkuY29tPgotLS0KIGtlcm5lbC9icGYvbWVtYWxsb2MuYyB8IDE4ICsr
KysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL21lbWFsbG9jLmMgYi9rZXJu
ZWwvYnBmL21lbWFsbG9jLmMKaW5kZXggNjYyODM4YTM0NjI5Li5mYjRmYTA2MDVhNjAgMTAw
NjQ0Ci0tLSBhL2tlcm5lbC9icGYvbWVtYWxsb2MuYworKysgYi9rZXJuZWwvYnBmL21lbWFs
bG9jLmMKQEAgLTgzMCw2ICs4MzAsOSBAQCB2b2lkIG5vdHJhY2UgKmJwZl9tZW1fYWxsb2Mo
c3RydWN0IGJwZl9tZW1fYWxsb2MgKm1hLCBzaXplX3Qgc2l6ZSkKIAogdm9pZCBub3RyYWNl
IGJwZl9tZW1fZnJlZShzdHJ1Y3QgYnBmX21lbV9hbGxvYyAqbWEsIHZvaWQgKnB0cikKIHsK
KwlzdHJ1Y3QgYnBmX21lbV9jYWNoZSAqZnJvbSwgKnRvOworCXN0cnVjdCBicGZfbWVtX2Nh
Y2hlcyAqY2M7CisJc3RhdGljIGludCBvbmNlOwogCWludCBpZHg7CiAKIAlpZiAoIXB0cikK
QEAgLTgzOSw3ICs4NDIsMjAgQEAgdm9pZCBub3RyYWNlIGJwZl9tZW1fZnJlZShzdHJ1Y3Qg
YnBmX21lbV9hbGxvYyAqbWEsIHZvaWQgKnB0cikKIAlpZiAoaWR4IDwgMCkKIAkJcmV0dXJu
OwogCi0JdW5pdF9mcmVlKHRoaXNfY3B1X3B0cihtYS0+Y2FjaGVzKS0+Y2FjaGUgKyBpZHgs
IHB0cik7CisJY2MgPSB0aGlzX2NwdV9wdHIobWEtPmNhY2hlcyk7CisJdG8gPSBjYy0+Y2Fj
aGUgKyBpZHg7CisJZnJvbSA9ICooc3RydWN0IGJwZl9tZW1fY2FjaGUgKiopKHB0ciAtIExM
SVNUX05PREVfU1opOworCWlmICghb25jZSAmJiB0by0+dW5pdF9zaXplICE9IGZyb20tPnVu
aXRfc2l6ZSkgeworCQlvbmNlID0gdHJ1ZTsKKwkJcHJfZXJyKCJiYWQgY2FjaGUgJXB4OiBn
b3Qgc2l6ZSAldSB3b3JrICVweCwgY2FjaGUgJXB4IGV4cCBzaXplICV1IHdvcmsgJXB4XG4i
LAorCQkgICAgICAgZnJvbSwgZnJvbS0+dW5pdF9zaXplLCBmcm9tLT5yZWZpbGxfd29yay5m
dW5jLAorCQkgICAgICAgdG8sIHRvLT51bml0X3NpemUsIHRvLT5yZWZpbGxfd29yay5mdW5j
KTsKKwkJV0FSTl9PTigxKTsKKwkJcHJpbnRfaGV4X2R1bXAoS0VSTl9FUlIsICIiLCBEVU1Q
X1BSRUZJWF9PRkZTRVQsIDE2LCAxLAorCQkJICAgICAgIGZyb20sIHNpemVvZigqZnJvbSks
IGZhbHNlKTsKKwl9CisKKwl1bml0X2ZyZWUodG8sIHB0cik7CiB9CiAKIHZvaWQgbm90cmFj
ZSBicGZfbWVtX2ZyZWVfcmN1KHN0cnVjdCBicGZfbWVtX2FsbG9jICptYSwgdm9pZCAqcHRy
KQotLSAKMi4yOS4yCgo=
--------------F8A338A4793F84B37BC09D79--


