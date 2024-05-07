Return-Path: <bpf+bounces-28963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9967C8BEEED
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B02282FEC
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131487603A;
	Tue,  7 May 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7M2Ix52"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FE74433
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118028; cv=none; b=Irnoeb4w4CmYHoUkQb1UGUTE5QRDor+RsJpqp4jzabs9Nt79jNDCZy8EVvxjun7y54v3nfrW3/zptjjSYourW01rZbetVks+84e9feNCw+i+4Nn7EMnWIY5fhqxlJmvigZa/EYX2xOagYJy6NcdJBk2gTF3X5aPoPJl/LR5SUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118028; c=relaxed/simple;
	bh=jnp/upSq68FDdxtb4CM8ef0lh6InJAeyuU53cZDaISo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KJEXl0GyT/PC8HBHbKEgJVc5IH/O55zCX0RA7B3vBIddM6bpAaZvB8g2wbTLp3z7pyxXLKchYwArXu5aTvov3eG7tnEK+OniFm55CA7j+pf7HZr36EIaU2OJKerKVrb1XN8Pmsco3tYNG2BIKzChbOZcjpRG8Fh4Vt7WGMcN4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7M2Ix52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 245D6C4AF17;
	Tue,  7 May 2024 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715118028;
	bh=jnp/upSq68FDdxtb4CM8ef0lh6InJAeyuU53cZDaISo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z7M2Ix524WwXFkUroIVL3/EwWePaj+vcFf5osqkXU++xXkj3OUH7tQai8L6e1u2+i
	 uXSrEuBOzk5UAxDUvI/s88rdc5OOZoENVxSCqtjKjO+nB2t+vkCWfZs/8RJswtVlqv
	 9bqQiKvBOqF7hLbz7Gnz0spK8wxKo2OPKnc4IyyneHBx50tebmLlit+duVzfJLpGuK
	 6xOjb9oxeseQJT39Biztbfw0279ytmubDZjsZtZcXUSQove/23nJyh02ow9gN5Fl1e
	 c6vIWzCqmId7DBwIDWI/GTAkin/FAaul4MniNBhvWpBsm9tCn8u+2AiVzba+g78RkK
	 mK6c9HxgHKfLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A91BC43330;
	Tue,  7 May 2024 21:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2 0/2] bpf: avoid `attribute ignored' warnings in
 GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171511802803.15787.2996104692965890147.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 21:40:28 +0000
References: <20240507074227.4523-1-jose.marchesi@oracle.com>
In-Reply-To: <20240507074227.4523-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  7 May 2024 09:42:25 +0200 you wrote:
> These two patches avoid warnings (turned into errors) when building
> the BPF selftests with GCC.
> 
> [Changes from V1:
> - As requested by reviewer, an additional patch has been added in
>   order to remove __hidden from the `private' macro in
>   cpumask_common.h.
> - Typo bening -> benign fixed in the commit message of the second
>   patch.]
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2,1/2] bpf: avoid __hidden__ attribute in static object
    https://git.kernel.org/bpf/bpf-next/c/2ce987e16502
  - [bpf-next,V2,2/2] bpf: disable some `attribute ignored' warnings in GCC
    https://git.kernel.org/bpf/bpf-next/c/b0fbdf759da0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



