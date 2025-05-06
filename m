Return-Path: <bpf+bounces-57545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C93AACC3C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B9E3BF47A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B00284B59;
	Tue,  6 May 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUqeBUWj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B51227574;
	Tue,  6 May 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552600; cv=none; b=k+LmWFCZeN1ulEDYJejAy4cf+ZbzkD96P8aa7IsSBuvB4Pk2Va2NHl43/8neP7cJl8DjvwnXzwk1/cc0xYCYjNn7wbcdGQ/LjaNa+NsdSKHCyq5j5decN8+Id+EBD7QMlGpp4xJEUxim3MDVFP17t4nqn5Cg8RmY0obIquoi5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552600; c=relaxed/simple;
	bh=a5IjjeslWstXCIy0Z7FbsC1/6yjktsktZKQbGzwtkCs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ESpOfgdw+Fc/Ffbn//COxQaHlVGK2zp9LzRlQ99d9pWjMVHQF2xJxViIyqYRzBV2xiIe7/We+mZPAkhdJZX7yKji3J/2m+XFtPWCOfxxGpaw3iZE1qV6xdata5jPsWnYSpcsuq27SOuObtdzCfjB641bCXeSGr+M4Whav3spSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUqeBUWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C4C4CEE4;
	Tue,  6 May 2025 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746552600;
	bh=a5IjjeslWstXCIy0Z7FbsC1/6yjktsktZKQbGzwtkCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUqeBUWj43Di7dbKEYkkasDAm8gzm4WFkozz2xCJl4YzD9S8oJdX6l7Af2OL42I2e
	 SElEkRzplvFULPXo3ClMlRcVdaNg02xnIKJTnXB/+HPEFz0klBEkGR5kCkg9LNzYam
	 4xCBRIIE6cUDbC7T+gVmmjp05ZE3IavsijG6B6Kitu7sYNTl8LQRsxvLIvk0FgSalh
	 QwphM5MycKvbVx4pJE8FF4uWcj01N0VAsfjHW/YZ06YE2fsQxZ45a5OoveKnyjnYZC
	 jprKobnJG95hmeztc6tkMFRUbShSk6ysaPs6HurupuMJATL7SDj18IRhWLZdOi6HE1
	 QuKG2IqTw+q6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F05380CFD7;
	Tue,  6 May 2025 17:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/8] bpf: Support bpf rbtree traversal and list
 peeking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174655263889.1598736.13266345407626279616.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 17:30:38 +0000
References: <20250506015857.817950-1-martin.lau@linux.dev>
In-Reply-To: <20250506015857.817950-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, ameryhung@gmail.com,
 netdev@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 May 2025 18:58:47 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The RFC v1 [1] showed a fq qdisc implementation in bpf
> that is much closer to the kernel sch_fq.c.
> 
> The fq example and bpf qdisc changes are separated out from this set.
> This set is to focus on the kfunc and verifier changes that
> enable the bpf rbtree traversal and list peeking.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/8] bpf: Check KF_bpf_rbtree_add_impl for the "case KF_ARG_PTR_TO_RB_NODE"
    https://git.kernel.org/bpf/bpf-next/c/b183c0123d9b
  - [v2,bpf-next,2/8] bpf: Simplify reg0 marking for the rbtree kfuncs that return a bpf_rb_node pointer
    https://git.kernel.org/bpf/bpf-next/c/7faccdf4b47d
  - [v2,bpf-next,3/8] bpf: Add bpf_rbtree_{root,left,right} kfunc
    https://git.kernel.org/bpf/bpf-next/c/9e3e66c553f7
  - [v2,bpf-next,4/8] bpf: Allow refcounted bpf_rb_node used in bpf_rbtree_{remove,left,right}
    https://git.kernel.org/bpf/bpf-next/c/2ddef1783c43
  - [v2,bpf-next,5/8] selftests/bpf: Add tests for bpf_rbtree_{root,left,right}
    https://git.kernel.org/bpf/bpf-next/c/47ada65c5cf9
  - [v2,bpf-next,6/8] bpf: Simplify reg0 marking for the list kfuncs that return a bpf_list_node pointer
    https://git.kernel.org/bpf/bpf-next/c/3fab84f00d32
  - [v2,bpf-next,7/8] bpf: Add bpf_list_{front,back} kfunc
    https://git.kernel.org/bpf/bpf-next/c/fb5b480205ba
  - [v2,bpf-next,8/8] selftests/bpf: Add test for bpf_list_{front,back}
    https://git.kernel.org/bpf/bpf-next/c/29318b4d5dc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



