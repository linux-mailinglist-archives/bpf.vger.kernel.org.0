Return-Path: <bpf+bounces-538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DFF702FB7
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B081C20B37
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B3DF4C;
	Mon, 15 May 2023 14:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1CDF57
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACB00C433D2;
	Mon, 15 May 2023 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684161020;
	bh=mFvV9WikoapF0c2jwsBseN0eXfIRdKw6KrzrenDtVGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dmAjBwHZU0REME7syhrLXIXNLBLQmfW3ksmrgfvl4FTSx2y3n+M2iFMbLAOILYr9a
	 KKJz5/xe3pp6kVJsuiNYMCvjbNXqlaMNdKWyQjrluBarSKf/cxepXUGYDGQ0KJ5b4+
	 TzIVXG5sdvZjCUQv6jznXJ0joPpxTMlRl5p+ymSG2ps/EQppb7cCo1GfAJ2JOUORKm
	 cMEfDcbY5AKJ31+Crjq+ujE+u+rC/4616Giwy9ZxTgu4vQM4HUC/lMsAvtq81ZxhKK
	 7vmI8SpExuVs5G8WDAW3rmSwYqySODPOBk2iDd/ZhfiUteTab35482fHB6STeOFxaO
	 avZA4zrZmdhlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CF30E5421B;
	Mon, 15 May 2023 14:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove anonymous union in
 bpf_kfunc_call_arg_meta
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168416102057.4488.17383948571779879884.git-patchwork-notify@kernel.org>
Date: Mon, 15 May 2023 14:30:20 +0000
References: <20230510213047.1633612-1-davemarchevsky@fb.com>
In-Reply-To: <20230510213047.1633612-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 May 2023 14:30:47 -0700 you wrote:
> For kfuncs like bpf_obj_drop and bpf_refcount_acquire - which take
> user-defined types as input - the verifier needs to track the specific
> type passed in when checking a particular kfunc call. This requires
> tracking (btf, btf_id) tuple. In commit 7c50b1cb76ac
> ("bpf: Add bpf_refcount_acquire kfunc") I added an anonymous union with
> inner structs named after the specific kfuncs tracking this information,
> with the goal of making it more obvious which kfunc this data was being
> tracked / expected to be tracked on behalf of.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove anonymous union in bpf_kfunc_call_arg_meta
    https://git.kernel.org/bpf/bpf-next/c/4d585f48ee6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



