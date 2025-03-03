Return-Path: <bpf+bounces-53117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F7A4CDCA
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259CE1727BD
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA911F12FF;
	Mon,  3 Mar 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzYkEHXo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4F1F0E2E
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039200; cv=none; b=MueTf5aITV/WJq/I9+2FkPGUnw9DEzCrBWtnxjtYG4GrBty9/mmXYfMDappJ3E7BtvHilKjxyDTmL7ieDR6ZaZFrLOLm1kRe30RMml9P8PtJrh4/7ChOLbWHlekIWTii5QoK+TK3GRACInzmc7iNPMEU6Ex8sVdAu3pX6vr7/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039200; c=relaxed/simple;
	bh=SUwiZzdDaQccIan/Ha/N2t0T3sexIIabJsoGFIZxQjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdNU4wuGNHBawmr5CITF7oECCiPX+sBW293yB9/53fqdK8vuDSIfKB5QRMXh0Qh1wHB7x9svAG8kA7CinaXpBiJVkSF+NP4zC/UmWVO6DMGWCu4IbTF5nha2iYXe4G8Bfg1J9MWvThyl6C/FcMEKDkKk5yz0EtzNDcy42sYTPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzYkEHXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B20C4CED6;
	Mon,  3 Mar 2025 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741039199;
	bh=SUwiZzdDaQccIan/Ha/N2t0T3sexIIabJsoGFIZxQjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NzYkEHXoB8suiDhsoUxZDUQcnAQe+rCYzpsA158za9errcOzvvJVXXSfSwaXsh37I
	 jCWMcmHZdW7iF8w/osiE/kTHeCKhRy3jjtkH1+IS9HDt1cvF2xr3qqYjz6fmLko/8T
	 UYZn6ao4zG7Ws89DwuxtGNlONf4DCRQVWwSpAR90EmhnV0i3NWhx+rw565o2w1R+4u
	 C29kLVUNiurM2qv4YoJAs9g9ypdhJ+zrhW4K3/Ds7fMCzXbZN7ZFkFORGyIqdHH8f+
	 PNs++Uw6sDbAu1o6sozXk4rTXELCdxsketwmF2f5eG63gZV9hvYHhYdrzCoGnHvO8Z
	 +QJa+s0GFUzWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF653809A8F;
	Mon,  3 Mar 2025 22:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] veristat: @files-list.txt notation for object
 files list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174103923250.3728948.1467587784560266384.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 22:00:32 +0000
References: <20250301000147.1583999-1-eddyz87@gmail.com>
In-Reply-To: <20250301000147.1583999-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 28 Feb 2025 16:01:44 -0800 you wrote:
> A few small veristat improvements:
> - It is possible to hit command line parameters number limit,
>   e.g. when running veristat for all object files generated for
>   test_progs. This patch-set adds an option to read objects files list
>   from a file.
> - Correct usage of strerror() function.
> - Avoid printing log lines to CSV output.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] veristat: @files-list.txt notation for object files list
    https://git.kernel.org/bpf/bpf-next/c/128cd7672577
  - [bpf-next,v2,2/3] veristat: strerror expects positive number (errno)
    https://git.kernel.org/bpf/bpf-next/c/164975333cec
  - [bpf-next,v2,3/3] veristat: report program type guess results to sdterr
    https://git.kernel.org/bpf/bpf-next/c/b12752801e44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



