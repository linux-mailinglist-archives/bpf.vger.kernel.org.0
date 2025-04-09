Return-Path: <bpf+bounces-55604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA394A834AD
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D58189F72A
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF921D3EE;
	Wed,  9 Apr 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj3LRGqc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9E19ADA4
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242012; cv=none; b=Z7z+y0DyznHeHpdeNgF7XwDeTqzOJfBNqJlUI2OncW9jf8CGaDkOwrQseMBM7+ZRNXDN83CcjmviHoOglJQ5nEiblm9fDHQyCin3pZLaU+yT+trlnfm/46gy4rW7/lXbGsUcSKUqY8LwQUsABTWwFWnqg5rREJTl3DUQnL8ZWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242012; c=relaxed/simple;
	bh=FZ60AH0JPZePD5G/CQ5kABHXCcF62aoA1Dkjx+sRaFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qXE2Z3EBsA8CDlXGXT3edYx6z+nLpe5pLWOU+1wp+G3g9yS5FpW+YJEJiBhFS81TrtEYc30BnV2hec88mjI+fa0A1y5a+frDiKY5SAQZvh0tm683SwYdbEqp1hEHmrWcdOrRPi+68I7B2VjyPdqR71TeaOek5zOYWXXy391niwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj3LRGqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3F2C4CEE3;
	Wed,  9 Apr 2025 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242012;
	bh=FZ60AH0JPZePD5G/CQ5kABHXCcF62aoA1Dkjx+sRaFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dj3LRGqcbKRDL1XGGZlDsSZrtnTR6ficCROSBqaBe5Mfz/KtZi2SLQpQBZBleoHzx
	 RWBBO5zoqMAVxmNHmTYknXH9CtBSdgtfhAbPRFjLAcE1mNd5+pBYAaub2KhX3SQznu
	 dtLrrKvpBH/n1Lrcoj5aAoK8zOhUE+/Vi+MuiPZW/9Cc8kFca+ttTU59i4Q1peQoyq
	 EoRtmQxg1U2Qoq2A3csxFY2WHtWxBZo+49W/q79O15tV1FjNR3NXZxDN6TzUfHbWBh
	 YDuCX/ZRuSXigju1/eiMlNLQtyv6NJTw6bUGVor24G5Fe815854beN2cyzD0ANUi4M
	 QLzwjg+kHrWwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4A738111DC;
	Wed,  9 Apr 2025 23:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] libbpf: introduce line_info and func_info
 getters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424204976.3077267.16964174474735244289.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 23:40:49 +0000
References: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Apr 2025 00:44:15 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> This patchset introduces new libbpf API getters that enable the retrieval
> of .BTF.ext line and func info.
> This change enables users to load bpf_program directly using bpf_prog_load,
> bypassing the higher-level bpf_object__load API. Providing line and
> function info is essential for BPF program verification in some cases.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] libbpf: add getters for BTF.ext func and line info
    https://git.kernel.org/bpf/bpf-next/c/243d720e2e53
  - [bpf-next,v5,2/2] selftests/bpf: add BTF.ext line/func info getter tests
    https://git.kernel.org/bpf/bpf-next/c/b8390dd1e09e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



