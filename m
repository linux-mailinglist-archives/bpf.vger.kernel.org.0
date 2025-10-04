Return-Path: <bpf+bounces-70388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D9BB9018
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C34F3A43E9
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD627F19F;
	Sat,  4 Oct 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogT6ZX80"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76D262A6;
	Sat,  4 Oct 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596314; cv=none; b=gz3MKBO7eINUfL9H+2vy0ZAZlQeN9RqEAG0E7WTwyZTCtU0Plh9LQWg+uzSeeRmK1UFXusg7hL9R69fzVtsL7ocgIvc/A7xDiMj5POrAQdel1oPWUPyuLfIgyDrM2YbqfHNG2D4r0STdbPfVRhc7/K4T0oBwdOhcsqwV5lO1eTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596314; c=relaxed/simple;
	bh=XxT91GDYIYJD8haxtCXcvVdeAkGevoW2BjK5IgW0zFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgpWLMbLKhPCzxur5nKQsKad0irPauB3NGeqedblukgggkeTdqAY4VuBIOoBtdJX55UqFn7Go2qamqlQxDyWHW0LVUmvT8GSYvpvmjtuHryEd1sJzJgaJZBsxI/Bud0B97qHhmVHQpS0Mimw+N/9+N87zISOCjntjBkYgXH2Oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogT6ZX80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17159C4CEF1;
	Sat,  4 Oct 2025 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596313;
	bh=XxT91GDYIYJD8haxtCXcvVdeAkGevoW2BjK5IgW0zFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogT6ZX80LkiHiRSypYh9jLbdAyzeFgSGTWEcrSh7RX1zuYD1w1UVrWsM+A7n1FFis
	 Z+su45wiRFQYhcKjRTqv7+mvF4wwYvgQyO/iHFvUxObyxQp6oc0L1dig6dhsal5iim
	 +NqOm3V/4WvndPTxbb/FIwn8GoeAFlio1h7dvethVwJ1HHkn/v1JTuAjGbsMuwolZk
	 E0eveb4VQSEhuOK7F9sgFSEUYS3GWkHV7UK03W+MwrYtryArkNBNpBe6zGf9fYk2kE
	 /TbLDHoXPEwoeKaQSlhua1WonICybt12+NKeW1NyTIVZs2rweWHPbdCZqu0JPGUOPf
	 ns9lPfHo4GzPA==
Date: Sat, 4 Oct 2025 17:45:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	alexanderduyck@fb.com, sdf@fomichev.me, mohsin.bashr@gmail.com
Subject: Re: [PATCH net 2/9] eth: fbnic: fix accounting of XDP packets
Message-ID: <20251004164508.GG3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-3-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:18PM -0700, Jakub Kicinski wrote:
> Make XDP-handled packets appear in the Rx stats. The driver has been
> counting XDP_TX packets on the Tx ring, but there wasn't much accounting
> on the Rx side (the Rx bytes appear to be incremented on XDP_TX but
> XDP_DROP / XDP_ABORT are only counted as Rx drops).
> 
> Counting XDP_TX packets (not just bytes) in Rx stats looks like
> a simple bug of omission.
> 
> The XDP_DROP handling appears to be intentional. Whether XDP_DROP
> packets should be counted in interface-level Rx stats is a bit
> unclear historically. When we were defining qstats, however,
> we clarified based on operational experience that in this context:
> 
>   name: rx-packets
>   doc: |
>     Number of wire packets successfully received and passed to the stack.
>     For drivers supporting XDP, XDP is considered the first layer
>     of the stack, so packets consumed by XDP are still counted here.
> 
> fbnic does not obey this requirement. Since XDP support has been added
> in current release cycle, instead of splitting interface and qstat
> handling - make them both follow the qstat definition.
> 
> Another small tweak here is that we count bytes as received on the wire
> rather than post-XDP bytes (xdp_get_buff_len() vs skb->len).
> 
> Fixes: 5213ff086344 ("eth: fbnic: Collect packet statistics for XDP")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


