Return-Path: <bpf+bounces-61571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB9AE8EDD
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1B3B7011
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00792DA76D;
	Wed, 25 Jun 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKftlTBf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3B289823
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880382; cv=none; b=TGlOAdcqgI2ZUKq8Z0QAOl3Cjij3t5mrbv5rRkwDQ0DbpJbRH7cQsj+fT4y5ERPbZdoYv99ZGuG2qzuKvf9sbGBSXKAybHDlLp0lmlgFGKFkKyKF5DqViU8bsrsa6pPUOn/jbB+9tZqRxnqMyRchy/BKMEHll/i8hBy6LcjUFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880382; c=relaxed/simple;
	bh=hl/a4FGYKQlwIrUcnf+w8GTXLxsFKLmH6/GaTnWcVTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mdPjDy8r/i3D1gJR1K8VdfNYfbwWjmJebADfn9MyVgPTbySvWnHdyK8MangZXT7n+va4mk6rPnbl85LNnE6KGxd5QA9ogpHOhIZxwm2CpjUYy4rPFJ1KpO9fPAAhjGb5NOCF/AyBLtsbnzTgqLDaySw17IP+y6FmCCNCS1nRuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKftlTBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F24C4CEEA;
	Wed, 25 Jun 2025 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750880379;
	bh=hl/a4FGYKQlwIrUcnf+w8GTXLxsFKLmH6/GaTnWcVTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKftlTBfBszkRLNGpf/yCsA92qi92cfi7qiy70szNa5enB+uuNc9klIgGVvuw25Lz
	 BBo9bD6rPFt/e9ff9fkUmNF6M6zNJUyiKhh3fazxDp2zXnCqNOXdzHhc639w/k2QAA
	 2wkeCF4ShmfE6eXxXYBXC2hrpJH5W7Uu1QpGDGbtEjCSEdKI1krl5EJdkew0xm8uUq
	 hsn10tzqid0kC+/jJh/kMiAGaqRYU/vacH452LALHcJxHrHeWSulJlmZan+a0PczAn
	 zXxXMTYOMKQzHHywUjk9efP+8qSM9NvjcX3bfXJdQvmTp43W6laMffimUjPARwHpRl
	 DRla1mggajvfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCB3A40FCB;
	Wed, 25 Jun 2025 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] libbpf: fix possible use-after-free for externs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175088040601.602008.12808154479939089792.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 19:40:06 +0000
References: <20250625050215.2777374-1-amscanne@meta.com>
In-Reply-To: <20250625050215.2777374-1-amscanne@meta.com>
To: Adin Scannell <amscanne@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 24 Jun 2025 22:02:15 -0700 you wrote:
> The `name` field in `obj->externs` points into the BTF data at initial
> open time. However, some functions may invalidate this after opening and
> before loading (e.g. `bpf_map__set_value_size`), which results in
> pointers into freed memory and undefined behavior.
> 
> The simplest solution is to simply `strdup` these strings, similar to
> the `essent_name`, and free them at the same time.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] libbpf: fix possible use-after-free for externs
    https://git.kernel.org/bpf/bpf/c/fa6f092cc0a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



