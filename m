Return-Path: <bpf+bounces-454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26145700F2E
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D11C21241
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B182723D66;
	Fri, 12 May 2023 19:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955B23D43
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 19:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A05A8C4339C;
	Fri, 12 May 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683918620;
	bh=SQuKwrtt+nEUGJpKjW8c0JPDuqypL113lmTuLJDwKig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pi2yJe/VCf9TkXcmxiiAIKqhLAtZ9mN6kxniCo1NEF+Jxcs9zIIw9ivZs3qn94x41
	 Y5ad3LWHkhKGijmQNfE6W7w8vcQYhee8Nqh/VqzsmWY6ZDj3MMH/egRQE3+/KGzyHX
	 fYuhuxXqcOqpR1RAcCl2PaeJIDAY1o/W3zgETSSPfTHWVmjPln0vTGkmcmGgL6266o
	 4jyx1XlNKZsCXEMsa9DteXbvHoKwFel4IgCsZviA3pcrBjgM7HQfH7zOt0XOTABEwH
	 mpoKxfnlq3U2+KRuXkjohqoabd1FaYd2xTyXk807NjPIRW5Z2aLtxY/3C9MyFEVZcZ
	 b2fm4gor2MejQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C251E4D00E;
	Fri, 12 May 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Address KCSAN report on bpf_lru_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168391862050.6084.8499223588458681634.git-patchwork-notify@kernel.org>
Date: Fri, 12 May 2023 19:10:20 +0000
References: <20230511043748.1384166-1-martin.lau@linux.dev>
In-Reply-To: <20230511043748.1384166-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com,
 syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 May 2023 21:37:48 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> KCSAN reported a data-race when accessing node->ref.
> Although node->ref does not have to be accurate,
> take this chance to use a more common READ_ONCE() and WRITE_ONCE()
> pattern instead of data_race().
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Address KCSAN report on bpf_lru_list
    https://git.kernel.org/bpf/bpf-next/c/ee9fd0ac3017

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



