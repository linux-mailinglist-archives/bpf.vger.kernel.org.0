Return-Path: <bpf+bounces-9320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95244793798
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 11:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4BE281297
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494551368;
	Wed,  6 Sep 2023 09:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F70ED0
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DB25C433C9;
	Wed,  6 Sep 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693990824;
	bh=5vAHwVUQQJrgBcymMHk+CybvQjeXh14elc96WpYmWMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cVsFFbGZfK2Txbzc5wZAeUA/DBkKSpFUzdWCTEdqNsbvIeUzZD1+6Y2otkyq0c5vq
	 IivzP3PtVsXf6EbxdHHEnPrxmKR0+nnRluYIrs6JblB8++PH6bowsLy76OOe9X5+NI
	 wmLOQdvnJ4/5KWC9pcs4H1p0HYxjATyjeTiA/+1pR18Wd9NNUMezj38DKksvyv9pFk
	 QiD79NfsFETIpogYW8RsxOIfFQp7pQKGipOCt22FNlu9dBQATzYZVp5DLZSv1o5f4I
	 Bh4WRNymIoMIWWli1L410/gj6OzpcI/3znaB2f2brmknEs9cjRUW2fHoTmYlM+k5j3
	 HGbiQEFtxX1tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23E68C04D3F;
	Wed,  6 Sep 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] s390/bpf: Pass through tail call counter in trampolines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169399082414.6662.10802557802739575767.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 09:00:24 +0000
References: <20230906004448.111674-1-iii@linux.ibm.com>
In-Reply-To: <20230906004448.111674-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, hffilwlqm@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  6 Sep 2023 02:44:19 +0200 you wrote:
> s390x eBPF programs use the following extension to the s390x calling
> convention: tail call counter is passed on stack at offset
> STK_OFF_TCCNT, which callees otherwise use as scratch space.
> 
> Currently trampoline does not respect this and clobbers tail call
> counter. This breaks enforcing tail call limits in eBPF programs, which
> have trampolines attached to them.
> 
> [...]

Here is the summary with links:
  - [bpf] s390/bpf: Pass through tail call counter in trampolines
    https://git.kernel.org/bpf/bpf/c/a192103a1146

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



