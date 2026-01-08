Return-Path: <bpf+bounces-78238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89143D042FD
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 17:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F972301266A
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EA272E6D;
	Thu,  8 Jan 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="anmTV0HF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83B264A86;
	Thu,  8 Jan 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887667; cv=none; b=M7cvIqbWLJAYpTvrViT8YR0E/jjWm58vTjjg4NIZSCHn3ySSsfW6/v84KSnuB8sMmElubUMWvIwARWc5jsS4gC571Tb/AINBvfWunYkTT5r2ooe5nOjrP2KD00yI5kkGuQbwlZDosV5TTdOAc2ycFgD38a1Dy9RGDOeEqusr4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887667; c=relaxed/simple;
	bh=D7mFMv1M/e+pJMtAzOs2WcvquDi6G1yfA7fqyx8qQAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro6XQCBY2o+plSTqWi9cJv14tjkgpMQm8saJp0dSPRYArwa0Pd6CjATpdns9+JFixMw/Q4JdeShNp7X6dAUOdEm7NTyexRGk1qhY5pd9n0XQzNPYTC7laQKPilHoPKhwc38Ii2IyMT6APDYdcUYTGvffX/GDC7x9JmP6xbDWhIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=anmTV0HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCDFC116C6;
	Thu,  8 Jan 2026 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767887666;
	bh=D7mFMv1M/e+pJMtAzOs2WcvquDi6G1yfA7fqyx8qQAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anmTV0HFmn5QQsF+PGyK0sxpR71b+VQYn95yley/jmx7xSc2D+J2/LfZN+pv2xppz
	 Juou0wOhbO2Ns0uZJNIhO8+6kXiQy/XJN/urquVjzd5GAGvSlL5y2ykTQKI1L+bwld
	 BIw9GXlbMSMduRu+KeIJg7cF4v75ANEcje9+Ox98=
Date: Thu, 8 Jan 2026 16:54:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: HarinadhD <harinadh.dommaraju@broadcom.com>
Cc: stable@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net,
	jakub@cloudflare.com, lmb@cloudflare.com, davem@davemloft.net,
	kuba@kernel.org, ast@kernel.org, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.y] bpf, sockmap: Don't let
 sock_map_{close,destroy,unhash} call itself
Message-ID: <2026010808-nearby-endurable-8e19@gregkh>
References: <20251212035458.1794979-1-harinadh.dommaraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212035458.1794979-1-harinadh.dommaraju@broadcom.com>

On Fri, Dec 12, 2025 at 03:54:58AM +0000, HarinadhD wrote:
> From: Jakub Sitnicki <jakub@cloudflare.com>
> 
> [ Upstream commit 5b4a79ba65a1ab479903fff2e604865d229b70a9 ]
> 
> sock_map proto callbacks should never call themselves by design. Protect
> against bugs like [1] and break out of the recursive loop to avoid a stack
> overflow in favor of a resource leak.
> 
> [1] https://lore.kernel.org/all/00000000000073b14905ef2e7401@google.com/
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Link: https://lore.kernel.org/r/20230113-sockmap-fix-v2-1-1e0ee7ac2f90@cloudflare.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [ Harinadh: Modified to apply on v5.10.y ]
> Signed-off-by: HarinadhD <Harinadh.Dommaraju@broadcom.com>

Please use your name for your signed-off-by.

thanks,

greg k-h

