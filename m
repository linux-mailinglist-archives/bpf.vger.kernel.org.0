Return-Path: <bpf+bounces-54159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7BA63E11
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89CD188C232
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C0214A9C;
	Mon, 17 Mar 2025 04:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LHRPolUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="meyFymZf"
X-Original-To: bpf@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71366A59;
	Mon, 17 Mar 2025 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185212; cv=none; b=sTIXwCADwWbMqrT6ZRDaQFsGnk1WEPyarT27fbY6/sfMQAizSuRIbw4omsUpDbTMUd6znfeBGUJuOQXlygQ/T7gy52qxw+9U+q+lfRQNOZokNIVct06/TcZwVJodE/Tfx0FZd5HS337VNLYP3gt25T52yclWSw8mtirWHxQ8a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185212; c=relaxed/simple;
	bh=/8FiYef5d99uCy0bDydFDdgkV/npK40z7TQ6Wa3apfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFn2+JpCz2najOB9VSFUOhdZu3R/j/g9W0S37cwTB9Z7uR0aCpWFXIznYYm51uSXJlJ9bxFf2E1bcvehysKr1eaB0CvPpHxPUFbF+ObJEHfrV6YSRfRw9p3nL4c0AC22zd3+iKzEVoJjicMZl0yTWKYR+GQt3HSeSrw1MWMs8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LHRPolUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=meyFymZf; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 57D551D41340;
	Mon, 17 Mar 2025 00:20:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 17 Mar 2025 00:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742185207; x=1742192407; bh=sB2Vv7iTl6
	/85KF2Q7eb4AEAere1+nDFaUtjRjzwOaM=; b=LHRPolUi5saPu1XiZVS3ParkbA
	kx00UA6CNHfLPEKuTVKT+cLj4948DZFHx6q4hhfD4SP9CVXxfZE14iiS0pf70rIs
	8+B8DnaTY1tFKDkjcfLPJIinTzFSyLXMEE8EJrekv8fh0cpV85XScCNbKgHnD89k
	n8lGrhmJwxpU+Hop30iWD31kcRdxcAckOiEEif72sJRx7vKfy/uCM5weIzNG1RUk
	sr48gPHqkJBGeD3L2pLZ/mZy7+zR4g43jLcx0iURNwBKTqex+kVceEtXE78SMv93
	53d0PIcppu3j7bPJGJREUpt5OqUg3X6PtR5aLDqvO3y+dzyAkXCN2wWpJ/jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742185207; x=1742192407; bh=sB2Vv7iTl6/85KF2Q7eb4AEAere1+nDFaUt
	jRjzwOaM=; b=meyFymZfR3uTVY+cLQHjkQTdqrcQSft4BF7vNgjwKf5GNvxO7Jl
	vf4/MKK5K8DbtYgK0oze7sOBGlRWS6DZeKgjC5mtvOuPl9BfX7CA1UEheRxfoRsh
	ZvYB0mkxToAW3UQcBhxrMBzHigNvQYym+2/r9SYeYr0RYVOogb6EJFZFFlppIiWF
	l0hTkGJOoYlik2wVP+qT3lDroWYkdX9OHEjo0ZadBaeUFMNu5TIf/Xk/znKbjIVK
	wMJKfMMcRKD12dwok1iNfAPEWllWgfUCB0q7O0BvY0bSLTJG7g8Q+gXFfVPKgqJW
	CcsC7xt+jJV14I8X7b8D1ZMff/qgzLzLucA==
X-ME-Sender: <xms:9qLXZ2whe3XnVtD7p6uAYXyUXaBMlF4qDvoFO9hqxIpLkBY0bt-SVQ>
    <xme:9qLXZyRf-mRRzq8PaHSfzMJGYVix01oj9OaZepb0Z9Xa5j36zYIcYD_8UKkC8GiKs
    DmeRgsjsh-ZZg>
X-ME-Received: <xmr:9qLXZ4UypdR-W64LjvfJi2Ttbcg_2rg12oGDP_8ojVQr9lbnXZYJLsqHGsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepfedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gthhgvnhhlihhngihurghnseguvggvphhinhdrohhrghdprhgtphhtthhopegrnhgurhhi
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    ugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgrkhgvvghlrd
    gsuhhttheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:9qLXZ8hsOSOPmrpMr7z25rfUo7kihDS248pcC4iG3YixAqqPZAc6Gg>
    <xmx:9qLXZ4DF0ovr4P35nfGjfNgtdBde2-YXbbwlEd5ClfIX0Iz3OuHb5Q>
    <xmx:9qLXZ9KzFXk2ZZEkes0H7D4sLeQRLcJ8F5cWTXw6Og9N_ia2skh2tA>
    <xmx:9qLXZ_DNAWLN4SP871nOuwGG3K1MWGVETN4xqn9s0Diq8r7kLxQ15g>
    <xmx:96LXZ5gxKLYoTJrau4DWGESssk316THjwidXZy3dOa2g5pM13hThXWF2>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 00:20:05 -0400 (EDT)
Date: Mon, 17 Mar 2025 05:18:48 +0100
From: Greg KH <greg@kroah.com>
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.6 v2] lib/buildid: Handle memfd_secret() files
 in build_id_parse()
Message-ID: <2025031759-sacrifice-wreckage-9948@gregkh>
References: <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org>

On Mon, Mar 17, 2025 at 09:16:04AM +0800, Chen Linxuan wrote:
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
> [ Chen Linxuan: backport same logic without folio-based changes ]
> Cc: stable@vger.kernel.org
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> ---
> v1 -> v2: use vma_is_secretmem() instead of directly checking
>           vma->vm_file->f_op == &secretmem_fops
> ---
>  lib/buildid.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 9fc46366597e..34315d09b544 100644
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
> +	/* reject secretmem */

Why is this comment different from what is in the original commit?  Same
for your other backports.  Please try to keep it as identical to the
original whenever possible as we have to maintain this for a very long
time.

thanks,

greg k-h

