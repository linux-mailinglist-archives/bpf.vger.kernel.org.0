Return-Path: <bpf+bounces-76489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21CCB73A2
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 22:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F49D301B2CA
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5002D2387;
	Thu, 11 Dec 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAxoqJhc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D923D2B4
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765489197; cv=none; b=J4TF9lK9ZBKp+i1VTvKZ9v7pc3JgJAKuDx1JnMRoy5fQwpeb72dR2Dingvplu5XgChKzk3WRzShUS44cjCCUnaBLiXJd2VpMNewwlhCL1SoRwYRC3DNfbrvhjSbUsqv35P6CONhcfzc0D93so1agWGIQGdqaZMRKUOkugNm1VhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765489197; c=relaxed/simple;
	bh=/RVJJDzJOp4GNotnViq/6E/cxvEjaLO4p1shqTwXrd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufQGVXzT1Jww2MjO3CIGOyW2ou1MQG3NwK6uRUJRW+YLYtx1KiUq3yQdMYOOd7kyuW2Nbe/GxeNO3tE5QIxQ/+zBi0F/6abGYqBuY4SyHTBUU9B2ZH9TGeZlPAiaZpDXFNG9Ow91L+0IFqTKQtNJbYW64G0hcB1A+zaEos8PzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAxoqJhc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so1067435a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765489194; x=1766093994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nulxyKhLi0q3F2cAdvKBi0oIQ0ZoqY4+94a3nz78jpM=;
        b=eAxoqJhc92VRZs5e6q3IN8Cweiax+loO1mweJOW17MBPX5A8Q10ZuoR+6bfrIkRZI/
         E83ASeBan/eptUZ/4jLmYukPr6NhvVLOX8yCbOJqriufy1UYPeKyhmpn1KdMbEDt/WV6
         rqLk+rYOWRfZQjahAw1VZI3i2R/QQWINNisja8LZr+RfqghxDCZW/SDzsY9RXEXy+MM2
         dRVwEFuLeYovkvkpMUu5YEPakGHvBm9Ec/+dMNra/w0D57gtvBF6s1f/VpdXefGiJEsl
         sTODbe1QYT9I/W5KFAsIhYapff5igNeHkmXFLau/ltZlRWigI0WAClmc6SEd+EmH4dnM
         yy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765489194; x=1766093994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nulxyKhLi0q3F2cAdvKBi0oIQ0ZoqY4+94a3nz78jpM=;
        b=meoCVdgMAsm7jozlaqR6ZkX7UzxJwxFCx3FOYWKuizHAF7wNkByBWSwakL2j+n2s4G
         GqZjjWa4hGbIlErWA1hmMk+R60jq9d2st9PPgPT+dF3QyWg3i8LdcrIT/SQkV11y0Edn
         6Vl49DYX0LZFbBXkX86z2XNTMJD4Q96wh1orHdsZ6Ka6rFEcxsbm647oVsfK8qE96IMS
         qu01jRBo7E9xWscLPujRoFBSrxTbnDuqZeyL1gP/rKVXXwq4CmwT/FIRMyKH1wuiKNw6
         SDGy8ErkOVJSn7NaWG7T/BJEeXQ3UXCVRqVcq9EDDNlsE1CLoWgY6OXgXJCk5E5+FGID
         O15Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr/cyEgz6PxwYUwzYOXeoj01/4PNdPy9JEYj3AF/xhZTGgrSnJ779Pp4YCvzzGJh++vVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO37MrqO5vb1SPcFjq08fUMEnVCLu/Sl9OIXNfujzBSXrfccWA
	hMvPMdY/An5aGiE3wow7up4KyLYL+vw4G5O8rqY3wqSbj4gh5ETxCeVFrbJLZxefMA==
X-Gm-Gg: AY/fxX6R5/Ny9Dnefpsr7iVrxqBFCjpWC+LL8MEO4V8Wmo7FzmTjdQ8B/+XjuAT3g8X
	gfz5wMom2uie9TJIA/yjFpUxNhKFBrRkDC82MdZpMZq8rrZzwX6IusdVISw1xjaU3JBWSNajwWG
	d9LkH1rEM8Pecyk9E742G0Sne28eEy6/MtkmvP4gKU5ckLz1xfONbb3eSmtW/Gp16xN38hocxOj
	uQNy+M6HhGDOeqnV6P6VTdb83jwbiQeUpN7E9N+hNogUZOXc0wUpzJ6pEtEGz3ntWOvRagUL1qf
	BfI8SHc1e68a2uGHl1ezTu34aVL/9xffXTiYWzuXWPqec192wRDAJb5ehguzOylwh0s5fobQTlo
	67vRBV6IX7v+v1ORO/OfYSB04zGlpyMfTM4MR5zUJGvRmmMnfcgfVUbyOIToJksstTRfW5Wotkq
	z3+1sQBoOmAn/c5Pqq9eBbtH4XV3J4ct7Et2b2wgRs2ViAP4kId/WvQZue
X-Google-Smtp-Source: AGHT+IFoprgc2wHgkxctt+o4eus03Z/uiMJ0uYkTEl2MoSVgay3z923THPBUPnaOp10mOb/gHi9+Hg==
X-Received: by 2002:a17:907:724e:b0:b7c:e320:5232 with SMTP id a640c23a62f3a-b7ce823236bmr839322666b.5.1765489193663;
        Thu, 11 Dec 2025 13:39:53 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa570174sm371812666b.55.2025.12.11.13.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 13:39:52 -0800 (PST)
Date: Thu, 11 Dec 2025 21:39:49 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Message-ID: <aTs6JTBrzEa0WJwd@google.com>
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com>
 <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
 <aS87V-zpo-ZHZzu0@google.com>
 <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
 <aS_5K_CJcB1rIEVj@google.com>
 <CAADnVQLf10J688CXFWg+=UaOv_zPTr3ViqNFcjbe5u4no2o_GA@mail.gmail.com>
 <aTlFKI2IeHQ2-TSE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTlFKI2IeHQ2-TSE@google.com>

On Wed, Dec 10, 2025 at 10:02:16AM +0000, Matt Bobrowski wrote:
> On Wed, Dec 03, 2025 at 10:23:43AM -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 3, 2025 at 12:47 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > >
> > > > We can play tricks with __weak. Like:
> > > >
> > > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > index 7cb6e8d4282c..60d269a85bf1 100644
> > > > --- a/kernel/bpf/bpf_lsm.c
> > > > +++ b/kernel/bpf/bpf_lsm.c
> > > > @@ -21,7 +21,7 @@
> > > >   * function where a BPF program can be attached.
> > > >   */
> > > >  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> > > > -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> > > > +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> > > >
> > > > diff kernel/bpf/bpf_lsm_proto.c
> > > >
> > > > +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> > > > +                     unsigned long prot, unsigned long flags)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > >
> > > > and above one with __nullable will be in vmlinux BTF.
> > > >
> > > > afaik __weak functions are not removed by linker when in non-LTO,
> > > > but it's still better than
> > > > +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> > > > No need to change bpf_lsm.h either.
> > >
> > > Annotating with a weak attribute would be quite nice, but the compiler
> > > will complain about the redefinition of the symbol
> > > bpf_lsm_mmap_file. To avoid this, we'd still need to rely on the
> > > rename and ignore dance by using the aforementioned define, which at
> > > that point would still result in both symbols being exposed in both
> > > BTF and the .text section.
> > 
> > Not quite. You missed this part in the above:
> > 
> > > > diff kernel/bpf/bpf_lsm_proto.c
> > 
> > it's a different file.
> 
> Yes, yes, this will work. However, as discussed, it's fundamentally
> reliant on a small "hack" which I've implemented within
> kernel/bpf/Makefile here [0] to workaround current pahole
> deduplication logic.
> 
> Andrii and Eduard,
> 
> I’d like your input on a pahole BTF generation issue which I've
> recently come across. In the series I just sent [0], I had to
> implement a workaround to force pahole to process bpf_lsm_proto.o
> before bpf_lsm.o.
> 
> This was necessary to ensure pahole generates BTF for the strong
> definition of bpf_lsm_mmap_file() (in bpf_lsm_proto.c) rather than the
> weak definition (in bpf_lsm.c). Without this forced ordering, pahole
> processed the weak definition first, resulting in a state array like
> this:
> 
> ```
> btf_encoder.func_states.array[N] = bpf_lsm_mmap_file (weak
> definition from bpf_lsm.o)
> 
> btf_encoder.func_states.array[N+1] = bpf_lsm_mmap_file (strong
> definition from bpf_lsm_proto.o)
> ```
> 
> Because the deduplication logic in btf_encoder__add_saved_funcs()
> folds duplicates (those determined by saved_functions_combine()) into
> the first occurrence, the resulting BTF was derived from the weak
> definition. This is incorrect, as the strong definition is the one
> actually linked into the final vmlinux image.
> 
> An obvious fix that immediately came to mind here was to essentially
> teach pahole about strong function prototype definitions, and prefer
> to emit BTF for those instead of any weak defined counterparts?

Thinking about this a little more. Perhaps whilst in
btf_encoder__add_saved_funcs() we should only emit BTF for any
duplicated function within a CU which happen to match the
corresponding entry within the backing ELF symtab? We can do this by
checking whether the virtual address stored within DW_AT_low_pc
matches that of what's stored in the st_value field for the
corresponding ELF symtab entry? For example, for bpf_lsm_mmap_file we
have:

Output from reading the vmlinux symbol table:
```
$ readelf -s <input> | grep bpf_lsm_mmap_file
165360: ffffffff8152f9b0    16 FUNC    GLOBAL DEFAULT    1 bpf_lsm_mmap_file
```
Output from reading the vmlinux DWARF debugging information:
```
<2a40982>   DW_AT_name        : (indirect string, offset: 0x1352ea): bpf_lsm_mmap_file
<2a40986>   DW_AT_decl_file   : 4
<2a40987>   DW_AT_decl_line   : 199
<2a40988>   DW_AT_decl_column : 1
<2a40989>   DW_AT_prototyped  : 1
<2a40989>   DW_AT_type        : <0x2a1b010>
<2a4098d>   DW_AT_low_pc      : 0xffffffff8152e260
<2a40995>   DW_AT_high_pc     : 0x10
<2a4099d>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
<2a4099f>   DW_AT_call_all_calls: 1
<2a4099f>   DW_AT_sibling     : <0x2a409d8>
<2><2a409a3>: Abbrev Number: 10 (DW_TAG_formal_parameter)
<2a409a4>   DW_AT_name        : (indirect string, offset: 0x3623df): file
<2a409a8>   DW_AT_decl_file   : 4
<2a409a9>   DW_AT_decl_line   : 199
<2a409aa>   DW_AT_decl_column : 1
<2a409aa>   DW_AT_type        : <0x2a234ef>
<2a409ae>   DW_AT_location    : 1 byte block: 55    (DW_OP_reg5 (rdi))
<2><2a409b0>: Abbrev Number: 10 (DW_TAG_formal_parameter)
<2a409b1>   DW_AT_name        : (indirect string, offset: 0x23a09d): reqprot
<2a409b5>   DW_AT_decl_file   : 4
--
<2a60e0a>   DW_AT_name        : (indirect string, offset: 0x1352ea): bpf_lsm_mmap_file
<2a60e0e>   DW_AT_decl_file   : 1
<2a60e0f>   DW_AT_decl_line   : 15
<2a60e10>   DW_AT_decl_column : 5
<2a60e11>   DW_AT_prototyped  : 1
<2a60e11>   DW_AT_type        : <0x2a42713>
<2a60e15>   DW_AT_low_pc      : 0xffffffff8152f9b0
<2a60e1d>   DW_AT_high_pc     : 0x10
<2a60e25>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
<2a60e27>   DW_AT_call_all_calls: 1
<2><2a60e27>: Abbrev Number: 82 (DW_TAG_formal_parameter)
<2a60e28>   DW_AT_name        : (indirect string, offset: 0x135ede): file__nullable
<2a60e2c>   DW_AT_decl_file   : 1
<2a60e2c>   DW_AT_decl_line   : 15
<2a60e2d>   DW_AT_decl_column : 36
<2a60e2e>   DW_AT_type        : <0x2a49f59>
<2a60e32>   DW_AT_location    : 1 byte block: 55    (DW_OP_reg5 (rdi))
```

> [0] https://lore.kernel.org/bpf/20251210090701.2753545-1-mattbobrowski@google.com/T/#me14d534fb559a349c46e094f18c63d477644d511

