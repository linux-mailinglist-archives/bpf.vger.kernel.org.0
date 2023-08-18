Return-Path: <bpf+bounces-8101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7278135B
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 21:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FD82824B5
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ECA1BB31;
	Fri, 18 Aug 2023 19:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872B6112
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 19:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C39FCC433C8;
	Fri, 18 Aug 2023 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692387021;
	bh=30oYDtp4Jp4ozBpDO5T+nCDtpvHJBvyuH41aaYUSPhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ExPMtm/bg6L5V959kmugBLbaU1XDgfvskA/2/iDqTXwfb0KMVVNn9NA6VPYKUfLxS
	 jUG9mW5OBRmfcvsenYWNpkI4LlKohnbW6v68f1fmOio0da/+eV8v/Fx+0Xc7dcNP+6
	 me7jAFIap2QXcTk55iN3/EKY/3wxkVQ374Rnqwu9Pgd4vbfx6TNkGM5LgM0Gaow0zc
	 VZT32El2/lE1IU1fM4Ki55HmjsZQQNGzZ2XBvDkg4A+HSYoLrdCdL0QfjhEf3GnqIQ
	 nJ4TGqyP14gGW8eo+M45nj5bEdubQCjp3BknJ1QxAIb3pKrQvrAy+EsWOwt/hNnUag
	 eLpRnUvrdORMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9D8FE93B34;
	Fri, 18 Aug 2023 19:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix a selftest compilation error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169238702169.637.8272710318611270022.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 19:30:21 +0000
References: <20230818174312.1883381-1-yonghong.song@linux.dev>
In-Reply-To: <20230818174312.1883381-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 18 Aug 2023 10:43:12 -0700 you wrote:
> When building the kernel and selftest with clang compiler (llvm17 or llvm18),
> I hit the following compilation failure:
>   In file included from progs/test_lwt_redirect.c:3:
>   In file included from /usr/include/linux/ip.h:21:
>   In file included from /usr/include/asm/byteorder.h:5:
>   In file included from /usr/include/linux/byteorder/little_endian.h:13:
>   /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
>     136 | static __always_inline unsigned long __swab(const unsigned long y)
>         |        ^
>   /usr/include/linux/swab.h:171:8: error: unknown type name '__always_inline'
>     171 | static __always_inline __u16 __swab16p(const __u16 *p)
>   ...
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix a selftest compilation error
    https://git.kernel.org/bpf/bpf-next/c/0a55264cf966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



