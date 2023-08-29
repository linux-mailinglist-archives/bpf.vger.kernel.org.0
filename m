Return-Path: <bpf+bounces-8907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6378C38E
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E751C209E8
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A986D154BD;
	Tue, 29 Aug 2023 11:46:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2814F7B
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 11:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F97C433C7;
	Tue, 29 Aug 2023 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693309563;
	bh=KwHjdUAuTeDZHnYA1ERvFNqlNPp1iPTc04bBHrpxbHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pGJh7ok9RoxFeMcOaGa+LhHfqfof/+a55fzkWk/Upr6XLdgwJDiHQZ3k/mKfUT0sO
	 b91s8dCAqbTxwqnBvEybic/P9OhZJydUVWgmi54EJ6V/Cr6X93tZT4PnTHKGIl3xHq
	 1Gn4jdKMjJOXhdNT3p8bB24/ZmF9OuIw1BAJpkpPJkmXU5N0Y2O0W6liI6QpluQDfi
	 WEAykT7Ic+R/XgtJqUo3tv5cGQFAsMDoultVOMdfLDpuxAb70oOND261Ae3i10sgXn
	 p1oJA+dF7hZQgs+xD2wXtiLk3ox8O3D6qlL5k+Zudn5bnvWWf6ffmTZajKkHJ3n8c9
	 d+amQs7bySsww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, yonghong.song@linux.dev,
 bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
In-Reply-To: <87a5uaz4uh.fsf@all.your.base.are.belong.to.us>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
 <200dcce6-34ff-83e0-02fb-709a24403cc6@huaweicloud.com>
 <87zg2e88ds.fsf@all.your.base.are.belong.to.us>
 <64873e42-9be1-1812-b80d-5ea86b4677f0@huaweicloud.com>
 <87sf8684ex.fsf@all.your.base.are.belong.to.us>
 <878r9wswwy.fsf@all.your.base.are.belong.to.us>
 <fd07e0a3-f4da-b447-c47a-6e933220d452@linux.dev>
 <65c9e8d9-7682-2c8d-cd4d-9f0ca1213066@huaweicloud.com>
 <87a5uaz4uh.fsf@all.your.base.are.belong.to.us>
Date: Tue, 29 Aug 2023 13:46:00 +0200
Message-ID: <87r0nmjclj.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Hou Tao <houtao@huaweicloud.com> writes:
>
>> Hi,
>>
>> On 8/27/2023 10:53 PM, Yonghong Song wrote:
>>>
>>>
>>> On 8/27/23 1:37 AM, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>>>
>>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 8/26/2023 5:23 PM, Bj=C3=B6rn T=C3=B6pel wrote:
>>>>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 8/25/2023 11:28 PM, Yonghong Song wrote:
>>>>>>>>>
>>>>>>>>> On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
>>>>>>>>>> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
>>>>>>>>>> selftests on bpf-next 9e3b47abeb8f.
>>>>>>>>>>
>>>>>>>>>> I'm able to reproduce the hang by multiple runs of:
>>>>>>>>>> =C2=A0=C2=A0 | ./test_progs -a link_api -a linked_list
>>>>>>>>>> I'm currently investigating that.
>>>>>>>>>>
>>>>>>>>>> But! Sometimes (every blue moon) I get a warn_on_once hit:
>>>>>>>>>> =C2=A0=C2=A0 | ------------[ cut here ]------------
>>>>>>>>>> =C2=A0=C2=A0 | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c=
:342
>>>>>>>>>> bpf_mem_refill+0x1fc/0x206
>>>>>>>>>> =C2=A0=C2=A0 | Modules linked in: bpf_testmod(OE)
>>>>>>>>>> =C2=A0=C2=A0 | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE
>>>>>>>>>> N 6.5.0-rc5-01743-gdcb152bb8328 #2
>>>>>>>>>> =C2=A0=C2=A0 | Hardware name: riscv-virtio,qemu (DT)
>>>>>>>>>> =C2=A0=C2=A0 | epc : bpf_mem_refill+0x1fc/0x206
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 ra : irq_work_single+0x68/0x70
>>>>>>>>>> =C2=A0=C2=A0 | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp :
>>>>>>>>>> ff2000000001be20
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 gp : ffffffff82d26138 tp : ff6000008477a800=
 t0 :
>>>>>>>>>> 0000000000046600
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 t1 : ffffffff812b6ddc t2 : 0000000000000000=
 s0 :
>>>>>>>>>> ff2000000001be70
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998=
 a1 :
>>>>>>>>>> ff600003fef4b000
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 a2 : 000000000000003f a3 : ffffffff80008250=
 a4 :
>>>>>>>>>> 0000000000000060
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 a5 : 0000000000000080 a6 : 0000000000000000=
 a7 :
>>>>>>>>>> 0000000000735049
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 s2 : ff5ffffffffe8998 s3 : 0000000000000022=
 s4 :
>>>>>>>>>> 0000000000001000
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 s5 : 0000000000000007 s6 : ff5ffffffffe8570=
 s7 :
>>>>>>>>>> ffffffff82d6bd30
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 s8 : 000000000000003f s9 : ffffffff82d2c5e8=
 s10:
>>>>>>>>>> 000000000000ffff
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28=
 t4 :
>>>>>>>>>> 0000000000000000
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0 t5 : ff6000008fd28278 t6 : 0000000000040000
>>>>>>>>>> =C2=A0=C2=A0 | status: 0000000200000100 badaddr: 000000000000000=
0 cause:
>>>>>>>>>> 0000000000000003
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4=
/0x1f8
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8009fafa>] generic_handle_domain_irq+0x=
28/0x36
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff8009fafa>] generic_handle_domain_irq+0x=
28/0x36
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
>>>>>>>>>> =C2=A0=C2=A0 | [<ffffffff812b6904>] do_irq+0x66/0x98
>>>>>>>>>> =C2=A0=C2=A0 | ---[ end trace 0000000000000000 ]---
>>>>>>>>>>
>>>>>>>>>> Code:
>>>>>>>>>> =C2=A0=C2=A0 | static void free_bulk(struct bpf_mem_cache *c)
>>>>>>>>>> =C2=A0=C2=A0 | {
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_mem_cache *tgt=
 =3D c->tgt;
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 struct llist_node *llnode=
, *t;
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 int cnt;
>>>>>>>>>> =C2=A0=C2=A0 |
>>>>>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(tgt->unit_si=
ze !=3D c->unit_size);
>>>>>>>>>> =C2=A0=C2=A0 | ...
>>>>>>>>>>
>>>>>>>>>> I'm not well versed in the memory allocator; Before I dive into
>>>>>>>>>> it --
>>>>>>>>>> has anyone else hit it? Ideas on why the warn_on_once is hit?
>>>>>>>>> Maybe take a look at the patch
>>>>>>>>> =C2=A0=C2=A0 822fb26bdb55=C2=A0 bpf: Add a hint to allocated obje=
cts.
>>>>>>>>>
>>>>>>>>> In the above patch, we have
>>>>>>>>>
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Remember bpf_mem_ca=
che that allocated this object.
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The hint is not acc=
urate.
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c->tgt =3D *(struct bpf_mem=
_cache **)llnode;
>>>>>>>>>
>>>>>>>>> I suspect that the warning may be related to the above.
>>>>>>>>> I tried the above ./test_progs command line (running multiple
>>>>>>>>> at the same time) and didn't trigger the issue.
>>>>>>>> The extra 8-bytes before the freed pointer is used to save the
>>>>>>>> pointer
>>>>>>>> of the original bpf memory allocator where the freed pointer came
>>>>>>>> from,
>>>>>>>> so unit_free() could free the pointer back to the original
>>>>>>>> allocator to
>>>>>>>> prevent alloc-and-free unbalance.
>>>>>>>>
>>>>>>>> I suspect that a wrong pointer was passed to bpf_obj_drop, but do
>>>>>>>> not
>>>>>>>> find anything suspicious after checking linked_list. Another
>>>>>>>> possibility
>>>>>>>> is that there is write-after-free problem which corrupts the extra
>>>>>>>> 8-bytes before the freed pointer. Could you please apply the
>>>>>>>> following
>>>>>>>> debug patch to check whether or not the extra 8-bytes are
>>>>>>>> corrupted ?
>>>>>>> Thanks for getting back!
>>>>>>>
>>>>>>> I took your patch for a run, and there's a hit:
>>>>>>> =C2=A0=C2=A0 | bad cache ff5ffffffffe8570: got size 96 work
>>>>>>> ffffffff801b19c8, cache ff5ffffffffe8980 exp size 128 work
>>>>>>> ffffffff801b19c8
>>>>>>
>>>>>> The extra 8-bytes are not corrupted. Both of these two
>>>>>> bpf_mem_cache are
>>>>>> valid and there are in the cache array defined in bpf_mem_caches. BPF
>>>>>> memory allocator allocated the pointer from 96-bytes sized-cache,
>>>>>> but it
>>>>>> tried to free the pointer through 128-bytes sized-cache.
>>>>>>
>>>>>> Now I suspect there is no 96-bytes slab in your system and ksize(ptr=
 -
>>>>>> LLIST_NODE_SZ) returns 128, so bpf memory allocator selected the
>>>>>> 128-byte sized-cache instead of 96-bytes sized-cache. Could you plea=
se
>>>>>> check the value of KMALLOC_MIN_SIZE in your kernel .config and
>>>>>> using the
>>>>>> following command to check whether there is 96-bytes slab in your
>>>>>> system:
>>>>>
>>>>> KMALLOC_MIN_SIZE is 64.
>>>>>
>>>>>> $ cat /proc/slabinfo |grep kmalloc-96
>>>>>> dma-kmalloc-96=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 96=C2=A0=C2=A0 42=C2=
=A0=C2=A0=C2=A0 1 : tunables=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
>>>>>> 0 : slabdata=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>> kmalloc-96=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 186=
5=C2=A0=C2=A0 2268=C2=A0=C2=A0=C2=A0=C2=A0 96=C2=A0=C2=A0 42=C2=A0=C2=A0=C2=
=A0 1 : tunables=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
>>>>>> 0 : slabdata=C2=A0=C2=A0=C2=A0=C2=A0 54=C2=A0=C2=A0=C2=A0=C2=A0 54=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>
>>>>>> In my system, slab has 96-bytes cached, so grep outputs something,
>>>>>> but I
>>>>>> think there will no output in your system.
>>>>>
>>>>> You're right! No kmalloc-96.
>>>>
>>>> To get rid of the warning, limit available sizes from
>>>> bpf_mem_alloc_init()?
>>
>> It is not enough. We need to adjust size_index accordingly during
>> initialization. Could you please try the attached patch below ? It is
>> not a formal patch and I am considering to disable prefilling for these
>> redirected bpf_mem_caches.
>
> Sorry for the slow response; I'll take it for a spin today.

Hmm, on a related note, RISC-V has this change queued up [1], which will
introduce -96 and friends. Are there any other archs supporting the BPF
allocator where this is a concern? If not, I suggest simply leaving the
code as is.


Bj=C3=B6rn

[1] https://lore.kernel.org/all/20230718152214.2907-1-jszhang@kernel.org/

