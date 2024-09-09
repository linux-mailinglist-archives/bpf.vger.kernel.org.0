Return-Path: <bpf+bounces-39376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23706972597
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08A01F24840
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5B18DF64;
	Mon,  9 Sep 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABm2xHoT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0818CBF0
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923428; cv=none; b=MPa9M4qKyekXtnukXV0q8EkTBYvn60xSW1UsQbGE72kp9RGtvQNVXvuMsLEaj4/vDmfLw3CGXm5YIPkkoxAAbXzWhSJbs3kHz0qq34f7SeDUQ37kK8UWxt/EKtmjQWUamlMWZBCOvi9JdwE3IN8V7fEUkENvJR6vmEEAWncm+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923428; c=relaxed/simple;
	bh=pbx8EbEiVNMPEomtLEOvCNuR3jKXT+D+TW9zAn3BEHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pa07Dz2++yRxFAny2rWAQ8rG6/cV8Zh05LtZIRW2XpWWKyplSfCstJlG1LDkDw6MGdJAqd5wf6oYkvszVvwtEIsRePCptJybERndBmVN+bI7Nq2xUOdLaJHSArCRc/+bdQOPgupxAeuWBnag1QbOYajQjAux12TxO7+os99dk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABm2xHoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E86C4CEC5;
	Mon,  9 Sep 2024 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725923427;
	bh=pbx8EbEiVNMPEomtLEOvCNuR3jKXT+D+TW9zAn3BEHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ABm2xHoT+l4ByUKmmDSQtHjtjG6HeDTWhIcw7m+ShbxOfHMcL541KmEgJE2MoEdNI
	 yBoG9WbsZMAX5eXjd4Pz0AAPqRWzs5hBYEJbxV3pcXsHaGCPgtUKahorucVNgZBYXz
	 ytvPPDdcitFXaqj2eBh71421ONaLAP0iKQNtR2fzyfDmWo63TwECAHBeI90lGPPDfV
	 IqPsmrnG1BG6mhnzYPJBjFRPfb6ctm19QUTxfQnDMOZ+vAP140vyNZX66bxKp+FLhE
	 MXe+8X1ENf+uxY/QvAFePft1ioZOPzq/XPIYfOM2MUNr/ls+eMYCAXN13kq/iBmTn7
	 QxeEHaTXoCwXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE123806654;
	Mon,  9 Sep 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: fix some typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592342877.3950880.9473045380967973405.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 23:10:28 +0000
References: <20240909225952.30324-1-yunwei356@gmail.com>
In-Reply-To: <20240909225952.30324-1-yunwei356@gmail.com>
To: Yusheng Zheng <yunwei356@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Sep 2024 22:59:52 +0000 you wrote:
> Fix some spelling errors in the code comments of libbpf:
> 
> betwen -> between
> paremeters -> parameters
> knowning -> knowing
> definiton -> definition
> compatiblity -> compatibility
> overriden -> overridden
> occured -> occurred
> proccess -> process
> managment -> management
> nessary -> necessary
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: fix some typos in comments
    https://git.kernel.org/bpf/bpf-next/c/41d0c4677fee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



