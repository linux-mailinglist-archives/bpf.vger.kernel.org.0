Return-Path: <bpf+bounces-56083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2EA910F4
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 02:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC6B1907181
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE4190485;
	Thu, 17 Apr 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asR2gNEl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202774A05;
	Thu, 17 Apr 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744851517; cv=none; b=ZZXWMpdWoAhdxDV0Z1OLwMPF6rUMc07ENRgms0z6JpXA24fxSEZz+pIzT+h2jpdtN47hzjLsIpq2+dy0gQz7EAKsGsyMoEkixYIQr3qm1Fp8ANcBzgbnimt2CFNhu/cM4iNCUvqFaaoV+aX0vYAO32c4yL+kARHy++wjy1tPhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744851517; c=relaxed/simple;
	bh=IJ60gUMEGTmb8XxC1mQ13En+4ayrfd2OTpbrOX8ZN1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN/yuDYc303I5MoQfhiOOUPmeog5Or9T4nogwRToqJhMFKdNy6tCxjEuGYJ3pVu/3bEglSPIPDp0C+Hr3apEi0B20I+DI0joaXp8/1RFRPiyddpcWaih1C9zupT+aAZ1aNQBaDYGztyFZUF2F+eVA4Tl+EhqeF8tpnOa5rj78/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asR2gNEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE9CC4CEE2;
	Thu, 17 Apr 2025 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744851516;
	bh=IJ60gUMEGTmb8XxC1mQ13En+4ayrfd2OTpbrOX8ZN1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asR2gNEl/7FkbuQ+3UP4beLzsskFfi/ipeAnceSSj7rL1aTmcmirHu0ADrFJl1nA8
	 NmEEUbzJaHKbo/cypO19YlgFaH0l/Y69kfC5sc1VXmOVwHN17FWQxnjaThmZvG6keA
	 WUBp2Ozj8xPdpuJgpZfzk19Ftd3wsieylcIL2PESPXlY9WM2IwclfL9ln625Ie1xYW
	 5oNMh/4Kp9JYKR1e5qdre3WUUOyNO66b94MbZMIa8uP1poMII5p/iK1vqRziVmhFga
	 UqVdL1MpQB5cN0VUkZDBrs3HTR1J1VxPjI76RUpkT16+QpXkTTDI+Wa92QEvL+mK8/
	 tEc7ZZS/i3oTw==
Date: Wed, 16 Apr 2025 17:58:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
Message-ID: <20250416175835.687a5872@kernel.org>
In-Reply-To: <20250414183403.265943-1-sdl@nppct.ru>
References: <20250414183403.265943-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:34:01 +0000 Alexey Nepomnyashih wrote:
>  		get_page(pdata);

Please notice this get_page() here.

>  		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf)) {
> +			trace_xdp_exception(queue->info->netdev, prog, act);
> +			break;
> +		}

