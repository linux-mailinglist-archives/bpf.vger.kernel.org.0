Return-Path: <bpf+bounces-13916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB58A7DECB9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AEF281B29
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF963B6;
	Thu,  2 Nov 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6XE/ZHB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DC5680
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 902FEC116AE;
	Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904825;
	bh=TT6oGmKBvrWb94S/vP7d37OfMVFkbdfOksx84tXkYIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6XE/ZHBMLjtASbMMN8/6ByBnKKdvtKquvR6CelIrF5eOPLQ8DMZAOljjerNhqK//
	 SutgZS76sJlX+YETNSZXTJTqy8c3q2u3lb17gARz9MFjCsGwwqwmH/Rg+hVnE3k2uf
	 BIyhuXDqs/yAfTMz46fKjaTrmdAg1ORe1IJmNNKRfzYjKqUtK3nTLAmQcgUj4K8vyr
	 9i9B2Px7LEdG4kVIAu2smrPUR+glDlm5BjBdpgL/5sJj4EWiIhriRTMpFSjTkmnxMc
	 gTvY/j+3BPwSaeLlhATqdyOBH8/X+GKt0yjy2UfkBw8fXDy5Pj18C3ruQYFsshW5/x
	 poDJL7QpB4Nfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A7F3C43168;
	Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890482549.9002.3230353368904918414.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:00:25 +0000
References: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, sinquersw@gmail.com,
 ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net, haoluo@google.com,
 iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuifeng@meta.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mykolal@fb.com, sdf@google.com,
 shuah@kernel.org, song@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 28 Oct 2023 10:54:13 +0530 you wrote:
> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> This patch replaces all CHECK calls in bpf_iter with the appropriate
> ASSERT_* macros.
> 
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
    https://git.kernel.org/bpf/bpf-next/c/ed47cb27586d
  - [bpf-next,v3,2/2] selftests/bpf: Add malloc failure checks in bpf_iter
    https://git.kernel.org/bpf/bpf-next/c/cb3c6a58be50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



