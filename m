Return-Path: <bpf+bounces-58127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E55AB5966
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07988172EBC
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D622BE7CA;
	Tue, 13 May 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNem08h9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5719CC39;
	Tue, 13 May 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152591; cv=none; b=p0zjJFw2ZKjnbM5u5rvadBF52IRBHhPVZagrFuI97AQ78+AsVChq1IvmeU5nBeWGYOq/rWKdUgwCborAOqez2rsTeZboxXVLUxnV0JO5kmkptsW2JlHRz0YE2NCms1OQls/95g3YbqxspHzxv/da+HC8saMiP1wvlXkjOOpfWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152591; c=relaxed/simple;
	bh=MXkFvkFGa9kVT8kFDLSMJlylsrKtUcRTLqIO7oD//nA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tK2wtTOpsMTMSMCG5fuwqy1zWdCFNr7mtZb4xkYW/rMrRTaiUxyN9rfI4KT0qwe+89YX4WBt8Q5TsuiLsMpfycDN1ghU7wKq0Wo6XIjntJsyZkUueXWC43UNSm3Ov2YiW1XqVWpjrbRXP5Ag78nsiqaGT/g5DEUD8/qmhXr4wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNem08h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DEBC4CEE4;
	Tue, 13 May 2025 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152590;
	bh=MXkFvkFGa9kVT8kFDLSMJlylsrKtUcRTLqIO7oD//nA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DNem08h9pFtwFIhlhuDOshSsAEDx3dEHdJ7osmgCRo5t+b8Yegpho8Km40R3jUzHa
	 +JBAx4WbKSkDBQYLl9Ot3PA5JXWVhWJhhHJaJTFfy6YBiawDPYj5WKK50qtLcQ1VBI
	 e2UsnROoDgRcy7O6SsPpGxB+79gYGTaUIrxOKiJGjykTjZWT92IWej2PjfBvHpapyl
	 U2wQWOpb1HmB8m8Wxyd0Xe8XdJnRDO5eBYV8xgbNGJN6To/mYyV+ZEzk54u/qqy/Wn
	 9yxZOB+3c4yh1+cAhBWCtwycTfPwIjs7P4y+VwdJgws1lFXxPbmEg6AmbzSMFFCuHj
	 HfBtZiAwJTRGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF139D61FF;
	Tue, 13 May 2025 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs: bpf: fix bullet point formatting warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174715262801.1715489.17129474183914468130.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 16:10:28 +0000
References: <20250513015901.475207-1-khaledelnaggarlinux@gmail.com>
In-Reply-To: <20250513015901.475207-1-khaledelnaggarlinux@gmail.com>
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, andrii@kernel.org,
 linux-kernel-mentees@lists.linux.dev, shuah@kernel.org, tj@kernel.org,
 kernel-team@meta.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 13 May 2025 04:58:59 +0300 you wrote:
> Fix indentation for a bullet list item in bpf_iterators.rst.
> According to reStructuredText rules, bullet list item bodies must be
> consistently indented relative to the bullet. The indentation of the
> first line after the bullet determines the alignment for the rest of
> the item body.
> 
> Reported by smatch:
>   /linux/Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
> 
> [...]

Here is the summary with links:
  - [bpf-next] docs: bpf: fix bullet point formatting warning
    https://git.kernel.org/bpf/bpf-next/c/79af71c5fe44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



