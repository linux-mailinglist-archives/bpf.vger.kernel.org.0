Return-Path: <bpf+bounces-45006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB309CFC64
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 03:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41060288863
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893418FC86;
	Sat, 16 Nov 2024 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVRhlAgB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814A28FF;
	Sat, 16 Nov 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731724983; cv=none; b=gGF1gtVR8ZLcA74GPez0fQrLx6EbEpWhnv6/oxUEYFoOImIIJGRA9KeZUmLy3aOjP6yB9d18TkKetuBOlu5oLpY7pFEvCnkkTxhT77toPosjQ6Qhfzij1cChyebh4u91t2tB7xP1sUET6QOFGw4y4pGoEghMXiML2KxHGo6k4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731724983; c=relaxed/simple;
	bh=+rXykzW0QO6KmG71CGzw9uhXlezD+GywtS6uIgEyuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCFU7MKvnBmzmrMkF6cRdOghl2/Fhlu4mBMMpUYsjeZZA1q/mEbGS+MntaJ7zXD+n5RLtjIl2gNSaVquNBsPWMFu0K0W1uXfdUfKE8HF+haQtRMxeY8orL9dkpAOLzV5UeCd79JvyG8dQSOnZ3OqlluT2ARjTmxv12nt83XlegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVRhlAgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178BBC4CECF;
	Sat, 16 Nov 2024 02:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731724982;
	bh=+rXykzW0QO6KmG71CGzw9uhXlezD+GywtS6uIgEyuKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVRhlAgBbe7q7vT9+0QSKHhjsvL85G8I7PXUyr8JI5sG2DMAnrLJ89s54rgj8Nioc
	 jj/ut1RBQIII53ImYk4XhnWffF0qg+C+GbJyiyXAm+MxKCvdf5f2VrK9q51WAXyuvJ
	 DEdW9NoO+olK2+KSUIssjjsWAUrit2cF8EudbuvBa6pkgLuXj0Ib4zy7rmFiJaKn3O
	 FVK5QG41wcCP/zQNtzoc28Ju0U2l28DzHd+k+JtLCLpYkf60Y9QDYa0A7A0sUqBhqS
	 L5l7v7LTdqbGaYhJ08K+IqCGniVuBrs2aK8PcJqJhloA6F+7AB9ZRs7UZZTwX/AcjK
	 asTHcYfwU9BVw==
Date: Fri, 15 Nov 2024 18:43:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Message-ID: <20241115184301.16396cfe@kernel.org>
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 16:24:23 +0100 Alexander Lobakin wrote:
> Part III does the following:
> * does some cleanups with marking read-only bpf_prog and xdp_buff
>   arguments const for some generic functions;
> * allows attaching already registered XDP memory model to Rxq info;
> * allows mixing pages from several Page Pools within one XDP frame;
> * optimizes &xdp_frame structure and removes no-more-used field;
> * adds generic functions to build skbs from xdp_buffs (regular and
>   XSk) and attach frags to xdp_buffs (regular and XSk);
> * adds helper to optimize XSk xmit in drivers;
> * extends libeth Rx to support XDP requirements (headroom etc.) on Rx;
> * adds libeth_xdp -- libeth module with common XDP and XSk routines.

This clearly could be multiple series, please don't go over the limit.

