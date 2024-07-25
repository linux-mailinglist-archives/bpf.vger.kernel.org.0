Return-Path: <bpf+bounces-35600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497693BA66
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 03:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6390283F91
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D46FC6;
	Thu, 25 Jul 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dqX2B8sM"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B1847A
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871897; cv=none; b=Wn86rDIUBmsKviONyEAgk5ySv7KiK+MkbUsPKaTIvOt+l6UhbwQvLl50NtVm08o1caneX/ED2kB01cCcvP6r+arFnV/ocdpwfgoZYPWAS33TKyX9df/pj+0xGPiy88lT+TN512xReSOOCGzquq0u3ONCmoMudY60UHMSTiol0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871897; c=relaxed/simple;
	bh=7Lb1PtVjDKY24VG6kQhVVO6WNgXlE7FvU4cm6eUzxUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GPrgmhZL6OvrA7Cr9iSa/qcHZZR7Qo47WdUa7a7E+Xpg2nE4d4ROtse/q+GznOZnw5rGpQ7aZwZuJ/lyoU9ByLvpCotCikRaqLDUJJybwGKVSwWXU9frcTCaCcV5f6FL3S92ZIoSGZQH9BP635PyT/ngWGMc/m0xBCMg+S1HS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dqX2B8sM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f053dc10-f356-4134-9843-fc3e820e0ecc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721871893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtP3KRvaEhBgoAI7SBVTMiGcnj6LCb6cXAYLYBikBac=;
	b=dqX2B8sM6BweiKwRDXddvFW7OftDh3ikoVhp1AlqxKLEEFgob4HIIHZNE8RbFsPMg6KDnS
	HDfZ42Yp22r7j7+Q8XK7NxIlH/jRqr0oQfrx0pA8vipIqzJlbmSgNvsHhox5S3oPAuVDZb
	l+WNir4Qfss+euUhDdDccrkFDojeAMQ=
Date: Wed, 24 Jul 2024 18:44:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor
 functions.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 sinquersw@gmail.com, kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-2-thinker.li@gmail.com>
 <51966001-297e-4dae-a7b8-41cdef0fd35c@linux.dev>
Content-Language: en-US
In-Reply-To: <51966001-297e-4dae-a7b8-41cdef0fd35c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/24/24 12:08 PM, Martin KaFai Lau wrote:
> For the tests without having its own netns, they can either move to netns (which 
> I think it is a good thing to do) or use the traffic_monitor_start/stop() 
> manually by changing the testing code,
> or a better way is to ask test_progs do it for the host netns (init_netns) 
> automatically for all tests in the libpcap.list.

After another thought, probably scrape the init_netns auto capturing idea for 
now. I think it could be too noisy for the tests that do use netns.

