Return-Path: <bpf+bounces-32985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29157915BCE
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21A41F224E0
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F01B950;
	Tue, 25 Jun 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpCzQxll"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC818637;
	Tue, 25 Jun 2024 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279687; cv=none; b=Q3daEtFMZP3eAjLmpR5SB124cBJafQvjjNJ3PSAORo3JU+Y7M2II5xE0/rHjJfdPXbGxrJGFBk/WPVoFfHj0PPac8LotUDgilK9H1qpv/aN3y1+jYvL7rYMetfw78qFUAFd8AsqvwRmd9JdVU1YUmkMWArxGtlpU2Gnsq4eY8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279687; c=relaxed/simple;
	bh=WSDNSDfBvIc+eX+Ow2RXKGPqoaGprM+e7kambKcLM3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtUhW/dFRnpCEfoi+c2O/6+ACEalnBIeQIBPTCBHkJfU53LaktWaESK1p7J3xtcresQ6scp21uFoOJwocDCLfSV7wsEfaHxuhYnoGiywK7pye4bd0OVVebdBhq3Puvd2FEiAYEzqwz6N2RErcRlT02lGdsLXlZNArLmT4VC0pvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpCzQxll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B477C2BBFC;
	Tue, 25 Jun 2024 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719279687;
	bh=WSDNSDfBvIc+eX+Ow2RXKGPqoaGprM+e7kambKcLM3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpCzQxllUjGOV3g+dUuf1zT+5Zj+oAFefYrt7+pzfhVGZ/XFkCDIRFHVgBEGN0yGV
	 c4bmtXL0cfGmsTRxqRff83QRVsHwM0uqs2NmsxSBZrnb8LpYsomEpmPKFKI9f1OZ/h
	 Oy2h1WosohuiwT2JRwcrmaM0LMHPsvqWT2owI1tbH0U/x7HuvyzxLOI/2BGjBcrE1g
	 y+BOPrfr8LZetoDVFwDyI1nVmv2akCkL9CAayFU923b5+dkmtr9D1h2j0mRtpIi09T
	 ME2r08qFxDCrs3rMMktOKDZDYVkdh98Glc6lzcDqGEcxEpmWNxtvvOxNHzvCRFV8/u
	 xd2hPwWeDj2Bw==
Date: Mon, 24 Jun 2024 18:41:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2024-06-24
Message-ID: <20240624184126.33322abe@kernel.org>
In-Reply-To: <20240624124330.8401-1-daniel@iogearbox.net>
References: <20240624124330.8401-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 14:43:30 +0200 Daniel Borkmann wrote:
> The following changes since commit 143492fce36161402fa2f45a0756de7ff69c366a:
> 
>   Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-06-14 19:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Bot seems to not be responding, so: pulled, thanks!

BTW was the ssh link intentional?

