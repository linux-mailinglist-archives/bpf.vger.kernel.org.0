Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6583442A96
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 10:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBJpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 05:45:47 -0400
Received: from foss.arm.com ([217.140.110.172]:59422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhKBJpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 05:45:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DAA411B3;
        Tue,  2 Nov 2021 02:43:08 -0700 (PDT)
Received: from [10.32.36.26] (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3BA3F5A1;
        Tue,  2 Nov 2021 02:43:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] kallsyms: ignore arm mapping symbols when loading
 module
To:     Lexi Shao <shaolexi@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, nixiaoming@huawei.com, peterz@infradead.org,
        qiuxi1@huawei.com, wangbing6@huawei.com, jeyu@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
References: <cb7e9ef7-eda4-b197-df8a-0b54f9b56181@arm.com>
 <20211029065038.39449-1-shaolexi@huawei.com>
 <20211029065038.39449-3-shaolexi@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <415161e7-cdfc-557a-23cb-f72c5829bae4@arm.com>
Date:   Tue, 2 Nov 2021 09:43:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029065038.39449-3-shaolexi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 29/10/2021 07:50, Lexi Shao wrote:
> Arm modules contains mapping symbols(e.g. $a $d) which are ignored in
> module_kallsyms_on_each_symbol. However, these symbols are still
> displayed when catting /proc/kallsyms. This confuses tools(e.g. perf)
> that resolves kernel symbols with address using information from
> /proc/kallsyms. See discussion in Link:
> https://lore.kernel.org/all/c7dfbd17-85fd-b914-b90f-082abc64c9d1@arm.com/
> 
> Being left out in vmlinux(see scripts/kallsyms.c is_ignored_symbol) and
> kernelspace API implies that these symbols are not used in any cases.
> So we can ignore them in the first place by not adding them to module
> kallsyms.
> 
> Signed-off-by: Lexi Shao <shaolexi@huawei.com>


I tested this and it has removed the $ symbols from kallsyms where I saw
them before.

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  kernel/module.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 5c26a76e800b..b30cbbe144c7 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2662,16 +2662,22 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
>  	return '?';
>  }
>  
> -static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
> -			unsigned int shnum, unsigned int pcpundx)
> +static inline int is_arm_mapping_symbol(const char *str);
> +static bool is_core_symbol(const Elf_Sym *src, const struct load_info *info)
>  {
>  	const Elf_Shdr *sec;
> +	const Elf_Shdr *sechdrs = info->sechdrs;
> +	unsigned int shnum = info->hdr->e_shnum;
> +	unsigned int pcpundx = info->index.pcpu;
>  
>  	if (src->st_shndx == SHN_UNDEF
>  	    || src->st_shndx >= shnum
>  	    || !src->st_name)
>  		return false;
>  
> +	if (is_arm_mapping_symbol(&info->strtab[src->st_name]))
> +		return false;
> +
>  #ifdef CONFIG_KALLSYMS_ALL
>  	if (src->st_shndx == pcpundx)
>  		return true;
> @@ -2714,8 +2720,7 @@ static void layout_symtab(struct module *mod, struct load_info *info)
>  	/* Compute total space required for the core symbols' strtab. */
>  	for (ndst = i = 0; i < nsrc; i++) {
>  		if (i == 0 || is_livepatch_module(mod) ||
> -		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
> -				   info->index.pcpu)) {
> +		    is_core_symbol(src+i, info)) {
>  			strtab_size += strlen(&info->strtab[src[i].st_name])+1;
>  			ndst++;
>  		}
> @@ -2778,8 +2783,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>  	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
>  		mod->kallsyms->typetab[i] = elf_type(src + i, info);
>  		if (i == 0 || is_livepatch_module(mod) ||
> -		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
> -				   info->index.pcpu)) {
> +		    is_core_symbol(src+i, info)) {
>  			mod->core_kallsyms.typetab[ndst] =
>  			    mod->kallsyms->typetab[i];
>  			dst[ndst] = src[i];
> @@ -4246,8 +4250,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
>  		 * We ignore unnamed symbols: they're uninformative
>  		 * and inserted at a whim.
>  		 */
> -		if (*kallsyms_symbol_name(kallsyms, i) == '\0'
> -		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
> +		if (*kallsyms_symbol_name(kallsyms, i) == '\0')
>  			continue;
>  
>  		if (thisval <= addr && thisval > bestval) {
> 
