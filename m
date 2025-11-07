Return-Path: <bpf+bounces-73912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F84C3DFE7
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A84DF34C09D
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93E2E03FD;
	Fri,  7 Nov 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXWE4VLF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0F27F724;
	Fri,  7 Nov 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475991; cv=none; b=CgN/NIchZfD6sLQC9o7x9zDG+WXDGiG/hakv227FSjHzbi86fOCviqf4fMXOZd6qGxwHFC0tMHCgIazO7g5OvjQPibCW0ZJBdBLHWdX0Z/daFCsWNfKWeg10yt9MYALEkiPXMQFCIVfNAQDWxVhuqr7znbthIvw4Wqq5pJWJzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475991; c=relaxed/simple;
	bh=7YJDMv05W0X4dxbz1CS09+ZkUbkhp8EeeM69PLbxZY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGamEWmfUAt49lkW0r5PNa4al35gLbiTNgwmrq5Uzv3j13KYDz1tcrt7Qq+zutK8rqAtEokp7K7EKuOtbSfnQ+Wb/kZPCSu9ggaN7g5YUDXuPLMReTRlhuNRLW7rLiqWhor5Ao3WdQFxy7R1nVzcGK+z1WaXeWcXT9b8ZmZBzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXWE4VLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3CC4CEF7;
	Fri,  7 Nov 2025 00:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762475990;
	bh=7YJDMv05W0X4dxbz1CS09+ZkUbkhp8EeeM69PLbxZY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KXWE4VLF4wz7uXjr8XOhdjN5iQSOWXs4sXLRlyf/lL5ufhfBXRQv7nqTQ9yVcwGLH
	 KbpK2btSlm1QAIarq2G1pKgIvIETrEFqwsHifkfCll/9qupC0PZnV5UlZclkAvJuZg
	 8KfDYOk+qV49ZzwyRs240G7JKhwfhRZACJ6v7icOR6IHw3dXHBNqf1rYFvpO1SbV5Y
	 x18xui5EUcLKkAA8VwkMJ1RBS+9pk7rjod30n1nRZJIU/5lWCovWtBOE6Lzx0+cWz2
	 4xhCyATkTGnbda3dVMy5mXC+H2BaTmlHZ3RakIqq1pIzJ5NuUnoVj+tL7CxFsiIKGs
	 B8D3mrn+UuMeQ==
Date: Thu, 6 Nov 2025 16:39:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 01/14] net: Add bind-queue operation
Message-ID: <20251106163948.0d0d7d54@kernel.org>
In-Reply-To: <20251031212103.310683-2-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
	<20251031212103.310683-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 22:20:50 +0100 Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a ynl netdev family operation called bind-queue that creates a new
> rx queue in a virtual netdev (i.e. netkit or veth) and binds it to an rx
> queue in a real netdev.

bind is already used in context of queues to attach devmem.
Having bind-rx, bind-tx == devmem, and bind-queue something else
is not great. Plus well-named ops have the object first.

Can we call this op queue-create ?

It is creating a queue on the netkit, we can wrap the other params
into a nest called "lease". Once / if we get to dynamic queue creation
on real netdevs we can reuse it (presumably then lack of "lease" will
then imply that we need a real queue to be allocated).

> This forms a queue pair, where the peer queue of

"queue pair" means Rx+Tx, please do not reuse terms like this.

> the pair in the virtual netdev acts as a proxy for the peer queue in the
> real netdev. Thus, the peer queue in the virtual netdev can be used by
> processes running in a container to use both memory providers (io_uring
> zero-copy rx and devmem) and AF_XDP. An early implementation had only
> driver-specific integration [0], but in order for other virtual devices
> to reuse, it makes sense to have this as a generic API.

> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152..1e24c7f76de0 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -561,6 +561,46 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +  -
> +    name: queue-pair
> +    attributes:

No need to create a "real" attribute set for this.

Once the attrs are wrapped in a "lease" nest you'll need a single
triplet, so make this a subset-of: queue (see the queue-id set).
name: ifc-queue-id ?

