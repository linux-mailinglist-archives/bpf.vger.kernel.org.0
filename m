Return-Path: <bpf+bounces-40289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F79856CB
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B78282FEE
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B27156C73;
	Wed, 25 Sep 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgB0ykHw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322581EB36;
	Wed, 25 Sep 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258428; cv=none; b=eUrTnaszHXtZVk+iwxe6k9x/1CGS5GlOEa+4LFRgxNdwGRAyXmbLGY3Hk40YhqS9PoG/+sv7rWyyfbVOsKIuyrf/RdkKSQhSwE45v+EWfO7XUmPGN2QDhuSGZkHoHqxipPW5MYdOfMwFyAEaKQlA43nKsyMzW5CoAzq9r7o640k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258428; c=relaxed/simple;
	bh=5asKXx8rvc/j8RHJ0ZLPPfaRDR6OCWKdjW8K3o628iw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nT2D6E5eEbcGQNq7nP/WSHVI94Gu7KHOAo+m9ppN9Lv3sbfeVISguy6q59UCmr9++jck+ahbkiqgViO58tgz92wW8VRy01iNGpEJI0EdP8smhrgyvgGxGXGG2AxQTpXz3QVx21eiGYL1giqZrmO7rOIa3iQn/wiHiLUg1ji7w+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgB0ykHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E46C4CEC3;
	Wed, 25 Sep 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727258427;
	bh=5asKXx8rvc/j8RHJ0ZLPPfaRDR6OCWKdjW8K3o628iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VgB0ykHwDGc9YIKdIlQb305W/sNlM3q3qYn1spD78g/VDpGprqo3afz5Ut8jX+IjQ
	 8+/SnyBatpsh9ptlwQ1h1x/p0qlbFQyG8rskGh9uAxUN6ObvzgikHx5LEfdUBuR0rq
	 ObUl/4nejbq3gvkiR3Nn+75IJsq5a84YMGgevVp84BbwdHLV5UmrPeWwo5U3QcJyU1
	 dNpPF4mRf7kurvYClbEQl/bes/QF3KCXb0uSapYBktVa3qovHgbmLwKFqYJbsc1Nnn
	 p5DWc7x2VUhchRt6oWnFVlSzbKg/hvpDpWLOBYcZOcbGoLgxB6x7fVsUkq8wClceFw
	 ai15PvIZkxvlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3414A3809A8F;
	Wed, 25 Sep 2024 10:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: use raw_spinlock_t in ringbuf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172725843003.522662.2025610414872346543.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 10:00:30 +0000
References: <20240920190700.617253-1-wander@redhat.com>
In-Reply-To: <20240920190700.617253-1-wander@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, wander.lairson@gmail.com, bgrech@redhat.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 20 Sep 2024 16:06:59 -0300 you wrote:
> From: Wander Lairson Costa <wander.lairson@gmail.com>
> 
> The function __bpf_ringbuf_reserve is invoked from a tracepoint, which
> disables preemption. Using spinlock_t in this context can lead to a
> "sleep in atomic" warning in the RT variant. This issue is illustrated
> in the example below:
> 
> [...]

Here is the summary with links:
  - bpf: use raw_spinlock_t in ringbuf
    https://git.kernel.org/bpf/bpf/c/8b62645b09f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



