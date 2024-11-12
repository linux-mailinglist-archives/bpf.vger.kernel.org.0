Return-Path: <bpf+bounces-44591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E909C4DCA
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6131F24552
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32F208224;
	Tue, 12 Nov 2024 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gECO1TqZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4C41C79
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386420; cv=none; b=WZ6tWHYO6OQAbX8bzjnRDxFfJ0tlWmcUfxgQEczJJsne2Rz49xJ7yqYh/uthaU2XaOH8F/GSbfsEczIz6/FWhRRevQjh2bKVzULZAQfcbrWPT3ONhWE9bp5RgZcSWl63bnKqQLyxkYAGqZVlKnrl+KC/gZ+P7vKUy9olVStFMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386420; c=relaxed/simple;
	bh=tisZrx4TSNAM/ctFO4MHYbqQBeg4ubi0oaxlz1GnGLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V9ftYqPIq5y2RgCHSQSXtU87Bp+crE8CTRENOciSAWo6oex307qmlbDOO/8zY2Er1nkz3lbqx6hhKIX1A9DlyqH7WeSx2mn2TAjdXZzYYtoyCnD0zss/BkWmpyP7S+Q94Gesi3GWaB8US5WmuiFHJ3yxwnlviDHbSMRKTvHZsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gECO1TqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260ACC4CECD;
	Tue, 12 Nov 2024 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731386419;
	bh=tisZrx4TSNAM/ctFO4MHYbqQBeg4ubi0oaxlz1GnGLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gECO1TqZs67uuZHd2S6ZHbIkxTm9z7wubaB0T4psZr0PntqkjaIE6KTwiNuBBc99/
	 QXCG8jWvWYaw6VCqUm2Rp5f+TdVlvLhtDC9AyXkQwFDgVXz1kIxVQpkgUHBa4SK1aQ
	 TZGijkUyThxtchlQxBJ2H/JLcqagElyN2GPOvhkxKgKYopD9zK6bX87QG61SPK4RlH
	 OBV+M+7Lj56ttOeyeGOCmAqD2nQabX+UD5ivqaoMiJxB5Kc3IOQ3/H6/46vCWjEoaU
	 ZkBkbseQZgJ2MnGOGwEqImEhk47h4qOhOaxAifHDhx9aldIWw5zok250Un9cs1RUet
	 WvPtrzHSC7vgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D483809A80;
	Tue, 12 Nov 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] libbpf: stringify error codes in log messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138642925.82002.2282388771258860402.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 04:40:29 +0000
References: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Nov 2024 21:29:15 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Libbpf may report error in 2 ways:
>  1. Numeric errno
>  2. Errno's text representation, returned by strerror
> Both ways may be confusing for users: numeric code requires people to
> know how to find its meaning and strerror may be too generic and
> unclear.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] libbpf: introduce errstr() for stringifying errno
    https://git.kernel.org/bpf/bpf-next/c/1633a83bf993
  - [bpf-next,v3,2/4] libbpf: stringify errno in log messages in libbpf.c
    https://git.kernel.org/bpf/bpf-next/c/271abf041cb3
  - [bpf-next,v3,3/4] libbpf: stringify errno in log messages in btf*.c
    https://git.kernel.org/bpf/bpf-next/c/af8380d51948
  - [bpf-next,v3,4/4] libbpf: stringify errno in log messages in the remaining code
    https://git.kernel.org/bpf/bpf-next/c/4ce16ddd7105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



