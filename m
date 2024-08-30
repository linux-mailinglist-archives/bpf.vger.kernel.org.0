Return-Path: <bpf+bounces-38565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED996665A
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D4FB2396F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F41B86D9;
	Fri, 30 Aug 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M35Lo/+K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB71B5ED3;
	Fri, 30 Aug 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033626; cv=none; b=fqkKJElju4LP1d9QB3XCACW2RWavNczxl8XHd9Cf/EOtGP148fSmSbKpDs+su9eONxFIMM1Wz884nfI1OFgniumXvmfqLxr9jI8PqF6N3rRLsxo48agIXoaIdUpbaUTRoJwgh6LG+Ers9C/H6HkZ1LGSS7JJW0U/OA2/YfnsEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033626; c=relaxed/simple;
	bh=H1eVR7fCA25sTItQDzNJKfMrwfmWIW5Mj3idcLd+EzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrKqRU3ufwgpvnHzJv0wZIq92kwCIFzU5U2kD21vHm0sW6fIkDHFQk1FfUMEiGcXcuVl8hIuOniE3Sjl1tdNYafgFVFwPt1dIsXkNYcAbOu8vk8QtKvirNd6NcVcHch6pLym9wFYJxDO1zgt5S9R0YvTz3IR/VKCk/5s5ql4rCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M35Lo/+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1601DC4CEC7;
	Fri, 30 Aug 2024 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033626;
	bh=H1eVR7fCA25sTItQDzNJKfMrwfmWIW5Mj3idcLd+EzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M35Lo/+Kk3ZCNXPouvGjPvhDAn/ShvDhVs/2VPLgK0mXoUBYTNtjCutv+q2sm/QQj
	 mFZmYF0HVFosWmYol+InpRnXNQIigigebWQVvvdPpVnti5xqlzoYkVgSkqidyOZyQ4
	 psNJOoljcGo30FVlEL02wzpVvHxf/90N0hiCsYpjFphwUkv85f8wsnncgiM2wBmSh3
	 8S6SrXfd39XfoE1GGHcgHX99r5DtwliX1Fq8YF6qfxzuG49ZICUykXZ6NMDrEwUntB
	 4CIdgqdQcx2sqJWOIC0RlSYlTs1zy+J6fasdU5GrhcGUgdAobYifTOjV+KzOvtS65K
	 hJYO6t/Nxts1A==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AB9223809A81;
	Fri, 30 Aug 2024 16:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] bpf: Remove custom build rule
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172503362769.2640228.5019658965593399778.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 16:00:27 +0000
References: <20240830074350.211308-1-legion@kernel.org>
In-Reply-To: <20240830074350.211308-1-legion@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, masahiroy@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, oleg@redhat.com,
 alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Aug 2024 09:43:50 +0200 you wrote:
> According to the documentation, when building a kernel with the C=2
> parameter, all source files should be checked. But this does not happen
> for the kernel/bpf/ directory.
> 
> $ touch kernel/bpf/core.o
> $ make C=2 CHECK=true kernel/bpf/core.o
> 
> [...]

Here is the summary with links:
  - [v4] bpf: Remove custom build rule
    https://git.kernel.org/bpf/bpf-next/c/1dd7622ef508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



