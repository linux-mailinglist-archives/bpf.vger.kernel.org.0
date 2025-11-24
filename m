Return-Path: <bpf+bounces-75379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCEEC81FAA
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC8EA3493F9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562D2C178E;
	Mon, 24 Nov 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fuk9Dceb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD72BD5BB
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006644; cv=none; b=Cnmj2Rk/BzHnsoyS1+Jp2qd2aIMvH/Nq9I4HbRfSwtEBmLVHWtPZTITCoL3rNyDh8Kkn9PxzMQC/HLSn2giA5KyY0YSjItS6iHPKfllWiKdOc9I1dO5cWmsbAXsJuzNQ4REb1Aqnt4KnMtjLOx8W028xx5F48rrPT/pIVz6wlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006644; c=relaxed/simple;
	bh=C9dUBGcTzVoyNJ9W4+0NKmfOL7S3Jteh3A2y9ZFyL5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=imBM8KTm5r6S51jBBKGsQhhUnvbi7c6SFWoRi3cL6BisFmJi2rD5XWP5U+TRSI/hwE47xW9WfV03HynL8od6HxRV05aZlfk98R+L93mzhQXOV35xfe0DT8uN9EwoFu+26Br+ftRQq8mb/YNWJyVTAovHWfYJQZQUntq9fsOavb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fuk9Dceb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D27DC4CEF1;
	Mon, 24 Nov 2025 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764006643;
	bh=C9dUBGcTzVoyNJ9W4+0NKmfOL7S3Jteh3A2y9ZFyL5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fuk9DcebvaDDMwZirMwJUEP0XsfHI63e805hFI3hcZ+dEm2hJOXqMwIuF2hVqmXut
	 ixtJrMdlTOnfAWq+LnifUzKWXE9IhIoU0hO8ia9lot3Vq7kxhWttfJpl87uL26ldyK
	 GWsHHFKCcrRjWzusrwb9yen/o72cKUlOI21R4MTuxal3ARm6+CLnJoTIX6vLTD2bc6
	 fPkpVw8Zw4aNIbH+yCbw8tub+548hHFPMUgl3sYfmRDKN3qyW5gGKven5k9jC/OIBw
	 dYeZM3oOwN/U1HPday+WzaanHUKjJ746dDhQJmeEJ4aZF2PfEqisSQ5Js8/587enxZ
	 8uudwnV+jN7Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9B83A86295;
	Mon, 24 Nov 2025 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: cleanup aux->used_maps after jit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176400660652.23470.12746953403702208767.git-patchwork-notify@kernel.org>
Date: Mon, 24 Nov 2025 17:50:06 +0000
References: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
In-Reply-To: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Nov 2025 15:15:15 +0000 you wrote:
> In commit b4ce5923e780 ("bpf, x86: add new map type: instructions array")
> env->used_map was copied to func[i]->aux->used_maps before jitting.
> Clear these fields out after jitting such that pointer to freed memory
> (env->used_maps is freed later) are not kept in a live data structure.
> 
> The reason why the copies were initially added is explained in
> https://lore.kernel.org/bpf/20251105090410.1250500-1-a.s.protopopov@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: cleanup aux->used_maps after jit
    https://git.kernel.org/bpf/bpf-next/c/fad804002ef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



