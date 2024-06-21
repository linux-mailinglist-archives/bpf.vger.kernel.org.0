Return-Path: <bpf+bounces-32683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85C9118DE
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FC5284F25
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3586AE3;
	Fri, 21 Jun 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGsfS0wp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80582899
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718938831; cv=none; b=oghWRbaMq6tzuU/uC9fw8s5RgopxnZk87TUwru0LCI2ju0oX8dYgTkoiH0hYMxpCfs58FqYJY/I27RGqOMezBWJtPBQWeMGz/A7XTGJDGSEDWd7MqqINnME0UbCk5R9osujX1tbUoWD7ZefU81F7eY7ywDd0zdWtPFV/dZWyz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718938831; c=relaxed/simple;
	bh=urnadOlq2HbBOm64Z47sJOntg7zDAlckWeOYOt17MEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UwCQW7U+Rngs/vpK8j2ElJBuOys5JzAHKZij0oZh+TaDzPgm308rfy2cbxRs7zQe6mdGJMmUgVnHtOjOWM7/sAqLl/jd0xa+1WJWJWO9/bcTkoGab4cVhdK3RTB9D5CpeyLotI4kOcUWYR+PjzMP5Hme5ic+3HW8V9PlKGehc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGsfS0wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33946C4AF08;
	Fri, 21 Jun 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718938831;
	bh=urnadOlq2HbBOm64Z47sJOntg7zDAlckWeOYOt17MEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mGsfS0wpYnwFLzDnmH7GMtETYizAlc5H+dmENKu5Y71Oq2ZUJOyH3aWDgbng/LCkf
	 kGG3c3YdHiziC4mS+dg0cjemxemIlC7a9etGXJRLOxuRAmY7/4yBncMMxYd4WfA8wC
	 qgkyaOwjwYmlVlNULHO2/1TUTDdteOi0Y2KZIVizl4MtKrc5/jcbga9bAeHTn1G469
	 ikx7XxfKnxz0knpNhSyFmkp4Tl9wdpvFjXI3cqepx50fDd23a7Qp8GWHQt1jvDeuxI
	 jxYuUoB0mXzvmBN/kS4YuMYI+TszhG+LXCsELYkWVYQDut+W5tI32089FdzNUqewb7
	 VlDrDelN5zrFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1709DCF3B9B;
	Fri, 21 Jun 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2 0/3] Fix compiler warnings,
 looking for suggestions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171893883109.18859.2036012380257120725.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 03:00:31 +0000
References: <20240615022641.210320-1-rafael@rcpassos.me>
In-Reply-To: <20240615022641.210320-1-rafael@rcpassos.me>
To: Rafael Passos <rafael@rcpassos.me>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bp@alien8.de,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 mingo@redhat.com, puranjay@kernel.org, tglx@linutronix.de, will@kernel.org,
 xi.wang@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Jun 2024 23:24:07 -0300 you wrote:
> Hi,
> This patchset has a few fixes to compiler warnings.
> I am studying the BPF subsystem and wish to bring more tangible contributions.
> I would appreciate receiving suggestions on things to investigate.
> I also documented a bit in my blog. I could help with docs here, too.
> https://rcpassos.me/post/linux-ebpf-understanding-kernel-level-mechanics
> Thanks!
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2,1/3] bpf: remove unused parameter in bpf_jit_binary_pack_finalize
    https://git.kernel.org/bpf/bpf-next/c/9919c5c98cb2
  - [bpf-next,V2,2/3] bpf: remove unused parameter in __bpf_free_used_btfs
    https://git.kernel.org/bpf/bpf-next/c/ab224b9ef7c4
  - [bpf-next,V2,3/3] bpf: remove redeclaration of new_n in bpf_verifier_vlog
    https://git.kernel.org/bpf/bpf-next/c/21ab4980e02d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



