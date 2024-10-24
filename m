Return-Path: <bpf+bounces-43073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213DF9AEE63
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91BDB2703C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D61FC7F2;
	Thu, 24 Oct 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRROkaSJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6261F818A
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791625; cv=none; b=d5T2BoLvVJ1LpkHlnHvpX5QurwlxPwuYrZXdiyilrmAbg5zbZGiH6bXPrOCF1JLrD/0Is1x0GMg6seKzgJVnA3V19RJ8WmJI+rz9fbnhy0HKYJEDnxSg66rdidNoTRb47MXzT/E0lCDs3lfoaNymLM4/VeWCE5p39jlfVrYY6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791625; c=relaxed/simple;
	bh=ysUduXWCf5LygyQknOfRKmS+y0d3uOKwBM2UmmEN8cQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EBl4A+7XalnwHDxPE2yZhamRO+YJHoLJV8nSxC16SmMIho81KZ2uvwd6llBqku8xcdnSP4+FruRDqqI9GZCH4xpF+FBPzBChX+Ts6HubO9ph3w7/linYueQjwpC4rlILOxvG5ekRCXAsYSZIQoMzZUs3pozSEOewjidiMr7hWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRROkaSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1876CC4CEC7;
	Thu, 24 Oct 2024 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729791625;
	bh=ysUduXWCf5LygyQknOfRKmS+y0d3uOKwBM2UmmEN8cQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uRROkaSJOc94jA6iD5v2xo60slR3Nkh9/a6yf4z2OZ8/lKFBkWTsCsZHtiFaNSnLc
	 Gpgjdcepgkc3F3VaLfC44xwV85A0XbtlO+jEwWUaZx1vfxROAetktJMAMbN1WHzRCF
	 HGlMNLnnNg+m2bmDvpK7O1MnxKpImQyHRrn9ACeWEOXPG7DV0j3VkJUMl1RiYtKkbM
	 bNiaxQdEhHSTtOb92yAfDBVIBJXuVSp76uR4BwVCe3jVMAzYDWymTPx/NZph2zSmWM
	 wfhjd6BfgZMvNP+TI+fRnYCOnkPM2UKWv+n5BiIgMMqkdNK7hNc/v1Vslu7dGPEDKC
	 +sUUPXdUNokiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21B380DBDC;
	Thu, 24 Oct 2024 17:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] Add the missing BPF_LINK_TYPE invocation for
 sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172979163176.2323425.4141954543890547063.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 17:40:31 +0000
References: <20241024013558.1135167-1-houtao@huaweicloud.com>
In-Reply-To: <20241024013558.1135167-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
 alexei.starovoitov@gmail.com, andrii@kernel.org, song@kernel.org,
 haoluo@google.com, yonghong.song@linux.dev, daniel@iogearbox.net,
 kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org,
 john.fastabend@gmail.com, houtao1@huawei.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 24 Oct 2024 09:35:56 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The tiny patch set fixes the out-of-bound read problem when reading the
> fdinfo of sock map link fd. And in order to spot such omission early for
> the newly-added link type in the future, it also checks the validity of
> the link->type and adds a WARN_ONCE() for missed invocation.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
    https://git.kernel.org/bpf/bpf/c/c2f803052bc7
  - [bpf,v3,2/2] bpf: Check validity of link->type in bpf_link_show_fdinfo()
    https://git.kernel.org/bpf/bpf/c/8421d4c8762b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



