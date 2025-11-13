Return-Path: <bpf+bounces-74442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E55C5A473
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562023B2D51
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0A325490;
	Thu, 13 Nov 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eWpBSXqO"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761012AD0D
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763071195; cv=none; b=CQ5g+wzqJcmn51F0G+5VD0XxRMsgzzwAkT82Cds/kNqUcJYUpMK47uGoXt0Z7GPMqDtIEOUMOm2+o0q/HE5r9UXx9+8bWuN1Vm0Ar4B/EvhRCjuEdhsVt5ChW1ADQyeGS1FV6Hx2JlBlsL3d/czBUkHTZwX4CYxI2Mu8cY9dsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763071195; c=relaxed/simple;
	bh=INVahy4ZNgwIWqw3iKJnrj4wdROmsff+SGO+Rd3X1tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfVsmx+pl5aUdm7wzwUzq8u3Ds3XtT8vCGE+AXRFN7VynGq/7OttWfkjXRGModGJ5HvZdezlK+v0esFS7H6uro7aF7Eu8hvBIxvVLy9cjL2qt+XJqtmrCCvloQoTJshcrZsYoBGbjbv5Bn4ifXSmgPVckj3hkBF/8LziaQbnsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eWpBSXqO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a6ab4444-f3b4-49ae-84a8-8f7924267180@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763071191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INVahy4ZNgwIWqw3iKJnrj4wdROmsff+SGO+Rd3X1tY=;
	b=eWpBSXqOYRjlsiUhqAC6OCCrE7GYUwj7AeAmkU5mP5MOKrR5K0GjPHn5vfgdYK5agfawb7
	LpEdMwEUMSbLjSxv2EfhP7o5ADpDcMycFauWENlj8pTwJkFQhla1hZYKm51xnq13Im996D
	6njB5l3pPTXQtHZ5NJPiVm6HGGBwmqg=
Date: Thu, 13 Nov 2025 13:59:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix failure path in send_signal
 test
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
References: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/12/25 11:05 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When test_send_signal_kern__open_and_load() fails parent closes the
> pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
> continues and enters infinite loop, while parent is stuck in wait(NULL).
>
> Fix the issue by killing the child before jumping to skel_open_load_failure.
>
> The bug was discovered while compiling all of selftests with -O1 instead of -O2
> which caused progs/test_send_signal_kern.c to fail to load.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

I can reproduce the hang with -O1 and this patch fixed it. So

Tested-by: Yonghong Song <yonghong.song@linux.dev>


