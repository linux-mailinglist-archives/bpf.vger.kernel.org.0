Return-Path: <bpf+bounces-21127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C681847E56
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD911C2179A
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80D5680;
	Sat,  3 Feb 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ3mi0pI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940153A1
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926843; cv=none; b=rEXg2WIYLi+w1n17+7a4e/4lHW4IFcsv4zdfOyZ8DZVTvHu8zFva5MFKundfwvBD4a6hp8kHP8bvLPcYwipPkzzB+QRLlemgR35Ufb+xXE/F7JqqZ4V4QVUP+LauBGUJS59GYIa0L9JxocNRs5U8F4k42SblZxjQNMgTk2gvkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926843; c=relaxed/simple;
	bh=EQ1Hjt+2h6xDxt1cefzU0bk+uDLMviig+OuGAzXnwck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=APyHo4jxz52nbA8oTIjc+/9QKrAv7dRPrsAVFH377FCcCgflHP615Xs6+cTjCxTeUyhHKbgarKXXua0Qx/Y51j7bCkbyb6nesdU0vsxvcz5wCviZQ52lMo3LsQ+nr3zecSav73zICDRRcZGsCyTHTKelaxlqtEFN+e7Cm+/uRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ3mi0pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4C9C43390;
	Sat,  3 Feb 2024 02:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706926843;
	bh=EQ1Hjt+2h6xDxt1cefzU0bk+uDLMviig+OuGAzXnwck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XJ3mi0pIYRzoVjYBV3Y8KSZG4zMbN+6Z0jdudhlMPLqyHA0nctY2TkXmQVQVw5+OL
	 v3rEzjsDowuyf6OkKaecWSyjuRwal40z5BGXP4ek/fl/Uhu4yxpvwTsMSIDn2AhCB3
	 /n7EsuX1vvt/5pEO4oSIPHiAFOoGL5HiIRRGn8aiu+nNvl5UUlzlh22GXfzWeYK4sh
	 kLXeSTUEvs76+wy3VL1a8E1LG19yn0w6kztaOWItW17zaNiatFA5Ig4X0j/NYFLDN8
	 glIDjiLbGUnDx1a8I3/6KBCkkqw7kcmXJ17WormeppGfW6QH3CaHz5BX26MN0iOQ3t
	 NGtjHLGlPREiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C69AC04E27;
	Sat,  3 Feb 2024 02:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Two small fixes for global subprog tagging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170692684343.4408.15487697311103583387.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 02:20:43 +0000
References: <20240202190529.2374377-1-andrii@kernel.org>
In-Reply-To: <20240202190529.2374377-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Feb 2024 11:05:26 -0800 you wrote:
> Fix a bug with passing trusted PTR_TO_BTF_ID_OR_NULL register into global
> subprog that expects `__arg_trusted __arg_nullable` arguments, which was
> discovered when adopting production BPF application.
> 
> Also fix annoying warnings that are irrelevant for static subprogs, which are
> just an artifact of using btf_prepare_func_args() for both static and global
> subprogs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: handle trusted PTR_TO_BTF_ID_OR_NULL in argument check logic
    https://git.kernel.org/bpf/bpf-next/c/8f13c34087d3
  - [bpf-next,2/3] selftests/bpf: add more cases for __arg_trusted __arg_nullable args
    https://git.kernel.org/bpf/bpf-next/c/e2e70535dd76
  - [bpf-next,3/3] bpf: don't emit warnings intended for global subprogs for static subprogs
    https://git.kernel.org/bpf/bpf-next/c/1eb986746a67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



