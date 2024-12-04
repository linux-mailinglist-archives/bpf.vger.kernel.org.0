Return-Path: <bpf+bounces-46095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74519E437A
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717A8BE18CD
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065D20C021;
	Wed,  4 Dec 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSZnPth6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845991F5403
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333421; cv=none; b=V4p00wzxhhXZOJ1BCOEgTaJei2YYKrKOrsXz4e9pBsFd19VlaKsP2O06OAvVURPsMrqDrCCuMNJhIq9Eg1dylYe+uch2ccv1bs9sDMHOXJYsAYZ9wByctnH8B65b4abH4THHkLrb5nu3sppf/UNfxo2no8/KP9qJ5oG4mbAJWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333421; c=relaxed/simple;
	bh=az2r4ZGabw4cPzapYl0RZj6qhuP6yo1FLrCsDF0dCQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TPO3+yjqgzJrwq6pRJdULuMYgEBCh2yH2F8iBBddGqt0G2OKTbOD+9Cc58sb8WZwlW8KCpbxe3eieqzqS4dUvt5xFj4LE6sPGhLIXrzdxcSDrdnJKDqv0DHpBBs7rPMIYrp4jljEq4kjCXmGExZ3+KVof2OG3UUvHFnreqiGS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSZnPth6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD2DC4CECD;
	Wed,  4 Dec 2024 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733333419;
	bh=az2r4ZGabw4cPzapYl0RZj6qhuP6yo1FLrCsDF0dCQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kSZnPth63zDlviXUju8ksHDiyiSUWP1spHyDgV9HNyn2q7EYU0d6JlZ2+FTkGz0ie
	 /+7zcUUTmAzDuCUrdCTQjubdoqIpQkqaEHMaj4o2SmZeL22axrbR73oJtiU1mpLoQ0
	 i8oA86u0SypOXk8+/4LZDNd9XmhHganbfVlhV38f8kGcSXJ/3wMg99pzVOpdnzliec
	 bprVAHwZ9UVon3/DckuN8eeRsDi1Kd4gve8qkYBTra3VW1dXeux6LMvacW5Qn/PQD5
	 pXPbYjXGLmWDZxuLvGmz9WnLzTjAb5QAZtjMkhee6VDs3chnDMUAe9cFdSrkZb2+Sp
	 Ok4Ey1CIQGiHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1F33806673;
	Wed,  4 Dec 2024 17:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/5] Fixes for stack with allow_ptr_leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173333343351.1277728.7087223586728486550.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 17:30:33 +0000
References: <20241204044757.1483141-1-memxor@gmail.com>
In-Reply-To: <20241204044757.1483141-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tao.lyu@epfl.ch, mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca,
 sanidhya.kashyap@epfl.ch, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Dec 2024 20:47:52 -0800 you wrote:
> Two fixes for usability/correctness gaps when interacting with the stack
> without CAP_PERFMON (i.e. with allow_ptr_leaks = false). See the commits
> for details. I've verified that the tests fail when run without the fixes.
> 
> Changelog:
> ----------
> v3 -> v4
> v3: https://lore.kernel.org/bpf/20241202083814.1888784-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/5] bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
    https://git.kernel.org/bpf/bpf/c/69772f509e08
  - [bpf,v4,2/5] bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots
    https://git.kernel.org/bpf/bpf/c/b0e66977dc07
  - [bpf,v4,3/5] selftests/bpf: Introduce __caps_unpriv annotation for tests
    https://git.kernel.org/bpf/bpf/c/adfdd9c68566
  - [bpf,v4,4/5] selftests/bpf: Add test for reading from STACK_INVALID slots
    https://git.kernel.org/bpf/bpf/c/f513c3635078
  - [bpf,v4,5/5] selftests/bpf: Add test for narrow spill into 64-bit spilled scalar
    https://git.kernel.org/bpf/bpf/c/19b6dbc006ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



