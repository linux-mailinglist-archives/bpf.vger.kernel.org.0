Return-Path: <bpf+bounces-9700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8379C267
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936DB28143A
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549D8F4B;
	Tue, 12 Sep 2023 02:10:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B617EA
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 02:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 308E1C433C9;
	Tue, 12 Sep 2023 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694484629;
	bh=ps//5GioqVbEzOds1QLz0ZmsMNe+cUTVvr8ztm1M0mE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dppPTBMPVOiCjgwub2vKAdtlPxUX60UJ7X6UAykeK5/yNlMKWNbbpNKg+a3cekR2v
	 27nBcY+CpjLycx68Jlc5LIKyd8Pa9GUcr4JbqfYvH6LmGRfPimICvvf/pONhJktK8y
	 EfdmqFQADuBH6hB4jq2PtyV5o77mmOGVdn4/LOASPEm+tPLEf119cYrbf1vpzAOrag
	 pkSRyzWVpOOGnzSHqvEoyqkp7+siOyfj+mvIrwdHD/fGdasNpUOWhWiw5ge8r+goVa
	 NL3luZhAz5U0zfICJMz5Z3xbOwX5nzz5EqF1x50XPFbAnPB/qKeGF5f+PEu+BCUSLN
	 WbkNnwpj73M7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14D3CE1C281;
	Tue, 12 Sep 2023 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Avoid deadlock when using queue and stack maps from
 NMI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169448462907.6410.11732142190873200040.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 02:10:29 +0000
References: <20230911132815.717240-1-toke@redhat.com>
In-Reply-To: <20230911132815.717240-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mauricio.vasquez@polito.it,
 hsinweih@uci.edu, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Sep 2023 15:28:14 +0200 you wrote:
> Sysbot discovered that the queue and stack maps can deadlock if they are
> being used from a BPF program that can be called from NMI context (such as
> one that is attached to a perf HW counter event). To fix this, add an
> in_nmi() check and use raw_spin_trylock() in NMI context, erroring out if
> grabbing the lock fails.
> 
> Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
> Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
> Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
> Co-developed-by: Hsin-Wei Hung <hsinweih@uci.edu>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Avoid deadlock when using queue and stack maps from NMI
    https://git.kernel.org/bpf/bpf/c/a34a9f1a19af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



