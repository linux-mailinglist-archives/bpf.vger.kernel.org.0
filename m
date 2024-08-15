Return-Path: <bpf+bounces-37293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C615953B1B
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A2D1C240CA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644A824A0;
	Thu, 15 Aug 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdVuzD2F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DF5A7AA
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751436; cv=none; b=W+Y/vgteHc1YsIATLZL4gby55wx56HPffGmnaAUoKrEM9ii45Kqh93UkkchaHZNrgkmSQYTyTNvdfN+uKOFlztl1WkrgBLQtMnVKOCnNE/sWboFbmeDhXdMo+e83oFjYgRgMcfryTZBI+9bXh9fHcHf5ZXBvQMbK4WLDIGpb1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751436; c=relaxed/simple;
	bh=FnyFLCpPep/uCXoAo9vODsbmGrdIsfhKkC2Be5wE8rs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PN92+UKOp4AoO7au1Ybg6ucZGDcFzm9nHEEbB4CQS0cNHoyb6ul14nlcO/Ydp2i/owKDyvdfkLeiISG8vCWIzcPlWtUf0WoVVd8VzHnB3Pg4XzlWFv52WJd8vnM8UnL2m9+q4JHjKKLDpB8iDQoUyyeHXvrp/LM4tBdLSSigp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdVuzD2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07737C32786;
	Thu, 15 Aug 2024 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723751436;
	bh=FnyFLCpPep/uCXoAo9vODsbmGrdIsfhKkC2Be5wE8rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sdVuzD2FHnxFe81Bxk052aowAcWDnkWLh5tX7ccXKZVkPh/CVlnCbv93Hiw3vOEy9
	 iY2B4E21ds66WcN+2eRbb0FTXnHDrYaGxHs7YTjEWyhk8LlDQTRN4zOj0UuZ/l2HgC
	 jv1szohtycq6/3MKHmpH33i/xeg7Bs/Imoek8Te1gAyRDEDKVwZWwljT4WMbqF2p9I
	 IpGoZJHdX6RjD5A7Zr+DE8BY70Xguy43NzU4RMq1kOW3iQN0uirXCOIug3neomlxDH
	 W8InXzDlAT8fZBYdeEXjHp1dxfihYXdo7knARHNpqv2H3Rlxvd/ZNeJIlR9Ii8QB3K
	 ILhFmNhlHPUuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF9382327A;
	Thu, 15 Aug 2024 19:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/6] monitor network traffic for flaky test cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172375143529.2996010.3717574409082481079.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 19:50:35 +0000
References: <20240815053254.470944-1-thinker.li@gmail.com>
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 14 Aug 2024 22:32:48 -0700 you wrote:
> Capture packets in the background for flaky test cases related to
> network features.
> 
> We have some flaky test cases that are difficult to debug without
> knowing what the traffic looks like. Capturing packets, the CI log and
> packet files may help developers to fix these flaky test cases.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/6] selftests/bpf: Add traffic monitor functions.
    https://git.kernel.org/bpf/bpf-next/c/f52403b6bfea
  - [bpf-next,v8,2/6] selftests/bpf: Add the traffic monitor option to test_progs.
    https://git.kernel.org/bpf/bpf-next/c/f5281aacec85
  - [bpf-next,v8,3/6] selftests/bpf: netns_new() and netns_free() helpers.
    https://git.kernel.org/bpf/bpf-next/c/1e115a58be0f
  - [bpf-next,v8,4/6] selftests/bpf: Monitor traffic for tc_redirect.
    https://git.kernel.org/bpf/bpf-next/c/52a5b8a30fa8
  - [bpf-next,v8,5/6] selftests/bpf: Monitor traffic for sockmap_listen.
    https://git.kernel.org/bpf/bpf-next/c/b407b52b1850
  - [bpf-next,v8,6/6] selftests/bpf: Monitor traffic for select_reuseport.
    https://git.kernel.org/bpf/bpf-next/c/69354085975a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



