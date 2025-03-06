Return-Path: <bpf+bounces-53517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90140A55AAF
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 00:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905213A63EB
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D67327CCFB;
	Thu,  6 Mar 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="idHuknNe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69322E3373;
	Thu,  6 Mar 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302493; cv=none; b=j1ZWpEKWeUxUExLA8Y8IcaVp+rMyhhUtkmpvL/q4LSDaq/0XE7EngtsozsSNun399DfttSwSxhlVfiX9H+LFCDkxQcppOuQYEhlxTYbrbFR0p6aC2dwgZ9e9tiROW2fHnUEFhBXb5OMSh0cgYPxuVuxslh91uGTbtbuBVUtzeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302493; c=relaxed/simple;
	bh=gdiLxNe+cuFtEVaVP6C1N8H5pKPp/kWedV69oKhqvpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=smo1c9uIRkYXwzUdNBC4fQRg4+3lxPvw5bP9hGNlWdQs2T7yEZy8EiPJ5U3VptB8TZsA4O6AfUC1zFYQ7oLxz1KkJxCT6Pvn0v67BeVexQChThC5357z+ugKEOcHeAH1pug5WS/Tnh6O/ypuP1k/b7Ec4SyemjFR9+gsbQwX9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=idHuknNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC272C4CEE0;
	Thu,  6 Mar 2025 23:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741302492;
	bh=gdiLxNe+cuFtEVaVP6C1N8H5pKPp/kWedV69oKhqvpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idHuknNetz/6HtvrBB+RJu5ynAcPLnxQhkPVhKXBMmy+Zc3PyQfpFIHjK/pVj9DuI
	 GOS8D8sJuIITtSG/OGfoL/dGmz8zblwrmqJGQ1D812pCyj60mvXmzJbX2tdMh336CT
	 g94r8DhVOgkWdxbjtSzrDnZTQeKXA9nAQz52+WGg=
Date: Thu, 6 Mar 2025 15:08:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Sasha Levin <sashal@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Jann Horn <jannh@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] lib/buildid: Handle memfd_secret() files in
 build_id_parse()
Message-Id: <20250306150811.a2a5fbf0919f06fb5f08178a@linux-foundation.org>
In-Reply-To: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
References: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 13:06:58 +0800 Chen Linxuan <chenlinxuan@deepin.org> wrote:

> Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> Handle memfd_secret() files in build_id_parse()") to address an issue
> where accessing secret memfd contents through build_id_parse() would
> trigger faults.
> 
> Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> This repro will cause BUG: unable to handle kernel paging request in
> build_id_parse in 5.15/6.1/6.6.
> 
> ...
>
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	if (!vma->vm_file)
>  		return -EINVAL;
>  
> +#ifdef CONFIG_SECRETMEM
> +	/* reject secretmem folios created with memfd_secret() */
> +	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
> +		return -EFAULT;
> +#endif
> +
>  	page = find_get_page(vma->vm_file->f_mapping, 0);
>  	if (!page)
>  		return -EFAULT;	/* page not mapped */

Please redo this against a current kernel?  build_id_parse() has
changed a lot.

