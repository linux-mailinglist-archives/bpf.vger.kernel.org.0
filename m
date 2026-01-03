Return-Path: <bpf+bounces-77722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F005CEF815
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 01:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5631C3011FA5
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBC46BF;
	Sat,  3 Jan 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdB6hvqZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF521373
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767398606; cv=none; b=N+VLkxdqe4I9S5EJa8/Y5aGJLhHExzXiXsSWaxLGkH7JVjeWr2rXdROWMEfyLp+sUrK1YYrXGqej6A6lICEzAxUIZRgPLwYOT9cEh/W+pNDkQIzDDeBHVBE2MeHHSCjAQ2WfzH1n6rBi4i3fcfrDr8tVHcvs8smQnKqREKh6mOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767398606; c=relaxed/simple;
	bh=CKI61edfs+HjXwf+UnN88t26Ec+qmFhHCqHglFXp8Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bX0Uuqq000xtw82b0UW+QWSvAJxcMhXwLly696R1xw6xxlLV3es6iwD/4ER9TK0zZ7+JMJbETHGPfmcBGdqJMRS/sEaBa4+3BLriyRdkvjB9hMmcaeQJwUCT9V8ODKyC5u85gyBe9XKA1AKL6cpAja3Qhp0L1YFe0UjEcbwZ7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdB6hvqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6FDC116B1;
	Sat,  3 Jan 2026 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767398606;
	bh=CKI61edfs+HjXwf+UnN88t26Ec+qmFhHCqHglFXp8Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IdB6hvqZnDC3GLcDR8r0tuFIZFJsNLXKfHh9d1ar5Eqs/88fZVHRfUAor5+agiUXV
	 NJspfHpF5YLvBknyVG4akc1bgAglSXXUn7iX3u5iT6b+lI7M2wrtv8TGNUkFKFjPX4
	 9KGlUImoE18FDIMZezX4zk2rRHSmp6qlTvgpYIi1cgrN8efbWIOS2F9RcGp+tAJs1c
	 A7QwsnvWOFgugGxqeW0XJYJMKQ6m13262fMuDHQF0tF5lAUi0Wa1uxtv+X023f5ejJ
	 jqQTyi4GD4eS+WeDRxUQdphwlfDeb0bNaoIu01Y4bkUKKBJuNHwjbzaYXDrvJ8TcTQ
	 FBMTezpHN7jcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BC1E380A962;
	Sat,  3 Jan 2026 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Replace __opt annotation with __nullable
 for
 kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176739840605.4034889.2924070448105103726.git-patchwork-notify@kernel.org>
Date: Sat, 03 Jan 2026 00:00:06 +0000
References: <20260102221513.1961781-1-puranjay@kernel.org>
In-Reply-To: <20260102221513.1961781-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Jan 2026 14:15:12 -0800 you wrote:
> The __opt annotation was originally introduced specifically for
> buffer/size argument pairs in bpf_dynptr_slice() and
> bpf_dynptr_slice_rdwr(), allowing the buffer pointer to be NULL while
> still validating the size as a constant.  The __nullable annotation
> serves the same purpose but is more general and is already used
> throughout the BPF subsystem for raw tracepoints, struct_ops, and other
> kfuncs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Replace __opt annotation with __nullable for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/a069190b590e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



