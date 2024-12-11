Return-Path: <bpf+bounces-46676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C39ED9CB
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 23:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D67281371
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6071F37D5;
	Wed, 11 Dec 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEl/CjW1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212D1F0E3D;
	Wed, 11 Dec 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956339; cv=none; b=nAzr3ZPrz87SMP+qBY6lfz5fK84yqrLg1hAf2XmcDeuDBttgBK6R87Eq+JsTPyhz4Aq8Q+05qzVW/MmIwGhKh4xleqsNB1+zipUYS0Y2hxvgOdV7+gVlD+zUp9L6G/hTiQWSsZFd/Jz3Rkjtf93xe+/yQYP0z15BIXm7IZdk8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956339; c=relaxed/simple;
	bh=DPm05kHltpEewW4iDgoVf8//KAwPkxNr3T75XSMhm5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mu8ed/5LxODIBOgx1CVCsQhqujHKd0T6uTRZzJX573Q5+yqinFb9GWZC3G9jZO/KfiwtJlnZavetJ3RPZI87NcbwbAIE7sgJZTX4WPL1BJUOx4wos3LyRqg1rIVxmsGeCZBcjyLB/BovCF5IHugxQ+uOd23pz1ZzMr/fELSKruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEl/CjW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF6BC4CEE0;
	Wed, 11 Dec 2024 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956337;
	bh=DPm05kHltpEewW4iDgoVf8//KAwPkxNr3T75XSMhm5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bEl/CjW12x/WoIvT0JWZgDNgZNOG4yAoYC8fL0DTwLdezKSKaxNahz4l0MkfpU6HI
	 4Z0awS0oUbkFLA5ytXctWKXdm3FkV96b+lGzdV4QrBP8Q9gi7rF+xoGEn1cqPjCTbD
	 4ixH9fVSOk9M8hjH27Bln24p7sFWBPpRCxEQJvBLtfDS9OGgON02gn+P8QQsc/x3cC
	 l97z+90OA+7W+njKtuF8JBUHW++MAr7TIeNMXwTJfnOiNHSVxqJRIaf0iDMRLSG+7q
	 u45yKS67+kWXugIhvUjZwdWZu0K6kYYq4nAhlRYOdXqYEcePS137K6ylmvKn1X1i0J
	 Keb6S45Y+tHPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF29380A965;
	Wed, 11 Dec 2024 22:32:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] tools: Override makefile ARCH variable if defined,
 but empty
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395635324.1729195.17131106959498810013.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:33 +0000
References: <20241127101748.165693-1-bjorn@kernel.org>
In-Reply-To: <20241127101748.165693-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, alexghiti@rivosinc.com, acme@redhat.com,
 jean-philippe@linaro.org, qmo@kernel.org, andrii.nakryiko@gmail.com,
 bjorn@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, davidlt@rivosinc.com,
 namhyung@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 27 Nov 2024 11:17:46 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] tools: Override makefile ARCH variable if defined, but empty
    https://git.kernel.org/riscv/c/537a2525eaf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



