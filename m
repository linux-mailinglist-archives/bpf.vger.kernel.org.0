Return-Path: <bpf+bounces-67390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17BDB43198
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 07:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5A65804C6
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 05:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9D213E90;
	Thu,  4 Sep 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVd2RIGB"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5518F40
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963848; cv=none; b=kTfCAvMSoAXvr6ZETMuLVAVwaStnjG5ew5b6Q8i9QoADBT+UDHxxzRSzVOGogCSX+vFdH/luQG4znKsm8m2nERg42gxVYiXEqMelX9lTryIfIjZ1S+2vlx1BwBbVBRb5dTzIno2awXYXTgXK9xM30kwsLV1nE3mYOvpcEfcHpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963848; c=relaxed/simple;
	bh=QbtysNsVS2fD+bIGwCcBf0x7URUoQDF5HoZ72mIJ+r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC5sFpekEl91kcNS2Ld7fGfJPlZpWmSBkWJAhXAk074u/7EA1rpiAgNGlLAk3JkXBlyJ/u76WtZoZ3LUJ8A2IqLWaA2uD1ZOnIqNZf3wH6yMjB79Cfjrc4KkWezv+Th816nOM8jHZVvumLYf2gQIsvMWR30mJ2JkeuoQFu5rMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVd2RIGB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b86ceb7-5dd4-4531-83cb-4b0229caae97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756963843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbtysNsVS2fD+bIGwCcBf0x7URUoQDF5HoZ72mIJ+r8=;
	b=eVd2RIGBDJEqSGK3foxgaEsefELGup0McpeOxqMLEq8zE0kMF8LW1sewIM34PXqFyR2UWZ
	Y8Z0imChzysfJSH3d01WAbvg95txXcCA/P4kYki9h54T6YTdOpUJ9SyiXKsrV5zjTmkdyj
	m4KAJil8Ahm/OUmmTAeEqU+X2/HlRMw=
Date: Wed, 3 Sep 2025 22:30:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] libbpf: remove unused args in parse_usdt_note
Content-Language: en-GB
To: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904030525.1932293-1-phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250904030525.1932293-1-phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/3/25 8:05 PM, Jiawei Zhao wrote:
> Remove unused 'elf' and 'path' parameters from parse_usdt_note function
> signature. These parameters are not referenced within the function body
> and only add unnecessary complexity.
>
> The function only requires the note header, data buffer, offsets, and
> output structure to perform USDT note parsing.
>
> Update function declaration, definition, and the single call site in
> collect_usdt_targets() to match the simplified signature.
>
> This is a safe internal cleanup as parse_usdt_note is a static function.
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


