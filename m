Return-Path: <bpf+bounces-28206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E38B6629
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BC31F21D22
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631BE194C7E;
	Mon, 29 Apr 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKhZPrqZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610E128829;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432830; cv=none; b=ndPzMszNBqQzPQq3zeiJTTK0fwn4u2/okfcLJcpzyUkkHtC3oQv4sbv/XW+aivYKoutgi01K+VV8SJIzRUi++DeEi1pRXjuN7p1ZKoKySdn2dAz60XO+e4OIHK7WOA88UVvj49aiqmyM1KwEJHIh/l3xeaTp3aabfLfi/L67D6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432830; c=relaxed/simple;
	bh=wPKV6b8uo1C9ip5ROmL0/fDgzxD03Kr9ZPPKehVd3DM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXMW3HFOJlI7uBQYeBePo2atVcDrpM1KNzG6Jttvh3fjbrzAW9AJ7oslWdrChaJcUpw/DK287wqh77GXLQqyJmtyApfoa8gCvVPm8ohDfTzayR8fMHzWBSCwW7EJGqDfzBNwNb92DYqYaZmh9MdQE1nk8AwiYMV87aPbyKDlaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKhZPrqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A992C116B1;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714432830;
	bh=wPKV6b8uo1C9ip5ROmL0/fDgzxD03Kr9ZPPKehVd3DM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oKhZPrqZs6lYcVJ7RCh76CIoFHqfZQ6p06kBvWzG2S1IFuQrfzyH2cOQiaem1U+5m
	 HpUd9/mw+AY4UILOOc0lCHOhFEIeJSCCNwFWzBVR1NADjWGOOY9SIevS0PYiBucOpT
	 Zn6+hFgFPQSPSoJzRWGp2gbB8OGqv+wu9DWv9L3IWkZ55zg00lsatRSME1+XtDKxwg
	 kk87xseMJbzNi41H4G8CFD9fGTZohyiJcSXYu/h2tdx/hqKHwR3R0m566umUb/oc0u
	 ouZHjTDYwbyR7MBAPA1XBb2OWa2XmrgRpkMcouz5m1tcH6Cy9mfUbeAOVkOBfIlOzH
	 Br+tVeRRCuEeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56174E2D48A;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] bpf: Use struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443283034.1398.3239863646102577712.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 23:20:30 +0000
References: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Apr 2024 15:13:22 +0300 you wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/bpf/core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [v1,1/1] bpf: Use struct_size()
    https://git.kernel.org/bpf/bpf-next/c/cb01621b6d91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



