Return-Path: <bpf+bounces-9415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B639B7975E2
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F2A28172F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329812B9F;
	Thu,  7 Sep 2023 16:00:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF812B89
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FDB3C4339A;
	Thu,  7 Sep 2023 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694102427;
	bh=UGVPXXBkoVLlGyZfgs7q0AQXdg/ebIiZa/VdQ1aMV1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c6hfB2J52z9uxmpxodJ9G9+lJDb1Wdg3Eq/xJ+wSYCcgQXxnjZzZ+n5W4BoH8aOCG
	 ofhIFLSMUxPKFwUFI4Srp6yTH1DUWUNur34AnBCu9TX11XMYFEc1GxlmSpRfVFxAuM
	 Tpb29gb5MriPYc9CF2cBaW25bzSMSRucXEaMdctztJhdP6yGL/6QL/e0gGIEzLb10A
	 imzuiayvBtuzxeke2AmvJTsQlDBlEVtThc5aID82IjXt7fsBOeQvy+hW9zWPpOPLQi
	 7cclbE09Y6vBHtj3DY2mmPE0DPcE94uM1j2+14W47WQ+NI9buG01aogODnHprMro0y
	 IU4Bm1alEXtNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C6EC4166F;
	Thu,  7 Sep 2023 16:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] bpf: task_group_seq_get_next: misc cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169410242706.4782.13464394705010129474.git-patchwork-notify@kernel.org>
Date: Thu, 07 Sep 2023 16:00:27 +0000
References: <20230905154612.GA24872@redhat.com>
In-Reply-To: <20230905154612.GA24872@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: yonghong.song@linux.dev, ebiederm@xmission.com, sinquersw@gmail.com,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 5 Sep 2023 17:46:12 +0200 you wrote:
> Yonghong,
> 
> I am resending 1-5 of 6 as you suggested with your acks included.
> 
> The next (final) patch will change this code to use __next_thread when
> 
> 	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] bpf: task_group_seq_get_next: cleanup the usage of next_thread()
    https://git.kernel.org/bpf/bpf-next/c/f9aedd66c46b
  - [bpf-next,v2,2/5] bpf: task_group_seq_get_next: cleanup the usage of get/put_task_struct
    https://git.kernel.org/bpf/bpf-next/c/ad98e2e5f84f
  - [bpf-next,v2,3/5] bpf: task_group_seq_get_next: fix the skip_if_dup_files check
    https://git.kernel.org/bpf/bpf-next/c/c12e785e8648
  - [bpf-next,v2,4/5] bpf: task_group_seq_get_next: kill next_task
    https://git.kernel.org/bpf/bpf-next/c/c40a3b44f7c5
  - [bpf-next,v2,5/5] bpf: task_group_seq_get_next: simplify the "next tid" logic
    https://git.kernel.org/bpf/bpf-next/c/1e48f069c90f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



