Return-Path: <bpf+bounces-64157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86394B0EFB0
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD0E16EE20
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC328C5A1;
	Wed, 23 Jul 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma9cBdzH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52D28C033;
	Wed, 23 Jul 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266258; cv=none; b=rqWo6kH3FFc2pqv9llu4RIQCo7Yp/GSBBmnOn2eqKZzzQCDvObSp7oN0dzY/QXhR1aKyXwaAZWKdY1XFRVb/lx1wjhJVSnreixFruQKE95revRt8HlmF3xAruRzm5dkhAUdUAEhbAWQQ+mg3YEwHnLFkUtdBwG9h1yZQrtaxrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266258; c=relaxed/simple;
	bh=VxIrlHY3WeU5nF1uFuE1TzdHdN3R1UoY01Lw2c+e024=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UK6MICG27oBex4BH8cgpMiCp5pCXxC+pEkhUa5KtG0G8wjDHGGg4h0bQpuXdL4Jd0pVp6qQFDMVPmdd+aWHEE9q1IFNRJLKIgVdHes6lE9Yt8zRKWqq8u56sYoF7UnP0rzTGmuFt3EnuUuYYdnxPN7JwMJAJP21VbClMRkQOKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma9cBdzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2723AC4CEE7;
	Wed, 23 Jul 2025 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753266257;
	bh=VxIrlHY3WeU5nF1uFuE1TzdHdN3R1UoY01Lw2c+e024=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ma9cBdzH1LIaPH0x/g3JfxtIpOusBqAn16JMYnvGxtUdE1KZRTp5tsOiJJ4VJEKcr
	 i2Nbjzjpx6xffyRX6dUiBYrnr7G2IAfnPgjnnt3AsmFiDw2vM9fIbMEsDybAbAKhYt
	 28RTJpKzt0dPBG8q4wCQGJPKxwToLUObgS4W67gw24pxhukTL2IClqnzxnVxoM4Eqy
	 1q/tSD4YJsYKQ6uobWMIYvQY3Sd2nFmoa68e2Gtg7YO+EDS4aWCr4cQ6qfn6frTFYD
	 k5/UvugDfFgLlrDyO+As2uS9pTjHvf8bg/3U+A4sbhmUtMNKel0Qp6JzNCFlumuiUE
	 FQJsPfx66dTHg==
Message-ID: <a55fde07-9320-46b0-bf7c-a2fdfb7c79b2@kernel.org>
Date: Wed, 23 Jul 2025 11:24:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] bpftool: Add CET-aware symbol matching for x86_64
 architectures
To: chenyuan <chenyuan_fl@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <20250723022043.20503-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250723022043.20503-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Your message had a
"Reply-To: <aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org>" header, I
ignored it. I believe you meant to have In-Reply-To: instead.


2025-07-23 10:20 UTC+0800 ~ chenyuan_fl@163.com
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
> 
> Changed in PATCH v4:
> * Refactor repeated code into a function.
> * Add detection for the x86 architecture.
> 
> Changed int PATH v5:
> * Remove detection for the x86 architecture.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---


Looks good from my side, thank you!

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Probably worth waiting for Yonghong's ack as well before merging this patch.

