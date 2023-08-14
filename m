Return-Path: <bpf+bounces-7729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2B77BD40
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101C21C20AB4
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27EC2E6;
	Mon, 14 Aug 2023 15:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2BCC2C9
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B55DAC433C9;
	Mon, 14 Aug 2023 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692027622;
	bh=ZcpaAaxDe3cmRcmv6pGpMvd8CXdSK7v14b5uK5h9YPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tcGxkhoCrwZIXex7392BcakR2/vPR7strzyMR5bbvvnadoSh3cCrEwEli6AWIBlW5
	 gIqUX4utOpzXv+8YHbMiFLQSNMC1RtGjOlPDlq1Lp53gcwbikj1skFe3S73cASk/MZ
	 Hs1rNOarX1FJ9AJukGf7h0A+gryWUA8lxTm4cu0k9Ik0Q3pbHlwj2WPGCPOUdH+r1/
	 YEOkjrHQhSb8Rw4EMBN+a1UqTsB3z5OvtyRJBQSc74k4nDrWFyup2AmwXFtPUSeOuQ
	 Zg1DtxlAtN+sKdvv1NK94KW2MX7auoF7HHYfwsE/FMhZCtXhdt30LXQ6UvlMuT22T5
	 8IaDVtdcdpraw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 972D5E93B32;
	Mon, 14 Aug 2023 15:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: set close-on-exec flag on gzopen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169202762261.28565.7854580464689609130.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 15:40:22 +0000
References: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 marco.vedovati@crowdstrike.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 10 Aug 2023 14:43:53 -0700 you wrote:
> From: Marco Vedovati <marco.vedovati@crowdstrike.com>
> 
> Enable the close-on-exec flag when using gzopen
> 
> This is especially important for multithreaded programs making use of
> libbpf, where a fork + exec could race with libbpf library calls,
> potentially resulting in a file descriptor leaked to the new process.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: set close-on-exec flag on gzopen
    https://git.kernel.org/bpf/bpf-next/c/8e50750f122e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



