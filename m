Return-Path: <bpf+bounces-47070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FCE9F3D0E
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 22:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074007A2206
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FA1D6188;
	Mon, 16 Dec 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLTb/Wgh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E71B87E0;
	Mon, 16 Dec 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385814; cv=none; b=Gi5YAAmPy2+iqCtWq6WrZS6NCCXUxdLDZs8PdNKqKQF/JFkX7zkKagA2hhHOgVNSoyQ0uKqR0dlyD7nqxGiDE9EJvSvRpsQQCm6CX4sU8Y74fwReG2od//JoXN+w3mQCGc0nJsCdPv5VDwQ3BnAgnajlj0CNL2mrYsNmolgA4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385814; c=relaxed/simple;
	bh=BZJFK3QeyYb8JBUBB5s5NB7yEt4OJerhWaTrDQv0mzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pZfpllFyWiUAoWnMb0ChkOyCwJIwQSbTSzp5j1j0+wbt83AG10LqOkA/4fFHYcS5B/zrjJ+Yd7wqIpewd57R8Ew9EMSgx2T6p3QYnAkrNmfZ19SDnDYqHFmkXTj1IqFl5t2Mn/YCvrP3XRa2STkDa6uXmXsp5RQY5jz+uWt1SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLTb/Wgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE67FC4CED0;
	Mon, 16 Dec 2024 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385813;
	bh=BZJFK3QeyYb8JBUBB5s5NB7yEt4OJerhWaTrDQv0mzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lLTb/WghvGnl7+LgXhxmuAKKgGLhcVwCV0Iur6LhyBcq5yEfQZtLHkk9RKhRWVcid
	 oi6FxYwzTBcgPH+lpuG3Agh3uPsvZHY6zz2jYT252RSdCn6sQpgK8TZQEQD5VUTRnc
	 RCMatLe33qTmzd1uCuvOhp/TYtpYRLZnIAdGUZ02gMAyI41gIxtiP+GmmCw0bLRmyP
	 oOCzjdyAmRlTOwOqpHloi9pHOQaxpsjfKgaKVsYruhfxNRpQP3/MyqWBsEGhi1mFcu
	 1HX7cwCNAYAbwpXQdYYeIO/kwkUVordwOvl+RPqAr4LB0snpLEdQZxCN/gO5ymLqax
	 G3X7Re2vHRKLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB53806656;
	Mon, 16 Dec 2024 21:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests: bpf: Migrate test_xdp_meta.sh
 to test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173438583101.361160.455801228839827369.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 21:50:31 +0000
References: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
In-Reply-To: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 13 Dec 2024 16:06:19 +0100 you wrote:
> Hi all,
> 
> This patch series continues the work to migrate the script tests into
> prog_tests.
> 
> test_xdp_meta.sh uses the BPF programs defined in progs/test_xdp_meta.c
> to do a simple XDP/TC functional test that checks the metadata
> allocation performed by the bpf_xdp_adjust_meta() helper.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: test_xdp_meta: Rename BPF sections
    https://git.kernel.org/bpf/bpf-next/c/8dccbecbb969
  - [bpf-next,v2,2/2] selftests/bpf: Migrate test_xdp_meta.sh into xdp_context_test_run.c
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



