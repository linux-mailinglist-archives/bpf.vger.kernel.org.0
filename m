Return-Path: <bpf+bounces-74264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F14C50362
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 02:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8091897012
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 01:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E8272E5A;
	Wed, 12 Nov 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2wWr4nQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E62E403;
	Wed, 12 Nov 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911022; cv=none; b=smi7h95TcGj9oQnT1Yb/dJAgWSRgBqcEbqLJ9fG185vZXyyjl9F8ivNF5JOxw3RFAERpZoCTeG78kQpnf4DUFGOFSCC8NbBx+j5pQNlVS2zwIKb+T4r2UDqkBOMUqu/FORyODgC5RgRXkpT5MTU5dWsUxzQ9nWhOW77c8uGSZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911022; c=relaxed/simple;
	bh=75PIuoHEXowMg/7egDgGlJsGW/yk5CKxaEHvNzexu6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwUTTLGPxABnH/U2OXkVNqalGCotTnJNE1lJi8MUMTX20CRQNc1w8z174XcgbDqGvjm+kjB5gWidAlNb91noH7vWetXZ68455c6Yue7d2L9QbZJ1HApCN9izmbd6h9wVSZVQ174srAt76tkHKCq+Z+yTqJnwy1C4Xcw5VJz6KgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2wWr4nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABC7C116D0;
	Wed, 12 Nov 2025 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762911021;
	bh=75PIuoHEXowMg/7egDgGlJsGW/yk5CKxaEHvNzexu6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2wWr4nQGufj/mfHfSS5vL/+HsWpj9VwvHN61lPeN3wnv673+R/gZnT9a3gn3GrD0
	 /svl20KP4/RbOadwddhv2UO2SZwJmSeL84cmiPbj9+c7v3EN/K0mjOH2ZAhaPafZXe
	 yfpvgIERk9bIaYusDYzqTDonJzYE5LKKOb/EYMkSl6W3sGHa3vOuE8yqNwB38j15Fb
	 0K4I3/zcqU67oXSlIAwLATwlp+xfoD1/26uBODoPzQikcYqP5mxRMuagFSEZPd9hPK
	 JuAsEUsQK86luC7uuYq6Srdmvxbh98Qy7EDu7XOCY/JBQd9hu+v9+zPtGT+K6/lhFs
	 JeN8MvvVKAKgA==
Date: Tue, 11 Nov 2025 17:30:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, srk@ti.com,
 Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v2 4/7] net: ethernet: ti: am65-cpsw: Add
 AF_XDP zero copy for RX
Message-ID: <20251111173020.360b1066@kernel.org>
In-Reply-To: <20251109-am65-cpsw-xdp-zc-v2-4-858f60a09d12@kernel.org>
References: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
	<20251109-am65-cpsw-xdp-zc-v2-4-858f60a09d12@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Nov 2025 23:37:54 +0200 Roger Quadros wrote:
> +			ndev->stats.rx_dropped++;

AFAIU the device is multi-queue so using per-device stats looks racy.
Please create your own per queue stats.

