Return-Path: <bpf+bounces-6911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4D76F6C4
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722B51C21664
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC410EB;
	Fri,  4 Aug 2023 01:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9057E5;
	Fri,  4 Aug 2023 01:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE8D3C433C7;
	Fri,  4 Aug 2023 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691111421;
	bh=4rWS7fKouJlmX9vgplTxwMHi8wgS2ZAlyi0J8AgXOB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aTqWw1UKH26rn0R5KknzqCdp6ljrDjmONEepDMHuRwH/XSYu8KJQiWz3bjlu3HT40
	 U1NnmyNe6+otb9Qw9aewjEIld9DzzPGhW+5f8+bWoLkQnPCmywBLTu44M0X0in+l4p
	 irRlHK+FzbbloB4pDz2fhCkM7n7yN4q9RZQeWKhVmxcvJ3wTtxXws7mhl+niKr98kj
	 NoVl7T9Rfwg+VfQiJrgsrAA1ZEAgP+BQ3J0OZrBPg7kekRD5uYr58kWOi8qoFSEBYG
	 SEeSXCuFYkE0m/jqftgSYQz5UNjOG+FzzPS2pDztpTFvzWXzfCuTC5FgpAmTIe/xZp
	 fPi+93pbBtE6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C8F7C595C1;
	Fri,  4 Aug 2023 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: bpf_struct_ops: Remove unnecessary initial
 values of variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169111142156.15722.3750188534512850509.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 01:10:21 +0000
References: <20230804175929.2867-1-kunyu@nfschina.com>
In-Reply-To: <20230804175929.2867-1-kunyu@nfschina.com>
To: Li kunyu <kunyu@nfschina.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  5 Aug 2023 01:59:29 +0800 you wrote:
> err and tlinks is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  v2:
>    Remove tlinks initialization assignment.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: bpf_struct_ops: Remove unnecessary initial values of variables
    https://git.kernel.org/bpf/bpf-next/c/5964d1e4594e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



