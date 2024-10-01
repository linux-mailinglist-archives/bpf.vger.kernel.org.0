Return-Path: <bpf+bounces-40703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E798C4B4
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED3E1F241D2
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E11CC171;
	Tue,  1 Oct 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktz1tZuC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D91CBEBE
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804428; cv=none; b=DP19ufGHVmpB61qzfreJHxJYQnWWn8NU/RCCMww8H1dBgaBrsUPnmfcAqDr2nssbVVAmiKyJiZq+UDp1Y1ZFdihSBxH9Vm3aDqJwuH88AHBwFvKALXy4vfJIbKMSbDyDbRCOaKB4LSSj9LNFICnve2Xl3OzOrsud+eLWMKqWLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804428; c=relaxed/simple;
	bh=IasBCox2r7CKyQqHz4wSv9E52WGEGHEKLBlf3kXyQJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pHFX8uLuQRIquvobp0QcxKmMO3dwtXNdcXy2lUlfwrUJyJub5+6nYDswtB9Y/nGxjdDWQHD7JIVVUzw4rFcr4bJkfscdaJe1ZoOOFVzbELWDAZKXX3v914TfcaWFWlcfvH1n6UDkIO0E2iGozqoZNZ8fbJ6cdR4+hKd/YDQuZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktz1tZuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548E2C4CEC6;
	Tue,  1 Oct 2024 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727804428;
	bh=IasBCox2r7CKyQqHz4wSv9E52WGEGHEKLBlf3kXyQJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ktz1tZuCWVKzg5UD/2gMTIzMq9nxyS/DbVyGww5KY3qQYy62jI4e+nDyhSbcNtkvn
	 GqEYs/JoX5ekn18guYzN6Nr0h+8NHKN3opM0LH2b8d3b6AOEC/0yJbcb/AK3WTDKp2
	 nodKo5buoM/U6AbPBJhKMNMJ0W0jOxJ16HK46fPRJ+I1yylOrXoD3x9y4XZCnVWb1T
	 wmgS9dvRr72VPW8tS8PRMpvyEyodf3GJl3bS5CFxEG8ITZ2D6Fcl5zxcr6e6x62bRb
	 3K88xVVjd21meAU8SFqVLEMzU8wCGc1hb7GqgS2RKPOpRP+xd6ZvvxBL2rWRf46jAN
	 xPH+O5NsUSQQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD82380DBF7;
	Tue,  1 Oct 2024 17:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: emit top frequent code lines in
 veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172780443151.469068.16605928339105374881.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 17:40:31 +0000
References: <20240930231522.58650-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20240930231522.58650-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  1 Oct 2024 00:15:22 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Production BPF programs are increasing in number of instructions and states
> to the point, where optimising verification process for them is necessary
> to avoid running into instruction limit. Authors of those BPF programs
> need to analyze verifier output, for example, collecting the most
> frequent source code lines to understand which part of the program has
> the biggest verification cost.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: emit top frequent code lines in veristat
    https://git.kernel.org/bpf/bpf-next/c/9502a7de5a61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



