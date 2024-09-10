Return-Path: <bpf+bounces-39521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43679742A9
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9901F27F29
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0B1A7076;
	Tue, 10 Sep 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg57PXZi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF81A4B73
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994231; cv=none; b=SnONlkuvUsxMeuIFkt3OdB4jAp3iA4L3i0yAJahB6E3j7JMmYpgqXW3Qxncc+bB2RF4pRMPc/7xNMwV5YBJGh8Uljego7I5as/51U+GzVVkYC51qiks7ikdWtqO+NNYjVdvZ8OLKuC31E3T8XtjVrmRC/y2N2GsVPgOBSo/K50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994231; c=relaxed/simple;
	bh=Ha9LqAF7676xgj1qx7SlilOIdZIBJ7gUkHtiJCCpNCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VBU+LbEj6WzL8S5B0OP8P8J78zkuDmpYnZB6CbMlCtuFCqyXdsDtGWpd0ukMbA5MflUEXEOMFl13Vxzoxfr2Ex0uEtAutMkX6xf6VLH8FhK/m1xokJ2lunut+hn3Ytr8NT2HV5wJmeRnXKG42lp/0Rfyw1P4jMQQVtrH1HAmyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg57PXZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3882EC4CEC4;
	Tue, 10 Sep 2024 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725994230;
	bh=Ha9LqAF7676xgj1qx7SlilOIdZIBJ7gUkHtiJCCpNCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lg57PXZi6gl0ef4yW0bXW9twhNScZpm+x0Rd5Kwq9bbLzkTx8yR6BbqfAFrxvbQr6
	 39SLU+YRtJmpBnjtCdgkc40+lM6AVU/Z/NN5PkYSuAyHJABP/f2iFSKoI0nS7oTNf6
	 Elxz9qkwzPdtT5GDxsDlGNU6vcs1igJmEcQo7yuZqgLm5+7xdknmIlgtz54zh22mgo
	 0/6PHIKfI2loDwDJ5WgOXnx5WMXaZDqpacg9kVDGaHd48E3U5v3ydn9ziWtizhSwVV
	 9jROBFwg/TJUc7HwY8u4cpfkvoknzjKldYJXFm03J8YFA5kod7nvrvXS5xw887PsRJ
	 ra29Sps8+sYkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB93804CAB;
	Tue, 10 Sep 2024 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix uretprobe.multi.s programs auto
 attachment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172599423127.358597.16441184702970777843.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 18:50:31 +0000
References: <20240910125336.3056271-1-jolsa@kernel.org>
In-Reply-To: <20240910125336.3056271-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@fomichev.me,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 Sep 2024 14:53:36 +0200 you wrote:
> As reported by Andrii we don't currently recognize uretprobe.multi.s
> programs as return probes due to using (wrong) strcmp function.
> 
> Using strncmp instead to match uretprobe.multi as prefix.
> 
> Tests are passing, because the return program was executed
> as entry program and all counts were incremented properly.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix uretprobe.multi.s programs auto attachment
    https://git.kernel.org/bpf/bpf-next/c/8c8b47597403

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



