Return-Path: <bpf+bounces-78008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85BCFAD5B
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B66630390CE
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893F2C11C9;
	Tue,  6 Jan 2026 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxYxmcWD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432B2135D7;
	Tue,  6 Jan 2026 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729212; cv=none; b=mffaO/msNHbHOKY3W9OLNp4FqjLgfgiMz6B0w/rBmwQ4nDRdFjK6fAaFkVrNMzUEPqoOb1jH6Vg8/03DTyUWpKIEwRBVv7YMPJb6yISrGYV93ocAVS/qmzzJxNT5Thvw9Ktg914wAXPxCzzuMcL8qmxl0oapweAa60XraXaRt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729212; c=relaxed/simple;
	bh=EB5RagK69EMro02hnOlcswWF5eVi8MSQE7EmS1HRUIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TuerIPMJLgsUMDcub7g8Tws10W11aWKvKQ0OXtULYLQVJIdHIbPasWYnvmsnqJtWd3Y+T2xqiatnUF4jQkroPZchPcJ5cdFs8zqksHdIGkcX45H7i5qg4IuJrC1ojxSVLD04799AcXdVHjIP6G/PuFjhb3fc7ucb/2bc5KBBSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxYxmcWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33BEC116C6;
	Tue,  6 Jan 2026 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767729211;
	bh=EB5RagK69EMro02hnOlcswWF5eVi8MSQE7EmS1HRUIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NxYxmcWDrAI5b84WziSDMyz22XoDhd1dHBx4nbLXC4hIgFJclHK9qgsEhZZVIZS4X
	 uzOzMyOioiv5Gw7Ji1ZIw3NKFBcrZ4udu4/RTEi/lsmqmZzHS8qNFTikLA2RthTMj0
	 ec2QsKDLtGKid4RExgiTIfbJ30D9AYDWH03HV8P0+wojjwfieqvLtnYcUEu5NcANLR
	 9Dx6JKrF0qSn2qc4gpRpgJPlrreUJL2v4i5wqbhYfnIwwxv87RmUS50PLIk2ozOeW3
	 eOGKvV/POgpJYLp5Je08OsGHGCQv7kkGos9dishV9HSd7JBMF6iM2pUvEgwZjvH6CQ
	 kNDhA9X4bO4kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8214B380CEED;
	Tue,  6 Jan 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf,
 test_run: Subtract size of xdp_frame from allowed metadata size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176772900932.2120849.10780715204750127993.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 19:50:09 +0000
References: <20260105114747.1358750-1-toke@redhat.com>
In-Reply-To: <20260105114747.1358750-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, dddddd@hust.edu.cn, M202472210@hust.edu.cn,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Jan 2026 12:47:45 +0100 you wrote:
> The xdp_frame structure takes up part of the XDP frame headroom,
> limiting the size of the metadata. However, in bpf_test_run, we don't
> take this into account, which makes it possible for userspace to supply
> a metadata size that is too large (taking up the entire headroom).
> 
> If userspace supplies such a large metadata size in live packet mode,
> the xdp_update_frame_from_buff() call in xdp_test_run_init_page() call
> will fail, after which packet transmission proceeds with an
> uninitialised frame structure, leading to the usual Bad Stuff.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf, test_run: Subtract size of xdp_frame from allowed metadata size
    https://git.kernel.org/bpf/bpf/c/e558cca21779
  - [bpf,2/2] selftests/bpf: Update xdp_context_test_run test to check maximum metadata size
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



