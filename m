Return-Path: <bpf+bounces-68900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1264B87B7D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1FB7C4B9B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD725A355;
	Fri, 19 Sep 2025 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVc36Ubp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC51E5B7B;
	Fri, 19 Sep 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248416; cv=none; b=kVBXg9zpha9ZlSiuihR/W/sSJBK7WdcKMLUUpWKNkhSHuHJzp6wZtKVu6vtr25XhVd98OqNQWKoNexwsZunYivz8/97q/wbO3X+2mBPMcVclVe14ARoFZDYFWaqkt4RJ82rqPf8DFPTM1IE8Fl2D6okLQjJzZo8kPQZ/f1uflHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248416; c=relaxed/simple;
	bh=2uObbcWUmo8NjRMQzjwBSKL6PklNbLsVTmd+zWVv0EE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iHKii/is0ixqkE8Y8ry1qJ6xZrIn+dqUVetMJV0P/Qi/hRL/jyHVVhH2EgwEvjVTKAvVSh4tWKeTPHmZRDKnYDs2SV744DCpa9xvftFdG5/5jcVhrJGLLurpzbl9x9r8GpUymFixKJFQgRzQ02bVF7xv65RFr5giLoaAUkg8Tfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVc36Ubp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32886C4CEE7;
	Fri, 19 Sep 2025 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758248413;
	bh=2uObbcWUmo8NjRMQzjwBSKL6PklNbLsVTmd+zWVv0EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aVc36UbpxQtLdFTEJOAhZVc1HbJMJpsuHiG+K07gnPzJ0+BlepJvJSaf1cbOOFEPl
	 9FbGizWXG+HIBdlxl5h5x4xNwyrawPuf7/yoZSR+2j2aYDnnfLZXLrDz8SzzprPded
	 ty+utITYPSYtzxk3ctO59KxrD043m8BcBLgcJH6f0Gt+Tiiz+xTbZ7cavh2XVYa3X3
	 Ebx31p1aBJCWiJzsgDgi0R+bwl+IbNDa7DUVhBxJWYOOFN2xUww2zZr61N+I7X9nx9
	 wJl93STEGc2XA6kRbDg07Z5drQiHQ9r75BnRM77sisEJDMrt0bm5PiLHH26GQiBec0
	 eREgvVLb12Y7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9F39D0C20;
	Fri, 19 Sep 2025 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/12] Signed BPF programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175824841300.3021819.875187543538843071.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 02:20:13 +0000
References: <20250914215141.15144-1-kpsingh@kernel.org>
In-Reply-To: <20250914215141.15144-1-kpsingh@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 14 Sep 2025 23:51:29 +0200 you wrote:
> # v3 -> v4
> 
> * Dropped the use of session keyring by default from skeletons.
> * Andrii's feedback on exclusive map creation libbpf changes.
> * Cleaned up some more typos I found.
> 
> # v2 -> v3
> 
> [...]

Here is the summary with links:
  - [v4,01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
    (no matching commit)
  - [v4,02/12] bpf: Implement exclusive map creation
    https://git.kernel.org/bpf/bpf-next/c/baefdbdf6812
  - [v4,03/12] libbpf: Implement SHA256 internal helper
    https://git.kernel.org/bpf/bpf-next/c/c297fe3e9f99
  - [v4,04/12] libbpf: Support exclusive map creation
    https://git.kernel.org/bpf/bpf-next/c/567010a5478f
  - [v4,05/12] selftests/bpf: Add tests for exclusive maps
    https://git.kernel.org/bpf/bpf-next/c/6c850cbca82c
  - [v4,06/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
    https://git.kernel.org/bpf/bpf-next/c/ea2e6467ac36
  - [v4,07/12] bpf: Move the signature kfuncs to helpers.c
    https://git.kernel.org/bpf/bpf-next/c/8cd189e414bb
  - [v4,08/12] bpf: Implement signature verification for BPF programs
    (no matching commit)
  - [v4,09/12] libbpf: Update light skeleton for signing
    (no matching commit)
  - [v4,10/12] libbpf: Embed and verify the metadata hash in the loader
    (no matching commit)
  - [v4,11/12] bpftool: Add support for signing BPF programs
    (no matching commit)
  - [v4,12/12] selftests/bpf: Enable signature verification for some lskel tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



