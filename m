Return-Path: <bpf+bounces-38830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FF96A814
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE41C243D6
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E71D0177;
	Tue,  3 Sep 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixWllNYl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE39190463;
	Tue,  3 Sep 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394229; cv=none; b=GzgSBe8hmz3tiyc7ZboncVx1lDIJgvoWgMaplF6GTkHN55Vq5BVq6KZpXIQXx48yn+jcxWij+iQ0iwBv7OqmizOSRzvNI/c91HGTNTLnNhMnMAG4GOELLp6lnDWHO85u+TCL/5EQKsPVUg3Bd0G9EUHaToeDBVsXosQrUe6O4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394229; c=relaxed/simple;
	bh=Gw0IBZUNC2LELFePtOPc07moZnDlfXuC4n8LfF7pvzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h+UrU/Y2bNYQJWi0Bz8ez9y3yXSfhm8YI445+fv5vrolBlzdbTTfoavV7niAd4OblhE7j1pCaXFAaSMHJSnu/bPUMI+oMoVuIgbKeRCVIt9eSC/IZbOY648M/ZhuiIAmuQk5pdT7XemRpruGYqzC/VGeZ4qBMScO0UfTnXg60dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixWllNYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4384FC4CEC4;
	Tue,  3 Sep 2024 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725394229;
	bh=Gw0IBZUNC2LELFePtOPc07moZnDlfXuC4n8LfF7pvzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixWllNYlPxV1drLcJ6si72tTxEd7GRY8zYsO2uGb8/oFrVS2IZ9nQD7XN5xS9b/GY
	 JBSuk1ELBOIp9Ik9gy+7U2jNl7+xNpRRhSNOd9YSUl4XrTCizUuzKmSVJiwSsXZBqY
	 UXHmJMmDbeiOuIdC1XCwdNTyc2cxZKMNYlazw/wmSV2jmyzQ0iGUDsDl0EH8g/fOFP
	 9vGwg2CBV2lKNO41vooZQ/XlEF5+0zPTlG4gV9HOM2JyFkyFC5F/9RehYKcgYnTNA9
	 2TH7pHX7RuO/qrhuMw2ctg4xypmAh05jlDWZyKB9BclnSUq4OuSOYHAXjCdvJOvSiJ
	 Ybark54rrOPag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342A63805D82;
	Tue,  3 Sep 2024 20:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] bpf, net: Fix a potential race in do_sock_getsockopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172539423002.426047.5750436407367309589.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 20:10:30 +0000
References: <20240830082518.23243-1-Tze-nan.Wu@mediatek.com>
In-Reply-To: <20240830082518.23243-1-Tze-nan.Wu@mediatek.com>
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 sdf@fomichev.me, alexei.starovoitov@gmail.com, bobule.chang@mediatek.com,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, kuniyu@amazon.com,
 chen-yao.chang@mediatek.com, yanghui.li@mediatek.com,
 cheng-jui.wang@mediatek.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Aug 2024 16:25:17 +0800 you wrote:
> There's a potential race when `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` is
> false during the execution of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`, but
> becomes true when `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is called.
> This inconsistency can lead to `BPF_CGROUP_RUN_PROG_GETSOCKOPT` receiving
> an "-EFAULT" from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`.
> Scenario shown as below:
> 
> [...]

Here is the summary with links:
  - [net,v5] bpf, net: Fix a potential race in do_sock_getsockopt()
    https://git.kernel.org/netdev/net/c/33f339a1ba54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



