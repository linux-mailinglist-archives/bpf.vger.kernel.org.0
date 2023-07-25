Return-Path: <bpf+bounces-5880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C37624CF
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED19C1C20FA1
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66282275DB;
	Tue, 25 Jul 2023 21:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5026B83;
	Tue, 25 Jul 2023 21:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21672C433C9;
	Tue, 25 Jul 2023 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690321820;
	bh=C3N78LdzzkhdNILLsvGYjZB2EMY9TDfg329d9jBl8Ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czy0i+JPIIi3JSvDWzDUjezXc599XnsFAQdGdlXx+D4+98e+tmYq6opJQNxXQr8c9
	 dnNhjM9bNbTUm3ZBR9d0csYALAIVJyaXpevris3sOg3mmZeuuIc8fm3HdRsHSpCR5B
	 h0fJnVQPY9wFzDSTInEWvBgNXL9lRcRYNqzzB6OobOmPESXRJQr6wwrD+c7hk0E2pm
	 j0bR4ANHQX+AeaYTuLaVZERIKR8x1Sgx1kwLOks9ywwDbatyqt8MktdZArB8+8DdUM
	 2gpbpMOaeBYf5IGu3xygU9SegVQpjYc162AQzMfti9q/acfIwRkcbmnk4qym6G+/FX
	 gOPJVDOHSAJIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0522BC59A4C;
	Tue, 25 Jul 2023 21:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] selftests/xsk: Fix spelling mistake "querrying" ->
 "querying"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169032182001.22369.1559368522725545561.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 21:50:20 +0000
References: <20230720104815.123146-1-colin.i.king@gmail.com>
In-Reply-To: <20230720104815.123146-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, shuah@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 20 Jul 2023 11:48:15 +0100 you wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] selftests/xsk: Fix spelling mistake "querrying" -> "querying"
    https://git.kernel.org/bpf/bpf-next/c/13fd5e14afa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



