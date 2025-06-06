Return-Path: <bpf+bounces-59904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45198AD079B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6F61895A59
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAEE28BA9B;
	Fri,  6 Jun 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKrEd67R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77817BEBF;
	Fri,  6 Jun 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231653; cv=none; b=oVUpD6vy/zrS42YrGucGMD1KmQe4h4CTyqRQD2/M+v1I/02ldM4pWcuC7mRvkH6KF3KWWji3TsZFmeWo8Qc80Mlm1PwSgXFwFvYsgyf1ixT1Kp/WIK2dLREZeFBzZYkUbhSkQSyAK7/IL2cWR3sR30Bi871CUHn1/Iy0py6dhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231653; c=relaxed/simple;
	bh=54VOQcTStIKGbHnVIUAzqcD8i0by73zBgA0CWwOBjjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzycyDrbfSl5tKs5CPuNAqbF1KdUHGuDdlkoYLw7q5YvACjY09cfzEDkapC2XcYw9CoK47uo+dhTNLJRBHtMGokYZUsgJaCXWici88KQUnp7O5Yr1W5QX3MbRNyoifMjoaIVBylA5HAFvxAZq8VSbD99NJ0Gity/7MGGmIHc2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKrEd67R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A6C4CEEB;
	Fri,  6 Jun 2025 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749231652;
	bh=54VOQcTStIKGbHnVIUAzqcD8i0by73zBgA0CWwOBjjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKrEd67R2fTruS57Ood3EPZOreFiG/yXVCDfGd5kNDAu5jpJSaS9Wmy07hWZrG0Hk
	 mbOrDy2La9ZZTQk9milgZlVK/itGwLHPZSO7YqR2uTzizf8CZNuV+ecPzl5jn350iJ
	 MLyNQBOCf7XzuqvrqXov+hsDZJrVlwFzaWh/btDa87sfxaDcfpKtX10en0vt0gVxEf
	 1dvWZ4v8XA3amwQjn/3u4iR+0Avyfkhl+k4O4xE4V9IiW4weSDlH/O1YKgnn1Y+4Ci
	 Lj8VDDOFcgZnAJgjnwP8UQgK5HiVFQf63zeh/XjYpr0370fvA3QNJcnwJyVXw4aF9V
	 I4ohy87wWUrOw==
Date: Fri, 6 Jun 2025 10:40:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, masahiroy@kernel.org, ojeda@kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH] .gitignore: ignore compile_commands.json globally
Message-ID: <20250606174047.GA4035746@ax162>
References: <20250605181426.2845741-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605181426.2845741-1-andrii@kernel.org>

On Thu, Jun 05, 2025 at 11:14:26AM -0700, Andrii Nakryiko wrote:
> compile_commands.json can be used with clangd to enable language server
> protocol-based assistance. For kernel itself this can be built with
> scripts/gen_compile_commands.py, but other projects (e.g., libbpf, or
> BPF selftests) can benefit from their own compilation database file,
> which can be generated successfully using external tools, like bear [0].
> 
> So, instead of adding compile_commands.json to .gitignore in respective
> individual projects, let's just ignore it globally anywhere in Linux repo.
> 
>   [0] https://github.com/rizsotto/Bear
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sure, I cannot imagine anyone actually wanting to check these in,
regardless of where they exists.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  .gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitignore b/.gitignore
> index bf5ee6e01cd4..451dff66275d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -175,7 +175,7 @@ x509.genkey
>  *.kdev4
>  
>  # Clang's compilation database file
> -/compile_commands.json
> +compile_commands.json
>  
>  # Documentation toolchain
>  sphinx_*/
> -- 
> 2.47.1
> 

