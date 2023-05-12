Return-Path: <bpf+bounces-453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40ED700F1E
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D640281CB4
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3723D61;
	Fri, 12 May 2023 19:00:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98923D4D
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 19:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17C05C433EF;
	Fri, 12 May 2023 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683918020;
	bh=X0JitWnD4B51LMzqYZL/bmFvqHS/5bZ7uoLy7rUItZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXkdysSzQ1Tw/xElzVEPJXWzgo+Y2yYCvPBcoNYc8ng/JKwBZUN7RNgyRwgNxIU+c
	 f974+UZOfaHzY88nz1iUWaz5o5mBWyBiwQSKJgXRw1olfoPjvL6ooGmoUNI8Mfc8fS
	 NF6C+clUMEFz96kVNcVpiPwP3s0sPuzWO/bzJpUCwo9KoGnP0jkPWPKN6QFHgrlO8O
	 eTtoqr3qf7fuRKVL5qo78wps9TsoWat4ImYDqDIbNRxXWjcZRv89oh3zFylnwOjLO8
	 a6c7+lWu1ac1BodkNPYNJcC8a+6uOGAG1lpTybqaKwJJpbW7HNb7s07VHTftJC9YN6
	 Pr+2TQUzsEvoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5C3EE26D2A;
	Fri, 12 May 2023 19:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168391801993.32766.1241331761103876503.git-patchwork-notify@kernel.org>
Date: Fri, 12 May 2023 19:00:19 +0000
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
In-Reply-To: <20230510130241.1696561-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org,
 jolsa@kernel.org, laoar.shao@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 May 2023 14:02:41 +0100 you wrote:
> v1.25 of pahole supports filtering out functions with multiple inconsistent
> function prototypes or optimized-out parameters from the BTF representation.
> These present problems because there is no additional info in BTF saying which
> inconsistent prototype matches which function instance to help guide attachment,
> and functions with optimized-out parameters can lead to incorrect assumptions
> about register contents.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
    https://git.kernel.org/bpf/bpf-next/c/7b99f75942da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



