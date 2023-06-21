Return-Path: <bpf+bounces-3038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1858A738933
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89BD280DF5
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500D19529;
	Wed, 21 Jun 2023 15:31:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17819523
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 15:31:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3001706;
	Wed, 21 Jun 2023 08:31:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79BE31063;
	Wed, 21 Jun 2023 08:31:55 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C415C3F64C;
	Wed, 21 Jun 2023 08:31:09 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:31:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
	bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Message-ID: <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
References: <20230619100121.27534-1-puranjay12@gmail.com>
 <20230619100121.27534-4-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619100121.27534-4-puranjay12@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 10:01:21AM +0000, Puranjay Mohan wrote:
> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer
> with bpf_jit_binary_pack_finalize.
> 
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> JIT as these functions are required by bpf_jit_binary_pack allocator.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

From a quick look, I don't beleive the I-cache maintenance is quite right --
explanation below.

> @@ -1562,34 +1610,39 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  
>  	/* 3. Extra pass to validate JITed code. */
>  	if (validate_ctx(&ctx)) {
> -		bpf_jit_binary_free(header);
>  		prog = orig_prog;
> -		goto out_off;
> +		goto out_free_hdr;
>  	}
>  
>  	/* And we're done. */
>  	if (bpf_jit_enable > 1)
>  		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
>  
> -	bpf_flush_icache(header, ctx.image + ctx.idx);
> +	bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);

I think this is too early; we haven't copied the instructions into the
ro_header yet, so that still contains stale instructions.

IIUC at the whole point of this is to pack multiple programs into shared ROX
pages, and so there can be an executable mapping of the RO page at this point,
and the CPU can fetch stale instructions throught that.

Note that *regardless* of whether there is an executeable mapping at this point
(and even if no executable mapping exists until after the copy), we at least
need a data cache clean to the PoU *after* the copy (so fetches don't get a
stale value from the PoU), and the I-cache maintenance has to happeon the VA
the instrutions will be executed from (or VIPT I-caches can still contain stale
instructions).

Thanks,
Mark.

>  
>  	if (!prog->is_func || extra_pass) {
>  		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
>  			pr_err_once("multi-func JIT bug %d != %d\n",
>  				    ctx.idx, jit_data->ctx.idx);
> -			bpf_jit_binary_free(header);
>  			prog->bpf_func = NULL;
>  			prog->jited = 0;
>  			prog->jited_len = 0;
> +			goto out_free_hdr;
> +		}
> +		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
> +							 header))) {
> +			/* ro_header has been freed */
> +			ro_header = NULL;
> +			prog = orig_prog;
>  			goto out_off;
>  		}
> -		bpf_jit_binary_lock_ro(header);
>  	} else {
>  		jit_data->ctx = ctx;
> -		jit_data->image = image_ptr;
> +		jit_data->ro_image = ro_image_ptr;
>  		jit_data->header = header;
> +		jit_data->ro_header = ro_header;
>  	}
> -	prog->bpf_func = (void *)ctx.image;
> +	prog->bpf_func = (void *)ctx.ro_image;
>  	prog->jited = 1;
>  	prog->jited_len = prog_size;
>  
> @@ -1610,6 +1663,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		bpf_jit_prog_release_other(prog, prog == orig_prog ?
>  					   tmp : orig_prog);
>  	return prog;
> +
> +out_free_hdr:
> +	if (header) {
> +		bpf_arch_text_copy(&ro_header->size, &header->size,
> +				   sizeof(header->size));
> +		bpf_jit_binary_pack_free(ro_header, header);
> +	}
> +	goto out_off;
>  }
>  
>  bool bpf_jit_supports_kfunc_call(void)
> @@ -1617,6 +1678,13 @@ bool bpf_jit_supports_kfunc_call(void)
>  	return true;
>  }
>  
> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> +{
> +	if (!aarch64_insn_copy(dst, src, len))
> +		return ERR_PTR(-EINVAL);
> +	return dst;
> +}
> +
>  u64 bpf_jit_alloc_exec_limit(void)
>  {
>  	return VMALLOC_END - VMALLOC_START;
> @@ -2221,3 +2289,27 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>  
>  	return ret;
>  }
> +
> +void bpf_jit_free(struct bpf_prog *prog)
> +{
> +	if (prog->jited) {
> +		struct arm64_jit_data *jit_data = prog->aux->jit_data;
> +		struct bpf_binary_header *hdr;
> +
> +		/*
> +		 * If we fail the final pass of JIT (from jit_subprogs),
> +		 * the program may not be finalized yet. Call finalize here
> +		 * before freeing it.
> +		 */
> +		if (jit_data) {
> +			bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
> +						     jit_data->header);
> +			kfree(jit_data);
> +		}
> +		hdr = bpf_jit_binary_pack_hdr(prog);
> +		bpf_jit_binary_pack_free(hdr, NULL);
> +		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> +	}
> +
> +	bpf_prog_unlock_free(prog);
> +}
> -- 
> 2.40.1
> 

