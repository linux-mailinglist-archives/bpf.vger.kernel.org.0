Return-Path: <bpf+bounces-59041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D6AC5E5A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726A53B4485
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151213D503;
	Wed, 28 May 2025 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOc8WOr/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5771494CC;
	Wed, 28 May 2025 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392293; cv=none; b=FJ6RMu9PcyvpO9J8zJ8nKaXhmGX2PHxrMrHgvCNhLTY0HaUotUhkfUKV8RajI9sjmiKEARwLZvhqW/tgvCDv5mkt8vy911hEx4nJxYpnV52NjnaBZoIb9xW68khrff0Cxv5bwR5fwvtSfOt1g7eOVpeMw49XrAV3jjBBUcHWbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392293; c=relaxed/simple;
	bh=MLwhvtKhwU9vgPKCzIYU7mR+ZDet3iMYeKEF2iU7III=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEqFoycvu8qLiD/z5wBQsAj55QEd8UXNbCBHCf06XvEVLWD4kOyn5tgnW+eayp6NLGDd0TsVLFjyc5rl+DJPwoi0cpW3Z5Z3L4papU8hXbe/IWC4OdTxCJ/sBCc0L3NmZ8zeCupf0xpFOg5A9+4mfedzCrMXA9l4CTzhlUpwy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOc8WOr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EA9C4CEED;
	Wed, 28 May 2025 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392292;
	bh=MLwhvtKhwU9vgPKCzIYU7mR+ZDet3iMYeKEF2iU7III=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iOc8WOr/V5vvXxE7wDSWJ0akr/nSeG1kOGtr/Tk/2z0rPExyalXKWNe7kVJzXDUup
	 SVt8xroqKarsMG7GB4XGmjTgDH69EKPwTgMDiKYZsSg7po+W7+VXfuMQLvJ3WD70kT
	 VvMUEh4thtHmbTXN77ciM8RfejNivizlVOXRZbQ+OM4ES5k/l6Qv5/Uds5TKN5FInF
	 qZ+oJpsgMop2OLZtsk+M9DB9nCLx0oQhWmwN788V4B+TOWG0uLECNjgzCLxWUHcIB1
	 fG1LHn6FfMMpn9r+URDUbI7nxEZDSVmzyW5IhOdOvkrTDPSGRk1qTCKvt8SmpLSHWQ
	 Y3y2IYviw6wgQ==
Date: Tue, 27 May 2025 17:31:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Message-ID: <20250527173131.3d5bfce1@kernel.org>
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 00:41:15 +0300 Tariq Toukan wrote:
>   net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR

I'll apply this one already, seems like a good cleanup.

