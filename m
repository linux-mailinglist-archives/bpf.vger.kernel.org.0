Return-Path: <bpf+bounces-21243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA884A28F
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3151C23A66
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B02C183;
	Mon,  5 Feb 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnS+xRg3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F1482C7
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158429; cv=none; b=N/nz8uEpL19kCofn0S40QwOi9IyG2IXCpoesz6OnVuELZzXzM9Ekhq+4uF6tjf4k0m7eykQOlJSQvNIadU4Cj1raaDQhUw8rrkZsPZG6Mq565VOmCbCw1Gkzi18UcgsX7tt+x7WvgvWgwLpb5vSiYLH2eAUrpvyD5uA7f7UCMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158429; c=relaxed/simple;
	bh=ugBolXI57WnDAqI+VtdQKiR8gX5O8Z3m8xWQcspyAUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BammkDxc6nW12nu6TeTRYVz0aKcvjdYyQzAscx11946m9MDkbJgoSUTq1EmL5VY/KF6hXBLdrrNKc6IVFI3T6R2lMwhc39xLGzpFfotFufckT+0KxzO9eseCYK51dVOFuZWvudAueY6RevPXsqoEJafushMFp9ZCSrmFbPXATjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnS+xRg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1AE1C43390;
	Mon,  5 Feb 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707158428;
	bh=ugBolXI57WnDAqI+VtdQKiR8gX5O8Z3m8xWQcspyAUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BnS+xRg3Cpa+PuZhaKNMEW6ENRU0nseOu1GJ/d83Exu5PNzf70g1I/DxaS7SzY4xF
	 KjDInkbIynYYqdbSYVPZsAf2VztyrvX6OrjcWs3/DUuflWfIqxKdwz9NcZ/5ncyM+L
	 1Nl3j8rfkktPIBF87BuVo8l4JDGeWSk7lJ3cqSc7qF3FGgX6r2GB9gL841z04juU/r
	 6PIvctK0MqoBbzfYS2YRDwMHZrXV+XUL3o8X78pTe4FutZ+5fFesDm84ioru3tDqqW
	 6xSemOICXhV5xGION4Oa9mOpyoMp9QVXg+AUKLf/3z5NCfFonj7sGoNrNYzN/C4S2G
	 iNEZyouqxzTnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8CC8E2F2F1;
	Mon,  5 Feb 2024 18:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove an unnecessary check.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170715842868.28974.11617068628588148431.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 18:40:28 +0000
References: <20240203055119.2235598-1-thinker.li@gmail.com>
In-Reply-To: <20240203055119.2235598-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  2 Feb 2024 21:51:19 -0800 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The "i" here is always equal to "btf_type_vlen(t)" since
> the "for_each_member()" loop never breaks.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove an unnecessary check.
    https://git.kernel.org/bpf/bpf-next/c/df9705eaa0ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



