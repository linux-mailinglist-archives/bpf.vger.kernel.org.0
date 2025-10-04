Return-Path: <bpf+bounces-70389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B41BB901E
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA03BE79A
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED427F18F;
	Sat,  4 Oct 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSpYvjKr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A234BA5C;
	Sat,  4 Oct 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596361; cv=none; b=qUvDmtsuadh4Vk2aA6B10SSK6hZzN/nPw2dCqF/qwZj2OVQDTuLbjAUwEEVe+NPjwl5hRmoK2tumtbJGq6J+4DvUsFmY2OIYDP6HDoCwdRP3eofO8tsQsr7ezEOhSdHHG5haN3pVV2hjskPXnfyzbIZFwnQsmGQ2XFGzv0CcYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596361; c=relaxed/simple;
	bh=3Zkc7jR/aAZsMuJesAzvh3ylS2v+ebDFzJyAV+5QVis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIYba5pUCJQBilrlBpFsYCR9AprHNlJHOJJ/UFw9Qo6uQ5Ge+P4v9WG6Xmg7/rzHGpQdc0AIrazIwoE/a6Xg8glYhZHjZMgul1vqipxq+YJyuM4IzWeV0ZtDH0PSfi72C2KJ8wj1G/nzmsw/E7w7L4ZDfhK0LrcL7T2iZ6miCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSpYvjKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E6AC4CEF1;
	Sat,  4 Oct 2025 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596361;
	bh=3Zkc7jR/aAZsMuJesAzvh3ylS2v+ebDFzJyAV+5QVis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSpYvjKrAvLnr1TXiEJw9EyD1FdJqQCFVmrsvXaxr9WkLlROQxXGKdz+f4OaGBe9k
	 o3Wo66lTUGcINwlCh8+sG2MDzS8osofsqPsgA5SRxDF05L2W87wvaGOmzw1bugfIRd
	 x/PFBSFbd+/nByCQxX6ly6F4cMz8g3WAT+6E8FKjUcgyvW5WD3l5CARwrdaR6P1W4g
	 dzm3oiibV8b4BpEwAdCSd41/6szRGGWBR4tdccKQfe59btEuWXIe+huvROYNYdz8Fq
	 9IgdMKdCob2iLcp6nAiFryd/koO71XDgY7Y3K88XlJzpJbvX7gavGwdBTQtmypdxKt
	 XkS86NLaRvxjg==
Date: Sat, 4 Oct 2025 17:45:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	alexanderduyck@fb.com, sdf@fomichev.me, mohsin.bashr@gmail.com
Subject: Re: [PATCH net 3/9] eth: fbnic: fix saving stats from XDP_TX rings
 on close
Message-ID: <20251004164556.GH3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-4-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:19PM -0700, Jakub Kicinski wrote:
> When rings are freed - stats get added to the device level stat
> structs. Save the stats from the XDP_TX ring just as Tx stats.
> Previously they would be saved to Rx and Tx stats. So we'd not
> see XDP_TX packets as Rx during runtime but after an down/up cycle
> the packets would appear in stats.
> 
> Correct the helper used by ethtool code which does a runtime
> config switch.
> 
> Fixes: 5213ff086344 ("eth: fbnic: Collect packet statistics for XDP")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


