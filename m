Return-Path: <bpf+bounces-72574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27DCC15BB1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E851890914
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E133396FD;
	Tue, 28 Oct 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebQmc8ol"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5A3081B8
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667934; cv=none; b=WZ05Y3050kWvcSxzX7+kHW1ooQijxTvfeo8fhSusk4JAcb7sMc+pzBq73VLS9GtxjlE6XUW9jzpqsIVlGzVq+uk5RS8SuUgEgjvW7LXBw5p7WhCnAXQETDAGAQm+byQ8IZ5VsvUs/FC3154vO1oS02CYLdBV3E4rn0613yuKeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667934; c=relaxed/simple;
	bh=THm16ndzj06DojLwICFWcOalj47J8grV6Xkr29WbmsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXYAP6HXhS7/vVWsWGrYVhHWAnjhEnjKE7AaP1c/Jn750czmzXicGUH0T+3t7x5BCod6V5x11H2XBtK5elps6pNEWTZVVwjg+3kUCOhr+uvPEdkbY6AwVYNSMrZkvPPUkXrpEMkH7e0lETvlxEOO78tsNyxdqRzijmdnrwncD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebQmc8ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED68FC4CEE7;
	Tue, 28 Oct 2025 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667933;
	bh=THm16ndzj06DojLwICFWcOalj47J8grV6Xkr29WbmsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebQmc8oloiWDB+RLxmLDORlLuU/ecjNV3HjP1o6TdyjiWleOqznoZEHJAJ8yuFtjx
	 2lfQH4BaH2cPLuBsczZ4ixM4KCQtfOhpxVC1nxUFq0AnQnrFLDg3KZsc2yGb2k7wzW
	 qUX7MTfTqoa7lrHJOTdkyLwhkeSbhxKz1kSDKvC4fLC2HQzsEImI+jLQJxobihSAyJ
	 nB4EajOE1jaXGmrl7k6USLhEvB5ah7H4UausOp010YYfMa0hArPzmOZgo6HCNi3S36
	 FUMYmPSzNDR/NhzjOE74n0apnPx8W0hi2MqxPMdOEJ5mzld7uYvMiFy/UnQd1ikiF8
	 PBcKuePCOB47Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3DC39EFA68;
	Tue, 28 Oct 2025 16:11:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools:bpf: fix missing closing parethesis for
 BTF_KIND_UNKN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176166791075.2291094.18133627510897823274.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 16:11:50 +0000
References: <20251028063345.1911-1-zhangchujun@cmss.chinamobile.com>
In-Reply-To: <20251028063345.1911-1-zhangchujun@cmss.chinamobile.com>
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Oct 2025 14:33:45 +0800 you wrote:
> In the btf_dumper_do_type function, the debug print statement for
> BTF_KIND_UNKN was missing a closing parenthesis in the output format.
> This patch adds the missing ')' to ensure proper formatting of the
> dump output.
> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
> 
> [...]

Here is the summary with links:
  - tools:bpf: fix missing closing parethesis for BTF_KIND_UNKN
    https://git.kernel.org/bpf/bpf-next/c/88427328e35d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



