Return-Path: <bpf+bounces-12848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D77D1495
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5281C20F9C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44382200CC;
	Fri, 20 Oct 2023 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLPHbulC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A4200C7
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A847C433C9;
	Fri, 20 Oct 2023 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697821830;
	bh=BkesrUhmXpYgERrkywRkdp41NNXEowX4fb6JKZTCKv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fLPHbulCTl/plEuvWaDV56sBc2Jxn2FpNBA5/v68AbT5n5Vu85OyVN1x9aqya2HVm
	 gSe0NEDU8OEGbQ/rDHfDB9Ajq9+hk2sYGfcEg9Zcv76Dz2E+j23+1vEKfRjyprItxe
	 3uOv52r8kSEe190iULzJQoACE7uVyVNr7qrU6dbdIF4F27QUs1OfcLMNHMluPPmemz
	 rgKFVGyKb7Y/ZOQLNblO6LaP2tiYCgJ9YKxDLBaHNJfA2/rCDdvfo/Sr2IHKy3EHuF
	 qknuHumeeeOHYk31vZ0W0iDVCajKLRw45raDf78OZznbXpOK0cIWRYME4nttkO35gP
	 AGO9aT6BKaRtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E861FC595CE;
	Fri, 20 Oct 2023 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Make linked_list failure test more
 robust
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169782182994.30621.4999717933918919408.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 17:10:29 +0000
References: <20231020144839.2734006-1-memxor@gmail.com>
In-Reply-To: <20231020144839.2734006-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 20 Oct 2023 14:48:39 +0000 you wrote:
> The linked list failure test 'pop_front_off' and 'pop_back_off'
> currently rely on matching exact instruction and register values.  The
> purpose of the test is to ensure the offset is correctly incremented for
> the returned pointers from list pop helpers, which can then be used with
> container_of to obtain the real object. Hence, somehow obtaining the
> information that the offset is 48 will work for us. Make the test more
> robust by relying on verifier error string of bpf_spin_lock and remove
> dependence on fragile instruction index or register number, which can be
> affected by different clang versions used to build the selftests.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Make linked_list failure test more robust
    https://git.kernel.org/bpf/bpf-next/c/da1055b673f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



