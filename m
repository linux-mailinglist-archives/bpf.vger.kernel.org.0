Return-Path: <bpf+bounces-45185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361999D2816
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD26281F70
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498871CEAB8;
	Tue, 19 Nov 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tooqZ7lK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D131CBE8D;
	Tue, 19 Nov 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026345; cv=none; b=DHJZzd1hHKfH89NndXA7QPmkjZCsZHGOj7ETSuUVAUxA46vv/J0t/cSBwzzOtkDvhEI0JHnsQTxt+pKv02xVOgNv1RKeS2U5enn+RP/Bn+65bKCmSsXA2fjQvF79flCiRq1snNMwqE3Lw+PJMnQBST5eIVAgEhEjr6nyU5p4bm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026345; c=relaxed/simple;
	bh=mjmuQ5REEGrJNiwfId8qSYDdZ9xIZ6W//wGJVaY2Mh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxvLqB4xlwAW0Kkiu5SqYBMI831hwe9CY3Xl8FpBOQ/7Byi/2nwCVhxTh4YC4r/f93cbH3NDEKWoNb96AEOcTCvPZ+mF6LP1tsXP+8fsJYsusxoRMPxC1vmfJB4nvNGktEz2G8e2N0nmGLZ3jlB82tsLuCDB7JbIfoLowvTmaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tooqZ7lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD441C4CED0;
	Tue, 19 Nov 2024 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732026345;
	bh=mjmuQ5REEGrJNiwfId8qSYDdZ9xIZ6W//wGJVaY2Mh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tooqZ7lKmc3u22VG1T3RT+aV21g+7MzJh0jOrENS5symZUeqUx9x3GboDdxWoxeUD
	 4iA2AWldYyxFuQGOIItG+us8hp1y+iOCdsYdZpkQy/34fMyMLj81ZcgVYpSD76nYVA
	 8SnCl9CjS0uzSU0GKEpgZy6CK2Oi9BhNRuR/bkeiad5ITWUcVBOjBAbIApwNGYje7S
	 BLbe/TUqzKVs+4LWjHDHidP4zUKK3UZzD4QKUB6+GePIrbpHSUdsDbZchazYjKKCKG
	 FSYTAAHjrjtZbbnij1FtlSoRf2Fna0xBpe1eMshNvjbbMFlHGWrQI2j18DK/4i7zHQ
	 PhUiEMIHkZGyg==
Date: Tue, 19 Nov 2024 06:25:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
 <magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Message-ID: <20241119062543.242dc6a9@kernel.org>
In-Reply-To: <63df7a6a-bb4a-410d-9060-be47c9d9a157@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
	<20241115184301.16396cfe@kernel.org>
	<63df7a6a-bb4a-410d-9060-be47c9d9a157@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 13:06:56 +0100 Alexander Lobakin wrote:
> > This clearly could be multiple series, please don't go over the limit.  
> 
> Sorta.
> I think I'll split it into two: changing the current logic + adding new
> functions and libeth_xdp. Maybe I could merge the second one with the
> Chapter IV, will see.

FWIW I was tempted to cherry-pick patches 2, 4, 5, 6, and 7, since they
look uncontroversial and stand on their own. But wasn't 100% sure I'm
not missing a dependency. Then I thought - why take the risk, let me
complain instead :) Easier to make progress with smaller series..

