Return-Path: <bpf+bounces-44964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31229CF0BC
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B581F2B2F0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE131D5CFD;
	Fri, 15 Nov 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8bulmpX"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9391D5AC0
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685992; cv=none; b=ZPIJgyM68O5C8eldqne6aaLO9qODdYtu1mFu/i1tRxg4z+Y8p/j4SghUBBb8elkHlYtNoSO4G6lpgy4EYnwZ/o54to6AOdQYpn0FS7Rv2n1Xp+8QUYS+wQCmYGQ/KlX5BJ/jpUvI5v6DKTGLdSKrkljqO5esCXwzPPlEm7qOSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685992; c=relaxed/simple;
	bh=DBHsNfndIOfMj4KlvXF4Absd1pi5QeJGJAb4et1eznY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDpnonFeEksOXgtkLEixGkzK90z77N8gd0hnR8PWHmaPNnPltiqtQq789W68A+0Eu7RWHm/kUqzwwsiAYZArZ57Wpsjn3te0k2X7Lx+FgkqXoaRHkWd81j4sbYMmSIsudOV5LOcnqj33teazXtNpH6pQi3tfLmloOXLUXUFmQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8bulmpX; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31fd2d8d-0a3f-4924-9f56-3a861e6df04d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731685981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxP8IGTASP4487uUkTUVDIh27bGLwKTpbboeO12itW0=;
	b=m8bulmpXFDLTFb/u5ZnoT0I2a4zf3Yqcu4QPzi45gunleS+7MCmpATpw7yuZOJYNSXyJL+
	QkmUgM0D/k8MFq+6mtMFOIN4hygWwPEa55hg7nn2nQ2eneqhfxJSGGebIcyv5Jz34pc1Kj
	VspblwhPg2FW8ET2HYlDI3wpofpWz6M=
Date: Fri, 15 Nov 2024 07:52:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 dwarves 1/2] dwarf_loader: Check
 DW_OP_[GNU_]entry_value for possible parameter matching
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com
References: <20241115113605.1504796-1-alan.maguire@oracle.com>
 <20241115113605.1504796-2-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241115113605.1504796-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/15/24 3:36 AM, Alan Maguire wrote:
> From: Eduard Zingerman <eddyz87@gmail.com>
>
> Song Liu reported that a kernel func (perf_event_read()) cannot be traced
> in certain situations since the func is not in vmlinux bTF. This happens
> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
>
> The perf_event_read() signature in kernel (kernel/events/core.c):
>     static int perf_event_read(struct perf_event *event, bool group)
>
> Adding '-V' to pahole command line, and the following error msg can be found:
>     skipping addition of 'perf_event_read'(perf_event_read) due to unexpected register used for parameter
>
> Eventually the error message is attributed to the setting
> (parm->unexpected_reg = 1) in parameter__new() function.
>
> The following is the dwarf representation for perf_event_read():
>      0x0334c034:   DW_TAG_subprogram
>                  DW_AT_low_pc    (0xffffffff812c6110)
>                  DW_AT_high_pc   (0xffffffff812c640a)
>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>                  DW_AT_GNU_all_call_sites        (true)
>                  DW_AT_name      ("perf_event_read")
>                  DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>                  DW_AT_decl_line (4641)
>                  DW_AT_prototyped        (true)
>                  DW_AT_type      (0x03324f6a "int")
>      0x0334c04e:     DW_TAG_formal_parameter
>                    DW_AT_location        (0x007de9fd:
>                       [0xffffffff812c6115, 0xffffffff812c6141): DW_OP_reg5 RDI
>                       [0xffffffff812c6141, 0xffffffff812c6323): DW_OP_reg14 R14
>                       [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                       [0xffffffff812c63fe, 0xffffffff812c6405): DW_OP_reg14 R14
>                       [0xffffffff812c6405, 0xffffffff812c640a): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                    DW_AT_name    ("event")
>                    DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>                    DW_AT_decl_line       (4641)
>                    DW_AT_type    (0x0333aac2 "perf_event *")
>      0x0334c05e:     DW_TAG_formal_parameter
>                    DW_AT_location        (0x007dea82:
>                       [0xffffffff812c6137, 0xffffffff812c63f2): DW_OP_reg12 R12
>                       [0xffffffff812c63f2, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                       [0xffffffff812c63fe, 0xffffffff812c640a): DW_OP_reg12 R12)
>                    DW_AT_name    ("group")
>                    DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>                    DW_AT_decl_line       (4641)
>                    DW_AT_type    (0x03327059 "bool")
>
> By inspecting the binary, the second argument ("bool group") is used
> in the function. The following are the disasm code:
>      ffffffff812c6110 <perf_event_read>:
>      ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>      ffffffff812c6115: 55                    pushq   %rbp
>      ffffffff812c6116: 41 57                 pushq   %r15
>      ffffffff812c6118: 41 56                 pushq   %r14
>      ffffffff812c611a: 41 55                 pushq   %r13
>      ffffffff812c611c: 41 54                 pushq   %r12
>      ffffffff812c611e: 53                    pushq   %rbx
>      ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>      ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>      <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>      ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>      ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40, %rax
>      ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>      ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>      ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>      ffffffff812c613f: 75 3f                 jne     0xffffffff812c6180 <perf_event_read+0x70>
>      ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:(%rax,%rax)
>      ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>      ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>      ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>      ffffffff812c615a: e8 c1 a0 d7 00        callq   0xffffffff82040220 <_raw_spin_lock_irqsave>
>      ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>      ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>      ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>      ffffffff812c616b: 0f 84 9a 00 00 00     je      0xffffffff812c620b <perf_event_read+0xfb>
>      ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>      ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>      <=========== NOTE: %rsi is overwritten
>      ......
>      ffffffff812c63f0: 41 5c                 popq    %r12
>      <============ POP r12
>      ffffffff812c63f2: 41 5d                 popq    %r13
>      ffffffff812c63f4: 41 5e                 popq    %r14
>      ffffffff812c63f6: 41 5f                 popq    %r15
>      ffffffff812c63f8: 5d                    popq    %rbp
>      ffffffff812c63f9: e9 e2 a8 d7 00        jmp     0xffffffff82040ce0 <__x86_return_thunk>
>      ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>      ffffffff812c6400: e9 be fe ff ff        jmp     0xffffffff812c62c3 <perf_event_read+0x1b3>
>
> It is not clear why dwarf didn't encode %rsi in locations. But
> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
> the entry of perf_event_read(). So this patch tries to search
> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
> the expected parameter register matches the register in
> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
> is not optimized.
>
> For one of internal 6.11 kernel, there are 62498 functions in BTF and
> perf_event_read() is not there. With this patch, there are 62552 functions
> in BTF and perf_event_read() is included.
>
> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   dwarf_loader.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 83 insertions(+), 23 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ec8641b..4789967 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1157,16 +1157,90 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
>   	return pack;
>   }
>   
> +/* Returns number of locations found or negative value for errors. */
> +static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
> +				      ptrdiff_t offset, Dwarf_Addr *basep,
> +				      Dwarf_Addr *startp, Dwarf_Addr *endp,
> +				      Dwarf_Op **expr, size_t *exprlen)
> +{
> +	int ret;
> +
> +#if _ELFUTILS_PREREQ(0, 157)
> +	ret = dwarf_getlocations(attr, offset, basep, startp, endp, expr, exprlen);
> +#else
> +	if (offset == 0) {
> +		ret = dwarf_getlocation(attr, expr, exprlen);
> +		if (ret == 0)
> +			ret = 1;
> +	}
> +#endif
> +	return ret;
> +}
> +
> +/* For DW_AT_location 'attr':
> + * - if first location is DW_OP_regXX with expected number, return the register;
> + *   otherwise save the register for later return
> + * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is in the
> + *   list, return the register; otherwise save register for later return
> + * - otherwise if no register was found for locations, return -1.
> + */
> +static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
> +{
> +	Dwarf_Addr base, start, end;
> +	Dwarf_Op *expr, *entry_ops;
> +	Dwarf_Attribute entry_attr;
> +	size_t exprlen, entry_len;
> +	ptrdiff_t offset = 0;
> +	int loc_num = -1;
> +	int ret = -1;
> +
> +	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
> +		loc_num++;
> +
> +		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
> +		 * DW_OP_stack_value instructs interpreter to pop current value from
> +		 * DWARF expression evaluation stack, and thus is not important here.
> +		 */
> +		if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
> +			exprlen--;
> +
> +		if (exprlen != 1)
> +			continue;
> +
> +		switch (expr->atom) {
> +		/* match DW_OP_regXX at first location */
> +		case DW_OP_reg0 ... DW_OP_reg31:
> +			if (loc_num != 0)
> +				break;
> +			ret = expr->atom;
> +			if (ret == expected_reg)
> +				goto out;
> +			break;
> +		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
> +		case DW_OP_entry_value:
> +		case DW_OP_GNU_entry_value:
> +			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
> +			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
> +			    entry_len == 1) {
> +				ret = entry_ops->atom;
> +				if (ret == expected_reg)
> +					goto out;
> +			}

For the above if statement, let us do

			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
			    entry_len == 1 && expected_reg == entry_ops->atom) {
				ret = entry_ops->atom;
				goto out;
			}

This has been discussed in comments of v2:
   https://lore.kernel.org/bpf/Zzdh_4Z-e8nl50L6@krava/T/#md3940ef06ee2b2f4bbaf2d1c8dc916f5783330b5


> +			break;
> +		}
> +	}
> +out:
> +	return ret;
> +}
> +
>   static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>   					struct conf_load *conf, int param_idx)
>   {
>   	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>   
>   	if (parm != NULL) {
> -		Dwarf_Addr base, start, end;
>   		bool has_const_value;
>   		Dwarf_Attribute attr;
> -		struct location loc;
>   
>   		tag__init(&parm->tag, cu, die);
>   		parm->name = attr_string(die, DW_AT_name, conf);
> @@ -1208,35 +1282,21 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>   		 */
>   		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
>   		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
> -		/* dwarf_getlocations() handles location lists; here we are
> -		 * only interested in the first expr.
> -		 */
> -		if (parm->has_loc &&
> -#if _ELFUTILS_PREREQ(0, 157)
> -		    dwarf_getlocations(&attr, 0, &base, &start, &end,
> -				       &loc.expr, &loc.exprlen) > 0 &&
> -#else
> -		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) == 0 &&
> -#endif
> -			loc.exprlen != 0) {
> +
> +		if (parm->has_loc) {
>   			int expected_reg = cu->register_params[param_idx];
> -			Dwarf_Op *expr = loc.expr;
> +			int actual_reg = parameter__reg(&attr, expected_reg);
>   
> -			switch (expr->atom) {
> -			case DW_OP_reg0 ... DW_OP_reg31:
> +			if (actual_reg < 0)
> +				parm->optimized = 1;
> +			else if (expected_reg >= 0 && expected_reg != actual_reg)
>   				/* mark parameters that use an unexpected
>   				 * register to hold a parameter; these will
>   				 * be problematic for users of BTF as they
>   				 * violate expectations about register
>   				 * contents.
>   				 */
> -				if (expected_reg >= 0 && expected_reg != expr->atom)
> -					parm->unexpected_reg = 1;
> -				break;
> -			default:
> -				parm->optimized = 1;
> -				break;
> -			}
> +				parm->unexpected_reg = 1;
>   		} else if (has_const_value) {
>   			parm->optimized = 1;
>   		}


