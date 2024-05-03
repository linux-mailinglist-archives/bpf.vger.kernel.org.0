Return-Path: <bpf+bounces-28493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510EC8BA6C4
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 08:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91F22838E3
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03512139CE4;
	Fri,  3 May 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPQnzs3C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529F139579
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716028; cv=none; b=mXgu8F38Rj3RNuHknojB5TvyvtRN3SGKkZEY6tlX14OdE6gKSo0Z9dX8NDNq8z9uomH0i96Zfsqdbziohd5aYO0/Tr2kYIV8wXiDK2u33IZqWNIgIk/bUyrYsVjcuU95lO00ELx3/+T13hNu1oGhuUNO2e3QT6Q7o4znBQSGXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716028; c=relaxed/simple;
	bh=+MEspRWLhC2U18JXj4v6AyBBc4Q/3+plN8KOtWsSrDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LfnQs4HZC26bHF0NE8PQsCNW/shPVttR3pbQnva6wYldiE7sgi2kh+CS/7AJcPWdoIAmAZ0eKxPoIT919dAv/5YrzvYMlwaBgDgm7z+azAjf9wWRgmhe1IKVqHCl11lbZAxFMwnNqkmcyV4/5CIDLGp9tlN+aJ1ojRcMgoix7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPQnzs3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D848FC4AF18;
	Fri,  3 May 2024 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714716027;
	bh=+MEspRWLhC2U18JXj4v6AyBBc4Q/3+plN8KOtWsSrDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fPQnzs3CO+A6vTkQBzNv/x4VTBzoB45pcIp55TBPCjE0G2UglFtUfSLd4i5/dGp8P
	 X0ruU/vUvBZi67fiXRZssUzCkhwziGU57sfoS7kTxs+6mnBaAYb81PfSB2YsvmbTIl
	 4cRlWzoYhj+nYOunrug6b3qjoupd6FEz7V6+d208gp1Ufn7G5sfeLLM0BHX/95nErv
	 lVqn3H5Tgj32dyNo+OobSy4gKH9u0JRRGdcQW8B68ffMd6fabQAHKJA32O3zgg1q72
	 e1f1Nx0yKlE3NV2KxvzNpQMzOr4O/jgIlEhCSXO7AIU6k9AkseK/KdtcQLuH0ZsbIB
	 wypDJg6vkkyDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5BA0C43338;
	Fri,  3 May 2024 06:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171471602780.12180.10592919600518510128.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 06:00:27 +0000
References: <20240428112559.10518-1-jose.marchesi@oracle.com>
In-Reply-To: <20240428112559.10518-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, david.faust@oracle.com,
 cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 28 Apr 2024 13:25:59 +0200 you wrote:
> The macro bpf_ksym_exists is defined in bpf_helpers.h as:
> 
>   #define bpf_ksym_exists(sym) ({								\
>   	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
>   	!!sym;											\
>   })
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix bpf_ksym_exists in GCC
    https://git.kernel.org/bpf/bpf-next/c/cf9bea94f6b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



