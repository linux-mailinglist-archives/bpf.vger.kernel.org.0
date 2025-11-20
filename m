Return-Path: <bpf+bounces-75117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F17C71A38
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C13DA29712
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 01:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19452343BE;
	Thu, 20 Nov 2025 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0EiuuaB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB115624B;
	Thu, 20 Nov 2025 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600586; cv=none; b=QJ8IRRH6xJNmsyUllDRLfWVvKqIz30LoJTNWA2dA6k5zCu7rQH4fhB3H7jMmNlvlP1bG1FbqHzRld+PwTb7XJYzPRk3WinSjs311H0s4/Kw+DvFTCjlqLlN/2lITSphBVTGH4VonMaCWM3mcbBDlDvzUy9jNPFx2bC+rYyRCboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600586; c=relaxed/simple;
	bh=V+jX/8QopxdSDO6O5TNU3aEQhlUYE8ATtCK6XEKW5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqxXNClFOi9u0EOx+/OSUzwcUOhtZzq6fOIANvewJLR4jenMey3mmyGHeIetswMJnfJ/FmSIAJIfZAuVAPoY5iJcqHPURlVwcY9RkwYm4f3WCt29XxGU9penyUYes2EerwY+S/BsS85a8MMhO4ogPSTqt1bmN9T+4SBuFzETP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0EiuuaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87263C4CEF5;
	Thu, 20 Nov 2025 01:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763600585;
	bh=V+jX/8QopxdSDO6O5TNU3aEQhlUYE8ATtCK6XEKW5RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0EiuuaBz/OpXfei/3z+GvVGzAHjTn8GeJe/V4wbTymI8kxgG7CQW5bgzOyeu9NfO
	 slXNTBw5yovdT8DtaQVJBTZ8wu4Q2bTP2lzDfWD73Lqxm2fZZ4bIcawdaCrJvTd13R
	 FHUubmE24/9h/onBi6fJCZT3EJWbxorAEYAbV7eH3Ooc0saYuzGjhEa5APcFdFqDS3
	 dg3Qwsu9vMDW9yli1a+tHxPFZyOZUYGdhMqqzhIO/4xdvGAk0SRS3VztlZ1MHkcA/G
	 7yg1s/tm0TZItoH1Pu32NXu4EMgTIq/7FulmI9gx5reEeaKH8za0LIHLZVg2bLx2u0
	 eIxNMXBYDlsQQ==
From: SeongJae Park <sj@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Date: Wed, 19 Nov 2025 17:03:02 -0800
Message-ID: <20251120010303.74537-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117173530.43293-1-vishal.moola@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 09:35:26 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> We should do a better job at enforcing gfp flags for vmalloc. Right now, we
> have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
> supported flags. If a caller were to pass in an unsupported flag, we may
> BUG, silently clear it, or completely ignore it.
> 
> If we are more proactive about enforcing gfp flags, we can making sure
> callers know when they may be asking for unsupported behavior.
> 
> This patchset lets vmalloc control the incoming gfp flags, and cleans up
> some hard to read gfp code.

For the series,

Acked-by: SeongJae Park <sj@kernel.org>

> 
> ---
> Linked rfc [1] and rfc v2[2] for convenience.
> 
> Patch v2 -> v3:
>   Only changes the whitelist mask and comment in patch 1:

I'd suggest s/whitelist/allow-list/.


Thanks,
SJ

[...]

