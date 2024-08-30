Return-Path: <bpf+bounces-38601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B8966ACD
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51121C21F35
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF71BF809;
	Fri, 30 Aug 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDJ/rOt0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF2156F33
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050432; cv=none; b=NSpaxk3QSbpgi/gxhUssn5zl7YjVDEhlHa/gWsnBppBXOHvtlEOYynSo8cw5o/spRzFkpAjE0uBW7diDta2XTpJ4dmuclwNdSZz+lpKj+GzQj/BU02tc9PIzpD7+rFUaGMgxpwsD+3OG3xK5SDedw5GLM6UHvJVuw27aR7/yeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050432; c=relaxed/simple;
	bh=pmfD/z4SXcDrHpCREFWDLn7lmEXhbT4UfXtVQ5cpJBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sC3dv8pZ2udJmGj9kx23kMib+/7JH3arVogCHNkS6ccXR/C76ib1Pxw2BwX9gucMThZS0clSnJ5GAmuGUiM/u7j5MdZbQYHlo/0wyEcU2Dh7Ga64kKDCcWx+ziHSbUGXAFDlzMKercBtdONjkwgqNMsfspGN/Zc79dvMg8+zeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDJ/rOt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41063C4CEC2;
	Fri, 30 Aug 2024 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725050431;
	bh=pmfD/z4SXcDrHpCREFWDLn7lmEXhbT4UfXtVQ5cpJBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MDJ/rOt0snG3CNhYmiKyw0Mwyv3T4jQZeuRkXk/u7PX8PEPba7qftiVPVKVhG1+HR
	 JCa8YatVPuHiln/PBXq+fg9AOS3pj+0nBokh8HLLKCMIiX4RECOMpxgKZcJOWenvkK
	 B6NF2j+fAu6R5f6vukt6Kn3/TJeuEcwwy4J9lsVtGayg3RlwxFgBDhMDdTNFCe5jR9
	 efzp0JKAP8ojRAObz6Vwn7EwXp4fFoB1omvQvxIu+P4PRW3HkXDxDYM7Sc92xmqeLt
	 4FUJcnpQaeUgAQAFZm5WPIy97GbcBpe3a2SefScEYZGkeZd61LDAMyEYKTDbryTcky
	 v5OKMmS/iuB2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1E43809A80;
	Fri, 30 Aug 2024 20:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: specify libbpf headers required
 for %.bpf.o progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172505043178.2709774.14367906871497830195.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:40:31 +0000
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
In-Reply-To: <20240828174608.377204-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Aug 2024 17:46:14 +0000 you wrote:
> Test %.bpf.o objects actually depend only on some libbpf headers.
> Define a list of required headers and use it as TRUNNER_BPF_OBJS
> dependency.
> 
> bpf_*.h list was determined by:
> 
>     $ grep -rh 'include <bpf/bpf_' progs | sort -u
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: specify libbpf headers required for %.bpf.o progs
    https://git.kernel.org/bpf/bpf-next/c/38960ac8f916
  - [bpf-next,2/2] selftests/bpf: do not update vmlinux.h unnecessarily
    https://git.kernel.org/bpf/bpf-next/c/2ad6d23f465a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



