Return-Path: <bpf+bounces-45498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D29D6942
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50F2B2262C
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967719E7FA;
	Sat, 23 Nov 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrDAMQZX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D519D089;
	Sat, 23 Nov 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368302; cv=none; b=qxFNDn/SrfphQEX8uPZNe6lJnmYE2nowMIjO9H1HpRyramDlbGHQgTcx/eQbIZUvvnVMgpIMcGyIFNJqqmSiiPK6gpr6CZgVIg0SY9EKDTs8R7rOCLw8KzAAUMX9PTfgvmDxMUep33EmAYaAbsmYosXk7O+/iHnjQUZjXFY94GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368302; c=relaxed/simple;
	bh=eiNK2KBdszxeI9C1sTvyPGvL2PAcwvqTX+iT97pIpUk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4xU+aytyyvCBg9lNYVrjwYti0/GtkdJGYszlpukdI1EVqoId17KwM//TzqEQ8iBGZO9Kwx92BSHwJ2/dtr9qGU109JNSuthC1LKdgocLaLYFkwSSlj1n5TkfHaYd4QhEgfrh1JnenECplTknvdmQryzCDw3aWZR6BEqI4CxRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrDAMQZX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382442b7d9aso2543460f8f.1;
        Sat, 23 Nov 2024 05:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732368299; x=1732973099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLhGICJL9P+uGBOkVeNmUztSaNFF6STrg7jRfE3rUm0=;
        b=nrDAMQZXU3heS9UO5giFfxCzVHCjqi5ZZAHqxceZOfSHL3r/JsNF/TSviOJrNC7BnB
         iXT0eAaY5lTm96Fiai3N+Wae9Jqx43bX3rgbzWobUUrXtaQMLAT2bUkdjl/Ln6Rc169l
         YqwZsb/Dt88y1IpG2Hszq60AQjoc7XVXKZ/zjx+FBi99KhbBdgJBNaUyWhxQ0LmBT2Ml
         Y6hSUHQAgvhbGP1rJiv3YEbTtF/8bqq9SF4oOrazB3TAymQXQ1f2W55Y/VozGCoMx4vO
         MsDqnLofFYyoR7WdMhZ0lIyxR65xrKblhMvm444j1bSGHuEbCiTvL0e+Pih2knVHLlfT
         i0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732368299; x=1732973099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLhGICJL9P+uGBOkVeNmUztSaNFF6STrg7jRfE3rUm0=;
        b=WK4aEyI/YtS44tX8vHthdW3Fww/GmCHtbJDBAySEMheCM497hqEaM75d2RWI/qDgqW
         hCiIFV490vtmpdbA0Sqh5+cqVvVnTfQrDdmqT9uepQMvgWy/A8IMUXbQCK9TAm6VaETk
         n29XWzTouRL8peIbs8y/68KyL9PQvbyeskQTsQBBhlJPTxs2vOCllOLKUlTUJw9J2jSW
         u7/FwyC0OCWmwUWuq3mY69rEy1Txqc2dRFj69N/cGF2AKjElPGD8sEVQi1LZqopDfKm/
         WvzmuDd+DUlPg2W8pN4btvJA9xNZYIYQB+z0n6r14uY+NpcEEitHQJcEtXeSCVjq3svc
         vzTA==
X-Forwarded-Encrypted: i=1; AJvYcCWAE9TVmGfpwVgFjD+jbAnNdSiIn3FAtNniaOU0UfyTQQyFH481YYTECXhO1UmnbXd/4nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KMZCN2YoMxWLHI0jGg4VVn7fSuvpo+D7uetH/g67iuWS+MCo
	gcKlHbUU88oOI2X9KG3KCLdX0yHg5bi3tW0Zvmw102/aSuSemV/x6rHRRw==
X-Gm-Gg: ASbGncv/+GKOWnDBhPSUOoi1FOO+Ew+75G7rkRdFeOH4BIx/EMf79SdrXx5VMxyM53i
	0LGgHmcjMvWXMs+/wAagWA3Vyfp5B8fsLJL6ZhruiWRSZ9EG8Vxbdr4RgVCI6BrEWU4wGS2OAC/
	fYjRRaokCKW2zNzA+eZznxSw9RuxCa6J6pvLDh65w8h7tsE02Nk2nZ1bxmj5LHRW11zqABnrZBB
	P4dgoVgdFv4WjnHqDfjs2o4XdOd+5Pj6Xqy3nHy648HkeJps883rdfpxdIy6O11WXWIAEU=
X-Google-Smtp-Source: AGHT+IHBf1YfZHTyeFRdp/JzBer+aXj5Bc80G3HgsyoCvY9WGMV19e+wvDfjh/oKR/mCuWZNL+cICQ==
X-Received: by 2002:a5d:6d03:0:b0:382:4d54:2cde with SMTP id ffacd0b85a97d-38260bcb33emr5916787f8f.37.1732368298856;
        Sat, 23 Nov 2024 05:24:58 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb27386sm5275231f8f.51.2024.11.23.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:24:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 23 Nov 2024 14:24:56 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, yonghong.song@linux.dev,
	Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH dwarves v2 1/1] btf_encoder: handle .BTF_ids section
 endianness
Message-ID: <Z0HXqLswziDAjNrk@krava>
References: <20241122214431.292196-1-eddyz87@gmail.com>
 <20241122214431.292196-2-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122214431.292196-2-eddyz87@gmail.com>

On Fri, Nov 22, 2024 at 01:44:31PM -0800, Eduard Zingerman wrote:
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
> This commit resolves the issue by introducing an endianness conversion
> step for the .BTF_ids section data before the main processing stage.
> Since the ELF file is opened in O_RDONLY mode, gelf_xlatetom()
> cannot be used for endianness conversion.
> Instead, a new type is introduced:
> 
>   struct local_elf_data {
> 	void *d_buf;
> 	size_t d_size;
> 	int64_t d_off;
> 	bool owns_buf;
>   };
> 
> This structure is populated from the Elf_Data object representing
> the .BTF_ids section. When byte-swapping is required, a local copy
> of d_buf is created.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Jiri Olsa <olsajiri@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Vadim Fedorenko <vadfed@meta.com>
> Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  btf_encoder.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1adddf..06d4a61 100644
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
> @@ -145,6 +146,14 @@ struct btf_kfunc_set_range {
>  	uint64_t end;
>  };
>  
> +/* Like Elf_Data, but when there is a need to change the data read from ELF */
> +struct local_elf_data {
> +	void *d_buf;
> +	size_t d_size;
> +	int64_t d_off;
> +	bool owns_buf;
> +};
> +
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -1681,7 +1690,8 @@ out:
>  }
>  
>  /* Returns if `sym` points to a kfunc set */
> -static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, struct local_elf_data *idlist,
> +			    size_t idlist_addr)
>  {
>  	void *ptr = idlist->d_buf;
>  	struct btf_id_set8 *set;
> @@ -1847,13 +1857,52 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
>  	return 0;
>  }
>  
> +/* If byte order of 'elf' differs from current byte order, convert the data->d_buf.
> + * ELF file is opened in a readonly mode, so data->d_buf cannot be modified in place.
> + * Instead, allocate a new buffer if modification is necessary.
> + */
> +static int convert_idlist_endianness(Elf *elf, Elf_Data *src, struct local_elf_data *dst)
> +{
> +	int byteorder, i;
> +	char *elf_ident;
> +	uint32_t *tmp;
> +
> +	dst->d_size = src->d_size;
> +	dst->d_off = src->d_off;
> +	elf_ident = elf_getident(elf, NULL);
> +	if (elf_ident == NULL) {
> +		fprintf(stderr, "Cannot get ELF identification from header\n");
> +		return -EINVAL;
> +	}
> +	byteorder = elf_ident[EI_DATA];
> +	if ((BYTE_ORDER == LITTLE_ENDIAN && byteorder == ELFDATA2LSB)
> +	    || (BYTE_ORDER == BIG_ENDIAN && byteorder == ELFDATA2MSB)) {
> +		dst->d_buf = src->d_buf;
> +		dst->owns_buf = false;
> +		return 0;
> +	}
> +	tmp = malloc(src->d_size);
> +	if (tmp == NULL) {
> +		fprintf(stderr, "Cannot allocate %lu bytes of memory\n", src->d_size);
> +		return -ENOMEM;
> +	}
> +	memcpy(tmp, src->d_buf, src->d_size);
> +	dst->d_buf = tmp;
> +	dst->owns_buf = true;
> +
> +	/* .BTF_ids sections consist of u32 objects */
> +	for (i = 0; i < dst->d_size / sizeof(uint32_t); i++)
> +		tmp[i] = bswap_32(tmp[i]);
> +	return 0;
> +}
> +
>  static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  {
>  	const char *filename = encoder->source_filename;
>  	struct gobuffer btf_kfunc_ranges = {};
> +	struct local_elf_data idlist = {};
>  	struct gobuffer btf_funcs = {};
>  	Elf_Data *symbols = NULL;
> -	Elf_Data *idlist = NULL;
>  	Elf_Scn *symscn = NULL;
>  	int symbols_shndx = -1;
>  	size_t idlist_addr = 0;
> @@ -1918,7 +1967,9 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
>  			idlist_shndx = i;
>  			idlist_addr = shdr.sh_addr;
> -			idlist = data;
> +			err = convert_idlist_endianness(elf, data, &idlist);
> +			if (err < 0)
> +				goto out;
>  		}
>  	}
>  
> @@ -1960,7 +2011,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  			continue;
>  
>  		name = elf_strptr(elf, strtabidx, sym.st_name);
> -		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> +		if (!is_sym_kfunc_set(&sym, name, &idlist, idlist_addr))
>  			continue;
>  
>  		range.start = sym.st_value;
> @@ -2003,13 +2054,13 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  			if (ranges[j].start <= addr && addr < ranges[j].end) {
>  				found = true;
>  				off = addr - idlist_addr;
> -				if (off < 0 || off + sizeof(*pair) > idlist->d_size) {
> +				if (off < 0 || off + sizeof(*pair) > idlist.d_size) {
>  					fprintf(stderr, "%s: kfunc '%s' offset outside section '%s'\n",
>  						__func__, func, BTF_IDS_SECTION);
>  					free(func);
>  					goto out;
>  				}
> -				pair = idlist->d_buf + off;
> +				pair = idlist.d_buf + off;
>  				break;
>  			}
>  		}
> @@ -2031,6 +2082,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  out:
>  	__gobuffer__delete(&btf_funcs);
>  	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (idlist.owns_buf)
> +		free(idlist.d_buf);
>  	if (elf)
>  		elf_end(elf);
>  	if (fd != -1)
> -- 
> 2.47.0
> 

