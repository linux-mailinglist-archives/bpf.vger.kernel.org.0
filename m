Return-Path: <bpf+bounces-77649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAEBCEC9CF
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2BD230052DB
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3D30EF8E;
	Wed, 31 Dec 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCMo2JII"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DADF30EF7A;
	Wed, 31 Dec 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767218005; cv=none; b=f9mFC3t8/HAZaeF7XIWFbV/0JtN7qHLaE9esgGHOXL7ru5ijsRLR9opUpE9xJy77Md5Ayl6mpAwgu/LwNtTf6FWlAzYcGZ7L+fQ12GxlZ25ATJfBExL8WchoNOfKtNtJKtKLur1/g6Kj7qBT/81bpqyZK+ywZT7sTm8QQWb4Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767218005; c=relaxed/simple;
	bh=+jzER5LlCxbCRlPdqn90xRorge9v//z2HFOy19EmGwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hI59/wQHoYl07t21dcDuhdguVv5NfME8ht/pkdP29+oS/YumlHEj5YbFMs00SVhr7FqbAnyyNWnoTFV5WX/qXUqDVW6DvAci8lv/34ye/O+uE1CzbOnN/q1BdY2vOF/l8fOE3MKAEMaDYejuGnblnzprolb92WQfz/9Z0fT16Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCMo2JII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123E6C113D0;
	Wed, 31 Dec 2025 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767218005;
	bh=+jzER5LlCxbCRlPdqn90xRorge9v//z2HFOy19EmGwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCMo2JII8OM9G/dkGklFaP+au6uunfpbyngeI5PsUoVyn3oWEGLMLRcb4XhI3fQzm
	 99jkAWzvGNK2NgUSE480F/6bREHmWf/1UE/MP7Irmh36IHuXL9vWXJxKTteKDyHmCj
	 +O7mis5h4lP2WGi+zDfr9dvHXT6LP7C+0wDQJSR1D9jqbbpqh6LMg+Ust18/JZKFTF
	 1mefldEpFx+oWT37z5F2STSWDG4g6LOaaXT33euBPVDi0DVfBnHbqUKtaGM925fDwZ
	 ThqmNeLf7/HduQdZb8ODPFi9Du4AmJ5LobGo5R60/3ev9Q+bnGWGgwvVpvKNxrQCbj
	 srbyg5OMYc1vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787EB3809A83;
	Wed, 31 Dec 2025 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation/bpf: Update PROG_TYPE for BPF_PROG_RUN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176721780607.3608013.6877028760018942442.git-patchwork-notify@kernel.org>
Date: Wed, 31 Dec 2025 21:50:06 +0000
References: <20251221070041.26592-1-tjdfkr2421@gmail.com>
In-Reply-To: <20251221070041.26592-1-tjdfkr2421@gmail.com>
To: SungRock Jung <tjdfkr2421@gmail.com>
Cc: corbet@lwn.net, ast@kernel.org, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 21 Dec 2025 07:00:41 +0000 you wrote:
> LWT_SEG6LOCAL no longer supports test_run starting from v6.11
> so remove it from the list of program types supported by BPF_PROG_RUN.
> 
> Add TRACING and NETFILTER to reflect the
> current set of program types that implement test_run support.
> 
> Signed-off-by: SungRock Jung <tjdfkr2421@gmail.com>
> 
> [...]

Here is the summary with links:
  - Documentation/bpf: Update PROG_TYPE for BPF_PROG_RUN
    https://git.kernel.org/bpf/bpf-next/c/17c736a7b58a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



