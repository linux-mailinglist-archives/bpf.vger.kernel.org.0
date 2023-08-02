Return-Path: <bpf+bounces-6754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CA76D93A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2101E281DB8
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541911CB6;
	Wed,  2 Aug 2023 21:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B806D2E8
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A35E8C433CA;
	Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691010621;
	bh=BdosRve/1vfQeMLTfUBO5k42yoYp/cyiP43a62UOc6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqumx8W9D+/hwn6ORB/oyhkDY+eEmmWfjtjnUOFva6X0C17qbyxEJy777dS6Fm8zA
	 ykk7FWf8KXUoXwWFQeIOvQ9QwPpPj8wt5gTC6+zB8KOQSn55j7SwluR6zsSLMY/h8t
	 hjPBsKynmu6iTAGVx5oriJ5zATy9fI07eKwAH09xduV5rchomigR6+7Iwv7AeXAEru
	 DxU19I7qVYVy+hX5nq3bAYqmPCpO0tiyYtHtKlMRXhUi3Xi7dzHaz0wE/grqEneCEh
	 2AZSjMTpxtpLhnmk0pWadz5VJq64hSTmUXkXYNHC2ZK5GBRiS1IdgOHGdxZChG1Btd
	 1pdaq/LBQ/Pbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C8C4C6445B;
	Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: fix typos in Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169101062157.23031.3643802072740316226.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 21:10:21 +0000
References: <20230722065236.17010-1-rdunlap@infradead.org>
In-Reply-To: <20230722065236.17010-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, liuxin350@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Jul 2023 23:52:36 -0700 you wrote:
> Capitalize ABI (acronym) and fix spelling of "destination".
> 
> Fixes: 706819495921 ("libbpf: Improve usability of libbpf Makefile")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: Xin Liu <liuxin350@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: fix typos in Makefile
    https://git.kernel.org/bpf/bpf-next/c/94e38c956b97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



