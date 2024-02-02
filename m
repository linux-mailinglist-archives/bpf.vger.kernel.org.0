Return-Path: <bpf+bounces-21054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6858470FC
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE99828D13B
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E332C88;
	Fri,  2 Feb 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhCzBU1P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF73D63
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879923; cv=none; b=ZLSUr8DVTNuFGJGw0cVKbwBYHf8S4mF4dvnBfw3ZfBgv9PJcjb1NXhYLO+py4otF2mrUHoQu7a0o6+airmN5jccrMhrf2liaiPy9SJn6DSKAmNQfJJsHLWaLJ2sHiT4jjP8HKF+KUtpbTDMs3jgADO3pxrKJtr2KAv31m1qQykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879923; c=relaxed/simple;
	bh=W7OZx4RTxoom4Ogz5ug3JSSYtqzQnfFyLwBWZ6PN524=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qONlcuYg+zthjl9GAfq9PyBNOms0wYa9Nz0eZ66S2vnm4PQRopr1L1bbiNFY7j+fE2nhRi8aY3aADgomhcvw7xmznuj90yx/2fYRdBoBKCvt5/ILq7Xqcio77MBt76HGkxLrpXbwBAtkvHLf8bo1C3VB3XFi/RQI34bzM1v7Buc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhCzBU1P; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so25046821fa.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706879919; x=1707484719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbtOpRngfWUWXoOKqm74anyaAHkCqDPmB9AzS1PPbu0=;
        b=RhCzBU1PW0My1mfJhRjkIYh3GpscjbjjHl/vhvzMxzUGvhk6lQvIhqYiTd+WA/t+P5
         0LmXo818EnE++6ygqhxSG4ix+57wII3FZToPjdk4jz+yOEqo4SPkKsv5SUDVJoica/q4
         qQZM/ftjmqxA11UUft0UcJJCE6R1ljQvwzC9b+qgiGn1uZPRCjXoM1DtbxaR+sA86EOO
         5oLjQpXuiwJutqCovVJoOpYhu0bBCmfrKAo5QuB6W4qFSme32mDINa0pNEJHpM7q0e9b
         /xiSPLBL/xPAtTP4P6TcG41Hr8g5u1iWoZD1xFmtLiV3IWEtPRDZElZUdWbKrFytzjET
         vSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879919; x=1707484719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbtOpRngfWUWXoOKqm74anyaAHkCqDPmB9AzS1PPbu0=;
        b=IgkOJfdv3yzSf+YrII5t6eIiIIGVT9L2pQI8heTL3xONZEx/FpuqT717Ui7vsDCTFk
         S0cGK6Ug88/tJICZBJZPvxv/4noPNtUFp4MSQfh2FBvtwwD319iXCxEunyUA+dbU+ksO
         FyFLaDpyYPIs4f0LJn1Yb88/SaW08S03p/Iq23C6P/ooidyLPRRhb75dP9EKVhkdGImt
         tiStDfoFQUfKl7W4kXFOXiIYqvyzAxGUvrJDTAY2TjuNb43NNOdW5bW35001erqJt0kY
         OdCPT1I8vVXI6dTU7ZbLQ8O+JQTyQYl3W4EhaVCRJQxxbmEFKhX/rfIi2Jf37DUygKQA
         rIxA==
X-Gm-Message-State: AOJu0YzZ9z1a7PLi722/uNZzNbjRsCf0vd7EGThml3PsmBDwr7zwoNCi
	Y/XhmCWnp00IeK/d0HEx/vgm14y4WX07mPe1GyqMzRgDbTGDBUti
X-Google-Smtp-Source: AGHT+IEFT61vTE6wXKdnjmftyazW/VRST/KOvz1w7wGU+674/5ID46MJZEfaRVd3XS0TUGWzGZe+ew==
X-Received: by 2002:a2e:9e10:0:b0:2cd:4883:6e25 with SMTP id e16-20020a2e9e10000000b002cd48836e25mr5334207ljk.50.1706879919077;
        Fri, 02 Feb 2024 05:18:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2yMAzPZsQAmDyPtgf+hIn01WzxrIlR6jm4E6suHayqpb+dXrnmA0o6TgW99buOMG3rqW4sPNFywC0vaOFbx7v4z4qlp3aeF+tkcGXUUbWEAdjhRO8OOdu9NNyCP1/Hv6rD29lUPzMEqhWnwYNw2HTZ2XcrEre628HGcBYC3FuCDLmiPHn5FdUTl1TNTGrsFMtOPHApdHHAJo/9o5ZaYGqZCiTOCTWsFooY67xM14P49ayC3EPTai91aLNtMDa8G/0O4piPhzBEe5G2PRNgYktpz/DBkb3zxeGuHqFMq9u7RfF6z367024lcWRTbpQFY4/F2qWdzbpXgRVnvU895xYVOqoI0sKOnduJ/U5/kMSXQ0gYUlC2SbawDS4sHPXz0rvZTVNW09vCIgL5JpG
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ij7-20020a056402158700b0055fe55441cbsm793199edb.40.2024.02.02.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:18:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Feb 2024 14:18:36 +0100
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: Re: [PATCH bpf] selftests/bpf: trace_helpers.c: do not use poisoned
 type
Message-ID: <ZbzrrBKaJyRJLEz8@krava>
References: <20240202095559.12900-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202095559.12900-1-shung-hsi.yu@suse.com>

On Fri, Feb 02, 2024 at 05:55:58PM +0800, Shung-Hsi Yu wrote:
> After commit c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize
> kallsyms cache") trace_helpers.c now includes libbpf_internal.h, and
> thus can no longer use the u32 type (among others) since they are poison
> in libbpf_internal.h. Replace u32 with __u32 to fix the following error
> when building trace_helpers.c on powerpc:
> 
>   error: attempt to use poisoned "u32"
> 
> Fixes: c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize kallsyms cache")
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Somehow this error only shows up when I'm building on ppc64le, but not
> x86_64 and aarch64. But I didn't investigate further.

it's within powerpc ifdef:

  #if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 4faa898ff7fc..27fd7ed3e4b0 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -271,7 +271,7 @@ ssize_t get_uprobe_offset(const void *addr)
>  	 * addi  r2,r2,XXXX
>  	 */
>  	{
> -		const u32 *insn = (const u32 *)(uintptr_t)addr;
> +		const __u32 *insn = (const __u32 *)(uintptr_t)addr;
>  
>  		if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
>  		     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
> 
> base-commit: 943b043aeecce9accb6d367af47791c633e95e4d
> -- 
> 2.43.0
> 

