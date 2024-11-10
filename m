Return-Path: <bpf+bounces-44449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF59C3023
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 01:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B02B1F21723
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D12139E;
	Sun, 10 Nov 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXlwbNTn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAA139B
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731197420; cv=none; b=HDJqdGNqFVKMrSJe33BDHqiLW/+ALN+q0JSzIzfXhTu40Nk/x/8MsL2tMTR6WaD+XX60nol4iEzSqsNZvdoFBsmL89UV9TrtbANgYVliLAgaeVFFKDCQ9bvonJRppcUVfWeB1WMkBmLK+lN4iWXPgmzC/7LlQj8+PaF8v5GCgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731197420; c=relaxed/simple;
	bh=ZqG5HlxcEWqdewz1xNXoMOcYhaPtzScxUZnrWd8Ix20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIOXX4C5gnWmyADV7/7pTgfZMVirb2Oj4nuX9R9aWt5RfETDWEOG46/mjjoXDCMACwI5wjP+gIWiq3g+qdVir6S98d7U/scDOcbGMTec9B7+9anWhVqQ0XroxedN8IR/d9P29B9qVUu3CLoryAWRYVyzDTzR95LxNK8HhFwZGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXlwbNTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C2DC4CECE;
	Sun, 10 Nov 2024 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731197419;
	bh=ZqG5HlxcEWqdewz1xNXoMOcYhaPtzScxUZnrWd8Ix20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rXlwbNTniPzzOOJk81w+MnbNB0BaYtorhKG21BkDGnN+kfKZ/tURZgCWkGjcAsZf1
	 Wf8aKAzr6L7oGBcDDY5EQhTS3FZVuiu37UIxTFq2g7tYgfp4KhEhSRfyeE5QMK7Ica
	 ZzuA8L1qy73cxPXRt4QGvJV7/FX7p16ZDbhP7sHIgP7oNy8rNP13HEfDtpHUQDL1ET
	 zhQA+vrY8HD6+IPOaPXxugF9gnT2ZFJVPPFvT4ncTyUdsX/sA6Sdg7r7FPNAuhAplj
	 IRso0AxBjzMZypn0HklLoMp0FTg6ejJhqbn7scdijSUnJhK4d577LnYtQrloASycb9
	 TBqPuNzFSFRcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B413809A80;
	Sun, 10 Nov 2024 00:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] Refactor lock management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173119742925.3041060.16347954384379369607.git-patchwork-notify@kernel.org>
Date: Sun, 10 Nov 2024 00:10:29 +0000
References: <20241109231430.2475236-1-memxor@gmail.com>
In-Reply-To: <20241109231430.2475236-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  9 Nov 2024 15:14:28 -0800 you wrote:
> This set refactors lock management in the verifier in preparation for
> spin locks that can be acquired multiple times. In addition to this,
> unnecessary code special case reference leak logic for callbacks is also
> dropped, that is no longer necessary. See patches for details.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: Refactor active lock management
    https://git.kernel.org/bpf/bpf-next/c/25eb5b03b669
  - [bpf-next,v6,2/2] bpf: Drop special callback reference handling
    https://git.kernel.org/bpf/bpf-next/c/9bb162b059aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



