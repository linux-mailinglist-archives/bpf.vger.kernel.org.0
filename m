Return-Path: <bpf+bounces-68043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E115BB51ED4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB527B9B8D
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE8320391;
	Wed, 10 Sep 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6O9S5Q2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E03126AD;
	Wed, 10 Sep 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525027; cv=none; b=P9yNOU9QVyiWOS/QhWqclXmdW2GWoCCHSSB3imNuS2wIH8roTgzniqodIGLfoeQPg7hL/v90HKj8lnzkQNOLB06kkP0AwpuEeu0pU0tEsfybVFFC/Gul52z+x83Ybfd298dKo3WnklIe5mpOCRw/7w+ihnUKo6Qr22A1CJSzzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525027; c=relaxed/simple;
	bh=2oZJ4NanHFBpJK7mVTRXGTHVse28QdOdraSCom3vIek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aK56oWF9oG8YyW0oG77YFBZwLqRIxPknvEFvtguEQKz9pxBgvxIkJCV0rfn7oRxX5343MgA9fJY7TqrzJEiFhOoteJEfDV5tP3f5xqZijVb4ecUOG4SJ77DUVg9vWKWU9X2vne7+zQQS+uS2tKC/t0LPTZgiYy0bscPQKkbMKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6O9S5Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6391FC4CEEB;
	Wed, 10 Sep 2025 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757525027;
	bh=2oZJ4NanHFBpJK7mVTRXGTHVse28QdOdraSCom3vIek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6O9S5Q2uEm03nX9khvKTs3zwLxAynuxcSNN2DcHEDwglyX7vSXB7VJ4WxQsSzyUt
	 GMGIx+WAPsTj3Y8w2VXDbln5WqnVwsFu5TUV5j+g0EcLSm+Oy6ZQXKcBWf1ce6B/zN
	 6qt2mSdMsDr6J2+2kl8o+UApCD1as6lOCjJqZDcYiIaTUw1DmtDDT8Z7uXusQo/+RX
	 XSEtnT8vQSC9gwAui/qvxbkFk2F/E0CXFPzsibGLNQzHCDjlW713o2VD5vVpO270Cw
	 Z07Mr/aFxcmEaP7CA9RewabJJkEvkYk8GiAAJNk+1RTfEV9fncPnQBrfV3g1OhzQcy
	 CpdmRM/d5VtOQ==
Date: Wed, 10 Sep 2025 10:23:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, "Leon Romanovsky" <leon@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Message-ID: <20250910102345.4fd2b49f@kernel.org>
In-Reply-To: <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
	<1757499891-596641-11-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 13:24:51 +0300 Tariq Toukan wrote:
> @@ -45,6 +45,14 @@ Parameters
>       - The range is between 1 and a device-specific max.
>       - Applies to each physical function (PF) independently, if the device
>         supports it. Otherwise, it applies symmetrically to all PFs.
> +   * - ``num_doorbells``
> +     - driverinit
> +     - This controls the number of channel doorbells used by the netdev. In all
> +       cases, an additional doorbell is allocated and used for non-channel
> +       communication (e.g. for PTP, HWS, etc.). Supported values are:
> +       - 0: No channel-specific doorbells, use the global one for everything.
> +       - [1, max_num_channels]: Spread netdev channels equally across these
> +         doorbells.

This is not vibing with the changes we merged yesterday (or I fumbled
the merge):

Documentation/networking/devlink/mlx5.rst:13: ERROR: Error parsing content block for the "list-table" directive: uniform two-level bullet list expected, but row 8 does not contain the same number of items as row 1 (3 vs 4).

Also in this series:

drivers/net/ethernet/mellanox/mlx5/core/devlink.c:549:11-83: WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD

