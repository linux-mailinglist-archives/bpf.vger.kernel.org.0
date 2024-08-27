Return-Path: <bpf+bounces-38193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31066961795
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE0A1F2590D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A71D2F40;
	Tue, 27 Aug 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoOHXJxW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE618195F04
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785232; cv=none; b=j4IIBJ2evng5DhEim/KQYCMNLB4xITbIKUyiuRN5WWAoOVRQ0TV58Ru0uu6/hr8xuvndSq+apuZF6QDdWsoWkxZoMM1dB2liXXANgZHgsoVKSb+cQ9fQA+7FkZ/ov0DEezUdAiUP90VVk0y5q8H8P8vhMG7cj+C/tq/gxqPQ4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785232; c=relaxed/simple;
	bh=EPa6GSRoIKbhuUc/26XPxc6zFmXCgDxPrO/Htxb8K70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r0K9k4RzxtCmdc/HQURU3T7bl+gxmWB3L4Jzz0VcFodGaD9B4BmI7pxwsn0b0W35sUMx0AEYxK8sClgt5EEb0YHRXTtNrLrPQhe2L//KZBHP07bwG2wwpW/QspJGRJbwB/MnAh1VATxH6n9TlyZq8mvhAW34C7Z8QDH2ZdQ50qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoOHXJxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6440CC4AF18;
	Tue, 27 Aug 2024 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785232;
	bh=EPa6GSRoIKbhuUc/26XPxc6zFmXCgDxPrO/Htxb8K70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoOHXJxWYLW+EeFLiXhOoXVlXqhzeCMdp1JjKBps+dgHXa/IvC/OPiLk6twFB3jme
	 SehV6B7emIhG2xPrGJoFLJw7lIo0qBMMbDB/56+j+V3VEaSHfbUFbAF3ihtxl3mM4I
	 3mItrI/TfF6q9gRO8cGjfywjiwjaezVPNLhhdFz1ae/KgOrT4otESUE3nctXBbgTR9
	 c4pYl2NuBGyrg1nhN2oUwoyBBoVWumFnZnBYHt4OY3MzmsXrpwJ/zq4rTJ/dTlFhXi
	 JmY5xLKr7JizDZ1S8ZVFPrRrksHIV2ZfMXdESWTU5k0sykFJFQLGoqQDJ99HeVxuQu
	 JVAZ2Or6w5UOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4563822D6D;
	Tue, 27 Aug 2024 19:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] netkit: Disable netpoll support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172478523255.737227.4857063484811499620.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 19:00:32 +0000
References: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>
In-Reply-To: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kafai@fb.com, bpf@vger.kernel.org, leitao@debian.org, razor@blackwall.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 23 Aug 2024 14:00:53 +0200 you wrote:
> Follow-up to 45160cebd6ac ("net: veth: Disable netpoll support") to
> also disable netpoll for netkit interfaces. Same conditions apply
> here as well.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] netkit: Disable netpoll support
    https://git.kernel.org/bpf/bpf-next/c/d96608794889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



