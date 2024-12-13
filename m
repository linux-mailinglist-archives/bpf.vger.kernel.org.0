Return-Path: <bpf+bounces-46938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640169F19A6
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCFE18871C5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90561AF0B8;
	Fri, 13 Dec 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uibj7KRA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BAC1922E9
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131416; cv=none; b=rh1g/J6KECc0ln3umf28a1Bvy//W9I/DxoHVgV4F87J1uGkNy72V6/2d8DZaEMQIXat8ozgjbHWXuSuHZfYTxVSfa6+t4O/MdxtFLbZ+DUqSe2osoHZiwEqk3cXCsWqKp8T6Je4iA3ekA7a6Na3+B0+3U1NcL0g2WMEStNnl+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131416; c=relaxed/simple;
	bh=cdNWf2GTt/2LkIyoL2YquWQrVRBYsEEN03/NxPdfI0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7yKggrrmn5vh283Pk7AQtplDQ9ncFMqMuC24bFE6xC/wTsRh/7i1sIMdep+FrNGfFS/mEK/CC5Y0uOQmTwfAhW8ZSmlzOIwFOxu2XIHmbbdLuue1dISJcwwxd6IaXCK6Q69A9H9NB4ZmWkle38AFrAUQwKw4rCg/KV+ErYvUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uibj7KRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D5CC4CED0;
	Fri, 13 Dec 2024 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734131416;
	bh=cdNWf2GTt/2LkIyoL2YquWQrVRBYsEEN03/NxPdfI0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uibj7KRAtkpCWTN5YBDrxJ+CQmo9/hwXBHxsBwxrKy29J0bAgds/sdSMOCj92Mfhl
	 bhIc7Z53B/+3NZnK7Ia1mNAQExyn5Ia3u07OvU8LKZu9Vor5EYB+eO+0HcCsJc5PNY
	 1M+q7Vvy7xbnHkBmuJoP5b1A2jnI7GNIWJh+KtS09zvi/nYIxvUYeo77REurAPnIto
	 RvCJ6Hbz3DrHfFRAHdNNV29G+HTIOzyhmwoKezEIJW37L4eo/c2jBHmZJpC57lgl3H
	 Jc+0Dx+NLNYVu3n3web9CwlxB8w8rYUEMTQ2lI5x9lWWO2il7G3+HF4wyWe22J3D7U
	 hnU5tYMe7+66Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE059380A959;
	Fri, 13 Dec 2024 23:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/7] Add fd_array_cnt attribute for BPF_PROG_LOAD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173413143251.3187520.18077942591138065487.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 23:10:32 +0000
References: <20241213130934.1087929-1-aspsk@isovalent.com>
In-Reply-To: <20241213130934.1087929-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Dec 2024 13:09:27 +0000 you wrote:
> Add a new attribute to the bpf(BPF_PROG_LOAD) system call. If this
> new attribute is non-zero, then the fd_array is considered to be a
> continuous array of the fd_array_cnt length and to contain only
> proper map file descriptors or btf file descriptors.
> 
> This change allows maps (and btfs), which aren't referenced directly
> by a BPF program, to be bound to the program _and_ also to be present
> during the program verification (so BPF_PROG_BIND_MAP is not enough
> for this use case).
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/7] bpf: add a __btf_get_by_fd helper
    https://git.kernel.org/bpf/bpf-next/c/4e885fab7164
  - [v5,bpf-next,2/7] bpf: move map/prog compatibility checks
    https://git.kernel.org/bpf/bpf-next/c/928f3221cb14
  - [v5,bpf-next,3/7] bpf: refactor check_pseudo_btf_id
    https://git.kernel.org/bpf/bpf-next/c/76145f725532
  - [v5,bpf-next,4/7] bpf: add fd_array_cnt attribute for prog_load
    https://git.kernel.org/bpf/bpf-next/c/4d3ae294f900
  - [v5,bpf-next,5/7] libbpf: prog load: allow to use fd_array_cnt
    https://git.kernel.org/bpf/bpf-next/c/f9933acda31a
  - [v5,bpf-next,6/7] selftests/bpf: Add tests for fd_array_cnt
    https://git.kernel.org/bpf/bpf-next/c/1c593d7402b1
  - [v5,bpf-next,7/7] selftest/bpf: replace magic constants by macros
    https://git.kernel.org/bpf/bpf-next/c/d677a10f80ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



