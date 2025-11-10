Return-Path: <bpf+bounces-74107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531DC496AC
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE8188E708
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E0340A79;
	Mon, 10 Nov 2025 21:32:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8333FE34;
	Mon, 10 Nov 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810334; cv=none; b=kKDYauzIW/uKeWceUIvecSkoeF7zwoG/etLV2OKI/tJHIstGnJuWszpfEkPPvV6NkX1Kb7aC4bTheKRGg48bu0ZlYm+s2S1zC8lFbVlMEsMtYI+k+UxKLcZRzD9e/hFIbMfiPCoEbjGWn0OEUG846MPIaeioGSEk/cEeAhZYj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810334; c=relaxed/simple;
	bh=zyD+iyCaoU+XwTxHLzAckqfMmgHVkkvY0FxEEiLLdow=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C58HzWhrCDd9xoTAuzRDgAe+lX6gueKds0/cXbas7Ae4sXN7lRTKZuxaC6J7fFqTVnBaBRyq+wUbqiwguSX3RR9X0sAUYnPib8EqYs6c6P9JUm+uKIcVLTCsbKMgMGo9KvgA1Pbnfbf8JMd/caQ/SxdST1g7eMbIDz61/S8puT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9900692009C; Mon, 10 Nov 2025 22:32:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 93FEC92009B;
	Mon, 10 Nov 2025 21:32:10 +0000 (GMT)
Date: Mon, 10 Nov 2025 21:32:10 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Nathan Chancellor <nathan@kernel.org>
cc: Jens Reidel <adrian@mainlining.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mips: Use generic endianness macros instead of MIPS-specific
 ones
In-Reply-To: <20251110210835.GA302594@ax162>
Message-ID: <alpine.DEB.2.21.2511102129020.25436@angie.orcam.me.uk>
References: <20251108-mips-bpf-fix-v1-1-0467c3ee2613@mainlining.org> <20251109233720.GB2977577@ax162> <alpine.DEB.2.21.2511100050330.25436@angie.orcam.me.uk> <20251110210835.GA302594@ax162>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Nathan Chancellor wrote:

> >  Also please don't review changes based on assumptions, "I assume GCC 
> > does[...]" means that you just don't know (and it's trivial to check).
> 
> Yes, that is totally valid. I hastily reviewed this when I should have
> taken the time to check but I did not have a MIPS cross compiler
> available locally to test and I forgot that I can use Godbolt for that
> test. I'll be more mindful of that in the future (or at least being
> clear that I did not actually check but it should be verified before the
> change is merged without providing a tag).

 Well, `info cpp' would have sufficed, no need for a cross-compiler here.

> > target macros.  Since our current GCC requirement is 5.1 it will be fine 
> 
> Just an FYI, the minimum GCC version is 8.1 since commit 118c40b7b503
> ("kbuild: require gcc-8 and binutils-2.30") in 6.16.

 Indeed, thanks, I looked at an older checkout.

  Maciej

