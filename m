Return-Path: <bpf+bounces-40190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F197E798
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAEB215C0
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62D19341D;
	Mon, 23 Sep 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvShRKkD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103F2F2D;
	Mon, 23 Sep 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080476; cv=none; b=F8jAckM2VGZ3oyYGNvZuANJe3G6Zb75awE7Duh7LJKXE1Ixym00egPnfqIpymAnEM0CN/i8mVQrL8vu8Z9vgzUvlkRsE8P2sH29Y5ycC1HUjdJ2GmiEEd6FyCPqPZdXqmfQBkh2NL49YoNrtY+BxCq0OU8mw4YMxfx5U3Je9rhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080476; c=relaxed/simple;
	bh=RKen6Z1zD3TKFxZEjI37rBLQGIuE3UM2cEg1ZLhLCJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lwUzvPfjgrhVSLPylUBzzUIjEXkaQJ0xssRPUiIM0qkRzKI+Fu3Femly1YfD33KRv4IveZDIrBoS3ftZRmLgiLnBxcRMjQUfZLOxhGmr+1+uXVq0FjWEosYvYz/H1RhS+TtjNwtHM9STtJSGPuXP1EWhAl56kkTNWHDFC8d1GU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvShRKkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A5AC4CEC4;
	Mon, 23 Sep 2024 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727080476;
	bh=RKen6Z1zD3TKFxZEjI37rBLQGIuE3UM2cEg1ZLhLCJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HvShRKkDmI4DDHv8wxf3xNFWue/3zdAFhXdtqJVVpJn8A9aJPxklAR+AkM5IWcMn/
	 oIE61Z2p/43WuG6dodBTdVVVrgApHP4wd7W/v/lIryKNhPSqdHNVtJWKGUANU2O4mv
	 JaWQiaIkAPSn6/d7WWTv+su0kQciix4xHHitGvPHfyuRl1BYcru8vqx74EqyjbQEJc
	 SKw0GUjh1HHZyAKz+s4Nmy9BKikZP2FhsxhE4MzXS8DTKVfKeR5FLQiMMS3Z81uWSW
	 WbALxyyME8VZ+1T4aNRm5LH2fLGvjJonjhWdPGhbVwImJpx2T+YmkR2hfH8ielGbG+
	 xKNUY6IP6C/sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCE3809A80;
	Mon, 23 Sep 2024 08:34:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 00/14] uprobe, bpf: Add session support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172708047825.3261420.5126267811201364070.git-patchwork-notify@kernel.org>
Date: Mon, 23 Sep 2024 08:34:38 +0000
References: <20240917085024.765883-1-jolsa@kernel.org>
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: oleg@redhat.com, peterz@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 17 Sep 2024 10:50:10 +0200 you wrote:
> hi,
> this patchset is adding support for session uprobe attachment and
> using it through bpf link for bpf programs.
> 
> The session means that the uprobe consumer is executed on entry
> and return of probed function with additional control:
>   - entry callback can control execution of the return callback
>   - entry and return callbacks can share data/cookie
> 
> [...]

Here is the summary with links:
  - [PATCHv4,01/14] uprobe: Add data pointer to consumer handlers
    (no matching commit)
  - [PATCHv4,02/14] uprobe: Add support for session consumer
    (no matching commit)
  - [PATCHv4,03/14] bpf: Add support for uprobe multi session attach
    (no matching commit)
  - [PATCHv4,04/14] bpf: Add support for uprobe multi session context
    (no matching commit)
  - [PATCHv4,05/14] bpf: Allow return values 0 and 1 for uprobe/kprobe session
    (no matching commit)
  - [PATCHv4,06/14] libbpf: Fix uretprobe.multi.s programs auto attachment
    https://git.kernel.org/bpf/bpf/c/8c8b47597403
  - [PATCHv4,07/14] libbpf: Add support for uprobe multi session attach
    (no matching commit)
  - [PATCHv4,08/14] selftests/bpf: Add uprobe session test
    (no matching commit)
  - [PATCHv4,09/14] selftests/bpf: Add uprobe session cookie test
    (no matching commit)
  - [PATCHv4,10/14] selftests/bpf: Add uprobe session recursive test
    (no matching commit)
  - [PATCHv4,11/14] selftests/bpf: Add uprobe session verifier test for return value
    (no matching commit)
  - [PATCHv4,12/14] selftests/bpf: Add kprobe session verifier test for return value
    (no matching commit)
  - [PATCHv4,13/14] selftests/bpf: Add uprobe session single consumer test
    (no matching commit)
  - [PATCHv4,14/14] selftests/bpf: Add consumers stress test on single uprobe
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



