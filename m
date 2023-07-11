Return-Path: <bpf+bounces-4731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFE74E835
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9271F281572
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47856174CF;
	Tue, 11 Jul 2023 07:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3945CBC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9FB7C433C9;
	Tue, 11 Jul 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689061220;
	bh=dIb9GFr8USCYKn4XB7TPv53MjezVGZWYWqXzou5cp8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBRwC0FaJc15lkeaxo0JrbrIeImrXu1h5SYE2Gf7xSU1jx6wmWfs3X49jlXRpEVsE
	 npouWFrYld3tiQO2Td5KvBF0/cTKMa2nUoQrhDk6MqDuCyMSX/uzQ+LxgIpcWfVwoT
	 ZonROHXBqeDLTokV+cmc8tQGMEKcn6bru9vG0XuYXPebAncXshpyD7lh8ldMeEgWpr
	 +KRoqoFRqxdGTfoWDMc6+8cC6eJbWtneDKyHtbhXvO6MZHH4HJrD7jJvdCrSK3LaV6
	 RA3CTvQ9/wgF52MatVuu/SAI6q3QItTzaB1V+OhGegp0PXXSxf2jnmg6X4PTRwWckw
	 JYq4CEAPC0WaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F253E52BEF;
	Tue, 11 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix realloc API handling in zero-sized edge
 cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168906122064.6555.7083123219190152673.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 07:40:20 +0000
References: <20230711024150.1566433-1-andrii@kernel.org>
In-Reply-To: <20230711024150.1566433-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 10 Jul 2023 19:41:50 -0700 you wrote:
> realloc() and reallocarray() can either return NULL or a special
> non-NULL pointer, if their size argument is zero. This requires a bit
> more care to handle NULL-as-valid-result situation differently from
> NULL-as-error case. This has caused real issues before ([0]), and just
> recently bit again in production when performing bpf_program__attach_usdt().
> 
> This patch fixes 4 places that do or potentially could suffer from this
> mishandling of NULL, including the reported USDT-related one.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix realloc API handling in zero-sized edge cases
    https://git.kernel.org/bpf/bpf-next/c/8a0260dbf655

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



