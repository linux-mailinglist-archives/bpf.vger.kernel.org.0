Return-Path: <bpf+bounces-52289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E621A4119F
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A893B46CB
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878623F40C;
	Sun, 23 Feb 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFtO8k/U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272423ED68
	for <bpf@vger.kernel.org>; Sun, 23 Feb 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342616; cv=none; b=u4TT34K0FG08mftUc5MDFmizf9m2yFMylMQyFjkeBYAn97ybTGJPeXdMpMbVDlws9mArjd0CLOWH3Wri8bKxWKdPw5yBuIdsS4RU4j5LgRAeuNTTOKA8n7ZpIhCJoQCaMuM0YvwsEqD+qe+5UYSHfN/eJuCHSyVkuZ7iRaa81mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342616; c=relaxed/simple;
	bh=9BeP4Xg+I7CIgdbxEzyVZ01/Y7MLhDvNE98qDpr31NM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iFV37Lf5y3cB1/JPwlVRgO+NmJlGYWCLUGmFD/52HdS0PTB3+oUP7iZyVCD000SybGa3+myYTlIS3kexa4aSwTH6bMoqn1qkFq7Xu/xQG9ud7f7boUWzAcaO0Rb6p8PWiwdYBA/w5Zv+J7mQewxX04qgsKZZ61wOkyf84CeoNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFtO8k/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65112C4CEDD;
	Sun, 23 Feb 2025 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740342615;
	bh=9BeP4Xg+I7CIgdbxEzyVZ01/Y7MLhDvNE98qDpr31NM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hFtO8k/UyMYK3f2JY6ScMUd2t9OOvbjVdwoWtbHf+ApXtNMaB1C7iOZro6vLEGnhl
	 j//inQVA3W/+yaD1JkVZMD9QtzPeu0JiQq8D1++SHTl35Qe1fYOp8bhZ7llaaL1OPw
	 odiLmherU23bg6O8fEcysSrIia3OeOatHgqEa+Xq01N+eP3sUaxlN3OUFjQldwE6Qz
	 wEbauW52qkt87xQ576z8FEChUqWMo4KJIcltTglp3883+MaKA0g+izk+yw/GHy0RMR
	 G1oUoKsXEWs15jLl5FpYNJS1VKacbDq7IfdQUE09PIW7SjQkeyrw8m6PZNT1JSpfm1
	 wBWIwaj8579Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA07380AAF9;
	Sun, 23 Feb 2025 20:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Refactor check_ctx_access()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174034264676.2612491.11796681762886469056.git-patchwork-notify@kernel.org>
Date: Sun, 23 Feb 2025 20:30:46 +0000
References: <20250221175644.1822383-1-ameryhung@gmail.com>
In-Reply-To: <20250221175644.1822383-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Feb 2025 09:56:44 -0800 you wrote:
> Reduce the variable passing madness surrounding check_ctx_access().
> Currently, check_mem_access() passes many pointers to local variables to
> check_ctx_access(). They are used to initialize "struct
> bpf_insn_access_aux info" in check_ctx_access() and then passed to
> is_valid_access(). Then, check_ctx_access() takes the data our from
> info and write them back the pointers to pass them back. This can be
> simpilified by moving info up to check_mem_access().
> 
> [...]

Here is the summary with links:
  - bpf: Refactor check_ctx_access()
    https://git.kernel.org/bpf/bpf-next/c/201b62ccc831

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



