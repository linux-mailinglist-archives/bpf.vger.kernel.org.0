Return-Path: <bpf+bounces-4876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF375131A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC161C21090
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29BF9D0;
	Wed, 12 Jul 2023 22:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC6DF61
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 22:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55908C433C7;
	Wed, 12 Jul 2023 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689199221;
	bh=FO4w++Kv3sPxmZFdvsflchQiyZ7k0EFL3ujLavh8Tp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pfnAFiUgq10e1hGGI7dLsXhBBHXaAWDbKMo4sGlNqM9qfMiAWq0mreyCfbYuGUv3g
	 +qYUtFlNoOL7Hs6k/noorBb9yE3PsrwIA/PLjM53Xfcc0qjUmsvGGSDELZ1xmzfxVd
	 KCzHoEtTIDHpUcPwUKBExJD5kSLaFMRNfKuu3hUevRwLkIwqrOtt8atObYiQipVTwb
	 RBlfjGX6AKQOesESUo096V6VndTPNbR+VMYUcXekAXXjIEWh8QAdadmtb1aILMucKR
	 fHA7o90V4OumiJlDPCl8oTPiEKmVwmgBnWw0+rcY8wSI2J4VbfIubVJlpSVu22zJW3
	 pR7goJjEHZVnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33798E49BBF;
	Wed, 12 Jul 2023 22:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Use "fallthrough;" keyword instead of
 comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168919922120.4872.13067138812742561469.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 22:00:21 +0000
References: <20230712152322.81758-1-quentin@isovalent.com>
In-Reply-To: <20230712152322.81758-1-quentin@isovalent.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Jul 2023 16:23:22 +0100 you wrote:
> After using "__fallthrough;" in a switch/case block in bpftool's
> btf_dumper.c [0], and then turning it into a comment [1] to prevent a
> merge conflict in linux-next when the keyword was changed into just
> "fallthrough;" [2], we can now drop the comment and use the new keyword,
> no underscores.
> 
> Also update the other occurrence of "/* fallthrough */" in bpftool.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Use "fallthrough;" keyword instead of comments
    https://git.kernel.org/bpf/bpf-next/c/0a5550b1165c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



