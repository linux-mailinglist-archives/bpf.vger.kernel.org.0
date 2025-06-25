Return-Path: <bpf+bounces-61560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6094AAE8C0A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA71C2227A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C312D541F;
	Wed, 25 Jun 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX+uJLFK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E81A3159
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875035; cv=none; b=QLd3uZl2IfhHyjx/T2Dto4Qr7FttSYaD1JwxYDLoWV09/tQtOk2WGbXVGCwXXHQIpsMCZeY2CExWW7UqZuNLbkNo+yIfNazlJO2/rnGf9DexEDAbPamK8AtvRBTVuw3KOarIAFwtX46UXx8Bdmvt+wFpxWw4PF8+0j3+5bn6fRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875035; c=relaxed/simple;
	bh=j8Z3Hf0xX+wPcAhaNRq1sRTIpdqNU6PS0SUx2LYRLJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bky5KIl9/NkMVkHuns76pwNxgiHsEwEGt6w+mU97dFKA4EjGOH2lTfgvTGDjzMCJIDsmxvHyFYSR1vGe3gk1pGxGxMWk51w/MSYWidvPo2Kp0kEs3t9lK0W1QjQN9OM+JKJnye6BmZvXkkxFqV7v0fDhUUbjUOHmfYezaHUZZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dX+uJLFK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750875032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzuUBV0uV48AYrCe5pTj9jDjUJNzMBEgymAaKUPlan8=;
	b=dX+uJLFKXchqgrklT/L+8ry5qUiU/P03M3NwRPPAI2WbP7Tc7J1URFmUFPA96P0hN1rpNC
	rL7DtdhVInBP23ZEejuGtW2C7ybacXpT97sv2EngEk0tgwYZcq7LYaDWjVUaUm64N8/Ejr
	MTHtUwkzZSpFB4kV4OWxsvKXyN0kT5w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-NzDd3K3OPbubeO-RAfx01g-1; Wed,
 25 Jun 2025 14:10:29 -0400
X-MC-Unique: NzDd3K3OPbubeO-RAfx01g-1
X-Mimecast-MFC-AGG-ID: NzDd3K3OPbubeO-RAfx01g_1750875025
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A190F1809C9D;
	Wed, 25 Jun 2025 18:10:24 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.225.238])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D426930001A1;
	Wed, 25 Jun 2025 18:10:15 +0000 (UTC)
Date: Wed, 25 Jun 2025 20:10:11 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCHv3 8/9] kexec: Integrate bpf light skeleton to load zboot
 image
Message-ID: <20250625201011.1eab16a5@rotkaeppchen>
In-Reply-To: <20250529041744.16458-9-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
	<20250529041744.16458-9-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Pingfan,

On Thu, 29 May 2025 12:17:43 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> All kexec PE bpf prog should align with the interface exposed by the
> light skeleton
>     four maps:
>                     struct bpf_map_desc ringbuf_1;
>                     struct bpf_map_desc ringbuf_2;
>                     struct bpf_map_desc ringbuf_3;
>                     struct bpf_map_desc ringbuf_4;
>     four sections:
>                     struct bpf_map_desc rodata;
>                     struct bpf_map_desc data;
>                     struct bpf_map_desc bss;
>                     struct bpf_map_desc rodata_str1_1;
>     two progs:
>             SEC("fentry.s/bpf_handle_pefile")
>             SEC("fentry.s/bpf_post_handle_pefile")
> 
> With the above presumption, the integration consists of two parts:
>   -1. Call API exposed by light skeleton from kexec
>   -2. The opts_insn[] and opts_data[] are bpf-prog dependent and
>       can be extracted and passed in from the user space. In the
>       kexec_file_load design, a PE file has a .bpf section, which data
>       content is a ELF, and the ELF contains opts_insn[] opts_data[].
>       As a bonus, BPF bytecode can be placed under the protection of the
>       entire PE signature.
>       (Note, since opts_insn[] contains the information of the ringbuf
>        size, the bpf-prog writer can change its proper size according to
>        the kernel image size without modifying the kernel code)
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: bpf@vger.kernel.org
> To: kexec@lists.infradead.org
> ---
>  kernel/Makefile                              |   1 +
>  kernel/kexec_bpf/Makefile                    |   8 +
>  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 292 +------------------
>  kernel/kexec_pe_image.c                      |  70 +++++
>  4 files changed, 83 insertions(+), 288 deletions(-)
> 
[...]

> diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> index e49d6db3c329d..f47c1e46dba97 100644
> --- a/kernel/kexec_pe_image.c
> +++ b/kernel/kexec_pe_image.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/elf.h>
>  #include <linux/pe.h>
>  #include <linux/string.h>
>  #include <linux/bpf.h>
> @@ -21,6 +22,7 @@
>  #include <asm/image.h>
>  #include <asm/memory.h>
>  
> +#include "kexec_bpf/kexec_pe_parser_bpf.lskel.h"
>  
>  static LIST_HEAD(phase_head);
>  
> @@ -163,14 +165,82 @@ static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz)
>  	return true;
>  }
>  
> +static struct kexec_pe_parser_bpf *pe_parser;
> +
> +static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
> +		const char *symbol_name, unsigned int *symbol_size)
> +{
> +	Elf_Ehdr *ehdr = (Elf_Ehdr *)elf_data;
> +	Elf_Shdr *shdr, *symtab_shdr, *strtab_shdr, *dst_shdr;
> +	Elf64_Sym *sym, *symtab = NULL;
> +	char *strtab = NULL;
> +	void *symbol_data = NULL;
> +	int i;
> +
> +	symtab_shdr = strtab_shdr = NULL;
> +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
> +		pr_err("Not a valid ELF file\n");
> +		goto out;
> +	}
> +
> +	shdr = (struct elf_shdr *)(elf_data + ehdr->e_shoff);
> +	for (i = 0; i < ehdr->e_shnum; i++) {
> +		if (shdr[i].sh_type == SHT_SYMTAB)
> +			symtab_shdr = &shdr[i];
> +		else if (shdr[i].sh_type == SHT_STRTAB && i != ehdr->e_shstrndx)
> +			strtab_shdr = &shdr[i];
> +	}
> +
> +	if (!symtab_shdr || !strtab_shdr) {
> +		pr_err("Symbol table or string table not found\n");
> +		goto out;
> +	}
> +	symtab = (Elf64_Sym *)(elf_data + symtab_shdr->sh_offset);
> +	strtab = (char *)(elf_data + strtab_shdr->sh_offset);
> +	for (i = 0; i < symtab_shdr->sh_size / sizeof(Elf64_Sym); i++) {
> +		sym = &symtab[i];
> +		if (strcmp(&strtab[sym->st_name], symbol_name) == 0) {
> +			if (sym->st_shndx >= SHN_LORESERVE)
> +				return NULL; // No section data for these
> +			dst_shdr = &shdr[sym->st_shndx];
> +			symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
> +			*symbol_size = symtab[i].st_size;
> +			break;
> +		}
> +	}
> +
> +out:
> +	return symbol_data;
> +}

In kernel/kexec_file.c there is kexec_purgatory_find_symbol which is
basically identical to this function. With a little bit of refractoring
it should work for both cases. I prefer using
kexec_purgatory_find_symbol as your implementation cannot handle elf
files with multiple symtab and strtab sections.

Thanks
Philipp

> +
>  /* Load a ELF */
>  static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
>  {
> +	opts_data = get_symbol_from_elf(bpf_elf, sz, "opts_data", &opts_data_sz);
> +	opts_insn = get_symbol_from_elf(bpf_elf, sz, "opts_insn", &opts_insn_sz);
> +	if (!opts_data || !opts_insn)
> +		return -1;
> +	/*
> +	 * When light skeleton generates opts_data[] and opts_insn[], it appends a
> +	 * NULL terminator at the end of string
> +	 */
> +	opts_data_sz = opts_data_sz - 1;
> +	opts_insn_sz = opts_insn_sz - 1;
> +
> +	pe_parser = kexec_pe_parser_bpf__open_and_load();
> +	if (!pe_parser)
> +		return -1;
> +	kexec_pe_parser_bpf__attach(pe_parser);
> +
>  	return 0;
>  }
>  
>  static void disarm_bpf_prog(void)
>  {
> +	kexec_pe_parser_bpf__destroy(pe_parser);
> +	pe_parser = NULL;
> +	opts_data = NULL;
> +	opts_insn = NULL;
>  }
>  
>  struct kexec_context {


