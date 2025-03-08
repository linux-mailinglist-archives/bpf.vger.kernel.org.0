Return-Path: <bpf+bounces-53641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE0A578D0
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 07:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD913B011B
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6118FC84;
	Sat,  8 Mar 2025 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LRFbn7Yj"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97E184540
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416518; cv=none; b=ED0W2sXmQ+Lb8DHEUznmKyOgltxoZgSymtQBvMftiTzaPFpeOQAhbg2q5d6u2qRWnOrZywXi1yvX5XrpmwAna4WT3BZakSWXpZuVuY1bf9JhMa9RBLsjFBeXtxs+GkS8DcxocqA/9B3xZ6nHQX8MmoS/t7jkA2675t0RdT7NUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416518; c=relaxed/simple;
	bh=8jukEC0EudsYjwC02rHInMECXXNwK3YBr4+9H9xlMdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=APe4hJCwMG4JJPuJSV9Qj+2JhSm4aNJqB91hCyocomLmZcrAZCfBJ4t5ft7wECA68h2KLSqa+MTUjPDbTL5xpkWPrqK7QqtUx0X1y0nGCpHMGHgPStj+9/6U0IfV+EhgcWRoM/sLl6TrI0acUcAqNYjO9g97LH28xxX8RufU6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LRFbn7Yj; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741416514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fITP1K5VcspxKICkRPgUCuZyykwQHgzN9i0lzuFRk3A=;
	b=LRFbn7YjkHBRLyZIWjGODrUhE3JqUL/k1xkvSKuQMr5ZCFKlW/TTIeD3AvvsWlLdcQqcq+
	0jOEB+lo98ouk2S/UYh+q3GQMcvgzke0SomaBM0SpXTHrdbK9MC3hmP/N7aN2EnwYzoK1c
	EfF1jD3gRGsq1OXvdP5AhjFzw4S3cf0=
Date: Fri, 7 Mar 2025 22:48:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: Fix uprobe offset calculation
Content-Language: en-GB
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, deso@posteo.net
References: <20250307140120.1261890-1-hengqi.chen@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250307140120.1261890-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/7/25 6:01 AM, Hengqi Chen wrote:
> As reported on libbpf-rs issue([0]), the current implementation
> may resolve symbol to a wrong offset and thus missing uprobe
> event. Calculate the symbol offset from program header instead.
> See the BCC implementation (which in turn used by bpftrace) and
> the spec ([1]) for references.
>
>    [0]: https://github.com/libbpf/libbpf-rs/issues/1110
>    [1]: https://refspecs.linuxfoundation.org/elf/
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Hengqi,

There are some test failures in the CI. For example,
   https://github.com/kernel-patches/bpf/actions/runs/13725803997/job/38392284640?pr=8631

Please take a look.
Your below elf_sym_offset change matches some bcc implementation, but
maybe maybe this is only under certain condition?

Also, it would be great if you can add detailed description in commit message
about what is the problem and why a different approach is necessary to
fix the issue.

> ---
>   tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 823f83ad819c..9b561c8d1eec 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_iter *iter, int sh_type, struct elf_sym
>    * for shared libs) into file offset, which is what kernel is expecting
>    * for uprobe/uretprobe attachment.
>    * See Documentation/trace/uprobetracer.rst for more details. This is done
> - * by looking up symbol's containing section's header and using iter's virtual
> - * address (sh_addr) and corresponding file offset (sh_offset) to transform
> + * by looking up symbol's containing program header and using its virtual
> + * address (p_vaddr) and corresponding file offset (p_offset) to transform
>    * sym.st_value (virtual address) into desired final file offset.
>    */
> -static unsigned long elf_sym_offset(struct elf_sym *sym)
> +static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *sym)
>   {
> -	return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
> +	size_t nhdrs, i;
> +	GElf_Phdr phdr;
> +
> +	if (elf_getphdrnum(elf, &nhdrs))
> +		return -1;
> +
> +	for (i = 0; i < nhdrs; i++) {
> +		if (!gelf_getphdr(elf, (int)i, &phdr))
> +			continue;
> +		if (phdr.p_type != PT_LOAD || !(phdr.p_flags & PF_X))
> +			continue;
> +		if (sym->sym.st_value >= phdr.p_vaddr &&
> +		    sym->sym.st_value < (phdr.p_vaddr + phdr.p_memsz))
> +			return sym->sym.st_value - phdr.p_vaddr + phdr.p_offset;
> +	}
> +
> +	return -1;
>   }
>   
>   /* Find offset of function name in the provided ELF object. "binary_path" is
> @@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>   
>   			if (ret > 0) {
>   				/* handle multiple matches */
> -				if (elf_sym_offset(sym) == ret) {
> +				if (elf_sym_offset(elf, sym) == ret) {
>   					/* same offset, no problem */
>   					continue;
>   				} else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {

[...]


