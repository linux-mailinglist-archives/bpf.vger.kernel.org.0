Return-Path: <bpf+bounces-46823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6F9F04A1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 07:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97CB188B20F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819A185B56;
	Fri, 13 Dec 2024 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/97BLyC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37C1547CC
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070213; cv=none; b=M7LaTcnUKyZcidCDt9y8STN4QZb7m+zJBoIyY/muccRxDjJdlxu6v4QrL/y+qEMC33z3OhHylQgCxqrXQYdX4dle0+HYsRR0IGFoNtXlJZnDzh8Vph9P+OcOcjyUdowhAqqCJ2FVbaNwdnGiCfN33ZWmOwtYaqZ9YoxnillOfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070213; c=relaxed/simple;
	bh=iTlUkgKbDOfE09CYyF9Egllwa7L7rbOQAHVxKPchZ4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TmffZFhoLHLW0Kzzpv4tiYIuQLJ1vFXLgCWwCwD4oZQpN5rL5zEc5LRGwUmSF66TIx7xjW6DRnb7eEtA0Ce573/9BTnTbxCeCNxV9hXJ0bCbkCEVCOYj3yu9/+ot7jMYlzfxv0J8Zhc9pxgsj7de2SHpH/zGACTe+OBTOu0XrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/97BLyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB19C4CED1;
	Fri, 13 Dec 2024 06:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734070212;
	bh=iTlUkgKbDOfE09CYyF9Egllwa7L7rbOQAHVxKPchZ4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/97BLyC28oTm9/x30tZ4VF3hXQYUIyYitggxYPVs9YnldWwTvpii1cgpDS2AKvUv
	 EthAX/i4/0IhjgztazQ1+uYxlsxILI9fC5HhFvO4cMtWemRjOBfXL/F7YBXQhjIOUl
	 A52aKGaWSSGLWwNyBV6IEIGEdJG4kklYtfa/MjzOEZcpwW/IxOIacQj2BAIrbV5EpF
	 bDCdvAitsvDOvG2NHGXtTQoLenuckJ9ZXErHS17esMkuLRUmQ4MhnygKabRQve1Dyf
	 O+jV1VVFF0mNYGrtxH5hLjAvxPz3xS88cCGzRjrZjWrONV5Dgmv1lkd8d6PjzAjHgh
	 Vvh8guHcdy+PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB2380A959;
	Fri, 13 Dec 2024 06:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: make BPF_TARGET_ENDIAN non-recursive to
 speed up *.bpf.o build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173407022926.2868509.6650979541461870107.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 06:10:29 +0000
References: <20241213003224.837030-1-eddyz87@gmail.com>
In-Reply-To: <20241213003224.837030-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Dec 2024 16:32:24 -0800 you wrote:
> BPF_TARGET_ENDIAN is used in CLANG_BPF_BUILD_RULE and co macros.
> It is defined as a recursively expanded variable, meaning that it is
> recomputed each time the value is needed. Thus, it is recomputed for
> each *.bpf.o file compilation. The variable is computed by running a C
> compiler in a shell. This significantly hinders parallel build
> performance for *.bpf.o files.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: make BPF_TARGET_ENDIAN non-recursive to speed up *.bpf.o build
    https://git.kernel.org/bpf/bpf-next/c/5506b7d7bbdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



