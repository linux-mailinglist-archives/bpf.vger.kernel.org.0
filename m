Return-Path: <bpf+bounces-64208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADBB0FAEA
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476AE567BFA
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04622A1D4;
	Wed, 23 Jul 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDgGFfhe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722602192F4;
	Wed, 23 Jul 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298834; cv=none; b=rTOb2XvTsxcSAmMg4j1LeHffLHDcSsNE9Rw4SzKklXg0OXKgAFFJ6P0P9aNZMlcOTrCSuTjFej6/xSb5tXU277msFW3P2vStSTwj6RMqmkWQw6XcY2Nyf+oJj4huXA7Ym2UYR12i7+J2EA3BNMAAa+18mZzGRomZ6M6vd1lkzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298834; c=relaxed/simple;
	bh=4ZQsZmHxrXUqIoLsun6oHdJj6ny8RfoitP6Kx5wckhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLAAgSxhXxb9ysCvBKcB0XfA1Ab40mwwF6l2Zdfc2zQ/+8J4pMWsmIrkyOVGNvrWHoX5gJRiDPBlAG3vRcKH2T1WHeREIDwuht1ccaapwNqSs43vVjZy/DpsKq4TxQecq/WpKst6Tsh4/AbHISvrmsFRxETKeewufcb3a0ovWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDgGFfhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EB5C4CEE7;
	Wed, 23 Jul 2025 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753298834;
	bh=4ZQsZmHxrXUqIoLsun6oHdJj6ny8RfoitP6Kx5wckhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDgGFfhetZcUHWHDB5at4rFEL9xiSLqmEypL97rzxWwbF3HjAPDnVqxwoi3r9Mvfi
	 iQX/zrqslq2mlLMAuMJMi/Q6ql2dP5bWT2sFIo3sRk9hlauOHqnQo5Vjj4Rx5tvgR2
	 ZFmnEasUzeFWZTwsiJfah7qBXsHu0XkRkIsEAXxO0+C8OfcGe9NIX6N0ESbWxBsRg4
	 L/oCKQbuBAoX1NxtJPKwf4qP0ALOKx2Zwx1JEHs+Igq3p5oP0COquiVcf+gW/0zg4I
	 Ahgi1cEmJcZttTRvf8b5jrbFHhdjuY/1YfPTt84oD9KsWwiIkSMAbGRjJnLX/59yIJ
	 BqqKevyVOOWcg==
Date: Wed, 23 Jul 2025 16:27:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] pahole: Don't fail when encoding BTF on an object
 with no DWARF info
Message-ID: <aIE3j4kcn7pzLA4P@x1>
References: <aH-eo6xY98cxBT1-@x1>
 <92260366-5a4f-42bb-8306-2d8e25aba4e8@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92260366-5a4f-42bb-8306-2d8e25aba4e8@oracle.com>

On Wed, Jul 23, 2025 at 08:00:31PM +0100, Alan Maguire wrote:
> On 22/07/2025 15:22, Arnaldo Carvalho de Melo wrote:
> > If pahole is asked to encode BTF for a file with no DWARF info, don't
> > fail, just skip it.

> > This is the case, for instance, in this file in a kernel build with
> > DWARF info generation enabled:

> >   $ pahole ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
> >   libbpf: failed to find '.BTF' ELF section in ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
> >   pahole: file '../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o' has no supported type information.
> >   $

> > Before it was failing when encoding BTF for it, now:

> >   $ pahole --btf_encode ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
> >   $ echo $?
> >   0
> >   $

> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Only potential issue I can see is that in the usual case of encoding BTF
> from DWARF in the kernel we'd probably like to fall over if we can't
> encode BTF due to DWARF absence. However current Kconfig dependencies of
> CONFIG_DEBUG_INFO_BTF mean this can't happen in practice I think so

Right, this is an exception, just some .o files out of thousands end up
without DWARF.

So I think that if we take --btf_encode as "Encode BTF from DWARF, if
DWARF is available" is a good interpretation of intent.

- Arnaldo
 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!

- Arnaldo
 
> > ---
> >  pahole.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/pahole.c b/pahole.c
> > index 333e71ab65924d2c..a001ec86ef1b0908 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3659,6 +3659,13 @@ try_sole_arg_as_class_names:
> >  			remaining = argc;
> >  			goto try_sole_arg_as_class_names;
> >  		}
> > +
> > +		if (btf_encode || ctf_encode) {
> > +			// If encoding is asked for and there is no DEBUG info to encode from,
> > +			// there are no errors, continue...
> > +			goto out_ok;
> > +		}
> > +
> >  		if (argv[remaining] != NULL) {
> >  			cus__fprintf_load_files_err(cus, "pahole", argv + remaining, err, stderr);
> >  		} else {

