Return-Path: <bpf+bounces-53772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F07EA5A734
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950411725D4
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF52080FD;
	Mon, 10 Mar 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atI8AQvu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8071FF618
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645798; cv=none; b=nC7qoebNmlvRzfTEMehF49qWceeIotJBWFB+4m9B1oppWQyYb4/zSzRwWoqUGWthT555BSZ7Mr9YFJ9jFTYga7zeSRXAu3ZwpKFt2+ngqPOxmWAjpFZB3xFWg+IPA7Vff7KurZKmaz3e0cZlUNNs/UMGQnC5z6NdVhTpVN6yuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645798; c=relaxed/simple;
	bh=UGOEqZG0TBsIgFoJglWXM/8zRgOeUZrnHWuvRUfx1NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CTJ7MCJIahzWSFFo82YxB6c8ENgiTPOGoITbYQ2JVb1xuK+mGKcrvlBpCFgT7w9Dgf7kBKxI9naPOALwQWLaksIV69FwIpzf5Nmqz8Br9mwP0pl4gPbjxA4tY6SZDd0v13HSVNqXrT9lYXqkUGs0DQWb/uD9QsEe+/v1HK4lvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atI8AQvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E535AC4CEEA;
	Mon, 10 Mar 2025 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645798;
	bh=UGOEqZG0TBsIgFoJglWXM/8zRgOeUZrnHWuvRUfx1NQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=atI8AQvuKXohoHSL+SYiqmDHgeNYe2z5OvYR3rEqkNQ7rl7JvF/n6nTfUkHq0qaS2
	 nrUHWhU8uonAvCEmiYN98m8txOUkqO3OAlUTswCPuxQkiKwBqHofWpVo8ou8AJr2w6
	 /gtSmWlMwZPIwdBJ2bAHEHJQpLDDwR6b10AToZuuDwrJVa0e7SXmhVv29d+kN7AWjT
	 BKNrE82pza+ias+TSYJMndFhcwY5CUAxnPFU30l8ycT9LL+1v0ynU0ZVdLoom/9JXc
	 9HqoBLZHGOMdMrhwmS7K1NBWl9iaDWyNEAE30HhzftqcrAI2OJhZg228XK+NGY9QwI
	 JF8QwFwsUfNrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CBA380AACB;
	Mon, 10 Mar 2025 22:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] mm: Fix the flipped condition in
 gfpflags_allow_spinning()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174164583201.3719472.12293725364552859716.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 22:30:32 +0000
References: <20250310124017.187-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250310124017.187-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, vbabka@suse.cz, linux-mm@kvack.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 10 Mar 2025 13:40:17 +0100 you wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> 
> The function gfpflags_allow_spinning() has a bug that makes it return
> the opposite result than intended. This could contribute to deadlocks as
> usage profilerates, for now it was noticed as a performance regression
> due to try_charge_memcg() not refilling memcg stock when it could. Fix
> the flipped condition.
> 
> [...]

Here is the summary with links:
  - [bpf-next] mm: Fix the flipped condition in gfpflags_allow_spinning()
    https://git.kernel.org/bpf/bpf-next/c/157a50236c30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



