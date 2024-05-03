Return-Path: <bpf+bounces-28487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E238BA444
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A808B21232
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33F1EB30;
	Fri,  3 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx3VgfIY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AA3D68
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694430; cv=none; b=BxoDV0Fyf6oMjLELzRi4BkEpXSHhhnatgBexrtUX7h4wwmrLEcYcS5kIvNnIUO8VeJo/FKg844vc3QKt8mDstLgLMMWWZyd0I1foEWvkxms2/gKSteahhIlg0c48yk85S+1bX/i26u+zq8P6+VXZ6KfM7gykg1ifzPjGVkaQnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694430; c=relaxed/simple;
	bh=g9PXDTyCXXCdfo5WooX9CYJ7FEgMpLpMTRfhe6wCZcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GMPJANPnHw6kUpMvQPD+3btd19Da2MYsyJ03C4KSLbSbbxaYWMr7mDUA/KVIeqBdQ9Vknvg0NoKJHQIarDZPeKWKWTsi5MDsDW85s52xV6WamgTEvSqCNbzbdMv4kLrNfJmFjxmxep23qa5CJ/tTgjXAeinsRUbff8PXKU4MXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx3VgfIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88498C32789;
	Fri,  3 May 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714694429;
	bh=g9PXDTyCXXCdfo5WooX9CYJ7FEgMpLpMTRfhe6wCZcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yx3VgfIYwQ7OgGpHTS6iZv6Y5LiJJBg0X911k+qn0ObKh6av7L7utI3T1DF+BYZTQ
	 lhghAt+k7sBKVni0BUaoig/u2RMadXESA+rOnG08+nwNXd0FTZYTT8Uvk2299odSBn
	 qix801BLXlcRS+CnkD+KcZTeMFTuq5u6uriHfH0FbzW+wgRE6MOFJcVXbetaAW3Fx1
	 MlWWOr/rXZfnSaH8fhgCiK/v7xngvuyg/cgjubvAPiT1luoQQ68RmDE9woqcHzxwZ3
	 LysUNcRs5kSMWXALqzLje+SdSQps5Pg5FtYcGdH1ZHcOLB/duDknnJdti0m0jjjb12
	 CsXm6mUiZdi9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FA83C43335;
	Fri,  3 May 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: fix potential overflow in
 ring__consume_n()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171469442945.28889.17821716698319813864.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 00:00:29 +0000
References: <20240430201952.888293-1-andrii@kernel.org>
In-Reply-To: <20240430201952.888293-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 30 Apr 2024 13:19:51 -0700 you wrote:
> ringbuf_process_ring() return int64_t, while ring__consume_n() assigns
> it to int. It's highly unlikely, but possible for ringbuf_process_ring()
> to return value larger than INT_MAX, so use int64_t. ring__consume_n()
> does check INT_MAX before returning int result to the user.
> 
> Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: fix potential overflow in ring__consume_n()
    https://git.kernel.org/bpf/bpf-next/c/00f0e08f23fc
  - [bpf-next,2/2] libbpf: fix ring_buffer__consume_n() return result logic
    https://git.kernel.org/bpf/bpf-next/c/087d757fb473

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



