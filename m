Return-Path: <bpf+bounces-55622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768BA83722
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1197719E80DC
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2A1F03EA;
	Thu, 10 Apr 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meWD25GU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317327468
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744255205; cv=none; b=dRvEGFq6iHDX34FrrqONWLeM02b/Ql70exBohobDrLIHmi2LBFz9a1Dj9XkW4VTppqZ6MQPjtqyBFYpN2Y69dh41PzEX1UZAa1g+HJZyKcWjSVRqxOBq23puPhE61PYYaew8mBE3njvdo+FSHh94ARSa7OMoESJrNzaVDKxN6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744255205; c=relaxed/simple;
	bh=5XJCORiPhtqploScNVfVkDpE2RApsMWuwdvoArYHM04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lK5lsm0Ui6+I5Lrkd/Ak2VAIKlsC+4Tn4ip2dim9AlDcsjqR6+Sj/6GIT7FKBw6IkbuKO9OvQrbg6Iu3EraValxP3wJjcAIMvbySLr8v+33VX/DvZbva5osFcyye9GzCOac7eNCa1qh+EiuTHXyPaFfkqbnRqB+r967MhevIB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meWD25GU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA1BC4CEE2;
	Thu, 10 Apr 2025 03:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744255204;
	bh=5XJCORiPhtqploScNVfVkDpE2RApsMWuwdvoArYHM04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=meWD25GUeC1Y1q7g7jBV1ZprJjY9mPcoPuusf52HxLhEr7iNXZ/hwnmskJS9dRljp
	 POvnZYM4HqqLJb5i8L00acI+3Pfw2q5FaAnDbxyowzatEUzF2OVjWmDjrHZ/oglrIj
	 iAs4gi7kC3Yx0VuUY26zsJKDR7u67nbBhWvFgPjaFvDl+gg2K6lOhijepsoi7RQdIS
	 F3QChXj8oKt17jMkToYjviTXvXEuv2JReDI7Is0cnBq6gQH6QJ3FXT10rfjp8FQ6AU
	 a1+5A8pQw1zl+tLI+2/qbIuPIJSvyfWFPbijQSrMFuA8v+OQwbbHBfEnx6xmq9piDy
	 XjoOlc6GYYkYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EEB380CEF9;
	Thu, 10 Apr 2025 03:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Support atomic update for htab of maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425524232.3134501.14061973239440848721.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 03:20:42 +0000
References: <20250401062250.543403-1-houtao@huaweicloud.com>
In-Reply-To: <20250401062250.543403-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com, toke@kernel.org,
 zeffron@riotgames.com, chaas@riotgames.com, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Apr 2025 14:22:44 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The motivation for the patch set comes from the question raised by Cody
> Haas [1]. When trying to concurrently lookup and update an existing
> element in a htab of maps, the lookup procedure may return -ENOENT
> unexpectedly. The first revision of the patch set tried to resolve the
> problem by making the insertion of the new element and the deletion of
> the old element being atomic from the perspective of the lookup process.
> While the solution would benefit all hash maps, it does not fully
> resolved the problem due to the immediate reuse issue. Therefore, in v2
> of the patch set, it only fixes the problem for fd htab.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] bpf: Factor out htab_elem_value helper()
    https://git.kernel.org/bpf/bpf-next/c/ba2b31b0f39f
  - [bpf-next,v3,2/6] bpf: Rename __htab_percpu_map_update_elem to htab_map_update_elem_in_place
    https://git.kernel.org/bpf/bpf-next/c/5771e306b6cd
  - [bpf-next,v3,3/6] bpf: Support atomic update for htab of maps
    https://git.kernel.org/bpf/bpf-next/c/2c304172e031
  - [bpf-next,v3,4/6] bpf: Add is_fd_htab() helper
    https://git.kernel.org/bpf/bpf-next/c/e8a65856c75d
  - [bpf-next,v3,5/6] bpf: Don't allocate per-cpu extra_elems for fd htab
    https://git.kernel.org/bpf/bpf-next/c/6704b1e8cfc5
  - [bpf-next,v3,6/6] selftests/bpf: Add test case for atomic update of fd htab
    https://git.kernel.org/bpf/bpf-next/c/7c6fb1cf33fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



