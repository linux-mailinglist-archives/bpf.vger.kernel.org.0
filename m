Return-Path: <bpf+bounces-21272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831884AD31
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3E01F24543
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D7745ED;
	Tue,  6 Feb 2024 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCQveWWU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD74745DE
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192027; cv=none; b=koHKZB8hYKPdBFxdt6MnwGhlWPoFjOgG3bYdofDoXBzbBTOi9qEJYzYPjpudGNUGXyORSBtbbdhMVRVgaxnOUDvjvBcKOPtykoRKNDVHB2Y5NCL9ee15EnHL1wbOBgsQprv0IIFL5f3NI+ARgC7y7PYf2aIfkG+nVF/V7k+dugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192027; c=relaxed/simple;
	bh=v/40idZaDk7QIHj3qvtRLhekGWgHHrgVcG94ZdP+txg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YIsdLmk1x/BWa2fFrqRoWelW/9dNouIxBwGCnBZD/6AwJ4CdPw9H+fu6ychYU3yIyTuAtTxK+4yBkKen8NO+xetccFIoXS6Ueq7YN5iR6fhqoKsXEMKd4zgXXf3d3ilSL5oQcf6s2MsHt1G/x+sEy2qMAjNUSdNbRsT4sgeYKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCQveWWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D9BC43390;
	Tue,  6 Feb 2024 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707192027;
	bh=v/40idZaDk7QIHj3qvtRLhekGWgHHrgVcG94ZdP+txg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCQveWWU9RfOU/AzDchkb7LkTc3hfpJbG1S5sJBxhhyf06YYoEHIKRnFIK3vNbqwJ
	 TZMJDmeME5wgzny8ph5qQI+Rw5QlgJf9asHtBr2GwmnwXdfvH/ijOYFpehPa41dR9q
	 EencjUA0Lsa6ly6IfFq4WVqGEE80issOqxmZGjgIG20HJM0zlZFB7ixD1DJYyT+xTT
	 96vD2l7fYf8VXQ6s0aRPEcActmOXmqCdL+stJ+bfkixLTvSvC6JCeMHUxMZAX5AXC9
	 KMYvOSVRFFZxZRfCQFvmMt4zNsb5/JmJEstZNOB65o+El11SVpKzQBenFVwo+GAUjg
	 VU2IBfMheTgZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D6EE2F2F9;
	Tue,  6 Feb 2024 04:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Enable static subprog calls in spin lock
 critical sections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170719202692.25774.2285679305015952977.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 04:00:26 +0000
References: <20240204222349.938118-1-memxor@gmail.com>
In-Reply-To: <20240204222349.938118-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, brho@google.com,
 void@manifault.com, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  4 Feb 2024 22:23:47 +0000 you wrote:
> This set allows a BPF program to make a call to a static subprog within
> a bpf_spin_lock critical section. This problem has been hit in sched-ext
> and ghOSt [0] as well, and is mostly an annoyance which is worked around
> by inling the static subprog into the critical section.
> 
> In case of sched-ext, there are a lot of other helper/kfunc calls that
> need to be allow listed for the support to be complete, but a separate
> follow up will deal with that.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Allow calling static subprogs while holding a bpf_spin_lock
    https://git.kernel.org/bpf/bpf-next/c/a44b1334aadd
  - [bpf-next,v2,2/2] selftests/bpf: Add test for static subprog call in lock cs
    https://git.kernel.org/bpf/bpf-next/c/e8699c4ff85b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



