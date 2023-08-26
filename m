Return-Path: <bpf+bounces-8739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F10789516
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 11:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0088128198B
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093E20FF;
	Sat, 26 Aug 2023 09:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C041C29
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 09:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7DC433C8;
	Sat, 26 Aug 2023 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693041810;
	bh=g+MK6ntjqfeTXNc27P4FFjlVBfxOMy0i5Ikz6lsBGvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YzyVhng01dFTsjLrTQBbwUNPtrFI9hufeFEW6j5Zr5oZpb4PPpizL1ugeRNOJfL1X
	 lrqrRprW7u3pYAlnHdrsI9NU0i0LnO0AoWi88H+5mW39GUcA/+lCrsGkp9qVqyuRRl
	 YctoqCp7186y9kbJbbVPpE9HpxYPkDWC54kCLj2V6LMnB/voQ6WluHD4Fih3pJs65Y
	 SVg3Mw2DgKfM61YS4/FWWPdNxj2uMkQLVBvWw0F6iVeKqpFQlrPV5WUYrIGM4FN7Nb
	 Awl+Rqfit9TvgFqElYXygUGDVOCcPlG6ywqZIqOGJSnbZZQi/0OMPb7Eh+FoTxAYa9
	 wyRSfpxCjg1dQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, yonghong.song@linux.dev, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
In-Reply-To: <200dcce6-34ff-83e0-02fb-709a24403cc6@huaweicloud.com>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
 <200dcce6-34ff-83e0-02fb-709a24403cc6@huaweicloud.com>
Date: Sat, 26 Aug 2023 11:23:27 +0200
Message-ID: <87zg2e88ds.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> Hi,
>
> On 8/25/2023 11:28 PM, Yonghong Song wrote:
>>
>>
>> On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
>>> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
>>> selftests on bpf-next 9e3b47abeb8f.
>>>
>>> I'm able to reproduce the hang by multiple runs of:
>>> =C2=A0 | ./test_progs -a link_api -a linked_list
>>> I'm currently investigating that.
>>>
>>> But! Sometimes (every blue moon) I get a warn_on_once hit:
>>> =C2=A0 | ------------[ cut here ]------------
>>> =C2=A0 | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
>>> bpf_mem_refill+0x1fc/0x206
>>> =C2=A0 | Modules linked in: bpf_testmod(OE)
>>> =C2=A0 | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=A0=C2=A0
>>> N 6.5.0-rc5-01743-gdcb152bb8328 #2
>>> =C2=A0 | Hardware name: riscv-virtio,qemu (DT)
>>> =C2=A0 | epc : bpf_mem_refill+0x1fc/0x206
>>> =C2=A0 |=C2=A0 ra : irq_work_single+0x68/0x70
>>> =C2=A0 | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001=
be20
>>> =C2=A0 |=C2=A0 gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000=
000046600
>>> =C2=A0 |=C2=A0 t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff20000=
00001be70
>>> =C2=A0 |=C2=A0 s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff60000=
3fef4b000
>>> =C2=A0 |=C2=A0 a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000=
000000060
>>> =C2=A0 |=C2=A0 a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000=
000735049
>>> =C2=A0 |=C2=A0 s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000=
000001000
>>> =C2=A0 |=C2=A0 s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : fffffff=
f82d6bd30
>>> =C2=A0 |=C2=A0 s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 0000000=
00000ffff
>>> =C2=A0 |=C2=A0 s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000=
000000000
>>> =C2=A0 |=C2=A0 t5 : ff6000008fd28278 t6 : 0000000000040000
>>> =C2=A0 | status: 0000000200000100 badaddr: 0000000000000000 cause:
>>> 0000000000000003
>>> =C2=A0 | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
>>> =C2=A0 | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
>>> =C2=A0 | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
>>> =C2=A0 | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
>>> =C2=A0 | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
>>> =C2=A0 | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
>>> =C2=A0 | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>>> =C2=A0 | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
>>> =C2=A0 | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
>>> =C2=A0 | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>>> =C2=A0 | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
>>> =C2=A0 | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
>>> =C2=A0 | [<ffffffff812b6904>] do_irq+0x66/0x98
>>> =C2=A0 | ---[ end trace 0000000000000000 ]---
>>>
>>> Code:
>>> =C2=A0 | static void free_bulk(struct bpf_mem_cache *c)
>>> =C2=A0 | {
>>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_mem_cache *tgt =3D c->tgt;
>>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 struct llist_node *llnode, *t;
>>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 int cnt;
>>> =C2=A0 |
>>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(tgt->unit_size !=3D c->un=
it_size);
>>> =C2=A0 | ...
>>>
>>> I'm not well versed in the memory allocator; Before I dive into it --
>>> has anyone else hit it? Ideas on why the warn_on_once is hit?
>>
>> Maybe take a look at the patch
>> =C2=A0 822fb26bdb55=C2=A0 bpf: Add a hint to allocated objects.
>>
>> In the above patch, we have
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Remember bpf_mem_cache tha=
t allocated this object.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The hint is not accurate.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c->tgt =3D *(struct bpf_mem_cache =
**)llnode;
>>
>> I suspect that the warning may be related to the above.
>> I tried the above ./test_progs command line (running multiple
>> at the same time) and didn't trigger the issue.
>
> The extra 8-bytes before the freed pointer is used to save the pointer
> of the original bpf memory allocator where the freed pointer came from,
> so unit_free() could free the pointer back to the original allocator to
> prevent alloc-and-free unbalance.
>
> I suspect that a wrong pointer was passed to bpf_obj_drop, but do not
> find anything suspicious after checking linked_list. Another possibility
> is that there is write-after-free problem which corrupts the extra
> 8-bytes before the freed pointer. Could you please apply the following
> debug patch to check whether or not the extra 8-bytes are corrupted ?

Thanks for getting back!

I took your patch for a run, and there's a hit:
  | bad cache ff5ffffffffe8570: got size 96 work ffffffff801b19c8, cache ff=
5ffffffffe8980 exp size 128 work ffffffff801b19c8
  | WARNING: CPU: 3 PID: 265 at kernel/bpf/memalloc.c:847 bpf_mem_free+0xb2=
/0xe0
  | ---[ end trace 0000000000000000 ]---
  | 00000000: 80 e3 dc 85 00 00 60 ff 00 00 00 00 00 00 00 00
  | 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 00000020: 20 00 00 00 00 00 00 00 c8 19 1b 80 ff ff ff ff
  | 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 00000040: 60 00 00 00 33 00 00 00 20 00 00 00 60 00 00 00
  | 00000050: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 00000060: 70 85 fe ff ff ff 5f ff 00 00 00 00 00 00 00 00
  | 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  | WARNING: CPU: 2 PID: 265 at kernel/bpf/memalloc.c:342 bpf_mem_refill+0x=
1fc/0x206
  | ---[ end trace 0000000000000000 ]---


Bj=C3=B6rn

