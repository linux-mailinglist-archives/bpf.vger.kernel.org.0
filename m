Return-Path: <bpf+bounces-70293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F42BB6655
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7151419E1778
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496922DC35A;
	Fri,  3 Oct 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei2bkIgx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC81E3DCF;
	Fri,  3 Oct 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484571; cv=none; b=QeoUVAAAYTNP4N1V9T1++yC4NK3dizGmQOA23k8gQawiBXCLBaQMDFMoiDUlK5r0mYYl61aLi+ohyeRxR0tRINqo7zRjyPRaCSmVCwNBVYHxuui8RqucIx5c2jSVEaWTpm5OJsVUN5VxosDNvPA7BozzkqRoQlfW8cm/Ao1PzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484571; c=relaxed/simple;
	bh=Oe0J/JeKTrP4JnYPa6S9YEkL0yL3pUJeT7isznOUIoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJhdUgSUd1kJNi+4GmCAzYDk7n3VxpcHpYeZX7zR9TC9WDobCjTLHcQCa3HFHFjhV+sWfT2iLxAWk/EK7oVJBMA9Waueek9uWIUlKracTrWXoscBi9yLE2zlK29WFUHKHlvw+1bLBcG9mdIiClBHRQ5xyWwEvT79b1rDZceMtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei2bkIgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942A3C4CEF5;
	Fri,  3 Oct 2025 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759484571;
	bh=Oe0J/JeKTrP4JnYPa6S9YEkL0yL3pUJeT7isznOUIoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei2bkIgx+kcs9Ly8bUY4IjFeU0A/vkfp+9f0OPhLuVDcK/fKXqGTzpW9evlD1MSiL
	 lh+H3xF4VHIxArO3AcjEc88MAr7PszjmLLp+UukbdupxnkT7JX6POBivNMEj3UmbAh
	 uJuv8mwzmnkIssnhVvpn6g3N/RVKPg+EDtK6JptQ/Oj2P9B5IKznhW2SefKInsijgo
	 pgD1GTWr9ecJE1xKMYoUe7zVHkurRtQtLFCm+hLbrpXFpSp2RgKRdXiNPFqN/qbEiJ
	 7F/AtGVDpdxpP/Ypndkfn8IIVpCIDu/KwVxuyipMHRHEdcHjB/HsmobtPYZCVhn0Ne
	 2N5sva5hVkmtA==
Date: Fri, 3 Oct 2025 10:42:47 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
	Julian Wiedmann <jwi@isovalent.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jordan Rife <jrife@google.com>
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
Message-ID: <20251003094247.GE2878334@horms.kernel.org>
References: <20251003073418.291171-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>

On Fri, Oct 03, 2025 at 09:34:18AM +0200, Daniel Borkmann wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.
> 
> The traffic is directed to the gateway via vxlan tunnel in collect md
> mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
> forward packets after the arrival and decap on vxlan, which turned out
> over time that the kmalloc-256 slab usage in kernel was ever-increasing.
> 
> The issue was that vxlan allocates the metadata_dst object and attaches
> it through a fake dst entry to the skb. The latter was never released
> though given bpf_redirect_neigh() was merely setting the new dst entry
> via skb_dst_set() without dropping an existing one first.
> 
> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
> Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> Reported-by: Julian Wiedmann <jwi@isovalent.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


