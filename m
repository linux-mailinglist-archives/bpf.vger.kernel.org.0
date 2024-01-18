Return-Path: <bpf+bounces-19807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34F831652
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B941F236F7
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECA6200DA;
	Thu, 18 Jan 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRfOJFZa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FE20B10;
	Thu, 18 Jan 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571923; cv=none; b=qf/gkYcMLC3qRxicAs3go4/86AxjITJ0OGz6YHwbb8YPvBdu/GcnpAldGPatggNd02zIY0AHMVFOJzoA/m6JbBaseLU2GkP6Ih2fDnE+pG+8ZfC7k+cxXo9WrFLxNegBOeZ+kH2HUy4FaxZo5i+PfORV/k0VEw9Qjqe+guTkjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571923; c=relaxed/simple;
	bh=Ali6VhBWvgEa8c3vvAdCoQmaY9kgbCr8S1JGwhC2gHI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=WfsxXdulo4su0NIRdNdm4+Qd/Is8cY0RXOvB3Ie+ScZEVPaQ/nC4mDEs+FJclnUoSSCE9CsfPwkpgx3ELkiRW+8Kl10R7tf1BlTDTnYuSOA+XMBV6XsGho9Mk9IMm/67G6SBk0+2ZoX8nlR4BprGGnA0tcx5boHtlFcP3iyKyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rRfOJFZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D343C43390;
	Thu, 18 Jan 2024 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705571922;
	bh=Ali6VhBWvgEa8c3vvAdCoQmaY9kgbCr8S1JGwhC2gHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRfOJFZatbNWICyCPcGR/P1336TSJmzcwCYLmmzjkk6+zN/tqViE0r7xIJTLrJeGu
	 EerVcl9D2CfleTpb2RbzsXCR0hbQPCQpNXYA7vmmgHzLDToiZymej5dGGev9YLXZgk
	 UuEpOB70DglCsjOQnvTi5PxkrC2THbgVDscKjS3g=
Date: Thu, 18 Jan 2024 10:58:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv2 stable 6.1 0/2] btf, scripts: Update pahole options
Message-ID: <2024011832-unsoiled-sublime-9d16@gregkh>
References: <20240117133520.733288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117133520.733288-1-jolsa@kernel.org>

On Wed, Jan 17, 2024 at 02:35:18PM +0100, Jiri Olsa wrote:
> hi,
> we need to be able to use latest pahole options for 6.1 kernels,
> updating the scripts/pahole-flags.sh with that (clean backports).
> 
> thanks,
> jirka
> 
> v2 changes:
>   - added missing SOB
> 
> ---
> Alan Maguire (1):
>       bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
> 
> Martin Rodriguez Reboredo (1):
>       btf, scripts: Exclude Rust CUs with pahole
> 
>  init/Kconfig            | 2 +-
>  lib/Kconfig.debug       | 9 +++++++++
>  scripts/pahole-flags.sh | 7 +++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 

All now queued up, thanks.

greg k-h

