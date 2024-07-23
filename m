Return-Path: <bpf+bounces-35421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4793A804
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158872836D8
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5EB142900;
	Tue, 23 Jul 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXqQ0iIp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776913C9D3
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766038; cv=none; b=aqdKBbyq88ag0NXEclTnJboI+g4qIxuC9KjCMNta4GJ5XOWVjP9bj07jamdVNfVlmiiGXzv/3eXmM1bNQGnnugZZiF29cpQ2YxrEpubIpOJPb2jY35/GujaDeb3Zs6DniVx5W0DltLoBgRwxNSpUHpPx0/8kDYO3i2zqoL5buv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766038; c=relaxed/simple;
	bh=TbaSHovEzPsljM7G/yiGXsm82zphcvUd5tt5SWeWzWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rT+Cog3vc0Nq68Z7n/Oo+IOsIzaYq7Z2ZzYfGBgzy8IP0qLR7b23Hm58n2oaT+yosdxCKGtrMULG1BXY5qkh6lvQm2X4Qhk3eaL7TJ4/ILwASCCxa8cDiaH/pSaBd9LPdkW9OBXxC/OtV/U39406vaALL+5BLdtPVKqDbZY66Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXqQ0iIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB00BC4AF0B;
	Tue, 23 Jul 2024 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721766037;
	bh=TbaSHovEzPsljM7G/yiGXsm82zphcvUd5tt5SWeWzWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXqQ0iIp3rnXFsLLfU2x43vpoFUGTxprFkZKtioY45GF8pbKc2ZUphT/1cmCo1v83
	 b1eLoxvPwSej0cfnA6+oEDvE+vul3h3baZsg/eOdaoKooz8EtnHuzJGgjG9lX2yOdT
	 adrFdsr6whYUDTOA9CSbFLxx1RGRDBBJBQmOGNwpWLWbiFGiSO7JF+n7ALky2ICCmi
	 zBpVS8MCr3+LZ0nood2sd47GeFi4scM4d5FO6rENI/zwQfLVuaSiTXg9jdTeBZmgY0
	 /t4K496eUptz/JoF0vxM60A8g0GhpDjugRP1AL4dmGoWJgyyA09GoM7R2+idT4zL8U
	 buikt6My/Bj4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7C4AC4333D;
	Tue, 23 Jul 2024 20:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: don't include .d files on make clean
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176603774.22487.12969691506447753923.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 20:20:37 +0000
References: <K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19HRx4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=@pm.me>
In-Reply-To: <K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19HRx4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com,
 andrii.nakryiko@gmail.com, daniel@iogearbox.net, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 Jul 2024 03:07:00 +0000 you wrote:
> Ignore generated %.test.o dependencies when make goal is clean or
> docs-clean.
> 
> Link: https://lore.kernel.org/all/oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQMp-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=@pm.me
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: don't include .d files on make clean
    https://git.kernel.org/bpf/bpf-next/c/76e17a202fff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



