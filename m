Return-Path: <bpf+bounces-53716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9FA58F4C
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD2188F9A7
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6CF224247;
	Mon, 10 Mar 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIBrwR6w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D72236EE
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598399; cv=none; b=EXAVBoj6vn2vQ6u69joqSB3XW0QMzups6HaX6E3PdTtH86W45q2z//jkbtS6pZQlYbSUOq2ZevO+wk3OrqiuZYYaXShYGbvUAXx5EJwjIHyeTXBApnTAN9lWJc05PIp9KbIPoMtQvA8FCMEG1OpMj9jHa4tdvhGaCV02xNOtZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598399; c=relaxed/simple;
	bh=1G0gF4JWvVXG+PDIWeClxn8Q26jKftGULvbAA3sHgc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VhZIRIUCZb5vf6Q/fV0X2cBAZPFLHAt/XbfCOZi73VkW4dE/c+BnT5VgfkGtMtl1dhvwvjS5kh5RJCyRcvl1vRcZxcpHHRVREt8yDciWMFgHZjfr8GayVFOPyT8e8MOKyxzuUui5Xm0X3AfMul5NRuKJbKBxfujfOTlhImkS5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIBrwR6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D76EC4CEED;
	Mon, 10 Mar 2025 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741598399;
	bh=1G0gF4JWvVXG+PDIWeClxn8Q26jKftGULvbAA3sHgc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TIBrwR6wilN5inavY8XyO67yIvIjnoYDHuQ1XWPYn07C6IbTap2HksDtHsGQuGdxS
	 vfkGmJy1mR/lxoOeo0dUf9tzR3xF/9tP1uUH71gbQKGYSESFDrmA6aoQtqt3DAmckr
	 RrxXykN8mEoRglezZrNy8fNSV7ZxL4CKmjwx9HQ1cTZyMT4e8iqbnPE71Ex6E4DIEu
	 Rjsxhnns7tnSWjS/Ih687m4PfzL6QCLwK4G7xHITw8X5ulO4hQM/aAnhY2jWpnOwi6
	 MuBEh51S+KuoYK+A/LknqF91R7elx2MkUJBJ5Zq/8+aeodLVdhR7mO1q93U5gQE2pL
	 t1miJ3eLJLaEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D82380AC1C;
	Mon, 10 Mar 2025 09:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/4] bpf: introduce helper for populating bpf_cpumask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174159843301.3446560.13692337798366305173.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 09:20:33 +0000
References: <20250309230427.26603-1-emil@etsalapatis.com>
In-Reply-To: <20250309230427.26603-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 tj@kernel.org, memxor@gmail.com, houtao@huaweicloud.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  9 Mar 2025 19:04:23 -0400 you wrote:
> Some BPF programs like scx schedulers have their own internal CPU mask types,
> mask types, which they must transform into struct bpf_cpumask instances
> before passing them to scheduling-related kfuncs. There is currently no
> way to efficiently populate the bitfield of a bpf_cpumask from BPF memory,
> and programs must use multiple bpf_cpumask_[set, clear] calls to do so.
> Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid
> BPF memory with a single call.
> 
> [...]

Here is the summary with links:
  - [v7,1/4] bpf: add kfunc for populating cpumask bits
    https://git.kernel.org/bpf/bpf-next/c/63f99cd6a53f
  - [v7,2/4] selftests: bpf: add bpf_cpumask_populate selftests
    https://git.kernel.org/bpf/bpf-next/c/3524b150f4ff
  - [v7,3/4] bpf: fix missing kdoc string fields in cpumask.c
    https://git.kernel.org/bpf/bpf-next/c/d70870e809a9
  - [v7,4/4] selftests: bpf: fix duplicate selftests in cpumask_success.
    https://git.kernel.org/bpf/bpf-next/c/93ececb29a19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



