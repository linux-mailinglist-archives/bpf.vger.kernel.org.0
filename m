Return-Path: <bpf+bounces-46555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEC99EBA21
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7181887D31
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DD226171;
	Tue, 10 Dec 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neQ7Qy0x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCA8632A
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859015; cv=none; b=j6rpD5AgLfqZxjDoDQ06L4d/Whyns9uE0jnuGUjdlWTjr5RQ17kKQ1OSLnapllAXEG46QC/cFS5cLnP4SehoLCqccjQulcGikFSkzd/S5XHSZlv+lFzBuIbKRjh3fkhG6HsryXrFJlw6JvYl3ahEZwKNfxWdMPguKmT6XFWSQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859015; c=relaxed/simple;
	bh=MEFmlIEWFxmYQhATO9x9yumAuMZ0CFZE/IjS7iYFeLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+MGHzNNkjj7Potslf62rDMiiWHuzdcNcB2RL4X9Fb7h1bXr124sxBP/F3LyGCcjXsaUH6muBhSXmjrK7oaP6X5qrwPds2jaFTHT1M0xK7+TjVASdYEE37cEL++cTke38xw7onR17fQc8EseC4fyATfsNh8axEe6lPL8vJeVqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neQ7Qy0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350A7C4CED6;
	Tue, 10 Dec 2024 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733859015;
	bh=MEFmlIEWFxmYQhATO9x9yumAuMZ0CFZE/IjS7iYFeLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=neQ7Qy0xChwTDUuxvGt3rCgCxjriD+Z8WzswOuJ6RaKHqrBlQEy4DzymVP5doCkhf
	 7gQttF4GqMQczXNwWTt4LcwEK0PUqAstt80eHQ47StgI/mT1TOomZBwLUMR6wjSDiG
	 t4V0wM/dwBFf+DohbyYldDFcVox8k960Ec+NtKMu3O2cwPbjl3GsZ20tdXlWVlN46h
	 h87LkKBwZ8OtIRmKWhR8yY/whb9AaSORnsSa/KeoRC7MVNscsoUPq0aYOCoGq3vXFE
	 U2wNtkV+daL6pyxywDnburEq6Hi9oK6TWx83Uo2aqe1KgW6/CVAHwdKnaLujjEAP8J
	 Fud54vXXZYVbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34ABF380A954;
	Tue, 10 Dec 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix potential error return
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173385903100.953241.11682341931242203136.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 19:30:31 +0000
References: <20241210114245.836164-1-aspsk@isovalent.com>
In-Reply-To: <20241210114245.836164-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, jolsa@kernel.org, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Dec 2024 11:42:45 +0000 you wrote:
> The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> error is a result of bpf_adj_branches(), and thus should be always 0
> However, if for any reason it is not 0, then it will be converted to
> boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> error value. Fix this by returning the original err after the WARN check.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix potential error return
    https://git.kernel.org/bpf/bpf/c/c4441ca86afe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



