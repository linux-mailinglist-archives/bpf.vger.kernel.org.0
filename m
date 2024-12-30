Return-Path: <bpf+bounces-47719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F09FEBA4
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79A4188304D
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A819DF52;
	Mon, 30 Dec 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN7sB2Af"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B019CD1D;
	Mon, 30 Dec 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735600825; cv=none; b=ITr91refng6TYQIaTtWj0qwV413lqYYPLCw8kdGO+cyY4P+EcQ1Jxdpe5WT07Bv6z4Y2gCRLgXz4HF8IvjMxvMycHG65p/4gdj3V5YPCoronbfZlMIXMLGESK5ojoDikj2J8qylF7XW7DazwjRh4uCbAZ6inMaFdli+XVpzLxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735600825; c=relaxed/simple;
	bh=dczdWUzae8fATUXm+18b81NX8QkYrzBLjrJF1942r0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e9Z1LZU41Ux6x8e8guG2DzscFJmll/ZW+oHtigmDwEIyQ3mXwMXx8d7yV302qxFprj/I1DlPzewMzb7GurFDe4kdt48CWeyGr+qwHsmCa5YP8MhKG4UKAW3SL21h/oDxXIctThErapu23MncO3zrDfa6aw7veIUBzzMt70J/z90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN7sB2Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A918DC4CED0;
	Mon, 30 Dec 2024 23:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735600824;
	bh=dczdWUzae8fATUXm+18b81NX8QkYrzBLjrJF1942r0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iN7sB2AfC3rfcDQq/z3sYEHjp5i95BJZA/RYLXMqijsEu22NzYe8+gOZq26tN91VR
	 DEIClEkCYXp8vrHbssmzvhp8LMdU7pqJowGGVxf37v3gWcWT0h0UssiEYWkw3fuAda
	 iW1TeQFqyhqDdQX5xmmP1ZTpqZtSVZjiARZnqq9xDYaZtiDxSiQWvo3uzQ+ommw87J
	 cvZu3cjwdShjmTyly+XcMiPupNRz78OuymD76qIEXGU62aJPZquE+/x22R9O42xQvl
	 Z/ObNY7EvKuoIA5bm03JMvm0W7bEoTdJZB1nuuuLk9B/gpjvEB4uKvai2cgLf1P+uk
	 oBD3kYD/8xBbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2DD380A964;
	Mon, 30 Dec 2024 23:20:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove unused MT_ENTRY define
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173560084451.1463142.4089107711832482844.git-patchwork-notify@kernel.org>
Date: Mon, 30 Dec 2024 23:20:44 +0000
References: <20241223115901.14207-1-lpieralisi@kernel.org>
In-Reply-To: <20241223115901.14207-1-lpieralisi@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Dec 2024 12:59:01 +0100 you wrote:
> The range tree introduction removed the need for maple tree usage
> but missed removing the MT_ENTRY defined value that was used to
> mark maple tree allocated entries.
> 
> Remove the MT_ENTRY define.
> 
> Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> 
> [...]

Here is the summary with links:
  - bpf: Remove unused MT_ENTRY define
    https://git.kernel.org/bpf/bpf-next/c/654a3381e3b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



