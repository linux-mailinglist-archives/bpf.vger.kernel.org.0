Return-Path: <bpf+bounces-66610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70BB375C5
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14021B67313
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8A2C236D;
	Wed, 27 Aug 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ0EFLsp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B01F2382
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252805; cv=none; b=JI3nCMHcrIU+K+ApKAAuyqZGdYpqU0oYEA7YXeFsqoI8a/kN1laHqM6QGK6bZv7rDTkSHakfrYlS2PYDHp1QsAn9o6syYoN3a6mFwDbnHRqNKMXfRz6HqZOUFlUMGckp/jwrxnLoJcFl/r6RJ9DWJgj5hxMwoCj+ymIJ6obbQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252805; c=relaxed/simple;
	bh=6qguICLpHbdA2walQDADjnbabUmIFTlrxeLoHRtxrxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PldgCGkJuLpWMW8faoGEnMcfTJ3l42eDccAC3fkVHSS8YabaHlVT2RDQ2K9MSLop1w0cigsrnMv1IK/Jf7hKiyBkPG/trZib85om2+nJQMokghddhHlidpcSYOUtWHSboZBmsqCh2rPt6eMAogR7ybsN+5rVU29vGel2WDAF8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ0EFLsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27711C4CEF1;
	Wed, 27 Aug 2025 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756252805;
	bh=6qguICLpHbdA2walQDADjnbabUmIFTlrxeLoHRtxrxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pZ0EFLsph2/0NABJzIDmu0coZahA+kQMA4bsqI+yF0IGgQMkJZ2WYf3Zn1hyiW9mb
	 KDkqOLj43Z73f9q7YLT9v4gozYMIHQdQuJXEhDqcdrN1m2vW44+B6q1P4ZJ+LgaYcg
	 rpYIvLrHSyCU+ICzsffl1Sx2c3l/tHIBcIkDJJchqfE00D9RrQ6jWkCmIb4m0zbEww
	 7FvJChfqrOfppk6BqIVehtHK33giadJ5bS9oMHMmjRiVQ14w16KV+se9Ksy/K4JOor
	 4UvcLKl39GXCYn3dIP5gLikRWMMaueYB5HrUEOpaknDekkSEQ/x9Zdh1OAEuaxMBlt
	 JstRQ64qYOqlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3F0383BF70;
	Wed, 27 Aug 2025 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] s390/bpf: Add s390 JIT support for timed
 may_goto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625281280.143338.15751749670685057893.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:00:12 +0000
References: <20250821113339.292434-1-iii@linux.ibm.com>
In-Reply-To: <20250821113339.292434-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Aug 2025 13:25:54 +0200 you wrote:
> v1: https://lore.kernel.org/bpf/20250821103256.291412-1-iii@linux.ibm.com/
> v1 -> v2: Fix test_stream_errors (caught by CI).
> 
> Hi,
> 
> This series adds timed may_goto implementation to the s390x JIT.
> Patch 1 is the implementation itself, patches 2-5 are the associated
> test changes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] s390/bpf: Add s390 JIT support for timed may_goto
    https://git.kernel.org/bpf/bpf-next/c/b8efa810c1db
  - [bpf-next,v2,2/5] selftests/bpf: Add a missing newline to the "bad arch spec" message
    https://git.kernel.org/bpf/bpf-next/c/b68dfcc12a32
  - [bpf-next,v2,3/5] selftests/bpf: Add __arch_s390x macro
    https://git.kernel.org/bpf/bpf-next/c/1e4e6b9e260d
  - [bpf-next,v2,4/5] selftests/bpf: Enable timed may_goto verifier tests on s390x
    https://git.kernel.org/bpf/bpf-next/c/7197dbcba230
  - [bpf-next,v2,5/5] selftests/bpf: Remove may_goto tests from DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/21bce5694054

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



