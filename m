Return-Path: <bpf+bounces-29328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621398C1940
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E0281BDB
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D012AAE2;
	Thu,  9 May 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO+M6Yjm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C26129A6F
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292629; cv=none; b=WkdKk8263ydKPWHc9wlOZVjtfnbrKDGXRj5MMzH06eNv2x3cdexEDyNo0BtqIh3uk7iV4NgApHeQ0Re4ktQQrzTW753yoMj0U3QrkfqpNjvxRYRAp3BtxsR4hcGqx+6ADrS8vgEmLYHTSfWi2vir4/UU/GxBJQKlk7U8Tbx4+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292629; c=relaxed/simple;
	bh=SO/DwT+s+ekRmBJpQpYZih2QzTdIO1tby03ZwIca91w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mm8/uCTDWMQNHzjBrXONeNigeWHpxkf/Tdl5CuQPQ1V/hUvjsqSMZa6ixa2JDzGMK7q1+K9QAQsm0VnhOI2pt9PdUCMfe8dRzOAKVMC9rMjWQCsViHo8eoUni0VmxEtT9uXAAQjxM6Pdl3CYkIsNlD4KnZzIwIH0WY5yPCwiWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO+M6Yjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 711CCC3277B;
	Thu,  9 May 2024 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715292628;
	bh=SO/DwT+s+ekRmBJpQpYZih2QzTdIO1tby03ZwIca91w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HO+M6YjmWvFWFMNtM0xMG+lTAzzv3UuIFdyZxVCiLPHoUYNwUGUwTy9miWrz29jha
	 3/KMajhDsyiifH0aA1tGC/P7EfsE/k6BELkNbN6adGJctQy1RVGgI2FsvhnR1uZuvj
	 yBmqkMLB69mtkP7+Pt5U8UIVSe4WgodHugdtkTEZcDyuw40psI1KJ4Nvu/+RV//q8G
	 ME3q/wj6qP7XK4vUe35Ijnk/UHaqxcbhgLUc4MXBOOmdLxufgxFRUH30Ty+qFrqp9E
	 UohFxtiM77rpEndFV0ZJ7N56QgYtPnpPDHmhym9pQxFozWE9OGd0BkSLcSn1HFHSGe
	 2LcbY9HefHThQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E89DE7C0E1;
	Thu,  9 May 2024 22:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features for
 pahole v1.26 and later
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171529262838.12882.5688564513712055920.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 22:10:28 +0000
References: <20240507135514.490467-1-alan.maguire@oracle.com>
In-Reply-To: <20240507135514.490467-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, bpf@vger.kernel.org, masahiroy@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  7 May 2024 14:55:14 +0100 you wrote:
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
    https://git.kernel.org/bpf/bpf-next/c/fcd1ed89a043

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



