Return-Path: <bpf+bounces-35592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB193B9C4
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430FA1F23E33
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C891C01;
	Thu, 25 Jul 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4PzYtv1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B517C2;
	Thu, 25 Jul 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866832; cv=none; b=Yc2dbd1epkBJ7vk3scTpyI3EUENdoRNYAE5ScLQalXgOqUyhDFsXOKVZ4uNNIUvucUNjFM2MHZjwy4a2R0CKD0AJCXWJNW2VgjRe0dDYkyx5NbT0VE/t2/gLqcnjJq9eFTwBUctTK1y33NPbWB0QeJVVPrP7PvJ2OhKpjwAAJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866832; c=relaxed/simple;
	bh=m5cezUP0xkAXQ2pBXRrRj0V0UkVsrJZ4Yc3vHoEbOzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DorG5dMvTpcSJpq0uf30bx2azTNUG2/Oz9ihK+3KZ0j8rz2SfPmubIPctyZQxyshmypMVKZGfRP2YGjO9gud9odscvIR8tWMw8WU2OrUjbDj2MTxtQgIcmbIGEsO+xTpsXG9Yfa3Zo3hJDLhXhm6xRMFN2Ktg4/kAGDXMhB7Nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4PzYtv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1A25C4AF0B;
	Thu, 25 Jul 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721866831;
	bh=m5cezUP0xkAXQ2pBXRrRj0V0UkVsrJZ4Yc3vHoEbOzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I4PzYtv1IpSApKRsyC5pZgFx0VzhKmmw0gd5T+iJ3FrVGdyTxz+iP1TccKhLZD6RN
	 Y4x2DSg9v5ANXP82cpZp8zpuTnv0TFIveZLcbTJ5nmvcJSzaW/NgEEA5KW044Ot4Dn
	 ML5qOUGKJbUOz/ro9FS7V3T8MSGW5Rica30bba4dZrnuppxG61UjRAMT/IM3mLF8s0
	 OhdZE+ElKnwv27bXA2oZOPKNOqCEx0d320RWFYZraPic3fWVhW1qs2uufOu5haOhaf
	 hCljxUGfNTwalBcgWOa4yh2XkdvqQKVeThNMWWDE6KHIcsEE/PjkaBqNf6NiNpQHtz
	 XwRA9P3RRdCtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FCB4C43601;
	Thu, 25 Jul 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: Don't take direct pointers into BTF data
 from st_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172186683158.5513.16534010366965699668.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 00:20:31 +0000
References: <20240724171459.281234-1-void@manifault.com>
In-Reply-To: <20240724171459.281234-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 Jul 2024 12:14:58 -0500 you wrote:
> In struct bpf_struct_ops, we have take a pointer to a BTF type name, and
> a struct btf_type. This was presumably done for convenience, but can
> actually result in subtle and confusing bugs given that BTF data can be
> invalidated before a program is loaded. For example, in sched_ext, we
> may sometimes resize a data section after a skeleton has been opened,
> but before the struct_ops scheduler map has been loaded. This may cause
> the BTF data to be realloc'd, which can then cause a UAF when loading
> the program because the struct_ops map has pointers directly into the
> BTF data.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: Don't take direct pointers into BTF data from st_ops
    https://git.kernel.org/bpf/bpf-next/c/7244100e0389
  - [bpf-next,2/2] selftests/bpf: Add test for resizing data map with struct_ops
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



