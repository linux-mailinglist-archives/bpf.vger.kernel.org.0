Return-Path: <bpf+bounces-77468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233FCE6601
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6339C3006A50
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416F287505;
	Mon, 29 Dec 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQj5RDjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF199227563
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004412; cv=none; b=JqBkH25R1fK3aXePdhVVXN4t9qDwRCgZTKsDjFCuejit6fZVooj2/o3wpaan3wR+j/2k1PN1VUbojlAEtZT28zRc+9sNjp8A/TeR6cvr9lVtt6unRtsLcqUiiFP5R+seUbE9h/aI9E+pU1GKuYU0tQvQUPVTXv4fOrqDPJVctJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004412; c=relaxed/simple;
	bh=tw7qHS6ynAvk0WQj4bVk4Xa7ZlXGFtdkJxH2JYwNDS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swm29hcXHlfSvurq4ckVfcXWmtZnDF2BJuGdOM9hf52JHmNapK7ku0iM+a5+w7SK2EFmhiSYpdBVAvYVyizfV/qrwq8c5RtwCmQM/Kk81Ab37xS6GekX3ILvO/PZncpZRAoFwb0siga7NddAgokBuoLenAjQErmR847558mWBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQj5RDjP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso10177668a12.2
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 02:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767004409; x=1767609209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yXpw1r1gk8LR9kaQgc29s/mYhGdSjSpQbwxaTaLmvBI=;
        b=MQj5RDjPJaXhmK5Hs/ZRT/G6vvzR6bu7Bz9S2wjfiHXk0smd4WCyJEo/Mgq2liioaf
         UV01pgXhpa2dYVkRHs/XcQC0+xdcHtPLNEgccBg5oTtGCDj+ZPnltZMbYVj8gsxmdQuK
         UKqzF8CtD0Kq5Gy57JDSAWDjpGxWxK0K9yAb06WtXtlcoAkvB0yFZ8tWiAXbTNOqy4Z6
         xEezGb3pPITs8KA4W3aNd8FEVggsQheiFq3aMCOGN15BgNe9VRGUQ6ezubvqtt2hJLHp
         8oJjDe4LyaULJR8O4EX0xnqZjUUHURa4diK0fxTxqmjuQAJ+OoEdge5xFdRcxnGlan5y
         4pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004409; x=1767609209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXpw1r1gk8LR9kaQgc29s/mYhGdSjSpQbwxaTaLmvBI=;
        b=J6GGmI+W2/padSYlj45z4NDdIKAXnovkQbtguSO1+5x0Wm/NDINlNurCXyMWvGV7Iv
         5T899K43Hgw0Gl1Frc0wKwHGBG4D9BFcxqpzLi35Fd6gVPNIEvXFjWvvOE3/px+etE3I
         e60DFzgxaExXZaZwSqknqKW8eqJNavdE9GEynW+31a2c6fsywWTMEe/WICChw4vuLYm+
         7XngVheVPxE/+g6vmvKOgZT7Jp03dpHp+19OQb2efF6pX8LaKQWax0recNP4xxkfEZY2
         C7eVVhBxLcubi+MJBzTcBnV807EC7iQ9aIzNKw3v9wuL65G1hxYYzegkgmqOvwSQ1TLh
         l24Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHPcLUpHHnS/YrZXLzOwNa/zj4pHzE7uDywI16E3q7JICzxIewHhoZtHjvQTewVA4pVM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdfx8RLlu3RLVDvT83tEsHNgW2/eJ3kWjzkOGPItTdTCSP2Osx
	/B8jc3VHghRAD5NoJidbxEJq3bONn7t3jei1+2zx5jp84SnEtQbxmnHtdRjn2nExxg==
X-Gm-Gg: AY/fxX5MjfiK5qOpcbMx5tQ8stspbZZnfGM+qQR5EdjnhVpM4TBRDz6uYVxsdwePh0l
	P6tATBzMRxUXZZFNznDPfwiXLrhZCo8up3SrFuV8U0Uf+taqkV8SG6mLuscRV25u1RQYP0jd3Fc
	DW9r1wwEp8gR0q97n80o3H6gus5Pi06zj5Jt0Z8b0LZo7Sp5YmgKjwmPyN4UEwLhh3wVBPfxRNw
	zEa01tvyp+zy1V/bVDdPqSwmuptQ8Vw1FfvhPba6M64MO4yYNBWTd0BEuJeDFAaTUxYIDQdpGBh
	9MOHo6zCJiOwXQ9Tded+buWK2R+cq3hVMGkfKml1X8fPyGZe3nhOWz9KjaNQ23exgHXXfDt5TKv
	1Xn/Ec3yI9erIljpwO/nbb4WAFBo+X9WMpU6URlrjIsigl3WxsG7uEGRezfo2AZJSrPABW3LJkn
	PU7i559TjFhNwNbHkkHijeAFfi27r+hqKYMxHSAbt5lJ8h+2c6Bn0dWw==
X-Google-Smtp-Source: AGHT+IGA7G94RUBb4sVvjTDgCryTxzGJb9fAwpKLVFD2XUyy+huUtD5YbmxE7EckOoldGmBC0NobUw==
X-Received: by 2002:a17:907:720f:b0:b73:8639:cd96 with SMTP id a640c23a62f3a-b8036f3a367mr3043928366b.24.1767004408739;
        Mon, 29 Dec 2025 02:33:28 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f18575sm3219427866b.54.2025.12.29.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:33:28 -0800 (PST)
Date: Mon, 29 Dec 2025 10:33:24 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	=?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Message-ID: <aVJY9H-e83T7ivT4@google.com>
References: <aS7BvzTJ-2Xo7ncq@google.com>
 <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
 <aS87V-zpo-ZHZzu0@google.com>
 <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
 <aS_5K_CJcB1rIEVj@google.com>
 <CAADnVQLf10J688CXFWg+=UaOv_zPTr3ViqNFcjbe5u4no2o_GA@mail.gmail.com>
 <aTlFKI2IeHQ2-TSE@google.com>
 <aTs6JTBrzEa0WJwd@google.com>
 <9e402939-40ea-4da2-aad1-43d2afb74a83@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e402939-40ea-4da2-aad1-43d2afb74a83@linux.dev>

On Thu, Dec 18, 2025 at 02:51:27PM -0800, Yonghong Song wrote:
> 
> 
> On 12/11/25 1:39 PM, Matt Bobrowski wrote:
> > On Wed, Dec 10, 2025 at 10:02:16AM +0000, Matt Bobrowski wrote:
> > > On Wed, Dec 03, 2025 at 10:23:43AM -0800, Alexei Starovoitov wrote:
> > > > On Wed, Dec 3, 2025 at 12:47 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > > > > We can play tricks with __weak. Like:
> > > > > > 
> > > > > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > > > index 7cb6e8d4282c..60d269a85bf1 100644
> > > > > > --- a/kernel/bpf/bpf_lsm.c
> > > > > > +++ b/kernel/bpf/bpf_lsm.c
> > > > > > @@ -21,7 +21,7 @@
> > > > > >    * function where a BPF program can be attached.
> > > > > >    */
> > > > > >   #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> > > > > > -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> > > > > > +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> > > > > > 
> > > > > > diff kernel/bpf/bpf_lsm_proto.c
> > > > > > 
> > > > > > +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> > > > > > +                     unsigned long prot, unsigned long flags)
> > > > > > +{
> > > > > > +       return 0;
> > > > > > +}
> > > > > > 
> > > > > > and above one with __nullable will be in vmlinux BTF.
> > > > > > 
> > > > > > afaik __weak functions are not removed by linker when in non-LTO,
> > > > > > but it's still better than
> > > > > > +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> > > > > > No need to change bpf_lsm.h either.
> > > > > Annotating with a weak attribute would be quite nice, but the compiler
> > > > > will complain about the redefinition of the symbol
> > > > > bpf_lsm_mmap_file. To avoid this, we'd still need to rely on the
> > > > > rename and ignore dance by using the aforementioned define, which at
> > > > > that point would still result in both symbols being exposed in both
> > > > > BTF and the .text section.
> > > > Not quite. You missed this part in the above:
> > > > 
> > > > > > diff kernel/bpf/bpf_lsm_proto.c
> > > > it's a different file.
> > > Yes, yes, this will work. However, as discussed, it's fundamentally
> > > reliant on a small "hack" which I've implemented within
> > > kernel/bpf/Makefile here [0] to workaround current pahole
> > > deduplication logic.
> > > 
> > > Andrii and Eduard,
> > > 
> > > I’d like your input on a pahole BTF generation issue which I've
> > > recently come across. In the series I just sent [0], I had to
> > > implement a workaround to force pahole to process bpf_lsm_proto.o
> > > before bpf_lsm.o.
> > > 
> > > This was necessary to ensure pahole generates BTF for the strong
> > > definition of bpf_lsm_mmap_file() (in bpf_lsm_proto.c) rather than the
> > > weak definition (in bpf_lsm.c). Without this forced ordering, pahole
> > > processed the weak definition first, resulting in a state array like
> > > this:
> > > 
> > > ```
> > > btf_encoder.func_states.array[N] = bpf_lsm_mmap_file (weak
> > > definition from bpf_lsm.o)
> > > 
> > > btf_encoder.func_states.array[N+1] = bpf_lsm_mmap_file (strong
> > > definition from bpf_lsm_proto.o)
> > > ```
> > > 
> > > Because the deduplication logic in btf_encoder__add_saved_funcs()
> > > folds duplicates (those determined by saved_functions_combine()) into
> > > the first occurrence, the resulting BTF was derived from the weak
> > > definition. This is incorrect, as the strong definition is the one
> > > actually linked into the final vmlinux image.
> > > 
> > > An obvious fix that immediately came to mind here was to essentially
> > > teach pahole about strong function prototype definitions, and prefer
> > > to emit BTF for those instead of any weak defined counterparts?
> > Thinking about this a little more. Perhaps whilst in
> > btf_encoder__add_saved_funcs() we should only emit BTF for any
> > duplicated function within a CU which happen to match the
> > corresponding entry within the backing ELF symtab? We can do this by
> > checking whether the virtual address stored within DW_AT_low_pc
> > matches that of what's stored in the st_value field for the
> > corresponding ELF symtab entry? For example, for bpf_lsm_mmap_file we
> 
> I think this is the correct way to do it. Basically we should
> pick the dwarf subprogram entry whose DW_AT_low_pc should match
> same-name same-low_pc ksym entry.

Yes, this exactly what I'm thinking. I'll send out a patch that makes
this amendment.

> > Output from reading the vmlinux symbol table:
> > ```
> > $ readelf -s <input> | grep bpf_lsm_mmap_file
> > 165360: ffffffff8152f9b0    16 FUNC    GLOBAL DEFAULT    1 bpf_lsm_mmap_file
> > ```
> > Output from reading the vmlinux DWARF debugging information:
> > ```
> > <2a40982>   DW_AT_name        : (indirect string, offset: 0x1352ea): bpf_lsm_mmap_file
> > <2a40986>   DW_AT_decl_file   : 4
> > <2a40987>   DW_AT_decl_line   : 199
> > <2a40988>   DW_AT_decl_column : 1
> > <2a40989>   DW_AT_prototyped  : 1
> > <2a40989>   DW_AT_type        : <0x2a1b010>
> > <2a4098d>   DW_AT_low_pc      : 0xffffffff8152e260
> > <2a40995>   DW_AT_high_pc     : 0x10
> > <2a4099d>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
> > <2a4099f>   DW_AT_call_all_calls: 1
> > <2a4099f>   DW_AT_sibling     : <0x2a409d8>
> > <2><2a409a3>: Abbrev Number: 10 (DW_TAG_formal_parameter)
> > <2a409a4>   DW_AT_name        : (indirect string, offset: 0x3623df): file
> > <2a409a8>   DW_AT_decl_file   : 4
> > <2a409a9>   DW_AT_decl_line   : 199
> > <2a409aa>   DW_AT_decl_column : 1
> > <2a409aa>   DW_AT_type        : <0x2a234ef>
> > <2a409ae>   DW_AT_location    : 1 byte block: 55    (DW_OP_reg5 (rdi))
> > <2><2a409b0>: Abbrev Number: 10 (DW_TAG_formal_parameter)
> > <2a409b1>   DW_AT_name        : (indirect string, offset: 0x23a09d): reqprot
> > <2a409b5>   DW_AT_decl_file   : 4
> > --
> > <2a60e0a>   DW_AT_name        : (indirect string, offset: 0x1352ea): bpf_lsm_mmap_file
> > <2a60e0e>   DW_AT_decl_file   : 1
> > <2a60e0f>   DW_AT_decl_line   : 15
> > <2a60e10>   DW_AT_decl_column : 5
> > <2a60e11>   DW_AT_prototyped  : 1
> > <2a60e11>   DW_AT_type        : <0x2a42713>
> > <2a60e15>   DW_AT_low_pc      : 0xffffffff8152f9b0
> > <2a60e1d>   DW_AT_high_pc     : 0x10
> > <2a60e25>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
> > <2a60e27>   DW_AT_call_all_calls: 1
> > <2><2a60e27>: Abbrev Number: 82 (DW_TAG_formal_parameter)
> > <2a60e28>   DW_AT_name        : (indirect string, offset: 0x135ede): file__nullable
> > <2a60e2c>   DW_AT_decl_file   : 1
> > <2a60e2c>   DW_AT_decl_line   : 15
> > <2a60e2d>   DW_AT_decl_column : 36
> > <2a60e2e>   DW_AT_type        : <0x2a49f59>
> > <2a60e32>   DW_AT_location    : 1 byte block: 55    (DW_OP_reg5 (rdi))
> > ```
> > 
> > > [0] https://lore.kernel.org/bpf/20251210090701.2753545-1-mattbobrowski@google.com/T/#me14d534fb559a349c46e094f18c63d477644d511
> 

