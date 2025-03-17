Return-Path: <bpf+bounces-54185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05CA64988
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709C1164B4B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7223A9B9;
	Mon, 17 Mar 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7LpPKBD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692822F17B;
	Mon, 17 Mar 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206715; cv=none; b=gznlctuVQvcKYPbny60cWipb9lblLb20bOw/cNueJUvCSmWQPi4Q1CMzu2EfVapUAa1ettiJNEhpdvU0GKYsY5y3hFkxyFR59SDolboIUBB6SXHdI7P9KVsKu7ZhW/vsufqhFce8QoSjmuyTLvkPJJGN8Le4OJr69Baa0GmWgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206715; c=relaxed/simple;
	bh=XjE4+zFvz2SqefVif3aUirZvhQJ87SiWwJlaKUqZNXk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avW3jp+GeZ0f6LVe3VXBoUCzQfFG90L2MUkiY4/DGkBGSTXrNF6QsvVcB5EXXNBW09F8HKga5WYI7ypd3Vk9YL2xnBJvPftrZXmR0LPtV+Ozv9wDe5cujuyJbTk3P9wshVO2S6VG3mDwYjDUBqJbdPBUuUmfE/+IessMyPFQGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7LpPKBD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2c663a3daso192786466b.2;
        Mon, 17 Mar 2025 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742206711; x=1742811511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEHlrjy8RB8567Xd0YTE7NiCgDY2+uTN3AGwaU7/bsE=;
        b=b7LpPKBDZdLz9W45NZDD5Zv8I/uAvfOFSRH82bUq/mhCgAkCo0VaN1Y4bjEkZPLzL2
         1qCNaUfuBdBqeh3EPs1flMEbTntkg9ubsVnR3qW49+eBBSlGIa/8KBzDrPqdlBMi3LtG
         Y0sjFldDyOnHIfx/lMOiWmOK3rf1vdNTssgfvUQ9l+lsVe3mjCeQEcMlS1cXAjlEV+8I
         SyseSECZ+IIzHWGKtzJtzaYyH4CgQtdFGAJEtq66+4zNLHpBhTxdLyVzEuAgTiv+xRyM
         Kq2i+qz0Fx2rB6i7fd84ScpUbo1/kmNzyDI6GViJl+6sGM2J3hZTmGM0qVAGP7o10Y44
         qmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206711; x=1742811511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEHlrjy8RB8567Xd0YTE7NiCgDY2+uTN3AGwaU7/bsE=;
        b=qXFCcIJvpwE26SudBtDGO7pYDjBWofwx0DIH3YxHh7enwX+17AG6RO7izHq6JpCIZX
         DtqoICo0L5doadBb9X8etqdgZweaqgpgl+THd6Vp6c6bBrrkqzOZlXFtYwtIzZ1vm9TX
         8y0qqAwTeAKNZpFi0CvCYuDTjp5COfpqevXtfo0BSkjrLIIQ6xv50SPalEQMJHlmHB3e
         lwC0Tx3WA9YLSJrjsM15lb8c22fYHRdwZ8l5oFTy8W5fsdzsZUfUa8k+WJiZ3jWL3fDn
         6C7o74454588MTLc4KMLPdkUvXEmofDp1Co2vjx5ak+CsS+m/xlRdomzVC6SWwoU5Pyj
         rPrA==
X-Forwarded-Encrypted: i=1; AJvYcCWjbymWvmxZ1qTxuGbMgeMBv1kF0iESRWniHrzMKA/fW5l3yIRI+WK8XrImWGYLQI/obZ01sIkE@vger.kernel.org, AJvYcCXbEACatVrbvtLSYqV7bRAP3Uw+caSMjhijAWajHJDiXMuwVQ3M9+Sqdsjm45Xu0UGobA+nao0/v02scxMN@vger.kernel.org, AJvYcCXpKScecY7LkZ2w3p60szmbiy9f1Xgz+l905x7/vRFw9N1XGp037UlqH/MpDO8y/BhOp08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvuro5n10wYeu9I186sufsPao9V85J4jzo3BHyflP3IYiipbYx
	ichwqWgURR4IwRMzblB+NkKKXggcmf24dxeTWO12EeRYEfT3xtde
X-Gm-Gg: ASbGnctrP9493sjKlsfYRKKY1jwmB26Tx2o+pZyhxkodT+nmn8qaHWqlcjdV1dnvejW
	cd7CqJ4+aaqVH5YXLnHuCiFlzpQX6u5PHSr5u4HrJUVvtg8mjiOlQek8TbX7ydESYDmGVL+NTTX
	7odbMXXR8tvlqmkNmy2B3TvqiPnyVRonlkH+a4iFTB8LiHVXt2RrizFK/369LfR9oIa2dShFJR1
	GVEFSXDRrxeS7AhijNUCO02q4oyJ7G+IQAnHNuXd5kKAff2iO4wFPvtcCo6ZpPGN6M57YPEIPoB
	K0eV3DUTGC7cz76viiox5Nbie5Q9Qdo=
X-Google-Smtp-Source: AGHT+IEZgRKTDLQyVHbs0c06ifShWYg0fN3NKtuuUCjdd9f2W7b/hT5jWr1RKcn7GzFwSmh5x1D74A==
X-Received: by 2002:a05:6402:5251:b0:5e0:9390:f0d2 with SMTP id 4fb4d7f45d1cf-5e8a0228606mr11038428a12.20.1742206711416;
        Mon, 17 Mar 2025 03:18:31 -0700 (PDT)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816974740sm5693886a12.26.2025.03.17.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:18:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 17 Mar 2025 11:18:29 +0100
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.1 v3] lib/buildid: Handle memfd_secret() files
 in build_id_parse()
Message-ID: <Z9f29SF5Wg5wA7FC@krava>
References: <84211070D1A421C2+20250317052300.24146-2-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84211070D1A421C2+20250317052300.24146-2-chenlinxuan@deepin.org>

On Mon, Mar 17, 2025 at 01:23:00PM +0800, Chen Linxuan wrote:
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

