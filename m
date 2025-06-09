Return-Path: <bpf+bounces-60066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C418BAD223F
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C066D7A2300
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B721019C;
	Mon,  9 Jun 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7nVh0kV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756921FF5F9;
	Mon,  9 Jun 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482424; cv=none; b=ANKSRhay2Z8egt6nmZIRT6lmJ5hXfPblGYf0c2NjXZswMtmx1zGQoJGY8+UjGwYRS3zdu+VW1YJTK3gUNQqRmvs0TQpYPapqbUtvlgNcBy2fK/7rmHVc3h/kCJdITveBhr7gW3nJhFSPhrWtr7Jariy5ya7bdiCbbOrVY4iZ31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482424; c=relaxed/simple;
	bh=sUaUR4iSXz3vBAGFwkg3IlGWXLi6RP/yU+4D3g+9NZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTy4DTQ9r3nJMtkNqLDtV8vhmvcHBDjoGZyYGWa4xGTixvfbSNJTKH4UP9uLdpLoqkuYDpBz9ohIlAUTUd+X8IhicGroYupZ1M7v25h4GS6farzX2b0wnyBUepzFGqoc+mZKfatxyAcgIc2OB2/pN0elpNxGpXjP4itzpcgW9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7nVh0kV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657C9C4CEF0;
	Mon,  9 Jun 2025 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482424;
	bh=sUaUR4iSXz3vBAGFwkg3IlGWXLi6RP/yU+4D3g+9NZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7nVh0kVizSkOEZ3nC7Hqdj053DIZFgYMyFad7S6tGsZrRXqitqx2lUUbvzorqaU3
	 +Kq4gyqsqsarbYPzB8DUktJmAFZOA2B9EfVbk6Id2tH2Ndj9UkC8haUxkl2fM0VeZl
	 PSjHpa6y/Y30m4xlFD6fnM0bTWaU+JeXUsjoGvbwAeT9Hl2wyBrSxGrdGyVozkaG0n
	 y4cEUGs69A8hUc/eOv4QpQlcILkA8EO3VUaILaTIKyP5PA2Gj+7+at5iTno7fdTOTB
	 4pXAIiPa14/mvlJI3XAtHilSHX4EGIEQ4TOpBGpq/BkpMSzNSV5wK7YAkmRTV+SVPq
	 EPYBpFQed9POg==
Date: Mon, 9 Jun 2025 08:20:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "saeed@kernel.org" <saeed@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "hawk@kernel.org"
 <hawk@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "leon@kernel.org"
 <leon@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Moshe
 Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool
 stats
Message-ID: <20250609082022.5ef0c44a@kernel.org>
In-Reply-To: <c8196bc9-ea3d-4171-b99b-b38898081681@gmail.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
	<20250522153142.11f329d3@kernel.org>
	<aC-sIWriYzWbQSxc@x130>
	<2c0dbde8d0e65678eeb0847db1710aaef3a8ce91.camel@nvidia.com>
	<c8196bc9-ea3d-4171-b99b-b38898081681@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Jun 2025 13:09:16 +0300 Tariq Toukan wrote:
> >> We already expose the stats of the main pool in ethtool.
> >> So it will be an inconvenience to keep exposing half of the stats.
> >> So either we delete both or keep both. Some of us rely on this for
> >> debug
> >>  
> > 
> > What is the conclusion here?
> > Do we keep this patch, to have all the stats in the same place?
> > Or do we remove it, and then half of the stats will be accessible
> > through both ethtool and netlink, and the other half only via netlink?

Unfortunately by that logic we would never be able to move away from
deprecated APIs.

> IIRC, the netlink API shows only the overall/sum, right?

Wrong.

> ethtool stats show you per-ring numbers, this is very helpful for system 
> monitoring and perf debug.

