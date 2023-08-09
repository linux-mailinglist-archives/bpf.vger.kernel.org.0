Return-Path: <bpf+bounces-7278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D083774FC3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 02:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C4B2819C4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 00:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83336D;
	Wed,  9 Aug 2023 00:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87247362
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4B67C433C9;
	Wed,  9 Aug 2023 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691540421;
	bh=KEvH3+b7kuYeVQWe6aTN19ry/olxY82t66djGgRmCOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K3YiVAcXw9TH4rnAmFUqzla3unLOraZKN1jYqR5pVDlAll+tsndyUeJCEvV1Go317
	 aURqyEZSlBkIKg4Ph9smgCvT/wxqj1PSxkGJXRehT98Z46UB0y87Q+qOx1IZlU9zQe
	 8P9TquVFyCakxaENk/uo9XsjoKxbgNyC+zOH2/zg6oYrdvT1P3fV9NSidcvV5OYCEI
	 80nGplZgMT7958xs3aTRxMwX71HsdeXrW56mA9m3ecu8nRCJkmlng7fmNX8HkTuU21
	 Rk5BgQE+426TqT22+TlksaR35avEvzDoYWalMZdUYh0P7HL/A2g/Mc8l+VsqOppAll
	 jqXQHNtLiT7FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCC27C595C2;
	Wed,  9 Aug 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: relax expected log messages to allow
 emitting BPF_ST
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169154042083.15967.1548393556107526816.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 00:20:20 +0000
References: <20230808162755.392606-1-eddyz87@gmail.com>
In-Reply-To: <20230808162755.392606-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  8 Aug 2023 19:27:55 +0300 you wrote:
> Update [1] to LLVM BPF backend seeks to enable generation of BPF_ST
> instruction when CPUv4 is selected. This affects expected log messages
> for the following selftests:
> - log_fixup/missing_map
> - spin_lock/lock_id_mapval_preserve
> - spin_lock/lock_id_innermapval_preserve
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: relax expected log messages to allow emitting BPF_ST
    https://git.kernel.org/bpf/bpf-next/c/898f55f50a00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



