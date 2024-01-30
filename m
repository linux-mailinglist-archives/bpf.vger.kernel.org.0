Return-Path: <bpf+bounces-20738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31028427DB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F6B1C262AE
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28C823C0;
	Tue, 30 Jan 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayho5h1N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE88121B
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628026; cv=none; b=d6YNjVED7JQC+t6NGZbN8bwNfrRozJVvaW/+q79x4PojQ4Ricd99duv/qdFtw3L5HBt/cOKHBnsKXC6Qop5wLoNJqODPnDAU0bgAcgNaJliyLTKVgxqf6fyLySupZRcg7LcG+fcg/SfSDYVVcXP0H/wkmu9eef4GMIAsOuCx8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628026; c=relaxed/simple;
	bh=PboZhfahKHok0Lx2zbG4dg0j1iTJoDyweylsXjHHH0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYjEFylBK39Sz4+WiaHSSOXvv7o7xnDm+nTATWJHyWzaLo4vyYCXm+cPAV9rfE7pty9O1vifJQufXqZ88IBe4wnsb6iRDcRXpdxd/cPyJ2qLcWazp7wV1oaC6Aay4H2vn9fMWgW2ki/aB9YeYTHNHDM6m7gJAG8FGv3HX58o6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayho5h1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E62C43609;
	Tue, 30 Jan 2024 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628025;
	bh=PboZhfahKHok0Lx2zbG4dg0j1iTJoDyweylsXjHHH0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ayho5h1NsPIlsYce30LZwhFb+0kXHsJIrU7jTFnU8sgVDsQdHIvCZqAYlsJa2V6Pc
	 IljhaQlZoCUuNc3nTB6AVmgQ5XzNI26UAL9unLqWZaN6ege30rYYytzrxuOTffoLwt
	 /yuC2gVD9CWDRbb60brHoVHffY5DmGTzuIhuXVVu18N8TRYIzuH1Eiyj1xXllUJ+oU
	 zP2OIIjlNQH3Rlzm1my3ot0uNfhywxCwpy86UhbX3708acId6KSsXmUMnrVtDtWizG
	 d+X75BY5f+vA4J/vnaTmZ0CGiho5IhQI7ODRUdoHkMNHOJOG5jc3W3yxVgOalXPelf
	 paMw+UOFe2x0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B6FAC3274C;
	Tue, 30 Jan 2024 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: build type-punning BPF selftests with
 -fno-strict-aliasing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170662802543.4509.10516985875114662334.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 15:20:25 +0000
References: <20240130110343.11217-1-jose.marchesi@oracle.com>
In-Reply-To: <20240130110343.11217-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yhs@meta.com, eddyz87@gmail.com,
 david.faust@oracle.com, cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jan 2024 12:03:43 +0100 you wrote:
> A few BPF selftests perform type punning and they may break strict
> aliasing rules, which are exploited by both GCC and clang by default
> while optimizing.  This can lead to broken compiled programs.
> 
> This patch disables strict aliasing for these particular tests, by
> mean of the -fno-strict-aliasing command line option.  This will make
> sure these tests are optimized properly even if some strict aliasing
> rule gets violated.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: build type-punning BPF selftests with -fno-strict-aliasing
    https://git.kernel.org/bpf/bpf-next/c/27a90b14b93d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



