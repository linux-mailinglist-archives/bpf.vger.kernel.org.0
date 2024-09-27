Return-Path: <bpf+bounces-40434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EC8988B60
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17086B263C5
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA61C3F17;
	Fri, 27 Sep 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQqCEH2o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B31C2DB4
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469633; cv=none; b=OBJc3FTa0/pooY1xJbeqWRnLt2EZEUnmThSgSVpJ4doYmIf7QRLWqcaFUAqkeki5v2BYe0gdcuHtAYf1Yger8/qyil5sch3f7JP7D0dV6X0FN+P93iSMNxMeL++TZUlt1WuMkLXmOmv22s2pc0jNRUuU0CfBx1xTlP4pclUyKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469633; c=relaxed/simple;
	bh=D+hsEdtr+xJkK+RhY6nHI2Z7Qbrf2mogRz3aftHgZaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=trc6BJ5tLiIMhSfG64nwkU/pXM5kHea4PN3AXFRanGgDs/G6ADLGMm5AL/ZGijn9p0foo2uqoo/DXGtG4zi+woFTiVqyK7oAdPdSYI1tlBNO95yP51s4ex67eF3wwe5OMFND3sZFZ5sV+3dXjQf32JImbhdG3dYD+mYjpSX3JGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQqCEH2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872E2C4CEC9;
	Fri, 27 Sep 2024 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727469632;
	bh=D+hsEdtr+xJkK+RhY6nHI2Z7Qbrf2mogRz3aftHgZaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oQqCEH2oJ8d2xVyVGMXRjhrOugdzJnEpLRtDVNaUrkONpVwm2/XoiI82Nlw4zYGx8
	 h2PYJZVN2H0PLTFSepYSotGrpCeeYHbGx04rmjqPKUpnt8KuYMw6XnvBXP2/N5ZYaP
	 ZTxz1RTiX9C3c8yiTWiHMD7iEQMI38fE2nsDmOAp6uUEMcYhPas9+kgX1PgHyajmSB
	 ESCbgxFL2LAuFZK7MqS3L7/cl3HhYPvwCeTxDzxNLUY7unIYxq8aNlWZjwMyEiFeQo
	 XzOi6j/VpxgLSpOgaO+VCZaRyiFt8jJNMgxhWVtGEoGg9BKN5QQFvQaCZ3fssB5ufV
	 1siNoaiPm/vsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FBE3809A80;
	Fri, 27 Sep 2024 20:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: vm: add support for VIRTIO_FS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172746963500.2077014.11256515998850938691.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 20:40:35 +0000
References: <20240925002210.501266-1-chantr4@gmail.com>
In-Reply-To: <20240925002210.501266-1-chantr4@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org, eddyz87@gmail.com,
 dxu@dxuuu.xyz, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 24 Sep 2024 17:22:10 -0700 you wrote:
> danobi/vmtest is going to migrate from using 9p to using virtio_fs to
> mount the local rootfs: https://github.com/danobi/vmtest/pull/88
> 
> BPF CI uses danobi/vmtest to run bpf selftests and will need to support
> VIRTIO_FS.
> 
> This change enables new kconfigs to be able to support the upcoming
> danobi/vmtest.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: vm: add support for VIRTIO_FS
    https://git.kernel.org/bpf/bpf-next/c/903d4edb973a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



