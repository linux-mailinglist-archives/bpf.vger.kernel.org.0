Return-Path: <bpf+bounces-65757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4140B27D00
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 11:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100191D230AA
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8495625FA29;
	Fri, 15 Aug 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiOt6U7g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7424E4BD;
	Fri, 15 Aug 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249596; cv=none; b=oWv1CUB54254f1Ep9JNBanMeGLGpsB9uMwlJnG0wNxS6HkJnIXea/E4PusOhBJqav5sLzyOdZaWcLrSX0JfqeMmc2VXTQ4whBiVAzpJ8Li6NvTsGjTEvZTwsgTdakOl5/I9DcFjZ0JNwi2QnVRHNiTVSoOR76AZt7Jmoz9PSHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249596; c=relaxed/simple;
	bh=2ta+fShbR6bzPh1NFB8OUN9f4zy7nhQZC/H02M+f58I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rOrYvGHSuKgkYHnLXyEUrvmHvT7wZVDJhQuEz0XOMvdKJxdeKZN/U24ARVmY1jx4ndNgwLCqwaG752Q99FVl0AhEfttDebAE3Xc/PlwYm/SEC724rrcysC4mhnHIauhw5++T2T/iAaJ7PgkgdfcZEvK7cTgaPRLBlQE15gI6hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiOt6U7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3CFC4CEEB;
	Fri, 15 Aug 2025 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755249595;
	bh=2ta+fShbR6bzPh1NFB8OUN9f4zy7nhQZC/H02M+f58I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WiOt6U7g5IedFGSNPzdAGXs/NkBSjyw9PJ6zwXr2qt/x6b12JMAm189iXC9iy8uQv
	 LW3AbPvWjX2HszeOB3BGMJVkjWsXeIPneqtSDBFIsKU172LMNpRYM+hh9ocWg9DYY4
	 fDloXo0j4Yin1yN0PvX2bLGNdEevOhcoxzE142Vx9ZJG/k9hfLXanAmKE7n1QRzRUJ
	 jSgpFfrcp+U/RKa8656NWBLBnGE2twDJOtow3rH5n6oK/eCJggLjWtys+nPph/6iHF
	 iC6wpGpFWfSJ61/91LobZZedEbUaolRPUPr/Vxd6fDTIUj6Og5EzjpHLVZJgXfZ1d2
	 OAtCUign4oCWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F9D39D0C3B;
	Fri, 15 Aug 2025 09:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf] bpf: Check the helper function is valid in
 get_helper_proto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175524960701.1002181.5903388173238461777.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 09:20:07 +0000
References: <20250814200655.945632-1-jolsa@kernel.org>
In-Reply-To: <20250814200655.945632-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 oliver.sang@intel.com, paul.chaignon@gmail.com, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 14 Aug 2025 22:06:55 +0200 you wrote:
> From: Jiri Olsa <olsajiri@gmail.com>
> 
> kernel test robot reported verifier bug [1] where the helper func
> pointer could be NULL due to disabled config option.
> 
> As Alexei suggested we could check on that in get_helper_proto
> directly. Marking tail_call helper func with BPF_PTR_POISON,
> because it is unused by design.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf] bpf: Check the helper function is valid in get_helper_proto
    https://git.kernel.org/bpf/bpf/c/e4414b01c1cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



