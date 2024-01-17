Return-Path: <bpf+bounces-19731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2E830725
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80491F25836
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D41EB51;
	Wed, 17 Jan 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/FnMNq+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25C1EB53;
	Wed, 17 Jan 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498525; cv=none; b=KcZLEzlY+3dyk7GXAgTeZuK3IEJQ/KiXoy9tha1Cff6N+Ubvh4yGmlkcgm3Yv6kIudSEJIBtxOvNfnX/4n6DBjGblWspeiBucYu6HN4Ivj+t1P2Z8ZuoQt+V1dZD04qetd7IWHXtZTwquUKIpGbrtwmv4yJudHK22naa9oprc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498525; c=relaxed/simple;
	bh=nWgw7B6ePvh1dQeMCEJGPfKRMG6+Z/+zQhO5bVw5bTw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=fQHFuqUmzs7P9v1wVCdxgYpR74gPlPAoTMwyet79VWLUeij7fgUUeRhy36M6qdfdnQ69AEqqQcWuKxEWy0yIaCrme3ucwnjn+AwleyP7j8gmLK0t+VjuWXJs2tn/PdHnX9ZCEK4bmL4SiHCDJRK5QH7wpqlhawH8BipjvRdZm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/FnMNq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69A7C433C7;
	Wed, 17 Jan 2024 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498524;
	bh=nWgw7B6ePvh1dQeMCEJGPfKRMG6+Z/+zQhO5bVw5bTw=;
	h=From:To:Cc:Subject:Date:From;
	b=B/FnMNq+H0ujjouVVoSfvSiSuKMU/vRdPAmaD3TRtu529kkPbd9DrPQp5sXOMyzNf
	 SPzHAdZEAh7AXWEsdICSsC+a+j3ffXXxIqOXH+0MLsNNIpwfQ8VMNweLeEvmJp2jc8
	 lsy5nd1CtwnWup7Vyp3Nedq7GmKyCsJc6ngnmMZj7eBQZK+NKbHLFtUAthe5dBzwbY
	 kqEC2Z9Cf8nS3cLox/azH3rSjdUWVVbItS3xuhtx/Sqyiw/OjDyAq4klK6MCtsuhKM
	 P1hPUCqt5T4432shrYA4yQvHc9ZCRfBZsWObcAn2R/nyXwe9uGqsVLvZ7OqlGnb2/M
	 1iIW1NfB7321Q==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv2 stable 6.1 0/2] btf, scripts: Update pahole options
Date: Wed, 17 Jan 2024 14:35:18 +0100
Message-ID: <20240117133520.733288-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we need to be able to use latest pahole options for 6.1 kernels,
updating the scripts/pahole-flags.sh with that (clean backports).

thanks,
jirka

v2 changes:
  - added missing SOB

---
Alan Maguire (1):
      bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25

Martin Rodriguez Reboredo (1):
      btf, scripts: Exclude Rust CUs with pahole

 init/Kconfig            | 2 +-
 lib/Kconfig.debug       | 9 +++++++++
 scripts/pahole-flags.sh | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

