Return-Path: <bpf+bounces-55668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D1A84AD4
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344361892252
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ADB1F09A5;
	Thu, 10 Apr 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o27CXlmQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF81EF397;
	Thu, 10 Apr 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305595; cv=none; b=KOh6/68I9NjbpuWtvzIKOdaMeGZVY/oKxLJ7uI71BnaM1bH+mhCX+DQsyBmvFWx1jh+zzZSAV9P/eWAMctsPdlvcNPEL2GHFJD5B0aOjj1YEfqljfXNWEtSoNuxFwZyjbpp6EnO0y/QK0oqpALtxq3RZLcxVIeQtKdomo0E/7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305595; c=relaxed/simple;
	bh=cfwqnIa+foWB7evC9M5I96CQ2AsMfuh+qMujbdOmI70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UNFtbE6D7mkMkNMPP/XX4sChBMQS2UOuwG5TZJ0KUfqashok3CpgwB0qaeCmV6VPqRG2QjCqKPOOaDh49FLhIs5BOSAKi/YxJZSYmA/jm3jQeq1okMkjo5N9VY90TV2x2rz0WTuQENLsxpAZbD/MMKyMkh3VBKFWLMZeRcWv8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o27CXlmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A26AC4CEE9;
	Thu, 10 Apr 2025 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744305595;
	bh=cfwqnIa+foWB7evC9M5I96CQ2AsMfuh+qMujbdOmI70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o27CXlmQUae4Oq+g3UFfx9PMQJKuyfTJkHZkkvj7+2lK06JkvOHaHvgaAsK1AEqWg
	 dFgl9q1u6m6SJSgBX5SbMdbrEJJj4cSWhLae91qJfLUixIdCsusTY5Q3lOokc5Mus0
	 vFVmwVKRcfwxOBZP5UMbVkQLXMXrqNR9PAHGlShkm9Y8HLkrZbo+xJZfZmDYV2klFK
	 ZW1f3j+4xxtNffaCMAzh2dvZJPU0CekYiY0o5iaJMWOg5dnANKdexvepM85eMZmnco
	 7Z+FKXk9yEdoR/wxwKCQjKxNT/5+Vcxqng15IZ53lxqrohk7KxasjmTY5GZqEPr0Qs
	 bdFAFGhzOFexw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5B380CEF4;
	Thu, 10 Apr 2025 17:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail
 adjustment in AF_XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174430563276.3761227.17315253449500219027.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 17:20:32 +0000
References: <20250410033116.173617-1-tushar.vyavahare@intel.com>
In-Reply-To: <20250410033116.173617-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 10 Apr 2025 03:31:14 +0000 you wrote:
> This patch series adds tests to validate the XDP tail adjustment
> functionality, focusing on its use within the AF_XDP context. The tests
> verify dynamic packet size manipulation using the bpf_xdp_adjust_tail()
> helper function, covering both single and multi-buffer scenarios.
> 
> v1 -> v2:
> 1. Retain and extend stream replacement: Keep `pkt_stream_replace`
>    unchanged. Add `pkt_stream_replace_ifobject` for targeted ifobject
>    handling.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] selftests/xsk: Add packet stream replacement function
    https://git.kernel.org/bpf/bpf-next/c/3e730fe2af86
  - [bpf-next,v4,2/2] selftests/xsk: Add tail adjustment tests and support check
    https://git.kernel.org/bpf/bpf-next/c/4b302092553c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



