Return-Path: <bpf+bounces-35107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D628F937C66
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD591F219E8
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47397146D7C;
	Fri, 19 Jul 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyrKphVG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9343687
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413231; cv=none; b=HBUft4qfcnaV7BcXmFS58Ic83h8IJGGQAULlMrzlbr75seUEsSKqvV3prUj+Qvse4Rag5WFXmUH7WTbnLxAqgV7rml7jOPfhxPGJyNwIfhHZXx19WS1Y3rCr1ApftmG1Azh7sjoHgranbHARFDEKfC3dpHRpgpXGV7JpW17WmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413231; c=relaxed/simple;
	bh=6tysaqnkehzT0I/MbEfsNg12CbLhV7O7n7yxNvtGmvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCzbjhC8qVozkXh472tN15KLg4XzyIyWIDnUXrVeIcbcCggMx0EA8pc9tqahF1O+JMp9CDqJTJ4LZhgASRxny3C9HJZSAlN9p3kz5iidT7widu7ibDct+vEWENE55ZV0aN2r34C4CW6wEsnpbFUgmSGA/zluoVjPH3kf3sJFaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyrKphVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7590DC4AF0B;
	Fri, 19 Jul 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721413230;
	bh=6tysaqnkehzT0I/MbEfsNg12CbLhV7O7n7yxNvtGmvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RyrKphVGgYryrYHfuVfpHxo7UB+sOrIW+7arn/AZ6SBAA+NVQVdeZRYSArzP+2W4P
	 Fjm9qaSWugmKfHC2AL2uti0SH2xULCQ/vjmcIreBOgu35Ub/k9gkuO8c5c9/I5RLYW
	 ur44k2tFblRMr+HegvkdvWoxLJUfeFsZjztxu9Mml45hIR4V0pCaKegLdZFC5EOFV2
	 cR58cYeI5Y9s2qgORwqv5qbqlQFz8QB+hQ3c4wYx7yIlWRv/zmpo6kIvUTPIPw5NAQ
	 AapAYAMvbeUwhMClOf4vEIwXPss57ZU2zzvelJ4zIg/BbxloMswTczR2qnqPEiYczq
	 llBvKaEVyC/Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DBA6C4333D;
	Fri, 19 Jul 2024 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test
 objects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 18:20:30 +0000
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
In-Reply-To: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii.nakryiko@gmail.com,
 eddyz87@gmail.com, daniel@iogearbox.net, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 18 Jul 2024 22:57:43 +0000 you wrote:
> Make use of -M compiler options when building .test.o objects to
> generate .d files and avoid re-building all tests every time.
> 
> Previously, if a single test bpf program under selftests/bpf/progs/*.c
> has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
> objects, which is a lot of unnecessary work.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] selftests/bpf: use auto-dependencies for test objects
    https://git.kernel.org/bpf/bpf-next/c/a3cc56cd2c20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



