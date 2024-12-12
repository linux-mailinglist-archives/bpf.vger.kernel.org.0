Return-Path: <bpf+bounces-46734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC79EFCC3
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B4516A1C9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56A1917E8;
	Thu, 12 Dec 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNhMpVwq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D31422D4
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033015; cv=none; b=RraCwY3/szewSH/8B0ugFH9qVvjZ6zsQc1LSl6Muu40CeBFHi9ccAX07/v0biVw1jeKbHrjVYkcpkdiagJmjsHBGRpt9PU91jBCR7ywkcMvKIWAoLOz9IJfBYuLMIKlCAGSJTVrUhBEq84y+rezigM3Puq8Uf0Y1GD0KabHm9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033015; c=relaxed/simple;
	bh=8YOtNuRTj6tGDQUsG7hQASH4PhJSFGGOzccADyFbAkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Co+XGupFMb6UkmN86sPQw0/g1OIMXwDCbL3AWO89UcvbcgTpnOZoz60V425AFY/3HoH1wWV5kPuER0EagJ/F3WkkxJmVVp3cclyMBRamNYmD7oZauSUrrLjj2JF8xAxSCvxUC/eXqqD9T0DG6MafY5S58jyW0qh8OIpvnCDS2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNhMpVwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFF3C4CECE;
	Thu, 12 Dec 2024 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734033015;
	bh=8YOtNuRTj6tGDQUsG7hQASH4PhJSFGGOzccADyFbAkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNhMpVwqdreowVKTPDExsfOtdCkfqEZ3PFnfCfaAJZ1ISFI3DczOoZwGONahKYuyT
	 ComUC7VummVBNnxmLYJrQDJHN8kxDCE/vHQA6z++NTnib0Q7QwzDTFHXvAo13kd37W
	 I3J3qEWLjn21xuP2kcR/KhzWejHtRUoEvQoG4NQVAw9lrsUVnUBVb9+zP+pRZgcsYh
	 k2/mqK+ser/oJc276RxjWH2Q+0No2yqE2/Eltc7mnQFGJx9PiMXYY7M99T6vu2DfuZ
	 4ngadlU9M7H5CjwtPjhotl9knzfeMXv/Xrl2WTXc0aBWAW2D8UoZChlO8pdGscO/md
	 BVAsBC4ZnNvgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE29D380A959;
	Thu, 12 Dec 2024 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: fix NPE when computing changes_pkt_data of
 program w/o subprograms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173403303164.2422426.1574242566292619873.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 19:50:31 +0000
References: <20241212070711.427443-1-eddyz87@gmail.com>
In-Reply-To: <20241212070711.427443-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, mejedi@gmail.com, lkp@intel.com,
 dan.carpenter@linaro.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Dec 2024 23:07:10 -0800 you wrote:
> bpf_prog_aux->func field might be NULL if program does not have
> subprograms except for main sub-program. The fixed commit does
> bpf_prog_aux->func access unconditionally, which might lead to null
> pointer dereference.
> 
> The bug could be triggered by replacing the following BPF program:
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: fix NPE when computing changes_pkt_data of program w/o subprograms
    https://git.kernel.org/bpf/bpf/c/ac6542ad9275
  - [bpf,2/2] selftests/bpf: extend changes_pkt_data with cases w/o subprograms
    https://git.kernel.org/bpf/bpf/c/04789af756a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



