Return-Path: <bpf+bounces-54141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78EA63433
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 07:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1CB1892127
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E031176AC5;
	Sun, 16 Mar 2025 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVAx48LB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AF8BE5;
	Sun, 16 Mar 2025 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742105617; cv=none; b=gs3WPI3JUPp+o5uLdYVfv+q916eKMIf7htPOPtBsNdNpK8yXCjn2w9SO6+vewiKVg1UddXOzG5E3kk+HsNVKUPmyCIzYB7W4bfA7yGC58m9rSRIUHzmFEaUAVhDRIq1wuWCbwTT5bFu2XanjOsHIwG2wcF3aqp/hBNN5l8uXSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742105617; c=relaxed/simple;
	bh=6cGBUz5aIol+ICzbCxvIpdgBgF6oR95SvmsvHtIWZGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhsW1su2pCrXjVTyhImz/KvDsfKZ/zy9a+Y43wqJ6Ul/KXhXMCne8KWwNPChwgHbyVQ1+dXUgOT+UF1g6kdmzPvBWxvVA3sYmoQD8lXqSsC+u7t4wn641BGT4IM/cJXF6XgRX9cKRGkg0UwhjlivqT7b9IO2PPMdd/HuR0Cz41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVAx48LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0759C4CEDD;
	Sun, 16 Mar 2025 06:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742105616;
	bh=6cGBUz5aIol+ICzbCxvIpdgBgF6oR95SvmsvHtIWZGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVAx48LBcbZr2Na7a9Q6+MR6zCrdXcGGNoBNRa653NjHZtAaQ3ohTwCDNiCpF3hlU
	 SjeUaR96oocKaQ8t7SzejjsGcN40aM1T6NgtlmhktdFShWq2B19uqoKh6aqO/Y2Ij5
	 z84gScWh0schCEFzmfBF4zNj7jOGwqf7pNETmA/4=
Date: Sun, 16 Mar 2025 07:13:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in
 build_id_parse()
Message-ID: <2025031645-unsightly-rely-25b3@gregkh>
References: <6F04B7A95D1A4D64+20250314064039.21110-2-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F04B7A95D1A4D64+20250314064039.21110-2-chenlinxuan@deepin.org>

On Fri, Mar 14, 2025 at 02:40:39PM +0800, Chen Linxuan wrote:
> [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
> 
> >>From memfd_secret(2) manpage:
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
> [ Linxuan: perform an equivalent direct check without folio-based changes ]
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> ---
> 
> Some previous discussions can be found in the following links:
> https://lore.kernel.org/stable/05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org/
> 
> ---
>  lib/buildid.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 9fc46366597e..6249bd47fb0b 100644
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
> @@ -157,6 +158,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	if (!vma->vm_file)
>  		return -EINVAL;
>  
> +#ifdef CONFIG_SECRETMEM
> +       /* reject secretmem folios created with memfd_secret() */
> +       if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
> +               return -EFAULT;
> +#endif

We really do not like #ifdef in .c files.  Why can't this use much the
same call it does in the original commit?  Just put that in the correct
.h file so that the #ifdef is not needed here, to make the backport
match much more cleanly.

thanks,

greg k-h

