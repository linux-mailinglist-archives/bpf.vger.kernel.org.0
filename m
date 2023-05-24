Return-Path: <bpf+bounces-1182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5770FE0E
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E53F1C20DA5
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B019E5D;
	Wed, 24 May 2023 18:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB3C13A
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 18:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11AEBC4339C;
	Wed, 24 May 2023 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684954221;
	bh=6jh50Lm6/BHrKXAkVOZ0YfolK+tquApZ+1N6pGkka4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kp3Dy+wJ08GG3HWGW9yRiGL0BgqOKsNKQQzfi9/hQ+f1coyZZX/f/b5j5UB9lxTfx
	 2XobWhJlFPly5tKQjrE8sH1NbCFqju+Sq7vWzp7GQPKMhOIylyVMi2DpkMY4+aLphd
	 pmEHE/aVSPphfIOpEMp839VHE9UvpZkj0tyLLXjH/5VhL5pdepxxDlfHU/e50tPK24
	 uK7MpZ7/XlIkXXZTU0XNdUJS2StbxnC3KKptTQT24Fnbo3X6yzpYWm5+bnzPfyYQQ6
	 Cm8SMMVP25gf+65a+Jh6ADtZmocB0rp4QkhhrpCiBC15Ll+LOd869Jg4YOQjcmPIN5
	 PvCfrbBWuw6AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBE3BE21ECE;
	Wed, 24 May 2023 18:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/2] libbpf: capability for resizing datasec maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168495422096.11839.5514267054305588279.git-patchwork-notify@kernel.org>
Date: Wed, 24 May 2023 18:50:20 +0000
References: <20230524004537.18614-1-inwardvessel@gmail.com>
In-Reply-To: <20230524004537.18614-1-inwardvessel@gmail.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 May 2023 17:45:35 -0700 you wrote:
> Due to the way the datasec maps like bss, data, rodata are memory
> mapped, they cannot be resized with bpf_map__set_value_size() like
> non-datasec maps can. This series offers a way to allow the resizing of
> datasec maps, by having the mapped regions resized as needed and also
> adjusting associated BTF info if possible.
> 
> The thought behind this is to allow for use cases where a given datasec
> needs to scale to for example the number of CPU's present. A bpf program
> can have a global array in a data section with an initial length and
> before loading the bpf program, the array length could be extended to
> match the CPU count. The selftests included in this series perform this
> scaling to an arbitrary value to demonstrate how it can work.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] libbpf: add capability for resizing datasec maps
    https://git.kernel.org/bpf/bpf-next/c/9d0a23313b1a
  - [v3,bpf-next,2/2] libbpf: selftests for resizing datasec maps
    https://git.kernel.org/bpf/bpf-next/c/08b089567573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



