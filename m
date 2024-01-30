Return-Path: <bpf+bounces-20681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A7841AE8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 05:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B5928A3CE
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467123770C;
	Tue, 30 Jan 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPkuHtMG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6D374C6;
	Tue, 30 Jan 2024 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587824; cv=none; b=UdVp8mnpJqCvmnwxf0BBkVp+AiBSGCoUuC7wgh8jzpvdWvO7zXkdr+vAkmYAfEcaMGcJNWWaz+TON5pzotliVQQGSJLmva5mOZMpT7Esmp96ffCw9STALRiqeAQCLJrezwPgOx9HZ3B0EaRT2Mj0cTs6iqhQjOWfv8TJdVwkYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587824; c=relaxed/simple;
	bh=ob1IYsuCU1fK8G9UTpGNv7xEjQtbA1pTIU/kjsxuEYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sw0UHKJ0lD5QPbt9vecV65+UoCVQgpK5JJ6nxcZAMQiz0RboLES/eMCAUpekXkowcNoV8hDfquKiqmBOygDXKqr7HBv2aXGetdX8oCCJWN0qeH9lP8UQcglMMkxHg3lADdLP1v65WmXZau4H5MWvxHzQpS1iDGdlTGkc7Bc7VwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPkuHtMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F0B1C433F1;
	Tue, 30 Jan 2024 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706587824;
	bh=ob1IYsuCU1fK8G9UTpGNv7xEjQtbA1pTIU/kjsxuEYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XPkuHtMGvWQBPjFqHmd3lTxSGF45u9pTgkKOy37rV3EfpNYRbMalGxIDkaBX2desx
	 7qFJDfoxEFBMsmWY7f+yWukUH5OLGrTs4a9LSibG69mxy/mG8wDFuJk0ydBabWZT2h
	 F0yPiXOunFKdb6eNgBmYFQ3OQqsiGxB08V4yBzk3JM1LFuhqD2ZIvoF39MqNYvKy13
	 Hjq/baViDlcocu9VN45ggz13RwaymIAYvS/wZTVUhF/KPvZ74h7BanG3UrvTp9hXkX
	 22Gv9iI1Z8CVMaRFwDezRnKGA0aIoLhw4WyQi3HFfBIWs+oMqZnMESrRaxth/g0TDh
	 5XsoWk8PmqlgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01300C395FE;
	Tue, 30 Jan 2024 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf,token: use BIT_ULL() to convert the bit mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170658782399.9776.5352803489783069210.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 04:10:23 +0000
References: <20240127134901.3698613-1-haiyue.wang@intel.com>
In-Reply-To: <20240127134901.3698613-1-haiyue.wang@intel.com>
To: Haiyue Wang <haiyue.wang@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 27 Jan 2024 21:48:56 +0800 you wrote:
> Replace the '(1ULL << *)' with the macro BIT_ULL(nr).
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  kernel/bpf/token.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [bpf-next,v1] bpf,token: use BIT_ULL() to convert the bit mask
    https://git.kernel.org/bpf/bpf-next/c/6668e818f960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



