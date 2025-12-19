Return-Path: <bpf+bounces-77136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB55CCEDAE
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 08:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 147CA30122F1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271C2C0265;
	Fri, 19 Dec 2025 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAs528FQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A71DE8AE;
	Fri, 19 Dec 2025 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130907; cv=none; b=ZWdv9QEXU0lQtHXYtm3UmI/JeJICdEO8safqad6x1YXq+keaceAJx0h0ghfmHbJhbI33CkUU7yR0YcEDUgMRoXs75q54y4NnApNbv3Ys5BnGNmB1T4RZsdc4clmY4pjaOjVMwuginD115M8qoDqqMhGrbHTl99T1UhcZ5fPvcTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130907; c=relaxed/simple;
	bh=cRqy5SMxZBEEUhWLiniqceALJQlzCGDWTLiWzjfMohA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgYRNb7CvWyk9pMhU/qBQrNihRdfVwEUig2oSyfzcCLm3ZA0mSQ1BHhOfPzqBUZY6dCMVLTz7NW+UPuvIggK6XLNBeBp5sDV3myLBr8gf2mS8B1zmlKRWreNhuOgG8Ur3P36KnL6BCPRkFd5n8EOkG+7qwQsM34S9bvS9si1HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAs528FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB8BC4CEF1;
	Fri, 19 Dec 2025 07:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766130906;
	bh=cRqy5SMxZBEEUhWLiniqceALJQlzCGDWTLiWzjfMohA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAs528FQIHLEdBLraQXuxmlRSxN9dVa0VrY6O6KLY0sLXW3KQDaMKhBxnp5x7j3Tq
	 IoVQixBxcj6BHwWmwrYu8tufd0wA+mn1XRp3/U0Y7YkbIS5i0pkEw/1uLb4NRG2HUm
	 FIm+Fj/7CfabRJ3APBXJ9Kv0h8ulb4A8HcerrLxq/evxRXKqSj8dPHZPso8a9O542U
	 tUzJt4bcWpv2rczCzAhHQXLZSOZdjIc787HC5Nu+0glNa8WWQqZwf33nCUqYmwZ+jG
	 dgwf8ZqjXPFPGSrRlwmRVdkhgdW5nbm2Ck9wmu0rRaFIDV6yQc1b2u/XrJWX8NTgne
	 SV7UnF7moiOPw==
Date: Fri, 19 Dec 2025 08:49:27 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH bpf-next v6 5/8] kbuild: Sync kconfig when PAHOLE_VERSION
 changes
Message-ID: <aUUDh1BkRcamDI9a@derry.ads.avm.de>
Mail-Followup-To: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251219020006.785065-1-ihor.solodrai@linux.dev>
 <20251219020006.785065-6-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219020006.785065-6-ihor.solodrai@linux.dev>

On Thu, Dec 18, 2025 at 06:00:03PM -0800, Ihor Solodrai wrote:
> This patch implements kconfig re-sync when the pahole version changes
> between builds, similar to how it happens for compiler version change
> via CC_VERSION_TEXT.
> 
> Define PAHOLE_VERSION in the top-level Makefile and export it for
> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> variable.
> 
> Kconfig records the PAHOLE_VERSION value in
> include/config/auto.conf.cmd [1].
> 
> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> between builds, make detects a dependency change and triggers
> syncconfig to update the kconfig [2].
> 
> For external module builds, add a warning message in the prepare
> target, similar to the existing compiler version mismatch warning.
> 
> Note that if pahole is not installed or available, PAHOLE_VERSION is
> set to 0 by pahole-version.sh, so the (un)installation of pahole is
> treated as a version change.
> 
> See previous discussions for context [3].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/kconfig/preprocess.c?h=v6.18#n91
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.18#n815
> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@oracle.com/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Makefile     | 9 ++++++++-
>  init/Kconfig | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e404e4767944..9b90a2a2218e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -713,6 +713,7 @@ endif
>  # upgrade.
>  CC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(CC) --version 2>/dev/null | head -n 1))
>  RUSTC_VERSION_TEXT = $(subst $(pound),,$(shell $(RUSTC) --version 2>/dev/null))
> +PAHOLE_VERSION = $(shell $(srctree)/scripts/pahole-version.sh $(PAHOLE))

As PAHOLE_VERSION is handled in the same way as CC_VERSION_TEXT and
RUSTC_VERSION_TEXT at line 736/737: could you please add it to the
comment above, too?

Patch looks good to me, thanks!

Reviewed-by: Nicolas Schier <nsc@kernel.org>
Tested-by: Nicolas Schier <nsc@kernel.org>

