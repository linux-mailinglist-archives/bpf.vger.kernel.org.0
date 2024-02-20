Return-Path: <bpf+bounces-22274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39085B008
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A99428324A
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100923D2;
	Tue, 20 Feb 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RL+8rAYO"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03117E1
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389048; cv=none; b=d40AnHrkd3Jgsb0bRqjXm6EmmqfWKUMmrH4X2FBAP7gU4DQ0/o1eKDgzDsIo6SIn+CfuWGRfKqW26YhQH8jyNxKXj+6NdjqtuPQtbPq3HUfuQZx+yHOiPeCjYkhDJJV4q7Skk5qpPPp/BLFXohTFDsqYhpq+c2ORFdZcKtJ7KGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389048; c=relaxed/simple;
	bh=l4Zs0YBXH9UNLo8mktwAw2SvEopgMabjNzSifnBw000=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSkbYiJrBIi/3HXweMTJhD8PHcRjDtaSAke5W/fkdA1ijLyUnCpho2y1Be+LAQgWwd5ZcOlUtyj2g8ajBMaidQgXtpcRDuMg4iw6nT9RgMlH1WVFVC6mG/P9asIx4xp5+/fKNf9pE4KR1p8Q03hPDmUsolwVbtzcXngELQ9/DVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RL+8rAYO; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25cbdfe8-6e95-4f28-afa5-f7f7e427ce9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708389044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xe2SpLtRd5jNOfZna/5q0m+HRtlp24fH4Dvl/nRxiRs=;
	b=RL+8rAYOz1iutjy+6oMx3HqOfZaE9GzCgkrg3VLhoY/OEMwc59RNUB7lZEBLNBl+BT45lc
	nz7Eox4Jr5CvN1GFG70mU3O3WySPeydu+yOVtADplP3d7/wX0XiUcYqDAdwHcyZu1CrpI8
	G/oWDHpYxYtYh/GiYPxt+1CxJddohiM=
Date: Mon, 19 Feb 2024 16:30:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 kuniyu@amazon.com
References: <20240216150334.31937-1-eddyz87@gmail.com>
 <20240216150334.31937-3-eddyz87@gmail.com>
 <CAEf4BzaF8tEt9aTOhKfst9_LoMX5OCV-9iUxHrbk76oet552=A@mail.gmail.com>
 <a5002108e494d8811bf121ae18ed99d3200119a0.camel@gmail.com>
 <57dbae6ab0ce251221aecc03beb7f1fb90a9ab7c.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <57dbae6ab0ce251221aecc03beb7f1fb90a9ab7c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/19/24 4:48 AM, Eduard Zingerman wrote:
> On Sat, 2024-02-17 at 20:19 +0200, Eduard Zingerman wrote:
> [...]
>
>>> Also, shouldn't this go into bpf tree instead of bpf-next?
>> Will re-send v3 with fixes tag to 'bpf'
> Sending via 'bpf' tree would require dropping patch #1.
> The test_tcp_custom_syncookie is not yet in 'bpf'.
> Note that patch #2 breaks syncookie test w/o patch #1.
> Should I split this in two parts?
> - patch #1   - send via bpf-next
> - patch #2,3 - send via bpf

Sounds good to me. Patch 1 will likely to be merged in bpf-next
before patch 2/3 merged in bpf tree and circulared back to bpf-next.
Please add related commit message in Patch 1 to explain actual
fix will go to bpf tree and will be back to bpf-next later.


