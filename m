Return-Path: <bpf+bounces-45700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E929DA65B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55862282095
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E831E2301;
	Wed, 27 Nov 2024 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaDEWuky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B741E2039;
	Wed, 27 Nov 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705235; cv=none; b=ZuM/mhKqpc2waxMwgbl9hZNupUGNRVCFEh+YXswsYwuF2MHFN/kumtAZcK/8/wlLDO6DNjelNatBdVIT4NubRVs9xtMkJe8e5WriicQLtDUmhqHEy9OFFvnjyqu2rU81qOpaoVbgrvxIGarhkXd9wa3wa1yUN73gW3FEEkzjmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705235; c=relaxed/simple;
	bh=ZSgfgzZpq4Wf/Z0XsS0ZTJNI9vYP9DfxXcfjZ+fpkTI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwwDNN9js4yJ3IOwmHyFsEwryBTI2IlenqDqG+1oQSxdQ9uOn2QsZhC7rG4SEspG/4i6vRM87NkmNfqAj6HskVnbkuwAoKEvdgkM1jBOkKRv8MDgLQub8yXqpg2Xv2M73DoGzIc4jwet/gYS5Iplx8eRGq3YWFPNp0hDLN5tAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaDEWuky; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a8640763so12513525e9.1;
        Wed, 27 Nov 2024 03:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732705232; x=1733310032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SO1AOrq1qdnnV7p/Q9H8T5VcCbwx58hSa8RXQhQN8EU=;
        b=RaDEWukyzO3h5GFMaNJMSstgqsouZjdfj9DLH5C1KHrLU10B1wUL3yW9msCrsbXhv9
         8/W9bvnAlCM7bB6EwTVbCxS2gdj3XLJySBZOHLZKPikbjk8ried3fFoqtPqef6FR5nMk
         qU9qtv5Zg3LVAA/4w9IJ95JNDQfQkTPzGR1rnosWu2OqWSLTgfCasmRpmfNA9SdRcvfq
         ZiBBV4fjZJEJMakjloHlSvIrPj4pVYC+29Jell0+7NjUw47KFg4Y5yv/0pJKLqUvl2GT
         SpKNkMvUyC26KWiCNcV+RoLiwA6B3gsrWqXBuM5zbmDuX8FKqjJpGfKi1VNO90TBtEvn
         RP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705232; x=1733310032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO1AOrq1qdnnV7p/Q9H8T5VcCbwx58hSa8RXQhQN8EU=;
        b=b/VaGpbrR9PHGrJdZvi2hgIrIE38zLgxB87bHyE7Tv06W+oRbR6IdFVrPwEHcsh83O
         mmHsjyn8ZXaxJJUSflRz0A41Ux4vwMMJ16ToPvkg4MSJGH3ytzLc3Iqj6Qdkv4Iquwp+
         SMfrFl+wQEhm184+CPuA/y6ptV6vU5hxFjJFRGDkJhqS+Ck76iGBC16R4UXK4B0cP9B5
         4ce/tFiJVqlG/pmvgs/ZEq020LPDBeQF035rTS+7OGHnMYvFnx/UDKzY8a6lh/1srrPf
         +Pq6NcMIg6QBkKQ6SX5ttngwXeSMeOYgThRgZk4dAaUhmRVpWnKjOhLb09mykPRSblrx
         ZluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUryWwqe1Fy1VkypffW+MyodF+RqCtoCiOIzAbK7NyDOIhBeVMEMjfcrmWnyOCDchNBz3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6CFZ/45+ftTe3QnBqB/DIEb2/SRhFdV+kNu8NhCc8iNoG/ym
	7J+s8VVf8npQCvQYpDwA9oJfFB871OQbz9JmNylw7DA1WuqHRjxV
X-Gm-Gg: ASbGncu3O2WpxGCBoeUy8ZGJacEWmMQQwPbRTuWqVOrMTp3KgfyVKsGQKz10851SjTh
	WRIFMNu+VwzuaM8FJTMV1TrlBYw3Ez74SSd1NEgRccqC63RNKP2y+2p+Q0cPG+KBA7Vrwd8hALL
	JcbqBBILInQQ4QBWFeQKoEq9PlTCW13dGWDlosISLeCX2JZQfSnu1NaC2uyRJvOuHyDYUSK/E3W
	C3xlwMC+lHFOdV8Yd+PX2CYOEirvYSokXBYoy9ddqXqLEeo47sHxu+2ldC7dk2Mp0yEOOBieXW8
	fco6sg2MHKoYsvb3EP7rjFA=
X-Google-Smtp-Source: AGHT+IEgt/7Ko0GQsJXILTaLNli5n+/IqbFSsVjZjYkyR42/v1KhtRxGqeF7jhIwu9iPr7AUQ6Bu+g==
X-Received: by 2002:a05:600c:4f12:b0:431:5a27:839c with SMTP id 5b1f17b1804b1-434a9db7b4bmr21860935e9.5.1732705231769;
        Wed, 27 Nov 2024 03:00:31 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe901esm16216029f8f.87.2024.11.27.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:00:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Nov 2024 12:00:28 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, yonghong.song@linux.dev,
	Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
Message-ID: <Z0b7zLfaoodeWF6J@krava>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
 <20241127015006.2013050-2-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127015006.2013050-2-eddyz87@gmail.com>

On Tue, Nov 26, 2024 at 05:50:06PM -0800, Eduard Zingerman wrote:
> btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> kfuncs present in the ELF file being processed.
> This section consists of:
> - arrays of uint32_t elements;
> - arrays of records with the following structure:
>   struct btf_id_and_flag {
>       uint32_t id;
>       uint32_t flags;
>   };
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
>  btf_encoder.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1adddf..3754884 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1904,18 +1904,32 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  			goto out;
>  		}
>  
> -		data = elf_getdata(scn, 0);
> -		if (!data) {
> -			elf_error("Failed to get ELF section(%d) data", i);
> -			goto out;
> -		}
> -
>  		if (shdr.sh_type == SHT_SYMTAB) {
> +			data = elf_getdata(scn, 0);
> +			if (!data) {
> +				elf_error("Failed to get ELF section(%d) data", i);
> +				goto out;
> +			}
> +
>  			symbols_shndx = i;
>  			symscn = scn;
>  			symbols = data;
>  			strtabidx = shdr.sh_link;
>  		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			/* .BTF_ids section consists of uint32_t elements,
> +			 * and thus might need byte order conversion.
> +			 * However, it has type PROGBITS, hence elf_getdata()
> +			 * won't automatically do the conversion.
> +			 * Use elf_getdata_rawchunk() instead,
> +			 * ELF_T_WORD tells it to do the necessary conversion.
> +			 */
> +			data = elf_getdata_rawchunk(elf, shdr.sh_offset, shdr.sh_size, ELF_T_WORD);

looks good, I'm just curious about one thing..

so ELF_T_WORD enum has this comment: /* Elf32_Word, Elf64_Word, ... */

I did just quick check, ***so I might be easily wrong***, but I wonder the
code in __elf_xfctstom (which I assume is the one called for conversion)
chooses to swap 32/64 bits values based on elf->class .. so for 64bit ELF
class we swap 64bit values? ... while .BTF_ids has always 32 bit values

thanks,
jirka

> +			if (!data) {
> +				elf_error("Failed to get %s ELF section(%d) data",
> +					  BTF_IDS_SECTION, i);
> +				goto out;
> +			}
> +
>  			idlist_shndx = i;
>  			idlist_addr = shdr.sh_addr;
>  			idlist = data;
> -- 
> 2.47.0
> 

