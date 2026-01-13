Return-Path: <bpf+bounces-78669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FFD170B5
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 08:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A53C33043481
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7962F6925;
	Tue, 13 Jan 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Od9EzqsJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36229226CF6
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289814; cv=none; b=QcNggZ0itvj1oszUbbaVj4JWTvTquIULd78sXOXuFaEUA3ygEpjodx2e2/EIOYkRWSSdKozOqfOI859UKqa7CnJry7MPHkVYQJoTaKIFqSoVC/KqedsQLtAjSPRpUkVkzOvvRj61BGF8s28WAki+7B2erwhChsdSJwZNqUXJmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289814; c=relaxed/simple;
	bh=YqTb2BRvCqpNEoNw4Trou8rlIEGw1QSLZNK5kXP3nCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5HVO+3r+eqdeNGOwGTw44muPYs2ehl8PU+rEJdro5TPX/UmC6q8bMfx0yzHJK+g8Nez4Z5TazxhKjFBvp7n7Jy0/kEfAeVtgGY0CB1pW+5mmMklxFKnH1nsKNCPdwUX1ApRm8y6VqjfB3MtfVd5gZ8SNkOtNiU/Mgp3kd5ZEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Od9EzqsJ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768289810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PoMLiQPZqU9DNYiwNOFdi31ASnya8ZlhDZDdbxeyIM=;
	b=Od9EzqsJ22+wp0cFuJWzJ9OVsneogWUImIEg6a43i8DBXvrafaYDvGMSVOHkDyg/c5BMrR
	SspIrw2/EcYTp6zz+pxVTrEO3FjWbokND9JksPm8duAQMapp/IHSD6ffcVUKZCEhI4Gpt6
	ppz27ZJ5OrNNpj9Jojy/EdmJRJNxd9I=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andriin@fb.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
 daniel@iogearbox.net, Andrii Nakryiko <andriin@fb.com>,
 andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject:
 Re: [PATCH bpf-next 3/9] libbpf: improve relocation ambiguity detection
Date: Tue, 13 Jan 2026 15:36:43 +0800
Message-ID: <2249675.irdbgypaU6@7940hx>
In-Reply-To: <20200818223921.2911963-4-andriin@fb.com>
References:
 <20200818223921.2911963-1-andriin@fb.com>
 <20200818223921.2911963-4-andriin@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2020/8/19 06:39 Andrii Nakryiko <andriin@fb.com> write:
> Split the instruction patching logic into relocation value calculation and
> application of relocation to instruction. Using this, evaluate relocation
> against each matching candidate and validate that all candidates agree on
> relocated value. If not, report ambiguity and fail load.
> 
> This logic is necessary to avoid dangerous (however unlikely) accidental match
> against two incompatible candidate types. Without this change, libbpf will
> pick a random type as *the* candidate and apply potentially invalid
> relocation.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 170 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 124 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2047e4ed0076..1ba458140f50 100644
> --- a/tools/lib/bpf/libbpf.c
[......]
> @@ -5005,16 +5063,31 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
>  		if (err == 0)
>  			continue;
>  
> +		err = bpf_core_calc_relo(prog, relo, relo_idx, &local_spec, &cand_spec, &cand_res);
> +		if (err)
> +			return err;
> +
>  		if (j == 0) {
> +			targ_res = cand_res;
>  			targ_spec = cand_spec;
>  		} else if (cand_spec.bit_offset != targ_spec.bit_offset) {
> -			/* if there are many candidates, they should all
> -			 * resolve to the same bit offset
> +			/* if there are many field relo candidates, they
> +			 * should all resolve to the same bit offset
>  			 */
> -			pr_warn("prog '%s': relo #%d: offset ambiguity: %u != %u\n",
> +			pr_warn("prog '%s': relo #%d: field offset ambiguity: %u != %u\n",
>  				prog_name, relo_idx, cand_spec.bit_offset,
>  				targ_spec.bit_offset);
>  			return -EINVAL;
> +		} else if (cand_res.poison != targ_res.poison || cand_res.new_val != targ_res.new_val) {
> +			/* all candidates should result in the same relocation
> +			 * decision and value, otherwise it's dangerous to
> +			 * proceed due to ambiguity
> +			 */
> +			pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %u != %s %u\n",
> +				prog_name, relo_idx,
> +				cand_res.poison ? "failure" : "success", cand_res.new_val,
> +				targ_res.poison ? "failure" : "success", targ_res.new_val);
> +			return -EINVAL;
>  		}

Hi, Andrii. This approach is not friend to bpf_core_cast() if the struct
is not used in the vmlinux, but the kernel modules.

Take "struct nft_chain" for example. Following code will fail:
    struct nft_chain *chain = bpf_core_cast(ptr, struct nft_chain).

The bpf_core_cast() will record a BPF_CORE_TYPE_ID_TARGET relocation
for "struct nft_chain". The libbpf will find multi btf type of nft_chain
in the modules nf_tables, nft_reject, etc, and it will fail the verification
due to the "new_val", which is btf type id, not the same, even if all
the "struct nft_chain" are exactly the same in different kernel modules.

I think this is a common case. So how about we check the consistence of
struct nft_chain in all the candidate list, and use the first one if all of
them have exactly the same definition?

We can check all the members in the struct iteratively, and make
sure they are all the same.

Thanks!
Menglong Dong

>  
>  		cand_ids->data[j++] = cand_spec.spec[0].type_id;
> @@ -5042,13 +5115,18 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
>  	 * verifier. If it was an error, then verifier will complain and point
>  	 * to a specific instruction number in its log.
>  	 */
> -	if (j == 0)
> +	if (j == 0) {
>  		pr_debug("prog '%s': relo #%d: no matching targets found\n",
>  			 prog_name, relo_idx);
>  
> -	/* bpf_core_reloc_insn should know how to handle missing targ_spec */
> -	err = bpf_core_reloc_insn(prog, relo, relo_idx, &local_spec,
> -				  j ? &targ_spec : NULL);
> +		/* calculate single target relo result explicitly */
> +		err = bpf_core_calc_relo(prog, relo, relo_idx, &local_spec, NULL, &targ_res);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* bpf_core_patch_insn() should know how to handle missing targ_spec */
> +	err = bpf_core_patch_insn(prog, relo, relo_idx, &targ_res);
>  	if (err) {
>  		pr_warn("prog '%s': relo #%d: failed to patch insn at offset %d: %d\n",
>  			prog_name, relo_idx, relo->insn_off, err);
> -- 
> 2.24.1
> 
> 





