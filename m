Return-Path: <bpf+bounces-58773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45291AC16DB
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 00:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD461894B30
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8227E1BA;
	Thu, 22 May 2025 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpjsM5rE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EE2914;
	Thu, 22 May 2025 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953103; cv=none; b=Y0e0T5i/gETbLcw13dM6MUzUxiaFmQmMs5b3CuuhrWpmV0I5GpoDvaM13UKZMuriLVeC1+46FTNhuPSd0uS7T0Tn1iV4bPzyCJJECjI+Qy1LutM+4XN037VaNmM2fQTbbNbr9Qnl4GlBIM7mYJyWeRsPVe0Ku3TQOfHaE5xEuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953103; c=relaxed/simple;
	bh=PbVebrwfqf7PHoDW9bfp76mc8zWQRDna+4r8jZ3T/zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L02W7dMVyEXhrJ5+LJNBcn4I8BDap/IGfPCuyOM6dgJchk9FF28kBM45+efjyd9tR86JO+3HhTbPOSWy9phK1ZdHHb+GKoz2ddpCAFjbE2WCtfhBjRxogn41U+FL1b6h3QLmzEP7AfJaIWTmbOjhBy/gqmmHO4fRaMIxqwCvVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpjsM5rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5A7C4CEE4;
	Thu, 22 May 2025 22:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747953103;
	bh=PbVebrwfqf7PHoDW9bfp76mc8zWQRDna+4r8jZ3T/zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DpjsM5rE7jrTBwP740RfqKD3BNaA4jmDsY3QdgkV3DHXiY+fljxuznw7b4BZZrjur
	 qz5aa2DRdoDOgk1dMGs9I9JqupIWUhM+0JmEGDk+KsMp1+LrZL/Tc1GJdOa38p51wm
	 8RcQhthMVVZt8TNBkJpUdgA4Ad/PGfU4J/aL96/pUJzT/AZAdidbcD5t/xDAnkRHya
	 er5+Xtfe3Q1fiSn1Y/VpEyxKedHSI1fkzlrNiYS+rTCFe94dyxfb75UGkijvxnGfnf
	 J9tjhPKsuQ6ls5j7wy2mwAaIcQd+do21X+B2aEYYkPCEnD73Izt6sW1vUy0wPvMk09
	 9cQu/BmU1O3QA==
Date: Thu, 22 May 2025 15:31:42 -0700
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
Subject: Re: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool
 stats
Message-ID: <20250522153142.11f329d3@kernel.org>
In-Reply-To: <1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 00:41:22 +0300 Tariq Toukan wrote:
> Expose the stats of the new headers page pool.

Nope. We have a netlink API for page pool stats.

