Return-Path: <bpf+bounces-43416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3A9B5476
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD1D1C2281E
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E882076AA;
	Tue, 29 Oct 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRUEkzVS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576A18F2C3;
	Tue, 29 Oct 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235022; cv=none; b=T+Yy+SHcwCIGLe5yK63ULG7mm0vjHqutQff38Gi/xTrCwWE/4p9fgXBq02RL95us2aZwVhnbdF/38rWSTMfja3QLUYQjZkwGKIYWx8JQ56yOsJKoxUUslYq83Gne5wJ3o4FZ4PLjgKkZsv5yGsyT6y/JHZoCQ7Jpc+Y4y7MpcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235022; c=relaxed/simple;
	bh=PFgZmx0MmwZRZ9SmGxPG2m4THj+CVCWCVSoLKxf7Uw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ipahOS8pCvjDvQnnBAOiVXeIdrXvQ17yuvM+N7H/0pYVNbbfiRmmUyEDoMnMYqHvXxEYKq+ScCzomAnvglSFNqtUqO5bBJqbEtTjn/AYwN4CUKezfKJ+YRDQjKBM4ozKYMZfskek1N5lx+yJgCDbt4rYQzvp5xZdWiTi9dXZwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRUEkzVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6273C4CECD;
	Tue, 29 Oct 2024 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730235022;
	bh=PFgZmx0MmwZRZ9SmGxPG2m4THj+CVCWCVSoLKxf7Uw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kRUEkzVSwEOGfh40PPK6vCQ+1yHdRG7QbR3fYQz/DhFiWR019VX39ZzkiqNaccyuR
	 gYXWImoxMmGY0QECTwoykxTRnrT0dO7XVqPIlZS/eSfcIwszaCop7wYCa6vHItkuf4
	 7P3/1IgT8PVQhDUWFzZ2ZHuhLQjRTDhSvC1VbMtp+4KsNHcuL5I+nwXP3BFwAILaxL
	 fhji1hMbaB7f06mrVIOfIw3i2lrKr2czZ4QkI3eQkVYp+iJZSoyGoiXhMbsWTOVoxo
	 HdVMlRBAEQwyheG1qFZh0IY+Kju0uZabV2Npv7qZL/xIOGJMwQKq0ljE0JtfNMAwDg
	 8JNnNbTMa4u5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE630380AC08;
	Tue, 29 Oct 2024 20:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 1/2] bpf: Fix out-of-bounds write in
 trie_get_next_key()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173023502951.818655.12095228890025333064.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 20:50:29 +0000
References: <Zxx384ZfdlFYnz6J@localhost.localdomain>
In-Reply-To: <Zxx384ZfdlFYnz6J@localhost.localdomain>
To: Byeonguk Jeong <jungbu2855@gmail.com>
Cc: toke@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 houtao@huaweicloud.com, yonghong.song@linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 26 Oct 2024 14:02:43 +0900 you wrote:
> trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> full paths from the root to leaves. For example, consider a trie with
> max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> .prefixlen = 8 make 9 nodes be written on the node stack with size 8.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/2] bpf: Fix out-of-bounds write in trie_get_next_key()
    https://git.kernel.org/bpf/bpf/c/13400ac8fb80
  - [v2,bpf,2/2] selftests/bpf: Add test for trie_get_next_key()
    https://git.kernel.org/bpf/bpf/c/d7f214aeacb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



