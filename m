Return-Path: <bpf+bounces-61746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35416AEB3FC
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 12:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CE179DD3
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD554298CC6;
	Fri, 27 Jun 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAaw7NcE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86115298242
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019190; cv=none; b=fs4Zn6U3ddNFo8Nl8TC86s4ku7apj4WdCccPXOUhDcXzT72liwIZq689VvIXSmVPOcYiNi9p+RsHaxK+/8RuLPIRPNXzxCD7UK+7+EUlW18HoXqwYBRGeP+N6qPfAl3XEbS3EDtYphdBwuc6ZpbDtnSoIMmULoF1LgswfpVnbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019190; c=relaxed/simple;
	bh=Hpd/kW7T6bGjss/Xmqvmbivfhe9ZiiRcHwCSMeZsfQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asitaES2EKHtUPM6LwG6Y6PxJj5f4mi4m5gMJW69veXt/rqDEneh/QGbb3NYVbO+gg51i9BxS9rFRhFY2TgPs3vaOiazZRv4hVJbNyVajelwhWJEjK0nO4nElvMLFTHTYp4eSTeUVR6WFYf81HfG5cKRu8UY44myzbUY6ZkjyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAaw7NcE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1295602f8f.0
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751019187; x=1751623987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDPXbRqi/D9iEUw++nlDIYysdezswwHgXTJx1hzdFZ4=;
        b=BAaw7NcEWydrslPe6jfzsE8DfC4868b+Jj2QBwv61dHJR3kcfVlrkGejcQUAsfWDnS
         emgkcSQnAvUCd4rg8PBa7B1ciwvNjxXr82QpXleAtvxEe0MaA0t8lqvVoOBGan2iCzbi
         es5KetRdT2fWuH9lnuzfqT3MoKoci3ro9sQGKIlqIxv3Qtu7XjNkb//qYa78o4d2L9Mn
         2FZpQKhU3wEXo/urehTtITq2xBRg2V0OjUe5hm0723gcmCdLkcNV3KL+KlEposmbszpU
         Ji2+G0XL86UUguUlEIZbzescl2VCGt0X0DsL8NlumezSV8SK+QXla2O/A3mAoOJAg5Z4
         l5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019187; x=1751623987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDPXbRqi/D9iEUw++nlDIYysdezswwHgXTJx1hzdFZ4=;
        b=q8If5HtUwFQ3Xb2yzAwJBAoEVWBCMPYcTWD1DH9Z2ByaENXkp1N2SkffDh2rpLKW66
         Ek6cvgMuE8dNRJVidek+6exp6UBQN0weBd9IDzieNsTgcrvVtGJ+2KJawyLsq4Pl3Itd
         h5zEIM5lbTdSUkjntmiaSfttD0YtihQUSprq4AzBn09gPkteOS+peUbkcaibIAIk796y
         Eis4RR0Prn8YbCHrwlrntOMO+VFSXkVALF2GqCScd+HQIMaPgSOKB1QIrxC61QGEeAfu
         VpYu2gXmNc2lK2AVHV72VuLZ7ZkYDnVrQGpLMVrJ52eaW7Ezucy6mNIiTkV3drMzVWEX
         nRSQ==
X-Gm-Message-State: AOJu0YwrjHy9u/7AzypMeJ5jzthP5JoD54yPyro51Tf+sfFp3RNS174T
	hEnzRU+0iyQy1LLrbTwFjlhMOmIoF5PXy3JPlrkHllmYa5Rz6r4i5mNZ
X-Gm-Gg: ASbGncs5SXFwCR4VLuF1vYATlDZYOExe4Ka9PdgtPWdZP+J3vnlNyljwgXYknknOjV6
	3fYOcbIymX0RcniHZyGophtLt1rWNSsj7/ZyQDDwwUeQkMoPPuYyFgx0j1UAsjywsKJLW9ZCzND
	zEnK1rBLKpAP/OxJtsr8UTqb5k8a6XZJqfrEqjZLAkqFqy6CYVbvUTJGoJevcbuW5xaVYHwgOHE
	IXVGaO3EDS9cRqSoOXxDozPvLQ3jPmCUdWgg6wZ4TD92GATIQPy4vNCkmsO3Zyw0Q7/QY7y8dIj
	7m8Pdpard7oS+b5SODkfYeFADcKO+lAJFQpWINvC0YC/rnKvKw+ohBxO+eFtyPPHZj5NnF45Vg=
	=
X-Google-Smtp-Source: AGHT+IE0+gKae78S2t+qbSCEGn4Z0DJu3A/Ld8B+alTbzlMGNYTdfHbTkgVZhV7oeb0VViEyduDikQ==
X-Received: by 2002:a05:6000:2d82:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a6f312dca2mr4127309f8f.16.1751019186701;
        Fri, 27 Jun 2025 03:13:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3b2fd7sm46764125e9.17.2025.06.27.03.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:13:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:18:25 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Message-ID: <aF5v8Yw5LUgVDgjB@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>

On 25/06/26 07:28PM, Eduard Zingerman wrote:
> On Wed, 2025-06-18 at 12:49 -0700, Eduard Zingerman wrote:
> > On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> > 
> > [...]
> > 
> > > @@ -698,6 +712,14 @@ struct bpf_object {
> > >  	bool has_subcalls;
> > >  	bool has_rodata;
> > >  
> > > +	const void *rodata;
> > > +	size_t rodata_size;
> > > +	int rodata_map_fd;
> > 
> > This is sort-of strange, that jump table metadata resides in one
> > section, while jump section itself is in .rodata. Wouldn't it be
> > simpler make LLVM emit all jump tables info in one section?
> > Also note that Elf_Sym has name, section index, value and size,
> > hence symbols defined for jump table section can encode jump tables.
> > E.g. the following implementation seems more intuitive:
> > 
> >   .jumptables
> >     <subprog-rel-off-0>
> >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> >     <subprog-rel-off-2> |        .size = 2   // number of entries in the jump table
> >     ...                          .value = 1  // offset within .jumptables
> >     <subprog-rel-off-N>                          ^
> >                                                  |
> >   .text                                          |
> >     ...                                          |
> >     <insn-N>     <------ relocation referencing -'
> >     ...                  jump table #1 symbol
> 
> Anton, Yonghong,
> 
> I talked to Alexei about this yesterday and we agreed that the above
> arrangement (separate jump tables section, separate symbols for each
> individual jump table) makes sense on two counts:
> - there is no need for jump table to occupy space in .rodata at
>   runtime, actual offsets are read from map object;
> - it simplifies processing on libbpf side, as there is no need to
>   visit both .rodata and jump table size sections.
> 
> Wdyt?

Yes, this seems more straightforward. Also this will look ~ the same
for used-defined (= non-llvm-generated) jump tables.

Yonghong, what do you think, are there any problems with this?
Also, how complex this would be to directly link a gotox instruction
to a particular jump table? (For a switch, for "user-defined" jump
tables this is obviously easy to do.)

> > > +
> > > +	/* Jump Tables */
> > > +	struct jt **jt;
> > > +	size_t jt_cnt;
> > > +
> > >  	struct bpf_gen *gen_loader;
> > >  
> > >  	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
> > 
> > [...]

