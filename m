Return-Path: <bpf+bounces-64986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A4B19F1B
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00D73BDAD1
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D32459FE;
	Mon,  4 Aug 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsiXLQIJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98623C8C7;
	Mon,  4 Aug 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301502; cv=none; b=fp6DLGBkD9etUfyZ1VaY0ZDGBZ5DI6Y/JlQftUfO7c5O6ceF+WlNBH7eaKVf8c/+hKmwlwuVCgOoC5W7hZHmI8WcU/XgZN5rx9bKkYBycS80DPv1y5x/TpWIrE9x6JpqLmWtlu1dWV25bwrqT0i5tP4OkcDRCzZxzSYNRQkjmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301502; c=relaxed/simple;
	bh=kUYQOYR8dh/UoKUnw0E24TPo6+iffC0MXNyqhVOjEfM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2PObBxnJ4fJ07zmIfjFbHTUNDOc1/D4AKBOiZ9UrgnloL07q+3F257tj5TXoPHGe2A96TLMcDqoc+zo3kDWPkKu7N63kBIltFE2ZZWBi1E4NyX+CAXy9slEl5dOfZ3d+Boup9Ys075Xm0OcRNoX66YC56+ik7pGtkVHZNpDrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsiXLQIJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so9268555a12.0;
        Mon, 04 Aug 2025 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754301498; x=1754906298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Tr8e+hsd8h1T2kog2UG0sY/rx+VLRnDE1612Udpcys=;
        b=EsiXLQIJ8AfFh8Lf1mXKcWgTwa7XvPwn6wpRoL5ZHU5Es0fcm+b1UgvcvRUu/Nc1+V
         yXM1pwU4Kyds2XSlO0L9gMRPs7iEpsUOT7vLg19QVDj93YdyO32Ea3TfhVZW8g2tuEpL
         Q0/QFK+1xOmnaCCtPyzxwwyov3rAyOoQ3TC4OooAqumsYSk0w+KuQif0jPClX0e8oZO7
         dAcnd0gj4kbIYmxwK/vR0m1U7q73XOjTFCJeSRcvdsalabJ6S8bEuWteYM69YRMd5P17
         n1qwJyy6QLxq1SNTWWETSlHQkQMo8DRJXDyhaRosI7GghnrsVISX5+lVb8jVb35P2uEq
         4HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754301498; x=1754906298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tr8e+hsd8h1T2kog2UG0sY/rx+VLRnDE1612Udpcys=;
        b=Ks7RJ3NFzdtkKwrm+DfPlXRd+/apLWx5WYPcoA6uf8Ac32PCXpRJM4cHfXnYNrys7s
         yfNL465m4npqNmcTVMpk0dFc8StkpiN6xWtrq+ljN7LQqm3febBdsT7+35HZ3XqEz58X
         xXMYqQRln32/sPlujsWGho0Kcv6WUkylZohQ2FdsjpTa7haAUlWEUcBU/UMUpNCApGoG
         rnFokQcegoAkrD1+jcbyLoAeTiBYJ27IJG1MpCG7MEA7GmA2mbnKbjnw0Mc294CxsqYX
         NrO2x0xNFWfGeHrIoH6RtNdm+7mvPRl0xqeRTOrz/fwcZpohDPpb4U6h6zUdLKl+Ctm1
         JTdg==
X-Forwarded-Encrypted: i=1; AJvYcCXdWw/Gxn8bpV/SCad1Ao5qGtatsy2wuaB/hWYnt+kvOBWjM8YHHfX/oUe26v+px0LB6bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzph2uVZR5+Jhd6h6eOB8ufS6cU75X2gfiNvNPX840sS5hYKRh6
	Bh2mxSqqTXtCNWNXDCv8oTDMRuNc0z7cYGGv7SH9kHgynUJogxEI0uPj6Pq2nh36
X-Gm-Gg: ASbGnctwlhK+FW8U245zG3DWv3acXPAbKVgGqHdej8u7bzos/7R8tN2960WeXdOF/nN
	ZRnrtBuFNZntMB7buLS0Qux97YIhOJxCzwDiQyQsaQFwEq9qJ+M81mYc49sz7rrKDX4tSvIooY/
	xfDzKhTTB4JmKGqr2/mjIbKPd1a1RoPWwqUU629DGRb/l9VnbcshQB/Dzq3M147Ys3pTuVkpe+K
	OL6TaHmxFJZ4FsGGZB5h7BY5u0pvCg2bMisFKGSTJubRrRXwIeMYffeGvrRdy0/HYFMipsD21P3
	ywPNlfwXIsHQKduAGWa6LMZ4SzoZnkemvPDkPgl03KTW1NPUX85Ms3WEn5tqHq9hkzAYOnwuELo
	Q5vZenqLc
X-Google-Smtp-Source: AGHT+IH3bZbk/enzyPqacVG4XWtUUE0EIqip+49gzXx3ZNomPEWb3qYxEIIN3/PxNi1pVgOI8C2wNQ==
X-Received: by 2002:a05:6402:5210:b0:615:705:274e with SMTP id 4fb4d7f45d1cf-615e5dbc49dmr8209483a12.4.1754301497585;
        Mon, 04 Aug 2025 02:58:17 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe79a0sm6644195a12.39.2025.08.04.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:58:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Aug 2025 11:58:15 +0200
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@fb.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	ebpf@linuxfoundation.org
Subject: Re: [PATCH v3 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
Message-ID: <aJCEN3AD1dt8nlcz@krava>
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-1-29569e086c12@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-1-29569e086c12@bootlin.com>

On Mon, Jul 07, 2025 at 04:02:03PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
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
> Changes in v3:
> - remove unneeded class__find_holes (already done by
>   class__infer_packed_attributes)
> - add uncertain parm loc in saved_functions_combine

lgtm, no change in functions on my setup

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> Changes in v2:
> - do not deny any struct passed by value, only those passed on stack AND
>   with some attribute alteration
> - use the existing class__infer_packed_attributes to deduce is a struct
>   is "altered". As a consequence, move the function filtering from
>   parameter__new to btf_encoder__encode_cu, to make sure that all the
>   needed data has been parsed from debug info
> ---
>  btf_encoder.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  dwarves.h     |  1 +
>  2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0bc23349b5d740c3ddab8208b2e15cdbdd139b9d..3f040fe03d7a208aa742914513bacde9782aabcf 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -87,6 +87,7 @@ struct btf_encoder_func_state {
>  	uint8_t optimized_parms:1;
>  	uint8_t unexpected_reg:1;
>  	uint8_t inconsistent_proto:1;
> +	uint8_t uncertain_parm_loc:1;
>  	int ret_type_id;
>  	struct btf_encoder_func_parm *parms;
>  	struct btf_encoder_func_annot *annots;
> @@ -1203,6 +1204,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  	state->inconsistent_proto = ftype->inconsistent_proto;
>  	state->unexpected_reg = ftype->unexpected_reg;
>  	state->optimized_parms = ftype->optimized_parms;
> +	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>  	ftype__for_each_parameter(ftype, param) {
>  		const char *name = parameter__name(param) ?: "";
>  
> @@ -1365,7 +1367,7 @@ static int saved_functions_cmp(const void *_a, const void *_b)
>  
>  static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>  {
> -	uint8_t optimized, unexpected, inconsistent;
> +	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc;
>  	int ret;
>  
>  	ret = strncmp(a->elf->name, b->elf->name,
> @@ -1375,11 +1377,13 @@ static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_
>  	optimized = a->optimized_parms | b->optimized_parms;
>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
> +	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
>  	if (!unexpected && !inconsistent && !funcs__match(a, b))
>  		inconsistent = 1;
>  	a->optimized_parms = b->optimized_parms = optimized;
>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
> +	a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;
>  
>  	return 0;
>  }
> @@ -1430,9 +1434,15 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  		/* do not exclude functions with optimized-out parameters; they
>  		 * may still be _called_ with the right parameter values, they
>  		 * just do not _use_ them.  Only exclude functions with
> -		 * unexpected register use or multiple inconsistent prototypes.
> +		 * unexpected register use, multiple inconsistent prototypes or
> +		 * uncertain parameters location
>  		 */
> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc;
> +
> +		if (state->uncertain_parm_loc)
> +			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
> +					"uncertain parameter location\n",
> +					0, 0);
>  
>  		if (add_to_btf) {
>  			err = btf_encoder__add_func(state->encoder, state);
> @@ -2553,6 +2563,38 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	free(encoder);
>  }
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
> +		class__infer_packed_attributes(class, cu);
> +
> +		if (class->is_packed)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
>  {
>  	struct llvm_annotation *annot;
> @@ -2647,6 +2689,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  		 * Skip functions that:
>  		 *   - are marked as declarations
>  		 *   - do not have full argument names
> +		 *   - have arguments with uncertain locations, e.g packed
> +		 *   structs passed by value on stack
>  		 *   - are not in ftrace list (if it's available)
>  		 *   - are not external (in case ftrace filter is not available)
>  		 */
> @@ -2693,6 +2737,9 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  		if (!func)
>  			continue;
>  
> +		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
> +			fn->proto.uncertain_parm_loc = 1;
> +
>  		err = btf_encoder__save_func(encoder, fn, func);
>  		if (err)
>  			goto out;
> diff --git a/dwarves.h b/dwarves.h
> index 36c689847ebf29a1ab9936f9d0f928dd46514547..d689aee5910f4b40dc13b3e9dc596dfbe6a2c3d0 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1021,6 +1021,7 @@ struct ftype {
>  	uint8_t		 unexpected_reg:1;
>  	uint8_t		 processed:1;
>  	uint8_t		 inconsistent_proto:1;
> +	uint8_t		 uncertain_parm_loc:1;
>  	struct list_head template_type_params;
>  	struct list_head template_value_params;
>  	struct template_parameter_pack *template_parameter_pack;
> 
> -- 
> 2.50.0
> 
> 

