Return-Path: <bpf+bounces-56651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE9A9BB95
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4EC466F24
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D203A32;
	Fri, 25 Apr 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6eHc1hA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7F382
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745539799; cv=none; b=Qr8ANBP6ZkjfElTi5ZTiAzJhTSyJWt99WoRfrp0UaJ8kj/YWPVglPGtvuNj/rXE5zPalI4TOPXBJNhPiJK3KI4b6zgbR7kvEm2fXHnVXB7aozBpZvuQPNe8ix2yKtcN38SSjcVD1fBg+6h09HsOaWhVz3Ah+LQWlkHhOJbucO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745539799; c=relaxed/simple;
	bh=TYcf4Y99n+xZ5rN+8qTpQWoMnsW5cUCW4Dng2lmDaHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2vqdlMGDkQ/tO7jwUipXve/Zbnfl5wYi3UIFuGEGNFXUyR+pks2LErYcyJAoARbVnoeiTiY/GECRUopEj1Fb4uIlO9lOdtPdYI8cQlXJfrQNm2hY1EVGjjfq5qaMc0vniZg6rv0erQI7U/QRhNNQEmP7+3H4hoTMB1MKd8fiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6eHc1hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF02C4CEE8;
	Fri, 25 Apr 2025 00:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745539798;
	bh=TYcf4Y99n+xZ5rN+8qTpQWoMnsW5cUCW4Dng2lmDaHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6eHc1hAsQmVnrSVNqcPizoX3q40HGId3Fwauvu42n/dLTQwRA0SH/eQglk2/+pwQ
	 o5Dq105GbgdSQMxl3+eFs4Ltaa9zwkVKMo4WxsVFynJ8hxqZ3gIHmnVkDT8A7QVu/p
	 4rK0JB+61NjVdX9QKjmff/VBn3LvCHyHJYpPkSE8yDY1RiFK6TOWdf5LLSvkbBRTH1
	 eqEGerFR+9mUYxJ3bNuowJLhrz2iwjQqVnAo/W9uIDemI/15OkLNR8qxsZxrtC6rmy
	 loDQ9Aj4RjgDpFGNlb8ermRHWL0Q5y22KOI3PNXXXFHEnjP23kaHvRdFZI+76rRjXj
	 4IqUP+vsTBClQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341B2380CFD9;
	Fri, 25 Apr 2025 00:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174553983700.3526942.13762326617930238465.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:10:37 +0000
References: <20250424165525.154403-1-iii@linux.ibm.com>
In-Reply-To: <20250424165525.154403-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> Hi,
> 
> I tried running the arena_spin_lock test on s390x and ran into the
> following issues:
> 
> * Changing the header file does not lead to rebuilding the test.
> * The checked for number of CPUs and the actually required number of
>   CPUs are different.
> * Endianness issue in spinlock definition.
> 
> [...]

Here is the summary with links:
  - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
    https://git.kernel.org/netdev/net-next/c/6fdc754b922b
  - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
    (no matching commit)
  - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



