Return-Path: <bpf+bounces-13973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707BD7DF7F2
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AD11C20F1B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3D18E1C;
	Thu,  2 Nov 2023 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIK5rFOE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38314F74
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34C10C433C9;
	Thu,  2 Nov 2023 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698943825;
	bh=CY7GoH+9GIerDC527tiJLe8UnTCSRMN07Z49pf8/YK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eIK5rFOEmufL92mZ6SPYJi4GVbOy0x/nbPINE+tD2R1/ZqVAEWeSh0YlVfHksJp48
	 9IYEGdSRjKoe4Je8+JMpRPAmlrsNovZFD/1+WhA/ypYLt1EkVdHtZwQt5HGcjQRRk2
	 EmaOsVIkhzcvwFFMVR0nH2SEHCh5GSy+7+jN2NuCmp6i21fYp7KgzRCyFbE7b3dcLt
	 0/tzPbNmhPOllbObGQcPKcukM9knSSgW+qRsGOU7Ori9jhCy2WGBvuRfLj4K/njyxq
	 t/uAGAviiBappDQwi/YIZ33DcBzHbMkHqfcG0GSA9Lpy4iQyznhBwGulkAEheri91Y
	 KnkvH9SjwPmNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A23FC395FC;
	Thu,  2 Nov 2023 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: Fixes for map_percpu_stats test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169894382510.17546.8408450524155416380.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 16:50:25 +0000
References: <20231101032455.3808547-1-houtao@huaweicloud.com>
In-Reply-To: <20231101032455.3808547-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 aspsk@isovalent.com, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Nov 2023 11:24:52 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> BPF CI failed due to map_percpu_stats_percpu_hash from time to time [1].
> It seems that the failure reason is per-cpu bpf memory allocator may not
> be able to allocate per-cpu pointer successfully and it can not refill
> free llist timely, and bpf_map_update_elem() will return -ENOMEM.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Use value with enough-size when updating per-cpu map
    https://git.kernel.org/bpf/bpf-next/c/3f1f234e677b
  - [bpf-next,2/3] selftests/bpf: Export map_update_retriable()
    https://git.kernel.org/bpf/bpf-next/c/ff38534e8251
  - [bpf-next,3/3] selftsets/bpf: Retry map update for non-preallocated per-cpu map
    https://git.kernel.org/bpf/bpf-next/c/57688b2a543b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



