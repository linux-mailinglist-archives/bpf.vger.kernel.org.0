Return-Path: <bpf+bounces-44557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CF9C4B59
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08540B27862
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B0201111;
	Tue, 12 Nov 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boYOEPG8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31762010FC;
	Tue, 12 Nov 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372715; cv=none; b=dQEKFrx/u3Xn8Obt5H6r98kSpnjdEStKQRBGq+QIl3ENoDRPqc0yTo1hJmF65f0i9mawB2y+dLGfm8yrz/OYwCNSX0jFhZdWdBZ0Aa1+sr8ay9rM+B1Y4q26fbZ6mG8qTNZiljzE/EjhIp6RdC540MO0out5YmKBaCwqzUzAfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372715; c=relaxed/simple;
	bh=ghNk0vlwGRPTZhszMgilrVKQYOpkdQF90FpgBVBjq/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3EuCiq05ptLn/wjaxSqfprrWM2T7s7uL2Wrif4f17aMjzbweEPNxP8oew6kxXnfDJ189n+lYHtEw1/zxWtoNgB0ZUh2ejFSHaNFVi69LSPW8kVFxPUaIdXHW3JA2ciMR9rqtpFvlcSzBLvFVPvPy8v4rpitbqBtKRguc1LeF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boYOEPG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82BDC4CECF;
	Tue, 12 Nov 2024 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731372715;
	bh=ghNk0vlwGRPTZhszMgilrVKQYOpkdQF90FpgBVBjq/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=boYOEPG8TKORykVEv/FvbFX05/99+lVhcYHQv/q86pwJEjbE45phj6QXtbb0Xk7Qq
	 mYrEoEYuhaVPiVoTk4JZ2VglMtaPftVdZdj04ct1eNvpGmguXDYVoIMRoTXcvl0/Q4
	 oCP9NJ5RXyw++Ls1EGQU1tY52aHJm2YbpmNbzVmQsn0dFDyL9to85/QhH63kJLr8+i
	 K9EmX8+xvuE1HSyWS94CtawDnlTqndrBjI4xVczwsCKxGo7z0JudIw7HZnmjPwz5Gs
	 tCCNcSYaeYYU9DSG6U7qPLZ7cCOsQokoHPXDfPKsHZKKMs3kErcxzhdOzI0YItWjHn
	 Yd8zv2breQh1Q==
Date: Mon, 11 Nov 2024 16:51:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/13] virtio_ring: introduce add api for
 premapped
Message-ID: <20241111165153.5c30cf00@kernel.org>
In-Reply-To: <20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
	<20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 16:54:56 +0800 Xuan Zhuo wrote:
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).

> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).

Looks like we need a rebase, doesn't apply any more.

When you rebase please correct the kdoc, looks like the official format
wants a ":" after the "Returns"

