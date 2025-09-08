Return-Path: <bpf+bounces-67731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E2B4968F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BF93A8FD9
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24B30F948;
	Mon,  8 Sep 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peaFrXvp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361130F946;
	Mon,  8 Sep 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351408; cv=none; b=XUaRGNtDA+vsw6MxGRkuC4QTGWxvx6uAwH//SaE397Q6VtCVEqiXm7EMtIU/aI/OXIQHV2Ti8+YgHRuGIeDI0r6EXroONSwoY4T7n2gXyNqiqkJ30j6cxe/tUM7ztktu1+TjRiSaEQgO0SICJaiA9ziDHWRH8ukNp4I8y8nYgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351408; c=relaxed/simple;
	bh=ZpzacrEH0AU5Cd96u17CXAH4e8FeBla7p+oGGlmiz6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3oiPNuFyjyvjWztHlv/az39E6uSyxCC4aPgdxBtpgtQyFmHyMXAbUGwjCrrzcJjUZnZF/4fez/oEseBN4hbO1uxsCC6azg1zaQ/nKaRncCzfYU7Cz+F3p6IIyKGlGhN7FPKeCfLO/MTbXZaFa3G7bYIx43aAsJdVxaSJRXTxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peaFrXvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4BAC4CEF1;
	Mon,  8 Sep 2025 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351407;
	bh=ZpzacrEH0AU5Cd96u17CXAH4e8FeBla7p+oGGlmiz6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=peaFrXvpIk7JnYFOWJA22NHqqeWr4DRjEuB+AuxFAHamMDErvPWfGqOhO3HVQaO1f
	 ykMDJAvt+02JW1PUbJgSSvndBFdeDBi/V/QqU/td+QrlC11Fgxcw+4X13bOqLTVfxs
	 O0K61ESmIcFx7OByiQRugmJ82gOmY41mnffbd6MGX0eequqBRd53kDJ9wy4QQXzXx7
	 2c73KqKVGGeLOALDpt49jefR9b0fjf5bAx5mfzOAMyp/YjjyWY6iJ5aI1eKLp8lw+Y
	 VaWpQNeAXEjuH17NgmkgWG+G91YNw5Tkq4OMj2tHZ3gXjDjrZxK1cUgW8sLaXFHVc7
	 bhHOv91+//f2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4E383BF69;
	Mon,  8 Sep 2025 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] bpf: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175735141100.4178020.7968878718213061793.git-patchwork-notify@kernel.org>
Date: Mon, 08 Sep 2025 17:10:11 +0000
References: <20250905085309.94596-1-marco.crivellari@suse.com>
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Sep 2025 10:53:06 +0200 you wrote:
> Hi!
> 
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> [...]

Here is the summary with links:
  - [1/3] bpf: replace use of system_wq with system_percpu_wq
    https://git.kernel.org/bpf/bpf-next/c/34f86083a4e1
  - [2/3] bpf: replace use of system_unbound_wq with system_dfl_wq
    https://git.kernel.org/bpf/bpf-next/c/0409819a0021
  - [3/3] bpf: WQ_PERCPU added to alloc_workqueue users
    https://git.kernel.org/bpf/bpf-next/c/a857210b104f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



