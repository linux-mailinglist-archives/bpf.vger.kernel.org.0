Return-Path: <bpf+bounces-67197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65182B40935
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA30C3B451A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1C324B15;
	Tue,  2 Sep 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7fVG5bz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE422147E6;
	Tue,  2 Sep 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827601; cv=none; b=Uk9oThDZZCdY65lh86MGbuXpmzzaGD9dy7SXA3swc3XsLz3JxiwWdlprPqTSBYZTzr7BNXp4l0BLbUgtIm0DRpkpFIIcQ39ITsN4PMhrtbDpFDX6HQgWDuVeotxJZrrXK1yrQPDI5L5WLRI7xSk5nISN6Mi89hQoOWY6SOAZKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827601; c=relaxed/simple;
	bh=AutO9D2OcTW50yepZSiaYG2a1oobSdECEk1qj5ePuxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QaYzGt3W/Fs7dEl57K9+Z38wmaTHQlFvlVHqalyW6qQpSJ4+w+U4K1gSpM87c2LTekqQMWztjMpjhyC+1W1KcNBTTINDZp/2hM2fZrtT1uVC3m2RfN0IkNIAzWBLJTTMpXYJRaRRZaK+SjPH5cwsUXW2n9Dm0zCdDAgje7I5YL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7fVG5bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ED8C4CEED;
	Tue,  2 Sep 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756827601;
	bh=AutO9D2OcTW50yepZSiaYG2a1oobSdECEk1qj5ePuxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E7fVG5bzSasr52PCP4Y+oZCf3BwNi/R4YbzYkZ1crlPezw9t/nJSywAnrX0/fLo9a
	 Xxt7csR+KTS8ktCJyVk6m5p8Q2AmZSErElaXKtqdvWt/GzVtqRrtBqFGJ/vaouXRIp
	 ux/j8M3AoQpDmIUGxbyEcNXCNIWKsvcs+dpTstlMH7kZxY6dLfPULdQTcE3b7nCriq
	 ID4WQvd3gJl3uARVwl6KsHWwzg3aVVs2pKz0J4z1uZNFibwP9M6nX24EX5i3mJEJsv
	 4jFKANfi0nga8jVHH3JaqoQtFpOptL3bgAZMdDVJvh+nFy3einqYpcXiYVNNxSVfCb
	 a4NFdGlDyTtcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF92383BF75;
	Tue,  2 Sep 2025 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Replace kvfree with kfree for kzalloc
 memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175682760676.346736.3640548991734500427.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 15:40:06 +0000
References: <20250827032812.498216-1-yangfeng59949@163.com>
In-Reply-To: <20250827032812.498216-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 27 Aug 2025 11:28:12 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> These pointers are allocated by kzalloc.
> Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
> check in kvfree().
> 
> This is the remaining unmodified part from [1].
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Replace kvfree with kfree for kzalloc memory
    https://git.kernel.org/bpf/bpf-next/c/e4980fa64636

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



