Return-Path: <bpf+bounces-21363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E873B84BC80
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8939FB22E26
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58FD53B;
	Tue,  6 Feb 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDA4mAMt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BBD51A
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241828; cv=none; b=QkDdjBkLo3L/Ra1b8iIhDjsKhEEfGvYv+DQg9u8pMcbIz4ToyaLaSOnUGixhvMkNS82A5Qdc7PFIh5rnT6/rQvK0+TAhH4fAnIjLNRIlX16QtKH3m0vxaSLcp5GFyzEPe8xZWn65CZmJGSnp9aIuyEcRTlJ24CHkKNDvmfNcyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241828; c=relaxed/simple;
	bh=V4Wrsw6XLx/7P+aEwygB1JKtp1emUwZDskdXRmdGG7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iC7aIe+tdjULMD0SdI+Fw3g6Safn8wMhcEYGPoy6Q6qJMoE2CpjEJeXt7ACguzOeymsyyuEkPS1SlNwpAamqDWUIjFMSXfcdx05ToaThYnd0KqEeyt279fo00AP2hb2/XVAqYuNOf986zg9xj/AgxSlVlEAvvbmHRByIwjIQNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDA4mAMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5296C43390;
	Tue,  6 Feb 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707241827;
	bh=V4Wrsw6XLx/7P+aEwygB1JKtp1emUwZDskdXRmdGG7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GDA4mAMtkDbAqIjfM1HaubQyxmq5OggqZtI+frks4vyV8tK9FneV/asXyAasHKIvK
	 4Sj8A97hZYdfjO0ZrCw2MFwGUh8+/ArzQhXKFFlQptIikLEt+aAYrrM0oanJC4YS4W
	 qT7gj1rqVG+lT0t3VH5Ale57JI+CfrmU5fX+5GKVCKQjpxE2VVB3Og1MwKt4LMC/I9
	 G42ziFjX34hOIw8/iOjqjisPSN4vZwmD7+wGEN+xktS7rg3Ks35pNqgffoQlu1165f
	 TpS5C5yMi+wvn0KT54g21RRPNwV2ebDy7DwQ5LCZ6Ys9I2sxepyQwXzQCk6w+dwNNL
	 pfijk77CwucbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AD7DD8C97E;
	Tue,  6 Feb 2024 17:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V3] bpf: use -Wno-address-of-packed-member in some
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170724182763.15500.1358869712660328492.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 17:50:27 +0000
References: <20240206102330.7113-1-jose.marchesi@oracle.com>
In-Reply-To: <20240206102330.7113-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, yhs@meta.com,
 eddyz87@gmail.com, david.faust@oracle.com, cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 Feb 2024 11:23:30 +0100 you wrote:
> [Differences from V2:
> - Remove conditionals in the source files pragmas, as the
>   pragma is supported by both GCC and clang.]
> 
> Both GCC and clang implement the -Wno-address-of-packed-member
> warning, which is enabled by -Wall, that warns about taking the
> address of a packed struct field when it can lead to an "unaligned"
> address.
> 
> [...]

Here is the summary with links:
  - [bpf-next,V3] bpf: use -Wno-address-of-packed-member in some selftests
    https://git.kernel.org/bpf/bpf-next/c/c27aa462aa78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



