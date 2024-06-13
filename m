Return-Path: <bpf+bounces-31996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25EF905FE0
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F51F2221E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB8C147;
	Thu, 13 Jun 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx54w+3u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7A3D62;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240431; cv=none; b=RWiyaC12KBn2rqtgwNRU0S+oSeP+PCJZG/uYqs9f0BsH/3VEm7Oxnq0i3gS3fAUVlf8uC99mH8/nBhG763RtmAkZaA2q3jBruiYDidWB4uJXTF2bFjE4EQ4iq07sJ93RmebzdgisAcfpHVvGz1tiYFSezZn+qK6uyd0xBV+kXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240431; c=relaxed/simple;
	bh=snrbHhwkywdB2nwXGFUJFLEdtmurn2wUbZ9Ec4+DStY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CoB0TXcDBcXZnR6czK3XD6K8LPvE6B9ZriHoVeYTSKqmpcg7gNc0gG0D+5T52zaq7U3JS/oBp+lo/79QKftTOUNZWTiiKgOjvK165BxblWi8cLaXwShjRJJK+i0aF8B02cUlJUUOwCSBhmRipBf9IakVdLinP4e/SoBwqGXgePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx54w+3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF286C4AF1C;
	Thu, 13 Jun 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718240431;
	bh=snrbHhwkywdB2nwXGFUJFLEdtmurn2wUbZ9Ec4+DStY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lx54w+3ueWNlFTqNtmfevTgllHnk3novugFC6UoRH/qLcf2Mhf/VfUkIIGc7lXPu9
	 d4TzmIMRiohgP80fAQSMlflTDwRz1arq/NuWX2aFtNqRN6FicjEa8hjSuPOMsyxMyD
	 8ob7zSzlRl7LqV3ttKxDaPQH+cs0KpfSzFtD1v9qhaTaE+IRxoh2G1yMxgFU6TTLjo
	 oZQRid0KAa1yk+U8kQDtjuaCjUvrR2xDxiMC0m9rMS7zeSTsPiFCf6UtyrFc5MttOo
	 KkSpxXPJGPEPh/SwVdoL15/nkoQgfLIZNpwZ1KveRDTfJyu0epOik8YVorBTx0htHt
	 w/uqKC27VN3UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC45FC43613;
	Thu, 13 Jun 2024 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: mailmap: Update Stanislav's email
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171824043083.29237.5483891725659346711.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 01:00:30 +0000
References: <20240612225334.41869-1-sdf@google.com>
In-Reply-To: <20240612225334.41869-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 12 Jun 2024 15:53:29 -0700 you wrote:
> Moving to personal address for upstream work.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] MAINTAINERS: mailmap: Update Stanislav's email address
    https://git.kernel.org/bpf/bpf/c/26ba7c3f139f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



