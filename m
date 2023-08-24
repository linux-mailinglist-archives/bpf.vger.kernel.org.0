Return-Path: <bpf+bounces-8424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64DB78643A
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527462813CF
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5345EDE;
	Thu, 24 Aug 2023 00:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C55179
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 00:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6117FC433C9;
	Thu, 24 Aug 2023 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692836424;
	bh=mHheW+hsnMJ66Qr7GrRSRKNhdX39hE5ClgSLeMSCvQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PeBiSHxWpPcvMdtBf4+3h9SIyKf1e98WZSKTgS8SAFmqGOtlGCokR6Gkuiq57a9CR
	 ZtgZxv/V6lvUFqrFUWXs4kLuNx365ueZE84bL/JE7gg8rI2II/UU0zL4aSEoM5frLo
	 WIJemC3ii88vqSEy4DCnpgOXkDBQr9oUIAAEq4SJUto5GAMHvHpAiUvWkkMRZFGvm5
	 4XGBbxeyrVfuE+VuVwdGm6iSNiYUSzVBD8DbgTsqKhZM7amTNZRvVl1cpHw+FTAMre
	 UDhP+GJhdRKOORYs/B7NlUNHvnkJV4E14JW1bHCSckw7FO9E8KFycZ8sXOpuGqt1Pb
	 Fjm1vJzduOsmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 433BCC4314B;
	Thu, 24 Aug 2023 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Add bpf_object__unpin()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169283642427.5265.11674522531780375026.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 00:20:24 +0000
References: <b2f9d41da4a350281a0b53a804d11b68327e14e5.1692832478.git.dxu@dxuuu.xyz>
In-Reply-To: <b2f9d41da4a350281a0b53a804d11b68327e14e5.1692832478.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 23 Aug 2023 17:15:02 -0600 you wrote:
> For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
> 
> But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
> symmetry to the API.
> 
> It's also convenient for cleanup in application code. It's an API I
> would've used if it was available for a repro I was writing earlier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Add bpf_object__unpin()
    https://git.kernel.org/bpf/bpf-next/c/068ca522d5a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



