Return-Path: <bpf+bounces-62535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC0AFB81A
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBDF189D988
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D269221FC7;
	Mon,  7 Jul 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxEKQ2u3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFC1A23B5;
	Mon,  7 Jul 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903984; cv=none; b=VgzSPGnkveX7c+Bvyh1xw1CsVvPMdCtssoZHnf+Un0oBfG0FEGKLZftP62R7uAb7IhA8aF5uQTLBaSScuEFlxrjim0M0kc08ZSvJ8MEpgE8H5u1/qk+5s1/F/R2Z/dSGyteqhGFnWohK3pfT/htJOefNi3Rs+W8e0JQ/+1Izgsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903984; c=relaxed/simple;
	bh=culOqIjkOS4OE1KS1E208+mey1VA6KfcxMPlrRWyHh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SG0HCDI/bLxOMQL2UBHmsIkx4rLu3/rrJc4T6euMTr2jETCrQqx5Nml6tKwtuW2n+MW2Y9ttJVDzoVHsltSi82KuijVdSuHjyzX43YJptyjdwOOG4WjkDp8n8tYfzXn0SEfCdBympE7UT5MTJX8rbuc1MPuwpN8YA3yLTe+EiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxEKQ2u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC01C4CEF1;
	Mon,  7 Jul 2025 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903983;
	bh=culOqIjkOS4OE1KS1E208+mey1VA6KfcxMPlrRWyHh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OxEKQ2u35ZJYZfdiwzUDxzwRFcUJIStOuDcMgtGxEdtQ6gmIls9mjOMO2tnppqNFB
	 yu4nX4gwES1HrLnH76q9LUC+TiDWmcSGR5knG4DE2yM4M/Qmi8vdnnUsvYaW1UHuhx
	 njhEqfaWm8OZJt+5EVRg9/L9OSjOry4euP+UZkxTBhxy6jifbWjd+NDOITtCB7kwwM
	 n+fObhKGFVWEA+HqvWmNZysNS6IbsrBP8GrODAJjU2NLQTKpOTzp4BW2h6k1Dqd24B
	 czG5842oJ4X6YdXFS7HhebOYj2yVrv8ZCUe13b5tW0+2hLpF5XKcbUXrLr4SJx6wTE
	 PnJD2UuHpzY7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AD813383BA25;
	Mon,  7 Jul 2025 16:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Clean code with bpf_copy_to_user
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175190400658.3343361.17710196557155966641.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 16:00:06 +0000
References: <20250703163700.677628-1-chen.dylane@linux.dev>
In-Reply-To: <20250703163700.677628-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Jul 2025 00:37:00 +0800 you wrote:
> No logic change, just use bpf_copy_to_user to clean code.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/syscall.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Clean code with bpf_copy_to_user
    https://git.kernel.org/bpf/bpf-next/c/3413bc0cf16e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



