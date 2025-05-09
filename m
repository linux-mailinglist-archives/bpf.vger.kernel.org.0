Return-Path: <bpf+bounces-57910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4229AB1C7C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9FA1C285DE
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13024290C;
	Fri,  9 May 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG/XKNJi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BA2417EF
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815993; cv=none; b=RK/IJXkQGh6/qx1XXFvcHOpIi5AeitgL5vB4mq6TyBIUF9769GN6d5bFrxjkjy+mZsHF7k9+eCnhDqBVF5qSzI5UsNR6dIQKJRDgFJR522hNvdkoC1KbQxJBx6IDocgCIQy1mElFIJEXgVKthD2NJrCYeovfSMBtWXOx24Y7k5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815993; c=relaxed/simple;
	bh=Kkh4S8lib/WXWjSI+lUxNVf1t/Mxh5uy1HRdhyMAsBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fn+PHVQnEkqzUj1YNR0Enme+bN5uaE9fhKscWsjegNRPthHD1yqUkIHUz9yxPrI5agOrnd5YSnm7xdAV89uUVErf/DcIqBxkfwH/EbMrYrmA2H7LRdaGJ9qboVHp/jfN579SdBEIeHBLqX3AliGfFqBksr6dIlDyNe4MBxc57/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG/XKNJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1B7C4CEE4;
	Fri,  9 May 2025 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815993;
	bh=Kkh4S8lib/WXWjSI+lUxNVf1t/Mxh5uy1HRdhyMAsBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EG/XKNJihHgIJajIJzcfGFF0yBwxnOv0fN/9a/MBPJPrZ57NRArIoMWT5H+cEsXP4
	 l0GTCxQkItBRV6bRPA6cjraVfkx7cS8KVBiNwkOrPC4pCQbI8nwKNoIvhfMGgFFq5S
	 MHU3YpW9O+3y/ADQyUWqmuZrR7wMz06J5PxsTeyjXNObmdP58Kz9c9gp5RGuC2DdLM
	 6ruj+h6YoeII0ip76XvZJn1YoGk8Zz26Q3rO2EQ/ZLcb48RCXtykPh2Ynizz5K02vP
	 fWa8GbLql6PdwyJ809YfajK0h0WyrgwZNZ15a/Oh9+nYisklA5eDDYW42itsohlz2n
	 kAir9aEuTfXvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE7380DBCB;
	Fri,  9 May 2025 18:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] scripts/bpf_doc.py: implement json output format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174681603126.3715348.10233513824645908854.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 18:40:31 +0000
References: <20250508203708.2520847-1-isolodrai@meta.com>
In-Reply-To: <20250508203708.2520847-1-isolodrai@meta.com>
To: Ihor Solodrai <isolodrai@meta.com>
Cc: qmo@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 dylan.reimerink@isovalent.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 8 May 2025 13:37:08 -0700 you wrote:
> bpf_doc.py parses bpf.h header to collect information about various
> API elements (such as BPF helpers) and then dump them in one of the
> supported formats: rst docs and a C header.
> 
> It's useful for external tools to be able to consume this information
> in an easy-to-parse format such as JSON. Implement JSON printers and
> add --json command line argument.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] scripts/bpf_doc.py: implement json output format
    https://git.kernel.org/bpf/bpf-next/c/cb4a11925268

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



