Return-Path: <bpf+bounces-38451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1D964EA9
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7547284362
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716921B8E8D;
	Thu, 29 Aug 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxc9PV4y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56751B654B
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959227; cv=none; b=rWjqU0JykvSO/SuuixnowLgflt9Li9XvxFP1PBBYvJsDYiCrk6VJX1p90VCDbhK7BSBWqS91kp2NGqB637X6bm3w+MI4MOj6QBxxF7MxPYj8jIIz3P8E41HdQ3+FOkvQnu+ApN6cdWRPWdBHR67zSxyulIK7C/zaV73NNupTOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959227; c=relaxed/simple;
	bh=5h0P5u/01lw23RTyc/5OagDEYAPPV3SnyAswyOBilZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvXvVnAJZBZ8rwTm4O/kMRYXi/GhMVoVfwlCI7Iu4WadJgCYwhEORCC0JqIEEjHmF8UxH08Qb4gB6RnXhPzS8HMZyUw7UE6aq0MMgsTLtkfjb2CNdWYIa9dC/AnaSEz5Ukq/XQXJMIReJudnm7jsuUEQXRRUy6rTGyoNruMIbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxc9PV4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A03C4CEC5;
	Thu, 29 Aug 2024 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959226;
	bh=5h0P5u/01lw23RTyc/5OagDEYAPPV3SnyAswyOBilZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dxc9PV4ymqA7ECRoo5TcVZFllMF+bClcFSXXpZTC5fHWF8KrkarIRXqbQcrPDttzF
	 npfyVSjtehbEGHWOJwiKJqntQU+UloeUAq+ifChejP+4r2hmw76iZxOJgntpMS48i8
	 OVNBfhokt5QfQWXepBw9XvHqeShsdyINk/8UxV1+7vgjsz4ouiqTDUePTByhyq0UmM
	 6WgBnSUGYOByLLbc8vGVbxvYo/ONko7s79hvPjyuPRc+Q00aiR6ByGb5oYkt5HLco+
	 HondtRv9lCgmKINFfvGemP9ZkOEjJPMVThF0YlB0Q0fzDMc7PieaMMv1+0XdkzqtYj
	 Ozy/CU0qzS4RA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0D6693822D6B;
	Thu, 29 Aug 2024 19:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure stashed kptr in local kptr
 is freed recursively
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495922804.2057934.12011253758921336605.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:20:28 +0000
References: <20240827011301.608620-1-amery.hung@bytedance.com>
In-Reply-To: <20240827011301.608620-1-amery.hung@bytedance.com>
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, houtao@huaweicloud.com,
 davemarchevsky@fb.com, ameryhung@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Aug 2024 01:13:01 +0000 you wrote:
> When dropping a local kptr, any kptr stashed into it is supposed to be
> freed through bpf_obj_free_fields->__bpf_obj_drop_impl recursively. Add a
> test to make sure it happens.
> 
> The test first stashes a referenced kptr to "struct task" into a local
> kptr and gets the reference count of the task. Then, it drops the local
> kptr and reads the reference count of the task again. Since
> bpf_obj_free_fields and __bpf_obj_drop_impl will go through the local kptr
> recursively during bpf_obj_drop, the dtor of the stashed task kptr should
> eventually be called. The second reference count should be one less than
> the first one.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Make sure stashed kptr in local kptr is freed recursively
    https://git.kernel.org/bpf/bpf-next/c/bd0b4836a233

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



