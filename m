Return-Path: <bpf+bounces-60736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA78ADB5D8
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45304188DD50
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469C526463A;
	Mon, 16 Jun 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJnEa+Wd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98712BEFFD;
	Mon, 16 Jun 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089003; cv=none; b=NXlUtSXhmHe03ZRhqpW0SOVtBXsJILE33I8irbztYTBa3sIYX604fU9jq1PRvsuQLU3B7yweG3tx3kWXou5cNU77gDoY5PWk6cz7Si+ctWNMJBhuUULJIoHrfuB5m7cR+nAiH2ZMuWGFDpbGsnm+s++IcoVOglpKBWa5iY2ozzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089003; c=relaxed/simple;
	bh=fBlSE0K3LatJ7r9H1p7a9x0l2P3ZmnSjr5hibBlStpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUCqV8LNFV3lKgI+XjWmdDs20TnoNFrGOnpI4hP/L8vaQ4ECLhFz8D0Kpu5AncH+Q5bJ9BUzM2LWl+VAYHQZVeFmykZKI5TWYqYP0VXIaidad9GANVYpgMancokfjWLmf+kFmUcnSHICJZwS82f9M05DXBB9s4vN+XJJ0jFr+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJnEa+Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA3C4CEEA;
	Mon, 16 Jun 2025 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750089003;
	bh=fBlSE0K3LatJ7r9H1p7a9x0l2P3ZmnSjr5hibBlStpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WJnEa+WdE/AqZkMg4CVXNyKRUGY+Hq+wWtC2G/PSYOKo6jYq48Cb9/i9XncPgaWZv
	 IQ2xdFe3/gE62jttBMOCjWvbJcQ2+dnTambL9bHn9hcEvgsngPVkhxoobUC5mVSWtc
	 YOmYNL2I2TXghEIE4a/zWOOBweYoGzuUb/xyfJK3eqjngc9w6TT/l0CrwESVTrFYki
	 Y4oB8iwf3221C0O7O22HFNeMOkjWhtMsBWoNtv4jT1d80yYebnRphm2ALHNpTwa5GH
	 t0pknRnQTvqNg/6Xzr9RT15X1NfBUvRsBuoe/0K7vopxl0IAKKr6icWImG7+nZqMNg
	 u6pCxJ/Tka29Q==
Message-ID: <b7a2fda3-1f98-49b6-ad74-7738db7b3743@kernel.org>
Date: Mon, 16 Jun 2025 16:50:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix JSON writer resource leak in version command
To: Yuan Chen <chenyuan_fl@163.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <20250616152719.28917-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250616152719.28917-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-16 11:27 UTC-0400 ~ Yuan Chen <chenyuan_fl@163.com>
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When using `bpftool --version -j/-p`, the JSON writer object
> created in do_version() was not properly destroyed after use.
> This caused a memory leak each time the version command was
> executed with JSON output.
> 
> Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible commands)
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> Suggested-by: Quentin Monnet <qmo@kernel.org>

Thanks a lot! Please, for future patches, state the version of your
patch (if > 1) in the prefix of your email subject:

	[PATCH bpf-next v2] bpftool: Fix JSON writer...

Reviewed-by: Quentin Monnet <qmo@kernel.org>

