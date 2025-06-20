Return-Path: <bpf+bounces-61200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BACAE2257
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5981BC5A26
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702CD2EA74A;
	Fri, 20 Jun 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otJWSjfL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455B6BFCE;
	Fri, 20 Jun 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444781; cv=none; b=otx4116A3FShdnW9/XgT40WCGBzNWH47+GhCjEbigu9ayGQjmzI9F2yIPy2yEu0swJOYRR7FHahPOtca2GSGYnfZ1hRRqUzqg9uf/R0l6Pdo5tCakxUItyi+wLxL3C4koKHJKred4u60LW7PPne/lp0Eq46KglA5nYFFfeF9Vh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444781; c=relaxed/simple;
	bh=WBAGkyPnLnmnwszlkbywC9BZ09qLFxK6zCZgFlCdjoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CK4UJnWqjhgFCvrpOKRjtR001kZJ3txWRPCtc2nFPzYl47kRUv+2JRLcMmHwF3dMZ0eWj9S1SxPSjKhF7gCBCLrz4aS3Dr7HK3KhsNzbetCURAZ5s0Qs4obM2TkWj5QZndTxj5LFk+bosv2MdDGS72qvniHvblvPWGdyB84f15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otJWSjfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2C4C4CEE3;
	Fri, 20 Jun 2025 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750444780;
	bh=WBAGkyPnLnmnwszlkbywC9BZ09qLFxK6zCZgFlCdjoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=otJWSjfL0DeqdBhyQ0TqDupvRsm3c/+lJJQECmczA+3WKspiyGBvSfOAF4H4zMtn5
	 pDL9XGpY01skaJ3yNuI89Jy0wgkhcYO6xwirzlextJz4GwjJ9mqoeS88WOc6fa1DN9
	 SBYODifjXOwVXvcuZV4qWMGRrJNOEfRmV+oQImMRacJ3wJzOyVQwa47sYEuxMV3KCn
	 nPkonvEtGZXe2HHNQ32gLehhLMrrd2GoSAYN34qyUsyGFwJOha648pL7q7YjcxCdip
	 PARK1zF4uyFHD6AISqn3Qlt8vHf++0t1vouos3sHgxwwxOvHKotxaQtmdn6QT149ZY
	 sDGHl1O3h8SYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9D39FEB78;
	Fri, 20 Jun 2025 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpftool: Fix memory leak in dump_xx_nlmsg on realloc
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175044480826.1670618.12225951813813785948.git-patchwork-notify@kernel.org>
Date: Fri, 20 Jun 2025 18:40:08 +0000
References: <20250620012133.14819-1-chenyuan_fl@163.com>
In-Reply-To: <20250620012133.14819-1-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: ast@kernel.org, qmo@qmon.net, alexei.starovoitov@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chenyuan@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Jun 2025 09:21:33 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> In function dump_xx_nlmsg(), when realloc() fails to allocate memory,
> the original pointer to the buffer is overwritten with NULL. This causes
> a memory leak because the previously allocated buffer becomes unreachable
> without being freed.
> 
> [...]

Here is the summary with links:
  - [v3] bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
    https://git.kernel.org/bpf/bpf-next/c/99fe8af069a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



