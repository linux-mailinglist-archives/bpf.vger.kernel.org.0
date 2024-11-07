Return-Path: <bpf+bounces-44251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E89C0B09
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FA2284897
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68A2170C8;
	Thu,  7 Nov 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nex96I6v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B00215C75;
	Thu,  7 Nov 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995824; cv=none; b=dauWRRf4I5m5Xd0Jr3GrLAiE5ANAqS+2XO9zbR8SIET6UeRxhovKP3F7rN9iw5YTV7895H9kk11nZd6Ik7EjnLo6tvcva2MTfBETXR36sYqbZRLvjp2yGBDnuZk/4XAM9OLqwtesgTiCedzbHY19Ppvc21tYC368twZqnlcgs7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995824; c=relaxed/simple;
	bh=WY30kkZmSSer43/0wq5+cimx8PJCLiy3jXJw3vexRdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3lF4l2lptfr8kXa3cPjYPhAyHRCQ4aIPMXO3TRpv0bC+jTEFHiSx/Ccs+HSPnZpwV6/67i/E8xEKB0AL+yFPIInOt4X0Aqszzs/BYVldm8tdwNyh0U8MPUH0evnqaQy99xwcelSf3Iyt03bckNjorzbrx2T6uR1TFkaKKy2cAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nex96I6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C006BC4CECC;
	Thu,  7 Nov 2024 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730995823;
	bh=WY30kkZmSSer43/0wq5+cimx8PJCLiy3jXJw3vexRdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nex96I6vnMIoCZbAQRNlFrYwVCKtAqzfeFzrTg5dqdTTgnri3mbfJF28w4unGo4Rh
	 oWHOk1pCLExA9zNR8UCUHI30WglsO8j01cgq+YjrWsuQjTC/1e5aLGGAYIspyM79Jp
	 AM+/wc3ruTAFCUuLTBnPligeAv/Ylq+XGrnV0PiSXVzC20e1sAiuEV59mVYaxySyXD
	 RAeasjJK1lX0UGu7wZshkVIrq3Nsvvpv+7E+eXFXq9hwoZYVTVD9+JiH9ToIMMN7gb
	 sx/R8WIau8nZ/5S35IwPqJzItThixAcbS7W0VrillN1e8Rid5WHK7RCftKcMz27kod
	 YUPbopD/gXsVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAB3809A80;
	Thu,  7 Nov 2024 16:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Fix uprobe consumer test (again)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173099583301.2013966.1812097042730981542.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 16:10:33 +0000
References: <20241107094337.3848210-1-jolsa@kernel.org>
In-Reply-To: <20241107094337.3848210-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com,
 peterz@infradead.org, sean@mess.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Nov 2024 10:43:37 +0100 you wrote:
> The new uprobe changes bring bit some new behaviour that we need
> to reflect in the consumer test.
> 
> The idea being that uretprobe under test either stayed from before to
> after (uret_stays + test_bit) or uretprobe instance survived and we
> have uretprobe active in after (uret_survives + test_bit).
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] selftests/bpf: Fix uprobe consumer test (again)
    https://git.kernel.org/bpf/bpf-next/c/2ed7316a506c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



