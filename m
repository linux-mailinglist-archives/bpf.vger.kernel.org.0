Return-Path: <bpf+bounces-10173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2EB7A24FE
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0CA1C20A71
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822D15EB8;
	Fri, 15 Sep 2023 17:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36515EA0
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2522C433C7;
	Fri, 15 Sep 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694799624;
	bh=Qwn1f5/rsqInJGnT3kvhHm67i8tGW7rDDoDw8C38yaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fn05XB5nhXxP030HEXxGF3WT+XQ6bNv211OcY7/R49+b4C1CzOo4S66zAwkns/SO5
	 mPvIh570BmsTf12i939MSiVvwhHANkExbAaxO5PDa3S7b/Yysde0u6HmTN9PdS5+Sh
	 Kn8TCDr4jKqkhyvycRopbxGLvkVL7ATVhDaYBqCqGM/Q19QxQvSzodUq2U9sjMM/Pm
	 kDMusYtJppDoE1nB+U9LMTd9/w827cpayd2X1SDNjxTfPT4mlJmGhnZ8wL/J7XfJMt
	 jwIZcjmp/1z9AgUh+Is0j/8vIAIGlCe0xumQdAnv1Dwe06LEoWR071LZMjdOFTpBPd
	 NRM5ACpGva1gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4F81E22AEE;
	Fri, 15 Sep 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Skip unit_size checking for global per-cpu allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169479962473.14368.7351881261068903128.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 17:40:24 +0000
References: <20230913135943.3137292-1-houtao@huaweicloud.com>
In-Reply-To: <20230913135943.3137292-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 sfr@canb.auug.org.au, biju.das.jz@bp.renesas.com, houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 13 Sep 2023 21:59:43 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> For global per-cpu allocator, the size of free object in free list
> doesn't match with unit_size and now there is no way to get the size of
> per-cpu pointer saved in free object, so just skip the checking.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/bpf/20230913133436.0eeec4cb@canb.auug.org.au/
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Skip unit_size checking for global per-cpu allocator
    https://git.kernel.org/bpf/bpf/c/dca7acd84e93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



