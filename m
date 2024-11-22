Return-Path: <bpf+bounces-45470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3609D611F
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AB6B22E18
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34087148FE1;
	Fri, 22 Nov 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flgz2yB0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF983CD3;
	Fri, 22 Nov 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288267; cv=none; b=C/StRXtMTEntkC44iE/Q/EtIotP5pCG/WCDlPYYmiEaPIk36waExokDdPLMesdsbzoUaTFOvoDNfM2CKt2Bs7YUlH9qKZtkoPP9OA//4734GfiR/S+ptKxgxzxD9td0yrXsaWldhDBirPe14Dh+3E1twWoL9Cu0qcwz6zoNJZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288267; c=relaxed/simple;
	bh=Dsa62Ix4UC505yWbpBXhW1zQ/pXOPHxSRF6MG1AbFGg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRa3KRZx+GTHofbY8DO1NnWpUushZcKNe8Jwi7tkWaS4Hv89K7TaSJekT7BnKe3dptnAj1r4FgsPhmzA5qsdeULDcKtRZZGKO2ubQUnKCdP5sen50bEMGXUrJBZuisUnootJ5TL5J6pGAb5reOAa8yg6iftTopAIvNC5nItyjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flgz2yB0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539ee1acb86so2549490e87.0;
        Fri, 22 Nov 2024 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288264; x=1732893064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGnHgilBQ9bAk1JJzZXCMHrm6f/fs9qbuspgTGW8FXs=;
        b=flgz2yB0VD96tJul9hvx2ySjy3tP4lWFqGiSm8EyeZoCfKY1NAejEZ+H8PjnuUJwz5
         HKVWSIM4Qj4uEv/xZUb3Slvb8E8Wg/yFcwjkp+WccdqfLUZW6Sg193wbSkaxGxkyJvE6
         T1stEczyAgWhGwH7C50H27Jx98SJZdNSzZe7qpMp9puvqUmj6C7MmyDBHVq3IFlWEE2Z
         Mq0TnV2ekVj+A52nax0NG41Crl+lpU+clMPcITrEJyYc5SN5XrKA01vXOZ/IGA2wAsjZ
         e2o653MLS6MjYzYUa0BvikokbD/FRKSsoWtCYYGfbV9xZpfetl8Kqg3rSQcyCDHHiYta
         LmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288264; x=1732893064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGnHgilBQ9bAk1JJzZXCMHrm6f/fs9qbuspgTGW8FXs=;
        b=J8gQi1+Vu6Y1+4wt21hGeVOT+a+XvhZFyO2dXYcugYo8uzNh04e6xgurvC1DGIqLtN
         yEhaa1+/u7PbdtD7tXA5kuWN1/V5S6lP6Qb8t/bwH00zHGKWmoDoJ512SlRJ6weB89j7
         fTiywyfuty1b57Nr0qxiZYsnY7wWGBtUy2rTJJngkcEHFZblBkU/nqEhyWs1JQGgvmoQ
         AIXXnqUiVPlAqKJdg1ZLhZGoT0L5I2vCwmZ1YZ3TiWQOuqRLR4Apb1q8GO8VLivRwwzm
         +gD6RpHo/UwXsAmAUjMj1UW4jVyzlhF6nwSv0UZa+kAgEHEBFDvL/Ll6JiRHju3JjaZN
         Un4w==
X-Forwarded-Encrypted: i=1; AJvYcCVIbWPC1glZPEDCHxlKglhfZNgt3FodhkSCsxlQy7vIzMDHvlZogWzYMK0O4vZ3OWz3rXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywhG8PntSsDzaRdsNynK8p1G9czH+YcscEasOh36R5/GDo7KB
	2ZPD592LdRBAEisDcWi3h7H34GRUqolZuZGITGRr+19v0UKOJvy8
X-Gm-Gg: ASbGnct2u6Ho74BzBaDe4RVpPTFFHcurqtl4NMx5glL5be9RmK5jX6nxNVLknEb2DHr
	rTB/9eKjvIHqiW66zZVcAt/jvzhGlvGfJDXOVjCbvnLSW0+PJANyMS6uiq2c9lAl6jFrItRCN//
	0jx7ZsaxUrzM8CL8ps1HRxL0iJ7EhoVLw4X6O5W3ta5iGB2brC7d0lZduVGMzQZoM+2ZJKBolb8
	5Nq9FpuXzPXZS+SmmvH0/gxn/4uVNUhpbRRyxdHFEjtOMZ4uuMJetHIzZL49HcopS4nB91cxpsS
	3aSZr/wwqAEyd1GlqK6VPIc=
X-Google-Smtp-Source: AGHT+IErzW1RYGreflIJ7mxkbpZK0XC/2+xOT5BK8vqhBqaew0PYip+tGXUBtCD11j0+QrZu7iKJuw==
X-Received: by 2002:a05:6512:b12:b0:53d:cefe:ffbd with SMTP id 2adb3069b0e04-53dd39b5567mr2099288e87.55.1732288263664;
        Fri, 22 Nov 2024 07:11:03 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad60f0sm2604015f8f.22.2024.11.22.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:11:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Nov 2024 16:11:01 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, yonghong.song@linux.dev,
	Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
Message-ID: <Z0CfBQR8zxgJv_AP@krava>
References: <20241122070218.3832680-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122070218.3832680-1-eddyz87@gmail.com>

On Thu, Nov 21, 2024 at 11:02:18PM -0800, Eduard Zingerman wrote:
> btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> kfuncs present in the ELF being processed. This section consists of
> records of the following shape:
> 
>   struct btf_id_and_flag {
>       uint32_t id;
>       uint32_t flags;
>   };

it contains pairs like above and also just id arrays with no flags, but
that does not matter for the patch functionality, because you swap by
u32 values anyway

> 
> When endianness of binary operated by pahole differs from the
> host endianness these fields require byte swap before using.
> 
> At the moment such byte swap does not happen and kfuncs are not marked
> with decl tags when e.g. s390 kernel is compiled on x86.
> To reproduces the bug:
> - follow instructions from [0] to build an s390 vmlinux;
> - execute:
>   pahole --btf_features_strict=decl_tag_kfuncs,decl_tag \
>          --btf_encode_detached=test.btf vmlinux
> - observe no kfuncs generated:
>   bpftool btf dump test.btf format c | grep __ksym
> 
> This commit fixes the issue by adding an endianness conversion step
> for .BTF_ids section data before main processing step, modifying the
> Elf_Data object in-place.
> The choice is such in order to:
> - minimize changes;
> - keep using Elf_Data, as it provides fields {d_size,d_off} used
>   by kfunc processing routines;
> - avoid sprinkling bswap_32 at each 'struct btf_id_and_flag' field
>   access in fear of forgetting to add new ones when code is modified.

lgtm, some questions below

> 
> [0] https://docs.kernel.org/bpf/s390.html
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Vadim Fedorenko <vadfed@meta.com>
> Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  btf_encoder.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  lib/bpf       |  2 +-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1adddf..3bdb73b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -33,6 +33,7 @@
>  #include <stdint.h>
>  #include <search.h> /* for tsearch(), tfind() and tdestroy() */
>  #include <pthread.h>
> +#include <byteswap.h>
>  
>  #define BTF_IDS_SECTION		".BTF_ids"
>  #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> @@ -1847,11 +1848,47 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
>  	return 0;
>  }
>  
> +/* If byte order of 'elf' differs from current byte order, convert the data->d_buf.
> + * ELF file is opened in a readonly mode, so data->d_buf cannot be modified in place.
> + * Instead, allocate a new buffer if modification is necessary.
> + */
> +static int convert_idlist_endianness(Elf *elf, Elf_Data *data, bool *copied)
> +{
> +	int byteorder, i;
> +	char *elf_ident;
> +	uint32_t *tmp;
> +
> +	*copied = false;
> +	elf_ident = elf_getident(elf, NULL);
> +	if (elf_ident == NULL) {
> +		fprintf(stderr, "Cannot get ELF identification from header\n");
> +		return -EINVAL;
> +	}
> +	byteorder = elf_ident[EI_DATA];
> +	if ((BYTE_ORDER == LITTLE_ENDIAN && byteorder == ELFDATA2LSB)
> +	    || (BYTE_ORDER == BIG_ENDIAN && byteorder == ELFDATA2MSB))
> +		return 0;
> +	tmp = malloc(data->d_size);
> +	if (tmp == NULL) {
> +		fprintf(stderr, "Cannot allocate %lu bytes of memory\n", data->d_size);
> +		return -ENOMEM;
> +	}
> +	memcpy(tmp, data->d_buf, data->d_size);
> +	data->d_buf = tmp;

will the original data->d_buf be leaked? are we allowed to assign d_buf like that? ;-)

> +	*copied = true;
> +
> +	/* .BTF_ids sections consist of u32 objects */
> +	for (i = 0; i < data->d_size / sizeof(uint32_t); i++)
> +		tmp[i] = bswap_32(tmp[i]);
> +	return 0;
> +}
> +
>  static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  {
>  	const char *filename = encoder->source_filename;
>  	struct gobuffer btf_kfunc_ranges = {};
>  	struct gobuffer btf_funcs = {};
> +	bool free_idlist = false;
>  	Elf_Data *symbols = NULL;
>  	Elf_Data *idlist = NULL;
>  	Elf_Scn *symscn = NULL;
> @@ -1919,6 +1956,9 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  			idlist_shndx = i;
>  			idlist_addr = shdr.sh_addr;
>  			idlist = data;
> +			err = convert_idlist_endianness(elf, idlist, &free_idlist);
> +			if (err < 0)
> +				goto out;
>  		}
>  	}
>  
> @@ -2031,6 +2071,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  out:
>  	__gobuffer__delete(&btf_funcs);
>  	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (free_idlist)
> +		free(idlist->d_buf);
>  	if (elf)
>  		elf_end(elf);

curious, would elf_end try to free the d_buf at some point?

>  	if (fd != -1)
> diff --git a/lib/bpf b/lib/bpf
> index 09b9e83..caa17bd 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 09b9e83102eb8ab9e540d36b4559c55f3bcdb95d
> +Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56

I think this should not be part of the patch

thanks,
jirka

