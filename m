Return-Path: <bpf+bounces-43824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4C9BA3F4
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 05:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D192B2139D
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 04:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E1136672;
	Sun,  3 Nov 2024 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JEBnm2Xf"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B93F9D5;
	Sun,  3 Nov 2024 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730608801; cv=none; b=qrfzTEuXFhcn5nLbbvb/A46EgtP5UAgLneifZ1Mg99yE0PbsP/s9M/PGI0aCELCp0ofhFjm7EFR3VPsht5+/amxrGz2NRISS/fSSC+f8jqVjCscfg5vyEGJzWLVzPlAfdp1y6UQIngTLBAtOlNbLDFTZmELf55urSzBF8Hn5+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730608801; c=relaxed/simple;
	bh=7m6MQPEFU2NaS8qN6JUNJTCkTwajzXU0ht1zJeuUWCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7PjZ83ZfVrC8VK7PpBbjvK8zaAXJ3jkKRklfElipv/Y0+8q5uAWwx4HVCqB2cerVW7ZegLMFC5IZCzRkXiLV385ND/1vCjvsiS3uWGP46x3f9NxABQqFPZee1Cz1ximimYGD82cbUMhngW8Ym5xrfb7JPbNzto9JeV0NGBZ1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JEBnm2Xf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730608785;
	bh=7m6MQPEFU2NaS8qN6JUNJTCkTwajzXU0ht1zJeuUWCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEBnm2XfnpG3T6Hna7nKdGQrXlMN64+x9O7j5VlgUw6IUIIcdAave58+atWkLQMYo
	 kvkAJ6SSE8UN8gXh0zCSabT3HsTVDG3BRx4kFhVrDgI/FcMFD00nAWmxr0B2+Unhtc
	 9PTNtmWRiNFEAoxRpnriVoG+h7YfuDF9stPlDYk8=
Date: Sun, 3 Nov 2024 04:39:38 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Peter Jung <admin@ptr1337.dev>
Cc: jose.fernandez@linux.dev, Christian Heusel <christian@heusel.eu>, 
	Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH] kbuild: add resolve_btfids to pacman PKGBUILD
Message-ID: <ce5b3247-c682-47f1-b503-154b5d48bffc@t-8ch.de>
References: <20241102120533.1592277-1-admin@ptr1337.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102120533.1592277-1-admin@ptr1337.dev>

On 2024-11-02 13:05:26+0100, Peter Jung wrote:
> If the config is using DEBUG_INFO_BTF, it is required to,
> package resolve_btfids with.

This sentence sounds weird.

> Compiling dkms modules will fail otherwise.

Maybe we should add it to scripts/package/install-extmod-build so it
also works for all the other package types?

> Add a check, if resolve_btfids is present and then package it, if required.
> 
> Signed-off-by: Peter Jung <admin@ptr1337.dev>
> ---
>  scripts/package/PKGBUILD | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> index f83493838cf9..4010899652b8 100644
> --- a/scripts/package/PKGBUILD
> +++ b/scripts/package/PKGBUILD
> @@ -91,6 +91,11 @@ _package-headers() {
>  		"${srctree}/scripts/package/install-extmod-build" "${builddir}"
>  	fi
>  
> +	# required when DEBUG_INFO_BTF_MODULES is enabled
> +	if [ -f tools/bpf/resolve_btfids/resolve_btfids ]; then

I would prefer to actually test for DEBUG_INFO_BTF_MODULES instead of
file existence. This file may be stale when the option got disabled.

> +		install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bpf/resolve_btfids/resolve_btfids
> +	fi
> +
>  	echo "Installing System.map and config..."
>  	mkdir -p "${builddir}"
>  	cp System.map "${builddir}/System.map"
> -- 
> 2.47.0
> 

