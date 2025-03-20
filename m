Return-Path: <bpf+bounces-54472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B46AA6A684
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3963C8A6EAE
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0E45027;
	Thu, 20 Mar 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beL7dyff"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F5AD5A;
	Thu, 20 Mar 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475272; cv=none; b=hHt4+iELeNcgaBMlP8rB387WloctXZPk4UyYUBAtO/U7RijFkQBZhUPXO7TZKOLBdijAyS/fYPVhAaBhum+jm0yIuXZFnDMwFLjmzSjceb3EA+cCn4Cm1+hHoRwl6UF4GKufm5jtOO/lpcLackkJKXeYbCxv0nRfVkUCKCgUk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475272; c=relaxed/simple;
	bh=UUeHYaWcZVHy8DD0p9+ABrB/AFWTnKzv0JWjred+ovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcirW/v/qQ4IsZCw8bCx6i8zVuDHBitLuNCmYTAdf8IcZrOWB+7QAX4bIInQUeGtLxagzuwFbLJA51cOmkndSTn08wrkZZAEIhJOCPkZn71l7Zttmq/qgPiWWRu4uQUL0JjE0eCWvwlnOvA/Q5MjIMGXt1At719OvUo/oCxXGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beL7dyff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B40DC4CEDD;
	Thu, 20 Mar 2025 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742475272;
	bh=UUeHYaWcZVHy8DD0p9+ABrB/AFWTnKzv0JWjred+ovQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beL7dyff5kYW6aDIOicQPhtdSJasmuSwJdRjUIlh8MSkfspCTwN8zNUDz9AXwgnun
	 uM5wDfa4HeC8Gwn7yc/7xMtG6aISfUtFeX5hRvyGd+dCuGP0arFvrNJkO3F2YT4z/N
	 tEQr/EuhRNbkluXRAsZJpME3up9CI9BD1CZRkb3gARoD4SAbzgOglnL7YpWg9gpjRS
	 UkFhxfi0FdjjJiX5lhBs1bSwwl2+tqvFAQXcnl9Fd+QsFguJRdRviV0VlSZTLyhjae
	 s+tBlQnQX8PxRyeLwdUo9bcBNxuGNzD3JxSaqW6kaRpY81OM5pXpAY3FVvqDOgcYna
	 ctIymZBUPqong==
Date: Thu, 20 Mar 2025 12:54:26 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kory.maincent@bootlin.com,
	javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
	jacob.e.keller@intel.com, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next 3/3] net: ti: icss-iep: Fix possible NULL
 pointer dereference for perout request
Message-ID: <20250320125426.GP280585@kernel.org>
References: <20250317101551.1005706-1-m-malladi@ti.com>
 <20250317101551.1005706-4-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317101551.1005706-4-m-malladi@ti.com>

On Mon, Mar 17, 2025 at 03:45:50PM +0530, Meghana Malladi wrote:
> Whenever there is a perout request from the user application,
> kernel receives req structure containing the configuration info
> for that req. Add NULL pointer handling for perout request if
> that req struct points to NULL.
> 
> Fixes: e5b456a14215 ("net: ti: icss-iep: Add pwidth configuration for perout signal")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


