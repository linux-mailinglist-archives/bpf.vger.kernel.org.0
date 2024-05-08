Return-Path: <bpf+bounces-29102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E78C026F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4401F1F24C1B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A63DF6C;
	Wed,  8 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZEb1wSr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A61A2C2D
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187631; cv=none; b=pdxzICac2w+PpiZh6V3t1rGyFKO4T+CdU9egIQpfyMdhTO2vY8QD1o3e2t0wmuVcXE4HmKhjOzsalWkGIRtf9+yLEoeV8a8YfyNkhG3BysiDsIU9NAa83bKF5lNMGt0XfbGaMvQtF43RmW2EtCoRJsvgxKuv9H401AL9p9hdj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187631; c=relaxed/simple;
	bh=TNAXsxPgGcQZnzJ0ROnaKUUPk2KEyypL9lRAASUSLeI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=El3awaOKYxOz9Z1V9YKMonCQ4zo3q7HL3NvzAfmzAd2O+jDDVZMDA6T1wKFhmmMnoC1v8AVHwnfOzJ7FbyKmhUu0l2rs6uo9rUIKZNtmSV0NLdiN/Oq16AkPcVvw7GzUH8V2QENAZ68s30anDaywWXcW7WPSMIDqNUxZVkXvoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZEb1wSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E25CBC32781;
	Wed,  8 May 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715187630;
	bh=TNAXsxPgGcQZnzJ0ROnaKUUPk2KEyypL9lRAASUSLeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZEb1wSr/akULHZW9xBWX9EyEyovbAP16YhSCyGVBEBNjI+6aSBblm03dYzdGH8dO
	 CISsTMz5gHJWUGS1o9kyIZJSqqVpm9ogJMjMSroAj/b8LNEUNW4yFev5vZLFkwYRh1
	 1ImBi7+H9o9bv1T1WGk03IiaymJNnNmfMYsl+r+Obq/wvD9FWqTFjNcEaACGEdsKW3
	 Xcv6e+RNyvmFRuSEQmyO8Z7hFYGIBdDRJJSNPj6HFJmVzSQ7KC7z+dvqRM01VAJtZT
	 qF6TvtL9RtsRri4GmTfCziuaX2tx3nNwL9mT416sPvbbFcG/w5kvrc1RSXIUf8xWpp
	 +CCqaMZkIB5cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6FA4C43614;
	Wed,  8 May 2024 17:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: guard BPF_NO_PRESERVE_ACCESS_INDEX in
 skb_pkt_end.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171518763081.20768.9843819969177772597.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 17:00:30 +0000
References: <20240508110332.17332-1-jose.marchesi@oracle.com>
In-Reply-To: <20240508110332.17332-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 eddyz87@gmail.com, yonghong.song@linux.dev, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 May 2024 13:03:32 +0200 you wrote:
> This little patch is a follow-up to:
> https://lore.kernel.org/bpf/20240507095011.15867-1-jose.marchesi@oracle.com/T/#u
> 
> The temporary workaround of passing -DBPF_NO_PRESERVE_ACCESS_INDEX
> when building with GCC triggers a redefinition preprocessor error when
> building progs/skb_pkt_end.c.  This patch adds a guard to avoid
> redefinition.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: guard BPF_NO_PRESERVE_ACCESS_INDEX in skb_pkt_end.c
    https://git.kernel.org/bpf/bpf-next/c/911edc69c832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



