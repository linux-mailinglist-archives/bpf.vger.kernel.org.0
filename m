Return-Path: <bpf+bounces-40846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F409E98F4E6
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8B42836B0
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4441A76B7;
	Thu,  3 Oct 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZEn0yGc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8D19F46D;
	Thu,  3 Oct 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975505; cv=none; b=McUB8/WL8hhbn1XvQJ5HGbchwiNJ+F4CxryNLNzhQC0To2ba6jCO+4Ozo0xhG/o961S0copAKmIOBxpeO0DL96iD/5T+43tUGe5MGGa3+4gT6uKDTD+ueES/GRM/4KFQaxY+1YSIciXFSAXGCAUDLNoDpXvzHoXmoFPT+nCrpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975505; c=relaxed/simple;
	bh=vFK5H45ABPJADyrRJaINqKoLykSah/FVkTLD+X2PPj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fWs/mzcRi+uKdd8v7/ce91gVGmHOEGvkMduVuYMNNataWMhgnX4PkdSwQWvbCyEqsLS9ZEysBpQe+d3QvahKIRv7qSjXdy9OAOEDyvHgVdNRFtBjLSiqAis+L0btvAvH40hnUW1UYPSQ1J8bgELVlmT6kbJ3TLGga6y7pCGXx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZEn0yGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908EFC4CECC;
	Thu,  3 Oct 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727975504;
	bh=vFK5H45ABPJADyrRJaINqKoLykSah/FVkTLD+X2PPj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pZEn0yGcXdIvtrsYpTqDl6MH6pFMmbvUU+DktsS6pD3hrU+H+bxJufv6aQu1UtzEA
	 nzUmSkrPTLCdlIOYhSIDlOIvNuLl17KRZt3GiGr2isoGm7GS4wvwVm4VyVOoDg3nXB
	 VW9L4K7yiEqJ4PmCYuzEf7xvMapoPzl9kjBtZ+Y/co8dmNcjXikN/wd1AFcJEg9gZl
	 exOIVzfgOb/4FD3VhXx9pJ2T7R9A9YEiobU1MpOuAZGsT9aihnMdrb4QH+R4TPgfK0
	 qFHRcbKk6lEphFi4bZCOaLORMpkOIH2e8XHCq92DuWYC7QTyZyI1CJZBDiSO6gMpCq
	 zpMxfkyN2AYUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA93803263;
	Thu,  3 Oct 2024 17:11:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH HID] HID: bpf: fix cfi stubs for hid_bpf_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172797550801.1927250.1874708957513155198.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 17:11:48 +0000
References: <20240927-fix-hid-bpf-stubs-v1-1-5bbf125f247c@kernel.org>
In-Reply-To: <20240927-fix-hid-bpf-stubs-v1-1-5bbf125f247c@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jiri Kosina <jkosina@suse.com>:

On Fri, 27 Sep 2024 16:17:41 +0200 you wrote:
> With the introduction of commit e42ac1418055 ("bpf: Check unsupported ops
> from the bpf_struct_ops's cfi_stubs"), a HID-BPF struct_ops containing
> a .hid_hw_request() or a .hid_hw_output_report() was failing to load
> as the cfi stubs were not defined.
> 
> Fix that by defining those simple static functions and restore HID-BPF
> functionality.
> 
> [...]

Here is the summary with links:
  - [HID] HID: bpf: fix cfi stubs for hid_bpf_ops
    https://git.kernel.org/netdev/net/c/acd5f76fd529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



