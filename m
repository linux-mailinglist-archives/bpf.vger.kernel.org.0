Return-Path: <bpf+bounces-54841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B67A7408B
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 23:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837CB3BC170
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A11DC9AB;
	Thu, 27 Mar 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIwuxwij"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3D1E32C5;
	Thu, 27 Mar 2025 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112672; cv=none; b=VfMUgmUKt4lSeOUju9iaVCzfE6PJQUZk09EOZaUMeVqQKrusej9RBDaFbGnhGCjsFgkmlOGo1ZZwynWRw3QqgL+ShmAMa5itVNMhGmnpNZtEG1xwifpsKyzz2uMOYfQM03YORXC8GoNe7uhncqlGYiWK3/LHNZq5vKTs6D/KRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112672; c=relaxed/simple;
	bh=ZsADyA8KuiZgxQVVEb+zpMu58RecCjloMAnX+/v+buo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eIlOCZ9FrC6AP/HJ3OKkUv6yd/Vu3exQpGdZM5DcTUi5nV8atm0q0+TgrOuBjmWGduVocC9bJVZ9yvZUf10mAihT2hmTZtbIT62cL9AvoNINSciN1DvH86I4XyxYdWEPdrnG8LfmSJAzOMsPBs24q3g+ADqxb5lADeDyNgBghdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIwuxwij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE61C4CEE4;
	Thu, 27 Mar 2025 21:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743112672;
	bh=ZsADyA8KuiZgxQVVEb+zpMu58RecCjloMAnX+/v+buo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bIwuxwijA27zYL/rKK5iPIKDyPcIVvdquEhX4uJ/0O7kDQfBlQSwDEduEq7lBgSUP
	 CarnIwjQQXg0LMhX247Z0yfZPAOVXs7ox6Yl/6ng4ld4ZhQwFVO6+OhtpmtLqg1lIr
	 iDGMaIq3M2g+x+DmwQyJ12DqWV+J6JbeUBhYNUPdvWYTWaBIIt5G7iXhiqcWwUeKfG
	 P2Y7tLT318zO2AKeuygoe8PKsHUjMAL0rFr2YeLw15OUpvxyxy6sb/6z+2jWBhe0Mb
	 ItMPzIq+nMKnGeobPtSLjSKUrJjsGUms2R5sXtzR1yJaJJrkYEwrRv0anEeepMmFm+
	 aAae3Ciufjrwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC26380AAFD;
	Thu, 27 Mar 2025 21:58:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 00/27] Improve ABI documentation generation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174311270850.2230226.4852455108648362564.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 21:58:28 +0000
References: <cover.1739182025.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1739182025.git.mchehab+huawei@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, tony.luck@intel.com, corbet@lwn.net,
 james.clark@linaro.org, suzuki.poulose@arm.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gpiccoli@igalia.com,
 linux-hardening@vger.kernel.org, coresight@lists.linaro.org,
 johannes@sipsolutions.net, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jonathan Corbet <corbet@lwn.net>:

On Mon, 10 Feb 2025 11:17:49 +0100 you wrote:
> Hi Jon/Greg,
> 
> This series replace get_abi.pl with a Python version.
> 
> I originally started it due to some issues I noticed when searching for
> ABI symbols. While I could just go ahead and fix the already existing
> script, I noticed that the script maintainance didn't have much care over
> all those years, probably because it is easier to find Python programmers
> those days.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,07/27] ABI: sysfs-fs-f2fs: fix date tags
    https://git.kernel.org/jaegeuk/f2fs/c/90800df0da78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



