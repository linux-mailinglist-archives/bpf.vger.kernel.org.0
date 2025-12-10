Return-Path: <bpf+bounces-76397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1482CB23CD
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 08:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA28530378CB
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92442FE04C;
	Wed, 10 Dec 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7r0ybR0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B62FF677
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351995; cv=none; b=XhaUQsltrgC4s5T0Bl2Zvwty2mShPbCg0ahIawLbLrLb2+yiIebWpXib/tdC0YH9WQiWD3CYPwNhQZOCwutWXsq0bKb7CF3+wzJ1fnMo8YQlI9jLyf76nPVHgkT7Bj6oPxoxYLOVxPTE1zKAAgsFPX5bWK0ruqnigIvJz87pFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351995; c=relaxed/simple;
	bh=SeugrnBI7J9A8yxfrxjUc2Y6qkN2Ic9+zfj2f26mFTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g6cSJEDta4NZdpSdRSvNhI7ibQjgwNi6pz4N+AWvf20wtXhoOMzTYrn6bgi2iKM6ieCwn/P8QqZQU/MIj0vf8NFUwxH63ulJhek8tmhzoVqzIbri/Gr/YHDT3LkHCDsC1aQsEc78Vf+510L1ZTn/p6NUP/+IT0ZJYTOpR4DlFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7r0ybR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032CEC116B1;
	Wed, 10 Dec 2025 07:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765351995;
	bh=SeugrnBI7J9A8yxfrxjUc2Y6qkN2Ic9+zfj2f26mFTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U7r0ybR0mA2Rp18+gSSBEXH5EcpLczS2/9eV+jAVvr74jSQryNmfugl2L/amqGwM9
	 moLoAXh4irC6dtgoFrOsvRizniCVU4R8R9Y5Itt0of3fMBaTkaFS+GLXmZ6BVWlGe8
	 RZy0fbl6Fl0+crIYbEpXXo2/Ntac1eXheckL3HqfBZT+1+mVYA5RIrgjrXS8XKJK3i
	 HtTldTxkyvt4wg6m0Ws4H72c4SmaXUQaDpzgs4S61fUIduFMgEUd0L/IcfLAJnwcoZ
	 /zWZWcjUl+J0wKFQsfwTawgcfQWvSwAiY1EBsCb7IFi4g862/ZbKnSSJslo9m+P8KI
	 ej5Jkggg+I7lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2FEE3809A18;
	Wed, 10 Dec 2025 07:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix build warnings from vmlinux.h due
 to MS
 extensions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535180952.487333.12933473404420622160.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 07:30:09 +0000
References: <20251208130748.68371-1-qmo@kernel.org>
In-Reply-To: <20251208130748.68371-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  8 Dec 2025 13:07:48 +0000 you wrote:
> The kernel is now built with -fms-extensions. Anonymous structs or
> unions permitted by these extensions have been used in several places,
> and can end up in the generated vmlinux.h file, for example:
> 
>     struct ns_tree {
>         [...]
>     };
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Fix build warnings from vmlinux.h due to MS extensions
    https://git.kernel.org/bpf/bpf/c/639f58a0f480

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



