Return-Path: <bpf+bounces-28747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE58BD877
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BA2283261
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAF622;
	Tue,  7 May 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP2Ex53X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B8182
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715041229; cv=none; b=qSSGCSYjXLcbDyR6atGPVmFBWXKjxxQmo/38w8rJn/WPQ3u53mI8nHlpMenulfny7GmVt3pS9HkP1P+sIUaWoRYJ44toxAbTajlCpFbejBx709dAPr5i56YzjnY6WTZpMFc82g2lbbKus9gBC3cVCKoQCky0XLCQalmlzz4AxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715041229; c=relaxed/simple;
	bh=75JgjLqmgZqrOcOXYkD6wJ8CUYB5YbjzoZTHi3LBV58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e7aAcvsYO4Br5eU/Rdugt/SMzRyczzMyGRy3I+El6Xrv8DmPgDN5M3to4iviIhOrzBV3QuApUFJ1JstXWWlvWdu+xtONeTRp/5/17Zc48H4KcrkaVsDDSS7vx8aVdiSaHzYuTwnmLxnvR4I9AElAL2C5BO5y4HauqcJd3wWHBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP2Ex53X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0BE4C116B1;
	Tue,  7 May 2024 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715041228;
	bh=75JgjLqmgZqrOcOXYkD6wJ8CUYB5YbjzoZTHi3LBV58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HP2Ex53X/FJxoHqWJwlh1XYS7mNgINMHWsxoxSVsUbs1Z0JVNQWC8F3MTTxNlOHo9
	 yZ2pnq32zYoD5+JAx9lNsxxDe+a3+4n2eyLzQvZMEAhCOA3SzGwrZF8Eo5vDR7J199
	 XoOEoLXArJ0oTGa2PIcLxwtc4LrryL8qIFG6NxvnNujEK8W+9TAQcNNWpw+p/K8Iux
	 aTt0rDPcWZzuzzBXTaJbORQ1+zEzdC1AkHRfEsjbXcIQ6DVefYtMK7oetTHn29tRlF
	 J1NLIzBMDwM20n/slz472pTG39qzPIqeNZP9/H5bkUULhzknhDnMpJzEw0uZAYArbo
	 uHTo0zDrO7oqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB9CC43337;
	Tue,  7 May 2024 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/6] bpf/verifier: range computation improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171504122871.27463.1368138144281847004.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 00:20:28 +0000
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev,
 alexei.starovoitov@gmail.com, david.faust@oracle.com,
 jose.marchesi@oracle.com, elena.zannoni@oracle.com, eddyz87@gmail.com,
 andrii.nakryiko@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  6 May 2024 15:18:43 +0100 you wrote:
> Hi everyone,
> 
> This is what I hope to be the last version. :)
> 
> Regards,
> Cupertino
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/6] bpf/verifier: replace calls to mark_reg_unknown.
    https://git.kernel.org/bpf/bpf-next/c/d786957ebd3f
  - [bpf-next,v5,2/6] bpf/verifier: refactor checks for range computation
    https://git.kernel.org/bpf/bpf-next/c/0922c78f592c
  - [bpf-next,v5,3/6] bpf/verifier: improve XOR and OR range computation
    https://git.kernel.org/bpf/bpf-next/c/138cc42c05d1
  - [bpf-next,v5,4/6] selftests/bpf: XOR and OR range computation tests.
    https://git.kernel.org/bpf/bpf-next/c/5ec9a7d13f49
  - [bpf-next,v5,5/6] bpf/verifier: relax MUL range computation check
    https://git.kernel.org/bpf/bpf-next/c/41d047a87106
  - [bpf-next,v5,6/6] selftests/bpf: MUL range computation tests.
    https://git.kernel.org/bpf/bpf-next/c/92956786b4e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



