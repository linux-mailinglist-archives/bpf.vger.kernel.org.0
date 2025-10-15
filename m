Return-Path: <bpf+bounces-70956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71568BDBDA4
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 02:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E34402C12
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955E1F1313;
	Wed, 15 Oct 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSEU3W4g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9BC34BA41
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486422; cv=none; b=dFKtPzCxNDvzCE1mV/c5WxcZvamGmMSoor7R4sAZKaL0LNUYE6Pq/q56M27UvyMlmik7Ck9xDvHZVmciP1UnyRNJh0ttaYWqKRzVtfTZJsDAXv1foLAq8n8PcOwoVBAl0X/6SUtoBJoFSEuKyD/qPOD5ENbUAteD1b4Mapk69ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486422; c=relaxed/simple;
	bh=JauAE5cKFS4pGPC7ehG+Qcv53fZsZ8YmiKo2UsTyQwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfzjVC4zgDa2WmPZFXt/ZjUZyL4gFdilY+AeUsHXBW1TRfRGkVqV25Go3ErDrV0XKfV1TPivRdDUP0JLA2QKdcYOZxOjO7skxHfhycYT/T3guZd+ofmpsT7IfRdZhaK/KgIurJjPGRrrD0oc1OFF1IebxOqcj1Eq+43eey3I/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSEU3W4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA4C4CEE7;
	Wed, 15 Oct 2025 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760486421;
	bh=JauAE5cKFS4pGPC7ehG+Qcv53fZsZ8YmiKo2UsTyQwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aSEU3W4gH0Yw83G9mPj6ZOco9CseOzOrJ0BsgKi/paW0z/U9blY3kGkwvKxPHcEfZ
	 rTmAbYupIY0UlpcN9z3i/LGBtuGupPkwhqCWYhPPJPH5/btirG30Ac9b9klgxPUOz+
	 Z0MF37Cfhv0MnAyEBfN1EoVd+8Z4R8i0sBOdt66BRwF1MTLi6EXVbLW6QpAVuQzfhf
	 DERbMVQ8FB6pzdUwJ//a0O7wQDXVoZotMwzi/qZF0Q8a4roW2Yd/kjUspEt+Z/awON
	 G01E38tE4yafY4ry5BkuYMpU1bxQ0+NSmD+7wTHoArXMXnfF8e0xNO3X9MBlSoZANu
	 WxeXuGR4rDHVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F53380CED6;
	Wed, 15 Oct 2025 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: make arg_parsing.c more robust to
 crashes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176048640701.153739.16409318584224861998.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 00:00:07 +0000
References: <20251014202037.72922-1-andrii@kernel.org>
In-Reply-To: <20251014202037.72922-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Oct 2025 13:20:37 -0700 you wrote:
> We started getting a crash in BPF CI, which seems to originate from
> test_parse_test_list_file() test and is happening at this line:
> 
>   ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
> 
> One way we can crash there is if set.cnt zero, which is checked for with
> ASSERT_EQ() above, but we proceed after this regardless of the outcome.
> Instead of crashing, we should bail out with test failure early.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: make arg_parsing.c more robust to crashes
    https://git.kernel.org/bpf/bpf/c/e603a342cf7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



