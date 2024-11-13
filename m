Return-Path: <bpf+bounces-44709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8979C66D4
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DB7285771
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2D481C4;
	Wed, 13 Nov 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOa1V74G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCE18654
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462021; cv=none; b=ogW1B0dtc+BZvD600An4DP/0L4LOol1MGwtjHdeVQ5L8RGIEuAIs/OOsjJlCj5R67BC8Q/IqaxOldzD4lFao8vYePH7esFgc7OGg6U1TIZz7hsDawMRx4iwhfGMwXyYZHLRwHaMdmAS0hphC4NnTd16MSPpjdXc/C356FdcVeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462021; c=relaxed/simple;
	bh=pivmGzh8sv47imCWcPy/6fIO86ZgmrQF6VpJbDy1kJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jm+FWbZ84ADJ9YLJ+7wV5ziGfwXok7O+tH8ofs8JDtGamuooOiVWf3UgXL/VADJputwegnZejI2p8Z7/EBWEgGtA98UXGpMTb+7Vwzeer6MMEOj4f5VH2sHm7GeEHndQDGTIdzN/yHSNF7Vu3nkGBch9r7ePjDzVgqTvBSatkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOa1V74G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF80C4CECD;
	Wed, 13 Nov 2024 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731462020;
	bh=pivmGzh8sv47imCWcPy/6fIO86ZgmrQF6VpJbDy1kJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EOa1V74Gob/Ymg/RfHMor3QBqixzbkwA6FZGzTg/bZTRMy45Luz49Xxn1WRYLoRWS
	 nUwtizTkkwQaaSeX9I97NWO/8gbczcM545IBp11RY8AYoLPqwxl2uZYtHSZcwnYzja
	 e6tSbPsRprtC5snz1tgnDXjltJxKFBBWZ9LzRE9Fux9dUuiooZ1XchaCnzImdk4/Pw
	 zeScSjp/K+127VT6QJTxBnLKbF+ejuo0dEWqAV9BHa+fSkpCjuYGMzOiqNDmBloF04
	 HcB5Ke6TYYvLc4mfUG2nBM8l9U5MmOQzUeymLAlxK6e7sImY+5Kji3pOI1j5WbWOue
	 qpNgCqoXLbCIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE73F3809A80;
	Wed, 13 Nov 2024 01:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf, x64: Introduce two tailcall enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173146203023.747334.7321490965358395425.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 01:40:30 +0000
References: <20241107134529.8602-1-leon.hwang@linux.dev>
In-Reply-To: <20241107134529.8602-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 eddyz87@gmail.com, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Nov 2024 21:45:27 +0800 you wrote:
> This patch set introduces two enhancements aimed at improving tailcall
> handling in the x64 JIT:
> 
> 1. Tailcall info is propagated only for subprogs.
> 2. Tailcall info is propagated through the trampoline only when the target
>    is a subprog and it is tail_call_reachable.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, x64: Propagate tailcall info only for subprogs
    https://git.kernel.org/bpf/bpf-next/c/a1087da9d11e
  - [bpf-next,v3,2/2] bpf, verifier: Check trampoline target is tail_call_reachable subprog
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



