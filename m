Return-Path: <bpf+bounces-46988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCD9F2042
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345E9166DF4
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62719B3E2;
	Sat, 14 Dec 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHt7tTK2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934B80C02
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199840; cv=none; b=MrVbXVnN2u8TLDrP63MDE8j9pDbVBybFD8cu2RNI94xHm0RIO3nlzd3SVq6u1XnFDan7cXCZ2++vE4NLAdLxg8eZxIWlJ5Rl78S3sg43j3woh6cqybUY8HlDZrccPfhUGGd6Y97lTPTorgh5SbTWft2lpCYs69tkt1D1CYU9JW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199840; c=relaxed/simple;
	bh=wkPWb/U7tMN8Ov3U863PsH0zk5iKoehGScvxE6GF92s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aGx1ah80CipV5pQmgc/LRC8aYCeKQ9i3tuAQDVRxsdpi9z4XSzWu3PEcKRlIechV9V3eortXO8ewjZRSZbjkFwPEUP4CQ9SHoKqF8xccV7lDQPD6GteoKeztpneazcfW+IZA1zU5XJY9GhzbAlIwb8wZbNP1PkUWcctfcB4XWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHt7tTK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54772C4CED1;
	Sat, 14 Dec 2024 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734199840;
	bh=wkPWb/U7tMN8Ov3U863PsH0zk5iKoehGScvxE6GF92s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHt7tTK2U4vNKlMMuNNrxAgg+RUNSVjuzJo7qU6WiM3dLPOlzmHhnxP6EPm8e832O
	 xnW5tvPvn3UQIUVRQlMzClXhaabvJ1AaCWD1WigOsqdr9ikbd0VSMLvwDTGltW/vJQ
	 qGzfh+IsL5u1QScrAL6iII3EZ8mOV4skRqnBr70y1Tg+dUrfCGrV/9hMQ2rEVrGKEk
	 aOYQMLTMQhouKg6HytCmwc1mtPoGcyPlA6QQzl9c9PoZ9cbdnmD2VXt4Kf6sCkcPZ2
	 71s7SL6Stxb0F9U6srZQDYGbyudMm7TfciXlC6Vgshm2+xzOhzRl9CjbRjPgPyHsJz
	 XnnRLfouqwQew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1D380A959;
	Sat, 14 Dec 2024 18:10:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Avoid deadlock caused by nested kprobe and
 fentry bpf programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173419985703.3371266.10165961479999486320.git-patchwork-notify@kernel.org>
Date: Sat, 14 Dec 2024 18:10:57 +0000
References: <CAPPBnEZpjGnsuA26Mf9kYibSaGLm=oF6=12L21X1GEQdqjLnzQ@mail.gmail.com>
In-Reply-To: <CAPPBnEZpjGnsuA26Mf9kYibSaGLm=oF6=12L21X1GEQdqjLnzQ@mail.gmail.com>
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, ardalan@uci.edu

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Dec 2024 17:58:58 -0800 you wrote:
> BPF program types like kprobe and fentry can cause deadlocks in certain
> situations. If a function takes a lock and one of these bpf programs is
> hooked to some point in the function's critical section, and if the
> bpf program tries to call the same function and take the same lock it will
> lead to deadlock. These situations have been reported in the following
> bug reports.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Avoid deadlock caused by nested kprobe and fentry bpf programs
    https://git.kernel.org/bpf/bpf/c/c83508da5620

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



