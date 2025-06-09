Return-Path: <bpf+bounces-60084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485BAD26A1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4793C7A90A1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC521ABB9;
	Mon,  9 Jun 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgUDJDsG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531CE571;
	Mon,  9 Jun 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496908; cv=none; b=imVtd9Ug+Q5nwD42eg60mn2bZjscKyfa4NkKT8zeNKQxdUdgeGC2TM0u6ikfR/m0Mx5pZkfHzby1rLACUpa6gB8WVdehH/c0/E3OMGuHPklS58b/olsOIP53s/97DYn2dYcdYjz764QX/2YfngUmHRPdk3k5wMVaiq2+7XByhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496908; c=relaxed/simple;
	bh=Wy7igUUFv5LV7lmGWexTUVc5dAUKDOBG/aPkLaAO6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDodd0zbf5FFaQHnTzUJ2MqIOpZVJI//96spya6rF7j8WvhaTvL7aZzMakmju7FK0bF86Xiz6/jbogj6moBhrUssYjCE/oT1dt8dBtx43xnWBU3jQlGl/Rmo+OqDOOJADxIWuUOaxjIdVnofW/6eQaVeqscsq4L6bLYQUaO4H78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgUDJDsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6144AC4CEEF;
	Mon,  9 Jun 2025 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749496907;
	bh=Wy7igUUFv5LV7lmGWexTUVc5dAUKDOBG/aPkLaAO6s4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgUDJDsGAYsXS8mR+rg3ydIbS06x6fDIS0K/2n/ex75Q7NwvkDsw2b3lV5B9AySzV
	 WDmxcjx+4zG5adVMn9YZwFqceUZqv0u20n4dDYEEPY6xbDG7kmLREwqSp6kfSl9hUV
	 YN7bDWnFi0gzXacEQ+2TiUM8zSUJfNjzy6yRSAjcBNm4d18rj7umA+m3DszAQ142yv
	 Lz65HLBgUJpYA2HvrPH0Xss8eYak+QN2FsXq4ZMDoUc5Iow1II0g79+U36O3sTwByW
	 6vW0GtQlyiqovp+5Yj2upm9VlYY/RtLZreIzq41GuBPA0girQannGDN4D6RPmqjWfY
	 PtcOeK2n6NU1Q==
Date: Mon, 9 Jun 2025 12:21:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Whitchurch via B4 Relay
 <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Cc: vincent.whitchurch@datadoghq.com, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] net: Add splice_read to prot
Message-ID: <20250609122146.3e92eaef@kernel.org>
In-Reply-To: <20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com>
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
	<20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Jun 2025 15:26:58 +0200 Vincent Whitchurch via B4 Relay
wrote:
> The TCP BPF code will need to override splice_read(), so add it to prot.

Can we not override proto_ops in tcp_bpf for some specific reason?
TLS does that, IIUC.

