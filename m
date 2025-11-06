Return-Path: <bpf+bounces-73767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9CC38C77
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 03:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4733B26B9
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5E21CC58;
	Thu,  6 Nov 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ileOsA8E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996971991D2
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394449; cv=none; b=Zq46GwXYAepta6UVV2b0dKjTDvOa8TRuAV7JW+TOlEyMBI7sLBuoO1Tn9slxJvYBeZ4QRsAN+MYb3ynL2Oqc50M+FIYtvUiXL6QRpIiDcfE7AtouqK5bHboQBVEoGWzRA6kHloQo0T9cJOE/fqzVWQsaxnUCVafhD5TAAZZLcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394449; c=relaxed/simple;
	bh=t3HTbYkw2cbPzYpVoXyBIKcONbnZ/PE68gnhciPi2lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTld80qbD9ko+yO3Ke/EHQum3naCrTnnra3kfZEE60jzKcA2ULblWXSoaLwHfQO+QxPdi4ySxKIZpLg+GbZUuP8jhjYsmHjcxYQPIyqR9/GbhZbphB6hil74mkiWJwc7RPuszwTt76lt5C5VCr5KWPybWByxQlxlEmejXM/5MTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ileOsA8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432B0C4CEF5;
	Thu,  6 Nov 2025 02:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762394448;
	bh=t3HTbYkw2cbPzYpVoXyBIKcONbnZ/PE68gnhciPi2lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ileOsA8ESMAB7i/W4WGP0ajTVXE5DMtCpgUr0tyT6uo177gRELsTlEYDv5UNJm8s5
	 PO2R3eEAv1TGgivhEes0flAAc/YlwLRXkX7a7WsMXcN519lAMPxncrAXqUtNyWAzzg
	 fTk5LE8p3yddgt2gnsRNCOVDzicgw+qZtBOZubbB998/mM6bZmyNm/AIt8/HSRTWQZ
	 GUfTEpvmy1oxGxDLGZ1DitDNvH6UDPBm1nXJ37BRcFXjH+Wnxl7DLmcNBfP2znNIKY
	 n1npmBb4HiZv9uWb0+RRLwYpk+FvjBy8KWfEKtxeAGyweay1XmWtq9zRkSA0TCnppa
	 ojyyXLO5GB0+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC0380AAF5;
	Thu,  6 Nov 2025 02:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11 bpf-next 00/12] BPF indirect jumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239442150.3831359.9615514579674903166.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:00:21 +0000
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com, qmo@kernel.org,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Nov 2025 09:03:58 +0000 you wrote:
> This patchset implements a new type of map, instruction set, and uses
> it to build support for indirect branches in BPF (on x86). (The same
> map will be later used to provide support for indirect calls and static
> keys.) See [1], [2] for more context.
> 
> Short table of contents:
> 
> [...]

Here is the summary with links:
  - [v11,bpf-next,01/12] bpf, x86: add new map type: instructions array
    https://git.kernel.org/bpf/bpf-next/c/b4ce5923e780
  - [v11,bpf-next,02/12] bpftool: Recognize insn_array map type
    https://git.kernel.org/bpf/bpf-next/c/18a187bf2584
  - [v11,bpf-next,03/12] libbpf: Recognize insn_array map type
    https://git.kernel.org/bpf/bpf-next/c/cbef91de0271
  - [v11,bpf-next,04/12] selftests/bpf: add selftests for new insn_array map
    (no matching commit)
  - [v11,bpf-next,05/12] bpf: support instructions arrays with constants blinding
    https://git.kernel.org/bpf/bpf-next/c/30ec0ec09bf5
  - [v11,bpf-next,06/12] selftests/bpf: test instructions arrays with blinding
    https://git.kernel.org/bpf/bpf-next/c/ae48162a667b
  - [v11,bpf-next,07/12] bpf, x86: allow indirect jumps to r8...r15
    https://git.kernel.org/bpf/bpf-next/c/5bef46ac9c57
  - [v11,bpf-next,08/12] bpf, x86: add support for indirect jumps
    https://git.kernel.org/bpf/bpf-next/c/493d9e0d6083
  - [v11,bpf-next,09/12] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
    https://git.kernel.org/bpf/bpf-next/c/bc414d35831b
  - [v11,bpf-next,10/12] libbpf: support llvm-generated indirect jumps
    https://git.kernel.org/bpf/bpf-next/c/dd3fd3c96559
  - [v11,bpf-next,11/12] selftests/bpf: add new verifier_gotox test
    https://git.kernel.org/bpf/bpf-next/c/ccbdb48ce5cd
  - [v11,bpf-next,12/12] selftests/bpf: add C-level selftests for indirect jumps
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



