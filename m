Return-Path: <bpf+bounces-45711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0FC9DA7FD
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49575B21765
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F631FC7E5;
	Wed, 27 Nov 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJOPbS9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09E1FC118;
	Wed, 27 Nov 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710930; cv=none; b=rD6hBtSHCx6yuh/hfJ1wtLf6jhscgi39lOmqu85Sl35opxJt8t0rLCKYOfmuPG1eC3eh42oLREcTdk1i3Zp0zRBF9qwgTX3mc7CkEq6CBDFJmrgn7KlRjn3YCEg1HJO0U1IyZwfkyBuSWaQstodWQoe2tLQ68EejLnG0XJhN8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710930; c=relaxed/simple;
	bh=JCruzxJQcHFn58dzlxpPtK9xqqWhHBkGIsbynbD3frM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poyW0bseXqpCEDHFg8EfJMmBOGJFNxKDvdaA0mbFuFcuZRKkW3Gb9DpiuA0KXAX3LNQJO16QBVLKdDJb2KJxbKxlswLXKSe94bUuTkMrbsImOSCoY5+BrsWpeKc70ovuMNZje0rZWZUKTSf1xul7eriiebSMFTOSUkXB2td8CnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJOPbS9E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a2033562so22773875e9.1;
        Wed, 27 Nov 2024 04:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732710927; x=1733315727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVqFD2qlbgxa7zjbWjVe9YXyPQ7C74Polpf8ZerrY+Q=;
        b=CJOPbS9ErX72X82+/pHJyT4hKWTJlrHX5jlyhzvZ3iQShYDnREqEgSzQbBf9yzZLSg
         XZB8nNO+cPQxuyXkAqTwdXNfH+Y0/DxHHiI0ACuGi40ToA1zFw3rZPfUm+w3HOenXe4/
         62BGrrFicUd1N2ZM2gMqwSNKJFkznv/dbhyJJy/bELZXK7ddrijbjfGbJu/xhSHr/5WC
         C/gVioUsYxMxSG5dRAKOA8LWr2EjV5wO4n9JqIzGPZ2LbJ01+FoIS8sx5xWla6AcrUCh
         KYlXsyVyp/YaWxvF2cZBoDwJebacweJ7aSRbaS89FfepU53Q/r0ILOfLD0a+M6/bSAnG
         Z8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710927; x=1733315727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVqFD2qlbgxa7zjbWjVe9YXyPQ7C74Polpf8ZerrY+Q=;
        b=ixcOL5Yi+TP9wu2fCYLgeE6jdHv63pUqVoNk5G7h1VpmMqSvj5QFFxi6pN9Qx7AX9r
         ga89N2t/rBlk1BO7rFA1Q8wz0vPE1+bxXavXsfSys1B9RQTcFYWemsGioPD8dBNzwM25
         C+OYko5K5LJOtKfSeWpJkxBjGw0ckCBZ9kSJhkaAE1yZr/R3aEHXabeBVHboKinjmygY
         FRvzz4jTcVg7tNOgRb90ksA2aVUAG+3Uufmmw+tqDWkqyjK64S4bgpTmYX167iNrRqVU
         qMAIFLRR9FiQ0MnvCHHmr4y4GYayWc3mYxNF95nSwYTvczBat4PxrSuBAlyCUUUom8J4
         716w==
X-Forwarded-Encrypted: i=1; AJvYcCXmgPPuVphDsLkS6f0ukYj55xUoCbyxl2jfUJ19LsCJn8rNF4UFXSLDSucCcbHdQyvOgC0/b6GQiA==@vger.kernel.org, AJvYcCXnEQkAwfQ6l44MWOWeZ0zOcjep4hmyPkVhX6lvvZl2SzVXOq7n0YEtFuZMrldB8OoUbbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWW911Yv6ImIM0OisVLmEuL2p5HlbIoOyvTlW/YKBKEjXK0V11
	GHYYGq7mTSzyhc1fPnh3mWY9HQJiR5a5S305+3nNoZeWTOa5J5rE
X-Gm-Gg: ASbGncuAAQl2ueAZKP7pHdECz9gdZ+d9Oix24G6fe1YQKe42ilAZKpZ4nuEqrOV3+HQ
	ZapzszwbADKyejUpV/SGxcolNy3bJrZl10cxeZwWpntYb8IyDF2xJCTMCPTr3oeUNkNBcUZ0msB
	DNUGcOPuuBQYgAPfAUJBOpp1xJbZ1gc5h9jD+bNb065u83O3+Lzu1ksdYmm7CgiT4cM+eXCubYB
	wsYGDMicnvy7byZa0BZLwDhxfzq6xb3olyGRh8IWAZ0acRl0WptUaaarI2d+/dQ5B9F04YXLuRI
	9xovaunCUX61KI8su1R351Q=
X-Google-Smtp-Source: AGHT+IFRs80rR0ESjWxGxHhi5gIt7TNyvi9oRYWf05rIKr2lXDTDSHuX/5FrIdL/aVqxBfz/yuMEFA==
X-Received: by 2002:a05:600c:3146:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-434a9dbbc0bmr21886165e9.1.1732710926916;
        Wed, 27 Nov 2024 04:35:26 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7b84e2sm19705035e9.14.2024.11.27.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:35:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Nov 2024 13:35:24 +0100
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
	dwarves@vger.kernel.org, arnaldo.melo@gmail.com,
	bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
	Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
Message-ID: <Z0cSDOtxLeqxbuzM@krava>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
 <20241127015006.2013050-2-eddyz87@gmail.com>
 <Z0b7zLfaoodeWF6J@krava>
 <6187706f-5c7f-4c22-9854-b3225b841385@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6187706f-5c7f-4c22-9854-b3225b841385@linux.dev>

On Wed, Nov 27, 2024 at 12:03:59PM +0000, Vadim Fedorenko wrote:
> On 27/11/2024 11:00, Jiri Olsa wrote:
> > On Tue, Nov 26, 2024 at 05:50:06PM -0800, Eduard Zingerman wrote:
> > > btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> > > kfuncs present in the ELF file being processed.
> > > This section consists of:
> > > - arrays of uint32_t elements;
> > > - arrays of records with the following structure:
> > >    struct btf_id_and_flag {
> > >        uint32_t id;
> > >        uint32_t flags;
> > >    };
> > > 
> > > When endianness of a binary operated by pahole differs from the host
> > > system's endianness, these fields require byte-swapping before use.
> > > Currently, this byte-swapping does not occur, resulting in kfuncs not
> > > being marked with declaration tags.
> > > 
> > > This commit resolves the issue by using elf_getdata_rawchunk()
> > > function to read .BTF_ids section data. When called with ELF_T_WORD as
> > > 'type' parameter it does necessary byte order conversion
> > > (only if host and elf endianness do not match).
> > > 
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Daniel Xu <dxu@dxuuu.xyz>
> > > Cc: Jiri Olsa <olsajiri@gmail.com>
> > > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > Cc: Vadim Fedorenko <vadfed@meta.com>
> > > Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >   btf_encoder.c | 26 ++++++++++++++++++++------
> > >   1 file changed, 20 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index e1adddf..3754884 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -1904,18 +1904,32 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> > >   			goto out;
> > >   		}
> > > -		data = elf_getdata(scn, 0);
> > > -		if (!data) {
> > > -			elf_error("Failed to get ELF section(%d) data", i);
> > > -			goto out;
> > > -		}
> > > -
> > >   		if (shdr.sh_type == SHT_SYMTAB) {
> > > +			data = elf_getdata(scn, 0);
> > > +			if (!data) {
> > > +				elf_error("Failed to get ELF section(%d) data", i);
> > > +				goto out;
> > > +			}
> > > +
> > >   			symbols_shndx = i;
> > >   			symscn = scn;
> > >   			symbols = data;
> > >   			strtabidx = shdr.sh_link;
> > >   		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> > > +			/* .BTF_ids section consists of uint32_t elements,
> > > +			 * and thus might need byte order conversion.
> > > +			 * However, it has type PROGBITS, hence elf_getdata()
> > > +			 * won't automatically do the conversion.
> > > +			 * Use elf_getdata_rawchunk() instead,
> > > +			 * ELF_T_WORD tells it to do the necessary conversion.
> > > +			 */
> > > +			data = elf_getdata_rawchunk(elf, shdr.sh_offset, shdr.sh_size, ELF_T_WORD);
> > 
> > looks good, I'm just curious about one thing..
> > 
> > so ELF_T_WORD enum has this comment: /* Elf32_Word, Elf64_Word, ... */
> > 
> > I did just quick check, ***so I might be easily wrong***, but I wonder the
> > code in __elf_xfctstom (which I assume is the one called for conversion)
> > chooses to swap 32/64 bits values based on elf->class .. so for 64bit ELF
> > class we swap 64bit values? ... while .BTF_ids has always 32 bit values
> 
> Well according to the doc:
> 
>        ELF_T_WORD     Unsigned 32-bit words.
>        ELF_T_XWORD    Unsigned 64-bit words.
> 
> It shouldn't use 64 bits swap:
> 
> const xfct_t __elf_xfctstom[EV_NUM - 1][EV_NUM - 1][ELFCLASSNUM -
> 1][ELF_T_NUM] =
> ....
> 	[ELF_T_WORD]	= ElfW2(Bits, cvt_Word),			
> 	[ELF_T_XWORD]	= ElfW2(Bits, cvt_Xword),			
> ...
> 
> Are you looking somewhere else?

nah I guess I got confused with Elf64_Word, which is still 32bits,
seems fine, sorry for noise 

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

