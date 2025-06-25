Return-Path: <bpf+bounces-61482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E83AE748C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 03:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952CC17B2D7
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67F19B5B1;
	Wed, 25 Jun 2025 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJcqiFwC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E4870813;
	Wed, 25 Jun 2025 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816782; cv=none; b=uJv3VQAUvXY9CHamjmIvhKDZ2PkQDmdS/QGwlKZse+G8S2Vt8PrDLGLX/rzy41QlA6Q0F30eapWqOeecUu+ccte20cHtcfce27ElCYtP3fvstmifd44AhuDOIBRrwr6BVMYTIQOtujFImfT0PA+NZrMlQ62DJBjRmClpht+o8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816782; c=relaxed/simple;
	bh=p321NOPiKKCXR7/+lYUBJLmzftRWSBvapwOVICGLLMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jXGxP515pw2T7HE/cDTzgekD1oQbANcNogTGyMzFSXVAL+xMfWFrBj8xxNP68w6FlvFJOewSLu+BSg6tI3QsJEupqVjeICgFbxbn9EMRXitsgimr7gqoaXebN12DIhrzbPWGsgqWS/B6nHCOznELEsP2YzeTZbxERww+klAl6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJcqiFwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64528C4CEE3;
	Wed, 25 Jun 2025 01:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750816781;
	bh=p321NOPiKKCXR7/+lYUBJLmzftRWSBvapwOVICGLLMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJcqiFwCeDB45p4AGW0njG79OmfMuYME76JuBvgZ3KHobg/Lr8OAiVAU10EzsWZaP
	 nGhm6wl5qDkntDGm4bt9DQMZsAOTZME1qWb2Eu4zdDjrsjZPqWxT12jP8ZuqX7gjYD
	 4skK8t7VsJnlZLU9iy3IdfQwK9Tr9My32maCsZ1X79f/RE49CzFF95Wv/eqNc13JPw
	 T+eLG7F5M8eN43I/5v9A1Wkm+B29RxXJgZmOPjeXgDfxuYRke5gKHzpjJc5R8o8+Id
	 DC16xnEpahQX5vhFRmwpqm1ACEmop4syfG0B4f+VjAQH/FhVWFj63tUY8WPpzeauW4
	 ViATkyMD30iCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4A22039FEB73;
	Wed, 25 Jun 2025 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] bpf,
 verifier: Improve precision of BPF_ADD and BPF_SUB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175081680825.4102668.16640418719234698848.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 02:00:08 +0000
References: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
In-Reply-To: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu,
 santosh.nagarakatte@rutgers.edu, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Jun 2025 00:03:55 -0400 you wrote:
> This patchset improves the precision of BPF_ADD and BPF_SUB range
> tracking. It also adds selftests that exercise the cases where precision
> improvement occurs, and selftests for the cases where precise bounds
> cannot be computed and the output register state values are set to
> unbounded.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [v3,1/2] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
    https://git.kernel.org/bpf/bpf-next/c/7a998a731627
  - [v3,2/2] selftests/bpf: Add testcases for BPF_ADD and BPF_SUB
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



