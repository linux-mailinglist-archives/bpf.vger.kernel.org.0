Return-Path: <bpf+bounces-61350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FDAE5BB2
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 06:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5309D1B6374F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67EA22A807;
	Tue, 24 Jun 2025 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F12kIuoB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1E170826;
	Tue, 24 Jun 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750741182; cv=none; b=sRmYIipDOUUFTU/sjXXk4y56PSyp2OTiY/FFd8uwofyd10XDvC7U83D4ibV4bT4DnFqD+Tndwa2a0znZ9OV0h3arQWOZtzqmJXamEMc1tr1AhYe9aMHUYjlr67oW9Am6kZtIfuubf+gZ2tn/bGc8WLJpI2MU/BzJ0EkNIKgRJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750741182; c=relaxed/simple;
	bh=8TalBPdVH8UTFnLXm7W08PbsQ8XLPIJz5xUz9CfdXV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d4d/XSc56wEaNtHkv5XJf56GCBSLuXELb+TIXisqlVv3LZO92BPvIBV4hYHtRYBoSnLHjwTx33mzFcspVj0zLT5O3M9F69hfzeEkXQoifxR17jiA0tJ30NPIbXhcMGRO1/j0sGTYea1TF28q5S8pHvPCyWdz8inv4AboSR7ZEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F12kIuoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C497FC4CEE3;
	Tue, 24 Jun 2025 04:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750741181;
	bh=8TalBPdVH8UTFnLXm7W08PbsQ8XLPIJz5xUz9CfdXV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F12kIuoBRt223geru+Vk8841Wf0P2VAIJFrRKH5bjJcWICkqnusawjNj/6T8qsnjR
	 eWFzCPxRvr7rmltuFukmdDJEPAfnA9iOecGLzfAjPeURR7RE62qPgPF5TJ0yCB9Efz
	 YjN2rAtTsNAQiIh1jU69s2XHHwZUerEDsJK9Xxtu1u2oH8/HaATMQOJcuwFpVMAAhq
	 LfWyNtYNBSFxIoZWGQy+zqlvdQTNwkySGozp8vioFX/guIYcPNpf5iPuz1UJfd/4uB
	 qLb2VrJWNNhw65/W3mUCykshH8RfC9RChL530/UpoxmDJJdWwvIcMcqv1WqpvctNVu
	 Ze5HYLEGViHwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADA839FEB7D;
	Tue, 24 Jun 2025 05:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] bpf: Specify access type of bpf_sysctl_get_name
 args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175074120875.3399614.10605130442249512213.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 05:00:08 +0000
References: <20250619140603.148942-1-jmarchan@redhat.com>
In-Reply-To: <20250619140603.148942-1-jmarchan@redhat.com>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
 eddyz87@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Jun 2025 16:06:01 +0200 you wrote:
> The second argument of bpf_sysctl_get_name() helper is a pointer to a
> buffer that is being written to. However that isn't specify in the
> prototype. Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper
> access type tracking") that mistake was hidden by the way the verifier
> treated helper accesses. Since then, the verifier, working on wrong
> infromation from the prototype, can make faulty optimization that
> would had been caught by the test_sysctl selftests if it was run by
> the CI.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] bpf: Specify access type of bpf_sysctl_get_name args
    https://git.kernel.org/bpf/bpf/c/2eb7648558a7
  - [v3,2/2] selftests/bpf: Convert test_sysctl to prog_tests
    https://git.kernel.org/bpf/bpf/c/b8a205486ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



