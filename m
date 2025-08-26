Return-Path: <bpf+bounces-66491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5CB350E0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F7C1B2205A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B81C6FE8;
	Tue, 26 Aug 2025 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpy5badJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CEC133;
	Tue, 26 Aug 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170934; cv=none; b=sfQBjPBBLWafsUyDHnLrvYLr1rnvaaIJB4MAyX5QJMm96T3mYCIgQRzg7o/bT+RvnwsMdLNY3Jts9fxycNugpg3l6Nb9y4htlp2UHdjBNsSCuUvM4Mn1RTZ3JHHRAR0xv92KM8E6caElfM0hN4ielEJfdAOGjmElCbrwcznkPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170934; c=relaxed/simple;
	bh=TFasoV4Wgbuy8d8WaLKLa5ZeC0ESXfKE9EW8yM7BQZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEOh3T9LIY3AzV/xOlEEEnSDx/+Qmvjeo0W9pfjvOnGHvYGBYQgntQRmwGrzuw7+QLhvKaOtpA4G7r7fLJOdCFe5GrEMpmRwEABLNJFUadqwoY2Vn+M3o23NqxMHHNxxwdZ0J5RDj/uNYEuQouXnT6IDP2X7uguiQ29DpR/Rl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpy5badJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ED4C4CEED;
	Tue, 26 Aug 2025 01:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756170933;
	bh=TFasoV4Wgbuy8d8WaLKLa5ZeC0ESXfKE9EW8yM7BQZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gpy5badJ7D3W9wGp5gqfPIPYZjenUKnNqDBcHNxHtUmGD4kStDFErNKPdl035RDs2
	 EaRGg0tI8HsLAQh50QyDCvDFy4ATzAEPO6JkMxl7JiOMNJiBrbXGxf8s+SqXc2sDXo
	 qMmnwaLNwt3eEM+Pu5l9UEjNPMkwYuGQZpqlsQLA270AXY0U3mprCDFPYK/xsTAirP
	 vAhGoc/jfpdYInV2L21MDYXtykyypqI7ysDqDszL0NAtHVM8ZeAiqcpVEQ9OXdOhy1
	 JU5gfzXLTxmNLUARmwxa/NakUXI5Tu8STZUl562T9pcc2dtZXUSet7nLrl2CJmupwT
	 ch+fFomi6e+jg==
Date: Mon, 25 Aug 2025 18:15:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy
 mode
Message-ID: <20250825181532.1b6ae14f@kernel.org>
In-Reply-To: <CAL+tcoCa3nfO+PJE-uccnOfQaZnUa+78AmJXwjaLod4WvPPfog@mail.gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
	<20250825104437.5349512c@kernel.org>
	<CAL+tcoCxzyBxhCes-4OfBAePpQK3jvSRSBufo0eu6afb4hdSaA@mail.gmail.com>
	<20250825172928.234fd75c@kernel.org>
	<CAL+tcoCa3nfO+PJE-uccnOfQaZnUa+78AmJXwjaLod4WvPPfog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 08:51:24 +0800 Jason Xing wrote:
> > > Sorry for missing the question. I'm not very familiar with how to run the
> > > test based on AF_PACKET. Could you point it out for me? Thanks.
> > >
> > > I remember the very initial version of AF_XDP was pure AF_PACKET. So
> > > may I ask why we expect to see the comparison between them?  
> >
> > Pretty sure I told you this at least twice but the point of AF_XDP
> > is the ZC mode. Without a comparison to AF_PACKET which has similar
> > functionality optimizing AF_XDP copy mode seems unjustified.  
> 
> Oh, I see. Let me confirm again that you expect to see a demo like the
> copy mode of AF_PACKET v4 [1] and see the differences in performance,
> right?
> 
> If AF_PACKET eventually outperforms AF_XDP, do we need to reinvent the
> copy mode based on AF_PACKET?
> 
> And if a quick/simple implementation is based on AF_PACKET, it
> shouldn't be that easy to use the same benchmark to see which one is
> better. That means inventing a new unified benchmark tool is
> necessary?

To be honest I suspect you can get an LLM to convert your AF_XDP test
to use AF_PACKET..

