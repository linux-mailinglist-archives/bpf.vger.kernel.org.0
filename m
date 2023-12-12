Return-Path: <bpf+bounces-17560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106F580F519
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBAB281E3D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486357E76A;
	Tue, 12 Dec 2023 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+gypvxy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C173171
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E32DC433C7;
	Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404024;
	bh=BI88GIs5IDTTAqpxxGCCJc8+blRl6ZsU07VGguptayg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P+gypvxyr4z4SBHDBn1Ojpb7VVwFxzjCuWEHusTikp31xD7Ktr3va30vtqkzIXLgx
	 AcNQaiavAvVGQ8+9dmGk9jn4V2gZVqV2cXRstvvAJ8WCXTRpnZTR1/UD0UfH3APrpX
	 momEfiO/a4J6aj9jEMFakOaHbStuEV6EzOq5jX6CSg0hEQEottTEjxMPSjTvqxeIcU
	 OlopO1ca9NP4RnkU6xDUmJ6xjjATmd0Fy8+TWykso9wmgN1qe44HeVl1Ihhp1DfWm8
	 k6ipWBV0Dizezuc1f6Ok83W0/QiBtBeGi2vGUpOTx0DOqQjYWLBYi9KKY4xcbP1blc
	 fgXh6P44RxFwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05A94C04E32;
	Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next ] selftests/bpf: Fixes tests for filesystem kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170240402401.18804.2512095460646622473.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 18:00:24 +0000
References: <20231211180733.763025-1-chantr4@gmail.com>
In-Reply-To: <20231211180733.763025-1-chantr4@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Dec 2023 10:07:33 -0800 you wrote:
> `fs_kfuncs.c`'s `test_xattr` would fail the test even when the
> filesystem did not support xattr, for instance when /tmp is mounted as
> tmpfs.
> 
> This change checks errno when setxattr fail. If the failure is due to
> the operation being unsupported, we will skip the test (just like we
> would if verity was not enabled on the FS.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fixes tests for filesystem kfuncs
    https://git.kernel.org/bpf/bpf-next/c/f77d795618b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



