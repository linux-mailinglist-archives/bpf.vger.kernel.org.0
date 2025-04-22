Return-Path: <bpf+bounces-56454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982FEA97871
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299513B0A2D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA32980D8;
	Tue, 22 Apr 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKr+SlLA"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A9262FE8
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356865; cv=none; b=M49eTPoaCYYipoma5DsanRR/I9jvZIwY3CQf+s97+5XniEfd1k0DwBt9B3LY5dibhv50vH/eu2oqxxk779hUkAYGltHiFWNceBQ/pYix39ey1DFWwR5596Z+Wr2p+tlHlyl//p6LA1Hzsmiz2/uMci8wgvXHdNoHe3MMmWOzl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356865; c=relaxed/simple;
	bh=ZrEAQMqsyLbolKW0CLeMrZ8PbAE+CG5CNRdOoWpu9A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXjbj0mpaRBXvolSlRvBIKhe9zKmF3n6lLAlgjafqPtVptISPtctaGGt4e3/WhNUxdrqD5v0oCC38gpbwBKNYgtgRN0djYD6ThdePuyZErrYIw9zmW+RisvoekpsYVdJPTtOUR/ZMrz1ZA9YapZEjcSMfh3kDLlYrPMKFoXp574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKr+SlLA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0973075-7040-4e59-80b2-7b4840a9b8e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745356858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8it9af45rz3xPU6jGbGfSzUcfD4g1fZDiNmeUzhLF/4=;
	b=bKr+SlLAN81+hFnwnO+/43ZnQibrHqfo5OCRbpM7aWSkrY/Y1gbjhgihe2JfKdc1f/LzOr
	xEpdBeXJpPZs1K9UJlU0ID+PvCtchtwkGiAArv3DUok2F/muMD1YFmv7ixbAeivZDAF1rM
	XqNk1pWsX4N4hBjEGVxqG0mqvl78fmw=
Date: Tue, 22 Apr 2025 14:20:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] xdp: create locked/unlocked instances of xdp
 redirect target setters
To: Joshua Washington <joshwash@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, Willem de Bruijn
 <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Martin KaFai Lau <martin.lau@kernel.org>, Joe Damato <jdamato@fastly.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250422011643.3509287-1-joshwash@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250422011643.3509287-1-joshwash@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/21/25 6:16 PM, Joshua Washington wrote:
> Commit 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with
> netdev->lock") introduces the netdev lock to xdp_set_features_flag().
> The change includes a _locked version of the method, as it is possible
> for a driver to have already acquired the netdev lock before calling
> this helper. However, the same applies to
> xdp_features_(set|clear)_redirect_flags(), which ends up calling the
> unlocked version of xdp_set_features_flags() leading to deadlocks in
> GVE, which grabs the netdev lock as part of its suspend, reset, and
> shutdown processes:
> 
> [  833.265543] WARNING: possible recursive locking detected
> [  833.270949] 6.15.0-rc1 #6 Tainted: G            E
> [  833.276271] --------------------------------------------
> [  833.281681] systemd-shutdow/1 is trying to acquire lock:
> [  833.287090] ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: xdp_set_features_flag+0x29/0x90
> [  833.295470]
> [  833.295470] but task is already holding lock:
> [  833.301400] ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: gve_shutdown+0x44/0x90 [gve]
> [  833.309508]
> [  833.309508] other info that might help us debug this:
> [  833.316130]  Possible unsafe locking scenario:
> [  833.316130]
> [  833.322142]        CPU0
> [  833.324681]        ----
> [  833.327220]   lock(&dev->lock);
> [  833.330455]   lock(&dev->lock);
> [  833.333689]
> [  833.333689]  *** DEADLOCK ***
> [  833.333689]
> [  833.339701]  May be due to missing lock nesting notation
> [  833.339701]
> [  833.346582] 5 locks held by systemd-shutdow/1:
> [  833.351205]  #0: ffffffffa9c89130 (system_transition_mutex){+.+.}-{4:4}, at: __se_sys_reboot+0xe6/0x210
> [  833.360695]  #1: ffff93b399e5c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown+0xb4/0x1f0
> [  833.369144]  #2: ffff949d19a471b8 (&dev->mutex){....}-{4:4}, at: device_shutdown+0xc2/0x1f0
> [  833.377603]  #3: ffffffffa9eca050 (rtnl_mutex){+.+.}-{4:4}, at: gve_shutdown+0x33/0x90 [gve]
> [  833.386138]  #4: ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: gve_shutdown+0x44/0x90 [gve]
> 
> Introduce xdp_features_(set|clear)_redirect_target_locked() versions
> which assume that the netdev lock has already been acquired before
> setting the XDP feature flag and update GVE to use the locked version.
> 
> Cc: bpf@vger.kernel.org
> Fixes: 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with netdev->lock")
> Tested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


