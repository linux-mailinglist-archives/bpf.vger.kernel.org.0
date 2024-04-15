Return-Path: <bpf+bounces-26835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4A8A56A6
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230AB28377E
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAC7A724;
	Mon, 15 Apr 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JZlTZZdt"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C0757FD
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195645; cv=none; b=Z37L5pWT/OcmEt2BQv9nlqPxKQPRRckBQeUYbqwav2TPPw21QJRxU/EJ31OvXHdsy1r6I1VUaLBu5F+MuKN+Bw8mUkZa0xttjvp/AcHE/zwcx74kRkRiPqJHKy9Q19/7J9JYSfpL51GmiK8ZKWN8U7KSDTAEx9COThsnh7riQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195645; c=relaxed/simple;
	bh=lfZ6ImByiKwmzsWO7quCdEHzgX/s71Ok2fPLvtsr8uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUQRPDYELbIPgoUFWeQu8/xxCEpwovE1MkwvJGK3DRogz7hWpZXg8+KqhwxYNYMWe5OsGRGC9IG1RRvapmm/ixYjHl9M/Tl9B495WpBCLtL6gdUkAPhijkpPw80aCvrZ3F6x3Nd9Dn1jRBWhW8UWPDmgme+QHxTN5kej58kB/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JZlTZZdt; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98230531-5b9b-4181-b862-21be6eb0ffbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713195640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfZ6ImByiKwmzsWO7quCdEHzgX/s71Ok2fPLvtsr8uU=;
	b=JZlTZZdtbDMTFmEYwvXjI5Tey5bLpYunVqy8R3i2XOlfiyJbY9xl9Epta2ayfmYcjTs7zy
	ZDLkHG/JGvif463nv+dulrifPEleJmklInsYlM3RNFNJV7mdO8DSRDAqGUjXa81AGLCMwA
	5Z7VafK5fniuiSrBEemfuLXzlCSMUt8=
Date: Mon, 15 Apr 2024 08:40:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf/tests: Fix typos in comments
Content-Language: en-GB
To: cp0613@linux.alibaba.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415081928.17440-1-cp0613@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240415081928.17440-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/15/24 1:19 AM, cp0613@linux.alibaba.com wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> Currently, there are two comments with same name
> "64-bit ATOMIC magnitudes", the second one should
> be "32-bit ATOMIC magnitudes" based on the context.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


