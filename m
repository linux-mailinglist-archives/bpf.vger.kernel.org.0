Return-Path: <bpf+bounces-19698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62682FE70
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE3E1C2432F
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66201C11;
	Wed, 17 Jan 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onRdSnN9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361410E9;
	Wed, 17 Jan 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455514; cv=none; b=IgJZlB5wGwoIWQpZcSdnGES3xfVML8LtS8Ks/Afapxm+V7+jSj6GMrg42E38iEiRMd4PDlaW0KbFZQG+MgrrkbdXMpLISNYv7wn9CmYC87qv8VMguQ1ChGuouWZMXNNbaaMb8JGWiXPrEVOGzpcLf3P4Snb9pAF3KDm/xY8PFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455514; c=relaxed/simple;
	bh=R5KLNcXBWSgYOjyxCaaoj7URUp994mkG/8fZlapNemI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=C/6IKA+KeCKEdrTl7KOUGTp99FtQ0Tl6vROgm0/1yPNsNprK+r/vimPY5NQiGu42Sd5hp4khjevf6BdmAr6IGekdARKDGq17l+QLjb5mOOnygxrdOZ/I0hlFS+kz2FGW9ySrrW8Tm1hPDa9x8eTvuUzdvDQLNP++Ns1VCAen+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onRdSnN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7AC433F1;
	Wed, 17 Jan 2024 01:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705455514;
	bh=R5KLNcXBWSgYOjyxCaaoj7URUp994mkG/8fZlapNemI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=onRdSnN9OsfGnJe0rweSp0cvS5RyqDmMufdwe7EewvH5O5RPvYf1SIeuxjCa/mLh0
	 kEV+9KYadAKKRvOP0NVN4EGCTCJqtyDo0xnlYzHtChF0rxD54Anux1oPm7Aw5+f4VZ
	 NJ38oDP51q0OYNtMRxYJsgkzOFuohvxu/bQvWk7rFwYnVvfolhGXoHdP7hpQwJF3gE
	 FeJV1axPMBWYkNr4/UNhISQ6G/7cftLpaM68LGPnu/TanCh8GJz39GDSvvUeTqKEQN
	 ISwnio8D9PQ7JsHEs6QXMJMnqPUPUbH9KRLRnjiSSZIUH7hHUqCD0apSACSDDvwrAd
	 3iid4VUwITXJA==
Date: Tue, 16 Jan 2024 17:38:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Igor Russkikh
 <irusskikh@marvell.com>, epomozov@marvell.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 076/108] net: atlantic: eliminate double
 free in error handling logic
Message-ID: <20240116173832.5ee074c7@kernel.org>
In-Reply-To: <20240116194225.250921-76-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
	<20240116194225.250921-76-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 14:39:42 -0500 Sasha Levin wrote:
> Driver has a logic leak in ring data allocation/free,
> where aq_ring_free could be called multiple times on same ring,
> if system is under stress and got memory allocation error.

This is a bit big, and the commit message is a leftover
from previous version which mixed up the fix with the cleanup.
The fix went in as 7bb26ea74aa86, I'd vote to drop the cleanup
from stable, but it "looks correct" so no strong feelings.

