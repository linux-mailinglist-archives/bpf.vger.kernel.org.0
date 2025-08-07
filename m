Return-Path: <bpf+bounces-65174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A11B1D00A
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 03:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB888564C7C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DB192B84;
	Thu,  7 Aug 2025 01:19:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6F33086;
	Thu,  7 Aug 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754529540; cv=none; b=ONkCo9d6gQfCPFx+vJN6Y9G45VwQWifLvXjbkBA0p88uRu/h0ue7RlsLdDt55Mi77tCuyzXOgXgfaZxzVaaJWuxkXEWIbTD9fSeiHCxv9FoheBQBD8ZpqVonMgnWpbcb2WLd6j4HWOALphd1ON7NzLTFN0ngMY55SpF5PJcZIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754529540; c=relaxed/simple;
	bh=sjGdSJg31+LrX/xww66nsqAGYZC6lRh/yOAl/7S3yo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJo8NseoTI1ZMurOQO8htgZqzNJOPwYV27frD9UNVA03P1cWuDxJBnCHnXCNz4h1WavoYDtjQ/Oq61LEZ36nXqirvfHv7PpmHFQ1FSIfnsnL/PhXnG0w0rVXK/IJnaJ8iiRwZJZDwqFXO0DPkpue2ZdlYQNPMLJYK4rWWF5CXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 20C53E98; Wed,  6 Aug 2025 20:18:55 -0500 (CDT)
Date: Wed, 6 Aug 2025 20:18:55 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of
 capable(CAP_SYS_ADMIN)
Message-ID: <aJP+/1VGbe1EcgKz@mail.hallyn.com>
References: <20250806143105.915748-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806143105.915748-1-omosnace@redhat.com>

On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but instead
> use bpf_capable(), which checks against the more granular CAP_BPF first.
> Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
> under SELinux, as privileged domains using BPF would usually only be
> allowed CAP_BPF and not CAP_SYS_ADMIN.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
> Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

So this seems correct, *provided* that we consider it within the purview of
CAP_BPF to be able to avoid clearing the branch history buffer.

I suspect that's the case, but it might warrant discussion.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  arch/x86/net/bpf_jit_comp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 15672cb926fc1..2a825e5745ca1 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2591,8 +2591,7 @@ emit_jmp:
>  			seen_exit = true;
>  			/* Update cleanup_addr */
>  			ctx->cleanup_addr = proglen;
> -			if (bpf_prog_was_classic(bpf_prog) &&
> -			    !capable(CAP_SYS_ADMIN)) {
> +			if (bpf_prog_was_classic(bpf_prog) && !bpf_capable()) {
>  				u8 *ip = image + addrs[i - 1];
>  
>  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
> -- 
> 2.50.1
> 

