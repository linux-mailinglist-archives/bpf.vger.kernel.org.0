Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED52D1543
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgLGP4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 10:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLGP4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 10:56:15 -0500
Date:   Mon, 7 Dec 2020 12:55:42 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607356533;
        bh=nqDEPecy5hi29ZHs/FJP/bg62yy47PGkG1GdQfuSPks=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUAcLQkQGu5wMDjHWx8I+3IE2bX/nAeQ/fa3F/kvuRv/DvZjg50gkvFY0LDUmdT6G
         tVM5uwk7rHD7ytTipZnF+nHHrzCcsZfaBVmL+xlbnRgx1jz5/zaGWGYsFOdGQmc4KC
         jzBbg2GsfTQ++WZacFXFHD1bV5EVFCra7OiUvtttzZZRm73ABnHPeYhogULAfFAlcZ
         R1804TRs8VcvNJXliK4VyHEUBn3w2WdVTppeKEdedoTNjUUfxN47zG4iL01oGJE1wQ
         xMSbSTKVlPG1dgjJ6ycMKjPe7Q8NcqoiI907dmNO0O5uLN2vLG785YpWYfbrZiGsG4
         vCCx0u3m8PN/Q==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: [PATCH] dwarves: Fix compilation on 32-bit architectures
Message-ID: <20201207155542.GC125383@kernel.org>
References: <20201206172617.9751-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206172617.9751-1-vt@altlinux.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Dec 06, 2020 at 08:26:17PM +0300, Vitaly Chikunov escreveu:
> Replace `%lx' for addr (uint64_t) with PRIx64. `%ld' for seek_bytes
> (off_t) is replaced with PRIx64 too, likewise in other places it's
> printed.
> 
> Fixes these error messages on i586 and arm-32:

Thanks, I had noticed this when I last did a scratch build on koji and
was going to fix it, now I don't need to do it, thanks! :-)

- Arnaldo
 
>   btf_encoder.c:445:52: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'uint64_t'
>   btf_encoder.c:687:54: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uint64_t'
>   btf_encoder.c:695:71: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uint64_t'
>   btf_encoder.c:708:88: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uint64_t'
>   pahole.c:1872:20: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'off_t'
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Cc: bpf@vger.kernel.org
> Cc: dwarves@vger.kernel.org
> ---
>  btf_encoder.c | 8 ++++----
>  pahole.c      | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c40f059..feb1023 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -442,7 +442,7 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
>  	}
>  
>  	if (btf_elf__verbose)
> -		printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> +		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
>  
>  	if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
>  		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> @@ -684,7 +684,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
>  
>  		if (btf_elf__verbose) {
> -			printf("Variable '%s' from CU '%s' at address 0x%lx encoded\n",
> +			printf("Variable '%s' from CU '%s' at address 0x%" PRIx64 " encoded\n",
>  			       name, cu->name, addr);
>  		}
>  
> @@ -692,7 +692,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		id = btf_elf__add_var_type(btfe, type, name, linkage);
>  		if (id < 0) {
>  			err = -1;
> -			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%lx\n",
> +			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%" PRIx64 "\n",
>  			        name, addr);
>  			break;
>  		}
> @@ -705,7 +705,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo, id, offset, size);
>  		if (id < 0) {
>  			err = -1;
> -			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%lx\n",
> +			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
>  			        name, addr);
>  			break;
>  		}
> diff --git a/pahole.c b/pahole.c
> index fe8d2cd..4a34ba5 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1869,7 +1869,7 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
>  
>  		// Since we're reading stdin, we need to account for what we already read
>  		if (seek_bytes < total_read_bytes) {
> -			fprintf(stderr, "pahole: can't go back in stdin, already read %" PRIu64 " bytes, can't go to position %ld\n",
> +			fprintf(stderr, "pahole: can't go back in stdin, already read %" PRIu64 " bytes, can't go to position %#" PRIx64 "\n",
>  					total_read_bytes, seek_bytes);
>  			return -ENOMEM;
>  		}
> -- 
> 2.25.4
> 

-- 

- Arnaldo
