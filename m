Return-Path: <bpf+bounces-68532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3DB59D44
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563DE1883607
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4F2727F9;
	Tue, 16 Sep 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gbYB4VyO"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7301F7575
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039466; cv=none; b=fHrHD1SshNLm+wMW0O84KacSLO87DlCn5Kmihc058pZOGC4Dy7ZKtkFYpFAGV3HI1/Qyf2T27ksXFPPe9snvEd102MXTcFSgWXnqdXefoouWayUFzjfRKlpEct5DZ+uxJVeTQFFUWlIhKBl3Iaw6nmuk1iYsF/JYcQC55fCNqYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039466; c=relaxed/simple;
	bh=0DxJEA29dmMDhKonc2a4f7p3uPS/FJjiZ0D9g8K6Euw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eitL3QqcoADScSql4oZ8vx10IlgzrDMjK7IvsqGRT04qt2zQARR/3Xv9M97sd9ixXS8RgtdHE6lPHTSOnaIKycUaTzV0eAE+OIKDDV4e3LljaqIRSem1MHqp/uCqQMlVvh8gfouqN9rRn24HoRllKaEswG6I0nel4NYekJQnRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gbYB4VyO; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f2353b9-055d-4332-8abe-5af20e9d55fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758039462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aGZ8T0bn9r0A0nxu3vBT+Iax9p/uZ4GI8WibZwwYV0=;
	b=gbYB4VyOwoOnh+HIukeYd3co1fXJ/k97SpoP9SgUXDQj+D1fs7HuMrV7D83HME4M6lvYdM
	7+rxq6iI+zX3GJEgk5g+ndRoG4WbMvWN6DsMe2GoFoLdoE7r/PJj6n0YAHscnxINhAbOeT
	B6+OmpVZ7uDjfrsSpd2OH1xq1tgBrek=
Date: Tue, 16 Sep 2025 09:17:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Add back removed kfuncs declarations
To: Xing Guo <higuoxing@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ameryhung@gmail.com
References: <20250916155649.54991-1-higuoxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250916155649.54991-1-higuoxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/16/25 8:56 AM, Xing Guo wrote:
> These kfuncs are removed in commit 2f9838e25790
> ("selftests/bpf: Cleanup bpf qdisc selftests"), but they are still
> referenced by multiple tests.  Otherwise, we will get the following errors.

They are declared in vmlinux.h which depends on a ~1 year old pahole. There are 
other selftests also depends on the kfunc declared in vmlinux.h alone. Update 
your pahole. There is nothing to fix.

pw-bot: cr


