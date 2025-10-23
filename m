Return-Path: <bpf+bounces-71941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF271C01F9C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147C619A5666
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB41D5AD4;
	Thu, 23 Oct 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjyAOad0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A132AAC8
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231918; cv=none; b=thxzcgRZghhHHu46MmYvh8FONmIrHJnhS9nXQNmnTg8FFV36MLirt+SmU4bzWTxAsbAzjdeg/Iave4CPhaCKdDcUWxtb6DSwgAwP3g2WyQNF1UFdF4rXz3cH0P1FKASSixyqcEg/Xna+WKL7TfYfiTSQpWHP2WEXSCNi5wHXeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231918; c=relaxed/simple;
	bh=hF5Pv5qLCCJJd2cynxhKvVBDZqBduAAiX2Q0bjJYFqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUw3fxIfSLKLvaIhk9/6sXdXx4XhlVW6IdeadLUEBqkhal9kdb5WfHJkDAM3qT1y3/gdVZDe4j/6ECa/RQpbsOmzFnu+Q51wdCKy68G7o+5waH3u3FvbXD3lKuSZSEM0ocdgjEOpZ1rhU2VAQlp8bY1EbGhS5IG2rdzrb6WhUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjyAOad0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D53AC4CEF7;
	Thu, 23 Oct 2025 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231917;
	bh=hF5Pv5qLCCJJd2cynxhKvVBDZqBduAAiX2Q0bjJYFqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjyAOad0ZtO3XRJ6b410p/4fccp2wO661B+Co5EYeu2YysQbBkGjqhZtSSCoaRNY1
	 EslK+ton4XdGzj8IGepMsOxRQDvgan87md4AAAq53kDsEmQR7jYFIZkayim3bKYobj
	 eTrX1djFz+sXklyJ4Fe+DszhJ8XsY2KlbNF7afYgTiNwsl8JKRPY8aW5SRMRk/OjbO
	 iVOnvRDWhqqgBDyen1ZOI9VzeA1V3G9haes1EdHjqxc+axfeNqAFdUOgyjt2lmvOXC
	 bnS9mGB0uh/imydOWTEewxiGJoNz06eUAEf+jkz9PzTsWa2lRoGgctRni/RrfKMfkt
	 DBRb70inKowGQ==
Date: Thu, 23 Oct 2025 20:27:01 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH bpf-next] libbpf: fix powerpc's stack register definition
 in bpf_tracing.h
Message-ID: <b4m7i5myohaf5gdx6u5vpyha3a5v4d72s4gtz77duamvgovmul@7pf6ahibwygt>
References: <20251020203643.989467-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020203643.989467-1-andrii@kernel.org>

On Mon, Oct 20, 2025 at 01:36:43PM -0700, Andrii Nakryiko wrote:
> retsnoop's build on powerpc (ppc64le) architecture ([0]) failed due to
> wrong definition of PT_REGS_SP() macro. Looking at powerpc's
> implementation of stack unwinding in perf_callchain_user_64() clearly
> shows that stack pointer register is gpr[1].
> 
> Fix libbpf's definition of __PT_SP_REG for powerpc to fix all this.
> 
>   [0] https://kojipkgs.fedoraproject.org/work/tasks/1544/137921544/build.log
> 
> Fixes: 138d6153a139 ("samples/bpf: Enable powerpc support")
> Cc: Naveen N Rao <naveen@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/bpf_tracing.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index a8f6cd4841b0..dbe32a5d02cd 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -311,7 +311,7 @@ struct pt_regs___arm64 {
>  #define __PT_RET_REG regs[31]
>  #define __PT_FP_REG __unsupported__
>  #define __PT_RC_REG gpr[3]
> -#define __PT_SP_REG sp
> +#define __PT_SP_REG gpr[1]
>  #define __PT_IP_REG nip

:facepalm:

Thanks for fixing this.
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>

- Naveen


