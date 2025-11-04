Return-Path: <bpf+bounces-73487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C8C32AD1
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E06424316
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37561340286;
	Tue,  4 Nov 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYEwx7vi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38133FE20;
	Tue,  4 Nov 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281037; cv=none; b=DgtZ9oEOWZ1P1avUuUO/5r21XDI9am7+Brfw1rn45C9rBO5asw13k+d5nB1ZJzrqNfMZCTXazxwPrqkbdITM3OJ0wChdaYsJHAhhaHFLIWWDy0Jyi9CJNuRXfdhxggPaeN+QG8gH/lcppIEvXPCyfmU/SfcWYSEaUL57O1Go+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281037; c=relaxed/simple;
	bh=4PjbvEITATd/KK+H9RZj7sFJzXr9iIiCoLwDCYfNvms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LANpQenGWD81bmez58/hMg38ESQLd8sQSuzJDFkYRCgVgixHCe/8yOKjkmPrcQT6L8xYVM0W8XKNNXZo55yU7JR/bb2wftAp8xGkzAldDUNb3XP6H3FvRNf9Zahs32zby+4tqhDoIzdB6sbscAruJYSUi/rTXi36aSqOa/xXZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYEwx7vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3D5C116B1;
	Tue,  4 Nov 2025 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762281037;
	bh=4PjbvEITATd/KK+H9RZj7sFJzXr9iIiCoLwDCYfNvms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZYEwx7vi5+6/ZnqSKBJkWesI841vPclF4+VExM5gw8BrzH9kPPS1M5KmpooSChWOr
	 hDLeu8fmQhq3hV+MvJ05C78aIawDNjlVWCBfgIogKGEUOgpCnUe9C2sxyG1AeQgLui
	 z4YjncEAVV1wv97Xw8bg1TD6GbIYuYv4YADvZ2h3uUzUEYbefGMRJnsjTSqG8RRTgl
	 2TfRMVk8EebDI1qMjgEmrCzn84KGDQESFipzGWTGHrklsF7hSso6vgJoLEZ+Gd9Vn2
	 ua/BO/GfzVWICPfiKBRQQqj+0UTULu5akUwq/iSBidfJafys1n6YR2zHAZNbNJz8ei
	 DELCIfrGiroLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC7380AA44;
	Tue,  4 Nov 2025 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add missing BPF k/uprobe program
 types
 to docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176228101125.2956689.5122391754843151442.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 18:30:11 +0000
References: <20251029180932.98038-1-donald.hunter@gmail.com>
In-Reply-To: <20251029180932.98038-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 29 Oct 2025 18:09:32 +0000 you wrote:
> Update the table of program types in the libbpf docs with the missing
> k/uprobe multi and session program types.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> 
> ---
> Changes in v2:
> - Document the correct attach types for kprobe.session, uprobe.multi and
>   uprobe.session, thanks Jiri Olsa
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] docs/bpf: Add missing BPF k/uprobe program types to docs
    https://git.kernel.org/bpf/bpf-next/c/b3387b312226

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



