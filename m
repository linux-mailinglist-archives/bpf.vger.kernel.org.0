Return-Path: <bpf+bounces-8971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7778D3C8
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC6280D98
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FCE1877;
	Wed, 30 Aug 2023 08:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C91852
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B24B1C433CA;
	Wed, 30 Aug 2023 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693382423;
	bh=us/CcTqEDDktbZAM7F7mJtPWO7A3gzB7r24c/SGVd58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eT0Iltsgo/l/dJkCJ/iQNr8c9qghPMAgma40yi56wb8oYM+pnAaY2oTPGFD8X6WqJ
	 A+d3hZ7O2cakmwssWUp2E1+84Z3wRioATZrFFCNNcIwMt3U+/sCH8k4Z6ha5uY3A+M
	 v7FEUKU4JLplmJHua93pafgIPBqBixkQFz2uIm6Wz07i2oeAuKfytkWZZ4MIrPMX24
	 OPJQZpx364qPKRfq0dVx3vRIoIjhocKpPtgbtKp0Y2G2HMjH3ozHAYWnESvSYUA/p+
	 mu5xD96v3HipiHBpm9cejBx9NmVZhe68AOtzDk3PergdoWl1ud5AbiGijFFkekEDBA
	 rcLIYW5byxg6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97CB1E29F3A;
	Wed, 30 Aug 2023 08:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/1] docs/bpf: Add description for CO-RE
 relocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169338242361.2642.14356576896820332828.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 08:00:23 +0000
References: <20230826222912.2560865-1-eddyz87@gmail.com>
In-Reply-To: <20230826222912.2560865-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 27 Aug 2023 01:29:11 +0300 you wrote:
> Add a section on CO-RE relocations to llvm_relo.rst.
> Based on doc-strings from include/uapi/linux/bpf.h and
> tools/lib/bpf/relo_core.c
> 
> Changelog:
> V2 -> V3:
>  - Small fixes suggested by Yonghong;
>  - Added ack from Yonghong;
> V1 -> V2:
>  - Small fixes suggested by Yonghong and Andrii;
>  - C example extended to include all 13 relocation kinds (Yonghong);
>  - Description of which fields are patched for which instruction
>    classes (Andrii);
>  - Details for BPF_CORE_TYPE_MATCHES relocation kind;
>  - Details for BPF_CORE_FIELD_{LR}SHIFT_U64 relocation kinds.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/1] docs/bpf: Add description for CO-RE relocations
    https://git.kernel.org/bpf/bpf/c/be4033d36070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



