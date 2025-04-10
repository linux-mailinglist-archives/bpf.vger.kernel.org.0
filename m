Return-Path: <bpf+bounces-55698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE7A85048
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D04C6546
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5090F2147F8;
	Thu, 10 Apr 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODI6pEIm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8025634;
	Thu, 10 Apr 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328999; cv=none; b=NWo7vrGNdQt+MIrfxccfWfVQke2qfkedwKIw5YhgdHXrDu70bZG6P7ohbyi/bEW6gQUJS6OUuehxi1sxGvNeXMfIJ0O5+NL/qKf1UdcKDiMJOD9EFVVglqwXCfe6BZ193qiHAi0cms0wq3agZSm1qi6g/87NdWkcJgjVuDqrCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328999; c=relaxed/simple;
	bh=nCO1u3KxlnXicjQs2ZMDIznduE5lzcYRi4H+ojdvQM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSy+C1HO6F7dHwG4NlSM4O6kXRPPWm5paPd3/g5GHVyEPny+AIyoc8RIJYegqOe4URKnuX3nc/5biADGB3JvnZZLe+QSxWqs8v9qbrCUgpSg7laLW7rQZYcEINegXj+1aXVR6taTu+yL5TTTCH9iYODsINEcaH6YEIPh6yGr7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODI6pEIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3EBC4CEDD;
	Thu, 10 Apr 2025 23:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744328999;
	bh=nCO1u3KxlnXicjQs2ZMDIznduE5lzcYRi4H+ojdvQM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODI6pEIm1rJrGfkB6/3qgWFybzSN9rUi6au+XuctU5B5zEU/JsXSJWGHQ1XO47YGZ
	 3jbFxEGq9KYvt2kcpBQtiS2sQEfktgZTNLZePsuNRokIsj1n3B8IIx69KEGJB67mVA
	 gT//7YXjA0QqylSpyRy9SYlGozEmy2O1bY6oqyKHmp783dOO69ucOLmF/FZ4zZtr2j
	 uN8mZL8NCXK0Hi1/hBuZ75gBA/RfhBo8+Kfn3v+dWjh+7D7IxuoMEDuzBToOqUlXB/
	 GcU4tsd/bS5rjPK6qJtshsOY0M5HarbGWPyQOmXI2yagbtDy320AsHuYrLKbZuMKhY
	 s9GESfV+/JuQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE23380CEF4;
	Thu, 10 Apr 2025 23:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/10] bpf qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174432903676.3863413.8348102163001498736.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 23:50:36 +0000
References: <20250409214606.2000194-1-ameryhung@gmail.com>
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com,
 kuba@kernel.org, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 martin.lau@kernel.org, jiri@resnulli.us, stfomichev@gmail.com,
 toke@redhat.com, sinquersw@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  9 Apr 2025 14:45:56 -0700 you wrote:
> Hi all,
> 
> This patchset aims to support implementing qdisc using bpf struct_ops.
> This version takes a step back and only implements the minimum support
> for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> directly and 2) classful qdisc are deferred to future patchsets. In
> addition, we only allow attaching bpf qdisc to root or mq for now.
> This is to prevent accidentally breaking exisiting classful qdiscs
> that rely on data in a child qdisc. This limit may be lifted in the
> future after careful inspection.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/10] bpf: Prepare to reuse get_ctx_arg_idx
    https://git.kernel.org/bpf/bpf-next/c/a5c234d9bac6
  - [bpf-next,v7,02/10] bpf: net_sched: Support implementation of Qdisc_ops in bpf
    (no matching commit)
  - [bpf-next,v7,03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
    https://git.kernel.org/bpf/bpf-next/c/81bb1c2c3e8e
  - [bpf-next,v7,04/10] bpf: net_sched: Add a qdisc watchdog timer
    https://git.kernel.org/bpf/bpf-next/c/f2ccce960e92
  - [bpf-next,v7,05/10] bpf: net_sched: Support updating bstats
    https://git.kernel.org/bpf/bpf-next/c/9658e4249727
  - [bpf-next,v7,06/10] bpf: net_sched: Disable attaching bpf qdisc to non root
    https://git.kernel.org/bpf/bpf-next/c/0ddc97ad5337
  - [bpf-next,v7,07/10] libbpf: Support creating and destroying qdisc
    https://git.kernel.org/bpf/bpf-next/c/8c52471cd771
  - [bpf-next,v7,08/10] selftests/bpf: Add a basic fifo qdisc test
    https://git.kernel.org/bpf/bpf-next/c/cb7e598ef547
  - [bpf-next,v7,09/10] selftests/bpf: Add a bpf fq qdisc to selftest
    https://git.kernel.org/bpf/bpf-next/c/69dfd77a5adc
  - [bpf-next,v7,10/10] selftests/bpf: Test attaching bpf qdisc to mq and non root
    https://git.kernel.org/bpf/bpf-next/c/93cb5375fb16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



