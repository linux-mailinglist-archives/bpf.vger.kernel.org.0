Return-Path: <bpf+bounces-44593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9F9C4E6A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 06:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DDFB21633
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3620100C;
	Tue, 12 Nov 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnMrFmJw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650244502F
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390620; cv=none; b=eqq01FPttmXjXNlkuwMeApYkh0LaBVhVnEwEVmLHFfTfAMLtsRwxhm0FZ4rl+kuTyQ4w/8N4pAjI9EZkx+tDS5IAnQVb0FsWAzm/fC3yvJ26nw8GCK0YSIXbOYMtDIRfv4Ri2h2VnzLsygHyqJBwxbd4yx7oFrI4OP/c7+tDhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390620; c=relaxed/simple;
	bh=s9qlv141yYv8ZzJNesSbY4VGUQcrRNrwKY+GYuSSLLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fr78WSZDsT324wpc0F45ASOoeYbh23NIpbWJjGE9buwfWZBysS/cNk4iSb+gS3sJS1tueV+CZY4tR06oG34EWM/SRfOPeMi/yNsZobiTcaqnik47nW3zrw9dQZ93S3X4Xgs6WdkoMCmIvst/rFpGcWQv/4Fl0UrZoJhIwbpPYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnMrFmJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7914C4CECD;
	Tue, 12 Nov 2024 05:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731390619;
	bh=s9qlv141yYv8ZzJNesSbY4VGUQcrRNrwKY+GYuSSLLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZnMrFmJwEN9KiB1I8ZmVnhfr7GfIH+hK6rW3VZrE20lov7ydGoDi9NyyNdgac6QT6
	 qIARlLgLZ0n2RfrfTYblU2UsWP0Dp2peIi7ve2eLy6iTWED9nylLz+AQbUZwVlAt+B
	 mk9F5ljt+KlApr9lnftLbXZLFB1rRyLCQDd/Wmv1Ily7EJG5sTaVN330bFCvSLLWvb
	 /ZvJH/yKVv7DiiRkO73fQSQbHikoqvAeApQRtyQTePqYLn3wi8HGOlruiswiI65wua
	 8LGBo+6s0kU5+o/EfedjT0PdycAdNBxL7lO0tfK4Rj8mqfMUNXCt7KzONKQab2VZD+
	 AJXuPImoz9SIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D503809A80;
	Tue, 12 Nov 2024 05:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: use common instruction history across all
 states
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173139063001.99001.4097081801335291237.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 05:50:30 +0000
References: <20241112035530.1219098-1-andrii@kernel.org>
In-Reply-To: <20241112035530.1219098-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Nov 2024 19:55:29 -0800 you wrote:
> Instead of allocating and copying instruction history each time we
> enqueue child verifier state, switch to a model where we use one common
> dynamically sized array of instruction history entries across all states.
> 
> The key observation for proving this is correct is that instruction
> history is only relevant while state is active, which means it either is
> a current state (and thus we are actively modifying instruction history
> and no other state can interfere with us) or we are checkpointed state
> with some children still active (either enqueued or being current).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: use common instruction history across all states
    https://git.kernel.org/bpf/bpf-next/c/042d95c6b30e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



