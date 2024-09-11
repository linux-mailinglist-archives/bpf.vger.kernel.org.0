Return-Path: <bpf+bounces-39657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A1975C0D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8362D1C21F9E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6AC145B14;
	Wed, 11 Sep 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsQMgxs7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F013D893
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087828; cv=none; b=d+9jDr/banRRzB2rqrxpv5qQFbMsYUlwNo92ACCr0TMJFkdEY6Fk+sx97Uh4WwZ0NrGR6ey2kbsz0+WsDBGZxzEdoQb3NSDThOqCwjW4WBeVjyjMqWaY9ePdtyiLoghCYlOGYotgPrBHgiVfptA6etZZsZ4iRBxPypy8xAqL+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087828; c=relaxed/simple;
	bh=fJTdP1Nj3jVr9T83MYWhULNaUk8vSQ2QBh5F/fSbzuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ApTsXbde8c3TsGnBqU/Df6GOqJbSgfNAJeG2YXAqdiNqIIabD90E15fr9RaB6vo19lD4hZ+GJDqAn0WM2IJ+PfKWwc/fldMHsSQS1JeGMJ9lLhs81T25lb/tgcUm6M1bE4Bflc2hzLB2FPBK38e/cKZujBhBNXHYvaFaJ5+BkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsQMgxs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFB9C4CEC0;
	Wed, 11 Sep 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726087828;
	bh=fJTdP1Nj3jVr9T83MYWhULNaUk8vSQ2QBh5F/fSbzuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsQMgxs7HNkVq00gpiRMLeK/10cO2PyqWGt3tTla7eIOjdTb6WOyV9PSzSjyBVSZj
	 wUwdc0m6LyaU1U6XsaboGntqsIS8ndRWaBUWzpvh/imlCYaIqO4xjS0P4hoZSY+566
	 t5BrwuoLFV3jXxOH7iF3fzVFSTx2MFCTZa19X1ex/rpPbYLBuqEwSS50/ZrneqCUm8
	 iewk64DVGei7du1cpzcB7TTu6pRSwQUpl2nI432MZuwNIC0pUH7opjybxykGsAvG/Z
	 M2lZb7MZHUpk0hTSIdVM1Cs39TO4jyGkFohOuS3403CxkzvLlBI6HVHm0/GkEOnyRE
	 039wFL1oChAKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C923806656;
	Wed, 11 Sep 2024 20:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] docs/bpf: Add constant values for linkages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172608782927.1042789.14068490113233931404.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 20:50:29 +0000
References: <20240911055033.2084881-1-hawkinsw@obs.cr>
In-Reply-To: <20240911055033.2084881-1-hawkinsw@obs.cr>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 11 Sep 2024 01:50:32 -0400 you wrote:
> Make the values of the symbolic constants that define the valid linkages
> for functions and variables explicit.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>     v1 -> v2:
>       - Reformat to match style in BPF ISA document
>       - Add information about BTF_VAR_GLOBAL_EXTERN
> 
> [...]

Here is the summary with links:
  - [v2] docs/bpf: Add constant values for linkages
    https://git.kernel.org/bpf/bpf-next/c/c229c17a76e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



