Return-Path: <bpf+bounces-67029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09DB3C269
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FB81CC298B
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678F343207;
	Fri, 29 Aug 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTSEeAxk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F33431ED
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492202; cv=none; b=g3Heyo37yXdZNQyz6o9Ab9v4vCwfIRXAHuEfhSiy0fXl1nt96pd9n3b2ogawMUzW0DJNfv6pNRFSv82S22+d+Ra2opvvcIM3E0dWF1fowKhSrFrsiMfdGPVUCoBhqvy+lGvCoRIoBqGXjA9Dj/XL3PNHilbiMCyUZtRCK/xBN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492202; c=relaxed/simple;
	bh=gmVCuuSIESlPLiHNKFgFSzryEaMyb/Pp2+OTvbpBhMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYN/XCPoRMwWpPEFrx5R0SEcLJ9MJ+oAjUes8xD+Rvk7y85hxy45cArmlTj/RbIBBpfeCsMcUADfXjn2o6Ood1I6wXH5V4cRp3TtnG/3kW9AzaZlm+7SxI+F+tkAZBxcfkFOWKgEEu4ETSpBqDJyIja8rrao17Tzz1mjrS9pNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTSEeAxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2652C4CEF0;
	Fri, 29 Aug 2025 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756492201;
	bh=gmVCuuSIESlPLiHNKFgFSzryEaMyb/Pp2+OTvbpBhMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dTSEeAxk6gxuap3UUhJn4Id/wiagqb6lDIVQEY//tpzRTfmQu0piKIWV/v8kXKD8I
	 sWechXDaP3/Q8OsfrsZIE1ok0uCWCZ/juTgIMmmXWlWMkYDCqzHgYRxZmI6/x2Hb7b
	 nKxBZ6HGqzOYXl1ZCYoSGkG/8jdRWs29R9rOj3Ak6ZwEKjO2At4pvvebGCgGWJkYG/
	 15ljPAxoZNuQUkJN2TTddIXKLPWV+2feiJghR/E8oZiHFpgdluDqYi3bs28Ciol6yT
	 5T2iGLQf0sgcynzjW3NYJ0SKuHa8jdV4ufVw8mxTG5ArgIIKvBwjv/6uwFfi2wP7GX
	 Iz1RlcH+By+8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF5383BF75;
	Fri, 29 Aug 2025 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/1] selftests/bpf: Fix "expression result
 unused"
 warnings with icecc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175649220851.2305100.17643805383991239346.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 18:30:08 +0000
References: <20250829030017.102615-1-iii@linux.ibm.com>
In-Reply-To: <20250829030017.102615-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 Aug 2025 04:53:56 +0200 you wrote:
> v3: https://lore.kernel.org/bpf/20250827194929.416969-1-iii@linux.ibm.com/
> v3 -> v4: Go back to the original solution (Yonghong, Alexei).
> 
> v2: https://lore.kernel.org/bpf/20250827130519.411700-1-iii@linux.ibm.com/
> v2 -> v3: Do not touch libbpf, explain how having two function
>           declarations works (Andrii).
>           Fix bpf-gcc build (CI).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/1] selftests/bpf: Fix "expression result unused" warnings with icecc
    https://git.kernel.org/bpf/bpf/c/90336fe5fb6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



