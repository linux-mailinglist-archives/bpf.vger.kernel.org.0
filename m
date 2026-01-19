Return-Path: <bpf+bounces-79481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD784D3B61B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153B430B5D51
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D338E5FA;
	Mon, 19 Jan 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWsObhlt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DC285404;
	Mon, 19 Jan 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848339; cv=none; b=ssOz1LRYXigI6vgbcEsBhCA2CqbNNkVyTUtypJ9tVZDBzLLDlQPjX8YaEfLN5XC4AmuscyeV9ieI3fKLTuzkAvgA5cEu7i7m7pgWnwylVN/tUJrLxXZjkKbXcFlHFFtLnkgaF7RkB3ON14U9CFfSAr7i8JiZw4k68aMI5+cak0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848339; c=relaxed/simple;
	bh=wRNvAJXnVuu1QOy742TWlD5Dl2Dtpm3GKw4CrofTVeQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q3iTyFb92ciB4nwsyop4Nbxjwggl+csZ4dUITvD8OLqpICmMD/5+6a8VJKqCUKsMAs4n8OcnqHNOqJA8KB80/rb83HqBBEP0NfhvwhOw3fXwvstceaCY4MjjnrufE/ffacVJ4ohe1tdPQsNfNCbHyRWzQqqdMJpZcK3SCCmB5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWsObhlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CE7C116C6;
	Mon, 19 Jan 2026 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848337;
	bh=wRNvAJXnVuu1QOy742TWlD5Dl2Dtpm3GKw4CrofTVeQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KWsObhltzs8wffjQlpFHA2xQ8ghIWpEpMTrT3XyVPstHjmlxKMZVeY22ethWSfnk8
	 NR8eG1F7CYM4yB2jxE1hR53i/9sB0lxSI7/zqEx1M+ZRJ8WAIPFsqnhDKBeYQHNcXH
	 3owN7yRqHNtboD2DIo89VlOHQyUfk7PbVuWpXIutBUYUc38RJM5X0xLRnr9Rxq+axA
	 QRAYBbR6kymyKYFZCXzN6JywgIOsoU1W1AwcapnGkklTX0DzfBgQFXTSo9qIUX9KBO
	 wKkyU0pg2Qup8njwIlFr8ZTOLxA2nFw5ULUXu02s88DFgVhWVCNZK5zJdySjSiH/QI
	 xZlOcUm4Ex0QA==
Content-Type: multipart/mixed; boundary="===============3056990786630533314=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <468c97464c9b7d16dcbcd192ab8616cb9d55fc0f3948c4df57dd7504a277889e@mail.kernel.org>
In-Reply-To: <20260119032424.10781-11-piliu@redhat.com>
References: <20260119032424.10781-11-piliu@redhat.com>
Subject: Re: [PATCHv6 10/13] kexec_file: Integrate bpf light skeleton to load image with bpf-prog
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:36 +0000 (UTC)

--===============3056990786630533314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index 5ad67672dead..9f1c5aede42e 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
> +		const char *symbol_name, unsigned int *symbol_size)
> +{
> +	Elf_Ehdr *ehdr = (Elf_Ehdr *)elf_data;
> +	Elf_Shdr *shdr, *dst_shdr;
> +	const Elf_Sym *sym;
> +	void *symbol_data;
> +
> +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
> +		pr_err("Not a valid ELF file\n");
> +		return NULL;
> +	}
> +
> +	sym = elf_find_symbol(ehdr, symbol_name);
> +	if (!sym)
> +		return NULL;
> +	shdr = (struct elf_shdr *)(elf_data + ehdr->e_shoff);
> +	dst_shdr = &shdr[sym->st_shndx];
> +	symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The elf_size parameter is declared but never used in this function. The
pointer calculations at ehdr->e_shoff, shdr[sym->st_shndx], and
dst_shdr->sh_offset + sym->st_value could all access memory beyond the
ELF buffer if the ELF data is malformed. Should there be bounds checking
against elf_size to prevent out-of-bounds reads?

> +	*symbol_size = sym->st_size;
> +
> +	return symbol_data;
> +}
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
                      ^^^^^^^^^^^^^^^^^^

If sym->st_size is 0 for either opts_data or opts_insn symbols in the ELF,
then opts_data_sz or opts_insn_sz would be 0 after get_symbol_from_elf()
returns. Subtracting 1 from an unsigned int with value 0 would cause an
integer underflow to UINT_MAX. This large value would then be passed to
bpf_load_and_run() via the opts structure. Would it make sense to check
that opts_data_sz and opts_insn_sz are non-zero before the subtraction?

> +
> +	pe_parser = kexec_pe_parser_bpf__open_and_load();
> +	if (!pe_parser)
> +		return -1;
> +	kexec_pe_parser_bpf__attach(pe_parser);
> +
> +	return 0;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============3056990786630533314==--

