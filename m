Return-Path: <bpf+bounces-58736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08937AC1096
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6951D4E7C38
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1463299ABF;
	Thu, 22 May 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScAsorDo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98629CE6;
	Thu, 22 May 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929618; cv=none; b=F1uskqeJmnCbOtTB0cAyDM6Uer1HaE4yRNwtKKEvB44h/yW/JQi0vICyiCblHt0RAjuW8M7KWL+OhNHmCn8j3updSNGHwadAqfzCvPPCjEqLk2favY8yv/4XUGTBRpjAnLYnKAIjKlCWODYllGeezm8Om//yGOxg4Y1scyLMyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929618; c=relaxed/simple;
	bh=Duu6R2oqMGbRLS8KypoJ+q341Mlb5R2v5xwyexlzGzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1oe9YvbR9cFo5RUM8E0eDlDNUeaP+bF+HGCMeaXlobFGlyv72WXUZgjDaOFA/gKCPn9tw88XgSfSah0uH/8y6J29erVqWOwbSo3jpkTTKQf0EXlso8BFsMsuWidnDjb1n+0MKHjoFyYWaoZRt3yzwDRaK7+hj3/l0i5MCQUWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScAsorDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02F8C4CEE4;
	Thu, 22 May 2025 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929617;
	bh=Duu6R2oqMGbRLS8KypoJ+q341Mlb5R2v5xwyexlzGzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ScAsorDoSw/NfVCiVDXq+nPJi+lDWwlFwznuUi9r8l+wmzMpygrZ4jlScGJCr2mag
	 dsMyh7Sitj/VKhbTgu/lSJp/z1SYqWBm0ecM0YYbpfS9I7Lnn6EpEUYJCuc2PkHy/f
	 qshWwBgEf8KgVRL+PqRWa6tXXejMgUegVwjcxi6BsctAjBIEVfLwqPRVFMlbg5rHAK
	 x31pQFHSq/+mH18rcgx3VeIhaj+JEOEbWSPnm7nJoyycVpXOuR1bxhHZURhXJq8XzI
	 Th8Y66s1I+v3lO5Je5GLwB9Wenizvw9kpoVWZXr8Kdx/k/3+w3q7/6SZBdfcHckdDw
	 Vxt9mBh2icfIw==
Date: Thu, 22 May 2025 09:00:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Richard Cochran"
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 4/5] net/mlx5e: Don't drop RTNL during firmware
 flash
Message-ID: <20250522090015.60147b61@kernel.org>
In-Reply-To: <1747829342-1018757-5-git-send-email-tariqt@nvidia.com>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
	<1747829342-1018757-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 15:09:01 +0300 Tariq Toukan wrote:
> However, the stack is moving towards netdev instance locking and
> dropping and reacquiring RTNL in the context of flashing introduces
> locking ordering issues: RTNL must be acquired before the netdev
> instance lock and released after it.
> 
> This patch therefore takes the simpler approach by no longer dropping
> and reacquiring the RTNL, as soon RTNL for ethtool will be removed,
> leaving only the instance lock to protect against races.

You didn't mention it so just in case someone tries to report this 
as a regression later - devlink has been the preferred way to flash
devices for 5+ years. It has much better UX with the progress
notifications, and already does per-instance locking.

