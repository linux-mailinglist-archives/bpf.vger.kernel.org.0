Return-Path: <bpf+bounces-29784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2DB8C6B18
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F85284EEA
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE65B4CB30;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8wYuvOr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F347F4A;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792292; cv=none; b=ggMpUj2kS2aMnennFtxjgv3yJMyOO++ULDID1w9FsCDQ6M7pFWmCIPd/WFTnyrkffdBL3KEBjVJAMwGNYXHBdSnmuHOZAtOKPRjtsf1yZ8niojG6yU4c9Dc6QP4gdPmOYhsKSghIKBspClebNhqUNn1c5cJ/UAVeThReSX/tTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792292; c=relaxed/simple;
	bh=EUv6Q0T3GbOdxQR7AOx78ZIeKRWWeELUi2KPEKQmIIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AMZnDLWf52FmhmTdJEZLOFT5nzYD0q75KrQnSYBapUbeah6TtJ18eWhy7unIaad8qVXCOC9IdZbscPkxuWDakd8hv1LJPGxZxdu8V0OElrQ7ydL+35K+oRyME5bY96Q+Icd4Q4lLvbBqkY0JH2zZlJXI5BWbmhFOXVO8JbjDcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8wYuvOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 259C2C32786;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715792292;
	bh=EUv6Q0T3GbOdxQR7AOx78ZIeKRWWeELUi2KPEKQmIIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o8wYuvOrdVCSi4CN6kJsW/2oTFYznPs32qdxz0e4BsIuGNO8ZkWGYAhBzFt2cv7/A
	 Zv4X7rfCiMrFMSfKJPybufmk2Q4e6rUDMtwoQFX46lWbA3WDPLwFSIYSrBp+0ETsUz
	 Yq/KeiQruklAq/dpIkmkwJY/NDXwGELhy/VIIoMn3t65xgYxM73CtQncLqZkOKlLGz
	 M2tam3eMD3AXV8rimvCIzsf71JISL0U7HQ/EY2BANfnk11EY40brVj7t3QNf4fiFyv
	 eiTtyA+X25cO4/qDYusjIepUyrC0JwemH0wlR8RJLNWckcDDPpjp0xV//UOk7bkv+K
	 pvEUATChPpDPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14F1EC43332;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] bpf: save extended inner map info for percpu
 array maps as well
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171579229208.15564.10606641897493999885.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 16:58:12 +0000
References: <20240515062440.846086-1-andrii@kernel.org>
In-Reply-To: <20240515062440.846086-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, torvalds@linux-foundation.org,
 kuba@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 May 2024 23:24:39 -0700 you wrote:
> ARRAY_OF_MAPS and HASH_OF_MAPS map types have special logic to save
> a few extra fields required for correct operations of ARRAY maps, when
> they are used as inner maps. PERCPU_ARRAY maps have similar
> requirements as they now support generating inline element lookup
> logic. So make sure that both classes of maps are handled correctly.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bpf: save extended inner map info for percpu array maps as well
    https://git.kernel.org/bpf/bpf/c/9ee982290831
  - [net-next,2/2] selftests/bpf: add more variations of map-in-map situations
    https://git.kernel.org/bpf/bpf/c/2322113ac9d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



