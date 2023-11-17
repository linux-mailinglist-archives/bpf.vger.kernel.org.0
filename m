Return-Path: <bpf+bounces-15254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F4B7EF784
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ABC1C20A6A
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5A2941F;
	Fri, 17 Nov 2023 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epj13dmI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B56C8CC
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 18:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44CA5C433CA;
	Fri, 17 Nov 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700246424;
	bh=L1j+LsRUX3cqSi9S5Zk6H4/pARUV/oZvMNeH41/J6Gg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=epj13dmIe6QaLyy8h/EDP1L9ewD9IHoweyoEMQpH3lHrCkgZ53+YqcQv+xyXwA0q/
	 JwZnVgL9qtkFxA0pGJzhOVoIwwJnf8mW8xjhafenYkBVDz7e880BNMveUiXlS4u//T
	 zUJO7KlwIJDbhCrEVyixNvqPFKp83WkZiqI1i8RyGuEzoY9sqzjThq+XafP6MdjgQ/
	 nQlzN1M6pJMLeUdnUX6mDSynfVNXxv49fX7EMq+4/zjjbw6DfHmjGVwHuMfTctgnht
	 FkcC2rvGOWJpmDU64JYQxApMTnFdK1HVpqeqcZ9bDXQ5ZQv24aj7ZCThjGe/E0/EMH
	 VzgOC3KD6iJfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 235FFC4316B;
	Fri, 17 Nov 2023 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: rename BPF_F_TEST_SANITY_STRICT to
 BPF_F_TEST_REG_INVARIANTS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170024642414.4130.660756547469126579.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 18:40:24 +0000
References: <20231117171404.225508-1-andrii@kernel.org>
In-Reply-To: <20231117171404.225508-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Nov 2023 09:14:04 -0800 you wrote:
> Rename verifier internal flag BPF_F_TEST_SANITY_STRICT to more neutral
> BPF_F_TEST_REG_INVARIANTS. This is a follow up to [0].
> 
> A few selftests and veristat need to be adjusted in the same patch as
> well.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231112010609.848406-5-andrii@kernel.org/
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: rename BPF_F_TEST_SANITY_STRICT to BPF_F_TEST_REG_INVARIANTS
    https://git.kernel.org/bpf/bpf-next/c/ff8867af01da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



