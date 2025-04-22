Return-Path: <bpf+bounces-56383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588FDA963B6
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 11:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6261A3A3481
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3958258CC0;
	Tue, 22 Apr 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnlwGH72"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614319D8B7;
	Tue, 22 Apr 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312971; cv=none; b=FmvOs/7Ue4vuVy+q5VnkRK57at6kjOR22BoY6rmrCE21be/n8Y7SJ+sjiHVmznB1J6egs6n+r42h0r0qLQvUQ8azX0xIylEbL8kEkBLSJOMDaq1XvHmQ5HdTFpxAss5eNX1v4917P3tcv1Ov3JFBcXuLrVFVporEuh46kV1mc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312971; c=relaxed/simple;
	bh=vz2jGYSY9oKDBgzu86yZLAUblBgnnaoGNFo9xbS5InE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LdFOdBttfoBDiS1pF/ixe2Yi0647FTztCuaXlMkcxPDLdygdmbYBA1wgs9X/8nl6PySFRJPVto+oUJnFr/rLz6dSYPOWtjXbTNJheBADPtmUtt9xq4HP7ZrbdnFhiste1tJSfq/8VaBzYM77+v1bL8N/ETt6ARBWSvFazJkPipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnlwGH72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF17C4CEE9;
	Tue, 22 Apr 2025 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745312970;
	bh=vz2jGYSY9oKDBgzu86yZLAUblBgnnaoGNFo9xbS5InE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rnlwGH7276RFaEUFuhe+paW6L4DhAzLSYIxKPJAtPO7J6cB3riqGMer25WHWGqL4s
	 a7HL0WdzUr4RM9XZBE4cvS3uClE58mKzn8oRUCYKmdiEwAywN/GvrtZ+D0elGMp4l3
	 hy74hf0NexQ7ev6chMryY0TdNBu78Je2HpqL6dY6gzjKUBIum2Dl7eLICBbJZVBowD
	 DJN+m4hF5lz88/wiwPd9aYZCtUC0cMFZQWlDe9iWojr37qgI5yOALLAmLfsvfXuM08
	 CvqA929Le9muTGTK11sLg47snjAZe9Th1tXiu+KYGwaq2eXCGBu47vUooV/2FJ7oTf
	 yVm7MlTBsGqUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7107A39D6546;
	Tue, 22 Apr 2025 09:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531300924.1477965.13156830298760999777.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:09 +0000
References: <20250417122118.1009824-1-sdl@nppct.ru>
In-Reply-To: <20250417122118.1009824-1-sdl@nppct.ru>
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 12:21:17 +0000 you wrote:
> The function xdp_convert_buff_to_frame() may return NULL if it fails
> to correctly convert the XDP buffer into an XDP frame due to memory
> constraints, internal errors, or invalid data. Failing to check for NULL
> may lead to a NULL pointer dereference if the result is used later in
> processing, potentially causing crashes, data corruption, or undefined
> behavior.
> 
> [...]

Here is the summary with links:
  - [v2] xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()
    https://git.kernel.org/netdev/net/c/cc3628dcd851

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



