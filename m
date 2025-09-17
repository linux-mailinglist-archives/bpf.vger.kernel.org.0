Return-Path: <bpf+bounces-68668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F2B8000E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2481C06F5E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C65286413;
	Wed, 17 Sep 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV8iHu5S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25B1A76BB
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118809; cv=none; b=UfMcej5GZGZ4ILPnrkSDIVdNZMf4jyZGn0Ow6Ej5rHEPMzk778vsaM3xDF2apRvnqYWtgrKRl7rSFXrazcsTlX4DFf/kHs0VJqFim+F7gD0KSYiQmQgiKAQK+Jv3x+Taokib1Xo5n395+0Mz+Mv6D4yKhlt6Qm3FOT4oom5X1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118809; c=relaxed/simple;
	bh=Fwq0T0StKMqVdWU159rNaBz+gk3e6XOOTlEBNXvwRVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QsfqP4ChhgAaasSHl8USFh+mRl5lWu5cDFHdmIgr4oKDVcnoM6ivy+EuhGgJelAw8tTcMWT1HFayVzRrrOjCSZxUM79ba9fpwpa85F+ys7UIfnGWwaoX8lyEpuv6LkdcNSZj6uHtr8OA2FjpmZrmwKubBrV3L1lZ634GaRBqVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV8iHu5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AFFC4CEF0;
	Wed, 17 Sep 2025 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758118808;
	bh=Fwq0T0StKMqVdWU159rNaBz+gk3e6XOOTlEBNXvwRVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GV8iHu5S4cvloKDqDXmPftt9ypj+cNxEMehPX3/n4VOZ2x1boEppqv3ntuK48mmUw
	 PVFFDEpXPC4XNbAXqmDO3oeuK4lYiXQ8GDw5+bzsd6hD11YQqy27NlDPAnmU5k+jmC
	 pX6Nb9oAO7+hJ3smjzupZthIiAbHLqRgWEwK1+twfAgXyZNP2DLTYMFCBRJBAtsdK0
	 BRPoWEMf1S5TVT67+pToz9B3I+vUJwpNKY5kUmPzY6DQ2UgXuJctZhGdvqT6PQnRpd
	 HB3tcDeBFQesHqiW4lXrRcZU1HymTouiEIejVhzlZEQbIYwWFlSHsrnnP9U9lzXKJe
	 hqCwtSsG955Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6839D0C1A;
	Wed, 17 Sep 2025 14:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Avoid warning on bpf_sock_addr padding
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175811880951.1646800.11597884061358663545.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 14:20:09 +0000
References: <cover.1758094761.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1758094761.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 Sep 2025 10:07:08 +0200 you wrote:
> This patchset fixes bpf_sock_addr padding access to avoid a kernel
> warning and improves our selftests coverage for these ctx padding cases.
> 
> Changes in v2:
>   - Rebased on top of bpf-next.
>   - Added selftests for paddings in bpf_sock and sk_reuseport_md.
>   - Simplified sock_addr_is_valid_access's logic, as suggested by Daniel.
>   - Removed a tab copied from existing code and spotted by Eduard.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Explicitly check accesses to bpf_sock_addr
    https://git.kernel.org/bpf/bpf-next/c/6fabca2fc94d
  - [bpf-next,v2,2/3] selftests/bpf: Move macros to bpf_misc.h
    https://git.kernel.org/bpf/bpf-next/c/7c60f6e488b7
  - [bpf-next,v2,3/3] selftest/bpf: Test accesses to ctx padding
    https://git.kernel.org/bpf/bpf-next/c/180a46bc1a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



