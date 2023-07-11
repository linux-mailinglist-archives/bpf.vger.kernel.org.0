Return-Path: <bpf+bounces-4779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE874F615
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089E32813AB
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110151DDD1;
	Tue, 11 Jul 2023 16:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE2443D
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4869C433CA;
	Tue, 11 Jul 2023 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689094226;
	bh=9MiOiMOs5+VWea1gr0KqPNVMAfzAFLnJIKEhFO9iDHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eqxhl31OaXhY7xJQ6BJkKiX2EAm/Afe8InXwasdaLIlnG79zKqAay5ozoRpKJDPC8
	 fkHLW2UxEm0NsmOO5Z2WlT/qgtJGqTmP51XTkLsJLhWcdMQIpVOY8eCWjdHfIh1Fzf
	 YHcbBZYPVG/lTQHHwLQLIuUki+seaiBLXuepvPOxW7dy66ho00eRFLQK3/fJDG1znd
	 P1RksMeavtW0skt166OofHUgR709eKQUOzu11AdnQvv2HFZmxoSaGFYSotEQ828VTV
	 w7eUJpeDGuTg3igHvtQM7w8AkRBFm/burtNhXUoLMg6USv2N/eBgvry7cs2rzeYMCe
	 RHTB42SgDCQoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B86A6E4D021;
	Tue, 11 Jul 2023 16:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] libbpf: remove HASHMAP_INIT static initialization helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168909422675.4543.5041944985378816466.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 16:50:26 +0000
References: <20230711070712.2064144-1-sanpeqf@gmail.com>
In-Reply-To: <20230711070712.2064144-1-sanpeqf@gmail.com>
To: John Sanpe <sanpeqf@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Jul 2023 15:07:12 +0800 you wrote:
> Remove the wrong HASHMAP_INIT. It's not used anywhere in libbpf.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
> ---
>  tools/lib/bpf/hashmap.h | 10 ----------
>  1 file changed, 10 deletions(-)

Here is the summary with links:
  - [v3] libbpf: remove HASHMAP_INIT static initialization helper
    https://git.kernel.org/bpf/bpf-next/c/a3e7e6b17946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



