Return-Path: <bpf+bounces-20147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE4839D4E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C86A1C256B6
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A735576F;
	Tue, 23 Jan 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLI6XEc7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929854654
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053250; cv=none; b=sUE/s9w7IGM+JZP534eDgjP4BXVA+vA2ZEdOba9u6X/sQe0bEZfLPbK1VlZEHtZmpAvNptnlbyFCL189XBa3otT9EhGk1ib81IBVl2Fb62A5jIYhBoxtrEnXc6PPiQP/EkXvB67WwqFoURnm5scpBPGzQ9OkfapRFJRp4bvwG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053250; c=relaxed/simple;
	bh=oCMK/9W0nsG6SviQ+lZQATvdoOdRfQOrDNfzcxL+/NM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CU2jISnUREBjobey1SshTV6fsccUk8Tr4iCHl6tIhCc5w/MXJ2fDLxivh+cGQd2YosOmFFdhEEaUcSFtFYzwdH+M2y+0W/fHH+TVE3rzhLSBRivBxELiPNYOsdIxYDgasbD6Mz1+tP7F8ar3g1DQz959WEMUrnTf9rVLykQQ+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLI6XEc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49EB8C43601;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706053250;
	bh=oCMK/9W0nsG6SviQ+lZQATvdoOdRfQOrDNfzcxL+/NM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tLI6XEc7ltE56VmEHzIF+mNyjRv7/nyTc0ABGcn1g4EVL5Q7atKWrd/jSj/koOQ8H
	 ECW83VUeO8zi3Lp16wd85J96DsRmiu5rHro4VxlintIrib+Zt+7Bw7Lf2Is11W4BzE
	 Eg/zGarr8vj19oFDEen/2jlEXTB8qVWHyJ+J59qOlSEr6MvieU00GNbRyDjllVU7U/
	 L6HAl9oQihqTZ24HxLWGMIAXmTXeQAcfDKDbvOZrxTi+3J2ZtlsbwbfsddkxPLWLiu
	 iT++5ddq5CtFtQE5US9cC7Kp34yjkdMDOR0P4ocACVdiPqKajDuXK3a4jkYVR8T+/l
	 GSEHuaOXvpuyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FA01DFF761;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605325018.25186.12613038676566222239.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 23:40:50 +0000
References: <20240119210201.1295511-1-andrii@kernel.org>
In-Reply-To: <20240119210201.1295511-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Jan 2024 13:02:01 -0800 you wrote:
> We've ran into issues with using dup2() API in production setting, where
> libbpf is linked into large production environment and ends up calling
> uninteded custom implementations of dup2(). These custom implementations
> don't provide atomic FD replacement guarantees of dup2() syscall,
> leading to subtle and hard to debug issues.
> 
> To prevent this in the future and guarantee that no libc implementation
> will do their own custom non-atomic dup2() implementation, call dup2()
> syscall directly with syscall(SYS_dup2).
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: call dup2() syscall directly
    https://git.kernel.org/bpf/bpf-next/c/bc308d011ab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



