Return-Path: <bpf+bounces-9691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6EB79AB41
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9B81C20971
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFB5388;
	Mon, 11 Sep 2023 20:40:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A420EB
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 20:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2585DC433C8;
	Mon, 11 Sep 2023 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694464829;
	bh=nM9qdqvpiaAiiZFd6CGwCiL85z9XzfxRoxta9lY8W/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OmK9pbxJM7RFJYD2owYX0Q5NH0xWS5EXLCNlLkjy5C9MteLhn2ZeccKg9/0qFbYMa
	 DteFCgUAHkF/llUigQ4/ZnBosi+JKAYZ+yRENuSVB9FnRmUxlhsLtDS1x5bvgHctRV
	 Zrq+LfchF9f8DMX8oV7TyUOV4Y5E8gmF1CYXsJMxTHsjgxlT4GONEhB+vfGPACEtZy
	 1EIQylc43xeqcP+GNKUk84gupRiqvPeniM8D8CuVADaot9xnQc8kkVThflOK+yau/n
	 PNL4pEGFqVQ3VCcBKe3+U6w127glw7O+DHm2AOi6h2cl/WCXLkQECKnSpFvIHmzrsH
	 Dm0quh/kA9+UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06FABE1C280;
	Mon, 11 Sep 2023 20:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: clarify error expectations from
 bpf_clone_redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169446482902.4154.9987772850452271859.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 20:40:29 +0000
References: <20230911194731.286342-1-sdf@google.com>
In-Reply-To: <20230911194731.286342-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 11 Sep 2023 12:47:30 -0700 you wrote:
> Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
> packets") exposed the fact that bpf_clone_redirect is capable of
> returning raw NET_XMIT_XXX return codes.
> 
> This is in the conflict with its UAPI doc which says the following:
> "0 on success, or a negative error in case of failure."
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: clarify error expectations from bpf_clone_redirect
    https://git.kernel.org/bpf/bpf/c/7cb779a6867f
  - [bpf-next,v2,2/2] selftests/bpf: update bpf_clone_redirect expected return code
    https://git.kernel.org/bpf/bpf/c/b772b70b6904

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



