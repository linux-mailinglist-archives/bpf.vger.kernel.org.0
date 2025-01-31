Return-Path: <bpf+bounces-50211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B870A23BDD
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 11:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B466E188A3B8
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01F1ACEAC;
	Fri, 31 Jan 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE4WKA7g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993018CC1D;
	Fri, 31 Jan 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317951; cv=none; b=Vlbo+1Rbmx+JJo29p9QJuL1L/1+W31oskM4pSPVTSgvJ/vU0s32K2u5pCD9jQCVqo3cKk9v1OEcsv7XIqSDil1KKFdFUID49BIz6QMREmDPHbjXSNQZU5IiOYRkYf28q25jShGdmipv0vpRjBrs+xzn11eAAVOrE/bBjvjaKw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317951; c=relaxed/simple;
	bh=fOGvzt4VXpEvCOY+kXMq0uNd0SgvKFlchoIyv6XU0bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCEYrh70tTq3SfKDitvPTQ4tGUGJMdIztcRafLNRS6G+NdMRM1x5KkvJW8xgSwQhh2U1iHbfOycwmziczud8P1IEoCsakC/71Q+9BLjJDMmAhBH+YOxPU4utyXcxbt7Fcrz/RwEkZPLKcBLMpXkS8ClvHJp0qxS4hCroJwExU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE4WKA7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACCC4CED1;
	Fri, 31 Jan 2025 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738317951;
	bh=fOGvzt4VXpEvCOY+kXMq0uNd0SgvKFlchoIyv6XU0bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE4WKA7gY0xGktkyO5t3ED+S8CDsKoqhNJAwhoWmL9ESKRCS+SdHy30ikMQPjjlJY
	 tSSdYtw94CkCLaMsRPNv6SAedBrxJ+E7C1BFvuuCUB9IfKVXWxDgbRqV6Y91qg9Qjy
	 o0AAEs5Jx/XCYFnEHscsyLfHl5sshAPcXXfPJ/3iW5YfA7xSO1/p6zlXILM3jfbGRx
	 tHvjQ+8De9sgFh2h4koz8akuFuhun4rrwYqRZlNVtSnFW4tCk5h1DNzDBwllZcUyFG
	 prqRa/S8ACSaJsCnq4aMsnmhESAXlqBMt9BZSSllChd+zb3TFSaut1ZNfMjG9Ro5Uj
	 kCe0B+zt5Yquw==
Date: Fri, 31 Jan 2025 10:05:45 +0000
From: Simon Horman <horms@kernel.org>
To: Zdenek Bouska <zdenek.bouska@siemens.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] igc: Fix HW RX timestamp when passed by ZC XDP
Message-ID: <20250131100545.GF24105@kernel.org>
References: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>

On Tue, Jan 28, 2025 at 01:26:48PM +0100, Zdenek Bouska wrote:
> Fixes HW RX timestamp in the following scenario:
> - AF_PACKET socket with enabled HW RX timestamps is created
> - AF_XDP socket with enabled zero copy is created
> - frame is forwarded to the BPF program, where the timestamp should
>   still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
>   behind bpf_xdp_metadata_rx_timestamp())
> - the frame got XDP_PASS from BPF program, redirecting to the stack
> - AF_PACKET socket receives the frame with HW RX timestamp
> 
> Moves the skb timestamp setting from igc_dispatch_skb_zc() to
> igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
> igc_construct_skb().
> 
> This issue can also be reproduced by running:
>  # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
> When a frame with the wrong port 9092 (instead of 9091) is used:
>  # echo -n xdp | nc -u -q1 192.168.10.9 9092
> then the RX timestamp is missing and xdp_hw_metadata prints:
>  skb hwtstamp is not found!
> 
> With this fix or when copy mode is used:
>  # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
> then RX timestamp is found and xdp_hw_metadata prints:
>  found skb hwtstamp = 1736509937.852786132
> 
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Reviewed-by: Simon Horman <horms@kernel.org>


