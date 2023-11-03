Return-Path: <bpf+bounces-14086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8EB7E08A7
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FEF281F32
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767241B269;
	Fri,  3 Nov 2023 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFRV9H8L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46B33E2;
	Fri,  3 Nov 2023 19:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D845C433C9;
	Fri,  3 Nov 2023 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699038024;
	bh=rpGeOHLL0JHWlA5DsJLeaXyHn/UF1g1QcCI791EnjEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qFRV9H8LTJuO478ux/Y3iwirW980PnFJtW4oKNKAcGW9OfLNbRrAyi/wJ5MkLXLqw
	 DxfqeVzNRJtE2PBi4r5tgTGeQ35HIcJ+Z5pSksL0IVMj7q1LzmwclQcrLU5cp8aFmV
	 LYxqWcOtCFErqzDFGGn5GQsO4+zwhcXotIdZVYn2yMsq7XDRb9MWjPLLE0xSMnxdjv
	 1eDg5fm0qDS4w7E394cLFRqk67QJxHuJEmV2oF5iJvVpyrA+skNjDx13LoGNIqOMoZ
	 Ds0EQzcIqrD4FzvAPEqG3dHKC/HDbiAgAKFSHefOkrxSpcy6AMSbW9XobHqiiQRI6j
	 RNUTOEpHibufA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E81EBE00085;
	Fri,  3 Nov 2023 19:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: fix prog object type in manpage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169903802394.13764.13691662419982712025.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 19:00:23 +0000
References: <20231103081126.170034-1-asavkov@redhat.com>
In-Reply-To: <20231103081126.170034-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, jsnitsel@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  3 Nov 2023 09:11:26 +0100 you wrote:
> bpftool's man page lists "program" as one of possible values for OBJECT,
> while in fact bpftool accepts "prog" instead.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpftool: fix prog object type in manpage
    https://git.kernel.org/bpf/bpf-next/c/b94df28c9bae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



