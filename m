Return-Path: <bpf+bounces-64926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D951B18844
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99096AA2E75
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1D279782;
	Fri,  1 Aug 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9z4fLGH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49815539A;
	Fri,  1 Aug 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080846; cv=none; b=kTkA549Q+M8Xqhg5oiZoOLXK8GElZjH9j6RO43abPA+SEF9tBuQZsO26eo4TKMTMkfnqdahQzHh6eem3K8k1gZp57niQPwsRZV9m+2JD40CXxySyBaCBBb1iII6fePZvmGAZvhxX68RaV8t5WsdtCsJIo8hA9hL209WsBu6tfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080846; c=relaxed/simple;
	bh=s21MNFiGpElh3lnP3/mQYGiKUI4NJbRZs5f7WP60uv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2tgtm3I56jzgi7O+I7x5azRWnRlcZlLQ1T5e9txlEhQawENgg+S4uTtXdIDaq/FsMv6RKknbSbFYtqfI1a75SKOwUhOBuQiv+rcaF5TSmeIFzlMByrwuxPSRaA8ai+MOnIDu0VPf/2Pw0BhvyXVvTTMJ5VUWE6oa+i90HnCJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9z4fLGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EBFC4CEE7;
	Fri,  1 Aug 2025 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754080846;
	bh=s21MNFiGpElh3lnP3/mQYGiKUI4NJbRZs5f7WP60uv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i9z4fLGHDNdeaoCx3h8OfziQHzYM/g+npTunX9FH35raRTFV3b5LvTonxcex34+wO
	 gYniVFDMpQ6pQu6XGXL6piZeULgYPFzi94VFLLXvDtE6/HIXdemEFeO705xPEvfsZF
	 O5FrOfnLESrDpZISh+tYsvIgHAEi2QprF5rOY5cY6G+wL/NoEWO4S2ZkLGBdyiiEc7
	 Y4m+RPdRTA+dJDNyPkRh5HIKFupBI1lMk8nz9YacFjOTJnLmaFEHKAc+YQvyTOdMf1
	 MHMbPSZYtBmEIbTO8jpQJam0wFBFqGNCX4ncc0S7E5jQDo1JNgKmf865wV7pYWlNI/
	 Qc+P2JZ+HF2IA==
Date: Fri, 1 Aug 2025 13:40:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250801134045.4344cb44@kernel.org>
In-Reply-To: <aIvdlJts5JQLuzLE@lore-rh-laptop>
References: <aG427EcHHn9yxaDv@lore-desk>
	<aHE2F1FJlYc37eIz@mini-arch>
	<aHeKYZY7l2i1xwel@lore-desk>
	<20250716142015.0b309c71@kernel.org>
	<fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
	<20250717182534.4f305f8a@kernel.org>
	<ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
	<20250721181344.24d47fa3@kernel.org>
	<aIdWjTCM1nOjiWfC@lore-desk>
	<20250728092956.24a7d09b@kernel.org>
	<aIvdlJts5JQLuzLE@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 23:18:12 +0200 Lorenzo Bianconi wrote:
> IIUC the 'set' proposal (please correct me if I am wrong), the eBPF program
> running on the NIC that is receiving the packet from the wire is supposed
> to set (or update) the hw metadata info (e.g. RX HASH or RX checksum) in
> the RX DMA descriptor associated to the packet to be successively consumed.
> Am I right?

I was thinking of doing the SET on the veth side. Basically the
metadata has to be understood by the stack only at the xdp->skb
transition point. So we can delay the SET until that moment, carrying
the information in program-specific format.

