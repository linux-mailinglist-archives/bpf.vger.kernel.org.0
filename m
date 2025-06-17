Return-Path: <bpf+bounces-60835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5EADDB2E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F7F1941B2D
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269AF2EBB8E;
	Tue, 17 Jun 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZgOHwnb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20802EBB82
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184080; cv=none; b=CxEIuWuUO85eSVAOh04/duddflmAnPknKGGD+pqqJNRzq/z1Q54e283Mpy9xldDrd7lLZYPdizkfBhJahzjmwxc2gWFt38XzZfTj+b3ry4d7wbJUgfZn8M9nWncLXuyRxwUxlqN0dWg0VfOrqUXSIyoeLfdvrxGdfxQEk9kDWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184080; c=relaxed/simple;
	bh=fF88/4rrQ3TjyM5pajDY2aoHrPQoYejlLVe2oyqzIgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AONGaXGrdE2/KvaLbEuKVqYbWYRstvUXiIHj63QnJAUkx8fkFa4pYtsiWeQDybbbM6QaCLBO7JnJPc7pXKJewOBoxlBu02DS7PhlmkwQ2DYYng1dJAs1w9gtZ9LELBCKYZtDphF5eKRpI+408YjWhI7zvuFWzbsawMZTmLtswR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZgOHwnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F9CC4CEE3;
	Tue, 17 Jun 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750184080;
	bh=fF88/4rrQ3TjyM5pajDY2aoHrPQoYejlLVe2oyqzIgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZgOHwnbUezW2D4+1E1aB8ii12O4PmAop8TYYEFG3fKanaeHKE7rFej0hL0ab+l3M
	 hSPSuED+0MAIdZbtcOtzsUvQdrXhHNNw6R/qHnHHh/s1G6I3MkWKG1wau5HAYKpTee
	 bh/+1d/+/W5RLHw711kANnTfIfRgVBZTxWgisdWHdZDGW4lQINkxAmSlI8PaJ4bXpV
	 g9LJ8V9j8+SJqnXJFobJE4YYU8aTDxd3YSXy5U42O5pFjDv1DFA9H7kJOgaGgWeyvv
	 7Q+ZTpWf5EbPTNb9oHBI6/jJqpFEHD7cG1X/sYcJFc/W3762p6EeZeEWEiw+ue+I7J
	 OzJSjOVXcnPuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E6D5539EFFE0;
	Tue, 17 Jun 2025 18:15:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix RELEASE build failure with
 gcc14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175018410874.3219184.1011690780572987225.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 18:15:08 +0000
References: <20250617044956.2686668-1-yonghong.song@linux.dev>
In-Reply-To: <20250617044956.2686668-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 16 Jun 2025 21:49:56 -0700 you wrote:
> With gcc14, when building with RELEASE=1, I hit four below compilation
> failure:
> 
> Error 1:
>   In file included from test_loader.c:6:
>   test_loader.c: In function ‘run_subtest’: test_progs.h:194:17:
>       error: ‘retval’ may be used uninitialized in this function
>    [-Werror=maybe-uninitialized]
>     194 |                 fprintf(stdout, ##format);           \
>         |                 ^~~~~~~
>   test_loader.c:958:13: note: ‘retval’ was declared here
>     958 |         int retval, err, i;
>         |             ^~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix RELEASE build failure with gcc14
    https://git.kernel.org/bpf/bpf-next/c/a633dab4b4d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



