Return-Path: <bpf+bounces-34914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA219326FC
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825731C20DA5
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F919AD40;
	Tue, 16 Jul 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W8RPYYOI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD52197A7D;
	Tue, 16 Jul 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134687; cv=none; b=mMuOYn8ej3eMlKwTsFzPjiLFt67cLK+nR8WSlwJWNODSzwU1sCCpJgsWvXRw0dO1Obnfum7qWDhCN7U2SsxcsH8/pMNVDVJdqmdEU01NZJ/1HCsYDtXGdPVCcZUCmtW7GTQnbgjIOWN6MeUJ9VmobbkFYn+Vfo+TMMXIhAD7WXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134687; c=relaxed/simple;
	bh=GA6xHKFSNTlUydN0bn4CgnfTPbXBgRXo/quRJcdiBYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNmNGbXVTZB+bfPflimrrXEm5A/BPlmAlJzcqQCYDBGGcn/JNCm+xJpPD0COxjdv1ZSGviPwRXd/zCZr1yKeBCOwtxpTWlzsOHPhwdY+L/9p0LYD+3FH8wserEvOhmxYWowrAeJYvZzn/toCzPHL9pqmaJ9mD8FNhF8l+QvAp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W8RPYYOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD8C116B1;
	Tue, 16 Jul 2024 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721134686;
	bh=GA6xHKFSNTlUydN0bn4CgnfTPbXBgRXo/quRJcdiBYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8RPYYOI3SoDM1NRJps1z10Pt5Z/nCWGyGFb/vqRj9y3gMXoPZPqxwEPjWJJDzhBb
	 QPS/01lp1dI7RUfNsNdp3AmABd3lHckV+8svyRVbgerI5lM02w6YXWInS09x0eayvM
	 o8xWrkPbKqIsZ4MvbEmsCMNz2sdxNtwPZzvkQ8+A=
Date: Tue, 16 Jul 2024 14:58:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Russell King <russell.king@oracle.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10] arm64/bpf: Remove 128MB limit for BPF JIT programs
Message-ID: <2024071656-valid-unpleased-d29a@gregkh>
References: <20240701114659.39539-1-pjy@amazon.com>
 <mb61py1617bua.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61py1617bua.fsf@kernel.org>

On Tue, Jul 16, 2024 at 12:36:29PM +0000, Puranjay Mohan wrote:
> 
> +CC Greg

Why?

confused,

greg k-h

