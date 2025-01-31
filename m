Return-Path: <bpf+bounces-50212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9BA23E38
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 14:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B993188A229
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EEB1C5D77;
	Fri, 31 Jan 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XWS5uL4R"
X-Original-To: bpf@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEC1C461F
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329202; cv=none; b=KV7nD5No3U5G4tUSrVGdpY0jk0MRTG/f021i+OiMOqmMPsyDAwQGJM5a0irmt0j2y7jSA1mOK/Aw3YWJQwb3RyPk875BIxO2D++TCLG4hz5zuRADDXeUFmyUNYQLT/1E2yn1XG3sk8ciF+c7KCfBODHI9Yu0Pwov5jQvz+hDqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329202; c=relaxed/simple;
	bh=k5RkkXzF13rZXSL9io3ekPgEPUw+PXfJpxELXTQUpY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BP+luXPY95q8UgA9Dw8b+TwMK7fAX90lwQ4aIKwNRsAJjEPxa1XwziDXb42SmPoylCz83RarMNy8BAgVXwLxEcGlT6H7LNZcyu//6yjMAdK3GR58A1MPfAbZdKcxAD1tcYAYCFnr++l17We6pRWvRoH6MD3lnFAgBgPqKIKLBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XWS5uL4R; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025013113130978f6a7460de655f783
        for <bpf@vger.kernel.org>;
        Fri, 31 Jan 2025 14:13:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7ddmw+MSH+bE+lpmVD4Wnv3gYJ4CsT3P6TUawXH7hJk=;
 b=XWS5uL4RZBFQEOgbrkoinobFHaphy8O+5E+P3yGXLd7XDgQnHjyupzHw/nFjHHjoFdTGf8
 mvcNlRBNYG8wW8IswCiNjHTMgAeNTd32AjpAXjStl8fyMt6y0rmFi/Yztz3oayTTUZiOqW3a
 sQaxSTerPXPAzJLqFHYAVUGkM8zHd3MPwWKw6SUnzJqfKdUeo9bHmdirmf4oOL/0OiGPXbER
 LJi8XzNCm80kQsfkobrEsJKbXnCXlQOD0N9Au9jkV92M0qC6kNZQPoxrc11wtPjGcoN+mHl5
 8Erb2wyxszaDR5KHq87NIv6bd1IyNXl4K6+BYuiaKdarLvOVMgfCkBEw==;
Message-ID: <f86bc94c97d6e91b3564d3df6f91722318c8d24f.camel@siemens.com>
Subject: Re: [PATCH] igc: Fix HW RX timestamp when passed by ZC XDP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Song Yoong Siang <yoong.siang.song@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jan Kiszka
	 <jan.kiszka@siemens.com>
Date: Fri, 31 Jan 2025 14:13:08 +0100
In-Reply-To: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
References: 
	<20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2025-01-28 at 13:26 +0100, Zdenek Bouska wrote:
> Fixes HW RX timestamp in the following scenario:
> - AF_PACKET socket with enabled HW RX timestamps is created
> - AF_XDP socket with enabled zero copy is created
> - frame is forwarded to the BPF program, where the timestamp should
>   still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
>   behind bpf_xdp_metadata_rx_timestamp())
> - the frame got XDP_PASS from BPF program, redirecting to the stack
> - AF_PACKET socket receives the frame with HW RX timestamp
>=20
> Moves the skb timestamp setting from igc_dispatch_skb_zc() to
> igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
> igc_construct_skb().
>=20
> This issue can also be reproduced by running:
>  # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
> When a frame with the wrong port 9092 (instead of 9091) is used:
>  # echo -n xdp | nc -u -q1 192.168.10.9 9092
> then the RX timestamp is missing and xdp_hw_metadata prints:
>  skb hwtstamp is not found!
>=20
> With this fix or when copy mode is used:
>  # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
> then RX timestamp is found and xdp_hw_metadata prints:
>  found skb hwtstamp =3D 1736509937.852786132
>=20
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
> ---

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

