Return-Path: <bpf+bounces-67514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4052CB449DF
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EA0561199
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15A2EDD6C;
	Thu,  4 Sep 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik/rasQW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603C2749C4
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025762; cv=none; b=EjcHI5U0LxZKvGEbnkrALcjThCGh7bfpZcw3a/1zBtYtt57Txg7aYECpD0CqCLjXUytcNkpbolBdw/mcha8Om3RGolCTsYP6W4/JsETDDYy9aLe0sRBOBebj4koUngcQ+SLnrWyutlfJr2dNvBQSo/DsxRJSaaopn1mk7H9ekIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025762; c=relaxed/simple;
	bh=B1W2Z1p5XZpOY8y94+EYl5/wEEkHq4/hJSBkXwZ1eFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKogIwYIUYvOJ3yAum0JPqhC/Uyak4wjWVsWZjH8kNJzr+BfzuL/Pvux/S4gvPjlBjN42bsOOIAfEf74wQakH9mAh8LSwYNAiDiKlVpMhIcqCiqrJk0WlZE+Giy3WKUsbcPS6AmQbrGiZ6tFvFBIg07rTS98l/g8a9xei9l5Vmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik/rasQW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7722bcb989aso1163321b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757025760; x=1757630560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7stybUMWipO5YZxvvicGiMS8w2Tz02CtPeQiBqJzrfg=;
        b=ik/rasQWoixSvi4a7sOOoeJvVn4pOePSD8SGl8Xnwr9jvD46YAK1h8gPkQbbvRTPtd
         W9Ws0XB9XcNB6GufaCnxfbsVkdCQ89lJMMZpc6BOwTlCMW8k3zftDK6mxVDIuOxkVJtX
         21z9LL77EL0QXndycz+5a1+QjGRvDQLFTf0aWOyUqb5JmNclgccNsvAtXg5l9kA5QiCb
         C0wXChhHZE1creL+3uw7IyRUZMlGlK1iqXsdrxIxC9jVotZifRjSg3UTvRyZezjXp+Sm
         dP+ZCiE7VK4R03p23TO5VK29+iKWftlL5bhL8eLdGp0p+awXYawLWqPobrz5v2ZoBFiA
         wYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025760; x=1757630560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7stybUMWipO5YZxvvicGiMS8w2Tz02CtPeQiBqJzrfg=;
        b=uoYEGeu09+i18mUxkXDJJLy0xiGYx4zyPqe9C7CtUhUupeMdR4yqjx0q0yLYJOtqcj
         7Z57ShlOjE0+XgBC7E3fCoIQVpTTqpAKRCgvxLWYOL8tal7zGIfymSgG1ea+4R2eKYZh
         YLr7k9FQ5EqutDb3Tapsn+BOapDYh2zgKhK//L7ujLe18n4fXiMpBqLA7lehuXAlTnSl
         dw0nd8CnBVobxOJM2NTr/PC/YQXxF7X05Dpt+X4DsXO1ldNuZyr0HnrziiA/rCb3AMTF
         Xm5hR8PQhFpV7z73xT3Xznb005vUQT8g8PUbv/Kmd74006/coPxdlZcyoN03Vx5hlTwn
         7R8g==
X-Gm-Message-State: AOJu0YxyQH8X8HhAOii31u64aVLyO0RtDbHl/yItpgIHbulCQ99toEji
	MqtNQzaKpVoPoJz5hzqGkIAQe0ODa1d8UfIKNuTlsycbAvOxbIhHFCO5
X-Gm-Gg: ASbGnct4ocVsikqpyAbqs/6VIhfQXXFBgUl8rII6t0BpogT6QA/at+NBArZcHrwJ/US
	RGS4yBXYJo7reLQySlfhfh72Q9h8Kd+//xm7ZH/CN/hXGdT62vi+RD65ftk7kxFj37IHULs/ROt
	k29WJzaopzl+RkewezH2HS6wuhNzRv6cT44Wsbd0Cti2EQ38sXW73Dq7EalZqnaAhL5hmntQgIO
	iB1hn3im4jMQsvz15S0IIGZjsxlvnj6/2KDPQABBWxrj7Xc5TPSq86yDVbpmunJe/PSTTT9Nu1Z
	ZcRrt0lySLZCKJI/ryYeRNZfiYPzyy5kdzbm5xXvjrvf34uZcOeBuOaP/xw0ss146BDNXRYxvwD
	4MYNv0nktx1oSN/IxEFc4pKHMqWpdSHtvic+yV4Fwy23w8j1yTHnneJmTNgshNyllRPmwdQ3i9I
	e6naLYfibh
X-Google-Smtp-Source: AGHT+IHaGhQFBh5KvECXojrlO5oM4f210/DrGBke61FWUGGCk6SouPwLYBbDYbh1r6mgA4iOB0psbw==
X-Received: by 2002:a05:6a00:1495:b0:771:ebf1:5e45 with SMTP id d2e1a72fcca58-7723e393f29mr24193241b3a.22.1757025760425;
        Thu, 04 Sep 2025 15:42:40 -0700 (PDT)
Received: from [192.168.1.77] (c-76-146-12-100.hsd1.wa.comcast.net. [76.146.12.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm20362170b3a.30.2025.09.04.15.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:42:40 -0700 (PDT)
Message-ID: <5829abcf-f1b9-4fb0-8811-b6098fdd8a29@gmail.com>
Date: Thu, 4 Sep 2025 15:42:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] riscv, bpf: Sign extend struct ops return
 values properly
To: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20250904103806.18937-1-hengqi.chen@gmail.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20250904103806.18937-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/25 3:38 AM, Hengqi Chen wrote:
> The ns_bpf_qdisc selftest triggers a kernel panic:
>
>      Unable to handle kernel paging request at virtual address ffffffffa38dbf58
>      Current test_progs pgtable: 4K pagesize, 57-bit VAs, pgdp=0x00000001109cc000
>      [ffffffffa38dbf58] pgd=000000011fffd801, p4d=000000011fffd401, pud=000000011fffd001, pmd=0000000000000000
>      Oops [#1]
>      Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1 dm_mod drm drm_panel_orientation_quirks configfs backlight btrfs blake2b_generic xor lzo_compress zlib_deflate raid6_pq efivarfs [last unloaded: bpf_testmod(OE)]
>      CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W  OE       6.17.0-rc1-g2465bb83e0b4 #1 NONE
>      Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>      Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2024.01+dfsg-1ubuntu5.1 01/01/2024
>      epc : __qdisc_run+0x82/0x6f0
>       ra : __qdisc_run+0x6e/0x6f0
>      epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb550
>       gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f180
>       t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5d0
>       s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 0000000000000001
>       a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 0000000000000000
>       a5 : 0000000000000010 a6 : 0000000000000000 a7 : 0000000000735049
>       s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda000
>       s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6f0
>       s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 0000000000000000
>       s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff0000
>       t5 : 0000000000000000 t6 : ff60000093a6a8b6
>      status: 0000000200000120 badaddr: ffffffffa38dbf58 cause: 000000000000000d
>      [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
>      [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
>      [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
>      [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
>      [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
>      [<ffffffff80d31446>] ip6_output+0x5e/0x178
>      [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
>      [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
>      [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
>      [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
>      [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
>      [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
>      [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
>      [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
>      [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
>      [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
>      [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
>      [<ffffffff80e69af2>] handle_exception+0x14a/0x156
>      Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 0709
>      ---[ end trace 0000000000000000 ]---
>
> The bpf_fifo_dequeue prog returns a skb which is a pointer.
> The pointer is treated as a 32bit value and sign extend to
> 64bit in epilogue. This behavior is right for most bpf prog
> types but wrong for struct ops which requires RISC-V ABI.
>
> So let's sign extend struct ops return values according to
> the function model and RISC-V ABI([0]).
>
>    [0]: https://riscv.org/wp-content/uploads/2024/12/riscv-calling.pdf
>
> Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 38 ++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 549c3063c7f1..c7ae4d0a8361 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -954,6 +954,35 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
>   	return ret;
>   }
>   
> +/*
> + * Sign-extend the register if necessary
> + */
> +static int sign_extend(int rd, int rs, u8 size, u8 flags, struct rv_jit_context *ctx)
> +{
> +	if (!(flags & BTF_FMODEL_SIGNED_ARG) && (size == 1 || size == 2))
> +		return 0;
> +
> +	switch (size) {
> +	case 1:
> +		emit_sextb(rd, rs, ctx);
> +		break;
> +	case 2:
> +		emit_sexth(rd, rs, ctx);
> +		break;
> +	case 4:
> +		emit_sextw(rd, rs, ctx);
> +		break;
> +	case 8:
> +		emit_mv(rd, rs, ctx);
> +		break;
> +	default:
> +		pr_err("bpf-jit: invalid size %d for sign_extend\n", size);
> +		return -EINVAL;

Will this accidentally rejects struct_ops functions that return void?

> +	}
> +
> +	return 0;
> +}
> +
>   static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   					 const struct btf_func_model *m,
>   					 struct bpf_tramp_links *tlinks,
> @@ -1175,8 +1204,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
>   
>   	if (save_ret) {
> -		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>   		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
> +		if (is_struct_ops) {
> +			ret = sign_extend(RV_REG_A0, regmap[BPF_REG_0],
> +					  m->ret_size, m->ret_flags, ctx);
> +			if (ret)
> +				goto out;
> +		} else {
> +			emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
> +		}
>   	}
>   
>   	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);


