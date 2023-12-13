Return-Path: <bpf+bounces-17736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC3C81234E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D463A1F21A3A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC283AF1;
	Wed, 13 Dec 2023 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OowHkdkU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5D77B22
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 23:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38DBAC433C7;
	Wed, 13 Dec 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510823;
	bh=GyvOzIti8ZlQYgXZjZ/LxZzVtNdONjyoObkwty4XOoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OowHkdkUE9L71B3wVZIkerzdS3BlMRCuapI6GzBy8VxSTCt0iEdi/zuBeR2BjVCnx
	 CijP0u/7RBme5FZLj8DK6+8MCTtCkfQM2Lhj9ZDP6loi54s2jluiAWkQa3n12OKVEb
	 Pq9IzwYSGmv+3iG3A7ltZUy7/+d7oiQndJtNArpI/FZVPCKgdg+QLwRMg3/OkzDqFG
	 DZz3yxdoci+mmnlKbrIOTWYeSHjQQdsDDVPkOF55bga93+RXcDFAEp10St10JgOQy8
	 9HPV3BGHOVpYd0kthLJsS2dyotrxss9w+jRLOV/qCTUKib0D3/Z52Hfh3gjdLi20a+
	 HTQ+XCSFlUleg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21A7EDD4F00;
	Wed, 13 Dec 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf: Support uid and gid when mounting bpffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251082313.7030.6702563453177727176.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 23:40:23 +0000
References: <20231212093923.497838-1-jiejiang@chromium.org>
In-Reply-To: <20231212093923.497838-1-jiejiang@chromium.org>
To: Jie Jiang <jiejiang@chromium.org>
Cc: bpf@vger.kernel.org, vapier@chromium.org, brauner@kernel.org,
 andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Dec 2023 09:39:23 +0000 you wrote:
> Parse uid and gid in bpf_parse_param() so that they can be passed in as
> the `data` parameter when mount() bpffs. This will be useful when we
> want to control which user/group has the control to the mounted bpffs,
> otherwise a separate chown() call will be needed.
> 
> Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> Acked-by: Mike Frysinger <vapier@chromium.org>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf: Support uid and gid when mounting bpffs
    https://git.kernel.org/bpf/bpf-next/c/750e785796bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



