Return-Path: <bpf+bounces-46187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7E9E6150
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C6168075
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30E1D63C0;
	Thu,  5 Dec 2024 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxy+5Vpf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7D1D5144
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441418; cv=none; b=snSiEskpNPrJ3Uw8t4OxadNSqd9nEZU8R+oBBG0v/GLtTKznndVahHvjA0tZDQxeMCjLF2Opzs/ejkO2/8n7mtiGJjtEInjb3kJJFxKO9cVMekspVmfI6db3bRksLn9lZeTjEEde42Daad1DtyhPXjeZzjJlqlk9uJepYE9oDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441418; c=relaxed/simple;
	bh=HejpFJsUqAq5Ze2nMMWTFRAnAk8qwLpM2u42Kkp/PDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2vmHrxE+9zIr0Zz0TY6VRZJ/kiERelXHUun/3Gh5ldJmt0k8kps4ykxC1eY5CB6Z+fraub0KxjmgHGWREo6dYMBKsbhhBlf0fDsA4OZofVWKz9ZHmvRkHdk4tKhRhm1qI8zO4o/XIZeomY8clBJTkr2L3ES46Ld3K7uJTcm7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxy+5Vpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A07C4CEDE;
	Thu,  5 Dec 2024 23:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733441418;
	bh=HejpFJsUqAq5Ze2nMMWTFRAnAk8qwLpM2u42Kkp/PDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxy+5VpfNylikJNrPvalUeZ9Zauv0QeLI4P9VZCnqYyEQYvEO4InvsT6xR99XzMTg
	 CnTMRNpaOBQz/RHC9RBVeDwnck6AmqME8vgqahU0EKqkhaCALmw7KHTiSeOnFvnqPc
	 cwzo2VPPhuCvM2wgwHatk1XCZa0D0/GzCPY8Afezo+x9TkJj+ttfTfvMSiVTuZTxJK
	 vh4kXSlG42qAjelnThVTw8fPB64PglJ2LMIGvq7IuB239PMNCyzgPPKrrByU0MUdwx
	 sP+uPBLTY6oTBCUCo7xXRA/xw4jUAcWy1lNjZBeji54HiUr6l7ux0BAkik+2HSRaxN
	 GI2wfruJ2Njgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5C0380A952;
	Thu,  5 Dec 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix segfault due to libelf functions not
 setting errno
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173344143251.2102866.5866509789597311586.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 23:30:32 +0000
References: <20241205135942.65262-1-qmo@kernel.org>
In-Reply-To: <20241205135942.65262-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  5 Dec 2024 13:59:42 +0000 you wrote:
> Libelf functions do not set errno on failure. Instead, it relies on its
> internal _elf_errno value, that can be retrieved via elf_errno (or the
> corresponding message via elf_errmsg()). From "man libelf":
> 
>     If a libelf function encounters an error it will set an internal
>     error code that can be retrieved with elf_errno. Each thread
>     maintains its own separate error code. The meaning of each error
>     code can be determined with elf_errmsg, which returns a string
>     describing the error.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix segfault due to libelf functions not setting errno
    https://git.kernel.org/bpf/bpf-next/c/e10500b69c3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



