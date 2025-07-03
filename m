Return-Path: <bpf+bounces-62318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E8AF7FAB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35A7163020
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B5A25A2C0;
	Thu,  3 Jul 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MfeZpb+A"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEF223715
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566678; cv=none; b=HT0IYTb30RmVwkmWU8q172ZzIUE+O7RrKxxLW6MAKCOEhl48SGs3ujw5Vz7Uysd2134evHkcViJtSIkHgb8CKTU6xxEljVfJiomV33mSCoG+7+gfuQmkKZflUS3hy3lvMq6QomZIsY3xkVEwl8MQ46UBSGX7oapr43BIQa9Pll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566678; c=relaxed/simple;
	bh=ldYKss+oN3iLOu22adLNUkny792ZWWGzAjOy1P4SzAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtcFM6N8H5U2BdBLYp7gNDkwKgR1gABXoUk9KbNzKZPdCblTbqUD5q+1dW5f2RmqsGfFnUf+DqvsdXEAVxMyYXdKaLikxmiVth6hPVwPYPISPHOA9I9RkwIoayA+lBhCrahjllbShZlvbjr4gkWddp2APxvcPj12IyHBLibu6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MfeZpb+A; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8923cd39-a242-4f61-b99e-b5fe5678ee84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751566673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzYOX+cRCf4jSg8iA91rzOOhCH3MjcvLbUiv4tW4608=;
	b=MfeZpb+AAyhv5KmLt6ao3qdCjaQIPlkIvCw8sHjE22UsIjpwifwJtAYkhjuk9pbmVszcdA
	TJTHGY08drNXcPKGz7hLrV15D673FLv2v9ZyLmnMJ7JgTzH1m908DmYpcHYtb/D4mJ37Bs
	Gym9Iy0g+cyb/IokY+/IgT5YAMsFJ5M=
Date: Thu, 3 Jul 2025 11:17:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
 <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/3/25 2:02 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Most ABIs allow functions to receive structs passed by value, if they
> fit in a register or a pair of registers, depending on the exact ABI.
> However, when there is a struct passed by value but all registers are
> already used for parameters passing, the struct is still passed by value
> but on the stack. This becomes an issue if the passed struct is defined
> with some attributes like __attribute__((packed)) or
> __attribute__((aligned(X)), as its location on the stack is altered, but
> this change is not reflected in dwarf information. The corresponding BTF
> data generated from this can lead to incorrect BPF trampolines
> generation (eg to attach bpf tracing programs to kernel functions) in
> the Linux kernel.
> 
> Prevent those wrong cases by not encoding functions consuming structs
> passed by value on stack, when those structs do not have the expected
> alignment due to some attribute usage.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - do not deny any struct passed by value, only those passed on stack AND
>    with some attribute alteration
> - use the existing class__infer_packed_attributes to deduce is a struct
>    is "altered". As a consequence, move the function filtering from
>    parameter__new to btf_encoder__encode_cu, to make sure that all the
>    needed data has been parsed from debug info
> ---
>   btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   dwarves.h     |  1 +
>   2 files changed, 49 insertions(+), 2 deletions(-)
> 

Hi Alexis. A couple of comments below.


> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0bc23349b5d740c3ddab8208b2e15cdbdd139b9d..16739066caae808aea77175e6c221afbe37b7c70 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -87,6 +87,7 @@ struct btf_encoder_func_state {
>   	uint8_t optimized_parms:1;
>   	uint8_t unexpected_reg:1;
>   	uint8_t inconsistent_proto:1;
> +	uint8_t uncertain_parm_loc:1;
>   	int ret_type_id;
>   	struct btf_encoder_func_parm *parms;
>   	struct btf_encoder_func_annot *annots;
> @@ -1203,6 +1204,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>   	state->inconsistent_proto = ftype->inconsistent_proto;
>   	state->unexpected_reg = ftype->unexpected_reg;
>   	state->optimized_parms = ftype->optimized_parms;
> +	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>   	ftype__for_each_parameter(ftype, param) {
>   		const char *name = parameter__name(param) ?: "";
>   
> @@ -1430,9 +1432,15 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>   		/* do not exclude functions with optimized-out parameters; they
>   		 * may still be _called_ with the right parameter values, they
>   		 * just do not _use_ them.  Only exclude functions with
> -		 * unexpected register use or multiple inconsistent prototypes.
> +		 * unexpected register use, multiple inconsistent prototypes or
> +		 * uncertain parameters location
>   		 */
> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc;


Is it possible for a function to have uncertain_parm_loc in one CU,
but not in another?

If yes, we still don't want the function in BTF, right?

> +
> +		if (state->uncertain_parm_loc)
> +			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
> +					"uncertain parameter location\n",
> +					0, 0);
>   
>   		if (add_to_btf) {
>   			err = btf_encoder__add_func(state->encoder, state);
> @@ -2553,6 +2561,39 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>   	free(encoder);
>   }
>   
> +static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ftype)
> +{
> +	struct parameter *param;
> +	int param_idx = 0;
> +
> +	if (ftype->nr_parms < cu->nr_register_params)
> +		return false;
> +
> +	ftype__for_each_parameter(ftype, param) {
> +		if (param_idx++ < cu->nr_register_params)
> +			continue;
> +
> +		struct tag *type = cu__type(cu, param->tag.type);
> +
> +		if (type == NULL || !tag__is_struct(type))
> +			continue;
> +
> +		struct type *ctype = tag__type(type);
> +		if (ctype->namespace.name == 0)
> +			continue;
> +
> +		struct class *class = tag__class(type);
> +
> +		class__find_holes(class);
> +		class__infer_packed_attributes(class, cu);
> +
> +		if (class->is_packed)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
>   {
>   	struct llvm_annotation *annot;
> @@ -2647,6 +2688,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>   		 * Skip functions that:
>   		 *   - are marked as declarations
>   		 *   - do not have full argument names
> +		 *   - have arguments with uncertain locations, e.g packed
> +		 *   structs passed by value on stack
>   		 *   - are not in ftrace list (if it's available)
>   		 *   - are not external (in case ftrace filter is not available)
>   		 */
> @@ -2693,6 +2736,9 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>   		if (!func)
>   			continue;
>   
> +		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
> +			fn->proto.uncertain_parm_loc = 1;
> +
>   		err = btf_encoder__save_func(encoder, fn, func);

I think checking and setting uncertain_parm_loc flag should be done
inside btf_encoder__save_func(), because that's where we inspect DWARF
function prototype and add a new btf_encoder_func_state.

>   		if (err)
>   			goto out;
> diff --git a/dwarves.h b/dwarves.h
> index 36c689847ebf29a1ab9936f9d0f928dd46514547..d689aee5910f4b40dc13b3e9dc596dfbe6a2c3d0 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1021,6 +1021,7 @@ struct ftype {
>   	uint8_t		 unexpected_reg:1;
>   	uint8_t		 processed:1;
>   	uint8_t		 inconsistent_proto:1;
> +	uint8_t		 uncertain_parm_loc:1;
>   	struct list_head template_type_params;
>   	struct list_head template_value_params;
>   	struct template_parameter_pack *template_parameter_pack;
> 


