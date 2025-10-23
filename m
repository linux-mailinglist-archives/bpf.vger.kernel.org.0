Return-Path: <bpf+bounces-71956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D5C0274C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894CB3AE91E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E59224AF9;
	Thu, 23 Oct 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDYU/mbK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCE313E0F;
	Thu, 23 Oct 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237077; cv=none; b=T041hfr0uVu8gFYOmyB9RRHUj1Iv0mMXPLZPeJhI0CKBeoV1OBK4fiqbiVj9bnYO8dMLzYuUelHtn51UZK9LDssg6S9v11nlXqgz6UbJ+UTeAM4iD/XXGkWyO257um9mgtfGhGhmwc5iXCurj1rIb4sATwIZv5FOruKkizTijSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237077; c=relaxed/simple;
	bh=WTHkrbGHGgyPalH7sKivguzU7HH6eKrxz8okjYAGo/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzQJ2R4efAyjgCgZ7Kcc9QrlHhkhSCchIu1gxanV1sW6ec/BEsVfZ8eDaOgWyqtEl2WTsF8Ae4lOZ6Lc+BmDoIcqODl3j3f3fidGQkI/WnaD65wf0KHggOhebvDtzcXPZS8Qr/AGLPc+84rc0nyRLEX5JByFvz65ksZcnpJMBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDYU/mbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C789C4CEE7;
	Thu, 23 Oct 2025 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761237077;
	bh=WTHkrbGHGgyPalH7sKivguzU7HH6eKrxz8okjYAGo/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDYU/mbKNCY21ty803BPrcd8LU9AWr6FcmTTaRh2u/7pp7a6u4vqWmVILq+BNS3XR
	 3wsMXL650V3Sk7LI5smLRsNmT5s+YxRo+lTCvD6/k1aBESXfr/IPEO/aPeLpsvHxF6
	 CmAHQEb/zrvheH7WT9kGKEBsTvlNtkJMGHYJ1t/r2RO2vV95CDw2Q4jCe+d2giCPzc
	 kR3Yn+Gt8oDhbqZKTaAcOS6JsFkKOrIKUGG5SW/wSXM+/MKw1Q347RuFzYGKQkX4Db
	 F7kP3ZKtfl0AgI9N5P5StUModKQvp5CEM6eDYkA1cu5SVVyuvFydUKj7x3lDp+LpGk
	 qcs7mFE0pB0GA==
Date: Thu, 23 Oct 2025 09:31:17 -0700
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
Message-ID: <202510230929.7425CE38C4@keescook>
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
 <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>

On Thu, Oct 23, 2025 at 12:43:06PM +0200, Paolo Abeni wrote:
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
> 
> Side note: sockaddr_unspec is possibly not the optimal name, as
> AF_UNSPEC has a specific meaning/semantic.
> 
> Name-wise, I think 'sockaddr_sized' would be better, but I agree with
> David the struct may cause unaligned access problems.

I'll go with sockaddr_unsized -- doing the sockaddr_sized variant is a
much more involved change. I just want to get us to where we are today
but with no lying to the compiler about sizes. :)

-- 
Kees Cook

