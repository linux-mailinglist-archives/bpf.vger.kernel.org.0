Return-Path: <bpf+bounces-47715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB219FEB89
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84743A28DA
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F0C1A2543;
	Mon, 30 Dec 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUyWo3i6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695719D8BC;
	Mon, 30 Dec 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735599616; cv=none; b=PAPSU6v6wcG2kQJ9Qx/pwM7aTF4AYKwwkG5dliGERstWIzES36zTdELPjQngO5l5r03rbJ39wiFDpwD0DlfLg4uxxYp32FbYbQLckoBfj7lOzhqIEpiu/J9UwTjKqF05Vstal2faBFkvkNrmIXVcamjSNkeVGamrJALR8RuKmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735599616; c=relaxed/simple;
	bh=8pI2GPwynOzFjLBVsNjdOKrNDt7ivC0/Z/q3b0wU37k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKeX1U9vUWV+W2aRz1jIqfgdXoY6RHOrn6pNz8yoofCImPMGbIcGRaNqgraB2CN1OlkHlRhCoknGEhinAwNK85Etw5s3tXYEG+s9ZIfg1imRG48uMWNlc8AY0YJBda0qesRmmrr+eZa9c1vikve0m11EQz9Mq6IK5mr/5R+iVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUyWo3i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F7C4CED7;
	Mon, 30 Dec 2024 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735599615;
	bh=8pI2GPwynOzFjLBVsNjdOKrNDt7ivC0/Z/q3b0wU37k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lUyWo3i6Ru44Tu8GV1F3xqaIM9/vsPTLtkSwhKfy1eDBRmztAdM/+NBmcXp9ESiGK
	 Tcd/DGZtpNhbPT5ANDnzXyLaxk3k4eNDgW7rI88LNNQZYBwcO+B6cBKnCj/o3QeKg+
	 PvglnRyrODlDldcHdqN6pQEv4tq876Sz885S3y9mjk2su1235OxjQFSxeLHFND7bpB
	 8pLMRzc50iM/jZlKKoT4Sl/QwfmU/RzYtw1hG1wrCPE5pGrHllANDSRenGgtC2wDlf
	 ozZJVNMrkSRi2Cu2FEzj6tFgWrG5/Tsen4iidYsMpnjoB9A2tev987MVNimRLAkB/K
	 I+R6h4GD80/OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3C380A964;
	Mon, 30 Dec 2024 23:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix holes in special_kfunc_list if !CONFIG_NET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173559963525.1460841.14234626256989004042.git-patchwork-notify@kernel.org>
Date: Mon, 30 Dec 2024 23:00:35 +0000
References: <20241219-bpf-fix-special_kfunc_list-v1-1-d9d50dd61505@weissschuh.net>
In-Reply-To: <20241219-bpf-fix-special_kfunc_list-v1-1-d9d50dd61505@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Dec 2024 22:41:41 +0100 you wrote:
> If the function is not available its entry has to be replaced with
> BTF_ID_UNUSED instead of skipped.
> Otherwise the list doesn't work correctly.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAADnVQJQpVziHzrPCCpGE5=8uzw2OkxP8gqe1FkJ6_XVVyVbNw@mail.gmail.com/
> Fixes: 00a5acdbf398 ("bpf: Fix configuration-dependent BTF function references")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> [...]

Here is the summary with links:
  - bpf: Fix holes in special_kfunc_list if !CONFIG_NET
    https://git.kernel.org/bpf/bpf-next/c/4a24035964b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



