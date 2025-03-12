Return-Path: <bpf+bounces-53928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F1A5E86B
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 00:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8E03BC3B2
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBEC1F30C3;
	Wed, 12 Mar 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXTaAvep"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA31F1538;
	Wed, 12 Mar 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822200; cv=none; b=W/HvdGH9YWjk34xx0sbfTzrWEsDU+YMNGISg90Me+CqozvPkJRfLah//iH961zNvW21cf0LtzrXz9pEaiF9xzzaukWEUTLt6OiPdqrHpwRmd6+2Emsogni4JxAJfYAUjx/lgk/B910ryFX1OoJMq4MnV+eV+u30jcb7XTxuHbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822200; c=relaxed/simple;
	bh=YMptz345m1LNoU+b3XCW5SOKoiYhbOWr076vRIAtRbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hYr/o+UILu0lZeYe+TUpB5AKv4NoeqGUhQ1P3r/iC3C78FABHNPGEbWFNC+CBIuYfTTojlRM9Y9ukylXcVWNmfQ+V71k3wJ06WRszub0XhFACF3HX7gZSNr34I54Is/nAm05w9CcGHMM0EktcBNMh4fPTkugsA7SF61aI6cBEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXTaAvep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D72C4CEDD;
	Wed, 12 Mar 2025 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741822199;
	bh=YMptz345m1LNoU+b3XCW5SOKoiYhbOWr076vRIAtRbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RXTaAvepU87fVFIkhelicafEE5UI7q17LlhFJAK0bPnVmg7dJtKOh1F8FV0S33us1
	 ZHWXD1qLbYOfN9iHSU2tseyc4GAlHfMNgkDmk0s/fm6ntZDC8F4RVn9Kc8Y7DAWAlx
	 5CHilHR5jeCEd3LSh1ieCieHYjdb1BpVVivXKeC3tLwrH9Q4g3IkPnzLk0IA0e3qfw
	 krsNdqQRkhGxvTpqtghAHvMVJ/lfqkPwDhMhe6nDohhQfgMrj1VfJOousBVC/gCEPg
	 KxWeomuVWduRPGi96P3rJINKgQsCzIyuoMK2YfI7os9zxDOZWmsZH5yeS36Phj4AcM
	 0U51ncotwMyzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C50380DBDF;
	Wed, 12 Mar 2025 23:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: preload: add MODULE_DESCRIPTION
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174182223399.971369.16485198767669764357.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 23:30:33 +0000
References: <20250310134920.4123633-1-arnd@kernel.org>
In-Reply-To: <20250310134920.4123633-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, arnd@arndb.de,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 10 Mar 2025 14:49:16 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Modpost complains when extra warnings are enabled:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/bpf/preload/bpf_preload.o
> 
> Add a description from the Kconfig help text.
> 
> [...]

Here is the summary with links:
  - bpf: preload: add MODULE_DESCRIPTION
    https://git.kernel.org/bpf/bpf-next/c/be741c7b2caf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



