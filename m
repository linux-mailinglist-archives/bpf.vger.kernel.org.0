Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089268195D
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbjA3Sgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjA3Sgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:36:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE7359B
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:36:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A63A061212
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 18:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6455C433EF;
        Mon, 30 Jan 2023 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675103773;
        bh=suc+TLGbN7In8tofG6vymI8YY1qKQIggCTMQoFpU8oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIkxjoNofjY1YGR7/YjxWT4UW2RwlWSyKhqxB1uKvmdxUY5ZiE5HvKNRz0C9asFyf
         3PgOP7QfxqcSums5SNr006Q9ogT3vByYTtGYbOBqECoCG6+joLstyWqn58FhAzKPEw
         NbFR/nMkQH9yuyTYiISAONynk1EDHb6z1n9RmSvhjW8+4X/cnBNruspNnuCX4MRN1L
         8m/VEZ1Tiy1wamfW4CFS2N0tF9AMZwdJokVbvZoDCZZmNMvRR59Y1Dt47WBVdrd8oa
         qNjOF193VtlpfPK1gIK+lEACiQ5GG/Yae7/04FCIUa7PzRwcolAWBQHE4XedXJ0yVT
         ki3moLeRnVoAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F2AC405BE; Mon, 30 Jan 2023 15:36:09 -0300 (-03)
Date:   Mon, 30 Jan 2023 15:36:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9gOGZ20aSgsYtPP@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 02:29:41PM +0000, Alan Maguire escreveu:
> Compilation generates DWARF at several stages, and often the
> later DWARF representations more accurately represent optimizations
> that have occurred during compilation.
> 
> In particular, parameter representations can be spotted by their
> abstract origin references to the original parameter, but they
> often have more accurate location information.  In most cases,
> the parameter locations will match calling conventions, and be
> registers for the first 6 parameters on x86_64, first 8 on ARM64
> etc.  If the parameter is not a register when it should be however,
> it is likely passed via the stack or the compiler has used a
> constant representation instead.  The latter can often be
> spotted by checking for a DW_AT_const_value attribute,
> as noted by Eduard.
> 
> In addition, absence of a location tag (either across
> the abstract origin reference and the original parameter,
> or in the standalone parameter description) is evidence of
> an optimized-out parameter.  Presence of a location tag
> is stored in the parameter description and shared between
> abstract tags and their original referents.
> 
> This change adds a field to parameters and their associated
> ftype to note if a parameter has been optimized out.  Having
> this information allows us to skip such functions, as their
> presence in CUs makes BTF encoding impossible.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  dwarf_loader.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  dwarves.h      |   5 ++-
>  2 files changed, 122 insertions(+), 8 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 5a74035..93c2307 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -992,13 +992,98 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
>  	return member;
>  }
>  
> -static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> +/* How many function parameters are passed via registers?  Used below in
> + * determining if an argument has been optimized out or if it is simply
> + * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
> + * allows unsupported architectures to skip tagging optimized-out
> + * values.
> + */
> +#if defined(__x86_64__)
> +#define NR_REGISTER_PARAMS      6
> +#elif defined(__s390__)
> +#define NR_REGISTER_PARAMS	5
> +#elif defined(__aarch64__)
> +#define NR_REGISTER_PARAMS      8
> +#elif defined(__mips__)
> +#define NR_REGISTER_PARAMS	8
> +#elif defined(__powerpc__)
> +#define NR_REGISTER_PARAMS	8
> +#elif defined(__sparc__)
> +#define NR_REGISTER_PARAMS	6
> +#elif defined(__riscv) && __riscv_xlen == 64
> +#define NR_REGISTER_PARAMS	8
> +#elif defined(__arc__)
> +#define NR_REGISTER_PARAMS	8
> +#else
> +#define NR_REGISTER_PARAMS      0
> +#endif

This should be done as a function, something like:

int cu__nr_register_params(struct cu *cu)
{
	GElf_Ehdr ehdr;

	gelf_getehdr(cu->elf, &ehdr);

	switch (ehdr.machine) {
	...

}

I'm coding that now, will send the diff shortly.

This is to support cross-builds.

- Arnaldo

> +
> +static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> +					struct conf_load *conf, int param_idx)
>  {
>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>  
>  	if (parm != NULL) {
> +		bool has_const_value;
> +		Dwarf_Attribute attr;
> +		struct location loc;
> +
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
> +
> +		if (param_idx >= NR_REGISTER_PARAMS)
> +			return parm;
> +		/* Parameters which use DW_AT_abstract_origin to point at
> +		 * the original parameter definition (with no name in the DIE)
> +		 * are the result of later DWARF generation during compilation
> +		 * so often better take into account if arguments were
> +		 * optimized out.
> +		 *
> +		 * By checking that locations for parameters that are expected
> +		 * to be passed as registers are actually passed as registers,
> +		 * we can spot optimized-out parameters.
> +		 *
> +		 * It can also be the case that a parameter DIE has
> +		 * a constant value attribute reflecting optimization or
> +		 * has no location attribute.
> +		 *
> +		 * From the DWARF spec:
> +		 *
> +		 * "4.1.10
> +		 *
> +		 * A DW_AT_const_value attribute for an entry describing a
> +		 * variable or formal parameter whose value is constant and not
> +		 * represented by an object in the address space of the program,
> +		 * or an entry describing a named constant. (Note
> +		 * that such an entry does not have a location attribute.)"
> +		 *
> +		 * So we can also use the absence of a location for a parameter
> +		 * as evidence it has been optimized out.  This info will
> +		 * need to be shared between a parameter and any abstract
> +		 * origin references however, since gcc can have location
> +		 * information in the parameter that refers back to the original
> +		 * via abstract origin, so we need to share location presence
> +		 * between these parameter representations.  See
> +		 * ftype__recode_dwarf_types() below for how this is handled.
> +		 */
> +		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
> +		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
> +		if (parm->has_loc &&
> +		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
> +			loc.exprlen != 0) {
> +			Dwarf_Op *expr = loc.expr;
> +
> +			switch (expr->atom) {
> +			case DW_OP_reg1 ... DW_OP_reg31:
> +			case DW_OP_breg0 ... DW_OP_breg31:
> +				break;
> +			default:
> +				parm->optimized = 1;
> +				break;
> +			}
> +		} else if (has_const_value) {
> +			parm->optimized = 1;
> +		}
>  	}
>  
>  	return parm;
> @@ -1450,7 +1535,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>  					     struct cu *cu, struct conf_load *conf,
>  					     int param_idx)
>  {
> -	struct parameter *parm = parameter__new(die, cu, conf);
> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
>  
>  	if (parm == NULL)
>  		return NULL;
> @@ -2194,6 +2279,7 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>  
>  	ftype__for_each_parameter(type, pos) {
>  		struct dwarf_tag *dpos = pos->tag.priv;
> +		struct parameter *opos;
>  		struct dwarf_tag *dtype;
>  
>  		if (dpos->type.off == 0) {
> @@ -2207,8 +2293,18 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>  				tag__print_abstract_origin_not_found(&pos->tag);
>  				continue;
>  			}
> -			pos->name = tag__parameter(dtype->tag)->name;
> +			opos = tag__parameter(dtype->tag);
> +			pos->name = opos->name;
>  			pos->tag.type = dtype->tag->type;
> +			/* share location information between parameter and
> +			 * abstract origin; if neither have location, we will
> +			 * mark the parameter as optimized out.
> +			 */
> +			if (pos->has_loc)
> +				opos->has_loc = pos->has_loc;
> +
> +			if (pos->optimized)
> +				opos->optimized = pos->optimized;
>  			continue;
>  		}
>  
> @@ -2478,18 +2574,33 @@ out:
>  	return 0;
>  }
>  
> -static int cu__resolve_func_ret_types(struct cu *cu)
> +static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  {
>  	struct ptr_table *pt = &cu->functions_table;
>  	uint32_t i;
>  
>  	for (i = 0; i < pt->nr_entries; ++i) {
>  		struct tag *tag = pt->entries[i];
> +		struct parameter *pos;
> +		struct function *fn = tag__function(tag);
> +
> +		/* mark function as optimized if parameter is, or
> +		 * if parameter does not have a location; at this
> +		 * point location presence has been marked in
> +		 * abstract origins for cases where a parameter
> +		 * location is not stored in the original function
> +		 * parameter tag.
> +		 */
> +		ftype__for_each_parameter(&fn->proto, pos) {
> +			if (pos->optimized || !pos->has_loc) {
> +				fn->proto.optimized_parms = 1;
> +				break;
> +			}
> +		}
>  
>  		if (tag == NULL || tag->type != 0)
>  			continue;
>  
> -		struct function *fn = tag__function(tag);
>  		if (!fn->abstract_origin)
>  			continue;
>  
> @@ -2612,7 +2723,7 @@ static int die__process_and_recode(Dwarf_Die *die, struct cu *cu, struct conf_lo
>  	if (ret != 0)
>  		return ret;
>  
> -	return cu__resolve_func_ret_types(cu);
> +	return cu__resolve_func_ret_types_optimized(cu);
>  }
>  
>  static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
> @@ -3132,7 +3243,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  	 * encoded in another subprogram through abstract_origin
>  	 * tag. Let us visit all subprograms again to resolve this.
>  	 */
> -	if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
> +	if (cu__resolve_func_ret_types_optimized(cu) != LSK__KEEPIT)
>  		goto out_abort;
>  
>  	if (cus__finalize(cus, cu, conf, NULL) == LSK__STOP_LOADING)
> diff --git a/dwarves.h b/dwarves.h
> index 589588e..2723466 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -808,6 +808,8 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
>  struct parameter {
>  	struct tag tag;
>  	const char *name;
> +	uint8_t optimized:1;
> +	uint8_t has_loc:1;
>  };
>  
>  static inline struct parameter *tag__parameter(const struct tag *tag)
> @@ -827,7 +829,8 @@ struct ftype {
>  	struct tag	 tag;
>  	struct list_head parms;
>  	uint16_t	 nr_parms;
> -	uint8_t		 unspec_parms; /* just one bit is needed */
> +	uint8_t		 unspec_parms:1; /* just one bit is needed */
> +	uint8_t		 optimized_parms:1;
>  };
>  
>  static inline struct ftype *tag__ftype(const struct tag *tag)
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
