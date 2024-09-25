Return-Path: <bpf+bounces-40294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B059985715
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B2BB211FB
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168C15B13B;
	Wed, 25 Sep 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5AhM/fB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94844C68
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259627; cv=none; b=hg8DdCq7VDCPqvVFYtOCV/lvYGWdPToSxzzwIJOINYdvgtTGgT5Ck8tNCeEFjxMSr2I2xp5bNN3/Rf8gAz3lbtRi/nZJ2pksNOcbUgk4mVMt+v2D7bl7kuMyygIPgBICquMLsg8afj257DZcN3D7KhDjj69ot5MxALv0nKDo/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259627; c=relaxed/simple;
	bh=Q9QX5PLzqVRd/aznAPmPBhixvtOnP66do6F/xovSQTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nQwowWVVe6h3hzVLAYq1F48KI45C0cJmV7/S8GjEV2JSHSSWUPPmIyr7wvML8CfQSKyHFUVz181cc5U0Y2zqMfYxeGXVOf8gS61Bc1+MgB0bwywcRTBiDJ56SdhIk6edL4dGh2OHLzI7CaFETguXFreg6/qRWs/vITUvWYxfn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5AhM/fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B371C4CEC3;
	Wed, 25 Sep 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727259627;
	bh=Q9QX5PLzqVRd/aznAPmPBhixvtOnP66do6F/xovSQTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o5AhM/fBsRYfYhpoFGX5GBiFiWuVlPYmuutrfbYEOa9Ogaq7xh9qbB6pf5Nx//KQ7
	 NsOG3nYRBNwfo+CjF7jpc3AhzJvz9GsHMm8xVrLgw7+dPQChOWzcuUN44cfxzUMd4a
	 QLJ1IhDTHWCXRBTsp47kI7cHZyMQBIceDaE3QfrYpxvzOJjOriIRIwiVyuROr4wqje
	 eobXKsT4CJy+OWa8icJq4Y/bNVdx9RqXcvH+XXmTCKuEtQZWwglPNIKnLr0JYnG+NO
	 9dEzME4G95PInJKD+Dasq/e9NVbmZSrQrKJbVQ6qjFl5dzD2ip8FEmqRI4Y/d8jiSv
	 AngAyfKHhwF3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE793809A8F;
	Wed, 25 Sep 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: change log level of BTF loading error
 message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172725962952.529070.10683033371235698776.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 10:20:29 +0000
References: <20240918193319.1165526-1-ihor.solodrai@pm.me>
In-Reply-To: <20240918193319.1165526-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 18 Sep 2024 19:33:22 +0000 you wrote:
> Reduce log level of BTF loading error to INFO if BTF is not required.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/lib/bpf/libbpf.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: change log level of BTF loading error message
    https://git.kernel.org/bpf/bpf-next/c/cc475dea00c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



