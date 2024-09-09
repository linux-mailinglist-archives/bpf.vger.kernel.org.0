Return-Path: <bpf+bounces-39377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAA3972598
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861421F245CF
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187C18DF73;
	Mon,  9 Sep 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy55y6uZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9A18CBF0
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923429; cv=none; b=YronbwO7S6KXh5xeUrnBDpczIMY+zCC+9pxs8pSqcapfRUet3j77FxW3xSPlSTW/m5v6S+tZwghSXzvQNOFOfJJQzx4Y/VepXiHYGo6uqtDo3u8wCRE5ITn9xVX70aCTnOL7eRVi1VDd1f8SgwAOQkmrMWedP7GoVvOdmm7sZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923429; c=relaxed/simple;
	bh=yTmwkGDBSjNmhNKCbNpOWEm4gM3P8iRRQKz9qPqaIrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CmK5eWEdqHF0GM2Ufx5662ZHDZB77JSXsDzmk1B4IBYWshkXGEn43xUExAsAT7WmmhdCfl8nnIZ2MyyrI5bSj2HteaeLOUjWXZ3l9UFe2dto1xPhIr0erKR5PbPcOuGj+7eaaRxnByo4qrOJ5uhp3A+jQG99aSAn0onfr6/CaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy55y6uZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B64FC4CEC5;
	Mon,  9 Sep 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725923429;
	bh=yTmwkGDBSjNmhNKCbNpOWEm4gM3P8iRRQKz9qPqaIrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dy55y6uZviDn2rSDIoggp6pQkiZeNSb0dEDdStekafhrJ26WFNHsTIR8lU8kBWVEr
	 IjvNxWxQBxzHqwBWr8ie1TTrLyCHycoGzw6bVjhgZWz/P+ESn0Ot6cPhHsrFDtg8vw
	 TRwSEf1Ka83CVQ7+k/dyFVjjNs0ougpLoeDFucXCx/fGlxa8qmkEsQeumH3Qqiz746
	 dcc6pffXjWxkTwUd1oJEMO1Chw7L9xd2KkTT1TJiJRVzzqH3e9+PPzizHpjr6/wOg3
	 l/iuckwkzKcJCsSQl7Jtzq2Yl2zBGDDvDZnTGqIHwK3syAp5Hnxgh4bcZxrjVy7Li7
	 0wn6KeV+2ebNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED33806654;
	Mon,  9 Sep 2024 23:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF ARC JIT: update my e-mail address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592343000.3950880.978532074406224777.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 23:10:30 +0000
References: <20240909184754.27634-1-list+bpf@vahedi.org>
In-Reply-To: <20240909184754.27634-1-list+bpf@vahedi.org>
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: bpf@vger.kernel.org, vgupta@kernel.org, fbedard@synopsys.org,
 linux-snps-arc@lists.infradead.org, ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Sep 2024 20:47:54 +0200 you wrote:
> The previous e-mail address from Synopsys is not available anymore.
> 
> Signed-off-by: Shahab Vahedi <list+bpf@vahedi.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Francois Bedard <fbedard@synopsys.org>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] MAINTAINERS: BPF ARC JIT: update my e-mail address
    https://git.kernel.org/bpf/bpf-next/c/72d8508ecd3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



