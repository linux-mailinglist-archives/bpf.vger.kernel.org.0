Return-Path: <bpf+bounces-58069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDDAB47A2
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A5D8C166F
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804329993B;
	Mon, 12 May 2025 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4QuTtIu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249A1DDC37
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090190; cv=none; b=rO2R01sciZRcOIUXw7hmrqsRRS0JDLyLLuWO/AuzUp/aXWAyGiubgLYju/EtJw479ou7Z6a3Zy43j5m8p3Z5gvC3aSbzXENycEoBm8AWXVvBYJMWN6bWI1dqzbXne/ZARExz3JgWdRPZx009IEscigbLfUS0asRZgLiGR49y1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090190; c=relaxed/simple;
	bh=Uz+rqeuSi7sLbJftGQncI//arkblTgD+42Xg1+Rtvg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P84GtpXrNgQM1OXbojjliYErVHcSc3Tf+CWX+WXXSkdvSEof6jBu15SNCektToWq97ntks7XFpAm7244YsHggz/qjhsLWdXOK3MpJFYmCGuY2u6JAw5O3lHTdyQdIMdPkHE9OF3gE59lhylkQF2LbVW6d6esClFTX19K820eY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4QuTtIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B42BC4CEE7;
	Mon, 12 May 2025 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747090190;
	bh=Uz+rqeuSi7sLbJftGQncI//arkblTgD+42Xg1+Rtvg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b4QuTtIul5VH+mtvk8rIa0t1T1q41kJRiNPUYUEUTiwGPjC66AKOvm2JXifGSodS8
	 Y5X32TJq6aIzN53HPToneq1V/l6C7SzjJoEdbvqNS7GuLe4swlVOi6l2J6j0vswCEc
	 hqmqaLXp6IHQC6NU2GXmNc7fEenAYbUCpZuNNPkMN4ovEv3ua2XtOeEP6cYauRf+Tg
	 VpuJklinaqDh6vPUoBebl93OXstdRUKAwPRJs9n7toKfrqB8vBEEx++KmYL9K8AUD3
	 CJ4C02eASkjfK2u+QY/sDRx0Nwhl6Ju9lYdp9M3kYAMWK7jyoJu0uwLbv4cpCxeCGH
	 tfDMsBGV6xJBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3139D654D;
	Mon, 12 May 2025 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] libbpf: Use proper errno value in nlattr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174709022775.1105327.1006699780573482608.git-patchwork-notify@kernel.org>
Date: Mon, 12 May 2025 22:50:27 +0000
References: <20250510182011.2246631-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250510182011.2246631-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 10 May 2025 18:20:11 +0000 you wrote:
> Return value of the validate_nla() function can be propagated all the
> way up to users of libbpf API. In case of error this libbpf version
> of validate_nla returns -1 which will be seen as -EPERM from user's
> point of view. Instead, return a more reasonable -EINVAL.
> 
> Fixes: bbf48c18ee0c ("libbpf: add error reporting in XDP")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] libbpf: Use proper errno value in nlattr
    https://git.kernel.org/bpf/bpf-next/c/fd5fd538a1f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



