Return-Path: <bpf+bounces-52696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C3A46D11
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5911B3AC683
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1625A2A4;
	Wed, 26 Feb 2025 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEPQ6XTK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45E2580EC
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604202; cv=none; b=X6rnV5rqXmwJyVjSxkMHnApMSrMii9QfprSygRwz5k0xKEvTo3aWxg0rUHIE+1/rJ8Rlf7LYMHAFSgigId0FhaWJsfCOM4DinH2rULK2nZ61PiePWK3TDSibHpPshfFRso7SeXH1A5oa8KJALa+aWBgXdB22ckTNp4wxTm8k3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604202; c=relaxed/simple;
	bh=LsTU/bgjbiTvVW7xCOpRJDP0opHXYxhJ/mEfeBOXdoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VHvfcbBACoTjoZiHTs9BI5eULNXqO/yLKYEVmItZEy08zirlrxDQEKvmvCgVa+vcwSB3o5dkFBrKbqYntj6oH40n6a8nTqww2X/U/bDX0ius8oS74Fq0goV3FRgo+tOfOngYLFq7/HuYKH7H+u+16gH8W8DT2QEYgjGnxOFjG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEPQ6XTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA62C4CED6;
	Wed, 26 Feb 2025 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604202;
	bh=LsTU/bgjbiTvVW7xCOpRJDP0opHXYxhJ/mEfeBOXdoc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DEPQ6XTKWlWXYnpX8LSue9/JgxrlwLBXAAG35OIoIwuQGHjM7yopPsbNhDnbOVdgK
	 uIJ6j68oJqU5DLLyLHoNzigIWYznjmVISvtgtUhwxoGBA9B0A8XOyUl7QddJGQsAiM
	 +bX4Aeo3PePAc7qJnI45iQYuKZD1b2iynbryy7hRe6n3DYgi+2T/YyWEOFAlybN2Iq
	 onhjNeHbsBdPHeOWvFDUu+9d+UuevbvKONf5Ca9J6Pf+/5xsnVo+F1+P5fyxgz4nVz
	 XUn9yOuYytleOpSMyKGbXMuIm9POugmEoyXWEiRv1KKcJfT4pQN855Vso5Yy2UPSyF
	 Ebmg+mFXz7+ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE0380CFE5;
	Wed, 26 Feb 2025 21:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] introduce bpf_dynptr_copy kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174060423373.846473.9090890109880103059.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 21:10:33 +0000
References: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 26 Feb 2025 18:31:58 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Introduce a new kfunc, bpf_dynptr_copy, which enables copying of
> data from one dynptr to another. This functionality may be useful in
> scenarios such as capturing XDP data to a ring buffer.
> The patch set is split into 3 patches:
> 1. Refactor bpf_dynptr_read and bpf_dynptr_write by extracting code into
> static functions, that allows calling them with no compiler warnings
> 2. Introduce bpf_dynptr_copy
> 3. Add tests for bpf_dynptr_copy
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf/helpers: refactor bpf_dynptr_read and bpf_dynptr_write
    https://git.kernel.org/bpf/bpf-next/c/bacac2175c13
  - [bpf-next,v3,2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
    https://git.kernel.org/bpf/bpf-next/c/9d15404d055b
  - [bpf-next,v3,3/3] selftests/bpf: add tests for bpf_dynptr_copy
    https://git.kernel.org/bpf/bpf-next/c/8fc1834cbde0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



