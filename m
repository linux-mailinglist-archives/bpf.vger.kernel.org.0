Return-Path: <bpf+bounces-39758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94267976FE6
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 20:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C201286933
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889C1B654F;
	Thu, 12 Sep 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+vgT+ea"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213D13A40F;
	Thu, 12 Sep 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164032; cv=none; b=cy9Wak8Qcc0ERTyTWhyZmrZ7u9WISuHCUWp7VMBzO74x3LvcJjHfDrBfZNIRDlpuXnEbH/OFUwMtngY1cosDRVyb8h32VZJQYMSneHF0wVzmhUlF5RMaqjlk9IzU1cCrtyQZ0jFGGokr77pHNN8kHXEV/iSh+TsC6tEvI+R5Nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164032; c=relaxed/simple;
	bh=lHIgLp9xSacqtWncvQajTLlhCHVh6KlxEBcChsp91Ns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XjBydHCrQ5Hjs293UeuD0oNl6oJdXfNX1G/VXqZo2q11iXYwP8DO4+wEDWd0soMcxTQiz7ZCjiZmNR9bjn1VZqV1NTVtOoKNtcIz3LbDl4Pjfs3++FRt+SmicXgXjWWlqzxr7A4TU747sWYrQL+5bGmSHk89JC7BMVt/bb4dOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+vgT+ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01439C4CEC3;
	Thu, 12 Sep 2024 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164031;
	bh=lHIgLp9xSacqtWncvQajTLlhCHVh6KlxEBcChsp91Ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B+vgT+ea96mBLnDs4pFIGDWtIRoqf/x61OwZtsCs23UNjfBxlEidhQ5gbsiQk5nVg
	 eXaSmGKzQNP1lV4zI5Y0Wj26HiFvh8I5+0ivdqwytW3EZifhILuHMLnPk394/F9Oxw
	 L0iu+2LYfYeC/TZf7JG/JOieZ+CS7H8vAN0MMpu+r8zysRKbjy5hcyz6RcZ3xHQ3BP
	 hHE3vN3Wi0Zf/mq6RzyUzE8WFwQT0MsUTm2tbqK+tQC6VjX75EQo/VuQGVoWSdRxs3
	 r1ieos23Cp0SF9zYST+C2M8/SI4+joud5CbXUKzJBQOB8nE2Xs5ZyoaBvEWDuCxRxa
	 0PegoeBH2Homw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8E3822D1B;
	Thu, 12 Sep 2024 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add missing BPF program types to docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172616403210.1673633.17653510692606656259.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 18:00:32 +0000
References: <20240912095944.6386-1-donald.hunter@gmail.com>
In-Reply-To: <20240912095944.6386-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 12 Sep 2024 10:59:44 +0100 you wrote:
> Update the table of program types in the libbpf documentation with the
> recently added program types.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/libbpf/program_types.rst | 30 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next,v2] docs/bpf: Add missing BPF program types to docs
    https://git.kernel.org/bpf/bpf-next/c/6182e0b80f9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



