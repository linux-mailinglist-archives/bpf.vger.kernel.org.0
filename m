Return-Path: <bpf+bounces-60774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA5ADBC52
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5E18926FE
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4F221275;
	Mon, 16 Jun 2025 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skHIjB2K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105C1E2823;
	Mon, 16 Jun 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110925; cv=none; b=l0wq87tBW/RZRTd1pgAZ8fnS2q6g73uiRzRZcQ+70i41L2B7yWtUrJMswF1dNojTmm0x59qaixbKnjFzwggOX9K1CDjbxfO5NbFfhTn+HT7MCH1VuepRbMTDFYERXE7GIw6NCKCW6hIUimJuI6bd18QtW5YPqRd5RWv9ne7m60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110925; c=relaxed/simple;
	bh=veD65YqTH8NhSkVXVb8XaFNPAT2G092j/e02FmwfxW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asyykhMl3Fa+LhjmEVFHY+wiGOfqTie8cAd4CUlfQKGSaEPqy/8xr/KCTaomEmH2ImSBYA6bvKLKHvOQkDJx4nW/ILGqaLJjJhst48VT2iGgSOsPQ/OICddu6dT6wjItjE0Uc5m2oQYeZpbTdviEb39TFy8zNFGJTtOJI1zva6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skHIjB2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38887C4CEEE;
	Mon, 16 Jun 2025 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750110924;
	bh=veD65YqTH8NhSkVXVb8XaFNPAT2G092j/e02FmwfxW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skHIjB2KEWRO5XJojksFvWRTITuvAFgNquyCVbWMY9XSXUhqzslUX06PRP49MZrqJ
	 IQ+9VADzskSPJ+X1W85hUCFDJrcw6rpP0oOtO6FntrnpJy6ImA4eB4zG6c/F0ShGSV
	 BtL+XaK9DGNoW8PNvC1cSFdPL8wARlBq2eC2kBFQ4ML79Q0SOMpaaLO6vfSwUQFJ15
	 wiWy5YGUWetzjbRV6zzyxxSpJFLFoDJxgZ0VcEVsoR6Qr1w6IwNxEkqEBaC7O1P2KP
	 xtIPSc77DmbXx9cn+7GKGGse3JvXyiaJVy0SxZavwxMcJUq+IVCP/kSavPcBQJ8bVX
	 E5sO+nkixdzxg==
Date: Mon, 16 Jun 2025 14:55:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, lorenzo@kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V1 3/7] net: xdp: Add kfuncs to store hw
 metadata in xdp_buff
Message-ID: <20250616145523.63bd2577@kernel.org>
In-Reply-To: <174897276809.1677018.15753779269046278541.stgit@firesoul>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
	<174897276809.1677018.15753779269046278541.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Jun 2025 19:46:08 +0200 Jesper Dangaard Brouer wrote:
> Introduce the following kfuncs to store hw metadata provided by the NIC
> into the xdp_buff struct:
> 
> - rx-hash: bpf_xdp_store_rx_hash
> - rx-vlan: bpf_xdp_store_rx_vlan
> - rx-hw-ts: bpf_xdp_store_rx_ts

My mental model would that these should operate within the "remote XDP".
We have helpers to "get the metadata", now we're adding helpers to "set
the metadata". Should the setting not be simply the inverse of the
getting? Store to driver-specific format?

-> local driver - all the metadata in HW-specific format / descriptors
  -> local XDP - GET and copy data to locally defined md prepend
-> remote drv - CPU map, veth) hooks in its own callbacks and md struct
  -> remote XDP - read the data from md prepend and call SET
-> remote drv - check if XDP set any md in its struct and uses it when
                converting to skb.

Note, this is just the model for the API. We can always introduce
optimizations, like a feature flag that makes the "local" driver output
well known MD struct and have the remote driver pick that up, with
neither XDP calling the helpers. 
But from the model perspective since the GET operations are local to
the driver owning the frame at the time, the SET operations should also
operate on metadata local to the owning driver.

That's my $0.02

