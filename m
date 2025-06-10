Return-Path: <bpf+bounces-60191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D8AD3D06
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5629B1892CCE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176923AE9A;
	Tue, 10 Jun 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQlRMNbn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D090236A7C
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568802; cv=none; b=l5oOvwvicyp9SfzNnlfFJEp0ScBMdTBVORXfcI8x8MbatLyTGmArrRTcNBsiiVRaKI+g/4Kr25aVn83ZMSZ3w42fiaVOfsOa8zH6ZY0F4gNZ7IJOvwdnb+gmeU7k40BcPZij9+883PFIIhGtNMEous+nWUvYm0V7Cx+asOYsbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568802; c=relaxed/simple;
	bh=y0i3qGbmPSZ0dGjY1JygC3MWHeHby6Y0BAhY7yrhv8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hY4Jd18NY3GHVQmjo1GuF+4KFG0u+lpFcv7kRRydFOLXGFZUWG5GWROo+ZQPSrdfnJPJPZVLbV/z5E5M0Xnz6r5nzlInHptkloNpwDQyUQhIDcQ8twmrVUQsQehx0LuAlcs4Jdflv4jN4yv4NrT5jD23rdxXR7JrbTTdHnKxjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQlRMNbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE0C4CEED;
	Tue, 10 Jun 2025 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749568802;
	bh=y0i3qGbmPSZ0dGjY1JygC3MWHeHby6Y0BAhY7yrhv8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aQlRMNbnytAHMtj0JrvexExnk0tyolJtjs0kyUTt+QJrSktv/bdLJkmrf+mnhHG2P
	 CYhqW15ppugiM5rGcyYAh2TSP07UhrXCWNqKp9gPrbbR/I/1sU73VkR0C1kV+l8CDX
	 edJrKrk6K26eKA29QHNF/OLo7VYMWp7Vbu5VhMiH97GVKra/POTuUN4Fk77zQZl88W
	 aaEf+KcTwxZ9vUO0rcsWm14mIPtXfeSLFOc3ePH1JWJTr6DXXJjtqTUaDiQwfitlT7
	 8HbmZ3ALRDsPZlA5wcrxhiZWEjwEzFnkF+IThU0dRgYpDfAf/X651Ne/ezSUp6Cf1C
	 5uF5q4Jl2aWQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCF39D6540;
	Tue, 10 Jun 2025 15:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: adjust path to trace_output sample eBPF program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174956883251.2440707.8014695003719532026.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 15:20:32 +0000
References: <20250610140756.16332-1-tklauser@distanz.ch>
In-Reply-To: <20250610140756.16332-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Jun 2025 16:07:56 +0200 you wrote:
> The sample file was renamed from trace_output_kern.c to
> trace_output.bpf.c in commit d4fffba4d04b ("samples/bpf: Change _kern
> suffix to .bpf with syscall tracing program"). Adjust the path in the
> documentation comment for bpf_perf_event_output.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> [...]

Here is the summary with links:
  - bpf: adjust path to trace_output sample eBPF program
    https://git.kernel.org/bpf/bpf-next/c/2d72dd14d77f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



