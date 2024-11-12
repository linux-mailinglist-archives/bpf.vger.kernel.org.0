Return-Path: <bpf+bounces-44587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAAE9C4DA2
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851BD2852B6
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBAD20968B;
	Tue, 12 Nov 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srkb/lbJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8871DFE4;
	Tue, 12 Nov 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384623; cv=none; b=ujpi6H0EHjJZs4sZUO+3YfHSCw3jmhCOvt/1nSAk9c0/ZactLQ9QFplsPI0nrLVC43kFMD0lwPlZKKhUXU6nbrPf6NPeRVtQOaY3JdxoxIaPci/QfZ70gQdKQVX7huBI+1Z6d6a0M69hDFq6mzocnxJ4+1oG9AaIEknTiYj3mqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384623; c=relaxed/simple;
	bh=ORjdVRJx5Edgtw72uy8KH0QBzoyQUcyZ8uQHXf/Tb6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gn/lBkORFhOMpLdpuUZWu43nDcXG8PPvQtBT+6XGuG4YREGWo3DNto02zs7WzBGK1ruWseAWSrPeEz+SW2aKBzbnVrcteh+LVOPHtKOgGZ4kaTtSLnrldWhfwNEHsXeYVv7ajWm5gRmoGOsQ2uirJNMM1iSN5R7L7gBEGPtnux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srkb/lbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64097C4CECD;
	Tue, 12 Nov 2024 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731384622;
	bh=ORjdVRJx5Edgtw72uy8KH0QBzoyQUcyZ8uQHXf/Tb6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=srkb/lbJId5+qUe+0voCtUTD5yNmwqnEh9qo4DyjIzQIpVT7+DMsLaTCKiYwmRuCY
	 2KnHyKK0fSw+aegVJTzX1IG1kE3ml3icIwzg674rMexfxzEX0JqrRy9HeP1S9VMb+7
	 e2L9YrmuS8dF9lsPk13OrUi1rtmrrK+R9DWhU/U4zSSNHtyWs6z5SNmXwzU60eBqZi
	 fGxKAFTC1srUEUW1jJ5kr8Cs2q4goOcHR8kTOqrtUKDXoWPYNKN/TPYPViFAu7z2qk
	 2sDTpfpRlQRJ9fnwG3Pc7aiXNcaTP4sN0eJfKfoszHTnRQ1FEj7qgcEp7rl6VgvH5R
	 xzue902jDNk6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD073809A80;
	Tue, 12 Nov 2024 04:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] kbuild,bpf: pass make jobs' value to pahole
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138463254.76505.14037200729080697971.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 04:10:32 +0000
References: <20241102100452.793970-1-flo@geekplace.eu>
In-Reply-To: <20241102100452.793970-1-flo@geekplace.eu>
To: Florian Schmaus <flo@geekplace.eu>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  2 Nov 2024 11:04:51 +0100 you wrote:
> Pass the value of make's -j/--jobs argument to pahole, to avoid out of
> memory errors and make pahole respect the "jobs" value of make.
> 
> On systems with little memory but many cores, invoking pahole using -j
> without argument potentially creates too many pahole instances,
> causing an out-of-memory situation. Instead, we should pass make's
> "jobs" value as an argument to pahole's -j, which is likely configured
> to be (much) lower than the actual core count on such systems.
> 
> [...]

Here is the summary with links:
  - kbuild,bpf: pass make jobs' value to pahole
    https://git.kernel.org/bpf/bpf-next/c/09048d22b782

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



