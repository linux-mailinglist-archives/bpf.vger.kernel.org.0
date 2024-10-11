Return-Path: <bpf+bounces-41684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB6999A51
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CF3B24107
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE01EABA0;
	Fri, 11 Oct 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2chn8Xb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB21F1306;
	Fri, 11 Oct 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613228; cv=none; b=Pzbx29zEsLFrpI1xLX2mzRS5GSP8I1yFXEQPoj+w8g71gl+bcSLLYrntPKjOgzFBQ1yoSg3VrLB1Lbe3FTySC7K8CV68vxgp/B9d80CqmujifS4VH/00CmgWV/FY1Q9V2oYChUDU5ok4PccF0qKeyntE54RzaVFfXwLa/QNscw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613228; c=relaxed/simple;
	bh=VfUGL3JXRQZUi7/H4/v3XWJN2bL/bshUjC9/Iid316c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HvCSefwcYVKx+MWLGgD2hgucfNRS+eEh92j96Sk4DyEiTrlI63gFqp/5mKNoGD5VQnNJJgsB+N1RcDGx79mwdjiHxOBvrcn459nbU8TIuETDMMNjjO7ljIi+oH2KvUk1wQuEfdMqYS/6pa/Tc3IdH74RqBKLAAocoADYyBk+1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2chn8Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0221BC4CEC6;
	Fri, 11 Oct 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728613228;
	bh=VfUGL3JXRQZUi7/H4/v3XWJN2bL/bshUjC9/Iid316c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o2chn8XbE3QvqS5GWVYo/xShYm9T8XyGpT9numqBTKAcNvUJ85GKI+SR4XbT56vBK
	 Y3iuY11OCtUpVznNj+hOd/0Zch+9dC/a9aczRykWEToiaaBox2qtw5jafzUKm21cac
	 hLgnoLknzLSR6RyDZ5s6T/MTZUQ674SRbWEQVO5xiA44T23/ZZJV1WzV4nElHDqGVR
	 pPsFrxrCCmRjaIrwJ8Yp+w7aHb3o46/ZYOzEG1N+j5jYDUEze3e0GbyRRDAzc7jIR0
	 DKOMFeWYhBpuwnCye1qQmUmBGpHYFRrWnQcXwydF9yzSO7ubpIlPmJnHS/dVVo4zVb
	 Jahwtcm/mjV9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC923803263;
	Fri, 11 Oct 2024 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: Fix a resource leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861323249.2249999.1050489536737520953.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 02:20:32 +0000
References: <20241010014126.2573-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241010014126.2573-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Oct 2024 18:41:26 -0700 you wrote:
> The opened file should be closed in show_sockopts(), otherwise resource
> leak will occur that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  samples/bpf/test_cgrp2_sock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - samples/bpf: Fix a resource leak
    https://git.kernel.org/bpf/bpf-next/c/f3ef53174b23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



