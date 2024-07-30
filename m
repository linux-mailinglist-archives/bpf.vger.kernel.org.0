Return-Path: <bpf+bounces-36097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAEA9421DE
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F7F285B17
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5618E03E;
	Tue, 30 Jul 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX4//iqT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775018562A;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372633; cv=none; b=Bes5B4zGO6xUHFq/K8+0wHuHSVow4N0FyVbtXoMu1UoRxHmeX8Kt7Boo7E4kqqrgCoP/XZFsuOQv4JAwuRLKy7qtBcZDroUysajXcGp7ZdHzZ7oYVltYdxHv5TrtcWIX8hHkweJPi0mV2DbVUpw0Y0jZKrAnr0xUNfKmHA0Uqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372633; c=relaxed/simple;
	bh=b2IxN54gwI0ZZihIlpMveC0fYHrEctJnVgLs2cEaq2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OtLDK6HoIaly3qT4Hcc6bUZZCQVpoNPmlV0E/FZbmNAfH8GijRtq6eg9JFCnfLjXlSURM1KrjRepZT+KP5/uTzLlHXw6K2/KkDWwNHJ2P0lGdkNRt7Hm6CYvi5g9vlUt4qjIYarL66KvAydtt3tA8UiLhLSmJVLSUfv+Hi2ykJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX4//iqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB2E1C4AF0E;
	Tue, 30 Jul 2024 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722372633;
	bh=b2IxN54gwI0ZZihIlpMveC0fYHrEctJnVgLs2cEaq2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MX4//iqTNi+XloB0AZR/v1GPsYMDLyK2BD4RHGTwD3TCKqyTePIwnnvre9aTnKO/R
	 FiyiR5xUxrs5sd/I+WwEKeZoykVpsRqmsX58HFOKejcjK8zg7F0n81eWAwUkEm3P5N
	 V4UcAnvK1prjW5FD9ZidvXVYNwYK+oGmPD3t3dImh8vbTSmIqa0dPXtllKupazJKU3
	 9nRv/4bSU5TTfSjILJycfqIewRC4D3gYy59SiZ/j15eiO+DQEYgDqm3daBT/Vq3f1S
	 lp2dpjHDtzD7vybr+pEC5XayCmqqavvMf9bzQGk/+zFy3HA7FP6tGzcoTVTjsGinB0
	 BDgNHNyLdN2ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D762DC6E398;
	Tue, 30 Jul 2024 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: kprobe: remove unused declaring of
 bpf_kprobe_override
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172237263287.10299.9053781144488747339.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 20:50:32 +0000
References: <20240730053733.885785-1-dongml2@chinatelecom.cn>
In-Reply-To: <20240730053733.885785-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, dongml2@chinatelecom.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Jul 2024 13:37:33 +0800 you wrote:
> After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction
> pointer with original one"), "bpf_kprobe_override" is not used anywhere
> anymore, and we can remove it now.
> 
> Fixes: 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction pointer with original one")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: kprobe: remove unused declaring of bpf_kprobe_override
    https://git.kernel.org/bpf/bpf-next/c/1cbe8143fd2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



