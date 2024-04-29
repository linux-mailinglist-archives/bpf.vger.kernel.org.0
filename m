Return-Path: <bpf+bounces-28208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B68B662B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5685D283078
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D514194C84;
	Mon, 29 Apr 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVILryaw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83914291E;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432831; cv=none; b=dcs8vmwc+o9YlZVsKwiEMyYVuxjoRaOXWfuDbMQQXjkUychfeCOe0a78+U2zL5wP6GzpY/w4bePgFvt9VQyId4/5C3X7VAd+69iBfFnGJ4xFLd30ebLhCyYW2+b/O/TE7dX2DJ6HKbzw+4zIjcADZWEa0yUnt48GNTGms4FLDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432831; c=relaxed/simple;
	bh=aWlqmfsjdDprFD1QPHeYvmyvfs26WsVNyAegz3z+Sz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iuZaPUkjy/KwaXotrKAS8uu+lR2M6JQkw2FvWf+Wk3Zq55s9wrCIWDHKWeKC8OUAisR0yMZ3vPvJvMhRtvM1snJzl7CR1OsSWtd2akHVSmy4tyL6fjtlLw5MXTfZltoKSr57P5l6MfSmFMIvcFE49bPKdvj4ZByuLzvEQGSZmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVILryaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C313C4AF1A;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714432830;
	bh=aWlqmfsjdDprFD1QPHeYvmyvfs26WsVNyAegz3z+Sz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OVILryaw2x3rvars8w+/RnZlFd+RjOVwnHts3BoHgtWUvyt6mxP3G8VItJo7IJp2q
	 mYY4mMzF18Ly0/gYQAJQknJ0YP3eUvnCofI8mvGxgWwgmhBQEJwyd15rNwiyZmX6nF
	 0k8qVAkFMn/2adgiDT2+GxAqqfiNXpSQqTKPArskgD/4ZHdMN9TomZDYXG7iWH5x1R
	 3wK2VFPE8uJxFgMCYHDO685Kj6xxpX/oA0OEDK2SpPgfpmHUke1CsmtiAAzNTIfCOt
	 qVGm2amt45s7VBoug/Vq3llMKZ04vOWgD7YPERSZVBI86dddmwLdInTwUGP3+7WN4/
	 RBAhU7Wz+/agw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AF7FC54BA4;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples: bpf: Add valid info for VMLINUX_BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443283043.1398.11744904571177428676.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 23:20:30 +0000
References: <20240428161032.239043-1-chen.dylane@gmail.com>
In-Reply-To: <20240428161032.239043-1-chen.dylane@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Apr 2024 00:10:32 +0800 you wrote:
> When i use the command 'make M=samples/bpf' to compile samples/bpf code
> in ubuntu 22.04, the error info occured:
> Cannot find a vmlinux for VMLINUX_BTF at any of "  /home/ubuntu/code/linux/vmlinux",
> build the kernel or set VMLINUX_BTF or VMLINUX_H variable
> 
> Others often encounter this kind of issue, new kernel has the vmlinux, so we can
> set the path in error info which seems more intuitive, like:
> Cannot find a vmlinux for VMLINUX_BTF at any of "  /home/ubuntu/code/linux/vmlinux",
> buiild the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or
> VMLINUX_H variable
> 
> [...]

Here is the summary with links:
  - samples: bpf: Add valid info for VMLINUX_BTF
    https://git.kernel.org/bpf/bpf-next/c/397658ddc88c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



