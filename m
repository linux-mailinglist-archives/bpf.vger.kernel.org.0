Return-Path: <bpf+bounces-54186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B4A6498F
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 11:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBD17A3BF9
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FA241CB0;
	Mon, 17 Mar 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP8p8kLK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4023BCEF;
	Mon, 17 Mar 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206727; cv=none; b=B4H20u2IDR4qZwi8YFI2+/ryWamojuy8xW0ISrer8cQzx09RbM1G3Pt+R6yR3xDi8N66p1DmhxHI+7ZHrRDmMBNnbaukgcWZC9NFn0Doue/ryxFEwhVm3vz5Ky3iHoqtvNCrx01yyNQwexRqtHE7p7a3qQz1eDAq68/sVyiqHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206727; c=relaxed/simple;
	bh=b11k5oP3Gi4MYYa6m+PvBEh5tx83phxNYeZXlZP0jzc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HajJJRfsHWDIvB14hwIj++n4cNCSMppVGblZJZF7V8JdfHJjopkXuafiOzwfeNdTR+5jTztiolCXFk/3kPS6meid4QZUNn/wgvyyIyd4KRkSRPkqHX87ru1wwr5e4IPDGQ3Vkl6/Mhn07S7Z6bPSVGLzLIy7dgylIZiazH+P+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP8p8kLK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso7170905a12.3;
        Mon, 17 Mar 2025 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742206723; x=1742811523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdVG7lUNv/s+5WyppAdp0QX1adPp/UInRlrEXdzVJ4s=;
        b=dP8p8kLKNZVg31din9wmvQZrd7Ul/bXLJ8/5DjV0AGvYA/iFMNWNui51F2ll2sKt5e
         gV5SI1Gk2NRKkbg3ZUd8njdBXrVjiCa1ZZYqVHRbbddIjeIIel62WMkWfFPlcDY4YjkK
         UxJybfSbgrNPpLVnU0cHQ+VHJZyBePXa41YZolOH+ZcKF/3PXFzo1Etx3eDqnE9I3X3P
         i3L7p4KW286JRz4Zu2bbSNq1GHouTdCf1nTRhsOxpK55TLExeQW5DBNpVxu+UM23rpao
         5eJL+5PcGOsgu6giDx83CYRpt7JC6LMUMYvJFvk2jhmwmwQBJr71CLORtvFu5LLTgtJT
         48Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206723; x=1742811523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdVG7lUNv/s+5WyppAdp0QX1adPp/UInRlrEXdzVJ4s=;
        b=d1b1MJ+nWrG2aoKcrZig023GZkEkw1nY4k+K5ATneze1fPmW4mZn/4ICe5VVtaZJIV
         SeKM2iH+V//wgxLbJ7t7EH/v/Zr8mSzbbtGId22VbN6DJtuhzkGxAnT/ZabU7cHnMGwf
         9JbzUksfavIOoPZabOned4JP0cz5S+K3adbC8Jevpidu7B50J4yoUQ1fRLIxsNrBNY44
         Mb1Cktq4tGuEFtf0dMrzpKfmlwCPRHVyfkZ82peE1S0H/xigQte1Sfn+BnnpxhvETwUR
         HYNEE4DcinVSmdQvjDpeehGXN++LY4VurWbOTXYdzij7k0DfsqvVMSBSf9KGZD14GMsm
         q54g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Zg+RsgXAA6lY/MpVUfYCD8dGsMa4gJ2C3JWxCBCGWVhlv3Y+has5CTYgcTYSAUmVSAx0TKxh@vger.kernel.org, AJvYcCWLhoSZKfQwcKfczdFe8pDATgUEzU1jhdsx6g+L5/AGsJaloh3TzugvPNQBKlCi/yxvrNk=@vger.kernel.org, AJvYcCWwvTkBUjDFrshBNOnKmi/Wmgo8gKcmv9PIq003yMjHTs+AT36/3jf0sFjGSQnINVlquE9u3UEkG72UOCRW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PrnK/Eb3y/BD6feYvVAEfZ2CBBPqAkpkiG0tMj/y7VammtVU
	dOn6zPfvHMk37sBik+ydGp9E/fP+lZCCQz/uwj0dS8YGbtHqUPIj
X-Gm-Gg: ASbGncte25C9pu9s7cWK4OvxK8FhmBc0VEi/aoK5JvevvYWMIWGX/l3Y9/A2vEFkb1L
	M61OpmdD+dYDY6b6B8uzo5Ah0+YZX3nworE3axqCOT0p4h9s03vVbywZ64yvhQBMZfhwoavSUse
	zBHIhqnH830m0+RCRIWV1J1qmROjrLRcdlrrY4TVyOKNmDXkLAsenqagEAF5/0fMoDSZoGABlYN
	n/WmrpdgSKoQzKxugckKNcxfPKyNjbbUpVeffmzyM6spqDUwcXYDFeb7GaHsgYEcqiKa4C+JyVp
	oDzpAAPqzmIuxySpSf9pG3mQh2iaUa+WrQmx5DlUMA==
X-Google-Smtp-Source: AGHT+IGYGwNgqS1ya1OqrWbyC9NELGJLxStZasnaimSv/apEOXJ8luOKZsqXG20fYalQAHa1l5W70g==
X-Received: by 2002:a17:907:2d91:b0:ac2:b8ce:90d5 with SMTP id a640c23a62f3a-ac3303bce33mr1249466766b.44.1742206722947;
        Mon, 17 Mar 2025 03:18:42 -0700 (PDT)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfbb3sm645707066b.101.2025.03.17.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:18:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 17 Mar 2025 11:18:40 +0100
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.6 v3] lib/buildid: Handle memfd_secret() files
 in build_id_parse()
Message-ID: <Z9f3AAE_IH6qPOeo@krava>
References: <485715E6BEC61FE5+20250317052325.24365-2-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485715E6BEC61FE5+20250317052325.24365-2-chenlinxuan@deepin.org>

On Mon, Mar 17, 2025 at 01:23:25PM +0800, Chen Linxuan wrote:
> [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
> 
> >From memfd_secret(2) manpage:
> 
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
> 
> We need to handle this special case gracefully in build ID fetching
> code. Return -EFAULT whenever secretmem file is passed to build_id_parse()
> family of APIs. Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
> Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
> [ Chen Linxuan: backport same logic without folio-based changes ]
> Cc: stable@vger.kernel.org
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>

lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
> v1 -> v2: use vma_is_secretmem() instead of directly checking
>           vma->vm_file->f_op == &secretmem_fops
> v2 -> v3: keep original comment
> ---
>  lib/buildid.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 9fc46366597e..8d839ff5548e 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/secretmem.h>
>  
>  #define BUILD_ID 3
>  
> @@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	if (!vma->vm_file)
>  		return -EINVAL;
>  
> +	/* reject secretmem folios created with memfd_secret() */
> +	if (vma_is_secretmem(vma))
> +		return -EFAULT;
> +
>  	page = find_get_page(vma->vm_file->f_mapping, 0);
>  	if (!page)
>  		return -EFAULT;	/* page not mapped */
> -- 
> 2.48.1
> 
> 

