Return-Path: <bpf+bounces-31501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5578FE84B
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09913286A84
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E08196C63;
	Thu,  6 Jun 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0jgy9/L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE9195B08
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682430; cv=none; b=RHPSgx9F1C9an4xNKZsifbgeFlTynH+6PYK/f1ZIvbKcNDjJg8ql5+THdZU7v6bWVvUJJojBxovQkchsYBNhVCm2TnL8S+zNLTTEm2xDY+ta4bwG4r5+gSFpYwb5LgvQ2kZLs8mCVcIB+p36c98evlz/moNPs0Pwr5Tdy2qOePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682430; c=relaxed/simple;
	bh=NxGzmCUKbZ+Gs95wP4OT+w/088PuLSE59R1IU5CKcy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNQi0RbgqCbYyyQrhzkQe8hInXw5OfOdGp2Gcv42il83VIS4Cb6uqebYocRDZxm40DAsTwLA7tVdx+MQGucnTbzOqwgIpBVCxYIZ7PgVypqspF2fp3/ODvhpkW8e1krzgaeQv0QX2b7upxgg26SSMJGswpMEIMEOx9ugTmDfvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0jgy9/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0290C32786;
	Thu,  6 Jun 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717682429;
	bh=NxGzmCUKbZ+Gs95wP4OT+w/088PuLSE59R1IU5CKcy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D0jgy9/LGLI7vtZ2aP625BF0UZ2AXaHCOrhMlFt0+in9EtmUhxEJIJUk1mzOhlTN+
	 HX4VrQaVDUZdnOvrwvdspCnjgsiyma6YoaKPq3vnBWlD3YTZ+jPUqArdFFIG8MG68R
	 M06jS54GMMRwMF7deMB8HWjSn+VwwXf/MO/27qQ3mH0iVPF+X4Os7P03WRcM06+ej2
	 TZXwXAhm4KooqhtpmXTiQWXIB6699M2op6h2kvkOi2yzzFdO2S12qnE0msYmuz900s
	 IG1fHvsiCT5h98/0UcA4pcJl51y4lIxdHQmWMWFQYERsmTp2V912ftkkLzKiyvKc1T
	 rcMGe2yxv1shw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CF05D2039C;
	Thu,  6 Jun 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf_field_iter selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171768242963.31397.867119466865847480.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 14:00:29 +0000
References: <20240605153314.3727466-1-alan.maguire@oracle.com>
In-Reply-To: <20240605153314.3727466-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  5 Jun 2024 16:33:14 +0100 you wrote:
> Selftests verify that for every BTF kind we iterate correctly
> over consituent strings and ids.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/prog_tests/btf_field_iter.c | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_field_iter.c

Here is the summary with links:
  - [bpf-next] selftests/bpf: add btf_field_iter selftests
    https://git.kernel.org/bpf/bpf-next/c/b24862bac7b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



