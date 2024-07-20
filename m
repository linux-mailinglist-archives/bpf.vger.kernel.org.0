Return-Path: <bpf+bounces-35132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A0937E70
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 02:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B152826E3
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044D7F9;
	Sat, 20 Jul 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dej/hlT2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0636C
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434468; cv=none; b=k2jeBTGmaEkqenV8CW3u/QVImI+GJEdbVKBArl3zgYUk05x7BA7R/mxEPsiQoMiLVTU80eIod2xlj6QavawGAojeAsT+c+p7WDW2RT22liSDA5TyK9Dh4diEmanqHRHrlo4V7WwqeTO/nlLhWKY9wsQdZGFZHtDcrMkQ+lMP5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434468; c=relaxed/simple;
	bh=8uAv9tpyPZ4ePG6DCw0J6oVHi081jT+apSuMaGkBG9Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kjrMZXX+IWC4crJaK3sNok8BaBJFLRTEFZLdQ7aZfcjRHFDIeX83nMuzzSZ6FlrR+C24E5wExabKIeu3e2aggtODQQwu9EbmW5oXuKoQEyW13USXt3dKlgCdVvpDUg0livOIX/WSOeF3c/OHKdxIe4Jj19zzQOrNiV/q9AGfUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dej/hlT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10912C32782;
	Sat, 20 Jul 2024 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721434468;
	bh=8uAv9tpyPZ4ePG6DCw0J6oVHi081jT+apSuMaGkBG9Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Dej/hlT2GTUVLN4aBJITH40J7goauWECWWfezdJMpyi5eADxh+M9I7AGhE3p6nL08
	 PRAiJt8L17aYzcFtybHUnBGPgbOdMLWsnlWPKMai0VaLCiqEpIYvPyYQVroSZMv0ua
	 1RHkPJdaqGrCpdZEtRvljpVmAYNpCyi+JNvje0Si2tzuPBARxZrvuXeJrgNCaGiMRu
	 rxLa70rK+oDNfJUsOnOlv0Zd8ako8vv6u7NWI+THSEnCLUt0MLanE6gc5/GaGx4D2W
	 NY58LeRKS4qssALY9XbyNM6KMcdskNGTxM9vFPaprjVZQRWrnEtijGoxlohzkVRV1v
	 al3hkRmTnUP6A==
Content-Type: multipart/mixed; boundary="===============8263467009597796902=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33a5c0bd1cf032335c9ee073edf6ad88cb9b60a5953dd4595b8b1be16e57e0bb@mail.kernel.org>
In-Reply-To: <20240718205203.3652080-1-yonghong.song@linux.dev>
References: <20240718205203.3652080-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark runtime performance with private stack
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sat, 20 Jul 2024 00:14:28 +0000 (UTC)

--===============8263467009597796902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2,2/2,no_merge] selftests/bpf: Benchmark runtime performance with private stack
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872349&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10015580432

Failed jobs:
test_maps-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10015580432/job/27687366542


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============8263467009597796902==--

