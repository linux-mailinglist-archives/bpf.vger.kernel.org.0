Return-Path: <bpf+bounces-49135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123FA146B6
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2458188CA5C
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CE242D79;
	Thu, 16 Jan 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcNgUeAx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7761DDC01
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070809; cv=none; b=J2k08fMHgJs+tLR4Uau26Glq1ae9tced1Cv/L1S/MSfT7NlkOarbE9nwWtpQ4nVknG/FxZEvu0o9rl8g+xwsf9RJZr5aaUtjUw/p0xQZwRT2OwLCp7+Cz7LtzQFHIyu/KlihGERjSfVVqhYcRam6Gd3JErpPGMQiMLBNEsV9IMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070809; c=relaxed/simple;
	bh=Jca4fPc1rw18g02E7+Bd/XJLex4ElvfWyAUjSpcfGks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EvLL0mf1NAns9jUCv7lbKNNbKhSspx6bmVe3XF80lMCNQxl5clSVv43vzRbVIMXALgVkJAY+QR5MV+VW/6VnuiL7hhT9mNJ4nc+x6yyKyDKXy63TQ2SQspBSrX8qbVXBcIhVGh4IyCwDOhu2mWrjzoyJRn8srsvA2ALvw3CbKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcNgUeAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA00C4CED6;
	Thu, 16 Jan 2025 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737070808;
	bh=Jca4fPc1rw18g02E7+Bd/XJLex4ElvfWyAUjSpcfGks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DcNgUeAxXOBCru7E/I/Rtg51edb2j/7rqmr7cMz+zeqomT0NtccNgCjvnuVlZvSvx
	 Sqhkw0fWXGEQ8TXElo1tbXfBLd+DZEWw/+3nLg53MPTvRkQbm16Ge8KQueW80RNSVH
	 mN7tMpabNny4qPxEUEpfHwRkF+iOlatExiu5MG35/wBgFRU9tr4pSjev8Vq3ygAvg9
	 i7BtExdkUP9f3Axk6U0hzuplATEtgFkIsLdWDDzZeoiATuWys+pIBhtryE4BJ37L5C
	 88+xYgzhKvDErHR/MYJTatOtlzDAx3KjmqCHReG1cYhgDqC2z63u+0qoQ54j2o3sq6
	 RTDWn0BDJziig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AEF380AA63;
	Thu, 16 Jan 2025 23:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] veristat: load struct_ops programs only once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707083181.1626468.2571157891605962733.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 23:40:31 +0000
References: <20250115223835.919989-1-eddyz87@gmail.com>
In-Reply-To: <20250115223835.919989-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 15 Jan 2025 14:38:35 -0800 you wrote:
> libbpf automatically adjusts autoload for struct_ops programs,
> see libbpf.c:bpf_object_adjust_struct_ops_autoload.
> 
> For example, if there is a map:
> 
>     SEC(".struct_ops.link")
>     struct sched_ext_ops ops = {
>     	.enqueue = foo,
>         .tick = bar,
>     };
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] veristat: load struct_ops programs only once
    https://git.kernel.org/bpf/bpf-next/c/7c311b7cb3c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



