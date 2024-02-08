Return-Path: <bpf+bounces-21462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5AB84D740
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F1C1F236B9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C351EDDA9;
	Thu,  8 Feb 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCwGBHL0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436005381;
	Thu,  8 Feb 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352827; cv=none; b=E/cb+b+ge8ITYA9aSFy170+LRDmHVqWyv9hoA4RsMAyNZ9Jt4JwFDQxPsGMSegJyqrn4GHMvHoA4LpEUdLpLVO+TwgJ6lmRwdTGnix/jM1flQMgfh83ibYUqJAue8/MsQPLd9kxwdMYzarPh9WEdSKRQhRDobnEqlIbjEj0Kmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352827; c=relaxed/simple;
	bh=OTsPfX3ootmJaowlcdqnHuUcVRwW2q7b+EVL2LbOUqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqzTk0Q/oC+EC5xpTVk1yEdBf/slE1EL+qW1Sg7godAqRNhXA/WjiwmJ3aHWngt05Zn3vyGULjfXcp6A0YrpVIb8iOccjcvHgCSauUNzK6Alj434PIvDydBUIaKlitRkvWp40V4aDNKh/3F2CN/QYbwcyXqtT7QtBN1LXvoYiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCwGBHL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6311C43390;
	Thu,  8 Feb 2024 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707352826;
	bh=OTsPfX3ootmJaowlcdqnHuUcVRwW2q7b+EVL2LbOUqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCwGBHL08qx6QqevaJWrp3ZDVg2rswWEEeTyL/h6nNAQ3WVI8yhJ+uXfPK5n9eLsJ
	 Ej9g9cdHHimG/aqYWUj9PYlvbd3OzEV5mbGgH4Wp/2QRFx15P7alDUTcpiWsGjGtSh
	 Tppru6bgqvbG8Mcmw9IZs+eDEneHLDwlVCqjFpKnFn+KvPUMtQwr24UFVBDEJ1Ndmr
	 IsR7H0Utzk0YyTYBM5oQye8b/NsLhFfi+oyH/TIPzY79rFNIxgg+8/g/knQ2uuwDos
	 seaWreoJegRQO9FEkNZvTyhW2ecmQb9nmSG7HBugq5jgeXQsh9nblrQA/WNl1yJn/O
	 IZsGMksu8bs6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B96DD8C96F;
	Thu,  8 Feb 2024 00:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: merge two CONFIG_BPF entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170735282656.22797.7077136793931051154.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 00:40:26 +0000
References: <20240204075634.32969-1-masahiroy@kernel.org>
In-Reply-To: <20240204075634.32969-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, andrii@kernel.org, haoluo@google.com, jolsa@kernel.org,
 kpsingh@kernel.org, martin.lau@linux.dev, song@kernel.org, sdf@google.com,
 yonghong.song@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  4 Feb 2024 16:56:34 +0900 you wrote:
> 'config BPF' exists in both init/Kconfig and kernel/bpf/Kconfig.
> 
> Commit b24abcff918a ("bpf, kconfig: Add consolidated menu entry for bpf
> with core options") added the second one to kernel/bpf/Kconfig instead
> of moving the existing one.
> 
> Merge them together.
> 
> [...]

Here is the summary with links:
  - bpf: merge two CONFIG_BPF entries
    https://git.kernel.org/bpf/bpf-next/c/e55dad12abe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



