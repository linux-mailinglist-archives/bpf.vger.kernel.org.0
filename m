Return-Path: <bpf+bounces-44376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1109C24F7
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30EB1F237A2
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAB1A9B49;
	Fri,  8 Nov 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmbdEoQM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098B233D83;
	Fri,  8 Nov 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091223; cv=none; b=HqWVeGsiTw9RWx+ryliX7TI33wq9c7n8ulBBDQA0Ud4vYpuG2KBEObt2JLoXcJ+6W0PNrS/LDGrcv8ComDhfKuwWy2183NXtIwo6A1uLHak/LofXIrena4hRtIsDxwETu4b+d80l6dOkgwn1Afm8HCJu4xRRYl3qbcNE04twJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091223; c=relaxed/simple;
	bh=isOCNhM7/InRuCIvcLSY/HCUam/j80uOJ1x4kGmRdzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tfk8Qu//2KGicI3uQ1YnVyI3+H/q0rBvosfIk3wp0TI4p3NIdtU+SF23n0gEdd85JcJYnZcGf9DJ7hjzo5GIjsz2aqNgktoQvPQuv0koGEM/tW9b/Hdwee2/xhmNWquO5CW/P6Miv4jxwiVNGAX081p1VpsO/4jp1UAKSgOhCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmbdEoQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C510C4CECD;
	Fri,  8 Nov 2024 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731091223;
	bh=isOCNhM7/InRuCIvcLSY/HCUam/j80uOJ1x4kGmRdzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fmbdEoQM/eSK1FEgGTkc0zVGpqRzHSgx7nWCbvpVc8Y0M4n8a5c7w4/s18yOZiqZa
	 OXlNx97GgZvWPCoZOyWGCL1b3O34YKWm81oSMfvztb9cEj4KAkOTUUB2LXhxHpkX+c
	 VEZxtWKTNSVyuFjVMYVsggFgMMdbQrGQpShN+Z/HXgIXB+gBJR/v6pqp+HZPTWR0HJ
	 6TD+GoLQwCBemIAJvWViGAyDqfvvL5d5FBwdIECEV/uvDFz2sa8XrJxtpQhGpDDv4h
	 tUczXCV965N0KcqOKKuo+ESKgDxuRxnGLaE6m9vKLLPgdbD9ypiPQKOgLF4rwtkTw4
	 VPhbUKsrH7eCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE553809A80;
	Fri,  8 Nov 2024 18:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv9 bpf-next 00/13] bpf: Add uprobe session support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173109123276.2726733.16157399408495124649.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 18:40:32 +0000
References: <20241108134544.480660-1-jolsa@kernel.org>
In-Reply-To: <20241108134544.480660-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: oleg@redhat.com, peterz@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  8 Nov 2024 14:45:31 +0100 you wrote:
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
  - [PATCHv9,bpf-next,01/13] bpf: Allow return values 0 and 1 for kprobe session
    https://git.kernel.org/bpf/bpf-next/c/1c9b65d7b569
  - [PATCHv9,bpf-next,02/13] bpf: Force uprobe bpf program to always return 0
    https://git.kernel.org/bpf/bpf-next/c/fb9618060bb7
  - [PATCHv9,bpf-next,03/13] bpf: Add support for uprobe multi session attach
    https://git.kernel.org/bpf/bpf-next/c/4c2c20b698ce
  - [PATCHv9,bpf-next,04/13] bpf: Add support for uprobe multi session context
    https://git.kernel.org/bpf/bpf-next/c/362ced90a9b9
  - [PATCHv9,bpf-next,05/13] libbpf: Add support for uprobe multi session attach
    https://git.kernel.org/bpf/bpf-next/c/894d0bd715f8
  - [PATCHv9,bpf-next,06/13] selftests/bpf: Add uprobe session test
    https://git.kernel.org/bpf/bpf-next/c/1932f3ffe604
  - [PATCHv9,bpf-next,07/13] selftests/bpf: Add uprobe session cookie test
    https://git.kernel.org/bpf/bpf-next/c/dce1b3b721b8
  - [PATCHv9,bpf-next,08/13] selftests/bpf: Add uprobe session recursive test
    https://git.kernel.org/bpf/bpf-next/c/9236020b0896
  - [PATCHv9,bpf-next,09/13] selftests/bpf: Add uprobe session verifier test for return value
    https://git.kernel.org/bpf/bpf-next/c/a773e1d169db
  - [PATCHv9,bpf-next,10/13] selftests/bpf: Add kprobe session verifier test for return value
    https://git.kernel.org/bpf/bpf-next/c/7dd198ccbe43
  - [PATCHv9,bpf-next,11/13] selftests/bpf: Add uprobe session single consumer test
    https://git.kernel.org/bpf/bpf-next/c/beab56332941
  - [PATCHv9,bpf-next,12/13] selftests/bpf: Add uprobe sessions to consumer test
    https://git.kernel.org/bpf/bpf-next/c/f343d91be2cb
  - [PATCHv9,bpf-next,13/13] selftests/bpf: Add threads to consumer test
    https://git.kernel.org/bpf/bpf-next/c/90aac4610851

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



