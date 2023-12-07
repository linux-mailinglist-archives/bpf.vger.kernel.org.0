Return-Path: <bpf+bounces-17034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7A80910C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 20:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CCB1C20A81
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAB4F209;
	Thu,  7 Dec 2023 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ+aUaPE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBC4D599
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F78C433C9;
	Thu,  7 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701976224;
	bh=tDkuTcOzK04IIlq2XVX+wDjnGf2hdMtszwmt7yL3TIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JZ+aUaPEaJwTe4117zJIacrV6u9h1/+LwTrFFFYqBFZ7Nny2o3M3dKC9Rf/joOghe
	 bpM0w0TEMlZDgpA/zW+LkY5Nc9cyUyYdF/sRlVjmldqIfmiZxaB8DYutwJjBZAT+nb
	 eeW4uCTodzYMfINdk50cOpOxfbpqkEwSlPKop1vX1JTuM27uEx82u1a8C4wPQNx5QG
	 AJK7uXW5mmYsHzgEUsaS4As6ErEjekK2/i98MP/CPrfnDgqYPiWMGO6rqH63RNke6C
	 GyeJM5y5cq4DOVojsVl3hLoCG24rUrQ5F1zNo1HG5VNGYwjAVzX7J0ZnMEN5EUaywm
	 ybjZPxvaeG1JQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DFB9C43170;
	Thu,  7 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf: fix verification of indirect var-off
 stack access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197622464.16032.7891344511842639576.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 19:10:24 +0000
References: <20231207041150.229139-1-andreimatei1@gmail.com>
In-Reply-To: <20231207041150.229139-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, andrii.nakryiko@gmail.com,
 eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  6 Dec 2023 23:11:47 -0500 you wrote:
> V4 to V5:
>   - split the test into a separate patch
> 
> V3 to V4:
>   - include a test per Eduard's request
>   - target bpf-next per Alexei's request (patches didn't change)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf: fix verification of indirect var-off stack access
    https://git.kernel.org/bpf/bpf-next/c/4f114bc280bb
  - [bpf-next,v5,2/3] bpf: add verifier regression test for previous patch
    https://git.kernel.org/bpf/bpf-next/c/ec32ca301faa
  - [bpf-next,v5,3/3] bpf: guard stack limits against 32bit overflow
    https://git.kernel.org/bpf/bpf-next/c/755f82668d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



