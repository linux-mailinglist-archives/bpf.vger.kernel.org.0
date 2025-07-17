Return-Path: <bpf+bounces-63517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 322AFB081EC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F1B7BA573
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530E1AA782;
	Thu, 17 Jul 2025 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH9iPIl9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C267E9;
	Thu, 17 Jul 2025 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713570; cv=none; b=EV9XIMx3iWYkiJLZemqBAuCpvU6HzqHcR/cAT4AB/BH1yKwQCG0coXkt3SJamme86/TfWo9MeRx4n57RvWGrqrZi9J4+UcDPrBchN9P9l+rmro7E1e2qsW/D3v/o0vWTOMfxZVnFC+L/VVTJmwrw6aO9lQ5C7dCKyMRl4vqDNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713570; c=relaxed/simple;
	bh=w6fWdXnFLYC/lql+ciw8+sqf3DEzT50/X6ihhi/6CL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImtD1i0DwoTqW2LGjH6gJVK7TrDe1j5U20ul92BtjcxqtKTIP0jnd16gV54C1E3GuLLhHfs7DPftj/jvCEdCgP6E87tImCPDqjQj7dEPX3eUYXfXF1P74yTY4NXw0x5lxdJ+zut4oWaEcVITqUZIpGUmBnVJFLFBUojug54i+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH9iPIl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57644C4CEE7;
	Thu, 17 Jul 2025 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713569;
	bh=w6fWdXnFLYC/lql+ciw8+sqf3DEzT50/X6ihhi/6CL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KH9iPIl9ash4n3j00+YlGPDVudA/8L1xYdLLsiKvcw+/jwvIPTxBryWuiGC9+88bi
	 T7b5QxyQUnmsRJHPIKE76yK59zfOTiUf7lXIDc4teTyhGa55+3MEXIvrR11/7KgmQO
	 89QKLfVVNKba5Pwc/4pLfgR87lpWxs7TXSedRSuKrFH/i9M53bOhwWqcoAY0dFUUJY
	 JA0qun8T7wjYKDf1Y8CNUkNXmY7KLDsPK+Bi8Hqiu+FjriKI19zSHlKy7RfcuAd4rw
	 LClpAfTA7pgUJkLLiXTc5raoSbzihmIHb3jn7nImFMhAF12VKyXNc2zKH0c/a7Qt5/
	 sFklR4evwUMCw==
Date: Wed, 16 Jul 2025 17:52:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
Message-ID: <20250716175248.4f626bdb@kernel.org>
In-Reply-To: <CAL+tcoA1LMjxKgQb4WZZ8LeipbGU038is21M_y+kc93eoUpBCA@mail.gmail.com>
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
	<20250716145645.194db702@kernel.org>
	<CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
	<20250716164312.40a18d2f@kernel.org>
	<CAL+tcoA1LMjxKgQb4WZZ8LeipbGU038is21M_y+kc93eoUpBCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 08:06:48 +0800 Jason Xing wrote:
> To be honest, this patch really only does one thing as the commit
> says. It might look very complex, but if readers take a deep look they
> will find only one removal of that validation for xsk in the hot path.
> Nothing more and nothing less. So IMHO, it doesn't bring more complex
> codes here.
> 
> And removal of one validation indeed contributes to the transmission.
> I believe there remain a number of applications using copy mode
> currently. And maintainers of xsk don't regard copy mode as orphaned,
> right?

First of all, I'm not sure the patch is correct. The XSK skbs can have
frags, if device doesn't support or clears _SG we should linearize,
right?

Second, we don't understand where the win is coming from, the numbers
you share are a bit vague. What's so expensive about a few skbs
accesses? Maybe there's an optimization possible to the validation,
which would apply more broadly, instead of skipping it for one trivial
case.

Third, I asked you to compare with AF_PACKET, because IIUC it should
have similar properties as AF_XDP in copy mode. So why not use that?

Lastly, the patch is not all that bad, sure. But the experience of
supporting generic XDP is a very mixed. All the paths that pretend
to do XDP on skbs have a bunch of quirks and bugs. I'd prefer that
we push back more broadly on any sort of pretend XDP.

