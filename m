Return-Path: <bpf+bounces-45939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D819E07F0
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB1173583
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE0208991;
	Mon,  2 Dec 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jy2if8o1"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FF1D545;
	Mon,  2 Dec 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153566; cv=none; b=Gk6aQzGhDtflyuKTi8sPpAYEjiIB3irUo/Alaj2IknSQ7GthyRYyRfyRKvJnAsTYpebrD4m2GRG6rz2l17EsixoMrf7Eh3Hb0Y0VHtbpPDe8auiLDksmtovpVgjPNcKRDlH1ImWKjI2knwj5ffXSugI0bETtnMjj81Z+V0ym5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153566; c=relaxed/simple;
	bh=r9dLBBAiV40sC8+KGiYZSV00p36foDz6DWBwNAH6KqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI7JtG7nISMjljYsFqXPUSRCFqHzSPeza7v5AFpdix22kf9iCQI3o/fo2/S6PWCUTCKfFiWuYTxoTFARjHZcNmLWUiQkEoK2GmIY/T0C9+FRcDJIbj12OmHlAmsraikSR0Y8Cn/LjkYO+zAWwvb7sEQxKkmo2+P4T/Uc6wgDwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jy2if8o1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733153552;
	bh=r9dLBBAiV40sC8+KGiYZSV00p36foDz6DWBwNAH6KqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy2if8o1xBc6ki8SzEZNGQJN1cycQjqsezrB8WK1Bt7miW3h4ykSJ3EvRs5YE6QKB
	 hctX9llehCOaIM8Tox4J9PL2LZv3PRfX6YxIIqBCTdkIBnV6Vco2mRTqoJWBuvd7Gy
	 +Qqvsz3auSxuxOcpfmLzq9t4m8paW6xTTcDJjYeA=
Date: Mon, 2 Dec 2024 16:32:31 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: propagate CONFIG_WERROR to resolve_btfids
Message-ID: <0a5cd9a8-46c6-44d3-9d76-a0191613f694@t-8ch.de>
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
 <7dfd3085-f433-41d9-a697-6b2433e27e3b@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dfd3085-f433-41d9-a697-6b2433e27e3b@iogearbox.net>

Hi Daniel,

On 2024-12-02 16:28:07+0100, Daniel Borkmann wrote:
> On 11/26/24 10:17 PM, Thomas Weißschuh wrote:
> > Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
> > Allow the CI bots to prevent the introduction of new warnings.
> > 
> > This series currently depends on
> > "[PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs" [0]
> > 
> > [0] https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net/
> 
> Given this is a dependency, do you plan to follow up on [1]?

>   [1] https://lore.kernel.org/lkml/Z0TRc0A6Q8QUxNAe@google.com/

I did so in [2], which is already part of the BPF tree.

[2] https://lore.kernel.org/lkml/20241125-bpf_lsm_task_getsecid_obj-v2-1-c8395bde84e0@weissschuh.net/

