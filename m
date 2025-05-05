Return-Path: <bpf+bounces-57327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A470DAA8EA2
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5333B7C98
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B491F470E;
	Mon,  5 May 2025 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sy7TwSLa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F71C8619;
	Mon,  5 May 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435317; cv=none; b=VTskD/FyVuSXSAfsAVZ+qAfwsTWdKYXJGAy9WNkje3c0oirDO1gRB/ipmI97/GrtoXRpr7HiCLB0wL7BwnrgWA8B+aMFp6hnAMxmbFkIVamkVu2MaOC7MKQgT7jGcWqqLaQHHmUDaISUmpAd/qRSujKVnRXdDzq+Oj4imkXkDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435317; c=relaxed/simple;
	bh=aZVYqeezCVcvz3UxPsyzeGLsLXp0o5X5SkWC2AuILwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXJPNN2ceFertGF2yZ9u4ejPOOm/SH+XFzPK5H1IlkGp3iY6KWOWKhBa68Bo2ZJyie1vNEa/X60XddVliHMEwwUYana0Xw2FkCOyffw+COyKd7Fv4akJeLAaKhVlB00NyguY0fPTeXOCwf/6a+RqzGyuqbebYleoAmmUmanSaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sy7TwSLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ED1C4CEE4;
	Mon,  5 May 2025 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746435316;
	bh=aZVYqeezCVcvz3UxPsyzeGLsLXp0o5X5SkWC2AuILwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy7TwSLax8aOzpWbglDpctcQWiCVFTd351UPI1HOsilk6i3xqgtJUZ7aD0kiweoQL
	 Z/+fEHj+XMpV1dByhkllA2HDuGqS5tWdQC86I/kYrEki5HdezkuuuAgYE7rtevwBZW
	 R6TEjwtRF6auTKoiIauPssA1SBJuLyqRvlpO5aFk=
Date: Mon, 5 May 2025 10:55:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>, Alex Davis <alex47794@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] bpf: Fix BPF_INTERNAL namespace import
Message-ID: <2025050535-cargo-transpose-2099@gregkh>
References: <20250503085031.118222-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503085031.118222-1-xry111@xry111.site>

On Sat, May 03, 2025 at 04:50:31PM +0800, Xi Ruoyao wrote:
> The commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> literal") makes the grammar of MODULE_IMPORT_NS and EXPORT_SYMBOL_NS
> different between the stable branches and the mainline.  But when
> the commit 955f9ede52b8 ("bpf: Add namespace to BPF internal symbols")
> was backported from mainline, only EXPORT_SYMBOL_NS instances are
> adapted, leaving the MODULE_IMPORT_NS instance with the "new" grammar
> and causing the module fails to build:
> 
>     ERROR: modpost: module bpf_preload uses symbol bpf_link_get_from_fd from namespace BPF_INTERNAL, but does not import it.
>     ERROR: modpost: module bpf_preload uses symbol kern_sys_bpf from namespace BPF_INTERNAL, but does not import it.
> 
> Reported-by: Mingcong Bai <jeffbai@aosc.io>
> Reported-by: Alex Davis <alex47794@gmail.com>
> Closes: https://lore.kernel.org/all/CADiockBKBQTVqjA5G+RJ9LBwnEnZ8o0odYnL=LBZ_7QN=_SZ7A@mail.gmail.com/
> Fixes: 955f9ede52b8 ("bpf: Add namespace to BPF internal symbols")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  kernel/bpf/preload/bpf_preload_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 56a81df7a9d7..fdad0eb308fe 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -89,5 +89,5 @@ static void __exit fini(void)
>  }
>  late_initcall(load);
>  module_exit(fini);
> -MODULE_IMPORT_NS("BPF_INTERNAL");
> +MODULE_IMPORT_NS(BPF_INTERNAL);
>  MODULE_LICENSE("GPL");

Ick, sorry about that, I thought I had fixed this all up.  Odd it never
showed up in anyone's build testing, I wonder why.

I'll go do a quick release with just this fix in it now to get this
resolved, thanks!

greg k-h

