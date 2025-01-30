Return-Path: <bpf+bounces-50088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B0A2275C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594D718842DD
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FD29408;
	Thu, 30 Jan 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJojCvhA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D1A182BC
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198804; cv=none; b=kXNKDjn+Upj9v/Mt0aVUcE1YD0weSeag0+OfOHxwHcKvzrQqsjuRRSVl5LNtNovpEN9DGkEx/lajxhEwQeqoL6pr66X16IcG79vsLQ2kcLAd8sDmTJpHPDRueTmlNk+oOFWCAuT/KdsOr3XyN4/bEBLFO5n+/61tflaPjOGQGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198804; c=relaxed/simple;
	bh=ntVmwtYEomJpmEjRSNfYT0vE6Kz4HBsMX8UU9OS8wtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qnnIInV6ILi5eLaWojjpJNtrBkNS4oYBCW9xF9WAJgmwEcvkI/FXEmPue3em6Cl0h12j9EItt+R++pfzxHoX5BHLBS6RCKAqQqmdXQy3Bf7fcckk+vnb3L0N8i3DojYO4LkcrIAV8gvvySirCXHdRRYx/AsiJRGgMNLZAMI9U/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJojCvhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA856C4CED1;
	Thu, 30 Jan 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738198803;
	bh=ntVmwtYEomJpmEjRSNfYT0vE6Kz4HBsMX8UU9OS8wtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bJojCvhAO+Eg4zk0vuVyNzqObPJvxg8s4vsHqJM9XDK0t4gNiSGPdm+/lyZWsJhKI
	 +O6TtHyj9e85Rte6ul9B8GrHwIa1cqPSEHa2aOT6SPcPGR18vtEAUcZ9ezeX38ieYE
	 Lx2iylGkaQPeN/kRm+NMg4lHHFZwJlPaoDGS/m71QLRYA/35YTAPN1fgiMFRIMndEU
	 M75CBu8En4kpoRF3Im/L/2+whJ88muP/UUeSrqTRo3157d51mAebGLmzvc9Iif+N0X
	 RRty7yODuw6m86MNoZB3hQGzhTklAcDJ4I/1dPqZKbaw87v34ANtCiGy1nmi4dcnS/
	 HOD2vRQ4ZlRbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3412E380AA66;
	Thu, 30 Jan 2025 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix readlink usage in get_fd_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173819883004.478532.17449273096411979099.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 01:00:30 +0000
References: <20250129071857.75182-1-vmalik@redhat.com>
In-Reply-To: <20250129071857.75182-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 29 Jan 2025 08:18:57 +0100 you wrote:
> The `readlink(path, buf, sizeof(buf))` call reads at most sizeof(buf)
> bytes and *does not* append null-terminator to buf. With respect to
> that, fix two pieces in get_fd_type:
> 
> 1. Change the truncation check to contain sizeof(buf) rather than
>    sizeof(path).
> 2. Append null-terminator to buf.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Fix readlink usage in get_fd_type
    https://git.kernel.org/bpf/bpf-next/c/57e71f8c8923

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



