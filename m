Return-Path: <bpf+bounces-67108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0390B3E4BA
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8627A8D93
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C6326D63;
	Mon,  1 Sep 2025 13:23:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165031DD9A
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733019; cv=none; b=owHLfnkm9xYGYLmEh/bpzhMy7X225qh7zV7vJ0bMkLSyNnV0QVm/y6B6XetNUVn0OwGay/5e7LRFq49GqcEIIvNCW4bytkosGwEqgLkIT9pnZqwcaEvbUxh/G9d9mxtYAnB+ILsh1v29vPnIzKAefnN5jbYNXj8syVYZVcJNI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733019; c=relaxed/simple;
	bh=ExGhHAnYVznkoY82qSMX9UzJRnNZjxsc2TNt4ZJ8X3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=puat/MvXBDiGl2Hsd5fdXUxhQcnKGvbDaMXdge34qKdGi3aatqya9xelHaSzL+yJyhFpb4MjH6APsVoCEhcWkSfOT3PMqWnr7X7qt7u5k6SzJIx/eb/PIo7v/fXeiowy6qzvyR2CoBbhWb7zs2leyLtUH/RTAoabwVqlU6nrmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cFqG11Bb0zdch2;
	Mon,  1 Sep 2025 21:19:05 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 981FD180495;
	Mon,  1 Sep 2025 21:23:33 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 21:23:32 +0800
Message-ID: <b1789304-715b-4fe4-8c82-3da9849ad3d2@huawei.com>
Date: Mon, 1 Sep 2025 21:23:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Sign extend struct ops return values properly
Content-Language: en-US
To: Hengqi Chen <hengqi.chen@gmail.com>
CC: <bjorn@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <puranjay@kernel.org>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20250827120344.6796-1-hengqi.chen@gmail.com>
 <d90361c5-75c6-4337-a590-0d81c61adfb9@huawei.com>
 <1be38ff5-ea37-4d5d-9f33-16799d2fe2c5@huawei.com>
 <CAEyhmHTz-ZXSg63AQhU4_Pk9CnTs2CQgGdH=LjWbFOqHOva9=Q@mail.gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CAEyhmHTz-ZXSg63AQhU4_Pk9CnTs2CQgGdH=LjWbFOqHOva9=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/9/1 17:14, Hengqi Chen wrote:
> On Mon, Sep 1, 2025 at 4:06 PM Pu Lehui <pulehui@huawei.com> wrote:
>>
>>
>>
>> On 2025/8/28 9:53, Pu Lehui wrote:
>>>
>>> On 2025/8/27 20:03, Hengqi Chen wrote:
>>>> The ns_bpf_qdisc selftest triggers a kernel panic:
>>>>
>>>>       Unable to handle kernel paging request at virtual address
>>>> ffffffffa38dbf58
>>>>       Current test_progs pgtable: 4K pagesize, 57-bit VAs,
>>>> pgdp=0x00000001109cc000
>>>>       [ffffffffa38dbf58] pgd=000000011fffd801, p4d=000000011fffd401,
>>>> pud=000000011fffd001, pmd=0000000000000000
>>>>       Oops [#1]
>>>>       Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1
>>>> dm_mod drm drm_panel_orientation_quirks configfs backlight btrfs
>>>> blake2b_generic xor lzo_compress zlib_deflate raid6_pq efivarfs [last
>>>> unloaded: bpf_testmod(OE)]
>>>>       CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W
>>>> OE       6.17.0-rc1-g2465bb83e0b4 #1 NONE
>>>>       Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>>       Hardware name: Unknown Unknown Product/Unknown Product, BIOS
>>>> 2024.01+dfsg-1ubuntu5.1 01/01/2024
>>>>       epc : __qdisc_run+0x82/0x6f0
>>>>        ra : __qdisc_run+0x6e/0x6f0
>>>>       epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb550
>>>>        gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f180
>>>>        t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5d0
>>>>        s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 0000000000000001
>>>>        a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 0000000000000000
>>>>        a5 : 0000000000000010 a6 : 0000000000000000 a7 : 0000000000735049
>>>>        s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda000
>>>>        s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6f0
>>>>        s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 0000000000000000
>>>>        s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff0000
>>>>        t5 : 0000000000000000 t6 : ff60000093a6a8b6
>>>>       status: 0000000200000120 badaddr: ffffffffa38dbf58 cause:
>>>> 000000000000000d
>>>>       [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
>>>>       [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
>>>>       [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
>>>>       [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
>>>>       [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
>>>>       [<ffffffff80d31446>] ip6_output+0x5e/0x178
>>>>       [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
>>>>       [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
>>>>       [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
>>>>       [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
>>>>       [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
>>>>       [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
>>>>       [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
>>>>       [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
>>>>       [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
>>>>       [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
>>>>       [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
>>>>       [<ffffffff80e69af2>] handle_exception+0x14a/0x156
>>>>       Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 0709
>>>>       ---[ end trace 0000000000000000 ]---
>>>>
>>>> The bpf_fifo_dequeue prog returns a skb which is a pointer.
>>>> The pointer is treated as a 32bit value and sign extend to
>>>> 64bit in epilogue. This behavior is right for most bpf prog
>>>> types but wrong for struct ops which requires RISC-V ABI.
>>>
>>> Hi Hengqi,
>>>
>>> Nice catch!
>>>
>>> Actually, I think commit 7112cd26e606c7ba51f9cc5c1905f06039f6f379 looks
>>> a little bit wired and related to this issue. I guess I need some time
>>> to recall this commit.
>>
>> Hi Hengqi,
>>
>> Sorry for late due to busy work. After some backtracking, I dismissed my
>> doubts about commit 7112cd26e606.
>>
>>>
>>> Thanks.
>>>
>>>>
>>>> So let's sign extend struct ops return values according to
>>>> the return value spec in function model.
>>>>
>>>> Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized
>>>> riscv ftrace framework")
>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>> ---
>>>>    arch/riscv/net/bpf_jit_comp64.c | 33 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c
>>>> b/arch/riscv/net/bpf_jit_comp64.c
>>>> index 549c3063c7f1..11ca56320a3f 100644
>>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>>> @@ -954,6 +954,33 @@ static int invoke_bpf_prog(struct bpf_tramp_link
>>>> *l, int args_off, int retval_of
>>>>        return ret;
>>>>    }
>>>> +/*
>>>> + * Sign-extend the register if necessary
>>>> + */ >>>> +static int sign_extend(struct rv_jit_context *ctx, int r, u8 size)

put `ctx` as last param would be more aligned with other function.

>>>> +{
>>>> +    switch (size) {
>>>> +    case 1:
>>>> +        emit_slli(r, r, 56, ctx);
>>>> +        emit_srai(r, r, 56, ctx); >>>> +        break;
>>>> +    case 2:
>>>> +        emit_slli(r, r, 48, ctx);
>>>> +        emit_srai(r, r, 48, ctx) >>>> +        break;
>>>> +    case 4:
>>>> +        emit_addiw(r, r, 0, ctx);

pls use emit_sextb/h/w() helper

>>>> +        break;
>>>> +    case 8:
>>>> +        break;
>>>> +    default:
>>>> +        pr_err("bpf-jit: invalid size %d for sign_extend\n", size);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>
>> We don't need to sign-ext when return value is 1 or 2 bytes. As for 4
> 
> Could you please elaborate more on this ?

Indeed, you pointed out my misunderstanding. According to riscv calling 
convention [0], for signed char and short, we need to do sign extension, 
but no need to do the same for unsigned. So for 1 or 2 bytes, we only 
need to do that for the signed.

Link: https://riscv.org/wp-content/uploads/2024/12/riscv-calling.pdf [0]

> IIUC, addiw on 1 byte / 2 byte values is equivalent to zext them.
> 
>> bytes, we have already do that in __build_epilogue. So we only need to
>> take care of 8 bytes return value. And the real fix would be:
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c
>> b/arch/riscv/net/bpf_jit_comp64.c
>> index 2f7188e0340a..08cc641f8b7c 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1177,6 +1177,9 @@ static int __arch_prepare_bpf_trampoline(struct
>> bpf_tramp_image *im,
>>           if (save_ret) {
>>                   emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>>                   emit_ld(regmap[BPF_REG_0], -(retval_off - 8),
>> RV_REG_FP, ctx);
>> +               /* Do not truncate return value when it's 8 bytes */
>> +               if (is_struct_ops && m->ret_size == 8)
>> +                       emit_mv(RV_REG_A0, regmap[BPF_REG_0], ctx);
>>           }
>>
>>           emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>>
>>>> +
>>>>    static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>>>                         const struct btf_func_model *m,
>>>>                         struct bpf_tramp_links *tlinks,
>>>> @@ -1177,6 +1204,12 @@ static int __arch_prepare_bpf_trampoline(struct
>>>> bpf_tramp_image *im,
>>>>        if (save_ret) {
>>>>            emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>>>>            emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
>>>> +        if (is_struct_ops) {
>>>> +            emit_mv(RV_REG_A0, regmap[BPF_REG_0], ctx);

This could be omit by combining with the sign_extend insn like 
`sextb(rd, rs, ctx)`.

>>>> +            ret = sign_extend(ctx, RV_REG_A0, m->ret_size);
>>>> +            if (ret)
>>>> +                goto out;
>>>> +        }
>>>>        }
>>>>        emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);

