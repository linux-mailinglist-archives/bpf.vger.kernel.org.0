Return-Path: <bpf+bounces-51074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53101A2FEE1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7424A3A6C45
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3271BC4E;
	Tue, 11 Feb 2025 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgjB/j6M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396971361;
	Tue, 11 Feb 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232604; cv=none; b=mIO9PI6B26R/AjGpN9PITqFTl5bb8T/EgJ/JlnQHDmfyPB8/a6L+7M7/GCNe3HWhMKqfLXQgyWvG+WEKCUUefHI2AL8NI4spzWd7LxTfQEMs2UzfK1DvHJ6cFReLkTuLXadd6P/SgVGA3we37B+1lOICR2cH7HhvI/arVgge4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232604; c=relaxed/simple;
	bh=rM8Z+zDTFOx3yBGI0rLntJDaItfj9kNC4JjtF0vDjbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MrrCFM1Zfsde7aauL23mBxwNThTrwGUD47IARCnqLW0yKBzZh4SnBes5gU+GCZsqAezhXGdcJPdImJNDk187c5QEGWuPdHrTthRnT35FQXTa+8jEONq8BiFKdQc9ATtPuKJStWV1+q1BcDoBLKWuymz/k3qBfMgOmkStACN1ySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgjB/j6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDA8C4CED1;
	Tue, 11 Feb 2025 00:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739232603;
	bh=rM8Z+zDTFOx3yBGI0rLntJDaItfj9kNC4JjtF0vDjbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HgjB/j6M7C/ob/SRBjzNbKXE/wO+Ezg2fLlBGGnqLJm3Tgw2BGvzA9tXh94NZeWaY
	 AsCvwXLHJBvjPDn/pV9T1TyBHbAZXZboWB2AQr9/W7l7hWBOUil9tVT2XDnuvMCGkZ
	 wZcuZhihMFn37eln91FNFNFP25t0aGml/DQAwruEG3m1Pp4F8X7KdTpzbxc4scCmgy
	 9VKeF/Yrm5luOqVNaApgthInlqapyO5k/eUHFRvAnJyDqGuE155yhK8LZDbMIOokSu
	 BQHaX/jf5UlyZNdEq4aMg9ftgtt9M/wqIWajEAMsYq3P70gd4B+1+oHWvozL1NPy8Q
	 BIuvj1PODukZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713C0380AA66;
	Tue, 11 Feb 2025 00:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/1] Using the right format specifiers for bpftool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173923263226.3898484.17293539222472582075.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 00:10:32 +0000
References: <20250207123706.727928-1-mrpre@163.com>
In-Reply-To: <20250207123706.727928-1-mrpre@163.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  7 Feb 2025 20:37:05 +0800 you wrote:
> Fixed some incorrect formatting specifiers that were exposed when I added
> the "-Wformat" flag to the compiler options.
> 
> This patch doesn't include "-Wformat" in the Makefile for now, as I've
> only addressed some obvious semantic issues with the compiler warnings.
> There are still other warnings that need to be tackled.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/1] bpftool: Using the right format specifiers
    https://git.kernel.org/bpf/bpf-next/c/17c3dc50294b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



