Return-Path: <bpf+bounces-21982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E54854DFA
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714D01C28569
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9CF604B0;
	Wed, 14 Feb 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTg5PygQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE55EE76;
	Wed, 14 Feb 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927627; cv=none; b=F38hMw6CH2kRz1MZol7TAojCCfJoXo06xOBROE/lhkwnlw+0NDxZxX58ZIEetn5Sgoekc3oQRkST+/34GaYNa/yFsUFmHzCqKUwJzWmwoX80oHI4BSuYvREeL1VrQYLmMHNzz3O4AJL4/+ypen4jioVNs0Zw/dZsCdn/9vhQ1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927627; c=relaxed/simple;
	bh=uMGAWooORyURgykdElNL6ynbJ1xeXkDPlZFNnnI2BJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jXztuW5UJo8651YB1oGqK7c9HtVLjVdguajmvTEBo1ZZsYj9ShXHZyXHN4wvOAjzTZYOUqSycu/ugxJ7EL6l0Oal9setnb/Egr4mn20VhX7dFs3IR73qRia2scdVhWOmgoXYflWWBok9Guw7FUu3l2zQaxjoumfEv4P15oGr7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTg5PygQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F777C43390;
	Wed, 14 Feb 2024 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707927627;
	bh=uMGAWooORyURgykdElNL6ynbJ1xeXkDPlZFNnnI2BJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTg5PygQml3QJqikkWFZkLGNkMq0034GYIFG2orCyJv4HJO1usetA1O17hW8is6pk
	 Ec7WsuSqCNjvE+8ObpZmGmZPIPiEDkX2nwAxghs2zbpWpjZwmPz60aIJAxpj1nAmJw
	 T+0YinHtipUTjMAHBkngDoFjfRsnt/kkHK6MjSB6DPkRoe5ihjQ0dz+Xkh01tYNJ7F
	 C4t9X3JHsnMNIVEgNbfP23VfBeAK/A56a1+MTTI7Z4W9nTqo12poem7sBJqeVExkUs
	 +ksxMem3nAshut4BYKhM32jbHfP5TZYH09m9oKKUZlwO4VeHX25V8IeobUtCsZ52cQ
	 aJ/KHlHVpq/BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15CA1C04D3F;
	Wed, 14 Feb 2024 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Corrected GPL license name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170792762708.6252.9827025047407468973.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 16:20:27 +0000
References: <20240213230544.930018-3-glusvardi@posteo.net>
In-Reply-To: <20240213230544.930018-3-glusvardi@posteo.net>
To: Gianmarco Lusvardi <glusvardi@posteo.net>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 13 Feb 2024 23:05:46 +0000 you wrote:
> The bpf_doc script refers to the GPL as the "GNU Privacy License".
> I strongly suspect that the author wanted to refer to the GNU General
> Public License, under which the Linux kernel is released, as, to the
> best of my knowledge, there is no license named "GNU Privacy License".
> 
> This patch corrects the license name in the script accordingly.
> 
> [...]

Here is the summary with links:
  - Corrected GPL license name
    https://git.kernel.org/bpf/bpf/c/e37243b65d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



