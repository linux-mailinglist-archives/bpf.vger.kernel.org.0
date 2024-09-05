Return-Path: <bpf+bounces-39062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883D96E3F2
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1219A1F23053
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70416191F6B;
	Thu,  5 Sep 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXtwAExf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C63D6D;
	Thu,  5 Sep 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567633; cv=none; b=IOo8rQvJGuJMPL5JvR+8m1rEtlmP1HgaWNJGqKwKhx6P8UX9xGVXuG8NSXhelUnbEtFnn5/UQwb7nM5EjphcxeX1ncF1OFMc5LDiPOVyN37KB22kJkNt0HlrJPV5JyFhg0bQyqQs5oZ/N5rHC4VwL4IBjhSd8UM8DWPkmDcjVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567633; c=relaxed/simple;
	bh=WNTKcbBoP3yzp4k548lRNhojlPboqlXEMOGGTo3NcgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DiXxtofrNhZL4dPRbnHSC6LzwSDHrAoUii0s5aA9x3MG7iCDaQNR8AjA3cWCPB6DNQrRAtbJO8kLdVqFCiYxVJv15c7bnQb3sPShtTmq+qhyOA0qilVVPGT/BAqJjup+KNjR0slImyTcVYGbZs/i5sZ4apYWdQzBN9I/hQDtL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXtwAExf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674DDC4CEC3;
	Thu,  5 Sep 2024 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567632;
	bh=WNTKcbBoP3yzp4k548lRNhojlPboqlXEMOGGTo3NcgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXtwAExfJEeJNm1MsUalbDl2XLmIPmnUcG4E5rZok3mplUU8MpDwZBrC1kr+7fQ+1
	 lo1CwP0DJE/qJy3AiwsE+qlusFQ+kBZxjRAqTpD3smQEYs5iy+XH9zxuiFKPqJ69m/
	 f3eMqoq9QmnAYg0hD/v1BT2t31YYDKZkLWI6jbyHAM4ydwVp4gDolxFtgRN/ms/hag
	 XnTn+o2TXtv3023EBMTElGS2uZ4ioQsU2+1rRRMj6huHJtE4/qSS6bxeThmXNFrBk0
	 PEz96UduTGJ26munzXiQr7pZfS0vPkvWcIjvpJ4l8hqJZfVNwU2lZUHX+rW+A9H2yF
	 31K9oTivEiD7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71E883806654;
	Thu,  5 Sep 2024 20:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/10] Local vmtest enhancement and RV64 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172556763330.1833779.11043836271169244932.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 20:20:33 +0000
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
In-Reply-To: <20240905081401.1894789-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 bjorn@kernel.org, puranjay@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, palmer@dabbelt.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Sep 2024 08:13:51 +0000 you wrote:
> Patch 1-3 fix some problem about bpf selftests. Patch 4 add local rootfs
> image support for vmtest. Patch 5 enable cross-platform testing for
> vmtest. Patch 6-10 enable vmtest on RV64.
> 
> We can now perform cross platform testing for riscv64 bpf using the
> following command:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/10] selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make
    https://git.kernel.org/bpf/bpf-next/c/dc3a8804d790
  - [bpf-next,v3,02/10] selftests/bpf: Rename fallback in bpf_dctcp to avoid naming conflict
    https://git.kernel.org/bpf/bpf-next/c/a48a43884cdd
  - [bpf-next,v3,03/10] selftests/bpf: Prefer static linking for LLVM libraries
    https://git.kernel.org/bpf/bpf-next/c/67ab80a01886
  - [bpf-next,v3,04/10] selftests/bpf: Limit URLS parsing logic to actual scope in vmtest
    https://git.kernel.org/bpf/bpf-next/c/0c3fc330be6d
  - [bpf-next,v3,05/10] selftests/bpf: Support local rootfs image for vmtest
    https://git.kernel.org/bpf/bpf-next/c/2294073dce32
  - [bpf-next,v3,06/10] selftests/bpf: Enable cross platform testing for vmtest
    https://git.kernel.org/bpf/bpf-next/c/d95d56519026
  - [bpf-next,v3,07/10] selftests/bpf: Add config.riscv64
    https://git.kernel.org/bpf/bpf-next/c/897b3680484b
  - [bpf-next,v3,08/10] selftests/bpf: Add DENYLIST.riscv64
    https://git.kernel.org/bpf/bpf-next/c/c402cb85802f
  - [bpf-next,v3,09/10] selftests/bpf: Add riscv64 configurations to local vmtest
    https://git.kernel.org/bpf/bpf-next/c/b2bc9d505499
  - [bpf-next,v3,10/10] selftests/bpf: Add description for running vmtest on RV64
    https://git.kernel.org/bpf/bpf-next/c/95b1c5d17832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



