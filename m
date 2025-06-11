Return-Path: <bpf+bounces-60367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B4AD5F2B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DED189FA11
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E742BD5B1;
	Wed, 11 Jun 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUWbw/gO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627BC28A72F;
	Wed, 11 Jun 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670804; cv=none; b=TN1OkhTEBznYjpHlw4IiaD2rI6eJIiZx1KbFFC8cu7B48dRWVlzde7RodcJnre8TZo66HvecGyjvdWnqBA4WBBwhltGgtUitRMWlT8ImtzmU4+WCfpl9jeKiKzTwb/Eo43CpynFGzj42bZJ96Iiep8FVzyxG7fObQCec/2Ba0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670804; c=relaxed/simple;
	bh=fQJ6zNWpiVY3xX8YTmPsMEr/hKbQN2NOUtWDTwisMHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dEw/VOb3VshfcWYgQa+Ug0eswqZg5rTrmN830WBl4ryL19DydQTAGGe7IGACRDctWitv49Rlp7ftzWYSY9CwrPsaS5kx+/CRrfkhmbQJ4CN5qcEFMNkhjKWgBIJN9OFPCGMDQTXtM1Km9R0i13klVpCB/dE2YN4vpMnJfuiqdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUWbw/gO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3B3C4CEE3;
	Wed, 11 Jun 2025 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749670803;
	bh=fQJ6zNWpiVY3xX8YTmPsMEr/hKbQN2NOUtWDTwisMHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qUWbw/gOr1gqRaa8fA2rbQ/9Bcx+HF2Qef5tGgzUk9UDpNkAGp8QfZf9Lp9d2zqB/
	 ug6Ma+9YrJyHI5kog3uaxPqUDbsJFzrODx4JJ9eP/Q1WygQr3bJTHTbeSJO6lEHIRs
	 M5wz5lho9hn5JbtZen4AcOI3v4zcpdj2AXD1Up1m/O3eHXUG66hhvriHVvo51BCybI
	 DQMaoaOSFcEsvqPT9gwjy4rbryFwriv5wO2gqSI1xfv0L0MwH0f1p89PdIZbbK+mai
	 hf6eOzw01rdasziD8t1kvVix4FgI7yI1q8whOWI2R/SuBZuLXAY4iTtcRKSDyJ4hS2
	 PMyfCOaxRzxAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B84380DBE9;
	Wed, 11 Jun 2025 19:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Documentation: Enhance readability in BPF docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967083376.3454768.5653421853244325577.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 19:40:33 +0000
References: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
In-Reply-To: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
To: Eslam Khafagy <eslam.medhat1993@gmail.com>
Cc: skhan@linuxfoundation.org, void@manifault.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 dthaler1968@googlemail.com, bpf@vger.kernel.org, bpf@ietf.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Jun 2025 01:24:25 +0300 you wrote:
> The phrase "dividing -1" is one I find confusing.  E.g.,
> "INT_MIN dividing -1" sounds like "-1 / INT_MIN" rather than the inverse.
> "divided by" instead of "dividing" assuming the inverse is meant.
> 
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] Documentation: Enhance readability in BPF docs
    https://git.kernel.org/bpf/bpf-next/c/c9b03a11005f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



