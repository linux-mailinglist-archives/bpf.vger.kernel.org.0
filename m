Return-Path: <bpf+bounces-52676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B6A4699C
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF831883561
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E6235BEE;
	Wed, 26 Feb 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUBbN6FD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307202356B7
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593998; cv=none; b=TqWmOZl4H/fHN1LGUkddX7xGsiZ91vJ3+KL6mihH/NVEKAcU1VUO0I2uFe6voJzwtjbITw66pPyQdfve7a/Hsnjmtwckfb0UtdPh86D8XOTaiTzHQHF9JosNEM/TNPpTBxdnNRkN9aIrMbTOUW3S4zQU9bP2z8tMwLeENIrMya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593998; c=relaxed/simple;
	bh=/RwtoeRBT6udFas7RPhS5h2b5FY6XYGLusZJgJja8VQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OT4Oq42iQOfOI8FUi3K6jhtGGHvL1l65u4U4QRI56l4npKRBg0Ya7EGJbxLHtp757ibjQ/FP/eo9vm+YNdQQiytqGRQSlu2cAAH8zIFT2enx85bcItzYuPfROEhuI6wy13udpIt9YDbJU2juQcxz7twCc7qSYubfS1JO2OW/eqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUBbN6FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9775BC4CED6;
	Wed, 26 Feb 2025 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593997;
	bh=/RwtoeRBT6udFas7RPhS5h2b5FY6XYGLusZJgJja8VQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HUBbN6FDCg138bzCm3oDw+5QZmZwTft1b8xYNGklZ39NARW1BerY5DBWuiGyzOv0p
	 MF2ERH8S4BcSwtzgrilkPZ+WQNBdbFC/sXDio6qxFqZx94WgGlcQfQQQQbB7Ne4prV
	 Nw2vcJUKvjqyMJ2BjlZ8lpRcc/1Os1uWwxV9Hpk3sRa6I17ftBZ4L4fn0K41RLW0qz
	 lOhjAfjZzS3CeviItKEGxAQYqfvScJKHFWT2mUn/IOmw80oyM1286iyVwdMf5BoQx8
	 7FRP/UvIsBJvCtKzA2lEzTBmIfGMor8KCUwFgH0YdVa5ewYqMh3jSug0Da7oO2fXsW
	 lEbViBqk7Bc2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD69380CFE5;
	Wed, 26 Feb 2025 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: implement bpf_usdt_arg_size BPF
 function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174059402950.801235.7236301825400438498.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 18:20:29 +0000
References: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 24 Feb 2025 15:57:55 -0800 you wrote:
> Information about USDT argument size is implicitly stored in
> __bpf_usdt_arg_spec, but currently it's not accessbile to BPF programs
> that use USDT.
> 
> Implement bpf_sdt_arg_size() that returns the size of an USDT argument
> in bytes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] libbpf: implement bpf_usdt_arg_size BPF function
    https://git.kernel.org/bpf/bpf-next/c/b62dff14402a
  - [bpf-next,v2,2/2] selftests/bpf: test bpf_usdt_arg_size() function
    https://git.kernel.org/bpf/bpf-next/c/0ba0ef012eba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



