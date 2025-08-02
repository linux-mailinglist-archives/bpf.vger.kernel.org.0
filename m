Return-Path: <bpf+bounces-64947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00163B18A09
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 03:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FA61C8231E
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1A1C28E;
	Sat,  2 Aug 2025 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW5DiDTf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F2A48
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754097114; cv=none; b=ngLST4+Z1kjXP6NOUP8qWwxOhq6AR7xxalUQJG9OPQzs2DWdJy/yfE1kVx5tKWX/onpyxD6T+haWrCgk7ahMSohmoj3ynyrBNwoUkolhVQs9nQ+ChNv2j6bj6gcfhUksw1Jgk0Xv/8tV3VSRc+8bKsDTTQI0aSftGvp4Cvph0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754097114; c=relaxed/simple;
	bh=nbZwV8V015HI+MwDo5fGeuhFYXhFsIz/fMicn8cC9mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=En99kzU/gxoA3X53uwoJZbHNIvpxSse8Mn/Bmeq8xp8tag9+Jxaz5PeMMQI69kdOoxTP5StfP2iGkgyTwWk8gpCMSEjzgu+/KwQL+BJcmZghrpihXdncTVkxJbUf2H9LrL8ywgJ2uMrXQYtQhGSnaA52htQqn1mi0r6d38xEscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW5DiDTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8392C4CEE7;
	Sat,  2 Aug 2025 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754097113;
	bh=nbZwV8V015HI+MwDo5fGeuhFYXhFsIz/fMicn8cC9mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KW5DiDTfIuYhX6LFrG1Q/+jSEKU4wnVqsjlhlY9HGxSR+eJpMfWQ3Ud0EckXO6yQT
	 VLN5r06H334ha0XwAL4xEMmpLvEkspZdXJEiXP8W0C7bBU0Y9jC1yhSni1kOZsZ4RP
	 vHExE/p1iUi3vQuV0tUVx6ZHkbI/QvoxFG0eOwpZ3fVyCE1bNTMHod+4pkhu51WUKs
	 xeEEbkKM6PQONsb9kFNV46fP2yJ/cI68fD5GeNqK7Eqrb+2JFbkxk7OSFxsGkDg3KG
	 UlvFrpvlMTPIJ8JxuvY9PuB1E8EDt3jgAIB2BmXeXzuc8/sr6GIPe5RkEceJslRoNU
	 ZANWo8rOaUPkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6B383BF56;
	Sat,  2 Aug 2025 01:12:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] bpf: correctly free bpf_scc_info objects
 referenced in
 env->scc_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409712901.4179816.3882176401699513348.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 01:12:09 +0000
References: <20250801232330.1800436-1-eddyz87@gmail.com>
In-Reply-To: <20250801232330.1800436-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, axboe@kernel.dk, alexei.starovoitov@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  1 Aug 2025 16:23:30 -0700 you wrote:
> env->scc_info array contains references to bpf_scc_info objects
> allocated lazily in verifier.c:scc_visit_alloc().
> env->scc_cnt was supposed to track env->scc_info array size
> in order to free referenced objects in verifier.c:free_states().
> Initialization of env->scc_cnt was omitted in
> verifier.c:compute_scc(), which is fixed by this commit.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] bpf: correctly free bpf_scc_info objects referenced in env->scc_info
    https://git.kernel.org/bpf/bpf/c/989705e34ad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



