Return-Path: <bpf+bounces-39787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E249776C2
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CF91F2540C
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA01D131F;
	Fri, 13 Sep 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BulptJsz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291955886
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193430; cv=none; b=DmYlLbCiByUXAIOuHcJ3u5CbG3fybA4IP1ktT9UiGqobI6eVxj+HcIELBxFe0+od3azKqMWzMBjyme4WPvS5nyATxiFwpbQsHIFnNtF4DZvMuLT3OYM0OH+rEvsVYUKF5+bewp54aRerKWimYpZ29K2zFSwBBlb95dGbO4bNN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193430; c=relaxed/simple;
	bh=1MghYZnAW8O8gU2py4i6PyThk/OGbP4k3KKll7fYICg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dS5Bzp5OAC9u+TOg/GdR52a+dQRGqM3Q8LuqEwgsSNzfavYN1/6+KCdeQJd2goBSw7JyIyKLZQerj4QGkuHgdmY3pLXTB6hrZrYXUFjTz/87XWMXtdGzO9u2wP5KsCGaYlfLTbq2ft0OhEiZYaIK0ZIWU2s84k/G0KgyTa5xIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BulptJsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF644C4CEC3;
	Fri, 13 Sep 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726193429;
	bh=1MghYZnAW8O8gU2py4i6PyThk/OGbP4k3KKll7fYICg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BulptJszwi+oNSvkbMaBjNMUwKkrK4YJ8DwUF6z6EIjN2Oh3T5CmMmwPY8+9MQZ0K
	 SGNklRS4NFNs8d3L0dCMSQzVz8NsTuKQ2R9odKaBI5GKmRuDeowGAyFy7meIOdpO86
	 FZyzBgbsLiA2+b/nJ+Rb+/owNpWh7xkQ8uftDItHhfWrmrRNZu7ofbwmSm4So/wf3Q
	 7UBVKEkwM33X/cwapPAZRYKURpSSpQphTgUHvHNEbPWx8OTy22psPY06JgcxxJJ9/r
	 Ozz8qwy+KFN8B2KQXO5C6PGsdQPfmu8f0MqH/QGfeaeDlMeKyfjJxveN0C931QWeNe
	 OY6ksiv3z5xzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342313806644;
	Fri, 13 Sep 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: add bpf_object__token_fd accessor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619343101.1787335.11821510921583247434.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 02:10:31 +0000
References: <20240913001858.3345583-1-ihor.solodrai@pm.me>
In-Reply-To: <20240913001858.3345583-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Sep 2024 00:19:02 +0000 you wrote:
> Add a LIBBPF_API function to retrieve the token_fd from a bpf_object.
> 
> Without this accessor, if user needs a token FD they have to get it
> manually via bpf_token_create, even though a token might have been
> already created by bpf_object__load.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: add bpf_object__token_fd accessor
    https://git.kernel.org/bpf/bpf-next/c/ea02a946873b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



