Return-Path: <bpf+bounces-28143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3578B6178
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F30A1C20A4C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AC13AA5A;
	Mon, 29 Apr 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EimzHSED"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EC839FD;
	Mon, 29 Apr 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417005; cv=none; b=K77mfcvxteRxhrbHMQ4W+ZpkH4VNNFDOfDsXMpdx4Gg1zdob/HHrjSvHbaD5XsG3GmpNbOOogm8GzFnGWvjaskpYFHcKXZt6Gm1EaRnd8bsDIag0yaVQZWYRZMEu/HFQYl5X68fBI5fRXT1lkDOhavcCik+SokqrtQlFiw+YJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417005; c=relaxed/simple;
	bh=H9Q95f6F5LwV4K5g2LuL9fA176ugt3P9s6YgDq8alk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euihEI5Mz3I2vN53AvYJiLf/7z3BEZT5QHvUKviYkRXD9suFaC4CpXBqsqObub5IC82CfDMAavkumTy2Lms6T4dMkK4h/51MxejWMr8ZJRF76aDdyFJrKhNLK6lFP5Q9LEQ9+KcbEyju0TiENkGuj+EW+Ue0EFeiMRccNr7Wrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EimzHSED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FDBC113CD;
	Mon, 29 Apr 2024 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714417004;
	bh=H9Q95f6F5LwV4K5g2LuL9fA176ugt3P9s6YgDq8alk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EimzHSEDVJ1X8wTQ/hEZh1CZyDeCB+JCrErM3IC3+QROiosYV62WhVkC8SVmKZhMC
	 NVSBNCuVCMLrzsfCt4R8bkLP8drNYN7d3d69RR6lPUES41rkQWmb9R2+Fzsq5k+AJH
	 XjSbYFT/MsdtYdjPJDoadTjYiYN3p7FkF20/tNJKgFd+YRn4/xJEQSRDow9d0t8Lj8
	 SZu6SpHy4AN+Y6QdJJiQKZkLExyehFWLyYQabpp73zH4DGiKWkQ32qF+P35mCdVe3s
	 K6TDWhqgTNy3NLfKSX9voLvOG9VOb0M7PC0IHHCTjMwZmqHKk0acxKr7HY4+lj7BIl
	 pD9laMsz5PUcA==
Date: Mon, 29 Apr 2024 11:56:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
Message-ID: <20240429115643.7df77e08@kernel.org>
In-Reply-To: <20240429114939.210328b0@canb.auug.org.au>
References: <20240429114939.210328b0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 11:49:39 +1000 Stephen Rothwell wrote:
>  +u64 __weak bpf_arch_uaddress_limit(void)
>  +{
>  +#if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
>  +	return TASK_SIZE;
>  +#else
>  +	return 0;
>  +#endif
>  +}
>  +
> + bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
> + {
> + 	return false;
> + }

Thanks! FTR I plan to used the inverse order, if that matters..

