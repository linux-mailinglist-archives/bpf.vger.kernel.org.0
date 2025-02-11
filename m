Return-Path: <bpf+bounces-51092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB0A3012F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585307A154F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63049134B0;
	Tue, 11 Feb 2025 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBG0xO58"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB8B676;
	Tue, 11 Feb 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239017; cv=none; b=LRHQk/ChpeY79PuDss07rpMATbEuy3enr55U9dNppe+m+OIHoXrS2yj2iqHMHJeK+0OZONxrRLLUMyuCaXUb7mW3kd2t1u/nMxMCapq6N2zBFcLxlPnnQkQScE/EC0TFPGjSr3S2DuIJUcfz4g0R4SQYXTo2AibTLMDHU0dCP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239017; c=relaxed/simple;
	bh=JBSsbLlRcnXVLndhpHzyIz4BCKHwBTs9BNQ8fcPk/8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJKY3mMpnc4OuFXbGo4KQNyraN6goQqMkz0CuZQVheOXHJDsYaHhl1IWaoJzpXWr/kshIYtJXlPNw18DnlLrMPLLVuHc5i0UpdDXKXyyyUn8yRmwlVIk8nSYsCX9koLJ9HazU5/LnRlaU+itpCZb+GDs3Gy2nWoPanUa+8gVtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBG0xO58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF9C4CED1;
	Tue, 11 Feb 2025 01:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739239017;
	bh=JBSsbLlRcnXVLndhpHzyIz4BCKHwBTs9BNQ8fcPk/8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GBG0xO58q4NUw7aNkm5a+Hg66ElniqttFVbAOoOmcwHHYUS7HzxtDQodv3vY6ZgmH
	 0x5cbyHaOdfzeOWDkxPZMidZ+qnOpawdfJw5n/wInSgPoiLXBpNblCpIoTyn18vKCx
	 evTS97adKqeiApOdy6hAJQyxYarTkWmpOoL11MaV10kgv99niiOrFKRCHo+cskkbF/
	 WSxv1XAgNpcszYYD3lPWffiVVmFSB/dBLeOTRZCsYCnguSWLRJDwipQvJ+GRkSR2p8
	 +9qu4hGiVWfFsEhXh7gE2We5OMp4MJm+D1qRNFrXPxxYXK2q921KlG2zNTVG31TsAZ
	 n21w7XenYDp+g==
Date: Mon, 10 Feb 2025 17:56:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxh?=
 =?UTF-8?B?bmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] unroll: add generic loop unroll helpers
Message-ID: <20250210175655.15c5fbe5@kernel.org>
In-Reply-To: <20250210210819.GF554665@kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
	<20250206182630.3914318-2-aleksander.lobakin@intel.com>
	<20250209110725.GB554665@kernel.org>
	<fa01e28e-b75d-4d60-b10a-ccf3e544ff1e@intel.com>
	<20250210210819.GF554665@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 21:08:19 +0000 Simon Horman wrote:
> > > This patch adds four variants of the unrolled helper.  But as far as I can
> > > tell the patch-set only makes use of one of them, unrolled_count().
> > > 
> > > I think it would be best if this patch only added helpers that are used.  
> > 
> > I thought they might help people in future.
> > I can remove them if you insist. BTW the original patch from Jose also
> > added several variants.  
> 
> I do slightly prefer only adding what is used.

Hm, I'm a bit on the fence. IDK how trivial it is to figure out how 
to get the equivalent behavior from the compilers... 

Let's keep it, if someone feels strongly I guess they could post 
a patch to delete the unused variants.

