Return-Path: <bpf+bounces-74638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC57C5FF1C
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 04:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4C4A4E2F70
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA31FFC48;
	Sat, 15 Nov 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHoRpvzB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43768128819
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175638; cv=none; b=oNlRLdwGru2ooTSqCk/i/NoD2EDTmEIWFKvScAw5yRPylLcnIwyrq0S/QeUAYW4pf1ovNPj0aj3VRs6eUDMmEodakXAXe9NOpVrHGYa8XcA6JOQVmXRrTxA0MoS3gyDX1cyokOLJgyS9+kARnSZf7Hb8wDAROnl4d9xn1w/jgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175638; c=relaxed/simple;
	bh=IBoONH27uIRJ7dQpKVRS7fM+oNhXAAdcaNP1PKwA0/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C/9llfk7+S0CRu73VzCSf+r9LwcLVXSqmjc1Oij+sqLjp4uG3LnPH0vJLsMZs/EurGdBQdXzLY7dsK39nyL53fQ+Kk6BgRHP7wm8FYhxjwMnHcXf0Zb3jDUTH6ZVg4m0vtkjOGRkonnEN8MzY4yFRorc/ioHyDEiPgrXbE3+nOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHoRpvzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F35C113D0;
	Sat, 15 Nov 2025 03:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763175637;
	bh=IBoONH27uIRJ7dQpKVRS7fM+oNhXAAdcaNP1PKwA0/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RHoRpvzBNGGAy6q0hE1ZTkVpCIqo0Uuq3pm6qQlSx1WDts5qInx6hlz0z7Oivqe2n
	 I4ENMV1kaao+ztuNLxOvH74yQ6gR58cye7MFpeMWqDqyCe4VIbOjm6a7/S4YsE9d5L
	 1v03+S3J5+lJsn9aX9iIRGnJJBaeNEVimkB3vVc75FSzeqfy+MTqkDuhKDXFcuc9aZ
	 veaSO3miNKjbaYDTl+Q5eQeR7qjim8nwuF/2v6PnyhGJ9HyTyEA9mowUDb/fzXQVjQ
	 bvb7Y9rj8IYeBAlMy/qYC6B3lv3dshv8CCM8BQrxsd7NOLYbAd8JlmGkYx2J6agJcQ
	 uwDk4WIc/uh2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F7D3A78A64;
	Sat, 15 Nov 2025 03:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: don't skip other information if
 xlated_prog_insns is
 skipped
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317560631.1920041.16119261354504141139.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 03:00:06 +0000
References: 
 <efd00fcec5e3e247af551632726e2a90c105fbd8.camel@nextron-systems.com>
In-Reply-To: 
 <efd00fcec5e3e247af551632726e2a90c105fbd8.camel@nextron-systems.com>
To: Altgelt@codeaurora.org,
	Max (Nextron) <max.altgelt@nextron-systems.com>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 4 Nov 2025 14:26:56 +0000 you wrote:
> If xlated_prog_insns should not be exposed, other information
> (such as func_info) still can and should be filled in.
> Therefore, instead of directly terminating in this case,
> continue with the normal flow.
> 
> Signed-off-by: Max Altgelt <max.altgelt@nextron-systems.com>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: don't skip other information if xlated_prog_insns is skipped
    https://git.kernel.org/bpf/bpf-next/c/4722981cca37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



