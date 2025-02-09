Return-Path: <bpf+bounces-50901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C43A2DCC0
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 12:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A4164E98
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9828188721;
	Sun,  9 Feb 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+IFlVec"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D324336A;
	Sun,  9 Feb 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099252; cv=none; b=LcOUwDRrGAaYQqgHWkXSKey6BxNjGql1bTMgf/KkrGBS5NYZeDT/7MmND4M3dEHk6V3AvwV2kOqMmmuW3vGJJ+oUeBBshy330ZRkcgftbQkJ9M5XiRZIM0x9H9Hb80UgrNMbCQZD03FdGCBqHvF5wm3rGeAnrGlouBzmqghqC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099252; c=relaxed/simple;
	bh=+7Yo1y4dQTWPi4ce0HpjoFbyRyph0IJngDk6BdYcLaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fprRy90SSqZcrvN6hsVys9CwzevdTtyuJsvpp1oSUoAOKdIWE2lHvBSAmMhDb4fGyIFUUEjyM+6MH13VCZdoLiPSwsUULOONXm6pMCYCsiTlZewy6OCw8/iaRP5ov7LEjTa7eoG1gchO/TUElcqLCujhhi3jHFeOiebdWdaSRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+IFlVec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42C0C4CEDD;
	Sun,  9 Feb 2025 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739099251;
	bh=+7Yo1y4dQTWPi4ce0HpjoFbyRyph0IJngDk6BdYcLaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+IFlVecTdbVPC0Awd+ZdRk7cPqrj3jfC/Lm8aZ0877R/mwoaN/CIZd9tTB/vSrxh
	 D55sMUOIjvFVYeffRF/cmxXp915G/p6V8HNHl3WKDs+4x+f3wKaZ3aXcUj0nAViJIg
	 xU6mM0fm8UWNx7IrL5kV1rg4gH1eiVg8c6Ia1qSG3AotniNdGSQrJIou0q5IufHXIY
	 XVZ+MUrUS193mnGKi58OxZRbg7SdXxwpclcLznrXuLLrmGJ07KbTEDOV4oUMJoQLng
	 G0xKmiAhhaHuAJUpPU9yGisnuccxsFWaNoO1xxtvxaUlmAHFeF+uGx4PJHoNwogHma
	 uMMJWbcccrrJw==
Date: Sun, 9 Feb 2025 11:07:25 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] unroll: add generic loop unroll helpers
Message-ID: <20250209110725.GB554665@kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206182630.3914318-2-aleksander.lobakin@intel.com>

On Thu, Feb 06, 2025 at 07:26:26PM +0100, Alexander Lobakin wrote:
> There are cases when we need to explicitly unroll loops. For example,
> cache operations, filling DMA descriptors on very high speeds etc.
> Add compiler-specific attribute macros to give the compiler a hint
> that we'd like to unroll a loop.
> Example usage:
> 
>  #define UNROLL_BATCH 8
> 
> 	unrolled_count(UNROLL_BATCH)
> 	for (u32 i = 0; i < UNROLL_BATCH; i++)
> 		op(priv, i);
> 
> Note that sometimes the compilers won't unroll loops if they think this
> would have worse optimization and perf than without unrolling, and that
> unroll attributes are available only starting GCC 8. For older compiler
> versions, no hints/attributes will be applied.
> For better unrolling/parallelization, don't have any variables that
> interfere between iterations except for the iterator itself.
> 
> Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Hi Alexander,

This patch adds four variants of the unrolled helper.  But as far as I can
tell the patch-set only makes use of one of them, unrolled_count().

I think it would be best if this patch only added helpers that are used.

...

