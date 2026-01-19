Return-Path: <bpf+bounces-79479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB6D3B617
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D7D307AFA5
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06861318142;
	Mon, 19 Jan 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b22nm1dl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE923E330;
	Mon, 19 Jan 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848333; cv=none; b=FsKUk8BtuTWHzZfK0vVPr+kXs491sS/bixB+WbvCIEJdlaJHpcwB05ofETMdMAplBwFfkW+imiM+9nhXBZy9AarR+aN0AQaMDis3uKJ+uCaqHHLXQZAhE740WUwm7N5nSax612Ufz212V2Cd5OSoT0yHkJtSmiMuqVB1KPSm4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848333; c=relaxed/simple;
	bh=eup11xvEgVwMgD+DiLklnJEQk5sM9viYzoAkrrjZKN0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VGsaels7+RCyM17457XjlP81wAd4/jWBPuqnkht/AoH9nJphW7BhUDZftTDNG0nJyCVXqkGmL1CZLGq9TyvMGfi/dVnkKOD5h7Y/9BteibS2fzcYmyi3fEl8WpeHTgjm4cQ2PziwvIuWh8Df6Toauvn+nQ5FVTUCnsNlrEIP0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b22nm1dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCFFC116C6;
	Mon, 19 Jan 2026 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848333;
	bh=eup11xvEgVwMgD+DiLklnJEQk5sM9viYzoAkrrjZKN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=b22nm1dlaQzLWyS8+pjhpoMfuJqNqiLM0EOUQA0mZ9gWRnr6ofyA7piQjQXp6Aj9+
	 8NrbvpXVzgGo6yNm292b0yZSpOW/lrsFyk9oHWGPQ/OKUPIERG4S8TtUO6oYbsiQL9
	 Wr9uOxWG1rY/iTRx+SUuErmJSNrnH309bS8VoEh+cDxxv5cSqLI7R83oJ7wEyjD4cF
	 W3rAv/6/7ELmMKLG4Rj6DfeSNPJddbvUeAlEK7fi4tEVYK3aSZQ+ubWVdOO6b+2glb
	 3yXZsze+qFM9wgixXg5AxH3LwmE6fCY1+KjqT2H3Mi/PsGL2ed4imPccvx3msIWMnZ
	 DcRaN3IF4nt3Q==
Content-Type: multipart/mixed; boundary="===============0317604263355170277=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <028f71c299f5611605a71e8765c660e34ddd74900081d61e79c33f8f2599b8c1@mail.kernel.org>
In-Reply-To: <20260119032424.10781-4-piliu@redhat.com>
References: <20260119032424.10781-4-piliu@redhat.com>
Subject: Re: [PATCHv6 03/13] kexec_file: Introduce routines to parse PE file
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:32 +0000 (UTC)

--===============0317604263355170277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_uefi_app.c b/kernel/kexec_uefi_app.c
> new file mode 100644
> index 000000000000..dbe6d76d47ff
> --- /dev/null
> +++ b/kernel/kexec_uefi_app.c

[ ... ]

> +static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	struct mz_hdr *mz;
> +	struct pe_hdr *pe;
> +
> +	if (!kernel_buf)
> +		return false;
> +	mz = (struct mz_hdr *)kernel_buf;
> +	if (mz->magic != IMAGE_DOS_SIGNATURE)
> +		return false;
> +	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);

The kernel_len parameter is declared but never used in this function.
Should this validate that mz->peaddr is within bounds of kernel_len before
accessing pe->magic? If mz->peaddr is larger than the buffer size, this
would read out of bounds.

> +	if (pe->magic != IMAGE_NT_SIGNATURE)
> +		return false;
> +	if (pe->opt_hdr_size == 0) {
> +		pr_err("optional header is missing\n");
> +		return false;
> +	}
> +	return true;
> +}

[ ... ]

> +int pe_get_section(const char *file_buf, const char *sect_name,
> +		char **sect_start, unsigned long *sect_sz)
> +{
> +	struct pe_hdr *pe_hdr;
> +	struct pe32plus_opt_hdr *opt_hdr;
> +	struct section_header *sect_hdr;
> +	int section_nr, i;
> +	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
> +
> +	*sect_start = NULL;
> +	*sect_sz = 0;
> +	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
> +	section_nr = pe_hdr->sections;
> +	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr +
> +				sizeof(struct pe_hdr));
> +	sect_hdr = (struct section_header *)((char *)opt_hdr +
> +				pe_hdr->opt_hdr_size);
> +
> +	for (i = 0; i < section_nr; i++) {

pe_get_section() has no buffer size parameter. The values of mz->peaddr,
pe_hdr->sections, and pe_hdr->opt_hdr_size are all read from the PE file
content. If the file is malformed or crafted, section_nr could be set to an
arbitrarily large value, causing sect_hdr to iterate past the end of
file_buf. Is there a way to validate these offsets against the actual
buffer size?

> +		if (strcmp(sect_hdr->name, sect_name) == 0) {
> +			*sect_start = (char *)file_buf + sect_hdr->data_addr;
> +			*sect_sz = sect_hdr->raw_data_size;
> +			return 0;
> +		}
> +		sect_hdr++;
> +	}
> +
> +	return -1;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============0317604263355170277==--

