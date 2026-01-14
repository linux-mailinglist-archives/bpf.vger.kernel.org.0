Return-Path: <bpf+bounces-78932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0FD20249
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 200913059E95
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC7244679;
	Wed, 14 Jan 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q1n2kqM2"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553736B045
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407372; cv=none; b=ts0HBmNr6tTSRMeF+IeZyvSsdCqUeOMAvLUEWXKbpeNlPq/ZDCEHJ5SafdZQHuNAgkNQ31/tH1eNlhll03vO79ui86jRhRd2SDNsLKaDOEeGSA0ulgmEIrpQOid4MmEvmGeOlXPwQZnUWFNEFAADg82wn25c1pfXZhr7KrPmDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407372; c=relaxed/simple;
	bh=qZCJFjr7yyhiGL5QufBQGxYkjQMqlOIrWFGSvnlodyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tomQphTk9X1FV2Lxnh3tDOwyXwmrLsIQ1z0o2Xf9MY+1PVX9X06OXBW7aQxXo4sySI+un2RObXBfN7slJyfnRC/uGuJDGyXvGzLlh7ThJvrMpMTvJRG3p7PyWI7rzgJ/lskNytT0kaP/9/hoeNK/RwaR41Kr2Gk3EStKZrJ2/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q1n2kqM2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79fac2fa-b5f8-4a7e-aafb-5b80d596db34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768407358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfIYQ+xprC85leRHg4rZRK2tgTgg0MknBkPJBLIVybY=;
	b=q1n2kqM2r/s5cvgHzVwLEt9aueuqRepeJelHQZ0NzrVgULCkq1XlVuGVJ3txpd30nVAywU
	/ab+Y9MnxjI9lZYwVxJ6xTB8Gfei9PKhJwTG5Fv/kEHma3f+S8WMCKF97kB7Czkb2Lcr+j
	M38XQCLFS9Y4o669K77bfhGkSQx3vSE=
Date: Wed, 14 Jan 2026 08:15:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 3/4] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-4-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260113131352.2395024-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 5:13 AM, Alan Maguire wrote:
> Currently we collate function information by name and add functions
> provided there are no inconsistencies across various representations.
>
> For true_signature support - where we wish to add the real signature
> of a function even if it differs from source level - we need to do
> a few things:
>
> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>     we can do this via the address associated with the function.
>     In doing this, we can then be confident that the debug info
>     for foo.isra.0 is the right info for the function at that
>     address.
>
> 2. When adding saved functions we need to look for such cases
>     and provided they do not violate other constraints around BTF
>     representation - unexpected reg usage for function, uncertain
>     parameter location or ambiguous address - we add them with
>     their "."-suffixed name.  The latter can be used as a signal
>     that the function is transformed from the original.
>
> Doing this adds 500 functions to BTF.  These are traceable with
> their "."-suffix names and because we have excluded ambiguous
> address cases we know exactly which function address they refer
> to.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   btf_encoder.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
>   dwarves.h     |  1 +
>   pahole.c      |  1 +
>   3 files changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5bc61cb..01fd469 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>   	int16_t component_idx;
>   };
>   
> +struct elf_function_sym {
> +	const char *name;
> +	uint64_t addr;
> +};
> +
>   /* state used to do later encoding of saved functions */
>   struct btf_encoder_func_state {
>   	struct elf_function *elf;
> +	struct elf_function_sym *sym;
> +	uint64_t addr;
>   	uint32_t type_id_off;
>   	uint16_t nr_parms;
>   	uint16_t nr_annots;
> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>   	struct btf_encoder_func_annot *annots;
>   };
>   
> -struct elf_function_sym {
> -	const char *name;
> -	uint64_t addr;
> -};
> -
>   struct elf_function {
>   	char		*name;
>   	struct elf_function_sym *syms;
> @@ -145,7 +147,8 @@ struct btf_encoder {
>   			  skip_encoding_decl_tag,
>   			  tag_kfuncs,
>   			  gen_distilled_base,
> -			  encode_attributes;
> +			  encode_attributes,
> +			  true_signature;
>   	uint32_t	  array_index_id;
>   	struct elf_secinfo *secinfo;
>   	size_t             seccnt;
> @@ -1271,14 +1274,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>   			goto out;
>   		}
>   	}
> +	if (encoder->true_signature && fn->lexblock.ip.addr) {
> +		int i;
> +
> +		for (i = 0; i < func->sym_cnt; i++) {
> +			if (fn->lexblock.ip.addr != func->syms[i].addr)
> +				continue;
> +			/* Only need to record address for '.'-suffixed
> +			 * functions, since we only currently need true
> +			 * signatures for them.
> +			 */
> +			if (!strchr(func->syms[i].name, '.'))
> +				continue;
> +			state->sym = &func->syms[i];
> +			break;
> +		}
> +	}
>   	state->inconsistent_proto = ftype->inconsistent_proto;
>   	state->unexpected_reg = ftype->unexpected_reg;
>   	state->optimized_parms = ftype->optimized_parms;
>   	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>   	state->reordered_parm = ftype->reordered_parm;
>   	ftype__for_each_parameter(ftype, param) {
> -		const char *name = parameter__name(param) ?: "";
> +		const char *name;
>   
> +		/* No location info + reordered means optimized out. */
> +		if (ftype->reordered_parm && !param->has_loc)
> +			continue;
> +		name = parameter__name(param) ?: "";
>   		str_off = btf__add_str(btf, name);
>   		if (str_off < 0) {
>   			err = str_off;
> @@ -1367,6 +1390,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>   
>   	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>   	name = func->name;
> +	if (encoder->true_signature && state->sym)
> +		name = state->sym->name;
> +
>   	if (btf_fnproto_id >= 0)
>   		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>   						      name, false);
> @@ -1509,6 +1535,38 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>   		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>   			j++;
>   
> +		/* Add true signatures for case where we have an exact
> +		 * symbol match by address from DWARF->ELF and have a
> +		 * "." suffixed name.
> +		 */
> +		if (encoder->true_signature) {
> +			int k;
> +
> +			for (k = i; k < nr_saved_fns; k++) {
> +				struct btf_encoder_func_state *true_state = &saved_fns[k];
> +
> +				if (state->elf != true_state->elf)
> +					break;
> +				if (!true_state->sym)
> +					continue;
> +				/* Unexpected reg, uncertain parm loc and
> +				 * ambiguous address mean we cannot trust fentry.
> +				 */
> +				if (true_state->unexpected_reg ||
> +				    true_state->uncertain_parm_loc ||
> +				    true_state->ambiguous_addr)
> +					continue;
> +				err = btf_encoder__add_func(encoder, true_state);
> +				if (err < 0)
> +					goto out;
> +				break;
> +			}
> +		}
> +
> +		/* True symbol that was handled above; skip. */
> +		if (state->sym)
> +			continue;
> +
>   		/* do not exclude functions with optimized-out parameters; they
>   		 * may still be _called_ with the right parameter values, they
>   		 * just do not _use_ them.  Only exclude functions with
> @@ -2585,6 +2643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>   		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>   		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>   		encoder->encode_attributes = conf_load->btf_attributes;
> +		encoder->true_signature = conf_load->true_signature;
>   		encoder->verbose	 = verbose;
>   		encoder->has_index_type  = false;
>   		encoder->need_index_type = false;
> diff --git a/dwarves.h b/dwarves.h
> index 78bedf5..d7c6474 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -101,6 +101,7 @@ struct conf_load {
>   	bool			btf_decl_tag_kfuncs;
>   	bool			btf_gen_distilled_base;
>   	bool			btf_attributes;
> +	bool			true_signature;
>   	uint8_t			hashtable_bits;
>   	uint8_t			max_hashtable_bits;
>   	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index ef01e58..02a0d19 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1234,6 +1234,7 @@ struct btf_feature {
>   	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>   	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>   				      attributes_check),
> +	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>   };
>   
>   #define BTF_MAX_FEATURE_STR	1024

Currently, in pahole, when checking whether signature has changed during
optimization or not, we only check parameters.

But compiler optimization may optimize away return value and such
information is not available in dwarf.

For example,

$ cat test.c
#include <stdio.h>
unsigned tar(int a);
__attribute__((noinline)) static int foo(int a, int b)
{
   return tar(a) + tar(a + 1);
}
__attribute__((noinline)) int bar(int a)
{
   foo(a, 1);
   return 0;
}

In this particular case, the return value of foo() is actually not used
and the compiler will optimize it away with returning void (at least
for llvm).

$ /opt/rh/gcc-toolset-15/root/usr/bin/gcc -O2 -g -c test.c
$ llvm-dwarfdump test.o
...
0x000000d9:   DW_TAG_subprogram
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadret/test.c")
                 DW_AT_decl_line (3)
                 DW_AT_decl_column       (38)
                 DW_AT_prototyped        (true)
                 DW_AT_type      (0x0000005d "int")
                 DW_AT_inline    (DW_INL_inlined)
                 DW_AT_sibling   (0x000000fb)
                                                                                                                     
0x000000ea:     DW_TAG_formal_parameter
                   DW_AT_name    ("a")
                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
                   DW_AT_decl_line       (3)
                   DW_AT_decl_column     (46)
                   DW_AT_type    (0x0000005d "int")
                                                                                                                     
0x000000f2:     DW_TAG_formal_parameter
                   DW_AT_name    ("b")
                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
                   DW_AT_decl_line       (3)
                   DW_AT_decl_column     (53)
                   DW_AT_type    (0x0000005d "int")

0x000000fa:     NULL

0x000000fb:   DW_TAG_subprogram
                 DW_AT_abstract_origin   (0x000000d9 "foo")
                 DW_AT_low_pc    (0x0000000000000000)
                 DW_AT_high_pc   (0x0000000000000011)
                 DW_AT_frame_base        (DW_OP_call_frame_cfa)
                 DW_AT_call_all_calls    (true)

0x00000112:     DW_TAG_formal_parameter
                   DW_AT_abstract_origin (0x000000ea "a")
                   DW_AT_location        (0x00000026:
                      [0x0000000000000000, 0x0000000000000007): DW_OP_reg5 RDI
                      [0x0000000000000007, 0x000000000000000c): DW_OP_reg3 RBX
                      [0x000000000000000c, 0x0000000000000010): DW_OP_breg5 RDI-1, DW_OP_stack_value
                      [0x0000000000000010, 0x0000000000000011): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                   DW_AT_GNU_locviews    (0x0000001e)

0x0000011f:     DW_TAG_formal_parameter
                   DW_AT_abstract_origin (0x000000f2 "b")
                   DW_AT_const_value     (0x01)
...

Assembly code:
0000000000000000 <foo.constprop.0.isra.0>:
        0: 53                            pushq   %rbx
        1: 89 fb                         movl    %edi, %ebx
        3: e8 00 00 00 00                callq   0x8 <foo.constprop.0.isra.0+0x8>
        8: 8d 7b 01                      leal    0x1(%rbx), %edi
        b: 5b                            popq    %rbx
        c: e9 00 00 00 00                jmp     0x11 <foo.constprop.0.isra.0+0x11>
       11: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
       1c: 0f 1f 40 00                   nopl    (%rax)

0000000000000020 <bar>:
       20: 48 83 ec 08                   subq    $0x8, %rsp
       24: e8 d7 ff ff ff                callq   0x0 <foo.constprop.0.isra.0>
       29: 31 c0                         xorl    %eax, %eax
       2b: 48 83 c4 08                   addq    $0x8, %rsp
       2f: c3                            retq

$ clang -O2 -g -c test.c
$ llvm-dwarfdump test.o
...
0x0000004e:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000010)
                 DW_AT_high_pc   (0x0000000000000022)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadret/test.c")
                 DW_AT_decl_line (3)
                 DW_AT_prototyped        (true)
                 DW_AT_calling_convention        (DW_CC_nocall)
                 DW_AT_type      (0x00000096 "int")

0x0000005e:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x1) loclist = 0x00000022:
                      [0x0000000000000010, 0x0000000000000018): DW_OP_reg5 RDI
                      [0x0000000000000018, 0x000000000000001a): DW_OP_reg3 RBX
                      [0x000000000000001a, 0x0000000000000022): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                   DW_AT_name    ("a")
                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
                   DW_AT_decl_line       (3)
                   DW_AT_type    (0x00000096 "int")

0x00000067:     DW_TAG_formal_parameter
                   DW_AT_name    ("b")
                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
                   DW_AT_decl_line       (3)
                   DW_AT_type    (0x00000096 "int")
...
Assembly code:
0000000000000000 <bar>:
        0: 50                            pushq   %rax
        1: e8 0a 00 00 00                callq   0x10 <foo>
        6: 31 c0                         xorl    %eax, %eax
        8: 59                            popq    %rcx
        9: c3                            retq
        a: 66 0f 1f 44 00 00             nopw    (%rax,%rax)

0000000000000010 <foo>:
       10: 53                            pushq   %rbx
       11: 89 fb                         movl    %edi, %ebx
       13: e8 00 00 00 00                callq   0x18 <foo+0x8>
       18: ff c3                         incl    %ebx
       1a: 89 df                         movl    %ebx, %edi
       1c: 5b                            popq    %rbx
       1d: e9 00 00 00 00                jmp     0x22 <foo+0x12>


The compiler knows whether the return type has changed or not.
Unfortunately the information is not available in dwarf. So
BTF will encode source level return type even if the actual
return type could be void due to optimization.

This is not perfect but at least it is an improvement
for true signature. But it would be great if llvm/gcc
side can coordinate to propose something in compiler/dwarf
to encode return type change as well. In llvm,
AFAIK, the only return type change will be
'original non-void type' -> 'void type'.


