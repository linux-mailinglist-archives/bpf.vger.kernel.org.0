Return-Path: <bpf+bounces-34487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1484F92DCA5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CB21C21266
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16814D428;
	Wed, 10 Jul 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V//+u7tk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1828FF
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654233; cv=none; b=NgR5SuX2CrQ9x7h34L30AnQ/e7esTF05pYbh0MCHVQRVYB5MSsgPeF5dmyeP38ZUZAb0po3IiR2yHRcxAK8OWf+ArpxqYDqV8+62tXfnRZpd65gQJ0pxjrO6j4fEXYMP3ZCUj38ZcKYs1Ly1TguDzJS5d30nex3Zh07AR3KtZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654233; c=relaxed/simple;
	bh=xtR00KOJt3fo0bLbRf7Dger0OiI0DyqLX75QL9RZF0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ftz9bcf1PPSAr/EeJs2C+Op4/ccKGDKMlh4UN3q/ZbQt4/iZ6CQpro/FckRQjAI8q7K1WA53perATuPBZrU/buy1mrkBKSNt9Hqm2nwfh+/BZ8QcxKKIfpXmo0iTbYNG7bImYwxkUWgj1TbRMafJHSNSYKbhYP3IoJi2DO3BG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V//+u7tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DBFAC4AF09;
	Wed, 10 Jul 2024 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720654233;
	bh=xtR00KOJt3fo0bLbRf7Dger0OiI0DyqLX75QL9RZF0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V//+u7tkEeNzINmZi8RWCVJVfIfCIpDAYIy5Ni2dBQDVpsoVWpDayr7M5oMSXtD3Q
	 sIxw7Ltck+CX6g6TojCPV9NutbcteIgggTpCr7gEfP2ATQ/c81jcFG7UUGwyCECPe5
	 vMIoIJNdmyDxJxzBpYBtrq/ey3KzKB6ieIgot8tz/XpKKULNBvFv0UtPt2MUf/lYxb
	 Hf4sb0IaS6VsEYldpjCLFQW1VPXG8JG3JQMC8Ag+0ICWkdbEG9AxY85+E6z6baf2X1
	 lNqdJsOaZoGeNKmHwnH3tnwqeMV9w0ZJOyz8HmYCM5wkF45PW2FIHJkfVV883HAKgF
	 amuc0dEOv/2Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D09BC4332E;
	Wed, 10 Jul 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/3] Fixes for BPF timer lockup and UAF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172065423350.5820.8139357490858247646.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 23:30:33 +0000
References: <20240709185440.1104957-1-memxor@gmail.com>
In-Reply-To: <20240709185440.1104957-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, dohyunkim@google.com,
 neelnatu@google.com, brho@google.com, htejun@gmail.com, void@manifault.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jul 2024 18:54:37 +0000 you wrote:
> The following patches contain fixes for timer lockups and a
> use-after-free scenario.
> 
> This set proposes to fix the following lockup situation for BPF timers.
> 
> CPU 1					CPU 2
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/3] bpf: Fail bpf_timer_cancel when callback is being cancelled
    https://git.kernel.org/bpf/bpf/c/d4523831f07a
  - [bpf,v1,2/3] bpf: Defer work in bpf_timer_cancel_and_free
    https://git.kernel.org/bpf/bpf/c/a6fcd19d7eac
  - [bpf,v1,3/3] selftests/bpf: Add timer lockup selftest
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



