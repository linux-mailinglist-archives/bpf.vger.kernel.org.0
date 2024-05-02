Return-Path: <bpf+bounces-28462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913038B9EC3
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23911C20A8A
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD6415E5C7;
	Thu,  2 May 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX94kVxE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5451E894
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668031; cv=none; b=uP5blVYf3PQhB6kcr9bK/c0HxpOXTHsgVswOgSiR1DQAuU9aF4/WtPxv69VaRuFWwIrhhsHKnGMWkVtSdLGq3o0HlV6HJLUZH32kpzNvlnTxujYkKiM84pW6VS1zL/WTt8yPRF8B3LLDOedVNrnjnVAh5QkJSldBChbMgmJ1+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668031; c=relaxed/simple;
	bh=qWWXfGtlHwn+DkAINLxi0B8XqP1lAZpM4cgUw5Z1tvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RhFHKAtV1mkT1iaxaTQGWW1jF4VdvWWy73w7eSe9KbISgroEhYTH70ud54hXP3+kWXW6soitTzoQFWExdtuYJHguxzUlvxppL7oF2V60X51ft+8s73hMCqbAMv/m5UfAqfSNi4elYv4nIvBON8rrUPZMSBEgziXGIs9L88dt8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX94kVxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D6DAC4AF18;
	Thu,  2 May 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668030;
	bh=qWWXfGtlHwn+DkAINLxi0B8XqP1lAZpM4cgUw5Z1tvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pX94kVxEoPz4ZVy+Xe1803LX0wum4WilFaZvY0BJDJ+DhSs5SBM4msIIiJbNry3fp
	 0m1AcqROiSeVMYKigcH/HEF+058Ul+q/xU6yg6yuVHmYNI7eQePxtlfAdV454PTZPb
	 3CwM3Zm5ocJ8SrKt9nFs6smFyMEW3UXp13TkETElt8kq7u7aENXir053x4qQM8X1fC
	 k19IUtYBXMDh9Dz7Vf0t+urk2qGGtSK2CJDlMA9WVPm/juirBBHuw21L83QH98j36q
	 KHhd3N2tIIizuX343rxMgs6q4S4gbyZpBFRofDsi8Jq8xDoXLuW271KrtoMJpVJTt/
	 EprrSak+qI1Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43BC9C4333C;
	Thu,  2 May 2024 16:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: missing trailing slash in
 tools/testing/selftests/bpf/Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171466803027.13356.14271626948887936984.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 16:40:30 +0000
References: <20240502140831.23915-1-jose.marchesi@oracle.com>
In-Reply-To: <20240502140831.23915-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  2 May 2024 16:08:31 +0200 you wrote:
> tools/lib/bpf/Makefile assumes that the patch in OUTPUT is a directory
> and that it includes a trailing slash.  This seems to be a common
> expectation for OUTPUT among all the Makefiles.
> 
> In the rule for runqslower in tools/testing/selftests/bpf/Makefile the
> variable BPFTOOL_OUTPUT is set to a directory name that lacks a
> trailing slash.  This results in a malformed BPF_HELPER_DEFS being
> defined in lib/bpf/Makefile.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: missing trailing slash in tools/testing/selftests/bpf/Makefile
    https://git.kernel.org/bpf/bpf-next/c/08e90da6872a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



