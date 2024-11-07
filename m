Return-Path: <bpf+bounces-44246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DC9C0A43
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E7D1C2231A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA12141A0;
	Thu,  7 Nov 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXqnWT70"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5E212D07;
	Thu,  7 Nov 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994021; cv=none; b=Q7BGY+n/mugdxfEh9A1R7MKqAXZlaPAs3kZ1GFJUeOeAt1SBE/yr+RJSKp5wQ7H3vcMavYOb5rbGj7Py1G90eTgCgcpm42HJQ+BC6KcJXyZGcc6tf98jD7EHKm/bWVKQmmtTIkPHUBj6yp9rXArIFwwxM4didOKeI4+P9MH1Zh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994021; c=relaxed/simple;
	bh=99mRawCrYiyprXONM9QgUaVEZFk1e6ntZv9bAFDjUBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OuzEbWt4P7dQIGsqn4rt7iN3OxMdJRmg+1BuO95VRtoc+vdxi2NiLFSUf5JAqq29NwLIT7WRDcG310cNBytOhzmg+maAVuFWMLvrbqNdPFXsyO3AzkkfX6PPZ/WsKkwhkPibt2GuCVicevfawuXYblHHomHrZM1PtxvbhWSw0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXqnWT70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A2FC4CECC;
	Thu,  7 Nov 2024 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730994020;
	bh=99mRawCrYiyprXONM9QgUaVEZFk1e6ntZv9bAFDjUBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXqnWT70L0uCsEMEDK0W4BHqJtQFvcQOJlDNjWU4nZ2yiaoHXoGT6jULrpZoLXDpZ
	 xQDxiRHnIv265cNFOrWyYVbUfRHoA7ubXSwOGT1dwby2BJZUnkpM8rowKrOfl6ywdj
	 PKJWjcRdcLN/XCOcss+aZvp6dO5GAhgUvuFzat3S0NHeViZsFGIht2fDaDpEi8IeGG
	 oUdTtS/jQ4vQSo1sbDsJbdSd41HCboKC3HGbyDM/mn37r2G6G9H7o9nN3wugYQc2F3
	 +VsupFAUlMbOBIFNIHS1bKRWGVuPxjFI8d90RNmB6HznQQNauTrwY9BcvsVGtmPc74
	 g8oL3FtWgeMMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BA63809A80;
	Thu,  7 Nov 2024 15:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] BPF verifier documentation cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173099403000.2004583.8555324576230265420.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 15:40:30 +0000
References: <20241107063708.106340-1-xandfury@gmail.com>
In-Reply-To: <20241107063708.106340-1-xandfury@gmail.com>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, corbet@lwn.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 Nov 2024 23:37:07 -0700 you wrote:
> Hi everyone,
> 
> I am interested in contributing to the BPF subsystem, starting with
> documentation cleanup. The patch removes trailing whitespace from the
> verifier documentation to maintain consistent formatting.
> 
> I have tested this patch with scripts/checkpatch.pl and it reports no
> issues.
> 
> [...]

Here is the summary with links:
  - [1/1] docs: bpf: verifier: remove trailing whitespace
    https://git.kernel.org/bpf/bpf-next/c/342f751e15c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



