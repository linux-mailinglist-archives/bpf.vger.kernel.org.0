Return-Path: <bpf+bounces-32347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60B90BCA1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 23:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA601F228BB
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFB11993B2;
	Mon, 17 Jun 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoyR459Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF78178387;
	Mon, 17 Jun 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658493; cv=none; b=P3j46qoTsg0OHcBWFbVwrft3JxTRSTAC3sgEDavLocV4FxCSWiXoKwC4AJEeYwyjqfT+vkqAMiEohSLobmxEaH9THzaDP+dKgaFwF6Q1nOCwGidT7OkUkGPvf6Ax72F6X/hsDRlZdUaKGZzde7hnwKOma/37HS1gNvdQCBOGHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658493; c=relaxed/simple;
	bh=Ss6FJeA2CRfgRGYkjX/3RT7unUDiKEmAfAeeooXWAxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMJD4uXBI08f7Z/dPA6RHRiQ+GN+NHjh/UdKGs6itn0m5Wr0MXkOrzrHoCUuN4ichQJw101Gg35ccVrF9FSE3ufqkk6oOBDMnzUPKWjvLMpMiJqnsZprqgOy/OpKf/x6SAWQCZvSKIsC3ZGO4Wk1B9A+cZoZMbpUr7ouA/Fh4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoyR459Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F49C2BD10;
	Mon, 17 Jun 2024 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718658493;
	bh=Ss6FJeA2CRfgRGYkjX/3RT7unUDiKEmAfAeeooXWAxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoyR459YyCXmDCh+YASME7N0lKt+8B6FjS6eFst0KrSQenV1O3/JjaRNCQAW1Eg5p
	 QGctfgaqsQUCWPIvU6LGcaWVWOYY9y1OBnEBNlEqgJDKYosnQGjaKMUR+YZXkRtKke
	 zU6pyrDsOSBny0lWqLb0JW4ZCkj7lep1kXM+BYDfa/htEKJPC+8h/f2yXu3DcKmWo1
	 AlNRW+vpYJrcB1bnJZd5l84y/JD7/K3Xjir43Z8SWQdVzbxWY91P335ckI0DfGCnSr
	 fwLRZy3ogq2/GJGNwCiCjz/yljvP18UfV3bAJad9vi+aEgk9E4KmgHaVTvAKJZasjA
	 tkRAiXWAnSfnA==
Date: Mon, 17 Jun 2024 14:08:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>,
	llvm@lists.linux.dev
Subject: Re: [PATCH/RFT] Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF
 kfuncs)
Message-ID: <20240617210810.GA1877676@thelio-3990X>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <20240613214019.GA1423015@thelio-3990X>
 <ZnCQ-Psf_WswMk1W@x1>
 <ZnCWRMfRDMHqSxBb@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnCWRMfRDMHqSxBb@x1>

On Mon, Jun 17, 2024 at 05:02:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Can you try with the one liner below? We remove it from the cus list
> unconditionally, and since we alloc space with zalloc/calloc in
> cu__new() and missed initializing that list_head (cu->node) we ended up
> hitting list_del with a zeroed 'struct list_head' :-\
> 
> I'll try and get this cast_common.ko checked into a test repo for pahole
> so that this gets regression tested.
> 
> Please test this patch so that we see if this is the only problem and
> your kernel build with clang completes successfully.

Thanks, I rebuilt pahole with the following diff and both my build and
the other configuration I tested for this regression successfully
complete.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/dwarves.c b/dwarves.c
> index 1ec259f50dbd3778..823a01524a12bb37 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -739,6 +739,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
>  		cu->dfops	= NULL;
>  		INIT_LIST_HEAD(&cu->tags);
>  		INIT_LIST_HEAD(&cu->tool_list);
> +		INIT_LIST_HEAD(&cu->node);
>  
>  		cu->addr_size = addr_size;
>  		cu->extra_dbg_info = 0;

