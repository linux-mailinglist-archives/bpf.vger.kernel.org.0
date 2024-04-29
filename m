Return-Path: <bpf+bounces-28209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232318B662A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D371E2831C7
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F81194C83;
	Mon, 29 Apr 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxpNpnUs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87F143C7B;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432831; cv=none; b=I1kdrfzUvJwLhlRfL+Njw05Y16GIen0Oj0EFP8U9OZ9xpgnMJ+nsq4o3Yg9jdRtYjlXeseu5Qubn/Y/+zSGXBHC/Sy9Eo4vNeLbCDnNS4JhwLEqYVMEtRS9lVMgXryxgtqbHyAUfs009hkySuTcl2fjJlZ9mh2jlMhjCyQScJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432831; c=relaxed/simple;
	bh=LElMbMggq3zSz6XdauPhawjeA3vLA+Bs6XRdTckMpR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdFPgcp3yWOKVINpznast1g+Gff1p1gnKsomoWGt176Pow/CdbiB38AwqAZRObNZ/g9inxVYpJt/MZRLFnxpm6bRKHXkzikdj02Uh5qV2hADECoaw+hNl2nfOAFuLKufzeAPinwaLac4HVKgy0bG5MzkqCp7IaJbqXEfwtbhV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxpNpnUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 873CFC4AF1D;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714432830;
	bh=LElMbMggq3zSz6XdauPhawjeA3vLA+Bs6XRdTckMpR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lxpNpnUs5k+0rmKYl+7415cmxk8U6tWW9TmVUmo6eAavi7l/XG81oO30qYDDOTcs2
	 VYM2C6rjr9gfwO20uomeURMjiss7OH+NSGfcEqUCqg/Ynhe18BzcWRlJpY/pQHhzr1
	 RAqoc+NAyCQm/SXDv+XrMuoBo0pWmRTaMcQKRRZ8H7y2Mn+YUWRVe4t1SYyTXi8rLS
	 eXrJjWdKqpFHVGIdPSG2ziSGtIzb43zGzDAAX1uCIqx8y8EDJWYUe78wTCFtFw+5Kz
	 2XmokUgp8sKEWbQsA8g2MD/pjD110wSXP8fYuvWUR/qqPLu96usOVAL/zcwTgTBHmr
	 0LRLe8gvTwgCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78098C54BAF;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] bpf: Switch to krealloc_array()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443283048.1398.3977777743158984889.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 23:20:30 +0000
References: <20240429120005.3539116-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240429120005.3539116-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Apr 2024 15:00:05 +0300 you wrote:
> Let the krealloc_array() copy the original data and
> check for a multiplication overflow.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/bpf/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1,1/1] bpf: Switch to krealloc_array()
    https://git.kernel.org/bpf/bpf-next/c/a3034872cd90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



