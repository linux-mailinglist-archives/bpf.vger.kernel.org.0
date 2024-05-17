Return-Path: <bpf+bounces-29905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF178C801C
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE55D1F22D5D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45507C127;
	Fri, 17 May 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB4dO+bP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346D9470
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715915429; cv=none; b=a8yQn2n2vjrH+jMg+CyI3GmKj9zPOMUuxnf9adCnSDzXcCIEFwe1Bsgi0tvnK2ZYJy2aU/2LMaLYXiDQgtmmGNjWS5qHG7eq7XLVIkEddwGtEHnjZP5f1DP1aO5yy51Qg4qr6rid6gf/31VmNEiOAQfbV+h9Ds7bz7CJab5cyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715915429; c=relaxed/simple;
	bh=8vPMdZoLViTgzL393LTbDVDbffZPUaU8l8Jyemsh2W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWe2h9z1H6gLDiYUb0MDpXH6FtUmHJXhq5e2OYOw+BHUccWmvIwSgAb1pOi7aXLZYYk8GnVl4xoUUA52i8RO6FQnLmaB5MrEymqO/SMLPmKEBljAFs4uw8fnME/yqKYkpo1UFg2c7XaqwFU3Og1KZHoxxZRVL64KoEZoD6mp4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB4dO+bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59CC0C4AF08;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715915429;
	bh=8vPMdZoLViTgzL393LTbDVDbffZPUaU8l8Jyemsh2W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZB4dO+bP4PRTV7R5AXdg9BUsdkh7K7X2XL0hXOYxE0XRxVf6ufZAMmxrgjMOBMqNF
	 MT2hK4bZiFsLFLmVX1EyNOJhk4s1YEUJfUdy4+MuylXQC59FQQanfxRnKhyiq1ayyX
	 wPIWNxeMQIzGS9LGbvfvAL60a08IruwY7ASbWbVMg9vUXVXdWlAmhflGtmTpowsReR
	 sDcJaazzL9tnnxo9MOQSykcZ9zRwfalW9gGtCJDQb7wTaC0yuKpYyVFUNKDeGA/v3w
	 n5wYU+8nKhEoV15rncfQqxxhxpQmzvM/989XRKB6XiDdQUbYb1akiKMgdP3PBcz+lu
	 +zi4J3s6fWDdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 495F5C41620;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] kbuild, bpf: use test-ge check for v1.25-only pahole
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591542929.18753.3063348546415616055.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 03:10:29 +0000
References: <20240514162716.2448265-1-alan.maguire@oracle.com>
In-Reply-To: <20240514162716.2448265-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, bpf@vger.kernel.org, masahiroy@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 14 May 2024 17:27:16 +0100 you wrote:
> There is no need to set the pahole v1.25-only flags in an
> "ifeq" version clause; we are already in a <= v1.25 branch
> of "ifeq", so that combined with a "test-ge" v1.25 ensures the
> flags will be applied for v1.25 only.
> 
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] kbuild, bpf: use test-ge check for v1.25-only pahole
    https://git.kernel.org/bpf/bpf-next/c/0545f3c64add

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



