Return-Path: <bpf+bounces-77895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF755CF606B
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 00:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1825302BF6C
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B802D7DCE;
	Mon,  5 Jan 2026 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdb/+SAI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6E2836E;
	Mon,  5 Jan 2026 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767656770; cv=none; b=oBNYxicAgd8LyKHT2m0yRnym8NaeXikUXRV5JhVHP6gCVisyAIHyvSC9wEJhq+YJGLTwVDQ5jkSlsVgS1Jr25k6MxLlJik0EtCKBMvJAru4V0431YuTmybqyRFobFNPHdKTGifvgsbtPRs/gZCF0ZqEG+KPP+WUXBt1opgYkqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767656770; c=relaxed/simple;
	bh=dvIS49jbsB+FpD9rVQ/xwSlM0vYensYCvpHNdfR853g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2Co7rRNbRgicNppyUJjqPTVh1bd0DN0YtLJZ6Lk1DN+nDgM00TD2kyekwcWX7GCnCfYz4gs9mK8Yu2Tp4b4TISNjujw1HPrz1fsDDaSLdq9Vq1mouxM4VPYIZ7e0n7s479k04e9RJYLefgONCSyH4BBjobvsYwXTrAwPvIQuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdb/+SAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE1BC116D0;
	Mon,  5 Jan 2026 23:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767656769;
	bh=dvIS49jbsB+FpD9rVQ/xwSlM0vYensYCvpHNdfR853g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jdb/+SAINQcEyGffd+mvJMEToFc+bpGUdfmefBXU/EWBqxYCkjumV/VeAy6ke2Ix/
	 Yd2IqNunNAyjGRfJuMcsKc3m5zKMPWksQXpDiwUiGhE3izDb2WHK6Uyx9bdxVWzreb
	 tUq+H9am9B0aR+lbqvtVcc3xYznpWJ6AZ6nqAuy9mZPYy40oK8kdKUGtzd+n3E90+Q
	 31zFL++axBoA6J6ycaQTqtnCeMUWHdp05uGJstyyKzdndiYBEt5ZLcEAikq7lzoBxG
	 E4JnfwvRwzptJ8i0h6xkZFrxnGK8wEZiPougsyWVauZ3q+3wjfiWUuIMPMtcFGJ0sG
	 geOQl3dSrHSDg==
Date: Mon, 5 Jan 2026 16:46:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next] scripts/gen-btf.sh: Disable LTO when generating
 initial .o file
Message-ID: <20260105234605.GB1276749@ax162>
References: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
 <ff8187bd-0bae-4b49-8844-6c975a2e79c6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8187bd-0bae-4b49-8844-6c975a2e79c6@linux.dev>

On Mon, Jan 05, 2026 at 02:01:36PM -0800, Ihor Solodrai wrote:
> Hi Nathan, thank you for the patch.
> 
> I'm starting to think it wasn't a good idea to do
> 
> 	echo "" | ${CC} ...
> 
> here, given the number of associated bugs.

Yeah, I was wondering if a lack of KBUILD_CPPFLAGS would also be a
problem since that contains the endianness flag for some targets. I
cannot imagine any more issues than that but I can understand wanting to
back out of it.

> Before gen-btf.sh was introduced, the .btf.o binary was generated with this [1]:
> 
> 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
> 		--strip-all ${1} "${btf_data}" 2>/dev/null
> 
> I changed to ${CC} on the assumption it's a quicker operation than
> stripping entire vmlinux. But maybe it's not worth it and we should
> change back to --strip-all? wdyt?

That certainly seems more robust to me. I see the logic but with
'--only-section' and no glob, I would expect that to be a rather quick
operation but I am running out of time today to test and benchmark such
a change. I will try to do it tomorrow unless someone beats me to it.

Cheers,
Nathan

