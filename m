Return-Path: <bpf+bounces-30599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0808CF099
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D44B20FD5
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C299127B72;
	Sat, 25 May 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLEl+8+G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894181272C7
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659433; cv=none; b=XLas2pJ3wYShr5+M020Zn56yIosx0BzlHD3WH8viMVO2yAKJi2feLfN+kf6LPztQMLJC3AFd5ZxTNOLC3ewkMsOrejZhwSnUvR7Dof8vWAGJ3GwMhVmyiLy68krZJacw74bIb9VSHyfsw+g/M+f1g2i7tqRLKQyJcjOKSn+/eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659433; c=relaxed/simple;
	bh=pP8bONZpdUorvpTXRZRIaJO8UzYKcZ9BC3wSaZ8Fl7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lgl+7UjR2L6Wk/r+F0hBhpu+RkTXZGYwxOhNsRNSaYTtS7d8WKxg8pYpm7B7q83X8d1Vjo/dh+JHeuTyHYsEYUck7KD+VGBWTdTwBGjNFUOjGjn7CFxX+Q9By6uPt44Gjhbf9vgjj64xPwmGWBTDpxHRdoK0glWPmZPX6zoFI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLEl+8+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35180C4AF07;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659433;
	bh=pP8bONZpdUorvpTXRZRIaJO8UzYKcZ9BC3wSaZ8Fl7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VLEl+8+GJ8PDL6F9rKIygilnO3g0jOpYPuuIbyCdljpESTOnid3tOn+tt1+YRDOTh
	 22V7oFFTc1+0bVW6lH9ULTJQny+PDtnzKXVvg+JC+VXEJFjJyBZBWHCdUJ5HON6PwE
	 zhkG2/LhF0LsuSRPgJ9894dE1zPHlVJuXDYYIWx5ofuACYz3N129JDBlps1/3hSRNe
	 aaVQm2+xkxBc+jhXKL2u2a+UOUNQKoa0KJmGclE1ROFGeNK1uZRrinN0KjLFWgCvg4
	 M8jcqAYd+GLGnbaB6iyTL/Q2SD1tTPyR+E6AG25eOMcQzlecwbXJ7pc2Cp1sM/p3E+
	 11grw/GHv2c5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27BAFD38A67;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Add table captions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943315.11416.15873380793328870156.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:33 +0000
References: <20240524164618.18894-1-dthaler1968@gmail.com>
In-Reply-To: <20240524164618.18894-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 24 May 2024 09:46:18 -0700 you wrote:
> As suggested by Ines Robles in his IETF GENART review at
> https://datatracker.ietf.org/doc/review-ietf-bpf-isa-02-genart-lc-robles-2024-05-16/
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 184 ++++++++++--------
>  1 file changed, 102 insertions(+), 82 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: Add table captions
    https://git.kernel.org/bpf/bpf-next/c/6a6d8b6f00ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



