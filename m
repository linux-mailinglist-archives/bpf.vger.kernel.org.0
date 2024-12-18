Return-Path: <bpf+bounces-47154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E660F9F5B54
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF2016EF51
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756CD1D6AA;
	Wed, 18 Dec 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDqlMyr/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889919A;
	Wed, 18 Dec 2024 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481214; cv=none; b=g4NszkYmh1wtTyCx1uDYqSnRnYqJJPpTsKWu1gSRphMMBd52nDk3oZhoqy02QrUoxHgbjc3x5phJ2jL04p7cKApQdaCL/h9AZ46OLR96vsSJd/31E8VnmTyuZ8wFDqXpKMqPRubsKNNBFcgBraub1y29gSdDpglvOe7dxJRXY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481214; c=relaxed/simple;
	bh=eNsTcjRLApj1HzTKyL5cjeHbchPtp/hq6YsXYpLTaJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+Ymx3x/wTqL5W+c3TNqBNlH0ivKfd41G8gbBtBO7ucTbuXGiOyhfK+JqidCienfvXLKbdJXqxLk1heJiFs6RCoQwapVPSeKc/4U3XQK/ctpt5sv8O0lzgFYE8cxDIdOyd1CmXzq2hXW+OOA0fpyCvjk6yMnW25VYTO0gXYqwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDqlMyr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AD1C4CED3;
	Wed, 18 Dec 2024 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734481213;
	bh=eNsTcjRLApj1HzTKyL5cjeHbchPtp/hq6YsXYpLTaJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDqlMyr/0QaMZ6lln9jg81CVANPzHs0ZFKFJdkjOZh94ck7ScszMVHH2jEqVWkCOi
	 +1B2P01SUfNNj4dwSTIZTSaK6MhQ08kcuVHPVf+9aP4g2/IHyMlS6KDmIqxVD+SQ+P
	 BrkKhk21nQWj++xzvlyjHHcL3G3X99H8rImiJ0voTz0v8iZoWHOP/FZiEamHz9qXGV
	 2o3SDxErEXfGDu01m9tHf5nryePimvUUYSll1VHnvzDQbTgZ7yVkFKKEjryQgriEd5
	 mnshBHvTjIztrGMt9orxSD+7yVvFkq9h9F7wvdWiUZbDEdPZnw3NuWM4ds5j5CF8JO
	 Q2ehMzW52XcaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2EE3806656;
	Wed, 18 Dec 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173448123077.1129094.278515116622545492.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 00:20:30 +0000
References: <20241217195813.622568-1-arighi@nvidia.com>
In-Reply-To: <20241217195813.622568-1-arighi@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 17 Dec 2024 20:58:13 +0100 you wrote:
> On x86-64 calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP
> disabled can trigger the following bug, as pcpu_hot is unavailable:
> 
>  [    8.471774] BUG: unable to handle page fault for address: 00000000936a290c
>  [    8.471849] #PF: supervisor read access in kernel mode
>  [    8.471881] #PF: error_code(0x0000) - not-present page
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP
    https://git.kernel.org/bpf/bpf/c/23579010cf0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



