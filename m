Return-Path: <bpf+bounces-55340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35842A7C124
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAF317CD97
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D41FF1D4;
	Fri,  4 Apr 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2mA2y32"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED661FF1C8
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782400; cv=none; b=rFneF9ttbvaZgbg/FFbJQgcg3XkXKVmF9HKay2NK8ino1/FTWcQz3RIWBwdr81CFFuz2p93XMRvH9gSypDlJgSjviD4PTH55SekoOB4Xav8VrtDDW4GXM4dt9vqEpPsC7sglwkS6a98li/BjxY1Kh/NTZukZQ8xnZHLVQzXu2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782400; c=relaxed/simple;
	bh=pqGXlfmYym3bqwzOgKI9wWIXHiCvsIILM1iyAYTpqA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vDkfM0OoRBHX8XrPYo8ATKkHNvxXYVgwSxY14tECQ6SuvH2HEi1pOBYdGojL0HNVbhT7amg4QEkV2sM/xMElk9hCWecO/HvtVdZuDBzSmffiO5ey2RkHK8Vt7LMNFsV96MLrwTWjmhcUHD624KKXo+ElcMTo6XHvQVyhAyyynEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2mA2y32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2761C4CEDD;
	Fri,  4 Apr 2025 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782399;
	bh=pqGXlfmYym3bqwzOgKI9wWIXHiCvsIILM1iyAYTpqA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d2mA2y32tHzTscsd6zCHONlCjIMx2SEEngpl7pjC8QbqeFlPTnjYtU0ZsAFOGvMoF
	 L6dt6UbRKZiKdchPt7vb2C3ofbrhDuxIlMjyFCU3NUyVevVfqAF3uziX9BcrG7oOkE
	 /duN6++no9aIYZm7XMJZY3NPJgsklZrkiJfHajH/42Fb7Cohorqf6Se/ZrzoX8teEW
	 mPRtuOX7Yop/dbe7K1ARs1b26IpWv7DmTrCEliGFuIvcDS1m1GZUfEkLOisN2eWeXt
	 2wwEDRZbzQxyTGxZDv37fK+dWOxcq4royUMaRMEyrK7Wk91xgrdPPT0VQRml8030Bq
	 wOu+/LtrPRo6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECC6B3822D28;
	Fri,  4 Apr 2025 16:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] likely/unlikely for bpf_helpers and a small
 comment fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174378243676.3310001.16730699009629085567.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 16:00:36 +0000
References: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 31 Mar 2025 20:36:16 +0000 you wrote:
> These two commits fix a comment describing bpf_attr in <linux/bpf.h>
> and add likely/unlikely macros to <bph/bpf_helpers.h> to be consumed
> by selftests and, later, by the static_branch_likely/unlikely macros.
> 
> v1 -> v2:
>   * squash libbpf and selftests fixes into one patch (Andrii)
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: fix a comment describing bpf_attr
    https://git.kernel.org/bpf/bpf-next/c/62aa5790cec8
  - [bpf-next,2/2] libbpf: add likely/unlikely macros and use them in selftests
    https://git.kernel.org/bpf/bpf-next/c/dafae1ae2ad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



