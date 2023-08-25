Return-Path: <bpf+bounces-8655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9748788D3E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164F81C20FFA
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910717AD0;
	Fri, 25 Aug 2023 16:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49D1079A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC97BC433C9;
	Fri, 25 Aug 2023 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692981624;
	bh=SKDRSLtygFS2WiM7wT7iplbO3yRVIz5f0tIwB4uNJEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JgY2nxR6W/dAjw/pS53QovhIvL1wteo2Gh5CBABdik9cEiz2Zv5wHmxb4Rj2eqYfm
	 xBGdXwBKdEuvUgvfcG/WJwvIca8qx0cFDGpXEbr8Af68TMc8vHwZSvVORVgzsgkBee
	 qdg7PgIy0nmuerL8iOL/+TBwbObU/mwahSBN2UFatEMlEP5eAG8pa7OzAWmegHfCH9
	 KJ1YuUda3UdVQxgu5Isf6C+0MrDW/9+qtLbmY1eBzCKVZ35T4oMJAYQTCDN+p1zYHF
	 aGelYvBucSYvWw+f+vXP0X69fcQuQzEpoIeLhyTOCvmwwIkSqDn4eOfoRLRKibQ9eJ
	 j2FhbUJceDGLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B10B6E33083;
	Fri, 25 Aug 2023 16:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/7] BPF Refcount followups 3: bpf_mem_free_rcu
 refcounted nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169298162472.7831.6539288842422036618.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 16:40:24 +0000
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
In-Reply-To: <20230821193311.3290257-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 21 Aug 2023 12:33:04 -0700 you wrote:
> This series is the third of three (or more) followups to address issues
> in the bpf_refcount shared ownership implementation discovered by Kumar.
> This series addresses the use-after-free scenario described in [0]. The
> first followup series ([1]) also attempted to address the same
> use-after-free, but only got rid of the splat without addressing the
> underlying issue. After this series the underyling issue is fixed and
> bpf_refcount_acquire can be re-enabled.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/7] bpf: Ensure kptr_struct_meta is non-NULL for collection insert and refcount_acquire
    https://git.kernel.org/bpf/bpf-next/c/f0d991a07075
  - [v2,bpf-next,2/7] bpf: Consider non-owning refs trusted
    https://git.kernel.org/bpf/bpf-next/c/2a6d50b50d6d
  - [v2,bpf-next,3/7] bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
    https://git.kernel.org/bpf/bpf-next/c/7e26cd12ad1c
  - [v2,bpf-next,4/7] bpf: Reenable bpf_refcount_acquire
    https://git.kernel.org/bpf/bpf-next/c/ba2464c86f18
  - [v2,bpf-next,5/7] bpf: Consider non-owning refs to refcounted nodes RCU protected
    https://git.kernel.org/bpf/bpf-next/c/0816b8c6bf7f
  - [v2,bpf-next,6/7] bpf: Allow bpf_spin_{lock,unlock} in sleepable progs
    https://git.kernel.org/bpf/bpf-next/c/5861d1e8dbc4
  - [v2,bpf-next,7/7] selftests/bpf: Add tests for rbtree API interaction in sleepable progs
    https://git.kernel.org/bpf/bpf-next/c/312aa5bde898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



