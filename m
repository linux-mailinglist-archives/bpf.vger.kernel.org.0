Return-Path: <bpf+bounces-56762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE87A9D6AD
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 02:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0964C6F01
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A261E0DE8;
	Sat, 26 Apr 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvxEHOfD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0F195FE8;
	Sat, 26 Apr 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627392; cv=none; b=bhi5PPncyopPVYxRF/3xat8yB7SHYcfG5LX+BAbT3GpG282my8GXxF13vDw8AESV7nxrGKAeFE8Vy6VPd5wTkIxuS7JILRMqPAShQeAw/xkdxglBjP+rkTuW6sVCPFH64uhbMDuoYD5EPAeNsoV7itgMC1ChuRkcBLi9HpKeOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627392; c=relaxed/simple;
	bh=Us/CQ229JFakDBYn+TJwgtBIHBEEL0JV+fnkPaVG1G4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aMpSDhoQ/1vKeFYxVBXYYfskBXXHFxEB+rSh+RCEErvKxo8Y4YstP566Org3yb0YCkYuHaCENrGparAX6ARdsxucSYOWBDRH6nmMTRpbby9ydb0QZuc97bH/4c29cpmfxbRc2TYi3nvIh9AdV5LJ1wk3mDLFbAYZLkgdcwQ9XYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvxEHOfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4919AC4CEE4;
	Sat, 26 Apr 2025 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745627391;
	bh=Us/CQ229JFakDBYn+TJwgtBIHBEEL0JV+fnkPaVG1G4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pvxEHOfDh7RbVF+XN9qtMZswiPpdezlm5xZuk73XMV4qhw0C+/gJKlzx6JnY7lAUc
	 MbkfuaHQ2XEx+kCH7h6johzaxivktwANgIT0L1Yxcr7W7xCVHu2uG7oPjUJSZ8/Kz/
	 lJ3E+Tig6S3tLDXbswkig2nlSS48fL5qF6TrtZm9A9A5XYChNGvpau/WV2y86hJT6H
	 MlvWQO6hGcQADh5ZlmZR2wx9U8BzQXF0sT4R9OPnSToSyt70wIXgd23/arETZYb60e
	 mxhRgV6zEjVtNj54jA7GYWsfqeK/k3pIyA+h3p+fbnmMT2ne00fI/TFn0MP82qTqPH
	 6NbfjU4JRfNmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CED380CFD7;
	Sat, 26 Apr 2025 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vmxnet3: Fix malformed packet sizing in
 vmxnet3_process_xdp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174562743000.3886189.102996888002820678.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 00:30:30 +0000
References: <20250423133600.176689-1-daniel@iogearbox.net>
In-Reply-To: <20250423133600.176689-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, andrew.sauber@isovalent.com,
 aspsk@isovalent.com, witu@nvidia.com, micron10@gmail.com,
 ronak.doshi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 15:36:00 +0200 you wrote:
> vmxnet3 driver's XDP handling is buggy for packet sizes using ring0 (that
> is, packet sizes between 128 - 3k bytes).
> 
> We noticed MTU-related connectivity issues with Cilium's service load-
> balancing in case of vmxnet3 as NIC underneath. A simple curl to a HTTP
> backend service where the XDP LB was doing IPIP encap led to overly large
> packet sizes but only for *some* of the packets (e.g. HTTP GET request)
> while others (e.g. the prior TCP 3WHS) looked completely fine on the wire.
> 
> [...]

Here is the summary with links:
  - [net] vmxnet3: Fix malformed packet sizing in vmxnet3_process_xdp
    https://git.kernel.org/netdev/net/c/4c2227656d90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



