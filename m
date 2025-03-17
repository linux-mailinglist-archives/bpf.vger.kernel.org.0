Return-Path: <bpf+bounces-54184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB24A649A2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA103AC0E4
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206C239591;
	Mon, 17 Mar 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewkjNUdu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9A230BC9;
	Mon, 17 Mar 2025 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206702; cv=none; b=ujP0l1roc70jK7jLIlu7TOTcD0MsTNpGuu5SvTdXVlKLcOSl0FOkcGddd0V0DFN6Ah+3Sc3jF3dFMcEL3XP0lYxZq0hxG1d76NxB02b2skQpgp7n5HuOUJ5DJH7Ko3AViyo/NmlMy6vFsG8jsu0x6rMTqxDw053ObVDw0DBDmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206702; c=relaxed/simple;
	bh=oetRCrK+6XzcEvbOj37sD62uupHCSGyNHZXJPghenF0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG3w1dlDBCvQYy5je7+iQMXPwgpDSJmnRATTB8JBTa96Y0kQgHLkbXtHEeJFzUmnAGGYM89nDL3pcZqFWqA+B/fF4yfbLfSZxrMxBSl8O9FrYhKeDUtVJEWeElp6Fg1mT/F2c4YOLU8Ub9OrkkTtbYsknP8igDoRXnurJy8pPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewkjNUdu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so9769826a12.0;
        Mon, 17 Mar 2025 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742206699; x=1742811499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wKketw2TWgl0iLj5YrKZu6wMKDpK26remsueT408zE=;
        b=ewkjNUdu6BPfdsXJbosHfUWddyC/YFQ/8BGj6bgCQaQhZcMueJ1ZkYHuoZ2fZbFppl
         7WJ5KISrMx9yR3xWy9MQ/REZIzRSQcRnGvN1jYr/U/Q/y8EMCYNPdbZvfdT9huOudlf2
         TcFePM2BziFsltnDOZjkBPPoQs/Fwr8QqNPX178Eas3Lgnlb/cK6Jfy19cxofitw0pJ9
         QtJnPJTVB62f99ULu9KFeTYSK2NZ6OlxzoAyIzgjV1eDDA0lduFKDcS2/ozuFnLOorQZ
         wb5U3Bz7fmAEVsaBof++CDd0RjUN6R9wWLd96WsXtG0bAv7ljKk/Q70sash7pgzNuWFk
         NZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206699; x=1742811499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wKketw2TWgl0iLj5YrKZu6wMKDpK26remsueT408zE=;
        b=GbIn08lYbM44tWVq2nM1LJX8sIAn1izxDr47LLYGkZVJ5F+FCZtWqtGnQGa0KIle9X
         0JgFQjOES11D3/2iGnOrzsfOrUORoL3BKzGVLLGPwtn7yImtvaYLWy7KfOHTbQTHikyD
         boeEyNsDUbfPO4yc6YaHjKdVOa6Elb0LB2mSIUOneq/wGV2hy9uVdetSRwlQj0qSJqGB
         IADt3aPT6jzbZ7k6FEtoWBreyyPBq+f1MXgWpczMntbp1fdiKzzX55bnfFIoLocIOQft
         mdYW4SEG3+j3NKZLLIVd4Ne4h7A9erGo11dWljQKx5Rr4QKVc2tUNzNfWP9ZTfa5HmDZ
         28yA==
X-Forwarded-Encrypted: i=1; AJvYcCUTaSs0+UpRcgjahh3g9VEJikO+rIwyUsg0kqZrIdZ2p5SaPTTJ3w8l/JoFmflIjdnJ4kECP3t8+c90CRVP@vger.kernel.org, AJvYcCUaJmED5RKFQgBxDnykwNJUlMT+wC0S0KpZCNuW510qxj01BLWf5ZxluKDwZxOleRl6AVI=@vger.kernel.org, AJvYcCXuK0xNn+TtF31fOU3usNyNbi6bW3KehAmEU6ejR6Aya1odyu6TLbwoM2Oz4CvCHsCOyIY/O55t@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJznCvgH2XGhlSDOxZiCycMn8fGxhtA0HsQ7ijv+EoJoNpmD+
	Vw923wAnkDEMmi0S1KjT7m0YomqodOMomsiOR3pMQFQkwzTpD0lb
X-Gm-Gg: ASbGncuTx7Zzg0gzqF4V4+8pFe6BDVcsyqGu9gomidEgkieFOH9EjXWdUdzRSq14Ri3
	r2upylvXF+VxQrwClxwA+2NhvCWeXjUL91AyZW1xHKKiARXEqscA/aV2ENfWjCM9/BZy9FyMxwv
	MCWxgowTBPmkoonOvgnd/LeuZc0B0954f5Lt6zbUeANu5Yu2EvhMDqmZ/kkzBWTGI9NufF5DTyN
	nrygSpsRNZOeW5nIc/txslPM1NtHzgDVIKG46fZ7RkcucWqkA5LvqJu1ZviJQCD1Yw97tAu19at
	GisxBiNx8F91SpKVyWUy9InixEDY/AqojTIfX47mQg==
X-Google-Smtp-Source: AGHT+IFtGdAtfoFs+Th129BAI5C2xeQ+mM3bbalDERGzS37sqYdjQf6O8en7nRVvQgz5hFjKcl3+wg==
X-Received: by 2002:a17:907:2d89:b0:ac1:e45f:9c71 with SMTP id a640c23a62f3a-ac3311aec0cmr1164507966b.1.1742206698786;
        Mon, 17 Mar 2025 03:18:18 -0700 (PDT)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0ca7sm651288866b.60.2025.03.17.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:18:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 17 Mar 2025 11:18:16 +0100
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH stable 5.15 v3] lib/buildid: Handle memfd_secret() files
 in build_id_parse()
Message-ID: <Z9f26L84ILYCsMv4@krava>
References: <DC5F0190D52D7B57+20250317052132.23783-2-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC5F0190D52D7B57+20250317052132.23783-2-chenlinxuan@deepin.org>

On Mon, Mar 17, 2025 at 01:21:32PM +0800, Chen Linxuan wrote:
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

