Return-Path: <bpf+bounces-56455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B2A97935
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA15A39D9
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597629C34E;
	Tue, 22 Apr 2025 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip3a/lur"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF62C376B
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357999; cv=none; b=cOKwr+D2hn2Uek6+n2XsUP73BEFMf348HKNinzHqB41+X5/oPDlp6iboaAoIIIqJ5hnDhzweyPBrJUGyblj2X1SQtkq1iT2rwWAX0wW4AGKf7OH1bmurK+AsAffizsyMJnEnKxJ4V4YiF4LbUqfZ+8S1IV5BxBS6avEX8Uf+sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357999; c=relaxed/simple;
	bh=tPji3gpjo9cXcqlz8I6X61GYBei9Cp25qXglMqs+u8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ppDiVY8IUbxbSPvMS0XSi5oYS0RbYe+bicdp/SD+2j2Q+fmB7blis8/1nwElbd1o5dMd/2vDlnPMK6HvPAPcr23D7MiMh+/pRP8FPLlSeA6T7mjbRB3pRQxpv9YU0+HKfKDBZosYaQMm/khICkq9o5r3dTBlEt8g4Zzs+ly1alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip3a/lur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810B6C4CEE9;
	Tue, 22 Apr 2025 21:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745357998;
	bh=tPji3gpjo9cXcqlz8I6X61GYBei9Cp25qXglMqs+u8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ip3a/lur8TohfbPlwJWcFp0d77fabXhm1o0UELqM57JehBUp6P/bwouR1GbGnGMtw
	 bLwEnwvqgpULHNvvk1CV4v+XNrUxJ8VHgOxoGvGvZFDptvjAjWo4fX7zVrjmBmaokG
	 p8Vu6V13SZd7iWin/KAt/eNECyAcjSYqaa9SsdM2aBR0VulnfbTRNf5WR/jUMiVNjW
	 gAYDaRApBk6FEvKAm19kd53lF6dVd7GctQFQYDuGkNXXHboy1KZv4fw+728/5kyOOh
	 SrPAbItAohyKwU2GoyCIGZRTkU8NhJTA9LFKJm0jl9KAxT4Av4IlTYH2/WyFPdBsCV
	 iZj1Cr3ROq1Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B54380CEF4;
	Tue, 22 Apr 2025 21:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid resource
 leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174535803702.2060528.16375701707880521044.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 21:40:37 +0000
References: <20250421174405.26080-1-malayarout91@gmail.com>
In-Reply-To: <20250421174405.26080-1-malayarout91@gmail.com>
To: malaya kumar rout <malayarout91@gmail.com>
Cc: andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 21 Apr 2025 23:14:05 +0530 you wrote:
> Static analysis found an issue in bench_htab_mem.c and sk_assign.c
> 
> cppcheck output before this patch:
> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: Resource leak: fd [resourceLeak]
> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Resource leak: tc [resourceLeak]
> 
> cppcheck output after this patch:
> No resource leaks found
> 
> [...]

Here is the summary with links:
  - selftests/bpf: close the file descriptor to avoid resource leaks
    https://git.kernel.org/bpf/bpf-next/c/be2fea9c07d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



