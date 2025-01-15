Return-Path: <bpf+bounces-48960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8AA12A2A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57453A551E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6BE1D5140;
	Wed, 15 Jan 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0XThA8G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51F155C96;
	Wed, 15 Jan 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963549; cv=none; b=HeVrhWcy5T7nx7Xx4FEYpCPe7GWMMQeBrtb+PcpOq0dR8mj03eWkoWQ3YUt3g+9BWZ2L0lr0Fg7vZVMQ7OB3RO2hiTv9wNezvqgEQhBV6dM6Xw65LeZV7AaGKP7R3a8W3MqCR8IIpXQp7FsZZUIbx36meVtK2irNhNmkjROQ/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963549; c=relaxed/simple;
	bh=VYcycM89HGad3xDeQXmDWnM4z4M/2xtJvbd4aqls6q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzDehLOiuN4IJTqlnHQeEGWzjjdqRPqEsyi9MwjBJ4OFQTMiaZ5O7RfjbZlzzCLxOkdZunLWM8c/IMO5h2soKEiMlk9ZU4kU96JHtwXFub6JfLcn0BqN+Nh02qjknsXw0x9XmpNWqIFCjc0fedogVNC2BdOgk16JZqSg/Ldzq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0XThA8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1C9C4CED1;
	Wed, 15 Jan 2025 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736963546;
	bh=VYcycM89HGad3xDeQXmDWnM4z4M/2xtJvbd4aqls6q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0XThA8GhIn92jHD/chbppU4szGH2PiJ+zvJVREsZKA4heQ5oTZbfCiu8xCbTtT8Q
	 UnIXxU8q85HuAO7rInDWdlcmQW+WHoPQOgK2rmCaS9VA/RGUmnwurxdMzYYMebKAkv
	 jx7zLNT72b9XaxhoXdKPpKrv0F/TAO7wA4RYFwddNuHnHKb+02BvpeitMhJEda39Mn
	 ZN1pEsGpCkg+KTqxJOm/cPByiwYRHcXtxzFvw2SmuTfuovoC8gQe0Zw0vNhwIf4tQ9
	 +NppnlnGVGwq5pBsKy81s+8zhYrEZUZU711k1q+t45+pxiStzaJd4GFZih0UOZKwXX
	 7OLghYx51w53w==
Message-ID: <5445fb43-a9c1-42df-874b-71dd51f1e848@kernel.org>
Date: Wed, 15 Jan 2025 18:52:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/8] bpf: cpumap: switch to GRO from
 netif_receive_skb_list()
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-4-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250115151901.2063909-4-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/01/2025 16.18, Alexander Lobakin wrote:
> cpumap has its own BH context based on kthread. It has a sane batch
> size of 8 frames per one cycle.
> GRO can be used here on its own. Adjust cpumap calls to the upper stack
> to use GRO API instead of netif_receive_skb_list() which processes skbs
> by batches, but doesn't involve GRO layer at all.
> In plenty of tests, GRO performs better than listed receiving even
> given that it has to calculate full frame checksums on the CPU.
> As GRO passes the skbs to the upper stack in the batches of
> @gro_normal_batch, i.e. 8 by default, and skb->dev points to the
> device where the frame comes from, it is enough to disable GRO
> netdev feature on it to completely restore the original behaviour:
> untouched frames will be being bulked and passed to the upper stack
> by 8, as it was with netif_receive_skb_list().
> 
> Signed-off-by: Alexander Lobakin<aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu<dxu@dxuuu.xyz>
> ---
>   kernel/bpf/cpumap.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 42 insertions(+), 3 deletions(-)

Nice and clean code, I like it! :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

