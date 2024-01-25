Return-Path: <bpf+bounces-20316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924A83BF4E
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 11:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DE4B2BB62
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519A1CD10;
	Thu, 25 Jan 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INkGzzbi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFA1CABB;
	Thu, 25 Jan 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179227; cv=none; b=FCKY7LTOamuTA4R3B3vniw3CLtHIHtlg45oHYAwWeW40KxImr8e8XJ2M5isJWkKgWw7qlLv4bL/m9m7N1JxVg2I5CMPf5HWt3+zkyHazF2GvQnIMe+sBczdiNasJYC+4EiQMYVWqPSGQU5bm9foWOPrMz3BP4GhSPjb3PwK/V1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179227; c=relaxed/simple;
	bh=JHUpbjAIia2XZLik4qZz59jRgpO/BXw8EXe1AuspsTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hUxMBlom4D7LV8KXkKFeE/RpeFP+6Ds78kTLjAvw10AdX+FXOaIWgGhSkfdA6uAkFgWA7W8JIqJjfhdpYWGKiCeXmsM7CxMhN2rfG/r4fP2m7e6atKsR9njtXcEWuv0WCL3AfYpSFlhVnNsGfXyWNMxMx/fMYhGsR0B7HZB6Yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INkGzzbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A057C43390;
	Thu, 25 Jan 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179227;
	bh=JHUpbjAIia2XZLik4qZz59jRgpO/BXw8EXe1AuspsTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=INkGzzbiue8L3zHsRStIYKw37mi+foVfPjeZ3D4b0A0mNuXLbizW2lod9kR4yHvvw
	 JKuvWCuNNOo8i3euNt+LWF09Ttj1r+SRs5TKiPp6gM1+QSnKEXEELkYX3DFvZtQxfm
	 YSeybvH8VfeHE6ONu83fvK7dQhwVY7SOK0KDa3r3T7iY1VJ6G/GVCnI3ZMUR8AW4LY
	 bbK6BQuVtfQTKsYVVkAC3+8OEk2b+grexEe+N9blRKiQL8s+V/oSDRBuapu7bhgRDw
	 LlvVO052wBG4T785mz/Omen36DQ8QAvvAKE/pTSCzhfaa5O8Q6Aw4HxCv2wPL3MG8K
	 14zxRYFzJmoxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 535DBD8C962;
	Thu, 25 Jan 2024 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-01-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170617922733.24282.8506587930561215773.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 10:40:27 +0000
References: <20240125084416.10876-1-daniel@iogearbox.net>
In-Reply-To: <20240125084416.10876-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 25 Jan 2024 09:44:16 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 12 non-merge commits during the last 2 day(s) which contain
> a total of 13 files changed, 190 insertions(+), 91 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-01-25
    https://git.kernel.org/netdev/net/c/fdf8e6d18c6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



