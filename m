Return-Path: <bpf+bounces-47729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2849FECC3
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 05:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64A21618A2
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 04:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C914B088;
	Tue, 31 Dec 2024 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj2J6tUn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014D2CA9;
	Tue, 31 Dec 2024 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735618811; cv=none; b=RukG4LqlgcZRy8wjqgiBjOXRn5BpEb0ZeuLw/MvIsayoZCgUT7eo5WqfqOFGED8tTvKLM1+2PhcN/AEenkqCChY+SikqypebS0BIgpWEgGGofJKROFwH27qe14Sq15ZWUb+EqtA6uxrdTJQxSl2P7DWzl2R6v2O26fB5s8uzvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735618811; c=relaxed/simple;
	bh=7dOTKs503ZhA8xmUouPE5S5JpNtSCCgDadm6Spfz8kE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UsBdrCsCLlrwRG9e9EdVIGknXpiv7OFEM912jlKx6AFuS5OrXiQyPWep0w7aDVTWU5gdzhJQQr2bWZw+guwPQDuN2Tp8LpLpcOE8Z6zkn/4egk5LJO5DoxqFp4WpiPu8kkZltBZURZnKcSCsUjYjxQYFJDXO+NeqCMdtRcVYkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj2J6tUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B37C4CECD;
	Tue, 31 Dec 2024 04:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735618810;
	bh=7dOTKs503ZhA8xmUouPE5S5JpNtSCCgDadm6Spfz8kE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nj2J6tUnVx9v4c0DMI9i1Va9ZNIr61mWE4XEDqnwqvOqDquNB8wiVYoo2NyIYrr2z
	 TarHAEiFeGwtaUj8mMYIGsFWsTcCOBSsl3q0L6e0XkgdndCW3NHLP6/tqnZWE8jqh7
	 kD09WrqbUZEL/+LLoGICU+FevoXXLbxnFcjOKORbJgOi/Jqz0YMbngAeRr/poKMXS6
	 m1RTQQZ2ToLJ8nu2kBwBvXqiRZf1oIbzwAAoB87lcslzEVlQnTRhcgFuX6YSjfRhvR
	 bLzvFjzxvJShFLwINh2r0++6/2aP+Y8iA/6DBZO/qAyWMMIncg3dwAbkOHWOEn4T+Y
	 xse/5z25xpZTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BEE380A964;
	Tue, 31 Dec 2024 04:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Use refcount_t instead of atomic_t for mmap_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173561883026.1501827.6312568520411319488.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 04:20:30 +0000
References: <6ecce439a6bc81adb85d5080908ea8959b792a50.1735542814.git.xiaopei01@kylinos.cn>
In-Reply-To: <6ecce439a6bc81adb85d5080908ea8959b792a50.1735542814.git.xiaopei01@kylinos.cn>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 30 Dec 2024 15:16:55 +0800 you wrote:
> Use an API that resembles more the actual use of mmap_count.
> 
> Found by cocci:
> kernel/bpf/arena.c:245:6-25: WARNING: atomic_dec_and_test variation before object free at line 249.
> 
> Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412292037.LXlYSHKl-lkp@intel.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - bpf: Use refcount_t instead of atomic_t for mmap_count
    https://git.kernel.org/bpf/bpf-next/c/dfa94ce54f41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



