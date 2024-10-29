Return-Path: <bpf+bounces-43407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA99B52BD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F051F2426A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216D197A93;
	Tue, 29 Oct 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPf3m0m0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DF17DE36
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230223; cv=none; b=dqQskj1Syl7zEFh0E8vfYT0JTgJd39iT5+jTt0eMUJpIrITswBNGTm158gqVFqCGangkBUeWopBdVeC8w/msTvCQXqBFwCBZX0zLTXGYhS4/N0MaB1fqJd5NYYfjIrmtHJzBU4RVbOl8gUU5nWkVQqjfGm7pTjOI0ZojGDJTT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230223; c=relaxed/simple;
	bh=7s32WaC6kpY9pg/rSDmDC4Cmb9HC3DVd53SSWKySiJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tf62Gv39BEco3Pc9V6o+32J1pP8JhoZZjBQl6fREA5mHzi7Jqx7bDVF1TbahDF5u3mM16cCvEb2cW2prKC6o7rM2qAlS2+Y+ULwuPcPiQWI5wB5BgAjft0jKEt+xXi/R1xPDIDJN/tIt5BdurN6rYg3ggXYU8FIaDsrpwJdOhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPf3m0m0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29354C4CECD;
	Tue, 29 Oct 2024 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730230223;
	bh=7s32WaC6kpY9pg/rSDmDC4Cmb9HC3DVd53SSWKySiJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pPf3m0m0NfJORakuX0W+jOcuOH0WwAuwuzMVYA38GXsQGSscCeN1HyErSMbdfzJIU
	 6ojoEkJNrDlu8zy4zrEmM9/Y2Ktq/T55jcFPnYtQwV4iXaoHR32HDPocZRR0cMr++k
	 0518IeGoGd1dhOqs5PANhBnP8i8hsUOCPdlOjuxEAB8G/8EfwLWL+rVOYeJpMe0fJN
	 /cqTDvFBbmQQRMz1VZ0xz6V6Q8zBauRyo/OcqUsapT7cVRhtihbpM9Db+2O0SVaWu7
	 BhIxTTWint/fgj+LMEtsCvm+yHM1tqQFtXj4T93ln8aztp9nyIWpx44cFP3Qa7NeCN
	 iKW4HPhLa/dZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB48B380AC08;
	Tue, 29 Oct 2024 19:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: remove xdp_synproxy IP_DF check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173023023079.798497.18305131050147360052.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 19:30:30 +0000
References: <20241025031952.1351150-1-vincent.mc.li@gmail.com>
In-Reply-To: <20241025031952.1351150-1-vincent.mc.li@gmail.com>
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 25 Oct 2024 03:19:52 +0000 you wrote:
> In real world production websites, the IP_DF flag
> is not always set for each packet from these websites.
> the IP_DF flag check breaks Internet connection to
> these websites for home based firewall like BPFire
> when XDP synproxy program is attached to firewall
> Internet facing side interface. see [0]
> 
> [...]

Here is the summary with links:
  - selftests/bpf: remove xdp_synproxy IP_DF check
    https://git.kernel.org/bpf/bpf-next/c/0ab7cd1f1864

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



