Return-Path: <bpf+bounces-10444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F67A7973
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8B1C20962
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1A14F7F;
	Wed, 20 Sep 2023 10:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C09F9EB
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D86C433C8;
	Wed, 20 Sep 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695206421;
	bh=vIUxhOIoPqmjcqUczspWLk5tFZ+1LbQiOnzDJ4R7L+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QZe+8RPKFoldBpAWGzpLUKKK4hr3aQcplxfqZMop7e+nX/iSuk8u/Uz+lYDOzKmpL
	 KJe0Uw8XHd6niFF8APnc6jRbat5fxheXLfKUvUN18ooCedu4pCnT4aNjYcNgzEuKEL
	 80Yv7rc+s89xg+pXisAn3p8WFAJIExomJYB0fzKqlRvzIqyYexbHDDun+eVTPSypjW
	 0pOdRhdanbmYdsPhqExGC+t1xRSCy4iXe++zT8S7GJiqjRDlZC1Ee0+s0wsmZeWvXK
	 ZahCkODSltd7HaJmuGWrxIjoMjtYBAsaJ8QuvHal0yE0DiBI3Yl59LpbaDNeOnR/wE
	 23xNvPhSus4jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99BFEC41671;
	Wed, 20 Sep 2023 10:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: unconditionally reset backtrack_state masks on
 global func exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520642162.20971.15535046661547364032.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 10:40:21 +0000
References: <20230918210110.2241458-1-andrii@kernel.org>
In-Reply-To: <20230918210110.2241458-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, clm@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Sep 2023 14:01:10 -0700 you wrote:
> In mark_chain_precision() logic, when we reach the entry to a global
> func, it is expected that R1-R5 might be still requested to be marked
> precise. This would correspond to some integer input arguments being
> tracked as precise. This is all expected and handled as a special case.
> 
> What's not expected is that we'll leave backtrack_state structure with
> some register bits set. This is because for subsequent precision
> propagations backtrack_state is reused without clearing masks, as all
> code paths are carefully written in a way to leave empty backtrack_state
> with zeroed out masks, for speed.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: unconditionally reset backtrack_state masks on global func exit
    https://git.kernel.org/bpf/bpf/c/81335f90e8a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



