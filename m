Return-Path: <bpf+bounces-71954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C6C026B0
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 005635016BD
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C12C11EA;
	Thu, 23 Oct 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY69QPay"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D12BD5AF;
	Thu, 23 Oct 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236417; cv=none; b=IdADC3oZoMRiszgEjw3nMNFs/0326smlaMPaZlNPTrytfTKyCJo7td/GrI0U616xbty/IyOWkM2ge+yEgDHwjY6foSK9pPeR2lAJTsFeH1lSuKKDfXpWuLVHj6ehHd2w2czt0kcIUpXAlMLdcUh4S76Icl4IwbzGS22zMYU+V9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236417; c=relaxed/simple;
	bh=fFVUi40XDCK9B7HixvDHQwpkFgo3/dBfhOzbpBXTDTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeJKmqlmIb5EP/YdtJ3Z6eNO2D4ArkG9w2Noil+MGxuYsucZ//btTMGEF1X6lzwvi6p89Ih+OolDI0SUGx/HvCgl6IRQpT+UmFOmvfuW53cskiVnGL69hk6CSuB6fR1R3OSaVGR2PbEX1+ZQDBpEXKohRQPxJgFfmraDW1JtxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY69QPay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3260C4CEE7;
	Thu, 23 Oct 2025 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761236417;
	bh=fFVUi40XDCK9B7HixvDHQwpkFgo3/dBfhOzbpBXTDTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY69QPayrEeVsAOYAfDxnBHKtP4LY+mIEf+kykRLRh7UrmCItw9ch0v/IfnubidB3
	 s+kE1VPjFfaUbpcfVYRMloqK1T89N0DGPN3sts5gjubAHfhcfasWlrnwYZ/5k+KvTq
	 mx18RRSLyACPAY4NOAcn9CHoIJOuEprnSvtvco8f/jw9KZCYN/EGwEW9pzTQ/ZqNjq
	 QYXzsVq/yfETa04aVZ04g67p6vXJVFUKrb7pVEeunSFQHnnkUfi0OOzgkOSE56OJ9l
	 v/b9wZL6lmUWKVwMW5NdLKwINBfzlrUFZSWms9nq7nXIE7O4NWxJwZFatipEjGDmbQ
	 gcg/+LfnF7w5g==
Date: Thu, 23 Oct 2025 09:20:16 -0700
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <202510230918.AFE383F9E0@keescook>
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
 <980907a1-255d-4aa4-ad49-0fba79fe8edc@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980907a1-255d-4aa4-ad49-0fba79fe8edc@redhat.com>

On Thu, Oct 23, 2025 at 12:59:59PM +0200, Paolo Abeni wrote:
> On 10/20/25 11:26 PM, Kees Cook wrote:
> > Add flexible sockaddr structure to support addresses longer than the
> > traditional 14-byte struct sockaddr::sa_data limitation without
> > requiring the full 128-byte sa_data of struct sockaddr_storage. This
> > allows the network APIs to pass around a pointer to an object that
> > isn't lying to the compiler about how big it is, but must be accompanied
> > by its actual size as an additional parameter.
> > 
> > It's possible we may way to migrate to including the size with the
> > struct in the future, e.g.:
> > 
> > struct sockaddr_unspec {
> > 	u16 sa_data_len;
> > 	u16 sa_family;
> > 	u8  sa_data[] __counted_by(sa_data_len);
> > };
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Another side note: please include the 'net-next' subj prefix in next
> submissions, otherwise patchwork could be fouled, and the patches will
> not be picked by our CI - I guess we need all the possible testing done
> here ;)

Okay, I've tweaked my workflow automation to attempt this now. I had a
bit of a catch-22 in that I generated the CC list after "git
format-patch" (and format-patch is what has the --prefix option, so I
couldn't see if netdev@ was in the CC list yet...) Anyway, it should be
part of my automation now...

-- 
Kees Cook

