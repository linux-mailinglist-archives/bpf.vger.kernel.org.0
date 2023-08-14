Return-Path: <bpf+bounces-7732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84877BDA5
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A0C28112A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427EC8D1;
	Mon, 14 Aug 2023 16:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09CC139
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 16:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F32C433CA;
	Mon, 14 Aug 2023 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692029421;
	bh=zni9T56LYbVj+/ygAvFBZMYd9kZJ1T1YQExPsHa2WYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Scj5OUKR46J1CUhrSuAV1J7IT7h7O2E0iLHIE6RQEiy75PabbhzMni/kxGbsoQiar
	 ydF+uDTNoOTVwKOYtxa1J0k2mXYQR9SLpDmSpbzrs6Akh3POnQ0ccudnOMLQykPnDm
	 MZGmIIcplnmDlf1E4zCP7Wox5CNmX3nf/BdkehmMLDy0nM8kPOK8MR4dw6jhh12bK/
	 LgBWYtg7tVRkNdBg0rPuo8L5JvdSEyXRrN5sD+LMuIxgJ84pJQq2o81VfMKBQfJatl
	 BYuTOw60ldCU8EY1vZ0dNGtiu0TS6Pc4KqCG2LTxCEIrYA2WK2SSWap36CnVMjno0+
	 G+bKmuY42zWGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94AEDC395C5;
	Mon, 14 Aug 2023 16:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] selftests/bpf: fix repeat option when kfunc_call verify
 fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169202942160.12578.16793476914030238239.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 16:10:21 +0000
References: <20230814031434.3077944-1-zouyipeng@huawei.com>
In-Reply-To: <20230814031434.3077944-1-zouyipeng@huawei.com>
To: Yipeng Zou <zouyipeng@huawei.com>
Cc: andrii@kernel.org, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 benjamin.tissoires@redhat.com, void@manifault.com, memxor@gmail.com,
 iii@linux.ibm.com, colin.i.king@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Aug 2023 11:14:34 +0800 you wrote:
> There is no way to set topts.repeat=1 when tc_test going to verify fail.
> 
> Maybe it's clerical error, fix it directly.
> 
> Fixes: fb66223a244f ("selftests/bpf: add test for accessing ctx from syscall program type")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> Reviewed-by: Li Zetao <lizetao1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix repeat option when kfunc_call verify fail
    https://git.kernel.org/bpf/bpf-next/c/811915db674f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



