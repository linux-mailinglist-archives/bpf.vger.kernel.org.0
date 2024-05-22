Return-Path: <bpf+bounces-30309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7128CC4E8
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3308B2129C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB321824BF;
	Wed, 22 May 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="njkpv+mU"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E46AD7
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395707; cv=none; b=OyaA4IYnQrTJ6lkcEyNrlenJFMF9amdaj/0B+Phen0Onhc04ksDJfHjDVC1cB5bH6zrW8wSnKLCo7iLxZTPQG/MrWjZvWlHquVrt6yRxSiFdIzArd+O43WU9fmMcLnZ+3qw09b5QYg64FHbiLC+0xr+qZNMalI+/O+3pZHwasxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395707; c=relaxed/simple;
	bh=oU0BB9g8bIVIXXjLHXITuySQHBbOjsp4ChyKahHxbHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gUQdGPIhy8OmNnfEDRwwGu0dwGzl3SG9+njggDH/p4VuhmD8D2MBcf1Wi95aazgenRAN9i+pVjXAVvt1dj/Y0p5QrsHoqlCs7BByAweRry8hx+sQTh00PrCt+TOpGcu/AhA/+D42vC4XG/AGdad8/3Z7ozbhz8lX1rNZS6S64h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=njkpv+mU; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716395702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxEbekp/q9D8LpJlilROj+MvrDm2qM+L5TSI2BeVAQc=;
	b=njkpv+mUWWPVtHcTgqCidwqCdE9P6lPbLZYvcU18lsDnvcWHLojpcSYaegFtOfbAGjIo0O
	Tui7RhRjnudOpt3oBMr0YQ//3yXGY8cPgFyPPi+Hm2Uhzl7c58FUAvMmiY26MvpfovofZf
	sYJfhPnIyranhyrK3xyWX67OhDV3KXw=
X-Envelope-To: kuba@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: andrii@kernel.org
X-Envelope-To: bpf@vger.kernel.org
Message-ID: <20db6269-80cb-47f9-8d36-5a3443680450@linux.dev>
Date: Wed, 22 May 2024 17:34:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/4] bpf: make trusted args nullable
To: Eduard Zingerman <eddyz87@gmail.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
 <4c8a90dbdc4677b57b19bc0d8b4109e3b6537aec.camel@gmail.com>
 <912ac775-1505-468b-9030-88cbbf8e30f2@linux.dev>
 <836e4a4ca07872fed42c0b2327dddecf47c572c0.camel@gmail.com>
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <836e4a4ca07872fed42c0b2327dddecf47c572c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/05/2024 16:23, Eduard Zingerman wrote:
> On Wed, 2024-05-22 at 13:35 +0100, Vadim Fedorenko wrote:
> 
> [...]
> 
>> I'm not really sure how I can test it without fully replicating crypto
>> tests. We don't have any other kfuncs with nullable dynptrs yet to test,
>> maybe we should revisit this part once we have more functions with
>> nullable parameters.
> 
> kfuncs for testing could be defined in
> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:bpf_testmod.c,
> e.g. see bpf_testmod_test_mod_kfunc().

alright, thanks for the pointer, I'll add some tests with kfuncs.


