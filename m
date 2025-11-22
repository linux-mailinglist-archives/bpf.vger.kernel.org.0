Return-Path: <bpf+bounces-75275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64278C7C0BE
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AF804EC28C
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10723AE62;
	Sat, 22 Nov 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/hSuN36"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3900201004
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772825; cv=none; b=OLALlWOqCjwU6QlPspJ4s4P23M+rAl8TkH5cTybEUXG9ZV+F2VPDUWSVrjf2q9jE6nzOVpUAGW+wG54QHq4+bTkkvdI8B1mas8RcCXD+ZxtKD6PfvC5YUWbtJTjSws3OqWvRbJa28EJO+WXHukK2igIBHbG2dsoBFr0YXSMAZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772825; c=relaxed/simple;
	bh=myfrW/C2amyh5q1xJ7hwnrmPeF4GLbJZfIJ0irsrU+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=owP0nm8IcPrPOSb//uaVqxdX+x79GdA/5Zr4djmKBguOnwLzibILrQLZZdcjInZBBYabd5CMh5G4ph1x7n50zp2LoFEIUZamtmd59P5qRWUbyYbP9CVBTl1GP4+matWJNu6SPjg1coQTePDdpC9Ux6smuS+Owu56E2VUqejyFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/hSuN36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CE3C4CEF1;
	Sat, 22 Nov 2025 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763772824;
	bh=myfrW/C2amyh5q1xJ7hwnrmPeF4GLbJZfIJ0irsrU+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/hSuN36l9ge5E+tBQSJp0GOzld5Gwgmm4gWwlKqcxEb5xstRYggq8Vrg3Gg4ZlqU
	 MN1jr3smvtN/UpEbUz7WbSQ0lkBfKoZOgMqdpSlg6LrQ2KgIIptx8AJ8TuHhvekuVU
	 ums6zoazziJ11LWet39QsdE/vbo2yoLcpHR0yBlLQr2TS3XDk2JyFIvkAhTeXoAjVc
	 8WVQhYzr/4JVFXUSUmRz+ANufx4BSXU4+ZLSVId6rH//ZoJL7ZTytviKJaR60z1Pae
	 TwsPR22AYa/rIo6Gg9gKgrwB+eFoMcThh6MvoMFwSN+A0TkFa5mESnm0pVg4weviNM
	 Y4j0l8Ey3ejLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F333A78AC8;
	Sat, 22 Nov 2025 00:53:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: skip test_perf_branches_hw() on
 unsupported platforms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377278875.2637800.15877237921356148904.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 00:53:08 +0000
References: <20251120142059.2836181-1-mattbobrowski@google.com>
In-Reply-To: <20251120142059.2836181-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dxu@dxuuu.xyz

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 20 Nov 2025 14:20:59 +0000 you wrote:
> Gracefully skip the test_perf_branches_hw subtest on platforms that
> do not support LBR or require specialized perf event attributes
> to enable branch sampling.
> 
> For example, AMD's Milan (Zen 3) supports BRS rather than traditional
> LBR. This requires specific configurations (attr.type = PERF_TYPE_RAW,
> attr.config = RETIRED_TAKEN_BRANCH_INSTRUCTIONS) that differ from the
> generic setup used within this test. Notably, it also probably doesn't
> hold much value to special case perf event configurations for selected
> micro architectures.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: skip test_perf_branches_hw() on unsupported platforms
    https://git.kernel.org/bpf/bpf-next/c/27746aaf1b20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



