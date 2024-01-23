Return-Path: <bpf+bounces-20148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512F839D51
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06FB1F279EC
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F895577F;
	Tue, 23 Jan 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdTHCn4Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CB54669
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053250; cv=none; b=NQP763uIlR0+6EDh+DfC+8bty2P346zYDKuGVZukO5IbquzelX8kwxR6V7HrJIqZq1sydcYmoADE3LlOuqyIRYPkfa5kZprmwQUOdHdSBCet6QZBx3VPQUcNBagGyG27EMw0V1jw6JgVKcQyrtLFmN+CZ3JFLZuyq7yGB1NKZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053250; c=relaxed/simple;
	bh=rdMqa/0yFHxAMs5v0DUfzBc/muh3lU6/I8NwBum3p8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r/TEjBH4Te259A37YPDmxGsXUd2eDr799dyanNv9TRlU1CN6JyvQ2Nee7U9VXxyK6kLuoiHi7wdDyDKcaVAF+9ZdJiVYQLVBvGyLtpPT5SsC4gwnvo9RpDGMzKS4+Lnk1pWUD/yDAE0fOXk6QSzT/Pa/OdtMMTZkjDD8ChtkWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdTHCn4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3985DC433B1;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706053250;
	bh=rdMqa/0yFHxAMs5v0DUfzBc/muh3lU6/I8NwBum3p8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bdTHCn4YDG6jOEhRaQUdJRQn6cTdmVmZ6rZmvXDqZD7ke/0o9s2ahS/so3SgSyq9+
	 U+c0FbnftG79LV881hwnqayfPd5lrVCJKnyYvGBgEYmsm5PKn8MoJApslZEJgTNOOf
	 Tv/yIqyaOFhD9PziqzCy4/S3Ybz434ti/MQEsn7hJcvUlP46inwwMlNCVXS7Vl34vM
	 jfYMeEE7lV+TPGX8sqsTX0C0D+Ydy8HGeQVsNsd4cT1Jk8Sb1Q7QnTd3cGKVE3rGJy
	 9XeioC2+J2tUGdJtv6uIcD8cUXFLvaQxn3fupcyevP/fqJAFqLytoDuGdbv0k+1aCw
	 k0yrQUmJ4IGAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22418DFF76A;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Enable the inline of kptr_xchg for arm64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605325013.25186.512342230131527223.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 23:40:50 +0000
References: <20240119102529.99581-1-houtao@huaweicloud.com>
In-Reply-To: <20240119102529.99581-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 zlim.lnx@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Jan 2024 18:25:27 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set is just a follow-up for "bpf: inline bpf_kptr_xchg()". It
> enables the inline of bpf_kptr_xchg() and kptr_xchg_inline test for
> arm64.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, arm64: Enable the inline of bpf_kptr_xchg()
    https://git.kernel.org/bpf/bpf-next/c/18a45f12d746
  - [bpf-next,2/2] selftests/bpf: Enable kptr_xchg_inline test for arm64
    https://git.kernel.org/bpf/bpf-next/c/29f868887a7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



