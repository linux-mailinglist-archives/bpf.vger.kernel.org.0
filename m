Return-Path: <bpf+bounces-72601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A0C162DA
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863433BEB37
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC634E741;
	Tue, 28 Oct 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDJficuX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2D34DCEE;
	Tue, 28 Oct 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672632; cv=none; b=M6kqPGZXXdfvMemIu8vuB15yLrHf4GKmXHchAw87508Faj02zWRGjlGZg0b1unxNCq6hjUl6mHGuPjd/u0A8TjX3YJWvGzyPhdCC8NQnV91kh3IksBG8WHvE4SjrRZe60J7FDkYqSIXdnrImM1KjGpRAcqIjdCq1EJTKdsHnRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672632; c=relaxed/simple;
	bh=Woj3s72mV/WX0PMq0VicXsosT9wlQpW9h0rQMEXcrtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QECk4v7HJ/52DVP8bsNPsOCiYiCWtKy1GmIAnIByrh1R0vKekdZGTTIYj1NeNNLGE3UJoPk2Iqr35TGzdM/Ek9Oqf/LHiF26l5U00gyigxv+bs6Uxy8r8xD9R7zEFWscz9vGgbpB8Vi5Fu9O41TPnDJ/O85Ej93fPN/NWvlP+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDJficuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75182C4CEE7;
	Tue, 28 Oct 2025 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672631;
	bh=Woj3s72mV/WX0PMq0VicXsosT9wlQpW9h0rQMEXcrtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDJficuXEHuzWw0Mo98R251Zx5wsjx6qhrrcRVY5LPUawNaNx3pMitcCliLjktMI7
	 u4YAU6zjexUKA0RqjW+MaPrZ/zL++Ovm5ZgEVGJaxAJAbmahZGne0n9vscG8sSrEg5
	 gCUX37PowWMFc3ZoCoStEjU752PfU0FBC8T3Kp28D9Sz7gP3S260QPRsMktJ4haKni
	 tdjpqirI2qCdnR/wOCKADHqIQQOYu2eCgp8+6XjDkbOv3M+4oV/tfzaLgtKzbNxWqK
	 wn67xyLGXSn7lNHJ5H8Gbjrt9VwnfMbzF7HAecAPPb35K+cimc1iptfnXjhp8WqxEX
	 Jr8sGWULSCvFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE539EF942;
	Tue, 28 Oct 2025 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176167260900.2322783.15511402406481747677.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 17:30:09 +0000
References: <20251024080802.642189-1-jianyungao89@gmail.com>
In-Reply-To: <20251024080802.642189-1-jianyungao89@gmail.com>
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Oct 2025 16:08:02 +0800 you wrote:
> In the elf_sec_data() function, the input parameter 'scn' will be
> evaluated. If it is NULL, then it will directly return NULL. Therefore,
> the return value of the elf_sec_data() function already takes into
> account the case where the input parameter scn is NULL. Therefore,
> subsequently, the code only needs to check whether the return value of
> the elf_sec_data() function is NULL.
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: optimize the redundant code in the bpf_object__init_user_btf_maps() function.
    https://git.kernel.org/bpf/bpf-next/c/4f361895ae65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



