Return-Path: <bpf+bounces-28970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6BB8BEF35
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBCE286171
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5E14B972;
	Tue,  7 May 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roGLbnAv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834514B944
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118629; cv=none; b=KvCukioTwoY2GT4L4jrPuqsiAcv6sySGUUOtWLKvgja13lvj6QETzedl8hMqRT+xCx2wV+kqdGjklJlBmZ95v3yZy2fe2BiE35H++5NU5ACdCXOUYWJkbDxmtp5pNQiLgLQyEAvgHlVyzK0roycuEvsGNWu6j8Fpll1wYA4Z4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118629; c=relaxed/simple;
	bh=AU2nKAz6GvTLd+czeNBRCI7aa/0MV37gBdt8jgOh+k0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3AR+TWCihddLHCS2c3KFH54J1GS4DgH7x/CmON4B7B5MTeyLp1tUYBCT54HK5i860kldd0sh13vhdveEfAnuWafQHisNl/AMxlrG7JqpmwsQ1AU9LtYAtXrmPeLgMdMYQZoUFXJljwOTq2Xzq5abrv8bfR9fT+iTqhUvVd5IWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roGLbnAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D5AC4AF63;
	Tue,  7 May 2024 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715118629;
	bh=AU2nKAz6GvTLd+czeNBRCI7aa/0MV37gBdt8jgOh+k0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=roGLbnAvc0qlWU6qXGV6zfN94iMMLnD3kd+a+2NDCz3d0ROEpf6Wg8wu4oyEcMmbC
	 ixQ2lXrJNWaRKGElNHw2ohqbDWskRq3A3OCYSJDf3HoNpNYfCIwuXG/fiZDsJ0swq6
	 3IsP05ADhK1pnSrzbQPCt3mC9ARErMkmcvdKnN1v2c0wn0InZaGgGh4OqdInogp78b
	 Pa1a7AX4Mr9KrshCQkfW7MFrP4DHhS8ZWzAuqmQARe3/MKgUxbkMivH7T/tPibvmJ7
	 pPtFe8ujPW7VrU11TjoMbQt25QG/YRPDSDGbzIa8OaNXqtz/9KRJa1RBZaGfqDhdvM
	 QS5sdatw30reg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21A73C43617;
	Tue,  7 May 2024 21:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Fix number of arguments in test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171511862913.23249.18015844007588719916.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 21:50:29 +0000
References: <20240507122220.207820-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240507122220.207820-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, eddyz87@gmail.com, yonghong.song@linux.dev,
 david.faust@oracle.com, jose.marchesi@oracle.com, elena.zannoni@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  7 May 2024 13:22:18 +0100 you wrote:
> Hi everyone,
> 
> This is a new version based on comments.
> 
> Regards,
> Cupertino
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Add CFLAGS per source file and runner
    https://git.kernel.org/bpf/bpf-next/c/207cf6e649ee
  - [bpf-next,v2,2/2] selftests/bpf: Change functions definitions to support GCC
    https://git.kernel.org/bpf/bpf-next/c/b2e086cb28aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



