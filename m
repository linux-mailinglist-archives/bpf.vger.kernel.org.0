Return-Path: <bpf+bounces-31508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0E8FF175
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01651F23DCD
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB8197A8E;
	Thu,  6 Jun 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpXT9UyT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BD197525;
	Thu,  6 Jun 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689508; cv=none; b=JMgQk+DGkRKhHxiexEgyH6gwQ2nSHu98K/N57u5ukLKgr23noQ1tWhXov4y5cesfCvZXpYI5S6A762iPjlyHka2BIO7WOEHmOdnqnuOjYk/Yk8rs1QRVVlg1l6fxoyDOJtaKHvKryInuWGAUq3b1aRP9SY0q2+YpyxxY6bVOWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689508; c=relaxed/simple;
	bh=qwzd4wpBEJVdaLunxRBZ7Jd0JMtaaH6BRBPJ691w9i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEfQ8ppWh+p3gifPjr0RycF5vsvjcRQr5yusUd/Tb60KcUSPX3AwBHeY0RmmJAia7XxsJTM3LbYC9UylHzoEAlPlYd0Ifi5d6eGWjvjqS/h9Xd9ezIfvGzq1XfE7DaLZ1Ze5KOt4IPPTPZ/asGIVocwtHHUfJhZQxgZY/SH/NAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpXT9UyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D69C32781;
	Thu,  6 Jun 2024 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689508;
	bh=qwzd4wpBEJVdaLunxRBZ7Jd0JMtaaH6BRBPJ691w9i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VpXT9UyTkhAKsFvVBXFGXak386aXOYvUoED6KV5cMimr2ot4PeNI0WcC1cJ3ANlgL
	 w+XFtrQUSY+GCQ2D2OkY8pZpVd6bBry4o9Tm3Vicg+Vlv28VT1FsIM52UQ3xY/UdVO
	 vPdSKmZx/O+wg+cQEk/Aur6skHAuCW6wN8YTtI6DzRwL9ytlp8IpsTlh3oBDeTi4Bq
	 zgayIik4sSgi1dSmiuECK58oACjmLOCmJVDb0376RwW8kkmhJeb/nLtNy8gTnad8LC
	 fe42ICnpbDz+S45p5neTXtgE37+p/Hkc9XoCRjwclk6oAPEq4NW3Csq13lXKMBchDv
	 8F5R7zbtJLcAw==
Date: Thu, 6 Jun 2024 08:58:27 -0700
From: Kees Cook <kees@kernel.org>
To: KP Singh <kpsingh@kernel.org>, paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org,
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org,
	song@kernel.org
Subject: Re: [PATCH v12 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202406060856.95CBD48@keescook>
References: <20240516003524.143243-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516003524.143243-1-kpsingh@kernel.org>

On Thu, May 16, 2024 at 02:35:19AM +0200, KP Singh wrote:
> This series is a respin of the RFC proposed by Paul Renauld (renauld@google.com)
> and Brendan Jackman (jackmanb@google.com) [1]
> 
> # Performance improvement
> 
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benefitting
> the most.

Hi Paul,

With the merge window closed now, can we please land this in -next so we
can get any glitches found/hammered out with maximal time before the
next merge window?

-Kees

-- 
Kees Cook

