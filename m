Return-Path: <bpf+bounces-73213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A8C27350
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4FF3AAFED
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCFA32E69F;
	Fri, 31 Oct 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNtZqGvi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D12566F7;
	Fri, 31 Oct 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954130; cv=none; b=pZammAjA3Odt1YrvFW3NtnAAHPfBw6MPNY7M4mb32ZbdSfA+tWXtFNO8r7/PWdypJqg5doJ5m1oaYUS/S8x6cqZNaJKpNQ/0KgdbgwSQ92lTtBJiiWWUG1ep8XdYKBxzhfJuiiq4+avHt3RJmDEjVdgf0DvQ7cGlYDxIqrToCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954130; c=relaxed/simple;
	bh=eBbfPCOcUmxMSyq7wUBU6DgUuJD7akDtbLm7whVK5bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czQjlSNJxOnyht106hEOsPEHgYbWFRKq/+AKkv0QEX6ug03TuYWI9DC9dBh+UcO9Rsdxvm9upuNcpnxdEc5dPFVozVOsBTXxcy9Ula2fXP7ESq5BZHestbnjW3zvPzUJ+gSRVlMRUnyXrX0DAsBx67GchMF8dB/F6OWGznyy+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNtZqGvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E5BC4CEE7;
	Fri, 31 Oct 2025 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761954130;
	bh=eBbfPCOcUmxMSyq7wUBU6DgUuJD7akDtbLm7whVK5bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UNtZqGviWSQCgguqSrqb89/EyeX0uh1ToYdr04R42VP5ICtBjSMQfFDhEKt2LSSCH
	 KSYsMekB88H8foiwiBkizKT0kA4PPrZKzLI2X+sAzvXmXN3m5i9P5mtHbw8hWVPUPp
	 plSX0koRCcONG6AHc2gHIXBBjdhtcJcRNx9IObO9Wpk9aVdvO341ikThuHbIJ3tFZe
	 17Asvj6FaGVTPRW6Ht8j2xTZzm3x3Co3CKbUKZNlyUNzYozY2PsKbFFqqA5ODdNKfV
	 TQxllv6loWy3T/cr2+rg5ESelW0mzdLeUJFUXHV+olP8Tf8LtxnmkzXsKFUeNiTB92
	 dmA5s6u4IEfXQ==
Date: Fri, 31 Oct 2025 16:42:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch
 <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Convert to new hwtstamp_get/set
 interface
Message-ID: <20251031164208.7917f929@kernel.org>
In-Reply-To: <1761819910-1011051-7-git-send-email-tariqt@nvidia.com>
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
	<1761819910-1011051-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 12:25:10 +0200 Tariq Toukan wrote:
> -		err = mlx5e_hwstamp_config_no_ptp_rx(priv,
> -						     config.rx_filter != HWTSTAMP_FILTER_NONE);
> +		err = mlx5e_hwstamp_config_no_ptp_rx(
> +			priv, config->rx_filter != HWTSTAMP_FILTER_NONE);

FWIW I think this formatting is even worse than going over 80 :(

