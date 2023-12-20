Return-Path: <bpf+bounces-18393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E4C81A1DF
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 16:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E671C1F220DE
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751493F8DB;
	Wed, 20 Dec 2023 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQfqgR9f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F673E47A;
	Wed, 20 Dec 2023 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6650C433C9;
	Wed, 20 Dec 2023 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703085024;
	bh=k5lHD9R+C2B/6uLWIwnXipq7ksFs2/w3BCDwsiM+uuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LQfqgR9fZc8yrV3lASYhrwq4W82RQjyLx5LgzEU8uoo7j1Prk8KstEdAECdaT/ESr
	 xyvmbzXZB5S9rJ7OSLno6eMhC41UejusUzWvLf6AzK1gXvVglqHZeNxy63QeuIjX+A
	 I7ADngy2WF8ktgSg+qt44cka0VBvB390vlSNH5vAJ/G+j+O/xdNBoBV9rYBonasEp5
	 klZJe5eanHhc4YL43yMrJsJTICaq6wnWgncrdeCeD+IfIjf5gBGTpVckB6gFqbRpdB
	 TCpqKuM9PHDlBPse2jhwKTLzHZEp64I8j6WI+LJnHgh/wxV5KPqmvnd44+U+NZzMPy
	 CD3G40bZXXz5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CF25DD4EE4;
	Wed, 20 Dec 2023 15:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: use %lu format specifier for unsigned long
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170308502463.13212.4312172367426805229.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 15:10:24 +0000
References: <20231219152307.368921-1-colin.i.king@gmail.com>
In-Reply-To: <20231219152307.368921-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 19 Dec 2023 15:23:07 +0000 you wrote:
> Currently %ld format specifiers are being used for unsigned long
> values. Fix this by using %lu instead. Cleans up cppcheck warnings:
> 
> warning: %ld in format string (no. 1) requires 'long' but the argument
> type is 'unsigned long'. [invalidPrintfArgType_sint]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> [...]

Here is the summary with links:
  - samples/bpf: use %lu format specifier for unsigned long values
    https://git.kernel.org/bpf/bpf-next/c/32f24938a1fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



