Return-Path: <bpf+bounces-74104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F65C495CF
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 22:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52783AE48D
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D842F7ABA;
	Mon, 10 Nov 2025 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzK2pMWu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2432F5A3E;
	Mon, 10 Nov 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808920; cv=none; b=WiSNx0GHub7JAu923VihQ+bFB+cclFFVw4lfEAmmMWSBkx+q+YNr4vKYUC49gbnYfx2+k2YumRd7yV5MQv7/T5z0bLidX8DgpAuSDZCn2+qvNJzkiS6Ywh26pDiQbmphQdxRS3pyc0cuRDOMwqPJmXTaTf6CNzAGxWEpxFtlb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808920; c=relaxed/simple;
	bh=WmucaFrI7bJuofCDaZRNIC+CayWlzp1M5K5cIAKTE1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKk2vRFCvkUK2ns3/Y0RAKI86Qat60c6vBUBJ1MocpvuP/c2E8DUXM7wtImySk8quyp8NFRFyQnDNn5RuMKtEo1Wwg2Iqv2dI2DnS+WHaYHSWe+TQZsVTIpXLLA1zn9dJavdP8s3kpmmo+3zvBGhKbKraG8h853/QkR1XEqrWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzK2pMWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35F1C116B1;
	Mon, 10 Nov 2025 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808919;
	bh=WmucaFrI7bJuofCDaZRNIC+CayWlzp1M5K5cIAKTE1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzK2pMWuVz3sx1/VAZ+bnvTBIVzDeFyWdopXWJCN0QXNVvvAgz/CLqWvLeb2jH6Sv
	 BNpAFiMMFNItLBfwv3XcKAV7CAvM3IcEnlyJTZqaDemuhfKuxQYD6PTiUwyJ+VEM6Q
	 VN0I+K4SrpW0OeqrCjFWuhud2QfcT2FWMXCottIz8tYwdP1XUFR999gJrC8EVxcrdi
	 vSjgLwplYB/q7R1wlkF0r5q9M63nr9Eho62ZHjovpbJsPoGl100MDYqr0cslBdZD8z
	 ZvHY8I8AXzZYtrxI262MqH213vGMGcx08l2AIeiaEeGz20lPLgogHfNOHhdSNS/RH0
	 uThAo/VD5hBxQ==
Date: Mon, 10 Nov 2025 14:08:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jens Reidel <adrian@mainlining.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] mips: Use generic endianness macros instead of
 MIPS-specific ones
Message-ID: <20251110210835.GA302594@ax162>
References: <20251108-mips-bpf-fix-v1-1-0467c3ee2613@mainlining.org>
 <20251109233720.GB2977577@ax162>
 <alpine.DEB.2.21.2511100050330.25436@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2511100050330.25436@angie.orcam.me.uk>

On Mon, Nov 10, 2025 at 01:34:19AM +0000, Maciej W. Rozycki wrote:
>  Also please don't review changes based on assumptions, "I assume GCC 
> does[...]" means that you just don't know (and it's trivial to check).

Yes, that is totally valid. I hastily reviewed this when I should have
taken the time to check but I did not have a MIPS cross compiler
available locally to test and I forgot that I can use Godbolt for that
test. I'll be more mindful of that in the future (or at least being
clear that I did not actually check but it should be verified before the
change is merged without providing a tag).

> target macros.  Since our current GCC requirement is 5.1 it will be fine 

Just an FYI, the minimum GCC version is 8.1 since commit 118c40b7b503
("kbuild: require gcc-8 and binutils-2.30") in 6.16.

Cheers,
Nathan

