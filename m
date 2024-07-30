Return-Path: <bpf+bounces-36096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99E9421DD
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0461F25396
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C7218E03A;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESIC2VSg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779E187861;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372633; cv=none; b=itRTAxnQcYyKaRjzlTB5WAmLCDztOfnwHTlvXJWlt/LqkijyYhZiaEvOL1yvlFQa2wfBB49XXvcpw6vJZGe5s5kjy/XRddHhrhD/tf+EWVmQ2jjaOUlRmH1Pmy86RPhOYL6QqEi4beGiDR4IKVgReJq1FPfxI0kKAP4nwwswzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372633; c=relaxed/simple;
	bh=MgCVRhA1euoE+9YhaIxZKyIRf/DwiRAkhRG0WzHNhEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0BGsOYdc51FGZxDlTrtbuWg2AkL21ORJBpSSS9gjXm7iAGi4gdwynus2D18HlhLm9W1S1VShCE9Kr9waJY1L5KsGP0uO9WwHTl24oh6DU/llo0iVCCBk5EjpMh0F9UbDk7ArZUUiEc48z58B+OgKlLDCcDiW+yavqZbifcApmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESIC2VSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B88AC4AF11;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722372633;
	bh=MgCVRhA1euoE+9YhaIxZKyIRf/DwiRAkhRG0WzHNhEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESIC2VSg6TVKifsfwvGrLTAsJVYhNgh2de8nxhFueEktUtfCcMvQF1mIgigL7ZJyl
	 tKI3nf27XW0mogHxEULS+aSdCzzeRyxFU2SHdnVl76IPZJgbjPkC1cZU/6gq43sPba
	 9BEgkMzgN83XJ+pvWucCqbCDmuO5j3Vd+oQ498lb21iNUgnHK8oltmHNIaO2P/CF2L
	 yARaCnq1fG768CavgLQGLX4R1p2IsUoU9ENqU1nc6wojBGDko+Ktkw+k1xHChk/dbb
	 Xo7egu6vnxsywT7CTyRpdVYNvnBpQKTlzBod/UBM/dcTE6apvD04d9S4yIxqO0Bz/7
	 1WJsQ/GyrzSiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9297C43619;
	Tue, 30 Jul 2024 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] tools/bpf:Fix the wrong format specifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172237263295.10299.13717406365394258197.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 20:50:32 +0000
References: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 Jul 2024 04:11:20 -0700 you wrote:
> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes:
> v2:
> modify commit info
> v3:
> fix compile warning
> v4:
> Thanks! But unsigned seems relevant here, and it doesn't make much sense
> to change the type of the int just because we don't have the right
> specifier in the printf(), does it? Sorry, I should have been more
> explicit: the warning on v1 and v2 can be addressed by simply removing
> the "space flag" from the format string, in other words:
> 
> [...]

Here is the summary with links:
  - [v4] tools/bpf:Fix the wrong format specifier
    https://git.kernel.org/bpf/bpf-next/c/781f0bbbdade

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



