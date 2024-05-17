Return-Path: <bpf+bounces-29907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615018C801E
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932C31C21C23
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB4C144;
	Fri, 17 May 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjplShAr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340D8F45;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715915429; cv=none; b=Hz09ewUgiwfuL7tlxFQFo1nOwqrWkm4/4bdoU6hF8Z70tfn/O3Qjz3FUe6TTSFuTFDB7ywlr6UH5LNI8oR1y/p9n2gNX1+uylQZHG3M/R+c3DwN5U3XTKwpeE6DwnCZ/rYdfcZuy3Np2wv78oASFD9n7V+DByOvGRsxvWODUl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715915429; c=relaxed/simple;
	bh=ewr5LqD6aFBNjgSdsKy+jHQsXVziy9ZAzxRTdgAdHuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I5OBZCBSTwsiQTEpqu7oBLeV/z7jYk/kqLcNdV0xx9xTOxbp3aWosGRcyIKIfEBOxkGUHx5bPNqjgalUoxxwCtZ1QtaDgV5CEln5cw4gyM3yZDIBtzsrhDCbGJ6kiwg9Yxs6p9P8s1x/qym08YVcYCkUMN55NEtgXPyIGKCT6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjplShAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B8FC4AF07;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715915429;
	bh=ewr5LqD6aFBNjgSdsKy+jHQsXVziy9ZAzxRTdgAdHuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XjplShArF2rnbwlAcmCYgpwnFooZFoYCqSus3hGCZDTxetj1qdVHEuf8wyO2YeMwH
	 c4foFnFpDd49rjAHa1XsZhx0YgBAjXhJ7Qt4SbiRENDP2jAxodfj/RghV/Rvs2fbKK
	 ZonfRiZg0ggqwa5C1CZWzt7S2UuYjczeDlfbNsTdLuCFhqnNxTRToJR985arGj6oc5
	 ioORWRwJ6O2l6+tyRFwcMiYBKbqAmMCLdsAdMCH7dWK9y7Ex8fHYk0e+tDNUmm2Q/q
	 F2tytl+mhrLKNTswwhUbx5RI5JLeoRd+cCUGUbDK8NkCsMTgfvVmkoI0VpdIB/EOtC
	 Z4b/x+4w5UItQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 546A2C54BDC;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: fix make dependencies for vmlinux.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591542934.18753.10218221858654904278.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 03:10:29 +0000
References: <20240513112658.43691-1-asavkov@redhat.com>
In-Reply-To: <20240513112658.43691-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jstancek@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 13 May 2024 13:26:58 +0200 you wrote:
> With pre-generated vmlinux.h there is no dependency on neither vmlinux
> nor bootstrap bpftool. Define dependencies separately for both modes.
> This avoids needless rebuilds in some corner cases.
> 
> Suggested-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: fix make dependencies for vmlinux.h
    https://git.kernel.org/bpf/bpf-next/c/83eea61776c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



