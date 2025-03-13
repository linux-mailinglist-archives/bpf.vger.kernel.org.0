Return-Path: <bpf+bounces-54004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE8A60369
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00536880985
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0D1F5423;
	Thu, 13 Mar 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsWMGa4g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745E1F4C9F;
	Thu, 13 Mar 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741901401; cv=none; b=WxlqbUuhl5aUsykO9xMohiU/8tiha5xJoYHjJUqESwGaU+Nf0aurm0U3yLgvjQpq3Stjyx/242z3VBbhlpYAzoIhWn54brF7XoXKGt+0szTY4Ap7O7klNvptJPceG1m+CHRmaqeXaCSxVBQRkPmnT8oapcjrTOouy5VP2qNM78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741901401; c=relaxed/simple;
	bh=+VKA+VjweHOiiA6Qwmrm0Tjgy2mkHOEccZA2UFvXomM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oWf1J50vgHFDJhnXuqu51u6iP1Hxk+jk7CI8XN47NOe0SkQ3ouxmKsHlQ3CD/LqmYT112SyNhXnw10WcrGWXZmelotnjr5JI8FOf96JVgXfCgifVZiIILAfIct2/Vf89AjQqqiYcJ5wYITKHjHRj9iYLtWsCboe1MlH4WB7J8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsWMGa4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ED7C4CEDD;
	Thu, 13 Mar 2025 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741901400;
	bh=+VKA+VjweHOiiA6Qwmrm0Tjgy2mkHOEccZA2UFvXomM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EsWMGa4gDQP8aDS5prx1nSrIXBYfhq8f8OjAJoWOJ0vbYVCW60ondN7l5hKVjyDwO
	 8pvo/RH5phfy4O6e6aysTT4OiPY1GmEKfkrWYHLwJmfTHFiBsnazwazZXF1MxdEpb5
	 ySzBZZhz8eUmHwE8+kCE7Gv3sapFhYjAisoxnqQU681JuDN88ZMZrBPhasyydwovGc
	 m9kv2cJc5ODSu526ekCVZppshCx8JSyZLDCFGQF26N3qeAv/sYzAIsbQU3QHRppng/
	 //X6V5jpvmUiYLo55dEcJeRpBak13ScJLnUGDpkyDJCJRXNWkEfrrf2rfBqIdHin66
	 RGUcK9X55utjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAD3806651;
	Thu, 13 Mar 2025 21:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix sockopt selftest failure on powerpc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174190143525.1668543.13643963297500248879.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 21:30:35 +0000
References: <20250311084647.3686544-1-skb99@linux.ibm.com>
In-Reply-To: <20250311084647.3686544-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
 andrii@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, miaxu@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Mar 2025 14:16:47 +0530 you wrote:
> The SO_RCVLOWAT option is defined as 18 in the selftest header,
> which matches the generic definition. However, on powerpc,
> SO_RCVLOWAT is defined as 16. This discrepancy causes
> sol_socket_sockopt() to fail with the default switch case on powerpc.
> 
> This commit fixes by defining SO_RCVLOWAT as 16 for powerpc.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix sockopt selftest failure on powerpc
    https://git.kernel.org/bpf/bpf-next/c/2d7597d67e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



