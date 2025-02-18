Return-Path: <bpf+bounces-51850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3DA3A4E4
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8603AA532
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C9270ED4;
	Tue, 18 Feb 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQjgisGe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613926A089;
	Tue, 18 Feb 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901849; cv=none; b=g/Mm/PnZui5xjb9Br3IgA4DjYVyWycyG8eY/Uae8zjR+bUoHaYI2KPX2xpI1RydYZ87I5DWoOdno3gjL1gcguwhsTNWoEwccKLf9VUxjuxYtqp20eJ7kPJqe6O8lSHo1jc4V/swlXaSzm0YzLYQ8yQ+Q1MBn77jctV4v+x8jzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901849; c=relaxed/simple;
	bh=wdJKKp6bw3MGMhiJmtEGYZQRTMc3zWOA9iLO9b0bQHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9NPU7RukaFYeg5B6psKaA56qb/Unff8lkA4Q/M6Tf21iCGtJQ2w3yVOYX7bGoFJpszkhKzGjfC98zmTHmjLtEYQ6KjYroVrHHlOWckheNF1KjBe+ROJw9Zb/ByQPCD2DyXekD1cu+xXiBrcjbGkSoIU8rjgbBQudYSkpqGc7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQjgisGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E954FC4CEE4;
	Tue, 18 Feb 2025 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901848;
	bh=wdJKKp6bw3MGMhiJmtEGYZQRTMc3zWOA9iLO9b0bQHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQjgisGe5tIJ3BvN8c/1EVc1hKJ0LzND9ysmPMfmvUWYkmzEmNe+S4yok/cuanELT
	 LFDVdwAFhoVfiVxSzj/Fmmd1HmAYmfz+PvPnCZRRqpV5l2YLtpez+Qvh7N3+Ypd9aH
	 pf9/1qpQcZWZMRh06Wu1pAMaUa0ZgCYIZPPBqkGVQvgifxyM8N+81IhX5SxVJIJDDN
	 Xc+lRX4bX8AOnSyDf092N2yNkvKwGAdvijDDzhq60pg3hL+dow0N2mzzkcAQJ2Ne+I
	 ghnvfaUSg3X9kpr+CRDc6VKWKbeFeWEpHhvYl/z9md3R5fVZp2zAB6yQd9J5DwfqFl
	 EAVweCZy2bGnw==
Date: Tue, 18 Feb 2025 18:04:03 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>, srk@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: ethernet: ti am65_cpsw: Drop separate
 TX completion functions
Message-ID: <20250218180403.GG1615191@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
 <20250217-am65-cpsw-zc-prep-v1-5-ce450a62d64f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-5-ce450a62d64f@kernel.org>

On Mon, Feb 17, 2025 at 09:31:50AM +0200, Roger Quadros wrote:
> Drop separate TX completion functions for SKB and XDP. To do that
> use the SW_DATA mechanism to store ndev and skb/xdpf for TX packets.
> 
> Use BUILD_BUG_ON_MSG() to fail build if SW_DATA size exceeds whats
> available. i.e. AM65_CPSW_NAV_SW_DATA_SIZE.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


