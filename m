Return-Path: <bpf+bounces-32857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA4913DD5
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CCA1F21B4D
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796818307A;
	Sun, 23 Jun 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7lsyU7C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEB13D626
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172830; cv=none; b=SkOWYIq3DgsUY6/NjOrdBGxV9uAk5nUdg3MdY1kxoEWNyIOkvtC3ZmCrb1+iHGTkoBrK++pEeP9+ydbpyy77vDCQjL1hJeNyb7D7pXLY7YEn2exVDwJ6SY/pKlT2CAZpLhqYeMf8VcyVE1/5onoGmSC9i5srHaVIK060m5zhXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172830; c=relaxed/simple;
	bh=7OGY772p/BvsvjxwwmEXLb3zwmicbidV8vVSG+66G10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZsfzpC6UxCLhPprUeXsXmQ0rlo4PlmqEdcVYSJN87/f1jwxZdI2MLnikOZI0Bp+3q8NqYk8caevQNkDGxsqJDT1jvjdAp5Gt+QI/B5kpFNXfisw1dSpe0F1MghnpRJ9txBniQRxnhWxzZuEz+FjmfZ3Vvc5Ocd6xGRx2k55k/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7lsyU7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 845BAC2BD10;
	Sun, 23 Jun 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719172829;
	bh=7OGY772p/BvsvjxwwmEXLb3zwmicbidV8vVSG+66G10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s7lsyU7CKMH1FV6CpFy/V0cgvMmcIFGOUItDqPLNXDBdWoo3Tw5FJhLpWpgOXipP0
	 oatXDjErGD0r2+ErkNUwfP7T2ZdiO3vDzHyVfiAa4OT0LeiYh1FQTHKGEqbTwczTAb
	 DV1YbxP36HeIcV081qlALg4pG2Bvg6zHWW6GCa7JCvzFHwZTti1iXaf357p0ECGlcO
	 7xyX41bTFbUf+V1lPZRxKB7ZGGZ9dRJMBqzilE+ajN7ngRKweLoYWEHR+xS08RigrB
	 oceSc5aZxRV3RX4yjmi35pZjyb7erXQEgQK3iqKUMBvI7Ew3+zGoD3etAwn8EORRF2
	 SWfO9oca6i2bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71FBEC54BB3;
	Sun, 23 Jun 2024 20:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES]
 is undefined
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171917282946.6193.17135250605309853635.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 20:00:29 +0000
References: <20240623135224.27981-1-alan.maguire@oracle.com>
In-Reply-To: <20240623135224.27981-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, acme@redhat.com,
 daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com,
 thinker.li@gmail.com, bentiss@kernel.org, tanggeliang@kylinos.cn,
 bpf@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 23 Jun 2024 14:52:24 +0100 you wrote:
> Kernel test robot reports that kernel build fails with
> resilient split BTF changes.
> 
> Examining the associated config and code we see that
> btf_relocate_id() is defined under CONFIG_DEBUG_INFO_BTF_MODULES.
> Moving it outside the #ifdef solves the issue.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES] is undefined
    https://git.kernel.org/bpf/bpf-next/c/5a532459aa91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



