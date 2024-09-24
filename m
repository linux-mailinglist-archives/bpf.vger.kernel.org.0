Return-Path: <bpf+bounces-40233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92938983D06
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 08:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C54C1F219C2
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54786E614;
	Tue, 24 Sep 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdN+qEPo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45682D66
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158827; cv=none; b=izY9n79lgD0QeL79ltBYIAg995LtT5rs+raqXd7ANubIdYeW7B8W4PIgG3t9M7SBH7TKKQRKnwOalDTAS0oyZYJt3pdlbxGvlDkkArt7gWa4RzaZ1pTe1j81V7RTNr+66cnd35PNqr8NhP1ccNYoX68uz6yBBHRvXkd+PEkySB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158827; c=relaxed/simple;
	bh=dvV7JW4j40YFjn+cskGYuG1xk+7VRmXa4IV5P8C2bgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eVuXB9lV7llb/V7weWaLmzznVcBZrd6Sk4OsrdbA7xSYBzg5eyH0dl9AE5R8KUFbVErH2Pt8hRcpmr48SXCnXhLGrI7jIseM3tt4xCOwRaLPRX/g6Hr2zL+LvxAJXa2RhbXlaJPi33S4YwGZovEcssq8Ejwh3MKTuEXSyKtIXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdN+qEPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D620FC4CEC4;
	Tue, 24 Sep 2024 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727158826;
	bh=dvV7JW4j40YFjn+cskGYuG1xk+7VRmXa4IV5P8C2bgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QdN+qEPo4Mj7tPNNTsZjhwQrODFqEHOO3BkjlrTn7tUAT1dtPd1DFTG/QWPP4Za81
	 wiHb/ngqU96Zl/XekogNCVcGljLzDbSxl2KAIsPUhEM/YyEiBOz1paxqOydVADE4bu
	 DHrNfqw0QSF29fM54mXI+G0/Q5GFxEJpnX/g0xQqsuo4sAWFgwlTxmNF3/3L29vUGW
	 xhRClfVFTQoTG0OijvCGoC5yTNCmfR2R6YYy9WOifgAUsJo2/hxkGpy+DE3RNhlaNS
	 POQT0/M+tu9yNxIXrISEWlpIPwLwAfmnBdNOip//V4W8fpF8+IPotJ/ozv6paZiCPk
	 6wor3opxmF7Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D093809A8F;
	Tue, 24 Sep 2024 06:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: remove test_skb_cgroup_id.sh from
 TEST_PROGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172715882926.3893391.17604218740773697669.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 06:20:29 +0000
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
In-Reply-To: <20240916195919.1872371-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, bjorn@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 16 Sep 2024 19:59:22 +0000 you wrote:
> test_skb_cgroup_id.sh was deleted in
> https://git.kernel.org/bpf/bpf-next/c/f957c230e173
> 
> It has to be removed from TEST_PROGS variable in
> tools/testing/selftests/bpf/Makefile, otherwise install target fails.
> 
> Link:
> https://lore.kernel.org/bpf/Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: remove test_skb_cgroup_id.sh from TEST_PROGS
    https://git.kernel.org/bpf/bpf-next/c/e4c139a63aff
  - [bpf-next,2/2] selftests/bpf: set vpath in Makefile to search for skels
    https://git.kernel.org/bpf/bpf-next/c/494c3a797257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



