Return-Path: <bpf+bounces-29608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503F8C3979
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F99828131E
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99FA5914A;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA3p2M0N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E82A1A4
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715558430; cv=none; b=PnzixQfFhjlTud6fftkIvEHdht+J2NiZ9myqciC6jM7vbl6aGJ3ck7GdrRJXiiKx0/AG1VWjpgiCPPCLuoMuZfLeAIn+UfJY2nKPdESantxVbp6rHqQe92gyljHgmrAFNi1L9v/X5hZ9pNOLXh1/+6v+5CCgHsqOCyjY+UhJ0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715558430; c=relaxed/simple;
	bh=LhdYkC0qbftljk8QqStc8yJRl81lvAVfmzyVKqOIP0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NrYkF6Rwx9F1sOCbuk4u8wSxDLyBcPfQoF2hbz1m5kAzYA33awffbtooIPLMAVUh7naGYWwuXNRs28Zr8Ex9iKx6w+HLFbCABIYfVCUVq8LukwPfphAF4F0/oMsv/YOaBFnGIvFiuYejLN0V5onMFVwVz2xY0U/wXSA4WEJ+uxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA3p2M0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1254C4AF11;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715558430;
	bh=LhdYkC0qbftljk8QqStc8yJRl81lvAVfmzyVKqOIP0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jA3p2M0NdgP9ZPkjdJrO+3Ak7Q/cwEqJjn9HOCdxL2yu+aJEkWkMq4z3Pcc7W2BD5
	 O6mS4/+hrAAajdJjW7eQJevJsNpmnBHvL9SVQ2IDq4HI29riJbpB+HnivvGRclX03M
	 HqPCkgRIgY9g05AZv3xbskmWTNPUqelqjnjsvJBe0sXuJ1GgOTPesrydCNgtQWXElc
	 87FqtnGI4bMngpSS8TuIH9acmVQrQusaovg3UHLbU6noc8P6jOYebuIDifq6v3OSxx
	 834B/bttz9UrTIqgXHWU6IZgqOMSEP/Z1EbObmES+Jz0hts4NM8RiLgMuxC8s17v7w
	 qVbkz9aC4D8XQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFFD0C4339F;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] s390/bpf: Emit a barrier for BPF_FETCH
 instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555842991.18024.15096430616731560463.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:00:29 +0000
References: <20240507000557.12048-1-iii@linux.ibm.com>
In-Reply-To: <20240507000557.12048-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 May 2024 02:02:49 +0200 you wrote:
> BPF_ATOMIC_OP() macro documentation states that "BPF_ADD | BPF_FETCH"
> should be the same as atomic_fetch_add(), which is currently not the
> case on s390x: the serialization instruction "bcr 14,0" is missing.
> This applies to "and", "or" and "xor" variants too.
> 
> s390x is allowed to reorder stores with subsequent fetches from
> different addresses, so code relying on BPF_FETCH acting as a barrier,
> for example:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] s390/bpf: Emit a barrier for BPF_FETCH instructions
    https://git.kernel.org/bpf/bpf-next/c/68378982f0b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



