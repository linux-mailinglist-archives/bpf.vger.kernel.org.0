Return-Path: <bpf+bounces-10197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEFF7A2D84
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 04:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE141C20C90
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 02:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559A5686;
	Sat, 16 Sep 2023 02:38:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66821107
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 02:38:32 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908AD195
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 19:38:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RnZx34K7Sz4f3kK2
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 10:38:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBn_t0RFQVluE9TAg--.58871S2;
	Sat, 16 Sep 2023 10:38:13 +0800 (CST)
Subject: Re: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache
 object size
To: Nathan Chancellor <nathan@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, houtao1@huawei.com
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
 <20230908133923.2675053-4-houtao@huaweicloud.com>
 <20230914181407.GA1000274@dev-arch.thelio-3990X>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9c286bd1-7551-0853-1f47-830847ecd04d@huaweicloud.com>
Date: Sat, 16 Sep 2023 10:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230914181407.GA1000274@dev-arch.thelio-3990X>
Content-Type: multipart/mixed;
 boundary="------------BC8A68EEC62CF9401B3FB1EA"
Content-Language: en-US
X-CM-TRANSID:gCh0CgBn_t0RFQVluE9TAg--.58871S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww15JrWfuFyrXrW7WFyDJrb_yoW3tFy5pF
	yagr4UCr4kJr13Jw47Wr1q9a43tr1rZ3W7GF17Xr1rAF1Dur1UXr4kZryfXryqqrWDKF12
	yF1vgr4v9w4DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4xvF2IEb7IF0Fy26I8I
	3I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8Jr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUFyxR
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------BC8A68EEC62CF9401B3FB1EA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/15/2023 2:14 AM, Nathan Chancellor wrote:
> Hi Hou,
>
> On Fri, Sep 08, 2023 at 09:39:22PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
>> bpf_mem_cache is matched with the object_size of underlying slab cache.
>> If these two sizes are unmatched, print a warning once and return
>> -EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early and
>> the potential issue can be prevented.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/memalloc.c | 33 +++++++++++++++++++++++++++++++--
>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 90c1ed8210a2..1c22b90e754a 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -486,6 +486,24 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>>  	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
>>  }
>>  
>> +static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
>> +{
>> +	struct llist_node *first;
>> +	unsigned int obj_size;
>> +
>> +	first = c->free_llist.first;
>> +	if (!first)
>> +		return 0;
>> +
>> +	obj_size = ksize(first);
>> +	if (obj_size != c->unit_size) {
>> +		WARN_ONCE(1, "bpf_mem_cache[%u]: unexpected object size %u, expect %u\n",
>> +			  idx, obj_size, c->unit_size);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
> I am seeing the warning added by this change as commit c93047255202
> ("bpf: Ensure unit_size is matched with slab cache object size") when
> booting ARCH=riscv defconfig in QEMU. I have seen some discussion on the
> mailing list around this, so I apologize if this is a duplicate report
> but it sounded like the previously reported instance of this warning was
> already resolved by some other changeor supposed to be resolved by [1].
> Unfortunately, I tested both current bpf master (currently at
> 6bd5bcb18f94) with and without that change and I still see the warning
> in both cases. The rootfs is available at [2], if it is relevant.

Thanks for the report. It seems it is a new problem which should be
fixed by commit d52b59315bf5 ("bpf: Adjust size_index according to the
value of KMALLOC_MIN_SIZE"), but failed to. However I could not
reproduce the problem by using the provided steps. Do you configure any
boot cmd line in your local setup ? I suspect dma_get_cache_alignment()
returns 64 of 1 in your setup, so slab-96 is rounded up to slab-128.
Could you please run the attached debug patch and post its output ?

> $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux- mrproper defconfig Image
>
> $ qemu-system-riscv64 \
>     -display none \
>     -nodefaults \
>     -bios default \
>     -M virt \
>     -append earlycon \
>     -kernel arch/riscv/boot/Image \
>     -initrd riscv-rootfs.cpio \
>     -m 512m \
>     -serial mon:stdio
> ...
> [    0.000000] Linux version 6.5.0-12679-gc93047255202 (nathan@dev-arch.thelio-3990X) (riscv64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP Thu Sep 14 10:44:41 MST 2023
> ...
> [    0.433002] ------------[ cut here ]------------
> [    0.433128] bpf_mem_cache[0]: unexpected object size 128, expect 96
> [    0.433585] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init+0x348/0x354
> [    0.433810] Modules linked in:
> [    0.433928] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-12679-gc93047255202 #1
> [    0.434025] Hardware name: riscv-virtio,qemu (DT)
> [    0.434105] epc : bpf_mem_alloc_init+0x348/0x354
> [    0.434140]  ra : bpf_mem_alloc_init+0x348/0x354
> [    0.434163] epc : ffffffff80112572 ra : ffffffff80112572 sp : ff2000000000bd30
> [    0.434177]  gp : ffffffff81501588 tp : ff600000018d0000 t0 : ffffffff808cd1a0
> [    0.434190]  t1 : 0720072007200720 t2 : 635f6d656d5f6670 s0 : ff2000000000bdd0
> [    0.434202]  s1 : ffffffff80e17620 a0 : 0000000000000037 a1 : ffffffff814866b8
> [    0.434215]  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
> [    0.434227]  a5 : 0000000000000000 a6 : 0000000000000047 a7 : 0000000000000046
> [    0.434239]  s2 : 000000000000000b s3 : 0000000000000000 s4 : 0000000000000000
> [    0.434251]  s5 : 0000000000000100 s6 : ffffffff815031f8 s7 : ffffffff8153a610
> [    0.434264]  s8 : 0000000000000060 s9 : 0000000000000060 s10: 0000000000000000
> [    0.434276]  s11: ff6000001ffe5410 t3 : ff60000001858f00 t4 : ff60000001858f00
> [    0.434288]  t5 : ff60000001858000 t6 : ff2000000000bb48
> [    0.434299] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.434394] [<ffffffff80112572>] bpf_mem_alloc_init+0x348/0x354
> [    0.434492] [<ffffffff80a0f302>] bpf_global_ma_init+0x1c/0x30
> [    0.434516] [<ffffffff8000212c>] do_one_initcall+0x58/0x19c
> [    0.434526] [<ffffffff80a0105e>] kernel_init_freeable+0x214/0x27e
> [    0.434537] [<ffffffff808db4dc>] kernel_init+0x1e/0x10a
> [    0.434548] [<ffffffff80003386>] ret_from_fork+0xa/0x1c
> [    0.434618] ---[ end trace 0000000000000000 ]---
>
> [1]: https://lore.kernel.org/20230913135943.3137292-1-houtao@huaweicloud.com/
> [2]: https://github.com/ClangBuiltLinux/boot-utils/releases
>
> Cheers,
> Nathan
>
> # bad: [98897dc735cf6635f0966f76eb0108354168fb15] Add linux-next specific files for 20230914
> # good: [aed8aee11130a954356200afa3f1b8753e8a9482] Merge tag 'pmdomain-v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
> git bisect start '98897dc735cf6635f0966f76eb0108354168fb15' 'aed8aee11130a954356200afa3f1b8753e8a9482'
> # good: [ea1bbd78a48c8b325583e8c0bc2690850cb51807] bcachefs: Fix assorted checkpatch nits
> git bisect good ea1bbd78a48c8b325583e8c0bc2690850cb51807
> # bad: [9c4e2139cfa15d769eafd51bf3e051293b106986] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> git bisect bad 9c4e2139cfa15d769eafd51bf3e051293b106986
> # bad: [4f07b13481ab390108b015da2bc8f560416e48d2] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> git bisect bad 4f07b13481ab390108b015da2bc8f560416e48d2
> # bad: [bcfe98207530e1ea0004f4e5dbd6e7e4d9eb2471] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
> git bisect bad bcfe98207530e1ea0004f4e5dbd6e7e4d9eb2471
> # bad: [95d3e99b1ca8ad3da86c525cc1c00e4ba27592ac] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
> git bisect bad 95d3e99b1ca8ad3da86c525cc1c00e4ba27592ac
> # good: [6836d373943afeeeb8e2989c22aaaa51218a83c6] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
> git bisect good 6836d373943afeeeb8e2989c22aaaa51218a83c6
> # good: [3d3e2fb5e45a08a45ae01f0dfaf9621ae0e439f9] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> git bisect good 3d3e2fb5e45a08a45ae01f0dfaf9621ae0e439f9
> # bad: [51d56d51d3881addaea2c7242ae859155ae75607] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
> git bisect bad 51d56d51d3881addaea2c7242ae859155ae75607
> # bad: [1a49f4195d3498fe458a7f5ff7ec5385da70d92e] bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
> git bisect bad 1a49f4195d3498fe458a7f5ff7ec5385da70d92e
> # bad: [c930472552022bd09aab3cd946ba3f243070d5c7] bpf: Ensure unit_size is matched with slab cache object size
> git bisect bad c930472552022bd09aab3cd946ba3f243070d5c7
> # good: [7182e56411b9a8b76797ed7b6095fc84be76dfb0] selftests/bpf: Add kprobe_multi override test
> git bisect good 7182e56411b9a8b76797ed7b6095fc84be76dfb0
> # good: [b1d53958b69312e43c118d4093d8f93d3f6f80af] bpf: Don't prefill for unused bpf_mem_cache
> git bisect good b1d53958b69312e43c118d4093d8f93d3f6f80af
> # first bad commit: [c930472552022bd09aab3cd946ba3f243070d5c7] bpf: Ensure unit_size is matched with slab cache object size


--------------BC8A68EEC62CF9401B3FB1EA
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Check-the-return-value-of-dma_get_cache_alignmen.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-bpf-Check-the-return-value-of-dma_get_cache_alignmen.pa";
 filename*1="tch"

RnJvbSAzNjlmMmU1OWNjNmM2M2MzOTI0ZjY1NGJhM2Y4NDkxZGJhNThiODdiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIb3UgVGFvIDxob3V0YW8xQGh1YXdlaS5jb20+CkRh
dGU6IFNhdCwgMTYgU2VwIDIwMjMgMTA6MzU6NTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBi
cGY6IENoZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgZG1hX2dldF9jYWNoZV9hbGlnbm1lbnQo
KQoKU2lnbmVkLW9mZi1ieTogSG91IFRhbyA8aG91dGFvMUBodWF3ZWkuY29tPgotLS0KIGtl
cm5lbC9icGYvbWVtYWxsb2MuYyB8IDEzICsrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9tZW1hbGxvYy5j
IGIva2VybmVsL2JwZi9tZW1hbGxvYy5jCmluZGV4IDFjMjJiOTBlNzU0YS4uYzhkMmMzMDk3
YzQzIDEwMDY0NAotLS0gYS9rZXJuZWwvYnBmL21lbWFsbG9jLmMKKysrIGIva2VybmVsL2Jw
Zi9tZW1hbGxvYy5jCkBAIC02LDYgKzYsOCBAQAogI2luY2x1ZGUgPGxpbnV4L2lycV93b3Jr
Lmg+CiAjaW5jbHVkZSA8bGludXgvYnBmX21lbV9hbGxvYy5oPgogI2luY2x1ZGUgPGxpbnV4
L21lbWNvbnRyb2wuaD4KKyNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgorI2luY2x1
ZGUgPGxpbnV4L3N3aW90bGIuaD4KICNpbmNsdWRlIDxhc20vbG9jYWwuaD4KIAogLyogQW55
IGNvbnRleHQgKGluY2x1ZGluZyBOTUkpIEJQRiBzcGVjaWZpYyBtZW1vcnkgYWxsb2NhdG9y
LgpAQCAtOTU4LDYgKzk2MCwxNCBAQCB2b2lkIG5vdHJhY2UgKmJwZl9tZW1fY2FjaGVfYWxs
b2NfZmxhZ3Moc3RydWN0IGJwZl9tZW1fYWxsb2MgKm1hLCBnZnBfdCBmbGFncykKIAlyZXR1
cm4gIXJldCA/IE5VTEwgOiByZXQgKyBMTElTVF9OT0RFX1NaOwogfQogCitzdGF0aWMgdW5z
aWduZWQgaW50IF9fa21hbGxvY19taW5hbGlnbih2b2lkKQoreworCWlmIChJU19FTkFCTEVE
KENPTkZJR19ETUFfQk9VTkNFX1VOQUxJR05FRF9LTUFMTE9DKSAmJgorCSAgICBpc19zd2lv
dGxiX2FsbG9jYXRlZCgpKQorCQlyZXR1cm4gQVJDSF9LTUFMTE9DX01JTkFMSUdOOworCXJl
dHVybiBkbWFfZ2V0X2NhY2hlX2FsaWdubWVudCgpOworfQorCiAvKiBNb3N0IG9mIHRoZSBs
b2dpYyBpcyB0YWtlbiBmcm9tIHNldHVwX2ttYWxsb2NfY2FjaGVfaW5kZXhfdGFibGUoKSAq
Lwogc3RhdGljIF9faW5pdCBpbnQgYnBmX21lbV9jYWNoZV9hZGp1c3Rfc2l6ZSh2b2lkKQog
ewpAQCAtOTkyLDYgKzEwMDIsOSBAQCBzdGF0aWMgX19pbml0IGludCBicGZfbWVtX2NhY2hl
X2FkanVzdF9zaXplKHZvaWQpCiAJCQlzaXplX2luZGV4WyhzaXplIC0gMSkgLyA4XSA9IGlu
ZGV4OwogCX0KIAorCXByX2luZm8oIj09PT0gYnBmX21lbV9jYWNoZTogS01BTExPQ19NSU5f
U0laRSAldSBBUkNIX0tNQUxMT0NfTUlOQUxJR04gJXUgbWluX2FsaWduICV1XG4iLAorCQlL
TUFMTE9DX01JTl9TSVpFLCBBUkNIX0tNQUxMT0NfTUlOQUxJR04sIF9fa21hbGxvY19taW5h
bGlnbigpKTsKKwogCXJldHVybiAwOwogfQogc3Vic3lzX2luaXRjYWxsKGJwZl9tZW1fY2Fj
aGVfYWRqdXN0X3NpemUpOwotLSAKMi4yOS4yCgo=
--------------BC8A68EEC62CF9401B3FB1EA--


