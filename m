Return-Path: <bpf+bounces-59939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D94AD0964
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7F0189CEF9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7D234964;
	Fri,  6 Jun 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5QfS6E5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3484039;
	Fri,  6 Jun 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244798; cv=none; b=WL4oxJymSksiJm+/eIaJ4oyQh80euOy8tR4oJfZxzkSWJ3ylolEIJAIwRkWdrIW7saMrvxkMMvcffVXq322lfXJSGp7i/sCpQBr7HPI6EBeQOGibXrE82U5DAuO+ZR9FY0jNrKoPhSl9ndn6uod57S0sXFxGUZR+l8v7z0Da4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244798; c=relaxed/simple;
	bh=r8+oY3WR8fauwlfsyQfE8FHu3+Yb7rovSOVtu4WsM9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SIv8+/J4WQQmDa1lUCbOIdXfEG8rNgwo/rhq//fTj91JMASRmUaGas+KT80aroHIqF7aVfZN4317EzRC2rqqFZt47P8S5dYmRX76RD5b3PIBNy2A74QcqNsSmOHNAudEfUrV7jhneVo6xKGU90rRbiXKBQl/aV1pH2dkqy457Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5QfS6E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8632C4CEEB;
	Fri,  6 Jun 2025 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749244798;
	bh=r8+oY3WR8fauwlfsyQfE8FHu3+Yb7rovSOVtu4WsM9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5QfS6E5W0S/1txMAkXTO0leyEsitPMRflqJpDiptYSulkfmEiNucZzSdIYVO+RN5
	 jVoP9wViQlPj5YO3WaOQstu3Y0FxyXdClQDxJw2AtTRlq3Modj7MWAOiSYK31yyFN8
	 BdzZQcoDEdIrWEmfBMC8t2l2aCjp61ar3x3yOSeCpV+V/rDGYVg7gYfbY6AfG0KKo8
	 p2w9fQ4v/Z9oa4Rk2Zlol9gX5pu4CUraeGpw/O56pbjg83HJzYTRBGmYyhX9DHix64
	 KBiANLqAYkHG3M8qL5+nGNtLbmqkxR5qxk71+y+HEdMw3QpcBgJRcqk65F5/KsQdp/
	 XZMV7P40QXR0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAC3822E05;
	Fri,  6 Jun 2025 21:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: handle unsupported mmap-based
 /sys/kernel/btf/vmlinux correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174924482950.3997280.17986283354831226329.git-patchwork-notify@kernel.org>
Date: Fri, 06 Jun 2025 21:20:29 +0000
References: <20250606202134.2738910-1-andrii@kernel.org>
In-Reply-To: <20250606202134.2738910-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, linux-perf-users@vger.kernel.org,
 kernel-team@meta.com, acme@redhat.com, lmb@isovalent.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Jun 2025 13:21:34 -0700 you wrote:
> libbpf_err_ptr() helpers are meant to return NULL and set errno, if
> there is an error. But btf_parse_raw_mmap() is meant to be used
> internally and is expected to return ERR_PTR() values. Because of this
> mismatch, when libbpf tries to mmap /sys/kernel/btf/vmlinux, we don't
> detect the error correctly with IS_ERR() check, and never fallback to
> old non-mmap-based way of loading vmlinux BTF.
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: handle unsupported mmap-based /sys/kernel/btf/vmlinux correctly
    https://git.kernel.org/bpf/bpf/c/02670deede22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



