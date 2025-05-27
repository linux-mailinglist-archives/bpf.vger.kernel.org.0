Return-Path: <bpf+bounces-59009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E545CAC5810
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 19:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC88A6E75
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD528003D;
	Tue, 27 May 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZk1lBN8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C91CAA7B;
	Tue, 27 May 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367602; cv=none; b=S46O/nptdQ7W0Nyd5Aptu9gmjwzNJvyS4u3BfvAvQ00uZcUypJ+awAqln6tgNascDqnw4uUxaL7SCyqcpuET0KsIeQfDIHvJzYDTgIAFHK80nkAzrR0HKCyEZD7fsKMbZHmQS5AK+kGvOyqb1PpQXzb5JbJ3/IkWfAX5FYEYo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367602; c=relaxed/simple;
	bh=89Vj2w5PEab91wuwNnDtXzxvInb8pjxCL/+sTxNeUVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LPklbnv4J8uVTrrskW+ug+GT1PKGxjze4aPqxOFDyf8yjDhneaD8VM4NeDt56U+ZtB/xR5NNI3M+LSOCycWT8I7NeQ+lexYGyRiVyWvTRsADMrttKFKY08xLKIvQoh01+g9J9pX/LOOzMzbbzIkspEg01tVL5Buzf96gK1H5Nf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZk1lBN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE610C4CEE9;
	Tue, 27 May 2025 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748367601;
	bh=89Vj2w5PEab91wuwNnDtXzxvInb8pjxCL/+sTxNeUVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mZk1lBN8aGwbib3al5TnANJQwATzT7Q88dFdAJVTEl6sg0+iohmPo8LfyTSjI/u33
	 MzRixEOIMQbuB8HoJfiCKUS55DiR6equ2nIAibkduZ0SIwqjOHpPfxVh4yYygDmAZY
	 VlY08Vau1K0OIhZy+5N43qBQE3UxnYSXy8N1Gy0iLuZTnfNVRDc5TvsqqkihowuaI4
	 oIqKSE5oZFcWzZHU7mFzVzUoODkVFg220/3ZHsHjpl89iXhKT6BNutcQf1JUEKNqeV
	 tq2cjgcKezzVOKa6bBY8AaFt9hSEs2ubPPfWIn/2HoW3s2wjxsmRZGAlPJYbWRJcwh
	 pct89J62NMmwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341A5380AAE2;
	Tue, 27 May 2025 17:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpftool: Add support for custom BTF path in prog
 load/loadall
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174836763576.1722871.13804046741500050141.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 17:40:35 +0000
References: <20250516144708.298652-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250516144708.298652-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dxu@dxuuu.xyz,
 chen.dylane@gmail.com, yatsenko@meta.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 May 2025 22:47:02 +0800 you wrote:
> This patch exposes the btf_custom_path feature to bpftool, allowing users
> to specify a custom BTF file when loading BPF programs using prog load or
> prog loadall commands.
> 
> The argument 'btf_custom_path' in libbpf is used for those kernels that
> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
> relocations.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpftool: Add support for custom BTF path in prog load/loadall
    https://git.kernel.org/bpf/bpf-next/c/1ae7a84ed853

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



