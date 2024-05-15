Return-Path: <bpf+bounces-29785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0F8C6B1A
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322D61F23FA4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B45C61C;
	Wed, 15 May 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsIQa+wT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE247F69
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792292; cv=none; b=roe3vGRSKFJRgcYCIoI62kX8bdwbPn5fTexbZu14w/cDUrVhiaIM0Hf+/GsbTRj2Hbmqt7aRqA9By+cNSzHMQ9og/YAFmrScNuFMA03adhIo3IrYVqad88Pm9nszyOmDhwt1fR7WCEugppLn+34MDn+QxJeqLBq308KYcas8EW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792292; c=relaxed/simple;
	bh=FUJ/eq065NiofEb8NxrmRjiJ9UmY5Q6J1EzQaLaO/gw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ig6PDkWAOYC2oMErDKYNymsZBq6sW+6WXb79/OuP3CdISnKuyAwhkQi2OyPTF5BbjssiwQDwHP5cw0EJcD6kRT9WEb4wWciGLqRfRvZj+nsSpNfGl2YEx3J/oZNUqNq665evcFbsjGr8Dok7gI2Ac9jv/FXG7I4wrF4ASTnYr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsIQa+wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3376BC4AF07;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715792292;
	bh=FUJ/eq065NiofEb8NxrmRjiJ9UmY5Q6J1EzQaLaO/gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IsIQa+wT+jkrtV934NdIvT3ANSzm61hgCrDbJyy2Bi6Cg94xMOc6mfWjmms3Z6h44
	 M3uau1JdCpV29K8rAdD9gzGEDmYh5Z4XumfV2BHhrIBhyynY9gN0QC00jTLNg1gq5l
	 W3PQ0vhA72AAhkxJEwpdPRPMAWdfVSv+merwuOz7t62DtUhzbSuZEQ8ibhu7y3Bfkd
	 RX/ADxqNm1LUmjmoERh3aQrcccpGVydW78JXvoX7R9mMtVBHwlBN8/rPBb60Q22g6V
	 q7BeJImNtCHa7Mn346DeHPIHJSLKPhAp477YOzGvdjQP0HhGgwP6LAXIeYVR9f6XnG
	 eRNwnqiiA5OPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25171CF21E4;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix feature detectors when using token_fd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171579229214.15564.1438327023874237356.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 16:58:12 +0000
References: <20240513180804.403775-1-andrii@kernel.org>
In-Reply-To: <20240513180804.403775-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 May 2024 11:08:03 -0700 you wrote:
> Adjust `union bpf_attr` size passed to kernel in two feature-detecting
> functions to take into account prog_token_fd field.
> 
> Libbpf is avoiding memset()'ing entire `union bpf_attr` by only using
> minimal set of bpf_attr's fields. Two places have been missed when
> wiring BPF token support in libbpf's feature detection logic.
> 
> [...]

Here is the summary with links:
  - libbpf: fix feature detectors when using token_fd
    https://git.kernel.org/bpf/bpf/c/1de27bba6d50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



