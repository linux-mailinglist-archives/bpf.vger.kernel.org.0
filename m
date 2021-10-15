Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FCB42F18A
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhJOM4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 08:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234376AbhJOM4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 08:56:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF50260F56;
        Fri, 15 Oct 2021 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302468;
        bh=GJYgvDmFMF37lj8djCH6OYdxq1He49jAVjZbUl5kHiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rx60UodlNITonDTm9CQDT0fQlhTm2HWNIha4CO1a/dacAwFOurifPHxk6RD7xbr85
         kfVP5bYDu3J3CnEXUSh5vd2/5LZ/8EqHx2ptIGn9dq27sCMkk7TQ77wEJ1Opgnc6K9
         OipG4IGXiO3X/kadk/mhpqmQI2fPTqDerOaNchwm9caRDGrZtEjummUmLCtSoCX/qe
         ZWxqoqbnVOJ/r8Pg154J1Rbs8yMOMXS4C5NPMOHrBY8VK+thOcBBJ0UzEVPMxcBhPk
         CI/xRowYdcVv3HwN4FJCjcDJarpLoCUz7wEQBGVbYsJe6fCLff79ghG6DP63jcWks0
         TLDd1AOBXoDQA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 364A1410A1; Fri, 15 Oct 2021 09:54:26 -0300 (-03)
Date:   Fri, 15 Oct 2021 09:54:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH dwarves] btf_encoder: Fix handling of percpu symbols on
 s390
Message-ID: <YWl6Au74co0UNMq2@kernel.org>
References: <20211012022637.399365-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012022637.399365-1-iii@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Oct 12, 2021 at 04:26:37AM +0200, Ilya Leoshkevich escreveu:
> pahole does not generate VARs for percpu symbols on s390. A percpu
> symbol definition on a typical x86_64 kernel looks like this:
> 
>   [33] .data..percpu     PROGBITS         0000000000000000  01c00000
>                                           ^^^^^^^^^^^^^^^^ sh_addr
>   LOAD           0x0000000001c00000 0x0000000000000000 0x000000000286f000
>                                     ^^^^^^^^^^^^^^^^^^ p_vaddr
>  13559: 000000000001ba50     4 OBJECT  LOCAL  DEFAULT   33 cpu_profile_flip
>         ^^^^^^^^^^^^^^^^ st_value
> 
> Most importantly, .data..percpu's sh_addr is 0, and this is what pahole
> is currently assuming. However, on s390 this is different:
> 
>    [37] .data..percpu     PROGBITS         00000000019cd000  018ce000
>                                            ^^^^^^^^^^^^^^^^ sh_addr
>   LOAD           0x000000000136e000 0x000000000146d000 0x000000000146d000
>                                     ^^^^^^^^^^^^^^^^^^ p_vaddr
> 80377: 0000000001ba1440     4 OBJECT  WEAK   DEFAULT   37 cpu_profile_flip
>        ^^^^^^^^^^^^^^^^ st_value
> 
> Fix by restructuring the code to always use section-relative offsets
> for symbols. Change the comment to focus on this invariant.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  btf_encoder.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c341f95..16e90c3 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -56,7 +56,8 @@ struct btf_encoder {
>  			  raw_output,
>  			  verbose,
>  			  force,
> -			  gen_floats;
> +			  gen_floats,
> +			  is_rel;
>  	uint32_t	  array_index_id;
>  	struct {
>  		struct var_info vars[MAX_PERCPU_VAR_CNT];
> @@ -1104,6 +1105,13 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
>  	if (encoder->verbose)
>  		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
>  
> +	/* Make sure addr is section-relative. For kernel modules (which are
> +	 * ET_REL files) this is already the case. For vmlinux (which is an
> +	 * ET_EXEC file) we need to subtract the section address.
> +	 */
> +	if (!encoder->is_rel)
> +		addr -= encoder->percpu.base_addr;
> +
>  	if (encoder->percpu.var_cnt == MAX_PERCPU_VAR_CNT) {
>  		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
>  			MAX_PERCPU_VAR_CNT);
> @@ -1195,12 +1203,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
>  		addr = var->ip.addr;
>  		dwarf_name = variable__name(var);
>  
> -		/* DWARF takes into account .data..percpu section offset
> -		 * within its segment, which for vmlinux is 0, but for kernel
> -		 * modules is >0. ELF symbols, on the other hand, don't take
> -		 * into account these offsets (as they are relative to the
> -		 * section start), so to match DWARF and ELF symbols we need
> -		 * to negate the section base address here.
> +		/* Make sure addr is section-relative. DWARF, unlike ELF,
> +		 * always contains virtual symbol addresses, so subtract
> +		 * the section address unconditionally.
>  		 */
>  		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
>  			continue;
> @@ -1322,6 +1327,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out_delete;
>  		}
>  
> +		encoder->is_rel = ehdr.e_type == ET_REL;
> +
>  		switch (ehdr.e_ident[EI_DATA]) {
>  		case ELFDATA2LSB:
>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
> -- 
> 2.31.1

-- 

- Arnaldo
