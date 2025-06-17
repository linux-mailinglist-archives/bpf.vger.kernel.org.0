Return-Path: <bpf+bounces-60816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC62ADCF93
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5DE4044A5
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A72EF667;
	Tue, 17 Jun 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkS0b7ZU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1832EF655;
	Tue, 17 Jun 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169350; cv=none; b=n7NUrqnRZutImlqc3gj60J94+k4pgtt8IKlPUcTcKuFed5RfKLpo+f9vnk1noDbhQzB/HONckr9gLWR4Ij8oXblCJzECRRtxVQV7Y+otQH/UsEX8qrNqNDBU3PwHRk77KgE0TZcio9fs02PVaWGhsWyL8boF0CmMx1/1pHU3lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169350; c=relaxed/simple;
	bh=v3nQWV8RXk6jZjaEoMUlg9WeaLdz+4l3z2FIbz3hhZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBFO+dvxyRejxGFVRo7EKS1X/vQwpdxMpUQQHKtDj80yEANG3ehhBacBZF0RgfszHH3+T/LPq2JyCtB7naIJAmzlwLRGCvPrWWotiDy3WLd3vv/cX8btKTwdkZdYL5ChwE6T5DIgJtMZpRIyQgDa4684l9Z98VGrDrJXHJg88Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkS0b7ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE3AC4CEFE;
	Tue, 17 Jun 2025 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750169350;
	bh=v3nQWV8RXk6jZjaEoMUlg9WeaLdz+4l3z2FIbz3hhZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lkS0b7ZU6qLVunu6YrpTd5Cn6yR8fN94N//6CzV6dliR4Oox2C1tbIIX8na+UNWm+
	 Wr71MImBBGCWzPckoE8zGGvWMWl8COWvkrVfSrAPxvMB9M4LGPAceAlOh0AOBOXPh2
	 0agJTC9UKDdy58t4gqwYXKmRxuLtgLMBeQuyDp8ENT3vliinrFxo/D0rDXhbjJ52U0
	 9WkzqdEINfxTnBs3twtHQuV50DTpAuSTEIHrpTA1lk8yR1aVoaxG7kbnOtLPeM+5k7
	 Sowyu7pR9Prc7BqWOX1b6ME2ffRPlw9bZ00G/6i8MLJld93hDe3/JsW6ZvlinoXWhJ
	 j2Dnm9A4lJHbw==
Message-ID: <8ffaaba9-a96e-4097-8e66-994034e7e67d@kernel.org>
Date: Tue, 17 Jun 2025 15:09:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpftool: Fix JSON writer resource leak in version
 command
To: Yuan Chen <chenyuan_fl@163.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrii.nakryiko@gmail.com, Yuan Chen <chenyuan@kylinos.cn>
References: <20250617132442.9998-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250617132442.9998-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-17 09:24 UTC-0400 ~ Yuan Chen <chenyuan_fl@163.com>
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

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

