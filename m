Return-Path: <bpf+bounces-60883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D4EADE09F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F93C189CB04
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B317D346;
	Wed, 18 Jun 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoToQin3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E06522F;
	Wed, 18 Jun 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750209599; cv=none; b=JIp+VHZDgYfTpPO5pUJxAJgZZ5MXPdPH1yvaFE8by/S0ufuz1VfD/EqMJ7OvcKTfStSGzahFK2Cxv0oXbKkS9IjmVUy2E/O7prXxUlgRosGpiwarLaJwLmVPNCkxB9CZM91vu7Vy/6zPU2HOXhy4YYnWGHaVPM+/AwbF33stBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750209599; c=relaxed/simple;
	bh=nOK1F2fLwFNCFaaqse5vh/+uEsbqSBiETDGgi3+2988=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GFch+uICdxnIcbhEfb4TkDem+KDyjUZzs6qbYynlKYGjggFZXhk5fIbS3LxxyaS6jPymcVcylCdkhWqAGI7/JQiflUO/t4QJMq9mNw5jrF0xRvT19+pvziLcDg+J2BtI895PkcPMhnaFY0QrELw+NyRNnTt3BhikxRs0TK8cA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoToQin3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DF4C4CEE3;
	Wed, 18 Jun 2025 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750209599;
	bh=nOK1F2fLwFNCFaaqse5vh/+uEsbqSBiETDGgi3+2988=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PoToQin35CfTM/Sy5GIyxOlY0SmPl/j92D8UoXYbzYCXS1tTeJz9r0dWPbYcwXppx
	 lt6en6T8Fk++UCagpaRzJM7TBWxCM0OXKaKTiaF17DX3c156xE+TFhZkS1VGW5s3jN
	 8EWAxhhlGSiHwOLPVng4GxssoRQhSaZozbRAiHhjuVjd8TkyQasIoX+XjJ5JdsGhTt
	 WBVPCExw4D+ck/5uljKLK0pdKZ514bn3qAF4E5vm2Dftnlz8OYTfJGQG2aEOx8o6kD
	 u3J6RjotJ/Ml5qiNKm8Ie5zXCgS/CqNCoNZI5UeVz5X4Im/M3JMITT8gtibRDJeeSP
	 una2zoDZ/TOxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8B38111DD;
	Wed, 18 Jun 2025 01:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: bpf: fix key serial argument of bpf_lookup_user_key()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020962801.3757059.1481472277492875690.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:20:28 +0000
References: 
 <84cdb0775254d297d75e21f577089f64abdfbd28.camel@HansenPartnership.com>
In-Reply-To: 
 <84cdb0775254d297d75e21f577089f64abdfbd28.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 roberto.sassu@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Jun 2025 10:57:36 -0400 you wrote:
> The underlying lookup_user_key() function uses a signed 32 bit integer
> for key serial numbers because legitimate serial numbers are positive
> (and > 3) and keyrings are negative.  Using a u32 for the keyring in
> the bpf function doesn't currently cause any conversion problems but
> will start to trip the signed to unsigned conversion warnings when the
> kernel enables them, so convert the argument to signed (and update the
> tests accordingly) before it acquires more users.
> 
> [...]

Here is the summary with links:
  - bpf: fix key serial argument of bpf_lookup_user_key()
    https://git.kernel.org/bpf/bpf-next/c/bd07bd12f2c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



