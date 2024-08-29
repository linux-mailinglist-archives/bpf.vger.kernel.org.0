Return-Path: <bpf+bounces-38460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB4965055
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1C7B210F8
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1508D1C1721;
	Thu, 29 Aug 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/viMvnn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A71C0DE1;
	Thu, 29 Aug 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961062; cv=none; b=ueMFx6/TYInWvQG/DeNpVLqqupt/h+1LduMGlxuWUqM05EFd0yf0umS8M3MMeJBNIpAOJCB4OVpbkJlo0FN1KBc8jjV3Ko6Ho8O1xFsmw0aSXEi2z5Q8Chl6ApdFV0QJ1JubxdXRGeR1ydLwixxo6EbfmMLuHOj1SLcDfNry3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961062; c=relaxed/simple;
	bh=Je4CnA/8fNxge0kbNP3YXYHsYmKu8bZ/0rq7476Lwsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzWf2YE34dFdsZFLd+KalROno5JB4GXMyWoWghWDXlAk02aFPR1JXhPAwpdIuwnXY5+om/v5CiN4ptg9MkG6rAiCvfTx+GPu/44L59TMZAW7bY7njRVmtK75Ge/Fu7TH1ibmcQX+NUaPXYoNDR5qVdh4TLcOxJ3Vahw6FflauS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/viMvnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9906DC4CEC1;
	Thu, 29 Aug 2024 19:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961062;
	bh=Je4CnA/8fNxge0kbNP3YXYHsYmKu8bZ/0rq7476Lwsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z/viMvnnLKCqlfttJ1Z7MJOiQV8PA+JAmUX32qraFCy+ZDrLFvNTRVk8+UQnZ8bFw
	 vW31jwyuIleQntyhNYLgo42bKG7cqiKLROCaII/lssaUSIII22560e1dDoczoDwN1L
	 KxLhezCOkuNI57gQdnhbfflEuw38inAOVMv0tPCdPus86lbISh3x3JYg+AFf4VJ3Ts
	 Ug+MmdWHXQSuYHdgm3+guWJO2OBANONEevue7lJTfIAA4/RaWem8TRMzzK1tRFAD15
	 3iOIlH9iFCEzGG52/NXnVsYa0qk3o363rX0l7vBtDl8QktUa+ysHI6ImINzADp3D7q
	 A2APLenufFU/w==
Date: Thu, 29 Aug 2024 12:51:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, John Fastabend
 <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com, Jakub Sitnicki
 <jakub@cloudflare.com>
Subject: Re: [Patch bpf] tcp_bpf: fix return value of tcp_bpf_sendmsg()
Message-ID: <20240829125100.7a1bb913@kernel.org>
In-Reply-To: <3864f6ed-deb5-4dc8-b351-53ba9dcb18bc@linux.dev>
References: <20240821030744.320934-1-xiyou.wangcong@gmail.com>
	<20240821145533.GA2164@kernel.org>
	<ZsaLFVB0HyQfXBXy@pop-os.localdomain>
	<66c7a37fd0270_1b1420837@john.notmuch>
	<3864f6ed-deb5-4dc8-b351-53ba9dcb18bc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 11:36:41 -0700 Martin KaFai Lau wrote:
> Jakub, can you directly land it to the net tree?

Sure thing! Let me re-assign it to netdev so it goes to the CI once
again, and I'll push it out.

