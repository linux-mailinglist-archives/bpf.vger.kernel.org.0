Return-Path: <bpf+bounces-54840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65285A74085
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 22:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4520189A150
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 21:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968E1E1C2B;
	Thu, 27 Mar 2025 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6COfFjl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C81DED45;
	Thu, 27 Mar 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112671; cv=none; b=GAIsXX3/hHT2FF1SSUrip23/8Dyt8rvWPaiZu0rw7z6Z2xtHnpM/kfSkQAygiZxJRdviZdBo7rQNr+X5HfKHdbtPFbPfmpzLxLKXJB9mBQGh2vmeEHwi6gOEyPgfBxPMYZ2kYa/O3x4fXgYbQa7JaFWxa4SiTqd6SIl29oNk4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112671; c=relaxed/simple;
	bh=2JaAn98f3WVVTUV4zPmAkU4cOoVTOpFjAd0eloNL26s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJ5vre7eXNJFfEvNwaT+5miCpoKrVIgUV8UR+OrPDhGH6UVNrMQe1SW1EewZlee7yan9tI228JVc6EGGysZqONndwPlcTXeOyaoYB7EcFiIkr0wOPRGXWlascJANjD+uqmm+CdF+xW2J2jdK3kT0XHjyvOqz82NwWtBqC8ywoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6COfFjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BF0C4CEDD;
	Thu, 27 Mar 2025 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743112670;
	bh=2JaAn98f3WVVTUV4zPmAkU4cOoVTOpFjAd0eloNL26s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B6COfFjlmv44H/k8P+/lDonPywmqiVsjydXWYBGmwJNHXItK56LsIYYCHHQsNCi4m
	 c8rDyU3SMmrjRXWXb4ZOTIUkAjf05A0hKeJKoHpRLXReBDGuzUUW/eZaSoDTyRK3BK
	 Khjkc7cJSoPNhaOvjjnbXbD02ffpLYPlRS6fC9xq8J88o17qUC+1K/ophEYU+IZCQJ
	 iv1KIjQaCTnZm+pVc/Q5fL2DhtGYEeQcDDS7ejfsxW3Ab5DPvDhRvhFhRTA17cABWY
	 KgAGz2fwz++ipPkeXUlTM6Vzuk/lcC0EZZ4SLuQabCgAHXkMoLioP57G+iE7wt0m0Z
	 +AB0AExum5kcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7109C380AAFD;
	Thu, 27 Mar 2025 21:58:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RFC v2 00/38] Improve ABI documentation generation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174311270700.2230226.6627341491675246186.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 21:58:27 +0000
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, coresight@lists.linaro.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-hardening@vger.kernel.org, workflows@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jonathan Corbet <corbet@lwn.net>:

On Tue, 28 Jan 2025 01:05:49 +0100 you wrote:
> Hi Jon/Greg,
> 
> That's the second version of my RFC patches meant to modenize the ABI
> parser that I wrote in Perl.
> 
> I originally started it due to some issues I noticed when searching for
> ABI symbols. While I could just go ahead and fix the already existing
> script, I noticed that the script maintainance didn't have much care over
> all those years, probably because it is easier to find Python programmers
> those days.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RFC,v2,10/38] ABI: sysfs-fs-f2fs: fix date tags
    https://git.kernel.org/jaegeuk/f2fs/c/90800df0da78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



