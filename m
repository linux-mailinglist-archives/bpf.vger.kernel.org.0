Return-Path: <bpf+bounces-1936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727272474B
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A6B280FF6
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C12DBC5;
	Tue,  6 Jun 2023 15:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825823C74
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 15:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78AC0C4339B;
	Tue,  6 Jun 2023 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686064220;
	bh=bQr/eFi4VULMVyUdMjxoiN5haOdXvfPwHaB7Lt8UCr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h5IqtCCtOytUdbR9JJjXMWJz2mlIJwkzyrNE0HTSTYpjQ9z/VEch8Qm2FK4D1aj7A
	 gyPHXzrj70U209T6jg0mpUMybxtkQvQLhNW6BR7MZscz6RPkMdRWFv2Ra9Lb+KrZKv
	 Ph8p3GzKqgtQwcdJKXmVqDjCY6halmlRMXOnlhi2shOns8JHou24griY9gZHXwLs5Y
	 Gbc1OeqArF9E+L8Adfx8WxxmOyXSBZcGoWfyACGd1CDoArbLI3NecS4Whei8SQSEhK
	 4+/BsHD9dvdfDX4ILfu+QUwoyoxT9Kl/JtD6hYFciAwGlt2w7fabuvhv9NqS145kOi
	 yFGEQgJGgNFZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59F4CC4166F;
	Tue,  6 Jun 2023 15:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] bpf: cleanup unused function declaration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168606422036.10567.7750110941195035658.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jun 2023 15:10:20 +0000
References: <20230606021047.170667-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230606021047.170667-1-gongruiqi@huaweicloud.com>
To: Ruiqi Gong <gongruiqi@huaweicloud.com>
Cc: andrii.nakryiko@gmail.com, sdf@google.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
 xiujianfeng@huawei.com, gongruiqi1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  6 Jun 2023 10:10:47 +0800 you wrote:
> All usage and the definition of `bpf_prog_free_linfo()` has been removed
> in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
> jited_linfo"). Clean up its declaration in the header file.
> 
> Signed-off-by: Ruiqi Gong <gongruiqi@huaweicloud.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Link: https://lore.kernel.org/all/20230602030842.279262-1-gongruiqi@huaweicloud.com/
> 
> [...]

Here is the summary with links:
  - [RESEND] bpf: cleanup unused function declaration
    https://git.kernel.org/bpf/bpf-next/c/aa6182707a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



