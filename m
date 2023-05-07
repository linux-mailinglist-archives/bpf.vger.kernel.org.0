Return-Path: <bpf+bounces-184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C80E6F9522
	for <lists+bpf@lfdr.de>; Sun,  7 May 2023 02:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7FA1C21BCC
	for <lists+bpf@lfdr.de>; Sun,  7 May 2023 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076010967;
	Sun,  7 May 2023 00:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D456210C
	for <bpf@vger.kernel.org>; Sun,  7 May 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7433C4339B;
	Sun,  7 May 2023 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683417620;
	bh=EYWEM6o7wbF3/QheBJOmYtWD/MteDRvbuh7QTpPK59E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=URdPYTB2z1OAwWZ/wrLCR4k0ip7/HDClRnEeNJiqhWoGJUHpWHjxop6pg6ufzO4Yb
	 FXp+987Z86hSUF61Qp57yM33F7I76sXbIEMXc2m1tpRY6qOzQA4xafNx3jCBPESNp7
	 dAwMhnDoKjakok6GjJLFTdC/RIIcu+6wmi4xhkcgVcsGux1lMVonOSWzHqdwSaM4T0
	 sO9cVCpHvrwkSsvJC5f8MewaH5yObiP1OnIUyYJc3Dy7NQ79vvLUARhWoGXqfh+wFQ
	 ESlZB2+P9oNE3tqLoPz1NSlJXvJyOfzECBl/0TzXh1VoyHJFMzmQp2KMFgfh1PlyUq
	 Am3H7/IJ8rnTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4ACBC395FD;
	Sun,  7 May 2023 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] Dynptr Verifier Adjustments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168341762073.15595.436910654395923794.git-patchwork-notify@kernel.org>
Date: Sun, 07 May 2023 00:00:20 +0000
References: <20230506013134.2492210-1-drosen@google.com>
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
To: Daniel Rosenberg <drosen@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, corbet@lwn.net,
 joannelkoong@gmail.com, mykolal@fb.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 May 2023 18:31:29 -0700 you wrote:
> These patches relax a few verifier requirements around dynptrs.
> Patches 1-3 are unchanged from v2, apart from rebasing
> Patch 4 is the same as in v1, see
> https://lore.kernel.org/bpf/CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com/
> Patch 5 adds a test for the change in Patch 4
> 
> Daniel Rosenberg (5):
>   bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
>   selftests/bpf: Test allowing NULL buffer in dynptr slice
>   selftests/bpf: Check overflow in optional buffer
>   bpf: verifier: Accept dynptr mem as mem in helpers
>   selftests/bpf: Accept mem from dynptr in helper funcs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
    https://git.kernel.org/bpf/bpf-next/c/3bda08b63670
  - [bpf-next,v3,2/5] selftests/bpf: Test allowing NULL buffer in dynptr slice
    https://git.kernel.org/bpf/bpf-next/c/1ce33b6c846f
  - [bpf-next,v3,3/5] selftests/bpf: Check overflow in optional buffer
    https://git.kernel.org/bpf/bpf-next/c/3881fdfed21f
  - [bpf-next,v3,4/5] bpf: verifier: Accept dynptr mem as mem in helpers
    https://git.kernel.org/bpf/bpf-next/c/2012c867c800
  - [bpf-next,v3,5/5] selftests/bpf: Accept mem from dynptr in helper funcs
    https://git.kernel.org/bpf/bpf-next/c/798e48fc28fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



