Return-Path: <bpf+bounces-40868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E198F858
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237DC1C21EB1
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF061B85C8;
	Thu,  3 Oct 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhSkImDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461951AC884;
	Thu,  3 Oct 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989149; cv=none; b=oJOjyLmz6vbYlO2KmTGFZS7vbczgd5GFYztoRvhn67t6PmsnIUB1bGgHJt7rLeJFXCvltxIwqpiFev2GBnpK44Vo4cREE1peHN/2Ze0hVJI+QfsAcBKZRcnXsPq3cbYwVso8YkBO/N0Gn7uyFMT4KrZp+w9qfjhQ2OeVll24cXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989149; c=relaxed/simple;
	bh=ZmpXlFGMpkNtzbN2wBs+Cw+ak6YemdJvW39dDHNXTWY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrokz0tZsL7H+KfcWGW3F40EnQ2IcnotpXHHgvUIOLwQGzNw1p8Sbw/pn+wL3fo8Vn0OZ+j+w3JSMIyEvn8qo44c1ea1YFHS8HJdjxghI0O2/z5ywVIhemZdjyD8cQvLHDGbjAyXfP6yglaB/WSKcJn+J1vBC2uvcII+uynQV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhSkImDq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so13235325e9.3;
        Thu, 03 Oct 2024 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989145; x=1728593945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJNihuWQh42d+jrcRZkq6DiE8tAO9UQ/Jb0vkJLRO0o=;
        b=lhSkImDqrZx6jC6CAR+dULWCkJb46UuS1mrq0cubfaVlN5JcS6kgfyXxl0r1eY6et1
         QkVozfPDvWqnPR+kIJz90QheCh9skgKnvJfaWU0Oy+MY1dLEMAYs9SUNyootsdt3zDcf
         yGjIw2FMwBTwELzSO0sjGIl389qmqSkcagGkEikh8qT1Ms0uTdhKfRyGFItiKbXEo67k
         +zEpHXU1sfFiDrvEk4EFpFhxFM11/vH5GwFriIwYVRlqRV1Rz4FnrIOW5W60eCmc2Hkz
         w13sK2brpBi35XdstzK5zvj4hrWG2t7TDhOFN7h/yRdCQTdpYrABsOW7SiDcxGkCzK6Y
         k4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989145; x=1728593945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJNihuWQh42d+jrcRZkq6DiE8tAO9UQ/Jb0vkJLRO0o=;
        b=QcKPcKChjGgtztCXylsmqiX6cFSxLOZ/LHnhDkQDPQnrkZYplhDehGhNMOzTCLQAR3
         hfviMkVHGUyiiuCSTjbvC+hEKX62100CdxFpNcb721vdF/v88xdPsQPgHZGgiTUhlYpR
         nrFWde6IICJAkxPXKbuGPhlEGNGbhWsPBDhYyi7a3/yJ9Q5rPxY66mQwIlOJXlMxcQ6h
         TBAVOLBeUYQjwdV4B83oJr9zubKIALXTQdHAw2MlMHlu+/Fe4k9ZfmzF2Qu8Cl38lhHK
         MjfHTlAa12gE0pDDy9uq3sei4CMFMlJAzN7TzENaeUHbyqxqjlFDTEvPJiXK+lqt4ESD
         OXPw==
X-Forwarded-Encrypted: i=1; AJvYcCUXAhZ5nO7qz8qX1MAok1uSWPBN81ZPXK0AF7uWNxQNoUz/ONsotGWqr3ycyVRFdk9PV+255SaUEQ==@vger.kernel.org, AJvYcCUw8PjHwMsa31v0+zC/QLpLKUW7ktzDwBpxukhsFKkipXj+UyyFcPlr6ETGWxAC4o4ivzY=@vger.kernel.org, AJvYcCVbOgw8YSkZ4K5M+XO4ugohbmHr16NBcOZDbYXbiX8qawS2XaRKO073GyOVQSQYcbm1xNZjKzFa0NKYSjCFu60o@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6HJkbFp/8lGi4tr4b9m2Vt8HO8m9/an2jjb1EhRkqL+4cXup
	tf3hQk9/Nqq3G9QHUyeiBvcaqsbXBY9Zu+HXOD2qgYEcH/52pWkc9eBOFvmA
X-Google-Smtp-Source: AGHT+IHssXj60QMhEj9YSO13AirAlwQRcDaUB+HiW5Htq7R4F7UVDq3ycVAM4z57QWMb5k3rjt1W7g==
X-Received: by 2002:a05:600c:3b27:b0:42f:8515:e4a8 with SMTP id 5b1f17b1804b1-42f85a6d5camr2173545e9.6.1727989145119;
        Thu, 03 Oct 2024 13:59:05 -0700 (PDT)
Received: from krava (85-193-35-211.rib.o2.cz. [85.193.35.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d2fcsm52618615e9.9.2024.10.03.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 13:59:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 3 Oct 2024 22:59:01 +0200
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v3 0/5] Emit global variables in BTF
Message-ID: <Zv8FlbMTd24eJCyE@krava>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002235253.487251-1-stephen.s.brennan@oracle.com>

On Wed, Oct 02, 2024 at 04:52:42PM -0700, Stephen Brennan wrote:
> Hello all,
> 
> This is v3 of the series to add global variables to pahole's generated BTF.
> Patches 1-3 of v2 were already merged. This series splits the last patch of v2
> and does some small updates. It should apply cleanly to the "next" branch.
> https://github.com/acmel/dwarves/commits/btf_global_vars/
> 
> Changes since v2:
> 1. Split things out into several smaller patches as can be seen in the log
>    below.

thanks for the split, so much better for review, lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 2. Previously the global_var feature was defined with BTF_DEFAULT_FEATURE, but I
>    think we agreed in the discussion of v2 that it would be better as
>    BTF_NON_DEFAULT_FEATURE, so I changed it to align with our discussion.
> 3. Removed the "--encode_btf_global_vars" option.
> 3. I went through and straightened out my use of integer types for ELF section
>    index (size_t, as returned by libelf) as well as the variable addr and size.
>    To this end I did add a few checks to explicitly ensure we don't overflow the
>    uint32_t fields in the DATASEC.
> 
> To test this out on a Linux build, you'll want to make the following change:
> 
> ---------
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..c88d9e526426 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)      += --skip_encoding_btf_inconsis
>  else
> 
>  # Switch to using --btf_features for v1.26 and later.
> -pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,global_var
> 
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
> ---------
> 
> With a suitable kernel config that has BTF enabled, you could then build like
> so:
> 
>     PATH=path/to/pahole_build_dir make all
> 
> And you'll be able to examine the size of the results with readelf, or dump the
> results with bpftool.
> 
> v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.brennan@oracle.com/T/
> v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/
> 
> Stephen Brennan (5):
>   btf_encoder: use bitfield to control var encoding
>   btf_encoder: stop indexing symbols for VARs
>   btf_encoder: explicitly check addr/size for u32 overflow
>   btf_encoder: allow encoding VARs from many sections
>   pahole: add global_var BTF feature
> 
>  btf_encoder.c      | 348 +++++++++++++++++++++------------------------
>  btf_encoder.h      |   7 +
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   7 +-
>  pahole.c           |   3 +-
>  5 files changed, 178 insertions(+), 188 deletions(-)
> 
> -- 
> 2.43.5
> 
> 

