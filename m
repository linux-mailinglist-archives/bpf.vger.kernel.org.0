Return-Path: <bpf+bounces-55196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8797A79915
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840913B6417
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28291F8921;
	Wed,  2 Apr 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shay3Qby"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FD1F874A;
	Wed,  2 Apr 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637199; cv=none; b=NgJ7tMrIxS8gTp2ssL1zFtotAv7MDCu9PauEO4SMEbdJDfpDESBlqAW6DuIFtwRaTocmgP30BFdV6jhgOgYyOrx4xRVHVre/e8xGeUxG5Pr6G2ag8YvRCZtCXmsLNQWXSWpac2uqc90J4VcGd3QofmEO6P8rs6wJZ2BPDEig1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637199; c=relaxed/simple;
	bh=d1Mp78QX2vOcjTcP1u20w/Jr7brr6ddMTAuwiaof3SE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pviLkNsd5+BI7HmwtHHqoC8aQeVDkEjAMn1LpjFIneCeukDdKwjZHl6Iz0vOgZKsMtz8t1e3mDHdxjJmKbYpBNMMbsedglpYwDZOIrUEB9/+AY4aEuldcIIxkyjHTyMUGRgw8ESe8yQkNuxwFOiPLx9U8TrHPdB+JP08m2OoMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shay3Qby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EB0C4CEDD;
	Wed,  2 Apr 2025 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637199;
	bh=d1Mp78QX2vOcjTcP1u20w/Jr7brr6ddMTAuwiaof3SE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Shay3QbyXfP+uz67OtEn9L3RfekUQJyjhY4n6bPkVCOftS3a6SfKcHSLGxWtOVqut
	 AMnLw14ZknW/ShbKgWSNyBYlWGwkQuzbi2n+8UFQf3REX2SKphPqX+ZlBJOyFYl3GU
	 UiRpCZ833FQTuyDPsCFc7MOrnrR4Hmio+MvM1LY28izg3NouCik94B1TVbJoKQ0lAK
	 sGFUf9Mxf9TwW1I2Sjl/rxOgXR2LK/GXr1OJF6fWYVUls5X5+P1Ao8lxBuJuGFPLVY
	 /JLl7dMbSRVOEeWeI0hgWSKhXww8meagtPqQvTUfM7+IltMgtHyYEP5bUz3xGXI1OA
	 Nxc/VRxTn7ykg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF2380CEE3;
	Wed,  2 Apr 2025 23:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: add missing ops lock around dev_xdp_attach_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363723574.1716091.3593838422130018102.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:35 +0000
References: <20250331142814.1887506-1-sdf@fomichev.me>
In-Reply-To: <20250331142814.1887506-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hawk@kernel.org,
 syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Mar 2025 07:28:14 -0700 you wrote:
> Syzkaller points out that create_link path doesn't grab ops lock,
> add it.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/67e6b3e8.050a0220.2f068f.0079.GAE@google.com/
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: add missing ops lock around dev_xdp_attach_link
    https://git.kernel.org/netdev/net/c/d996e412b2df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



