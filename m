Return-Path: <bpf+bounces-74041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A9C44BCB
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 02:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D3644E6702
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C1221540;
	Mon, 10 Nov 2025 01:34:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985882253EC;
	Mon, 10 Nov 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738464; cv=none; b=bjWRhlw9JJIMfwN3Nkh2FENCa5iv2aTgeqSci9OD/ZbURHspP25RVG7YgwzApmTlnawpZvKuCDxwRcIPHENqkm+Akyv1SfhSOXw2NR/u22gqPnoAMDeXxT1OsxKtM+jlbp5ENSkrQWwdYGLJ5jpvJqZ+D2GhbHcWQeMTxzzkwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738464; c=relaxed/simple;
	bh=3JYWIvaj1c5j9XP/3QI8YGNqt2UATECg1x7BPJty3WM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rx+lkNGg6LCgxbndeM5X9af8/aRmVk1NIhUR8E0oJF+tE/X3Yx1toZQEaBdJricvNw2oBqHRqFad+Sgil1Ca6GPX4Ll92gLOX6dmcBSJEyb1nEt4KIvaPl+dGKazhIOdSOKk+MfHpFbwKZNuXjOuhP7DxSOUTOgWcbwRh60r5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 11B3092009C; Mon, 10 Nov 2025 02:34:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0D81392009B;
	Mon, 10 Nov 2025 01:34:20 +0000 (GMT)
Date: Mon, 10 Nov 2025 01:34:19 +0000 (GMT)
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
In-Reply-To: <20251109233720.GB2977577@ax162>
Message-ID: <alpine.DEB.2.21.2511100050330.25436@angie.orcam.me.uk>
References: <20251108-mips-bpf-fix-v1-1-0467c3ee2613@mainlining.org> <20251109233720.GB2977577@ax162>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Nov 2025, Nathan Chancellor wrote:

> > Compiling bpf_skel for mips currently fails because clang --target=bpf
> > is invoked and the source files include byteorder.h, which uses the
> > MIPS-specific macros to determine the endianness, rather than the generic
> > __LITTLE_ENDIAN__ / __BIG_ENDIAN__. Fix this by using the generic
> > macros, which are also defined when targeting bpf. This is already done
> > similarly for powerpc.
> > 
> > Signed-off-by: Jens Reidel <adrian@mainlining.org>
> 
> As far as I can tell, this should be fine since clang defines these
> macros in the generic case since [1] and I assume GCC does as well but
> if there is a risk of this being a problem for userspace, these could be
> added in addition to __MIPSEB__ / __MIPSEL__.

 How was the change verified?

 Certainly GCC defines neither __BIG_ENDIAN__ nor __LITTLE_ENDIAN__, not 
at least for the MIPS target.  Either the current macros need to stay as 
they are, or the generic __BYTE_ORDER__ macro can be used instead if so 
desired, which is target-agnostic and well-documented.  Preferably with 
the #else clause retained.

 Why is a MIPS header used with another target anyway?  It seems like a 
bug elsewhere.  If it's not a bug indeed, for whatever odd reason, then a 
proper rationale needs to be given in the change description.

 Also please don't review changes based on assumptions, "I assume GCC 
does[...]" means that you just don't know (and it's trivial to check).

 NB the __BYTE_ORDER__ macro has only been there as from GCC 4.6 back in 
2010, while this header dates back to 1995 when it was necessary to use 
target macros.  Since our current GCC requirement is 5.1 it will be fine 
to use this macro instead.  But as I say a proper rationale is required.

  Maciej

