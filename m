Return-Path: <bpf+bounces-48478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735F5A0828D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A5716441D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6900C204F7C;
	Thu,  9 Jan 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSvhfu8g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35919187849;
	Thu,  9 Jan 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736460222; cv=none; b=ESG9gZ7b77irP0OpS9KW0GE5kWqeJI7CG25IXTHrFO/eiAZyQralhF7Oiipfmy4h19nauw6WL5USxlBLLYBm1KiH40ElxRphKtj5fS/lM0oipAjy+tW9l/oYbbL4jNCg1A46xr/mJBuab69SuflRXpFIa28lnuWNJq7PxBsoZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736460222; c=relaxed/simple;
	bh=2UtPC60eJM9xKW+KyIMh8+hr4BY34X3OWriBSo333mw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDTay9WDJkbO7GRV5Rs9D11l8zTlvc5hrOeEwWmhI3u4JKfo/REHhhNabVHN3u1zOueeo+GmBE8vKbXJ0hm9wE1C4Gs0luxGgkt+aJOfNufGlt5zjGSOVZzflQEipU77RpkukxGIc41ATe9xBEQa5JJBLf+46sKEVXbeq50vjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSvhfu8g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so223531266b.0;
        Thu, 09 Jan 2025 14:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736460218; x=1737065018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93Ke9BV0BcpS+z/bamzxbTV+Xb/l0iw7UeDYASLkxc4=;
        b=kSvhfu8gbZOrP5PJRDVzgx0acqpiR2qQaCkWyMTmEP45baK7cNOgrhZSFS08E7T5ie
         Dr5SkvPOIn8pdccCJbUR5P1+HdTLLuqim0+ectf4wK5RXxvhVXhX3Kc9qqAr8e/CgjO3
         +uVsGMOF9B48IK9TFNR+xZ8q3DJFiFQBCXyeZJQqWRGfw1PmBVrmxh8hTsuBSEbhzojq
         FoXRdGX5Hlt0stNEyQ6e+W2Wuf2mgCjxFpwXVql4BdBV6AlU43HBJn85dKNs0EJOt5ry
         GEB5oGEdkbWDHVqGtzaIr9S5IJHHl5HeL+b5wHBI+vxKvsJbQIRa9ujQ5ySWurQe+JC1
         Sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736460218; x=1737065018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93Ke9BV0BcpS+z/bamzxbTV+Xb/l0iw7UeDYASLkxc4=;
        b=H0FFhn/AkxfBrJOgJqEa4PBo6GjthHS0KnlfpK8w5J0DP+5aXhl3RUDaRAyIAkwNAj
         w1Zmhdr4SX8YV6lLj+y5kwsA8OdfXlQnAD8Dp5pp7qGE2fEaQXqSzc4Gqukr9KFrPhmz
         x5rS0GfMlq0OEFKpsn64BRt7DpWScfHDk34iMNWGoMcPHXWEas//Q7ySu/2pEGwpG7eE
         z7m6H43KlyOYEHTljlZhLY1EwUKTNVAtxVRHOPqOJQg+ULlfkA6DUO6Pjm/ju0HORJBT
         wZQh7mJ9V81J40fWhLLrSKguwPL+VkbTIAoRfZItnMpvCpNzUBEqRVxnJdgrb3tScnUU
         sByA==
X-Forwarded-Encrypted: i=1; AJvYcCUqS2SGA8/rp2/ofez301D/PiEbbBAPXNky02VtozHBQICQJ9VqOVin2KZ2Yto1WGpX6e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWms6pWXA+JI39JFKXHyuvIs7bV4V2EKA6do+JjnsdEwyuQBIO
	v6s1Th5hncd1AE74p8bppPIrU/C2r9ceWkGhttL+FfyDgpBkO8PU71EXjw==
X-Gm-Gg: ASbGncuoDh/NvWPObyh+PPOr0k4hfpo83EUKH8HVv0NUFEswFZFaaMW7TXTleqPSV5I
	9OYRidjaBllsKdRcfhB7bru3C0CmdoS00gn9+CnngFMAwuuL3pzoeK1KTKsFTtwbbl6zmUswpwu
	AhOsUkD1FR1WcTsKjm4dxoqZMbTLVvzt/UMS9KjrsTzMUxwvXMd3cc8XJiU6Npg7+H5ohbJA+hH
	PTfYNZ1DykonNnZckd8QZt+1R0gdDon4msAtIt00sroAZXcGiVHIqhkj7vL9+s=
X-Google-Smtp-Source: AGHT+IGg5G16yHywV0cd8EcE2wpZ1o97+aMle57RpqqI71SsvpUTPrkXa2+qG9kUiz1tVbJr+xDZtw==
X-Received: by 2002:a05:6402:2746:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5d972e1c54emr20040267a12.17.1736460218117;
        Thu, 09 Jan 2025 14:03:38 -0800 (PST)
Received: from krava (85-193-35-24.rib.o2.cz. [85.193.35.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b1bc1sm108946366b.147.2025.01.09.14.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 14:03:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 9 Jan 2025 23:03:31 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org,
	alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org,
	mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 RESEND 00/10] pahole: faster reproducible BTF
 encoding
Message-ID: <Z4BHs_rp6Ts2Dj5O@krava>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>

On Thu, Jan 09, 2025 at 06:59:54PM +0000, Ihor Solodrai wrote:
> Note: a resend due to https://lore.kernel.org/dwarves/Z4AWJBNsGJvBU7ZY@x1/
> 
> This is v4 of the series aiming to speed up parallel reproducible BTF
> encoding. This version mostly addresses feedback from Jiri Olsa on v3.
> 
> A notable adition is a patch 10/10, which changes func_states in
> btf_encoder from a list to an array.
> 
> Testing:
> 
>     vmlinux=/home/theihor/kernels/bpf-next/kbuild-output/.tmp_vmlinux1 PATH=$(realpath build):$PATH ./tests/tests
>       1: Validation of BTF encoding of functions; this may take some time: Ok
>       2: Default BTF on a system without BTF: Ok
>       3: Flexible arrays accounting: pahole: type 'nft_pipapo_elem' not found
>     pahole: type 'tls_rec' not found
>     pahole: type 'fuse_direntplus' not found
>     pahole: type 'nft_rhash_elem' not found
>     pahole: type 'nft_hash_elem' not found
>     pahole: type 'nft_bitmap_elem' not found
>     pahole: type 'ipt_standard' not found
>     pahole: type 'nft_rule_dp_last' not found
>     pahole: type 'ip6t_standard' not found
>     pahole: type 'ipt_error' not found
>     pahole: type 'ip6t_error' not found
>     pahole: type 'nft_rbtree_elem' not found
>     Ok
>       4: Check that pfunct can print btf_decl_tags read from BTF: Ok
>       5: Pretty printing of files using DWARF type information: Ok
>       6: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> 
> The warnings about not found types are also present at pahole/next, so
> not related to this patchset.
> 
> 
> Performance check. This patchset (always reproducible):
> 
>      Performance counter stats for '/home/theihor/dev/dwarves/build/pahole -J -j24 --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build --btf_encode_detached=/dev/null --lang_exclude=rust /home/theihor/kernels/bpf-next/kbuild-output/.tmp_vmlinux1' (13 runs):
> 
>               5,788.22 msec cpu-clock:u                      #    3.776 CPUs utilized               ( +-  0.17% )
> 
>                1.53288 +- 0.00334 seconds time elapsed  ( +-  0.22% )
> 
> 
> pahole/next (d444eb6), parallel non-reproducible:
> 
>      Performance counter stats for '/home/theihor/dev/dwarves/build/pahole -J -j24 --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=/dev/null --lang_exclude=rust /home/theihor/kernels/bpf-next/kbuild-output/.tmp_vmlinux1' (13 runs):
> 
>              10,462.38 msec cpu-clock:u                      #    6.678 CPUs utilized               ( +-  0.15% )
> 
>                1.56670 +- 0.00548 seconds time elapsed  ( +-  0.35% )
> 
> 
> pahole/next (d444eb6), parallel reproducible:
> 
>      Performance counter stats for '/home/theihor/dev/dwarves/build/pahole -J -j24 --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build --btf_encode_detached=/dev/null --lang_exclude=rust /home/theihor/kernels/bpf-next/kbuild-output/.tmp_vmlinux1' (13 runs):
> 
>               6,399.88 msec cpu-clock:u                      #    3.164 CPUs utilized               ( +-  0.22% )
> 
>                2.02269 +- 0.00359 seconds time elapsed  ( +-  0.18% )
> 
> 
> v3: https://lore.kernel.org/dwarves/20241221012245.243845-1-ihor.solodrai@pm.me/
> v2: https://lore.kernel.org/dwarves/20241213223641.564002-1-ihor.solodrai@pm.me/
> v1: https://lore.kernel.org/dwarves/20241128012341.4081072-1-ihor.solodrai@pm.me/
> 
> Alan Maguire (2):
>   btf_encoder: simplify function encoding
>   btf_encoder: separate elf function, saved function representations
> 
> Ihor Solodrai (8):
>   btf_encoder: free encoder->secinfo in btf_encoder__delete
>   btf_encoder: introduce elf_functions struct type
>   btf_encoder: introduce elf_functions_list
>   btf_encoder: remove skip_encoding_inconsistent_proto
>   dwarf_loader: introduce cu->id
>   dwarf_loader: multithreading with a job/worker model
>   btf_encoder: clean up global encoders list
>   btf_encoder: switch func_states from a list to an array

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  btf_encoder.c               | 662 +++++++++++++++++++-----------------
>  btf_encoder.h               |   7 +-
>  btf_loader.c                |   2 +-
>  ctf_loader.c                |   2 +-
>  dwarf_loader.c              | 335 ++++++++++++------
>  dwarves.c                   |  44 ---
>  dwarves.h                   |  20 +-
>  pahole.c                    | 230 ++-----------
>  pdwtags.c                   |   3 +-
>  pfunct.c                    |   3 +-
>  tests/reproducible_build.sh |   5 +-
>  11 files changed, 623 insertions(+), 690 deletions(-)
> 
> -- 
> 2.47.1
> 
> 

