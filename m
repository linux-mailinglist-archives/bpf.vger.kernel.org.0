Return-Path: <bpf+bounces-45327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8319D4768
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 07:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4348C282F2F
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD01A76C4;
	Thu, 21 Nov 2024 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNTLZfFQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF901CA84;
	Thu, 21 Nov 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732169095; cv=none; b=cfGLBOaSL5Agut1WAMRp+lT+g6Ainiw5XNzOPOk1lQjhuc3SYNijfEeM2rl8jthYrdOQPnANfJXlmlqAGZTx9yBONenuqCvN1+yReMVqnm9tiS9Ov7FuIiV5HqkQOVAc4fCfo8HTzaA7WUtMw85gE7LUOG7rHElWBL2cJjlH4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732169095; c=relaxed/simple;
	bh=5SzfSvmW6/EPTP4rQKZCAGqAdZ0pvivToAjN8Y2m9VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2PkPWHhjyUnSKaT696ety0i7OT5aFB0GMQve6db3lIDPo/INeEKyHqHNernVaSN70c4WOtEm9PRx8TQR1lgVyPC8DZCdqm857X+wHvf+Mn/UPDEcLowDIMoYZSnH5Hcagd7Ueigsw6xqNuA8CBMnYVgirPfo6YqyjiRr5PvT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNTLZfFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4073BC4CECC;
	Thu, 21 Nov 2024 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732169094;
	bh=5SzfSvmW6/EPTP4rQKZCAGqAdZ0pvivToAjN8Y2m9VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNTLZfFQdJoBGLUj/Pf2GLZJL1xjs3lT6zJqK68EcV/k1VghZ12lSCUsvVmtpqfkP
	 2vCJXXlH+JFp6qJOxbtoJ1yfY+gXOccwgKWHlo+Tc3KNksHIEUwMDSzrduOqSOxitA
	 /4wwoIV/n4bv4srSwtqkk3//3gXk1ej5lW8qno7wls9MiJkjkpAempHg/VSOZEovc3
	 2+64hp3/lyiYj0ZcIRB5dr5ZcaAsAVNxu6PP+TeEGRAyQWgzgtl94iGePzfGM0v+BZ
	 O1dI2gYBUkCAuVeBHFzC1sksj6Qep33n+ymFBqWN6ZlWCnqs0sUJB5yY1I8+CAE+Pb
	 XPrYDrJfPhQkA==
Date: Wed, 20 Nov 2024 22:04:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Quentin Monnet <qmo@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Abdurachmanov <davidlt@rivosinc.com>
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but
 empty
Message-ID: <Zz7Ng9CzrF_ciAz-@google.com>
References: <20241106193208.290067-1-bjorn@kernel.org>
 <87r076nikd.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r076nikd.fsf@all.your.base.are.belong.to.us>

On Wed, Nov 20, 2024 at 02:25:22PM +0100, Björn Töpel wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
> > From: Björn Töpel <bjorn@rivosinc.com>
> >
> > There are a number of tools (bpftool, selftests), that require a
> > "bootstrap" build. Here, a bootstrap build is a build host variant of
> > a target. E.g., assume that you're performing a bpftool cross-build on
> > x86 to riscv, a bootstrap build would then be an x86 variant of
> > bpftool. The typical way to perform the host build variant, is to pass
> > "ARCH=" in a sub-make. However, if a variable has been set with a
> > command argument, then ordinary assignments in the makefile are
> > ignored.
> >
> > This side-effect results in that ARCH, and variables depending on ARCH
> > are not set.
> >
> > Workaround by overriding ARCH to the host arch, if ARCH is empty.
> >
> > Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> > Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

> 
> Arnaldo/Palmer/Quentin:
> 
> A bit unsure what tree this patch should go. It's very important for the
> RISC-V builds, so maybe via Palmer's RISC-V tree?

I think it'd be best to route this through the bpf tree as it seems the
main target is bpftool.  But given the size and the scope of the change,
it should be fine with perf-tools or RISC-V tree.

Thanks,
Namhyung

> 
> Opinions? Just want to make sure it doesn't fall between any chairs!
> :-)
> 
> 
> Björn

