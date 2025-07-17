Return-Path: <bpf+bounces-63654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16476B09419
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED46A3A3E68
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A520C469;
	Thu, 17 Jul 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAEc3aHP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDC20ED;
	Thu, 17 Jul 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777586; cv=none; b=D86dlSnQ/ReFBoGdCE3Eh57nB636jPwpXrqSEzmwuWok0mkerIEvCgSs1PXJATMHrvMWODXxO5rS3xKEcmCKR8BdRDwBbfp+UfT3mcfhnGbXl3Dn6T74dCO7VpsDqF4QnoRmvmZQMjOjkVE8+lmwhhMOkYvgNSindUb4GN8w7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777586; c=relaxed/simple;
	bh=yIDpDwqOdxcWlcbJAwGAaOuYScJmwet0ohhW+G52cGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PPzAo2wYz9MYN4VG6t84OxkTfef06/pBkRraPFLBED0TgVPculgitPlSLC5aKpgAtr0JPW4x8bsV9viFJygwR3bIPKkEjvQD7alb5YbcVEYcGVZpEj/kDqMtkk2gZ/I8NmICWRskPL0G6oCuh8SpEI1PhfgPRMCQm5AkDlwF+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAEc3aHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E27AC4CEE3;
	Thu, 17 Jul 2025 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752777586;
	bh=yIDpDwqOdxcWlcbJAwGAaOuYScJmwet0ohhW+G52cGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vAEc3aHPG2vuslvGAPUQycKmTWThErGerRnmfVBtbH+y6UBSyVbkHbzAA3pbLKSQc
	 yJIDpmH9I/mpjW7STqxACxl6lSFXVntPq8GMP3JUspSIdzvE05b2SPCQf+gc9kgU73
	 v8l3hhTxHGnVddGJG5gbQ4er7Vv4NqMSSyVKKnUKQqj4Y6JRzayGxn/CCC0elN+7xX
	 V7mgG6AapGxm092VTzaAA8AfJ8i/Zralw5uPqcWdvgAOPzDRiSrKDmrM03Ma1smK3J
	 B5qFeKvF39ZMVJjkW5HFYx7wuJm+lQAJMnlXzZIrc36dd0UQlasLshkw2OIZm902t0
	 t/GirpIj95yOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C19383BAC1;
	Thu, 17 Jul 2025 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next,v5 1/1] doc: xdp: clarify driver implementation
 for
 XDP Rx metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175277760626.2036066.11510521662975521609.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 18:40:06 +0000
References: <20250716154846.3513575-1-yoong.siang.song@intel.com>
In-Reply-To: <20250716154846.3513575-1-yoong.siang.song@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 16 Jul 2025 23:48:46 +0800 you wrote:
> Clarify that drivers must remove device-reserved metadata from the
> data_meta area before passing frames to XDP programs.
> 
> Additionally, expand the explanation of how userspace and BPF programs
> should coordinate the use of METADATA_SIZE, and add a detailed diagram
> to illustrate pointer adjustments and metadata layout.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/1] doc: xdp: clarify driver implementation for XDP Rx metadata
    https://git.kernel.org/bpf/bpf-next/c/ef57dc6f52e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



