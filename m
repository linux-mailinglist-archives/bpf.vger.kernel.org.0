Return-Path: <bpf+bounces-45713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB09DA980
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6223AB20DC5
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7011FCFE5;
	Wed, 27 Nov 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oa9pn2/7"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6E1FCF57
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716005; cv=none; b=GzrPqP+lM7+IrZEqGRa2AZ9bMLFBQDgaswK1eU5k9DTXChMrpgxeVEH3jFo1olqj5O6oFzRM45kAinJPBn4mIxOMe89kB1TI5o2CMNmPY1/wjRohpn8bPMykdTdWWZBC2cHZ1RT6cEJ6DnOQIzZor+iym9qMvLY/Ei4xuiuKnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716005; c=relaxed/simple;
	bh=3iLOkCRVMa8WlfMFaQcEpRsjfAz3EAZYnnWEoDtsjWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5kxiPZdzXlJm8oDt1FUUJ1XbjY31Jgu2VoiWhpH3TCeMzUin/dKTC7O8cnKFfgTaapLhnP0RiAE44zcJxznaZyN+Y5HG2TH9p8CZL7zGAtgHkjz27/AWFZt719qbAJ+m+GsIajc5GQkRViht2o8wh0sXtAv0u9Ft7aserIqo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oa9pn2/7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35f1dcb0-f577-4861-a82d-c3083dafabd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732715999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2OmpSTHS2zTR/6T9qs+CZJX3BEn5zpT5EJk38SUdY8=;
	b=oa9pn2/7Ef6BAUhpjiUJ3SZqogBTYiFdRfwfI3NYcvjpKWfpcae2cG4VJOb1XZ9kS4jwHu
	RU7KhhuvlFQEu43SMzjnJAvGNnDFg+/afHenKzxi+5A/kNAAlLzgKNwxbApwXK7PpG83hp
	ltpa2ypFlcU8TEot6POKCtMHnE8WGa0=
Date: Wed, 27 Nov 2024 13:59:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
 arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
 Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Jiri Olsa <olsajiri@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
 <20241127015006.2013050-2-eddyz87@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241127015006.2013050-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/11/2024 01:50, Eduard Zingerman wrote:
> btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> kfuncs present in the ELF file being processed.
> This section consists of:
> - arrays of uint32_t elements;
> - arrays of records with the following structure:
>    struct btf_id_and_flag {
>        uint32_t id;
>        uint32_t flags;
>    };
> 
> When endianness of a binary operated by pahole differs from the host
> system's endianness, these fields require byte-swapping before use.
> Currently, this byte-swapping does not occur, resulting in kfuncs not
> being marked with declaration tags.
> 
> This commit resolves the issue by using elf_getdata_rawchunk()
> function to read .BTF_ids section data. When called with ELF_T_WORD as
> 'type' parameter it does necessary byte order conversion
> (only if host and elf endianness do not match).
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Jiri Olsa <olsajiri@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Vadim Fedorenko <vadfed@meta.com>
> Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   btf_encoder.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1adddf..3754884 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1904,18 +1904,32 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>   			goto out;
>   		}
>   
> -		data = elf_getdata(scn, 0);
> -		if (!data) {
> -			elf_error("Failed to get ELF section(%d) data", i);
> -			goto out;
> -		}
> -
>   		if (shdr.sh_type == SHT_SYMTAB) {
> +			data = elf_getdata(scn, 0);
> +			if (!data) {
> +				elf_error("Failed to get ELF section(%d) data", i);
> +				goto out;
> +			}
> +
>   			symbols_shndx = i;
>   			symscn = scn;
>   			symbols = data;
>   			strtabidx = shdr.sh_link;
>   		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			/* .BTF_ids section consists of uint32_t elements,
> +			 * and thus might need byte order conversion.
> +			 * However, it has type PROGBITS, hence elf_getdata()
> +			 * won't automatically do the conversion.
> +			 * Use elf_getdata_rawchunk() instead,
> +			 * ELF_T_WORD tells it to do the necessary conversion.
> +			 */
> +			data = elf_getdata_rawchunk(elf, shdr.sh_offset, shdr.sh_size, ELF_T_WORD);
> +			if (!data) {
> +				elf_error("Failed to get %s ELF section(%d) data",
> +					  BTF_IDS_SECTION, i);
> +				goto out;
> +			}
> +
>   			idlist_shndx = i;
>   			idlist_addr = shdr.sh_addr;
>   			idlist = data;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

