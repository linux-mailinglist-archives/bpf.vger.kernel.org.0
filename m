Return-Path: <bpf+bounces-72932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDBC1DD1A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82F4560320
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877631D37C;
	Wed, 29 Oct 2025 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqc5fjb9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD92EC562;
	Wed, 29 Oct 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781822; cv=none; b=kuIWvfSufBa9oG1/N/fGfzAlk26xTt0hRg+xE/xG30WRPZKHBIiJp0U4aIqo8aLzviGheXdBtQC3U5xlUD60qh26i0CpZZZOvH0xUcBQBgl0Zt4JHX1EKGNOLAP9OFtuLtaCsr6H5CNxZPHcq6+mLWcWnUQI517/+kH3CvVuM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781822; c=relaxed/simple;
	bh=fM//3UDeJnK4Agl2SUP3JZUXYOZx0yS20VihghA7GxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DksP3N8Y7eEePqQeZGjmnH9lJ5oOJ7cciAKRvacA1k/uC+83EA58KmoWqRDxpKJ4chUMvy/pWpIk6DM61pkz4+gPkn+O2Imwl5XTi1YtdcG6lXS75UzFKNBhJ+RkwXI5jqqflyj+GRCQJFArG+y73GEWLQUgZk6V8Cx0g3PysEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqc5fjb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF1BC4CEF7;
	Wed, 29 Oct 2025 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761781821;
	bh=fM//3UDeJnK4Agl2SUP3JZUXYOZx0yS20VihghA7GxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqc5fjb9Uh5RQNNDeH7O7qarXlnkKxveuz2lA+X4ROGgQfEo8IwAJsQjH+cyg8dS2
	 kHcaWxX/69z0zKPGPeDdf9sonkMTm1KFPcE1rzTqddaoSkE+98n+SY+5afW0Yv8ykx
	 ZARLcTCHfRF37tK9PTRst77WBBgi7qO442I8QtLd2/0bbz5WcLP+dkkdxvXxgAf6/D
	 lLJv9a4azDYUjqqlp7LF21ayXsidiID/STC7g9e42NM3ZYr5csNhmSAY/pcfqgag1g
	 EyrvgdyJzmW6JLeok1XctY7bBFHmbGm1y80vMeGPylEwrjENF78HJ4My9/Q8pLygEP
	 ulizgZWSwGCfg==
Date: Wed, 29 Oct 2025 16:50:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org, toke@redhat.com,
 lorenzo@kernel.org, syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila
 <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <20251029165020.26b5dd90@kernel.org>
In-Reply-To: <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
	<20251029221315.2694841-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 23:13:14 +0100 Maciej Fijalkowski wrote:
> +	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
> +					       MEM_TYPE_PAGE_SHARED;

You really need to stop sending patches before I had a chance 
to reply :/ And this is wrong.
-- 
pw-bot: cr

