Return-Path: <bpf+bounces-57708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33184AAED2C
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93159174FE7
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4628F93B;
	Wed,  7 May 2025 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEkaPqyD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADF1DE3DB;
	Wed,  7 May 2025 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650369; cv=none; b=OzI0HVgm2pnJJIGsc1qG9dgHhHegJsG0U57hSsYNjife++579TlWSxx6UTjJodARLgP4RwYDizVWmzgMdi610u2L719ULjDiRT0EoOXO+SV+ll+O/FWMLr8ai+Pef76gENS/PGzZ6KViUkcdpMIgTlMZtvVSfDEVRculEeOZDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650369; c=relaxed/simple;
	bh=mY2Xtf7zPtWs6nmBWknXish015HkOYwHrYDInCSWNR4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nThRmGo1JibwJDOSm0YTpi8lfWWI++CvL/NUOKnrHOusQGNAC4m3XsYr/HQyiVTGg9prAGSpvOK0+xxdiZhFu4QwCnuKcZyqYQu6ruY4BsMxWA0jdmAz5CdASOxY68ZoNFMlgI2YzV4x1tOTKy6oerbbD7IAdttM2Ahyay4/GAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEkaPqyD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso234434a12.2;
        Wed, 07 May 2025 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650367; x=1747255167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tM+64rIJ5rw3/ntvb2fmAVZVKDJkPi5kBpHLka6XskQ=;
        b=VEkaPqyDqHmEk60zP9OhdvnquulGYbkQIuwn8Y5Q7re3sol1tLqz++MOE90O+G+6sx
         cBYhL+wsoARXobYedQyia3BBa44+FzZujiSQENwI8rg2DhVrBenAGjJZjRtnO7red8Kg
         jpij8RwMb1dl7oZJb3O1xIZeEBeev/tIhz6UdDvlO8lWW78IIZmM+G7SZxVf1t816CgI
         Me1tmxnqlUOBaxKQSGr5oGJNVoWAUYWxPd8xhfFS/Cz+LIN5+zwaQJvEsaA0qfUjE1VT
         AjT663Zy98/cxpJgUvPqvscRoAJLnQgp7HySPGCHN32c1KtB7yzzbVJsKSqW8I/73X+x
         TsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650367; x=1747255167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tM+64rIJ5rw3/ntvb2fmAVZVKDJkPi5kBpHLka6XskQ=;
        b=iaqiu7Q2HSSp3sCKI1j4MLfie+UVxdSSma9c3XwEfVg3GbjOg+DVy8Zk0i3xWYFawN
         AIY2YYo4qmMYCqoHq8Ukej9Cgg1QLHOGy9Zn4ZYs4ECVziQDACAnJUAfQcyTbsn+jJcq
         DSz+NYuaNXpWBN/82BQSmf4XawfAOODxjHebYrxG7xQkJoe+G6KOOkGPdLW84N9p7zt+
         JcdPSuq4jVDXDvqXRstnRyRgMfm0fnsTQjsFbn6vJtT3i99E0FYYCldSXHeXjObb+LvI
         RPnEiyjAmWlkNvOTfG/mKRML1JfJvEYsD0xa1PnLgP7B62TCs+aYvEtnZppMM3c8zSj0
         qK5A==
X-Forwarded-Encrypted: i=1; AJvYcCW7GE9KqlWV0TcoLyDhHDUDJ+Ff9H6xzNbOyo5eInb0n7OwB3qcy/8u5myXAHwrRZxqSjY=@vger.kernel.org, AJvYcCXgMBQUTb8QMhhl4LaHIZLWnDmZvDJehaWIFkKljS1mt3T7nHyz9NUaHgGl2VNnrZGYEquj/QrOQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh37cFowqiuvH73j+6QDVwNohH7b0KITWBEvAdQeQRKaiX3B6t
	LmQ8eZaRtgbG03MKnmqpL5m0JS782MzCDeAVBWpE+LtvtK+j6pYf
X-Gm-Gg: ASbGncuNQdrzESEFT2hlDAnfiN01kJtzZGl6gBU+QiMSe+sXAdsP0xxDNZGOR28ujBV
	7PRWR0qtpxPDsm+6ClIJxwkoAetHYWOQqF+3y/Vk3yBEv0TNulvpK3KUp78SdjGsR/jZschIteH
	XQ6S+v8w1pPTACLvz8B0pu/62J1yusz1OqXkGujyIUgU7Heqas3YG3za4cEi6OJxw3/TzQnu8wd
	6cCBWLIpC6jh0BtgfH0uXOXsg3IA+5NQUswTPpdqn/obfCicMK3wdLu5CIFP/YXZoIPKeBF7WZh
	acZUrJgB6XFv4b+JGftdhykG8bt7lBcSAKuDJDApEuSBZhoOd54X5WnQqUda0ARn2EzrIP1sHG3
	dte0q/ao=
X-Google-Smtp-Source: AGHT+IH0G8c5LWoKUaMtkHNqa51ZaNgPIouUlLtIdZ8B/LQmzI/E8DtkV+/kbrLVCxvE0N79/0LpXA==
X-Received: by 2002:a17:90b:3e83:b0:2ff:53a4:74f0 with SMTP id 98e67ed59e1d1-30aac2b481bmr7029331a91.29.1746650367186;
        Wed, 07 May 2025 13:39:27 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4b42a14sm712110a91.18.2025.05.07.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:39:26 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 7 May 2025 13:39:23 -0700
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org
Subject: Re: Pahole/BTF issue with __int128
Message-ID: <aBvE++cyskZTfAo5@kodidev-ubuntu>
References: <D9Q73OTLEOU4.LNAO9K4POETM@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9Q73OTLEOU4.LNAO9K4POETM@bootlin.com>

On Wed, May 07, 2025 at 10:02:51PM +0200, Alexis Lothoré wrote:
> Hello,
> 
> I am working on some ebpf feature for ARM64 (improving trampolines to
> attach tracing programs to functions with more arguments than the current
> limit), and I am facing an issue with the generated BTF information when
> playing with large int types like __int128 (I need to use those large types
> to properly test some architecture-specific alignment expectations). I
> suspect the issue to be in pahole, but I would like to get some opinions on
> my observations, and maybe some guidance on where to look at to go further.
> 
> I would like to attach some fentry/fexit programs to the following kind of
> function, which is currently defined in a kernel module (bpf_testmod.ko in
> bpf selftests):
> 
>   struct bpf_testmod_struct_arg_7 {
>   	_int128 a;
>   };
>   
>   noinline int bpf_testmod_test_struct_arg_11(
>   	struct bpf_testmod_struct_arg_7 a,
>   	struct bpf_testmod_struct_arg_7 b,
>   	struct bpf_testmod_struct_arg_7 c,
>   	struct bpf_testmod_struct_arg_7 d,
>   	short e,
>   	struct bpf_testmod_struct_arg_7 f)
>   {
>   	[...]
>   }
> 
> This one works well (let's call it case 1), I am able to attach
> fentry/fexit programs to such function through libbpf.
> 
> However, if, in a case 2, I change the bpf_testmod_test_struct_arg_11
> prototype to use __in128 arguments instead of struct arguments, like the
> following one:
> 
>   noinline int bpf_testmod_test_struct_arg_11(
>   	__int128 a,
>   	__int128 b,
>   	__int128 c,
>   	__int128 d,
>   	short e,
>   	__int128 f)
>   {
>   	[...]
>   }
> 
> and rebuild the module/run my test, this does not work anymore, and libbpf
> complains with the following error:
>   libbpf: prog 'test_struct_many_args_9': failed to find kernel BTF type ID
>   of 'bpf_testmod_test_struct_arg_11': -ESRCH
> 
> Inspecting the generated BTF information in bpf_testmod.ko file with bpftool, I
> indeed find some BTF info related to my target func in case 1 but not in
> case 2:
> 
>   [...]
>   [118] STRUCT 'bpf_testmod_struct_arg_7' size=16 vlen=1
>           'a' type_id=10 bits_offset=0
>   [...]
>   [371] FUNC_PROTO '(anon)' ret_type_id=6 vlen=6
>           'a' type_id=118
>           'b' type_id=118
>           'c' type_id=118
>           'd' type_id=118
>           'e' type_id=5
>           'f' type_id=118
>   [372] FUNC 'bpf_testmod_test_struct_arg_11' type_id=371 linkage=static
>   [...]
> 
> I checked the command executed by the kernel build system to generate BTF
> info for the module, and got the following one:
>   pahole -J -j\
>   --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs\
>   --btf_features=attributes --lang_exclude=rust\
>   --btf_features=distilled_base --btf_base vmlinux\
>   tools/testing/selftests/bpf/bpf_testmod.ko
> 
> I ran the same command before/after switching the struct arguments to
> __int128, and made the same observation (I am running pahole 1.30). I then
> took a look at available DWARF info available in bpf_testmod.ko for pahole
> to generate BTF info, and AFAICT, it looks ok (to be confirmed ?) in both
> cases (I am using an aarch64-linux-gcc toolchain, v13.2.0 from
> https://toolchains.bootlin.com/)
> 
> Case 1:
> 
>   [...]
>   <1><262>: Abbrev Number: 106 (DW_TAG_base_type)
>      <263>   DW_AT_byte_size   : 16
>      <264>   DW_AT_encoding    : 5       (signed)
>      <265>   DW_AT_name        : (indirect string, offset: 0x193bc): __int128
>   [...]
>   <1><23429>: Abbrev Number: 11 (DW_TAG_structure_type)
>      <2342a>   DW_AT_name        : (indirect string, offset: 0xe98d): bpf_testmod_struct_arg_7
>      <2342e>   DW_AT_byte_size   : 16
>      <2342f>   DW_AT_decl_file   : 1
>      <23430>   DW_AT_decl_line   : 70
>      <23431>   DW_AT_decl_column : 8
>      <23432>   DW_AT_sibling     : <0x23442>
>   <2><23436>: Abbrev Number: 12 (DW_TAG_member)
>      <23437>   DW_AT_name        : a
>      <23439>   DW_AT_decl_file   : 1
>      <2343a>   DW_AT_decl_line   : 71
>      <2343b>   DW_AT_decl_column : 11
>      <2343c>   DW_AT_type        : <0x262>
>      <23440>   DW_AT_data_member_location: 0
>   [...]
>   <1><295c1>: Abbrev Number: 99 (DW_TAG_subprogram)
>      <295c2>   DW_AT_external    : 1
>      <295c2>   DW_AT_name        : (indirect string, offset: 0x5e20): bpf_testmod_test_struct_arg_11
>      <295c6>   DW_AT_decl_file   : 1
>      <295c7>   DW_AT_decl_line   : 152
>      <295c8>   DW_AT_decl_column : 14
>      <295c9>   DW_AT_prototyped  : 1
>      <295c9>   DW_AT_type        : <0xdd>
>      <295cd>   DW_AT_low_pc      : 0x1380
>      <295d5>   DW_AT_high_pc     : 0x34
>      <295dd>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame_cfa)
>      <295df>   DW_AT_GNU_all_call_sites: 1
>      <295df>   DW_AT_sibling     : <0x2964a>
>   <2><295e3>: Abbrev Number: 45 (DW_TAG_formal_parameter)
>      <295e4>   DW_AT_name        : a
>      <295e6>   DW_AT_decl_file   : 1
>      <295e7>   DW_AT_decl_line   : 152
>      <295e8>   DW_AT_decl_column : 77
>      <295e9>   DW_AT_type        : <0x23429>
>      <295ed>   DW_AT_location    : 0x6196 (location list)
>      <295f1>   DW_AT_GNU_locviews: 0x6194
>   [...]
> 
> Case 2:
> 
>   [...]
>   <1><262>: Abbrev Number: 106 (DW_TAG_base_type)
>      <263>   DW_AT_byte_size   : 16
>      <264>   DW_AT_encoding    : 5       (signed)
>      <265>   DW_AT_name        : (indirect string, offset: 0x1935d): __int128
>   [...]
>    <1><29552>: Abbrev Number: 98 (DW_TAG_subprogram)
>       <29553>   DW_AT_external    : 1
>       <29553>   DW_AT_name        : (indirect string, offset: 0x5e20): bpf_testmod_test_struct_arg_11
>       <29557>   DW_AT_decl_file   : 1
>       <29558>   DW_AT_decl_line   : 148
>       <29559>   DW_AT_decl_column : 14
>       <2955a>   DW_AT_prototyped  : 1
>       <2955a>   DW_AT_type        : <0xdd>
>       <2955e>   DW_AT_low_pc      : 0x1380
>       <29566>   DW_AT_high_pc     : 0x34
>       <2956e>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame_cfa)
>       <29570>   DW_AT_GNU_all_call_sites: 1
>       <29570>   DW_AT_sibling     : <0x295d6>
>    <2><29574>: Abbrev Number: 46 (DW_TAG_formal_parameter)
>       <29575>   DW_AT_name        : a
>       <29577>   DW_AT_decl_file   : 1
>       <29578>   DW_AT_decl_line   : 148
>       <29579>   DW_AT_decl_column : 54
>       <2957a>   DW_AT_type        : <0x262>
>       <2957e>   DW_AT_location    : 0x6158 (location list)
>       <29582>   DW_AT_GNU_locviews: 0x6154
>   [...]
> 

Hi Alexis,

> Am I missing some constraint or limitation that would prevent the case 2
> function from being described with BTF info ? If not, any advice about how
> to debug this further ?
> 

I suspect this might be related to an issue I ran into where pahole may
mis-encode types larger than register-size [1]. Out of curiosity, could
you try rebuilding and using a pahole with my latest patch [2]?

1: https://lore.kernel.org/dwarves/20250410083359.198724-1-tony.ambardar@gmail.com/
2: https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/

Cheers,
Tony

> Thanks,
> 
> Alexis
> 
> -- 
> Alexis Lothoré, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

