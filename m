Return-Path: <bpf+bounces-32753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFF912D07
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373071F25B06
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE317966E;
	Fri, 21 Jun 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtmnPw8d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D671791EF;
	Fri, 21 Jun 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993433; cv=none; b=Sr1luGikhxF6psQRTKQxwpIA1vlxlHljrqB76ZzHDnZ+nRYajlLPkp4e+o7z1TRl1dnK/L0fuyxIFOgXpCRZwGPqwZRPIj5GcXTfci+40acLzchSgumODH7O1+YTIBkvWUTv41wdcIloalgmo5mOLGW+JgCJy6bHtM28TMMMwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993433; c=relaxed/simple;
	bh=5b+UNieFQPKmUWt4+MmvkWhy62llP2muoBoOWy1lCEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YctsmixE6P7czGKd4Zk5gGWBGkppmXaIFW6PnkACKMpVIDqNQSaBA5/5ZgtiSJ6QUuDcMQrTJ2NUGTytmrqWWusdkrLRI9lTwuI7NjmoJb+/fVz/avOBBqJzU8ZPRA4NDq12KFxyuLJL2iADBHdzQAOACF2j6EPziDIvra3RZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtmnPw8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FE2CC2BBFC;
	Fri, 21 Jun 2024 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718993433;
	bh=5b+UNieFQPKmUWt4+MmvkWhy62llP2muoBoOWy1lCEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtmnPw8dIlW0MUBsbPNUr/iJabgfw0AGZqJa/HQ1WMGxvAVELZeWvYEeTL7tNu2V/
	 k7UdsYaUafc8NlqJzs9qXXKkMQw7jdAUR611E7eeZMV9hKUHwO74F5dSQqMmdFxR44
	 pZCzXg0GwBgTYRsWAdmX4XFf9JgiCovoofRV+6V7fW88C4nf0O2dI0j/dEOkx0hwwc
	 4ulyaMf82V+NY9QChBwawikgwS/wry3coQT3hVZM2GVLKDHp96n+peUhscKqs0Ui9r
	 ZgC664L/fOZjXKQIoS4opE/PTwRz7qiz0MVwDhe619go8iCfuwLuS4EXx9tVHg5/dz
	 iOzygpM0gC8UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88588E7C4C5;
	Fri, 21 Jun 2024 18:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: checking the btf_type kind when fixing variable
 offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171899343355.16505.13108622504134914457.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 18:10:33 +0000
References: <20240619122355.426405-1-dolinux.peng@gmail.com>
In-Reply-To: <20240619122355.426405-1-dolinux.peng@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: alan.maguire@oracle.com, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, andrii@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 19 Jun 2024 05:23:55 -0700 you wrote:
> I encountered an issue when building the test_progs from the repository[1]:
> 
> $ pwd
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/
> 
> $ make test_progs V=1
> ...
> ./tools/sbin/bpftool gen object ./ip_check_defrag.bpf.linked2.o ./ip_check_defrag.bpf.linked1.o
> libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in section '.ksyms'
> Error: failed to link './ip_check_defrag.bpf.linked1.o': No such file or directory (2)
> ...
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: checking the btf_type kind when fixing variable offsets
    https://git.kernel.org/bpf/bpf-next/c/cc5083d1f388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



