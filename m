Return-Path: <bpf+bounces-18241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD1817DC9
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353831F24442
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB477609D;
	Mon, 18 Dec 2023 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faozYQ/B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B17608C
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 23:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15A0CC433C9;
	Mon, 18 Dec 2023 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702940427;
	bh=5HimChk1ny9+hzaPtXkcEfUfYFGOWc19RYHxWbaL9DU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=faozYQ/BDio/wkR6/nKlZky/n787UaumxDcJwaIAo92JboAyNRPwE33vt3BcoDRFq
	 war31yMRNrx7fAuht01LPjS1Uqm1BMatYSM+Oz8jg5AOQF/i8VGSxqMne/QNa5+bXw
	 e9N3vWtrXpcTEszgcNyOV13BUY8InjX6ct5xqcyS/AepJoyHXwqzGCnuUdb3Ck7M7l
	 N70y4wJH7lUZ9HHQOFLzAdOLFNN6/we5ojJSq70Fa3mJYY4GQPfC6/VT4sTqXW/pvZ
	 MOR+E58oSes+Gb/MB1gHHH7/GLGVG7HRD3UEmDHoUyYUp3RhVI5tkPYRGulZpdGza5
	 hXQwS2WSycpHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01CBFC41677;
	Mon, 18 Dec 2023 23:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: ensure precise is reset to false in
 __mark_reg_const_zero()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170294042700.13408.5278574005036363508.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 23:00:27 +0000
References: <20231218173601.53047-1-andrii@kernel.org>
In-Reply-To: <20231218173601.53047-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, maxtram95@gmail.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 18 Dec 2023 09:36:01 -0800 you wrote:
> It is safe to always start with imprecise SCALAR_VALUE register.
> Previously __mark_reg_const_zero() relied on caller to reset precise
> mark, but it's very error prone and we already missed it in a few
> places. So instead make __mark_reg_const_zero() reset precision always,
> as it's a safe default for SCALAR_VALUE. Explanation is basically the
> same as for why we are resetting (or rather not setting) precision in
> current state. If necessary, precision propagation will set it to
> precise correctly.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: ensure precise is reset to false in __mark_reg_const_zero()
    https://git.kernel.org/bpf/bpf-next/c/8e432e6197ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



