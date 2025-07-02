Return-Path: <bpf+bounces-62139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C792AAF5D98
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5394216A904
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A52D7816;
	Wed,  2 Jul 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8ZHkG4A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7D3196D2
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471383; cv=none; b=IjeL6SdZKaOP70e0Z1W4MtgvYqv3tCteo+QhG7APoBZCJEwmZsvex7I7nRB1Rd+oPLiE3FX9d05al6mvXj3jpm8iBh/jZc/asayQod2pzoYyUzfOEztYazE6L0gPDm8Fl3VQitgsarIYg/fwXvlpXZNz5cI+aCa55ifYcZRYydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471383; c=relaxed/simple;
	bh=1GeAKTZJFCWI2FzjA7WemPCvzagWAqGYRXtdzLUzzmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dCtA9ITcwXJM9jdOQbBCUzoqq2lvbpQE0HIX9ZFT/s/qoAicXz2zBiRcBIKExxLGxkAhXctv6tQrnCbTcRLDzYISqR6VgOoa/ZCAW8lvIZk4VkasSlVEdwSRtj+8q5Ucq4f4e55R3UTLb9TicXL4ZL03YVCDVrjv72kglQBf4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8ZHkG4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6058DC4CEEF;
	Wed,  2 Jul 2025 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751471383;
	bh=1GeAKTZJFCWI2FzjA7WemPCvzagWAqGYRXtdzLUzzmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C8ZHkG4AKiLMzfdJVeffeCPAlsbXltTx567nu/6h1wWII/F8p4SjxxPYrSuAANOJ7
	 gwtrOUe3QiVRWwoG+icrpYKslne9+wiTrJrIc5XvhDnwnAkXF9ljdlz9aLVRcWEPR3
	 GLl18apIoQrHNXggm+UGiYeBSTA9nu8ROXugF7kTl1P9a4gL3dgxbVNOFS1ncDYMP8
	 Asddif7syaN4GhVcdCc9EOD4B10MwfnvBYivslHn6t4uBfT12ytowThJO9ybd/6ebI
	 3kL9Q6OnVhRnDd9gD6t5Jk4SV42JQ9bKF1E6x+eIVMRqMXJMCUYudpo5FMSYI2HzQw
	 fC9g93IDZuSxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34004383B273;
	Wed,  2 Jul 2025 15:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Negative test case for
 ref_obj_id in args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175147140777.772127.1115343254755259836.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 15:50:07 +0000
References: 
 <3ba78e6cda47ccafd6ea70dadbc718d020154664.1751463262.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <3ba78e6cda47ccafd6ea70dadbc718d020154664.1751463262.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 2 Jul 2025 15:53:23 +0200 you wrote:
> This patch adds a test case, as shown below, for the verifier error
> "more than one arg with ref_obj_id".
> 
>     0: (b7) r2 = 20
>     1: (b7) r3 = 0
>     2: (18) r1 = 0xffff92cee3cbc600
>     4: (85) call bpf_ringbuf_reserve#131
>     5: (55) if r0 == 0x0 goto pc+3
>     6: (bf) r1 = r0
>     7: (bf) r2 = r0
>     8: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
>     9: (95) exit
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Negative test case for ref_obj_id in args
    https://git.kernel.org/bpf/bpf-next/c/1f2dfde4f36f
  - [bpf-next,2/2] bpf: Avoid warning on multiple referenced args in call
    https://git.kernel.org/bpf/bpf-next/c/564606fec540

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



